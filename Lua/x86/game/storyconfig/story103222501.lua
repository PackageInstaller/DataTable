return {
	Play322251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322251001
		arg_1_1.duration_ = 5.13

		local var_1_0 = {
			zh = 4.2,
			ja = 5.133
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
				arg_1_0:Play322251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.166666666666667

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "H02"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.H02

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_24 = "1020ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1020ui_story"].transform
			local var_4_30 = 1.83333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1020ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -0.85, -6.25)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1020ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1020ui_story"]
			local var_4_39 = 1.83333333333333

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1020ui_story == nil then
				arg_1_1.var_.characterEffect1020ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1020ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1020ui_story then
				arg_1_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_4_42 = 1.83333333333333

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_4_43 = 1.83333333333333

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0
			local var_4_45 = 0.3

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "music"

				arg_1_1:AudioAction(var_4_46, var_4_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_48 = ""
				local var_4_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_49 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_49 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_49

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_49
						arg_1_1.bgmTxt2_.text = var_4_49
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

			local var_4_50 = 0.500666666666667
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_4_5_story_ainsoph_first", "bgm_activity_4_5_story_ainsoph_first")

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

			local var_4_56 = 0.2
			local var_4_57 = 1

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_58 = "play"
				local var_4_59 = "effect"

				arg_1_1:AudioAction(var_4_58, var_4_59, "se_story_133", "se_story_133_sea", "")
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

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[613].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(322251001)
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

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251001", "story_v_out_322251.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_322251", "322251001", "story_v_out_322251.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_322251", "322251001", "story_v_out_322251.awb")

						arg_1_1:RecordAudio("322251001", var_4_70)
						arg_1_1:RecordAudio("322251001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322251", "322251001", "story_v_out_322251.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322251", "322251001", "story_v_out_322251.awb")
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
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322251002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322251003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1020ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1020ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1020ui_story, var_12_4, var_12_3)

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
			local var_12_10 = 0.9

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_11 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_12 = arg_9_1:GetWordFromCfg(322251002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_14 = 36
				local var_12_15 = utf8.len(var_12_13)
				local var_12_16 = var_12_14 <= 0 and var_12_10 or var_12_10 * (var_12_15 / var_12_14)

				if var_12_16 > 0 and var_12_10 < var_12_16 then
					arg_9_1.talkMaxDuration = var_12_16

					if var_12_16 + var_12_9 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_9
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_17 = math.max(var_12_10, arg_9_1.talkMaxDuration)

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_17 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_9) / var_12_17

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_9 + var_12_17 and arg_9_1.time_ < var_12_9 + var_12_17 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play322251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322251003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play322251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.175

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

				local var_16_2 = arg_13_1:GetWordFromCfg(322251003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 47
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
	Play322251004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322251004
		arg_17_1.duration_ = 5.63

		local var_17_0 = {
			zh = 3.9,
			ja = 5.633
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
				arg_17_0:Play322251005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1020ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1020ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -0.85, -6.25)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1020ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1020ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1020ui_story == nil then
				arg_17_1.var_.characterEffect1020ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1020ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1020ui_story then
				arg_17_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			local var_20_14 = 0
			local var_20_15 = 0.475

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_16 = arg_17_1:FormatText(StoryNameCfg[613].name)

				arg_17_1.leftNameTxt_.text = var_20_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_17 = arg_17_1:GetWordFromCfg(322251004)
				local var_20_18 = arg_17_1:FormatText(var_20_17.content)

				arg_17_1.text_.text = var_20_18

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 19
				local var_20_20 = utf8.len(var_20_18)
				local var_20_21 = var_20_19 <= 0 and var_20_15 or var_20_15 * (var_20_20 / var_20_19)

				if var_20_21 > 0 and var_20_15 < var_20_21 then
					arg_17_1.talkMaxDuration = var_20_21

					if var_20_21 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_14
					end
				end

				arg_17_1.text_.text = var_20_18
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251004", "story_v_out_322251.awb") ~= 0 then
					local var_20_22 = manager.audio:GetVoiceLength("story_v_out_322251", "322251004", "story_v_out_322251.awb") / 1000

					if var_20_22 + var_20_14 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_14
					end

					if var_20_17.prefab_name ~= "" and arg_17_1.actors_[var_20_17.prefab_name] ~= nil then
						local var_20_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_17.prefab_name].transform, "story_v_out_322251", "322251004", "story_v_out_322251.awb")

						arg_17_1:RecordAudio("322251004", var_20_23)
						arg_17_1:RecordAudio("322251004", var_20_23)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322251", "322251004", "story_v_out_322251.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322251", "322251004", "story_v_out_322251.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_24 = math.max(var_20_15, arg_17_1.talkMaxDuration)

			if var_20_14 <= arg_17_1.time_ and arg_17_1.time_ < var_20_14 + var_20_24 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_14) / var_20_24

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_14 + var_20_24 and arg_17_1.time_ < var_20_14 + var_20_24 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play322251005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322251005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322251006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1020ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1020ui_story == nil then
				arg_21_1.var_.characterEffect1020ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1020ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1020ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1020ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1020ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.4

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

				local var_24_9 = arg_21_1:GetWordFromCfg(322251005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 16
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
	Play322251006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322251006
		arg_25_1.duration_ = 6.43

		local var_25_0 = {
			zh = 3.666,
			ja = 6.433
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
				arg_25_0:Play322251007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1020ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1020ui_story == nil then
				arg_25_1.var_.characterEffect1020ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1020ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1020ui_story then
				arg_25_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_28_4 = 0
			local var_28_5 = 0.45

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_6 = arg_25_1:FormatText(StoryNameCfg[613].name)

				arg_25_1.leftNameTxt_.text = var_28_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(322251006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 18
				local var_28_10 = utf8.len(var_28_8)
				local var_28_11 = var_28_9 <= 0 and var_28_5 or var_28_5 * (var_28_10 / var_28_9)

				if var_28_11 > 0 and var_28_5 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251006", "story_v_out_322251.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_322251", "322251006", "story_v_out_322251.awb") / 1000

					if var_28_12 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_4
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_322251", "322251006", "story_v_out_322251.awb")

						arg_25_1:RecordAudio("322251006", var_28_13)
						arg_25_1:RecordAudio("322251006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322251", "322251006", "story_v_out_322251.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322251", "322251006", "story_v_out_322251.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_14 and arg_25_1.time_ < var_28_4 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play322251007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322251007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play322251008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1020ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1020ui_story == nil then
				arg_29_1.var_.characterEffect1020ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1020ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1020ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1020ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1020ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.675

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_8

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

				local var_32_9 = arg_29_1:GetWordFromCfg(322251007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 27
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322251008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322251008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322251009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.125

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(322251008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 45
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322251009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322251009
		arg_37_1.duration_ = 2.9

		local var_37_0 = {
			zh = 1.999999999999,
			ja = 2.9
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
				arg_37_0:Play322251010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1020ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1020ui_story == nil then
				arg_37_1.var_.characterEffect1020ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1020ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1020ui_story then
				arg_37_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_40_6 = 0
			local var_40_7 = 0.175

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[613].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:GetWordFromCfg(322251009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 7
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251009", "story_v_out_322251.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_322251", "322251009", "story_v_out_322251.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_out_322251", "322251009", "story_v_out_322251.awb")

						arg_37_1:RecordAudio("322251009", var_40_15)
						arg_37_1:RecordAudio("322251009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322251", "322251009", "story_v_out_322251.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322251", "322251009", "story_v_out_322251.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_16 and arg_37_1.time_ < var_40_6 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play322251010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322251010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play322251011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1020ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1020ui_story == nil then
				arg_41_1.var_.characterEffect1020ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1020ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1020ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1020ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1020ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.725

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_8

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

				local var_44_9 = arg_41_1:GetWordFromCfg(322251010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 29
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322251011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322251011
		arg_45_1.duration_ = 9.23

		local var_45_0 = {
			zh = 5.4,
			ja = 9.233
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
				arg_45_0:Play322251012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1020ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1020ui_story == nil then
				arg_45_1.var_.characterEffect1020ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1020ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1020ui_story then
				arg_45_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_48_6 = 0
			local var_48_7 = 0.65

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[613].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_9 = arg_45_1:GetWordFromCfg(322251011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 26
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251011", "story_v_out_322251.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_322251", "322251011", "story_v_out_322251.awb") / 1000

					if var_48_14 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_6
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_out_322251", "322251011", "story_v_out_322251.awb")

						arg_45_1:RecordAudio("322251011", var_48_15)
						arg_45_1:RecordAudio("322251011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322251", "322251011", "story_v_out_322251.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322251", "322251011", "story_v_out_322251.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_16 and arg_45_1.time_ < var_48_6 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322251012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322251012
		arg_49_1.duration_ = 12.23

		local var_49_0 = {
			zh = 5.1,
			ja = 12.233
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
				arg_49_0:Play322251013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.7

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[613].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(322251012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 28
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251012", "story_v_out_322251.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251012", "story_v_out_322251.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_322251", "322251012", "story_v_out_322251.awb")

						arg_49_1:RecordAudio("322251012", var_52_9)
						arg_49_1:RecordAudio("322251012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322251", "322251012", "story_v_out_322251.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322251", "322251012", "story_v_out_322251.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322251013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322251013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play322251014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1020ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1020ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0, 100, 0)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1020ui_story, var_56_4, var_56_3)

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

			local var_56_9 = 0
			local var_56_10 = 0.825

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_11 = arg_53_1:GetWordFromCfg(322251013)
				local var_56_12 = arg_53_1:FormatText(var_56_11.content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 33
				local var_56_14 = utf8.len(var_56_12)
				local var_56_15 = var_56_13 <= 0 and var_56_10 or var_56_10 * (var_56_14 / var_56_13)

				if var_56_15 > 0 and var_56_10 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_9 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_9
					end
				end

				arg_53_1.text_.text = var_56_12
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_10, arg_53_1.talkMaxDuration)

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_9) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_9 + var_56_16 and arg_53_1.time_ < var_56_9 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play322251014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322251014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play322251015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.45

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(322251014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 18
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play322251015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322251015
		arg_61_1.duration_ = 11.9

		local var_61_0 = {
			zh = 8.333,
			ja = 11.9
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
				arg_61_0:Play322251016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1020ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1020ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, -0.85, -6.25)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1020ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1020ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1020ui_story == nil then
				arg_61_1.var_.characterEffect1020ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1020ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1020ui_story then
				arg_61_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action5_1")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_15 = 0
			local var_64_16 = 0.925

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[613].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(322251015)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 37
				local var_64_21 = utf8.len(var_64_19)
				local var_64_22 = var_64_20 <= 0 and var_64_16 or var_64_16 * (var_64_21 / var_64_20)

				if var_64_22 > 0 and var_64_16 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22

					if var_64_22 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251015", "story_v_out_322251.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_322251", "322251015", "story_v_out_322251.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_322251", "322251015", "story_v_out_322251.awb")

						arg_61_1:RecordAudio("322251015", var_64_24)
						arg_61_1:RecordAudio("322251015", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322251", "322251015", "story_v_out_322251.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322251", "322251015", "story_v_out_322251.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_25 and arg_61_1.time_ < var_64_15 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play322251016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322251016
		arg_65_1.duration_ = 21.33

		local var_65_0 = {
			zh = 11.5,
			ja = 21.333
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
				arg_65_0:Play322251017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 1.325

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[613].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(322251016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251016", "story_v_out_322251.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251016", "story_v_out_322251.awb") / 1000

					if var_68_8 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_0
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_322251", "322251016", "story_v_out_322251.awb")

						arg_65_1:RecordAudio("322251016", var_68_9)
						arg_65_1:RecordAudio("322251016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322251", "322251016", "story_v_out_322251.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322251", "322251016", "story_v_out_322251.awb")
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
	Play322251017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322251017
		arg_69_1.duration_ = 11.3

		local var_69_0 = {
			zh = 5.1,
			ja = 11.3
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
				arg_69_0:Play322251018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action5_2")
			end

			local var_72_1 = 0
			local var_72_2 = 0.6

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_3 = arg_69_1:FormatText(StoryNameCfg[613].name)

				arg_69_1.leftNameTxt_.text = var_72_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(322251017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 24
				local var_72_7 = utf8.len(var_72_5)
				local var_72_8 = var_72_6 <= 0 and var_72_2 or var_72_2 * (var_72_7 / var_72_6)

				if var_72_8 > 0 and var_72_2 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251017", "story_v_out_322251.awb") ~= 0 then
					local var_72_9 = manager.audio:GetVoiceLength("story_v_out_322251", "322251017", "story_v_out_322251.awb") / 1000

					if var_72_9 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_1
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_322251", "322251017", "story_v_out_322251.awb")

						arg_69_1:RecordAudio("322251017", var_72_10)
						arg_69_1:RecordAudio("322251017", var_72_10)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322251", "322251017", "story_v_out_322251.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322251", "322251017", "story_v_out_322251.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_11 and arg_69_1.time_ < var_72_1 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play322251018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322251018
		arg_73_1.duration_ = 9.2

		local var_73_0 = {
			zh = 4.8,
			ja = 9.2
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
				arg_73_0:Play322251019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.6

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[613].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(322251018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 24
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251018", "story_v_out_322251.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251018", "story_v_out_322251.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_322251", "322251018", "story_v_out_322251.awb")

						arg_73_1:RecordAudio("322251018", var_76_9)
						arg_73_1:RecordAudio("322251018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_322251", "322251018", "story_v_out_322251.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_322251", "322251018", "story_v_out_322251.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play322251019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322251019
		arg_77_1.duration_ = 5.3

		local var_77_0 = {
			zh = 3.366,
			ja = 5.3
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
				arg_77_0:Play322251020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_80_2 = 0
			local var_80_3 = 0.45

			if var_80_2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_4 = arg_77_1:FormatText(StoryNameCfg[613].name)

				arg_77_1.leftNameTxt_.text = var_80_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:GetWordFromCfg(322251019)
				local var_80_6 = arg_77_1:FormatText(var_80_5.content)

				arg_77_1.text_.text = var_80_6

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 18
				local var_80_8 = utf8.len(var_80_6)
				local var_80_9 = var_80_7 <= 0 and var_80_3 or var_80_3 * (var_80_8 / var_80_7)

				if var_80_9 > 0 and var_80_3 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_6
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251019", "story_v_out_322251.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_322251", "322251019", "story_v_out_322251.awb") / 1000

					if var_80_10 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_2
					end

					if var_80_5.prefab_name ~= "" and arg_77_1.actors_[var_80_5.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_5.prefab_name].transform, "story_v_out_322251", "322251019", "story_v_out_322251.awb")

						arg_77_1:RecordAudio("322251019", var_80_11)
						arg_77_1:RecordAudio("322251019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322251", "322251019", "story_v_out_322251.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322251", "322251019", "story_v_out_322251.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_12 and arg_77_1.time_ < var_80_2 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play322251020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 322251020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play322251021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1020ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos1020ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, 100, 0)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1020ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(0, 100, 0)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = 0
			local var_84_10 = 1.55

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_11 = arg_81_1:GetWordFromCfg(322251020)
				local var_84_12 = arg_81_1:FormatText(var_84_11.content)

				arg_81_1.text_.text = var_84_12

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 62
				local var_84_14 = utf8.len(var_84_12)
				local var_84_15 = var_84_13 <= 0 and var_84_10 or var_84_10 * (var_84_14 / var_84_13)

				if var_84_15 > 0 and var_84_10 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_9 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_9
					end
				end

				arg_81_1.text_.text = var_84_12
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_10, arg_81_1.talkMaxDuration)

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_9) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_9 + var_84_16 and arg_81_1.time_ < var_84_9 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play322251021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 322251021
		arg_85_1.duration_ = 6.57

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play322251022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.566666666666667
			local var_88_1 = 1

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				local var_88_2 = "play"
				local var_88_3 = "effect"

				arg_85_1:AudioAction(var_88_2, var_88_3, "se_story_145", "se_story_145_gun_air", "")
			end

			local var_88_4 = manager.ui.mainCamera.transform
			local var_88_5 = 0.566666666666667

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.var_.shakeOldPos = var_88_4.localPosition
			end

			local var_88_6 = 0.3

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_6 then
				local var_88_7 = (arg_85_1.time_ - var_88_5) / 0.066
				local var_88_8, var_88_9 = math.modf(var_88_7)

				var_88_4.localPosition = Vector3.New(var_88_9 * 0.13, var_88_9 * 0.13, var_88_9 * 0.13) + arg_85_1.var_.shakeOldPos
			end

			if arg_85_1.time_ >= var_88_5 + var_88_6 and arg_85_1.time_ < var_88_5 + var_88_6 + arg_88_0 then
				var_88_4.localPosition = arg_85_1.var_.shakeOldPos
			end

			local var_88_10 = manager.ui.mainCamera.transform
			local var_88_11 = 0.566666666666667

			if var_88_11 < arg_85_1.time_ and arg_85_1.time_ <= var_88_11 + arg_88_0 then
				local var_88_12 = arg_85_1.var_.effect1021
				local var_88_13
				local var_88_14 = var_88_10

				if not var_88_12 then
					var_88_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_88_14)
					var_88_12.name = "1021"
					arg_85_1.var_.effect1021 = var_88_12
				else
					var_88_12.transform:SetParent(var_88_14)
				end

				var_88_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_88_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_88_15 = manager.ui.mainCamera.transform
			local var_88_16 = 3.56666666666667

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				local var_88_17 = arg_85_1.var_.effect1021

				if var_88_17 then
					Object.Destroy(var_88_17)

					arg_85_1.var_.effect1021 = nil
				end
			end

			local var_88_18 = 0

			if var_88_18 < arg_85_1.time_ and arg_85_1.time_ <= var_88_18 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			local var_88_19 = 1.86666666666667

			if arg_85_1.time_ >= var_88_18 + var_88_19 and arg_85_1.time_ < var_88_18 + var_88_19 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			local var_88_20 = 0
			local var_88_21 = 1.725

			if var_88_20 < arg_85_1.time_ and arg_85_1.time_ <= var_88_20 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_22 = arg_85_1:GetWordFromCfg(322251021)
				local var_88_23 = arg_85_1:FormatText(var_88_22.content)

				arg_85_1.text_.text = var_88_23

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_24 = 69
				local var_88_25 = utf8.len(var_88_23)
				local var_88_26 = var_88_24 <= 0 and var_88_21 or var_88_21 * (var_88_25 / var_88_24)

				if var_88_26 > 0 and var_88_21 < var_88_26 then
					arg_85_1.talkMaxDuration = var_88_26

					if var_88_26 + var_88_20 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_26 + var_88_20
					end
				end

				arg_85_1.text_.text = var_88_23
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_27 = math.max(var_88_21, arg_85_1.talkMaxDuration)

			if var_88_20 <= arg_85_1.time_ and arg_85_1.time_ < var_88_20 + var_88_27 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_20) / var_88_27

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_20 + var_88_27 and arg_85_1.time_ < var_88_20 + var_88_27 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play322251022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 322251022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play322251023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.9

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(322251022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 36
				local var_92_5 = utf8.len(var_92_3)
				local var_92_6 = var_92_4 <= 0 and var_92_1 or var_92_1 * (var_92_5 / var_92_4)

				if var_92_6 > 0 and var_92_1 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_7 and arg_89_1.time_ < var_92_0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play322251023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322251023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play322251024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1.05

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(322251023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 42
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play322251024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322251024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322251025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.075

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(322251024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 3
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play322251025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322251025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play322251026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.5

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(322251025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 20
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_7 and arg_101_1.time_ < var_104_0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play322251026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322251026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322251027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.525

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(322251026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 21
				local var_108_6 = utf8.len(var_108_4)
				local var_108_7 = var_108_5 <= 0 and var_108_1 or var_108_1 * (var_108_6 / var_108_5)

				if var_108_7 > 0 and var_108_1 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_8 and arg_105_1.time_ < var_108_0 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play322251027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322251027
		arg_109_1.duration_ = 2

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play322251028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1020ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1020ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, -0.85, -6.25)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1020ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1020ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1020ui_story == nil then
				arg_109_1.var_.characterEffect1020ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect1020ui_story and not isNil(var_112_9) then
					arg_109_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect1020ui_story then
				arg_109_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_112_14 = 0

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_112_15 = 0
			local var_112_16 = 0.125

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_17 = arg_109_1:FormatText(StoryNameCfg[613].name)

				arg_109_1.leftNameTxt_.text = var_112_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_18 = arg_109_1:GetWordFromCfg(322251027)
				local var_112_19 = arg_109_1:FormatText(var_112_18.content)

				arg_109_1.text_.text = var_112_19

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 5
				local var_112_21 = utf8.len(var_112_19)
				local var_112_22 = var_112_20 <= 0 and var_112_16 or var_112_16 * (var_112_21 / var_112_20)

				if var_112_22 > 0 and var_112_16 < var_112_22 then
					arg_109_1.talkMaxDuration = var_112_22

					if var_112_22 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_22 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_19
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251027", "story_v_out_322251.awb") ~= 0 then
					local var_112_23 = manager.audio:GetVoiceLength("story_v_out_322251", "322251027", "story_v_out_322251.awb") / 1000

					if var_112_23 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_23 + var_112_15
					end

					if var_112_18.prefab_name ~= "" and arg_109_1.actors_[var_112_18.prefab_name] ~= nil then
						local var_112_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_18.prefab_name].transform, "story_v_out_322251", "322251027", "story_v_out_322251.awb")

						arg_109_1:RecordAudio("322251027", var_112_24)
						arg_109_1:RecordAudio("322251027", var_112_24)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322251", "322251027", "story_v_out_322251.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322251", "322251027", "story_v_out_322251.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_25 and arg_109_1.time_ < var_112_15 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play322251028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322251028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322251029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1020ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1020ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1020ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1020ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1020ui_story == nil then
				arg_113_1.var_.characterEffect1020ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1020ui_story and not isNil(var_116_9) then
					local var_116_13 = Mathf.Lerp(0, 0.5, var_116_12)

					arg_113_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1020ui_story.fillRatio = var_116_13
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1020ui_story then
				local var_116_14 = 0.5

				arg_113_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1020ui_story.fillRatio = var_116_14
			end

			local var_116_15 = 0
			local var_116_16 = 0.375

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_17

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

				local var_116_18 = arg_113_1:GetWordFromCfg(322251028)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 15
				local var_116_21 = utf8.len(var_116_19)
				local var_116_22 = var_116_20 <= 0 and var_116_16 or var_116_16 * (var_116_21 / var_116_20)

				if var_116_22 > 0 and var_116_16 < var_116_22 then
					arg_113_1.talkMaxDuration = var_116_22

					if var_116_22 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_15
					end
				end

				arg_113_1.text_.text = var_116_19
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_23 = math.max(var_116_16, arg_113_1.talkMaxDuration)

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_23 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_15) / var_116_23

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_15 + var_116_23 and arg_113_1.time_ < var_116_15 + var_116_23 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play322251029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322251029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play322251030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 1.125

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

				local var_120_2 = arg_117_1:GetWordFromCfg(322251029)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 45
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
	Play322251030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322251030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play322251031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.03333333333333
			local var_124_1 = 1

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				local var_124_2 = "play"
				local var_124_3 = "effect"

				arg_121_1:AudioAction(var_124_2, var_124_3, "se_story_141", "se_story_141_boxing_fall", "")
			end

			local var_124_4 = 0.0333333333333334
			local var_124_5 = 1

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				local var_124_6 = "play"
				local var_124_7 = "effect"

				arg_121_1:AudioAction(var_124_6, var_124_7, "se_story_145", "se_story_145_amb_information1", "")
			end

			local var_124_8 = 0
			local var_124_9 = 1.625

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(322251030)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_12 = 65
				local var_124_13 = utf8.len(var_124_11)
				local var_124_14 = var_124_12 <= 0 and var_124_9 or var_124_9 * (var_124_13 / var_124_12)

				if var_124_14 > 0 and var_124_9 < var_124_14 then
					arg_121_1.talkMaxDuration = var_124_14

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_15 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_15 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_15

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_15 and arg_121_1.time_ < var_124_8 + var_124_15 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play322251031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322251031
		arg_125_1.duration_ = 5.05

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play322251032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			local var_128_1 = 4.1

			if arg_125_1.time_ >= var_128_0 + var_128_1 and arg_125_1.time_ < var_128_0 + var_128_1 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end

			local var_128_2 = "STblack"

			if arg_125_1.bgs_[var_128_2] == nil then
				local var_128_3 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_128_2)
				var_128_3.name = var_128_2
				var_128_3.transform.parent = arg_125_1.stage_.transform
				var_128_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_[var_128_2] = var_128_3
			end

			local var_128_4 = 0.933333333333333

			if var_128_4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				local var_128_5 = manager.ui.mainCamera.transform.localPosition
				local var_128_6 = Vector3.New(0, 0, 10) + Vector3.New(var_128_5.x, var_128_5.y, 0)
				local var_128_7 = arg_125_1.bgs_.STblack

				var_128_7.transform.localPosition = var_128_6
				var_128_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_8 = var_128_7:GetComponent("SpriteRenderer")

				if var_128_8 and var_128_8.sprite then
					local var_128_9 = (var_128_7.transform.localPosition - var_128_5).z
					local var_128_10 = manager.ui.mainCameraCom_
					local var_128_11 = 2 * var_128_9 * Mathf.Tan(var_128_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_128_12 = var_128_11 * var_128_10.aspect
					local var_128_13 = var_128_8.sprite.bounds.size.x
					local var_128_14 = var_128_8.sprite.bounds.size.y
					local var_128_15 = var_128_12 / var_128_13
					local var_128_16 = var_128_11 / var_128_14
					local var_128_17 = var_128_16 < var_128_15 and var_128_15 or var_128_16

					var_128_7.transform.localScale = Vector3.New(var_128_17, var_128_17, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "STblack" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_18 = 0

			if var_128_18 < arg_125_1.time_ and arg_125_1.time_ <= var_128_18 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_19 = 0.933333333333333

			if var_128_18 <= arg_125_1.time_ and arg_125_1.time_ < var_128_18 + var_128_19 then
				local var_128_20 = (arg_125_1.time_ - var_128_18) / var_128_19
				local var_128_21 = Color.New(0, 0, 0)

				var_128_21.a = Mathf.Lerp(0, 1, var_128_20)
				arg_125_1.mask_.color = var_128_21
			end

			if arg_125_1.time_ >= var_128_18 + var_128_19 and arg_125_1.time_ < var_128_18 + var_128_19 + arg_128_0 then
				local var_128_22 = Color.New(0, 0, 0)

				var_128_22.a = 1
				arg_125_1.mask_.color = var_128_22
			end

			local var_128_23 = 0.933333333333333

			if var_128_23 < arg_125_1.time_ and arg_125_1.time_ <= var_128_23 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_24 = 3.16666666666666

			if var_128_23 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_24 then
				local var_128_25 = (arg_125_1.time_ - var_128_23) / var_128_24
				local var_128_26 = Color.New(0, 0, 0)

				var_128_26.a = Mathf.Lerp(1, 0, var_128_25)
				arg_125_1.mask_.color = var_128_26
			end

			if arg_125_1.time_ >= var_128_23 + var_128_24 and arg_125_1.time_ < var_128_23 + var_128_24 + arg_128_0 then
				local var_128_27 = Color.New(0, 0, 0)
				local var_128_28 = 0

				arg_125_1.mask_.enabled = false
				var_128_27.a = var_128_28
				arg_125_1.mask_.color = var_128_27
			end

			local var_128_29 = 0.133333333333333
			local var_128_30 = 0.3

			if var_128_29 < arg_125_1.time_ and arg_125_1.time_ <= var_128_29 + arg_128_0 then
				local var_128_31 = "play"
				local var_128_32 = "music"

				arg_125_1:AudioAction(var_128_31, var_128_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_128_33 = ""
				local var_128_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_128_34 ~= "" then
					if arg_125_1.bgmTxt_.text ~= var_128_34 and arg_125_1.bgmTxt_.text ~= "" then
						if arg_125_1.bgmTxt2_.text ~= "" then
							arg_125_1.bgmTxt_.text = arg_125_1.bgmTxt2_.text
						end

						arg_125_1.bgmTxt2_.text = var_128_34

						arg_125_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_125_1.bgmTxt_.text = var_128_34
						arg_125_1.bgmTxt2_.text = var_128_34
					end

					if arg_125_1.bgmTimer then
						arg_125_1.bgmTimer:Stop()

						arg_125_1.bgmTimer = nil
					end

					if arg_125_1.settingData.show_music_name == 1 then
						arg_125_1.musicController:SetSelectedState("show")
						arg_125_1.musicAnimator_:Play("open", 0, 0)

						if arg_125_1.settingData.music_time ~= 0 then
							arg_125_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_125_1.settingData.music_time), function()
								if arg_125_1 == nil or isNil(arg_125_1.bgmTxt_) then
									return
								end

								arg_125_1.musicController:SetSelectedState("hide")
								arg_125_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_128_35 = 0.233333333333333
			local var_128_36 = 1

			if var_128_35 < arg_125_1.time_ and arg_125_1.time_ <= var_128_35 + arg_128_0 then
				local var_128_37 = "stop"
				local var_128_38 = "effect"

				arg_125_1:AudioAction(var_128_37, var_128_38, "se_story_133", "se_story_133_sea", "")
			end

			local var_128_39 = 1.63333333333333
			local var_128_40 = 1

			if var_128_39 < arg_125_1.time_ and arg_125_1.time_ <= var_128_39 + arg_128_0 then
				local var_128_41 = "play"
				local var_128_42 = "effect"

				arg_125_1:AudioAction(var_128_41, var_128_42, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_128_43 = manager.ui.mainCamera.transform
			local var_128_44 = 0

			if var_128_44 < arg_125_1.time_ and arg_125_1.time_ <= var_128_44 + arg_128_0 then
				local var_128_45 = arg_125_1.var_.effect1030
				local var_128_46
				local var_128_47 = var_128_43

				if not var_128_45 then
					var_128_45 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_datablock_black"), var_128_47)
					var_128_45.name = "1030"
					arg_125_1.var_.effect1030 = var_128_45
				else
					var_128_45.transform:SetParent(var_128_47)
				end

				var_128_45.transform.localPosition = Vector3.New(0, 0, 0)
				var_128_45.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_128_48 = manager.ui.mainCamera.transform
			local var_128_49 = 0.933333333333333

			if var_128_49 < arg_125_1.time_ and arg_125_1.time_ <= var_128_49 + arg_128_0 then
				local var_128_50 = arg_125_1.var_.effect1030

				if var_128_50 then
					Object.Destroy(var_128_50)

					arg_125_1.var_.effect1030 = nil
				end
			end

			local var_128_51 = 0
			local var_128_52 = 1

			if var_128_51 < arg_125_1.time_ and arg_125_1.time_ <= var_128_51 + arg_128_0 then
				local var_128_53 = "play"
				local var_128_54 = "effect"

				arg_125_1:AudioAction(var_128_53, var_128_54, "se_story_120_00", "se_story_120_00_datastream", "")
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 102,
				charCount = 0,
				enableLayoutChange = true,
				duration = 0.7,
				groupID = "10312",
				startTime = 0.233333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322251031,
				charCount = 42,
				enableLayoutChange = true,
				duration = 2.8,
				groupID = "1031",
				startTime = 0.933333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play322251032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 322251032
		arg_130_1.duration_ = 1

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play322251033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			return
		end

		arg_130_1.nodeConfigList_ = {
			{
				groupID = "1031",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322251032,
				charCount = 9,
				enableLayoutChange = true,
				duration = 0.6,
				groupID = "1032",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play322251033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 322251033
		arg_134_1.duration_ = 1.47

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play322251034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 1.466
			local var_137_2 = manager.audio:GetVoiceLength("story_v_out_322251", "322251033", "story_v_out_322251.awb") / 1000

			if var_137_2 > 0 and var_137_1 < var_137_2 and var_137_2 + var_137_0 > arg_134_1.duration_ then
				local var_137_3 = var_137_2

				arg_134_1.duration_ = var_137_2 + var_137_0
			end

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				local var_137_4 = "play"
				local var_137_5 = "voice"

				arg_134_1:AudioAction(var_137_4, var_137_5, "story_v_out_322251", "322251033", "story_v_out_322251.awb")
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				groupID = "1032",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322251033,
				charCount = 5,
				enableLayoutChange = true,
				duration = 0.333333333333333,
				groupID = "1033",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play322251034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 322251034
		arg_138_1.duration_ = 8

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play322251035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 3

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.allBtn_.enabled = false
			end

			local var_141_1 = 0.3

			if arg_138_1.time_ >= var_141_0 + var_141_1 and arg_138_1.time_ < var_141_0 + var_141_1 + arg_141_0 then
				arg_138_1.allBtn_.enabled = true
			end

			local var_141_2 = "ST0512"

			if arg_138_1.bgs_[var_141_2] == nil then
				local var_141_3 = Object.Instantiate(arg_138_1.paintGo_)

				var_141_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_141_2)
				var_141_3.name = var_141_2
				var_141_3.transform.parent = arg_138_1.stage_.transform
				var_141_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.bgs_[var_141_2] = var_141_3
			end

			local var_141_4 = 1

			if var_141_4 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				local var_141_5 = manager.ui.mainCamera.transform.localPosition
				local var_141_6 = Vector3.New(0, 0, 10) + Vector3.New(var_141_5.x, var_141_5.y, 0)
				local var_141_7 = arg_138_1.bgs_.ST0512

				var_141_7.transform.localPosition = var_141_6
				var_141_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_141_8 = var_141_7:GetComponent("SpriteRenderer")

				if var_141_8 and var_141_8.sprite then
					local var_141_9 = (var_141_7.transform.localPosition - var_141_5).z
					local var_141_10 = manager.ui.mainCameraCom_
					local var_141_11 = 2 * var_141_9 * Mathf.Tan(var_141_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_141_12 = var_141_11 * var_141_10.aspect
					local var_141_13 = var_141_8.sprite.bounds.size.x
					local var_141_14 = var_141_8.sprite.bounds.size.y
					local var_141_15 = var_141_12 / var_141_13
					local var_141_16 = var_141_11 / var_141_14
					local var_141_17 = var_141_16 < var_141_15 and var_141_15 or var_141_16

					var_141_7.transform.localScale = Vector3.New(var_141_17, var_141_17, 0)
				end

				for iter_141_0, iter_141_1 in pairs(arg_138_1.bgs_) do
					if iter_141_0 ~= "ST0512" then
						iter_141_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_141_18 = 0

			if var_141_18 < arg_138_1.time_ and arg_138_1.time_ <= var_141_18 + arg_141_0 then
				arg_138_1.mask_.enabled = true
				arg_138_1.mask_.raycastTarget = true

				arg_138_1:SetGaussion(false)
			end

			local var_141_19 = 1

			if var_141_18 <= arg_138_1.time_ and arg_138_1.time_ < var_141_18 + var_141_19 then
				local var_141_20 = (arg_138_1.time_ - var_141_18) / var_141_19
				local var_141_21 = Color.New(0, 0, 0)

				var_141_21.a = Mathf.Lerp(0, 1, var_141_20)
				arg_138_1.mask_.color = var_141_21
			end

			if arg_138_1.time_ >= var_141_18 + var_141_19 and arg_138_1.time_ < var_141_18 + var_141_19 + arg_141_0 then
				local var_141_22 = Color.New(0, 0, 0)

				var_141_22.a = 1
				arg_138_1.mask_.color = var_141_22
			end

			local var_141_23 = 1

			if var_141_23 < arg_138_1.time_ and arg_138_1.time_ <= var_141_23 + arg_141_0 then
				arg_138_1.mask_.enabled = true
				arg_138_1.mask_.raycastTarget = true

				arg_138_1:SetGaussion(false)
			end

			local var_141_24 = 2

			if var_141_23 <= arg_138_1.time_ and arg_138_1.time_ < var_141_23 + var_141_24 then
				local var_141_25 = (arg_138_1.time_ - var_141_23) / var_141_24
				local var_141_26 = Color.New(0, 0, 0)

				var_141_26.a = Mathf.Lerp(1, 0, var_141_25)
				arg_138_1.mask_.color = var_141_26
			end

			if arg_138_1.time_ >= var_141_23 + var_141_24 and arg_138_1.time_ < var_141_23 + var_141_24 + arg_141_0 then
				local var_141_27 = Color.New(0, 0, 0)
				local var_141_28 = 0

				arg_138_1.mask_.enabled = false
				var_141_27.a = var_141_28
				arg_138_1.mask_.color = var_141_27
			end

			local var_141_29 = 0
			local var_141_30 = 0.3

			if var_141_29 < arg_138_1.time_ and arg_138_1.time_ <= var_141_29 + arg_141_0 then
				local var_141_31 = "play"
				local var_141_32 = "music"

				arg_138_1:AudioAction(var_141_31, var_141_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_141_33 = ""
				local var_141_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_141_34 ~= "" then
					if arg_138_1.bgmTxt_.text ~= var_141_34 and arg_138_1.bgmTxt_.text ~= "" then
						if arg_138_1.bgmTxt2_.text ~= "" then
							arg_138_1.bgmTxt_.text = arg_138_1.bgmTxt2_.text
						end

						arg_138_1.bgmTxt2_.text = var_141_34

						arg_138_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_138_1.bgmTxt_.text = var_141_34
						arg_138_1.bgmTxt2_.text = var_141_34
					end

					if arg_138_1.bgmTimer then
						arg_138_1.bgmTimer:Stop()

						arg_138_1.bgmTimer = nil
					end

					if arg_138_1.settingData.show_music_name == 1 then
						arg_138_1.musicController:SetSelectedState("show")
						arg_138_1.musicAnimator_:Play("open", 0, 0)

						if arg_138_1.settingData.music_time ~= 0 then
							arg_138_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_138_1.settingData.music_time), function()
								if arg_138_1 == nil or isNil(arg_138_1.bgmTxt_) then
									return
								end

								arg_138_1.musicController:SetSelectedState("hide")
								arg_138_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_141_35 = 0.4
			local var_141_36 = 1

			if var_141_35 < arg_138_1.time_ and arg_138_1.time_ <= var_141_35 + arg_141_0 then
				local var_141_37 = "play"
				local var_141_38 = "music"

				arg_138_1:AudioAction(var_141_37, var_141_38, "bgm_activity_4_5_story_watcher_ruin", "bgm_activity_4_5_story_watcher_ruin", "bgm_activity_4_5_story_watcher_ruin.awb")

				local var_141_39 = ""
				local var_141_40 = manager.audio:GetAudioName("bgm_activity_4_5_story_watcher_ruin", "bgm_activity_4_5_story_watcher_ruin")

				if var_141_40 ~= "" then
					if arg_138_1.bgmTxt_.text ~= var_141_40 and arg_138_1.bgmTxt_.text ~= "" then
						if arg_138_1.bgmTxt2_.text ~= "" then
							arg_138_1.bgmTxt_.text = arg_138_1.bgmTxt2_.text
						end

						arg_138_1.bgmTxt2_.text = var_141_40

						arg_138_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_138_1.bgmTxt_.text = var_141_40
						arg_138_1.bgmTxt2_.text = var_141_40
					end

					if arg_138_1.bgmTimer then
						arg_138_1.bgmTimer:Stop()

						arg_138_1.bgmTimer = nil
					end

					if arg_138_1.settingData.show_music_name == 1 then
						arg_138_1.musicController:SetSelectedState("show")
						arg_138_1.musicAnimator_:Play("open", 0, 0)

						if arg_138_1.settingData.music_time ~= 0 then
							arg_138_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_138_1.settingData.music_time), function()
								if arg_138_1 == nil or isNil(arg_138_1.bgmTxt_) then
									return
								end

								arg_138_1.musicController:SetSelectedState("hide")
								arg_138_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_141_41 = 0.0166666666666666
			local var_141_42 = 1

			if var_141_41 < arg_138_1.time_ and arg_138_1.time_ <= var_141_41 + arg_141_0 then
				local var_141_43 = "stop"
				local var_141_44 = "effect"

				arg_138_1:AudioAction(var_141_43, var_141_44, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_141_45 = 0.7
			local var_141_46 = 1

			if var_141_45 < arg_138_1.time_ and arg_138_1.time_ <= var_141_45 + arg_141_0 then
				local var_141_47 = "play"
				local var_141_48 = "effect"

				arg_138_1:AudioAction(var_141_47, var_141_48, "se_story_145", "se_story_145_amb_ST0512", "")
			end

			if arg_138_1.frameCnt_ <= 1 then
				arg_138_1.dialog_:SetActive(false)
			end

			local var_141_49 = 3
			local var_141_50 = 1.125

			if var_141_49 < arg_138_1.time_ and arg_138_1.time_ <= var_141_49 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0

				arg_138_1.dialog_:SetActive(true)

				arg_138_1.dialogCg_.alpha = 0

				local var_141_51 = LeanTween.value(arg_138_1.dialog_, 0, 1, 0.3)

				var_141_51:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_138_1.dialogCg_.alpha = arg_144_0
				end))
				var_141_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_138_1.dialog_)
					var_141_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_138_1.duration_ = arg_138_1.duration_ + 0.3

				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_52 = arg_138_1:GetWordFromCfg(322251034)
				local var_141_53 = arg_138_1:FormatText(var_141_52.content)

				arg_138_1.text_.text = var_141_53

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_54 = 45
				local var_141_55 = utf8.len(var_141_53)
				local var_141_56 = var_141_54 <= 0 and var_141_50 or var_141_50 * (var_141_55 / var_141_54)

				if var_141_56 > 0 and var_141_50 < var_141_56 then
					arg_138_1.talkMaxDuration = var_141_56
					var_141_49 = var_141_49 + 0.3

					if var_141_56 + var_141_49 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_56 + var_141_49
					end
				end

				arg_138_1.text_.text = var_141_53
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_57 = var_141_49 + 0.3
			local var_141_58 = math.max(var_141_50, arg_138_1.talkMaxDuration)

			if var_141_57 <= arg_138_1.time_ and arg_138_1.time_ < var_141_57 + var_141_58 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_57) / var_141_58

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_57 + var_141_58 and arg_138_1.time_ < var_141_57 + var_141_58 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				groupID = "1033",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play322251035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 322251035
		arg_146_1.duration_ = 8.9

		local var_146_0 = {
			zh = 6,
			ja = 8.9
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
				arg_146_0:Play322251036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1020ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1020ui_story = var_149_0.localPosition
			end

			local var_149_2 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2
				local var_149_4 = Vector3.New(0, -0.85, -6.25)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1020ui_story, var_149_4, var_149_3)

				local var_149_5 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_5.x, var_149_5.y, var_149_5.z)

				local var_149_6 = var_149_0.localEulerAngles

				var_149_6.z = 0
				var_149_6.x = 0
				var_149_0.localEulerAngles = var_149_6
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_0.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_0.localEulerAngles = var_149_8
			end

			local var_149_9 = arg_146_1.actors_["1020ui_story"]
			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect1020ui_story == nil then
				arg_146_1.var_.characterEffect1020ui_story = var_149_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_11 = 0.200000002980232

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_11 and not isNil(var_149_9) then
				local var_149_12 = (arg_146_1.time_ - var_149_10) / var_149_11

				if arg_146_1.var_.characterEffect1020ui_story and not isNil(var_149_9) then
					arg_146_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_10 + var_149_11 and arg_146_1.time_ < var_149_10 + var_149_11 + arg_149_0 and not isNil(var_149_9) and arg_146_1.var_.characterEffect1020ui_story then
				arg_146_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_149_13 = 0

			if var_149_13 < arg_146_1.time_ and arg_146_1.time_ <= var_149_13 + arg_149_0 then
				arg_146_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_149_15 = 0
			local var_149_16 = 0.8

			if var_149_15 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_17 = arg_146_1:FormatText(StoryNameCfg[613].name)

				arg_146_1.leftNameTxt_.text = var_149_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_18 = arg_146_1:GetWordFromCfg(322251035)
				local var_149_19 = arg_146_1:FormatText(var_149_18.content)

				arg_146_1.text_.text = var_149_19

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_20 = 32
				local var_149_21 = utf8.len(var_149_19)
				local var_149_22 = var_149_20 <= 0 and var_149_16 or var_149_16 * (var_149_21 / var_149_20)

				if var_149_22 > 0 and var_149_16 < var_149_22 then
					arg_146_1.talkMaxDuration = var_149_22

					if var_149_22 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_22 + var_149_15
					end
				end

				arg_146_1.text_.text = var_149_19
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251035", "story_v_out_322251.awb") ~= 0 then
					local var_149_23 = manager.audio:GetVoiceLength("story_v_out_322251", "322251035", "story_v_out_322251.awb") / 1000

					if var_149_23 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_23 + var_149_15
					end

					if var_149_18.prefab_name ~= "" and arg_146_1.actors_[var_149_18.prefab_name] ~= nil then
						local var_149_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_18.prefab_name].transform, "story_v_out_322251", "322251035", "story_v_out_322251.awb")

						arg_146_1:RecordAudio("322251035", var_149_24)
						arg_146_1:RecordAudio("322251035", var_149_24)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_322251", "322251035", "story_v_out_322251.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_322251", "322251035", "story_v_out_322251.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_25 = math.max(var_149_16, arg_146_1.talkMaxDuration)

			if var_149_15 <= arg_146_1.time_ and arg_146_1.time_ < var_149_15 + var_149_25 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_15) / var_149_25

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_15 + var_149_25 and arg_146_1.time_ < var_149_15 + var_149_25 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play322251036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 322251036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play322251037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1020ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos1020ui_story = var_153_0.localPosition
			end

			local var_153_2 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2
				local var_153_4 = Vector3.New(0, 100, 0)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1020ui_story, var_153_4, var_153_3)

				local var_153_5 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_5.x, var_153_5.y, var_153_5.z)

				local var_153_6 = var_153_0.localEulerAngles

				var_153_6.z = 0
				var_153_6.x = 0
				var_153_0.localEulerAngles = var_153_6
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, 100, 0)

				local var_153_7 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_7.x, var_153_7.y, var_153_7.z)

				local var_153_8 = var_153_0.localEulerAngles

				var_153_8.z = 0
				var_153_8.x = 0
				var_153_0.localEulerAngles = var_153_8
			end

			local var_153_9 = 0
			local var_153_10 = 1.3

			if var_153_9 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_11 = arg_150_1:GetWordFromCfg(322251036)
				local var_153_12 = arg_150_1:FormatText(var_153_11.content)

				arg_150_1.text_.text = var_153_12

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_13 = 52
				local var_153_14 = utf8.len(var_153_12)
				local var_153_15 = var_153_13 <= 0 and var_153_10 or var_153_10 * (var_153_14 / var_153_13)

				if var_153_15 > 0 and var_153_10 < var_153_15 then
					arg_150_1.talkMaxDuration = var_153_15

					if var_153_15 + var_153_9 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_15 + var_153_9
					end
				end

				arg_150_1.text_.text = var_153_12
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_16 = math.max(var_153_10, arg_150_1.talkMaxDuration)

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_16 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_9) / var_153_16

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_9 + var_153_16 and arg_150_1.time_ < var_153_9 + var_153_16 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play322251037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 322251037
		arg_154_1.duration_ = 9.3

		local var_154_0 = {
			zh = 7,
			ja = 9.3
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
				arg_154_0:Play322251038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1020ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1020ui_story == nil then
				arg_154_1.var_.characterEffect1020ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1020ui_story and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1020ui_story then
				arg_154_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_157_4 = arg_154_1.actors_["1020ui_story"].transform
			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1.var_.moveOldPos1020ui_story = var_157_4.localPosition
			end

			local var_157_6 = 0.001

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_6 then
				local var_157_7 = (arg_154_1.time_ - var_157_5) / var_157_6
				local var_157_8 = Vector3.New(0, -0.85, -6.25)

				var_157_4.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1020ui_story, var_157_8, var_157_7)

				local var_157_9 = manager.ui.mainCamera.transform.position - var_157_4.position

				var_157_4.forward = Vector3.New(var_157_9.x, var_157_9.y, var_157_9.z)

				local var_157_10 = var_157_4.localEulerAngles

				var_157_10.z = 0
				var_157_10.x = 0
				var_157_4.localEulerAngles = var_157_10
			end

			if arg_154_1.time_ >= var_157_5 + var_157_6 and arg_154_1.time_ < var_157_5 + var_157_6 + arg_157_0 then
				var_157_4.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_157_11 = manager.ui.mainCamera.transform.position - var_157_4.position

				var_157_4.forward = Vector3.New(var_157_11.x, var_157_11.y, var_157_11.z)

				local var_157_12 = var_157_4.localEulerAngles

				var_157_12.z = 0
				var_157_12.x = 0
				var_157_4.localEulerAngles = var_157_12
			end

			local var_157_13 = 0

			if var_157_13 < arg_154_1.time_ and arg_154_1.time_ <= var_157_13 + arg_157_0 then
				arg_154_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_157_14 = 0
			local var_157_15 = 0.625

			if var_157_14 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_16 = arg_154_1:FormatText(StoryNameCfg[613].name)

				arg_154_1.leftNameTxt_.text = var_157_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_17 = arg_154_1:GetWordFromCfg(322251037)
				local var_157_18 = arg_154_1:FormatText(var_157_17.content)

				arg_154_1.text_.text = var_157_18

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_19 = 25
				local var_157_20 = utf8.len(var_157_18)
				local var_157_21 = var_157_19 <= 0 and var_157_15 or var_157_15 * (var_157_20 / var_157_19)

				if var_157_21 > 0 and var_157_15 < var_157_21 then
					arg_154_1.talkMaxDuration = var_157_21

					if var_157_21 + var_157_14 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_21 + var_157_14
					end
				end

				arg_154_1.text_.text = var_157_18
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251037", "story_v_out_322251.awb") ~= 0 then
					local var_157_22 = manager.audio:GetVoiceLength("story_v_out_322251", "322251037", "story_v_out_322251.awb") / 1000

					if var_157_22 + var_157_14 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_22 + var_157_14
					end

					if var_157_17.prefab_name ~= "" and arg_154_1.actors_[var_157_17.prefab_name] ~= nil then
						local var_157_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_17.prefab_name].transform, "story_v_out_322251", "322251037", "story_v_out_322251.awb")

						arg_154_1:RecordAudio("322251037", var_157_23)
						arg_154_1:RecordAudio("322251037", var_157_23)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_322251", "322251037", "story_v_out_322251.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_322251", "322251037", "story_v_out_322251.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_24 = math.max(var_157_15, arg_154_1.talkMaxDuration)

			if var_157_14 <= arg_154_1.time_ and arg_154_1.time_ < var_157_14 + var_157_24 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_14) / var_157_24

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_14 + var_157_24 and arg_154_1.time_ < var_157_14 + var_157_24 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play322251038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 322251038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play322251039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1020ui_story"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1020ui_story == nil then
				arg_158_1.var_.characterEffect1020ui_story = var_161_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.characterEffect1020ui_story and not isNil(var_161_0) then
					local var_161_4 = Mathf.Lerp(0, 0.5, var_161_3)

					arg_158_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1020ui_story.fillRatio = var_161_4
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.characterEffect1020ui_story then
				local var_161_5 = 0.5

				arg_158_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1020ui_story.fillRatio = var_161_5
			end

			local var_161_6 = 0
			local var_161_7 = 1.225

			if var_161_6 < arg_158_1.time_ and arg_158_1.time_ <= var_161_6 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_8 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_9 = arg_158_1:GetWordFromCfg(322251038)
				local var_161_10 = arg_158_1:FormatText(var_161_9.content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_11 = 49
				local var_161_12 = utf8.len(var_161_10)
				local var_161_13 = var_161_11 <= 0 and var_161_7 or var_161_7 * (var_161_12 / var_161_11)

				if var_161_13 > 0 and var_161_7 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_6 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_6
					end
				end

				arg_158_1.text_.text = var_161_10
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_14 = math.max(var_161_7, arg_158_1.talkMaxDuration)

			if var_161_6 <= arg_158_1.time_ and arg_158_1.time_ < var_161_6 + var_161_14 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_6) / var_161_14

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_6 + var_161_14 and arg_158_1.time_ < var_161_6 + var_161_14 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play322251039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 322251039
		arg_162_1.duration_ = 9.73

		local var_162_0 = {
			zh = 6.1,
			ja = 9.733
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play322251040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1020ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1020ui_story == nil then
				arg_162_1.var_.characterEffect1020ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1020ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1020ui_story then
				arg_162_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_165_4 = 0
			local var_165_5 = 0.675

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_6 = arg_162_1:FormatText(StoryNameCfg[613].name)

				arg_162_1.leftNameTxt_.text = var_165_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_7 = arg_162_1:GetWordFromCfg(322251039)
				local var_165_8 = arg_162_1:FormatText(var_165_7.content)

				arg_162_1.text_.text = var_165_8

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 27
				local var_165_10 = utf8.len(var_165_8)
				local var_165_11 = var_165_9 <= 0 and var_165_5 or var_165_5 * (var_165_10 / var_165_9)

				if var_165_11 > 0 and var_165_5 < var_165_11 then
					arg_162_1.talkMaxDuration = var_165_11

					if var_165_11 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_11 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_8
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251039", "story_v_out_322251.awb") ~= 0 then
					local var_165_12 = manager.audio:GetVoiceLength("story_v_out_322251", "322251039", "story_v_out_322251.awb") / 1000

					if var_165_12 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_12 + var_165_4
					end

					if var_165_7.prefab_name ~= "" and arg_162_1.actors_[var_165_7.prefab_name] ~= nil then
						local var_165_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_7.prefab_name].transform, "story_v_out_322251", "322251039", "story_v_out_322251.awb")

						arg_162_1:RecordAudio("322251039", var_165_13)
						arg_162_1:RecordAudio("322251039", var_165_13)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_322251", "322251039", "story_v_out_322251.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_322251", "322251039", "story_v_out_322251.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_14 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_14 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_14

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_14 and arg_162_1.time_ < var_165_4 + var_165_14 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play322251040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 322251040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play322251041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1020ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos1020ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, 100, 0)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1020ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, 100, 0)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = 0
			local var_169_10 = 1.55

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_11 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_12 = arg_166_1:GetWordFromCfg(322251040)
				local var_169_13 = arg_166_1:FormatText(var_169_12.content)

				arg_166_1.text_.text = var_169_13

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_14 = 62
				local var_169_15 = utf8.len(var_169_13)
				local var_169_16 = var_169_14 <= 0 and var_169_10 or var_169_10 * (var_169_15 / var_169_14)

				if var_169_16 > 0 and var_169_10 < var_169_16 then
					arg_166_1.talkMaxDuration = var_169_16

					if var_169_16 + var_169_9 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_16 + var_169_9
					end
				end

				arg_166_1.text_.text = var_169_13
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_17 = math.max(var_169_10, arg_166_1.talkMaxDuration)

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_17 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_9) / var_169_17

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_9 + var_169_17 and arg_166_1.time_ < var_169_9 + var_169_17 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play322251041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 322251041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play322251042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.575

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[7].name)

				arg_170_1.leftNameTxt_.text = var_173_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:GetWordFromCfg(322251041)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 23
				local var_173_6 = utf8.len(var_173_4)
				local var_173_7 = var_173_5 <= 0 and var_173_1 or var_173_1 * (var_173_6 / var_173_5)

				if var_173_7 > 0 and var_173_1 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_8 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_8 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_8

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_8 and arg_170_1.time_ < var_173_0 + var_173_8 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play322251042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 322251042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play322251043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1020ui_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos1020ui_story = var_177_0.localPosition
			end

			local var_177_2 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2
				local var_177_4 = Vector3.New(0, 100, 0)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1020ui_story, var_177_4, var_177_3)

				local var_177_5 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_5.x, var_177_5.y, var_177_5.z)

				local var_177_6 = var_177_0.localEulerAngles

				var_177_6.z = 0
				var_177_6.x = 0
				var_177_0.localEulerAngles = var_177_6
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0, 100, 0)

				local var_177_7 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_7.x, var_177_7.y, var_177_7.z)

				local var_177_8 = var_177_0.localEulerAngles

				var_177_8.z = 0
				var_177_8.x = 0
				var_177_0.localEulerAngles = var_177_8
			end

			local var_177_9 = 0
			local var_177_10 = 1.475

			if var_177_9 < arg_174_1.time_ and arg_174_1.time_ <= var_177_9 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_11 = arg_174_1:GetWordFromCfg(322251042)
				local var_177_12 = arg_174_1:FormatText(var_177_11.content)

				arg_174_1.text_.text = var_177_12

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 59
				local var_177_14 = utf8.len(var_177_12)
				local var_177_15 = var_177_13 <= 0 and var_177_10 or var_177_10 * (var_177_14 / var_177_13)

				if var_177_15 > 0 and var_177_10 < var_177_15 then
					arg_174_1.talkMaxDuration = var_177_15

					if var_177_15 + var_177_9 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_15 + var_177_9
					end
				end

				arg_174_1.text_.text = var_177_12
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_10, arg_174_1.talkMaxDuration)

			if var_177_9 <= arg_174_1.time_ and arg_174_1.time_ < var_177_9 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_9) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_9 + var_177_16 and arg_174_1.time_ < var_177_9 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play322251043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 322251043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play322251044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.65

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[7].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(322251043)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 26
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_8 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_8 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_8

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_8 and arg_178_1.time_ < var_181_0 + var_181_8 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play322251044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 322251044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play322251045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0
			local var_185_1 = 1.05

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_2 = arg_182_1:FormatText(StoryNameCfg[7].name)

				arg_182_1.leftNameTxt_.text = var_185_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_3 = arg_182_1:GetWordFromCfg(322251044)
				local var_185_4 = arg_182_1:FormatText(var_185_3.content)

				arg_182_1.text_.text = var_185_4

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 42
				local var_185_6 = utf8.len(var_185_4)
				local var_185_7 = var_185_5 <= 0 and var_185_1 or var_185_1 * (var_185_6 / var_185_5)

				if var_185_7 > 0 and var_185_1 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_4
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_8 and arg_182_1.time_ < var_185_0 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play322251045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 322251045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play322251046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.1
			local var_189_1 = 1

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				local var_189_2 = "play"
				local var_189_3 = "effect"

				arg_186_1:AudioAction(var_189_2, var_189_3, "se_story_6", "se_story_6_vessel_open", "")
			end

			local var_189_4 = 0
			local var_189_5 = 1.15

			if var_189_4 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_6 = arg_186_1:GetWordFromCfg(322251045)
				local var_189_7 = arg_186_1:FormatText(var_189_6.content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_8 = 46
				local var_189_9 = utf8.len(var_189_7)
				local var_189_10 = var_189_8 <= 0 and var_189_5 or var_189_5 * (var_189_9 / var_189_8)

				if var_189_10 > 0 and var_189_5 < var_189_10 then
					arg_186_1.talkMaxDuration = var_189_10

					if var_189_10 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_4
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_11 = math.max(var_189_5, arg_186_1.talkMaxDuration)

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_11 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_4) / var_189_11

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_4 + var_189_11 and arg_186_1.time_ < var_189_4 + var_189_11 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play322251046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 322251046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play322251047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 1.275

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_2 = arg_190_1:GetWordFromCfg(322251046)
				local var_193_3 = arg_190_1:FormatText(var_193_2.content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_4 = 51
				local var_193_5 = utf8.len(var_193_3)
				local var_193_6 = var_193_4 <= 0 and var_193_1 or var_193_1 * (var_193_5 / var_193_4)

				if var_193_6 > 0 and var_193_1 < var_193_6 then
					arg_190_1.talkMaxDuration = var_193_6

					if var_193_6 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_7 and arg_190_1.time_ < var_193_0 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play322251047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 322251047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play322251048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 0.35

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[7].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:GetWordFromCfg(322251047)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 14
				local var_197_6 = utf8.len(var_197_4)
				local var_197_7 = var_197_5 <= 0 and var_197_1 or var_197_1 * (var_197_6 / var_197_5)

				if var_197_7 > 0 and var_197_1 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_8 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_8 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_8

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_8 and arg_194_1.time_ < var_197_0 + var_197_8 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play322251048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 322251048
		arg_198_1.duration_ = 36.02

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play322251055(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				SetActive(arg_198_1.dialog_, false)
				SetActive(arg_198_1.allBtn_.gameObject, false)
				arg_198_1.hideBtnsController_:SetSelectedIndex(1)

				arg_198_1.marker = "stop1"

				manager.video:Play("SofdecAsset/story/story_103222501_1.usm", function(arg_202_0)
					if arg_198_1.state_ == "playing" then
						arg_198_1:JumpToEnd()
					end

					if arg_198_1.playNext_ and not arg_198_1.auto_ then
						arg_198_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_203_0)
					if arg_203_0 then
						arg_198_1.state_ = "pause"
					else
						arg_198_1.state_ = "playing"
					end
				end, 10322251)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_201_1 = 36

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_1 then
				-- block empty
			end

			if arg_198_1.time_ >= var_201_0 + var_201_1 and arg_198_1.time_ < var_201_0 + var_201_1 + arg_201_0 then
				arg_198_1.marker = ""
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play322251055 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 322251055
		arg_204_1.duration_ = 4.3

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play322251056(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.666666669646899

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.allBtn_.enabled = false
			end

			local var_207_1 = 0.3

			if arg_204_1.time_ >= var_207_0 + var_207_1 and arg_204_1.time_ < var_207_0 + var_207_1 + arg_207_0 then
				arg_204_1.allBtn_.enabled = true
			end

			local var_207_2 = 0

			if var_207_2 < arg_204_1.time_ and arg_204_1.time_ <= var_207_2 + arg_207_0 then
				local var_207_3 = manager.ui.mainCamera.transform.localPosition
				local var_207_4 = Vector3.New(0, 0, 10) + Vector3.New(var_207_3.x, var_207_3.y, 0)
				local var_207_5 = arg_204_1.bgs_.ST0512

				var_207_5.transform.localPosition = var_207_4
				var_207_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_207_6 = var_207_5:GetComponent("SpriteRenderer")

				if var_207_6 and var_207_6.sprite then
					local var_207_7 = (var_207_5.transform.localPosition - var_207_3).z
					local var_207_8 = manager.ui.mainCameraCom_
					local var_207_9 = 2 * var_207_7 * Mathf.Tan(var_207_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_207_10 = var_207_9 * var_207_8.aspect
					local var_207_11 = var_207_6.sprite.bounds.size.x
					local var_207_12 = var_207_6.sprite.bounds.size.y
					local var_207_13 = var_207_10 / var_207_11
					local var_207_14 = var_207_9 / var_207_12
					local var_207_15 = var_207_14 < var_207_13 and var_207_13 or var_207_14

					var_207_5.transform.localScale = Vector3.New(var_207_15, var_207_15, 0)
				end

				for iter_207_0, iter_207_1 in pairs(arg_204_1.bgs_) do
					if iter_207_0 ~= "ST0512" then
						iter_207_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_207_16 = 0

			if var_207_16 < arg_204_1.time_ and arg_204_1.time_ <= var_207_16 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_17 = 0.766666666666667

			if var_207_16 <= arg_204_1.time_ and arg_204_1.time_ < var_207_16 + var_207_17 then
				local var_207_18 = (arg_204_1.time_ - var_207_16) / var_207_17
				local var_207_19 = Color.New(0, 0, 0)

				var_207_19.a = Mathf.Lerp(1, 0, var_207_18)
				arg_204_1.mask_.color = var_207_19
			end

			if arg_204_1.time_ >= var_207_16 + var_207_17 and arg_204_1.time_ < var_207_16 + var_207_17 + arg_207_0 then
				local var_207_20 = Color.New(0, 0, 0)
				local var_207_21 = 0

				arg_204_1.mask_.enabled = false
				var_207_20.a = var_207_21
				arg_204_1.mask_.color = var_207_20
			end

			local var_207_22 = arg_204_1.actors_["1020ui_story"].transform
			local var_207_23 = 0.766666666666667

			if var_207_23 < arg_204_1.time_ and arg_204_1.time_ <= var_207_23 + arg_207_0 then
				arg_204_1.var_.moveOldPos1020ui_story = var_207_22.localPosition
			end

			local var_207_24 = 0.001

			if var_207_23 <= arg_204_1.time_ and arg_204_1.time_ < var_207_23 + var_207_24 then
				local var_207_25 = (arg_204_1.time_ - var_207_23) / var_207_24
				local var_207_26 = Vector3.New(0, -0.85, -6.25)

				var_207_22.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1020ui_story, var_207_26, var_207_25)

				local var_207_27 = manager.ui.mainCamera.transform.position - var_207_22.position

				var_207_22.forward = Vector3.New(var_207_27.x, var_207_27.y, var_207_27.z)

				local var_207_28 = var_207_22.localEulerAngles

				var_207_28.z = 0
				var_207_28.x = 0
				var_207_22.localEulerAngles = var_207_28
			end

			if arg_204_1.time_ >= var_207_23 + var_207_24 and arg_204_1.time_ < var_207_23 + var_207_24 + arg_207_0 then
				var_207_22.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_207_29 = manager.ui.mainCamera.transform.position - var_207_22.position

				var_207_22.forward = Vector3.New(var_207_29.x, var_207_29.y, var_207_29.z)

				local var_207_30 = var_207_22.localEulerAngles

				var_207_30.z = 0
				var_207_30.x = 0
				var_207_22.localEulerAngles = var_207_30
			end

			local var_207_31 = arg_204_1.actors_["1020ui_story"]
			local var_207_32 = 0.766666666666667

			if var_207_32 < arg_204_1.time_ and arg_204_1.time_ <= var_207_32 + arg_207_0 and not isNil(var_207_31) and arg_204_1.var_.characterEffect1020ui_story == nil then
				arg_204_1.var_.characterEffect1020ui_story = var_207_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_33 = 0.200000002980232

			if var_207_32 <= arg_204_1.time_ and arg_204_1.time_ < var_207_32 + var_207_33 and not isNil(var_207_31) then
				local var_207_34 = (arg_204_1.time_ - var_207_32) / var_207_33

				if arg_204_1.var_.characterEffect1020ui_story and not isNil(var_207_31) then
					arg_204_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_32 + var_207_33 and arg_204_1.time_ < var_207_32 + var_207_33 + arg_207_0 and not isNil(var_207_31) and arg_204_1.var_.characterEffect1020ui_story then
				arg_204_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_207_35 = 0.766666666666667

			if var_207_35 < arg_204_1.time_ and arg_204_1.time_ <= var_207_35 + arg_207_0 then
				arg_204_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_207_36 = 0

			if var_207_36 < arg_204_1.time_ and arg_204_1.time_ <= var_207_36 + arg_207_0 then
				SetActive(arg_204_1.dialog_, true)
				SetActive(arg_204_1.allBtn_.gameObject, true)
				arg_204_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_204_1.isInLoopVideo = false
			end

			local var_207_37 = 0.0333333333333333

			if var_207_36 <= arg_204_1.time_ and arg_204_1.time_ < var_207_36 + var_207_37 then
				-- block empty
			end

			if arg_204_1.time_ >= var_207_36 + var_207_37 and arg_204_1.time_ < var_207_36 + var_207_37 + arg_207_0 then
				arg_204_1.marker = ""
			end

			if arg_204_1.frameCnt_ <= 1 then
				arg_204_1.dialog_:SetActive(false)
			end

			local var_207_38 = 0.666666669646899
			local var_207_39 = 0.05

			if var_207_38 < arg_204_1.time_ and arg_204_1.time_ <= var_207_38 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0

				arg_204_1.dialog_:SetActive(true)

				arg_204_1.dialogCg_.alpha = 0

				local var_207_40 = LeanTween.value(arg_204_1.dialog_, 0, 1, 0.3)

				var_207_40:setOnUpdate(LuaHelper.FloatAction(function(arg_208_0)
					arg_204_1.dialogCg_.alpha = arg_208_0
				end))
				var_207_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_204_1.dialog_)
					var_207_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_204_1.duration_ = arg_204_1.duration_ + 0.3

				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_41 = arg_204_1:FormatText(StoryNameCfg[613].name)

				arg_204_1.leftNameTxt_.text = var_207_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_42 = arg_204_1:GetWordFromCfg(322251055)
				local var_207_43 = arg_204_1:FormatText(var_207_42.content)

				arg_204_1.text_.text = var_207_43

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_44 = 2
				local var_207_45 = utf8.len(var_207_43)
				local var_207_46 = var_207_44 <= 0 and var_207_39 or var_207_39 * (var_207_45 / var_207_44)

				if var_207_46 > 0 and var_207_39 < var_207_46 then
					arg_204_1.talkMaxDuration = var_207_46
					var_207_38 = var_207_38 + 0.3

					if var_207_46 + var_207_38 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_46 + var_207_38
					end
				end

				arg_204_1.text_.text = var_207_43
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251055", "story_v_out_322251.awb") ~= 0 then
					local var_207_47 = manager.audio:GetVoiceLength("story_v_out_322251", "322251055", "story_v_out_322251.awb") / 1000

					if var_207_47 + var_207_38 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_47 + var_207_38
					end

					if var_207_42.prefab_name ~= "" and arg_204_1.actors_[var_207_42.prefab_name] ~= nil then
						local var_207_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_42.prefab_name].transform, "story_v_out_322251", "322251055", "story_v_out_322251.awb")

						arg_204_1:RecordAudio("322251055", var_207_48)
						arg_204_1:RecordAudio("322251055", var_207_48)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_322251", "322251055", "story_v_out_322251.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_322251", "322251055", "story_v_out_322251.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_49 = var_207_38 + 0.3
			local var_207_50 = math.max(var_207_39, arg_204_1.talkMaxDuration)

			if var_207_49 <= arg_204_1.time_ and arg_204_1.time_ < var_207_49 + var_207_50 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_49) / var_207_50

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_49 + var_207_50 and arg_204_1.time_ < var_207_49 + var_207_50 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.766666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play322251056 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 322251056
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play322251057(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1020ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1020ui_story == nil then
				arg_210_1.var_.characterEffect1020ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1020ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1020ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1020ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1020ui_story.fillRatio = var_213_5
			end

			local var_213_6 = 0
			local var_213_7 = 0.05

			if var_213_6 < arg_210_1.time_ and arg_210_1.time_ <= var_213_6 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_8 = arg_210_1:FormatText(StoryNameCfg[7].name)

				arg_210_1.leftNameTxt_.text = var_213_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_9 = arg_210_1:GetWordFromCfg(322251056)
				local var_213_10 = arg_210_1:FormatText(var_213_9.content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_11 = 2
				local var_213_12 = utf8.len(var_213_10)
				local var_213_13 = var_213_11 <= 0 and var_213_7 or var_213_7 * (var_213_12 / var_213_11)

				if var_213_13 > 0 and var_213_7 < var_213_13 then
					arg_210_1.talkMaxDuration = var_213_13

					if var_213_13 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_13 + var_213_6
					end
				end

				arg_210_1.text_.text = var_213_10
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_14 = math.max(var_213_7, arg_210_1.talkMaxDuration)

			if var_213_6 <= arg_210_1.time_ and arg_210_1.time_ < var_213_6 + var_213_14 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_6) / var_213_14

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_6 + var_213_14 and arg_210_1.time_ < var_213_6 + var_213_14 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play322251057 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 322251057
		arg_214_1.duration_ = 2.57

		local var_214_0 = {
			zh = 1.999999999999,
			ja = 2.566
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play322251058(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1020ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1020ui_story == nil then
				arg_214_1.var_.characterEffect1020ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1020ui_story and not isNil(var_217_0) then
					arg_214_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1020ui_story then
				arg_214_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_217_4 = arg_214_1.actors_["1020ui_story"].transform
			local var_217_5 = 0

			if var_217_5 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1.var_.moveOldPos1020ui_story = var_217_4.localPosition
			end

			local var_217_6 = 0.001

			if var_217_5 <= arg_214_1.time_ and arg_214_1.time_ < var_217_5 + var_217_6 then
				local var_217_7 = (arg_214_1.time_ - var_217_5) / var_217_6
				local var_217_8 = Vector3.New(0, -0.85, -6.25)

				var_217_4.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1020ui_story, var_217_8, var_217_7)

				local var_217_9 = manager.ui.mainCamera.transform.position - var_217_4.position

				var_217_4.forward = Vector3.New(var_217_9.x, var_217_9.y, var_217_9.z)

				local var_217_10 = var_217_4.localEulerAngles

				var_217_10.z = 0
				var_217_10.x = 0
				var_217_4.localEulerAngles = var_217_10
			end

			if arg_214_1.time_ >= var_217_5 + var_217_6 and arg_214_1.time_ < var_217_5 + var_217_6 + arg_217_0 then
				var_217_4.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_217_11 = manager.ui.mainCamera.transform.position - var_217_4.position

				var_217_4.forward = Vector3.New(var_217_11.x, var_217_11.y, var_217_11.z)

				local var_217_12 = var_217_4.localEulerAngles

				var_217_12.z = 0
				var_217_12.x = 0
				var_217_4.localEulerAngles = var_217_12
			end

			local var_217_13 = 0

			if var_217_13 < arg_214_1.time_ and arg_214_1.time_ <= var_217_13 + arg_217_0 then
				arg_214_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_217_14 = 0
			local var_217_15 = 0.175

			if var_217_14 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_16 = arg_214_1:FormatText(StoryNameCfg[613].name)

				arg_214_1.leftNameTxt_.text = var_217_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_17 = arg_214_1:GetWordFromCfg(322251057)
				local var_217_18 = arg_214_1:FormatText(var_217_17.content)

				arg_214_1.text_.text = var_217_18

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_19 = 7
				local var_217_20 = utf8.len(var_217_18)
				local var_217_21 = var_217_19 <= 0 and var_217_15 or var_217_15 * (var_217_20 / var_217_19)

				if var_217_21 > 0 and var_217_15 < var_217_21 then
					arg_214_1.talkMaxDuration = var_217_21

					if var_217_21 + var_217_14 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_21 + var_217_14
					end
				end

				arg_214_1.text_.text = var_217_18
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251057", "story_v_out_322251.awb") ~= 0 then
					local var_217_22 = manager.audio:GetVoiceLength("story_v_out_322251", "322251057", "story_v_out_322251.awb") / 1000

					if var_217_22 + var_217_14 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_22 + var_217_14
					end

					if var_217_17.prefab_name ~= "" and arg_214_1.actors_[var_217_17.prefab_name] ~= nil then
						local var_217_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_17.prefab_name].transform, "story_v_out_322251", "322251057", "story_v_out_322251.awb")

						arg_214_1:RecordAudio("322251057", var_217_23)
						arg_214_1:RecordAudio("322251057", var_217_23)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_322251", "322251057", "story_v_out_322251.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_322251", "322251057", "story_v_out_322251.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_24 = math.max(var_217_15, arg_214_1.talkMaxDuration)

			if var_217_14 <= arg_214_1.time_ and arg_214_1.time_ < var_217_14 + var_217_24 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_14) / var_217_24

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_14 + var_217_24 and arg_214_1.time_ < var_217_14 + var_217_24 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play322251058 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 322251058
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play322251059(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1020ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1020ui_story == nil then
				arg_218_1.var_.characterEffect1020ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect1020ui_story and not isNil(var_221_0) then
					local var_221_4 = Mathf.Lerp(0, 0.5, var_221_3)

					arg_218_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1020ui_story.fillRatio = var_221_4
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1020ui_story then
				local var_221_5 = 0.5

				arg_218_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1020ui_story.fillRatio = var_221_5
			end

			local var_221_6 = arg_218_1.actors_["1020ui_story"].transform
			local var_221_7 = 0

			if var_221_7 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 then
				arg_218_1.var_.moveOldPos1020ui_story = var_221_6.localPosition
			end

			local var_221_8 = 0.001

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_8 then
				local var_221_9 = (arg_218_1.time_ - var_221_7) / var_221_8
				local var_221_10 = Vector3.New(0, 100, 0)

				var_221_6.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1020ui_story, var_221_10, var_221_9)

				local var_221_11 = manager.ui.mainCamera.transform.position - var_221_6.position

				var_221_6.forward = Vector3.New(var_221_11.x, var_221_11.y, var_221_11.z)

				local var_221_12 = var_221_6.localEulerAngles

				var_221_12.z = 0
				var_221_12.x = 0
				var_221_6.localEulerAngles = var_221_12
			end

			if arg_218_1.time_ >= var_221_7 + var_221_8 and arg_218_1.time_ < var_221_7 + var_221_8 + arg_221_0 then
				var_221_6.localPosition = Vector3.New(0, 100, 0)

				local var_221_13 = manager.ui.mainCamera.transform.position - var_221_6.position

				var_221_6.forward = Vector3.New(var_221_13.x, var_221_13.y, var_221_13.z)

				local var_221_14 = var_221_6.localEulerAngles

				var_221_14.z = 0
				var_221_14.x = 0
				var_221_6.localEulerAngles = var_221_14
			end

			local var_221_15 = 0
			local var_221_16 = 1

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_17 = arg_218_1:FormatText(StoryNameCfg[7].name)

				arg_218_1.leftNameTxt_.text = var_221_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_18 = arg_218_1:GetWordFromCfg(322251058)
				local var_221_19 = arg_218_1:FormatText(var_221_18.content)

				arg_218_1.text_.text = var_221_19

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_20 = 40
				local var_221_21 = utf8.len(var_221_19)
				local var_221_22 = var_221_20 <= 0 and var_221_16 or var_221_16 * (var_221_21 / var_221_20)

				if var_221_22 > 0 and var_221_16 < var_221_22 then
					arg_218_1.talkMaxDuration = var_221_22

					if var_221_22 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_22 + var_221_15
					end
				end

				arg_218_1.text_.text = var_221_19
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_23 = math.max(var_221_16, arg_218_1.talkMaxDuration)

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_23 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_15) / var_221_23

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_15 + var_221_23 and arg_218_1.time_ < var_221_15 + var_221_23 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play322251059 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 322251059
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play322251060(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.275

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[7].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:GetWordFromCfg(322251059)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 11
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_8 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_8 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_8

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_8 and arg_222_1.time_ < var_225_0 + var_225_8 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play322251060 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 322251060
		arg_226_1.duration_ = 36

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play322251066(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				SetActive(arg_226_1.dialog_, false)
				SetActive(arg_226_1.allBtn_.gameObject, false)
				arg_226_1.hideBtnsController_:SetSelectedIndex(1)

				arg_226_1.marker = "stop2"

				manager.video:Play("SofdecAsset/story/story_103222501_2.usm", function(arg_230_0)
					if arg_226_1.state_ == "playing" then
						arg_226_1:JumpToEnd()
					end

					if arg_226_1.playNext_ and not arg_226_1.auto_ then
						arg_226_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_231_0)
					if arg_231_0 then
						arg_226_1.state_ = "pause"
					else
						arg_226_1.state_ = "playing"
					end
				end, 10322252)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_229_1 = 22.5833333333333

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_1 then
				-- block empty
			end

			if arg_226_1.time_ >= var_229_0 + var_229_1 and arg_226_1.time_ < var_229_0 + var_229_1 + arg_229_0 then
				arg_226_1.marker = ""
			end

			local var_229_2 = arg_226_1.actors_["1020ui_story"].transform
			local var_229_3 = 0

			if var_229_3 < arg_226_1.time_ and arg_226_1.time_ <= var_229_3 + arg_229_0 then
				arg_226_1.var_.moveOldPos1020ui_story = var_229_2.localPosition
			end

			local var_229_4 = 0.001

			if var_229_3 <= arg_226_1.time_ and arg_226_1.time_ < var_229_3 + var_229_4 then
				local var_229_5 = (arg_226_1.time_ - var_229_3) / var_229_4
				local var_229_6 = Vector3.New(0, 100, 0)

				var_229_2.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1020ui_story, var_229_6, var_229_5)

				local var_229_7 = manager.ui.mainCamera.transform.position - var_229_2.position

				var_229_2.forward = Vector3.New(var_229_7.x, var_229_7.y, var_229_7.z)

				local var_229_8 = var_229_2.localEulerAngles

				var_229_8.z = 0
				var_229_8.x = 0
				var_229_2.localEulerAngles = var_229_8
			end

			if arg_226_1.time_ >= var_229_3 + var_229_4 and arg_226_1.time_ < var_229_3 + var_229_4 + arg_229_0 then
				var_229_2.localPosition = Vector3.New(0, 100, 0)

				local var_229_9 = manager.ui.mainCamera.transform.position - var_229_2.position

				var_229_2.forward = Vector3.New(var_229_9.x, var_229_9.y, var_229_9.z)

				local var_229_10 = var_229_2.localEulerAngles

				var_229_10.z = 0
				var_229_10.x = 0
				var_229_2.localEulerAngles = var_229_10
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play322251066 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 322251066
		arg_232_1.duration_ = 7

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play322251067(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 2

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.allBtn_.enabled = false
			end

			local var_235_1 = 0.15

			if arg_232_1.time_ >= var_235_0 + var_235_1 and arg_232_1.time_ < var_235_0 + var_235_1 + arg_235_0 then
				arg_232_1.allBtn_.enabled = true
			end

			local var_235_2 = 0

			if var_235_2 < arg_232_1.time_ and arg_232_1.time_ <= var_235_2 + arg_235_0 then
				local var_235_3 = manager.ui.mainCamera.transform.localPosition
				local var_235_4 = Vector3.New(0, 0, 10) + Vector3.New(var_235_3.x, var_235_3.y, 0)
				local var_235_5 = arg_232_1.bgs_.ST0512

				var_235_5.transform.localPosition = var_235_4
				var_235_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_235_6 = var_235_5:GetComponent("SpriteRenderer")

				if var_235_6 and var_235_6.sprite then
					local var_235_7 = (var_235_5.transform.localPosition - var_235_3).z
					local var_235_8 = manager.ui.mainCameraCom_
					local var_235_9 = 2 * var_235_7 * Mathf.Tan(var_235_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_235_10 = var_235_9 * var_235_8.aspect
					local var_235_11 = var_235_6.sprite.bounds.size.x
					local var_235_12 = var_235_6.sprite.bounds.size.y
					local var_235_13 = var_235_10 / var_235_11
					local var_235_14 = var_235_9 / var_235_12
					local var_235_15 = var_235_14 < var_235_13 and var_235_13 or var_235_14

					var_235_5.transform.localScale = Vector3.New(var_235_15, var_235_15, 0)
				end

				for iter_235_0, iter_235_1 in pairs(arg_232_1.bgs_) do
					if iter_235_0 ~= "ST0512" then
						iter_235_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_235_16 = 0

			if var_235_16 < arg_232_1.time_ and arg_232_1.time_ <= var_235_16 + arg_235_0 then
				arg_232_1.mask_.enabled = true
				arg_232_1.mask_.raycastTarget = true

				arg_232_1:SetGaussion(false)
			end

			local var_235_17 = 2

			if var_235_16 <= arg_232_1.time_ and arg_232_1.time_ < var_235_16 + var_235_17 then
				local var_235_18 = (arg_232_1.time_ - var_235_16) / var_235_17
				local var_235_19 = Color.New(0, 0, 0)

				var_235_19.a = Mathf.Lerp(1, 0, var_235_18)
				arg_232_1.mask_.color = var_235_19
			end

			if arg_232_1.time_ >= var_235_16 + var_235_17 and arg_232_1.time_ < var_235_16 + var_235_17 + arg_235_0 then
				local var_235_20 = Color.New(0, 0, 0)
				local var_235_21 = 0

				arg_232_1.mask_.enabled = false
				var_235_20.a = var_235_21
				arg_232_1.mask_.color = var_235_20
			end

			local var_235_22 = 0

			if var_235_22 < arg_232_1.time_ and arg_232_1.time_ <= var_235_22 + arg_235_0 then
				SetActive(arg_232_1.dialog_, true)
				SetActive(arg_232_1.allBtn_.gameObject, true)
				arg_232_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_232_1.isInLoopVideo = false
			end

			local var_235_23 = 1

			if var_235_22 <= arg_232_1.time_ and arg_232_1.time_ < var_235_22 + var_235_23 then
				-- block empty
			end

			if arg_232_1.time_ >= var_235_22 + var_235_23 and arg_232_1.time_ < var_235_22 + var_235_23 + arg_235_0 then
				arg_232_1.marker = ""
			end

			if arg_232_1.frameCnt_ <= 1 then
				arg_232_1.dialog_:SetActive(false)
			end

			local var_235_24 = 2
			local var_235_25 = 0.15

			if var_235_24 < arg_232_1.time_ and arg_232_1.time_ <= var_235_24 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0

				arg_232_1.dialog_:SetActive(true)

				arg_232_1.dialogCg_.alpha = 0

				local var_235_26 = LeanTween.value(arg_232_1.dialog_, 0, 1, 0.3)

				var_235_26:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_232_1.dialogCg_.alpha = arg_236_0
				end))
				var_235_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_232_1.dialog_)
					var_235_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_232_1.duration_ = arg_232_1.duration_ + 0.3

				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_27 = arg_232_1:FormatText(StoryNameCfg[7].name)

				arg_232_1.leftNameTxt_.text = var_235_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_28 = arg_232_1:GetWordFromCfg(322251066)
				local var_235_29 = arg_232_1:FormatText(var_235_28.content)

				arg_232_1.text_.text = var_235_29

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_30 = 6
				local var_235_31 = utf8.len(var_235_29)
				local var_235_32 = var_235_30 <= 0 and var_235_25 or var_235_25 * (var_235_31 / var_235_30)

				if var_235_32 > 0 and var_235_25 < var_235_32 then
					arg_232_1.talkMaxDuration = var_235_32
					var_235_24 = var_235_24 + 0.3

					if var_235_32 + var_235_24 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_32 + var_235_24
					end
				end

				arg_232_1.text_.text = var_235_29
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_33 = var_235_24 + 0.3
			local var_235_34 = math.max(var_235_25, arg_232_1.talkMaxDuration)

			if var_235_33 <= arg_232_1.time_ and arg_232_1.time_ < var_235_33 + var_235_34 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_33) / var_235_34

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_33 + var_235_34 and arg_232_1.time_ < var_235_33 + var_235_34 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play322251067 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 322251067
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play322251068(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 1.125

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_2 = arg_238_1:GetWordFromCfg(322251067)
				local var_241_3 = arg_238_1:FormatText(var_241_2.content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 45
				local var_241_5 = utf8.len(var_241_3)
				local var_241_6 = var_241_4 <= 0 and var_241_1 or var_241_1 * (var_241_5 / var_241_4)

				if var_241_6 > 0 and var_241_1 < var_241_6 then
					arg_238_1.talkMaxDuration = var_241_6

					if var_241_6 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_7 and arg_238_1.time_ < var_241_0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play322251068 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 322251068
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play322251069(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0
			local var_245_1 = 0.65

			if var_245_0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_2 = arg_242_1:GetWordFromCfg(322251068)
				local var_245_3 = arg_242_1:FormatText(var_245_2.content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 26
				local var_245_5 = utf8.len(var_245_3)
				local var_245_6 = var_245_4 <= 0 and var_245_1 or var_245_1 * (var_245_5 / var_245_4)

				if var_245_6 > 0 and var_245_1 < var_245_6 then
					arg_242_1.talkMaxDuration = var_245_6

					if var_245_6 + var_245_0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_6 + var_245_0
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_1, arg_242_1.talkMaxDuration)

			if var_245_0 <= arg_242_1.time_ and arg_242_1.time_ < var_245_0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_0 + var_245_7 and arg_242_1.time_ < var_245_0 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play322251069 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 322251069
		arg_246_1.duration_ = 36

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play322251073(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				SetActive(arg_246_1.dialog_, false)
				SetActive(arg_246_1.allBtn_.gameObject, false)
				arg_246_1.hideBtnsController_:SetSelectedIndex(1)

				arg_246_1.marker = "stop3"

				manager.video:Play("SofdecAsset/story/story_103222501_3.usm", function(arg_250_0)
					if arg_246_1.state_ == "playing" then
						arg_246_1:JumpToEnd()
					end

					if arg_246_1.playNext_ and not arg_246_1.auto_ then
						arg_246_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_251_0)
					if arg_251_0 then
						arg_246_1.state_ = "pause"
					else
						arg_246_1.state_ = "playing"
					end
				end, 10322253)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_249_1 = 12.0833333333333

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_1 then
				-- block empty
			end

			if arg_246_1.time_ >= var_249_0 + var_249_1 and arg_246_1.time_ < var_249_0 + var_249_1 + arg_249_0 then
				arg_246_1.marker = ""
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play322251073 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 322251073
		arg_252_1.duration_ = 7

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play322251074(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 2

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			local var_255_1 = 0.175

			if arg_252_1.time_ >= var_255_0 + var_255_1 and arg_252_1.time_ < var_255_0 + var_255_1 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			local var_255_2 = 0

			if var_255_2 < arg_252_1.time_ and arg_252_1.time_ <= var_255_2 + arg_255_0 then
				local var_255_3 = manager.ui.mainCamera.transform.localPosition
				local var_255_4 = Vector3.New(0, 0, 10) + Vector3.New(var_255_3.x, var_255_3.y, 0)
				local var_255_5 = arg_252_1.bgs_.ST0512

				var_255_5.transform.localPosition = var_255_4
				var_255_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_6 = var_255_5:GetComponent("SpriteRenderer")

				if var_255_6 and var_255_6.sprite then
					local var_255_7 = (var_255_5.transform.localPosition - var_255_3).z
					local var_255_8 = manager.ui.mainCameraCom_
					local var_255_9 = 2 * var_255_7 * Mathf.Tan(var_255_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_255_10 = var_255_9 * var_255_8.aspect
					local var_255_11 = var_255_6.sprite.bounds.size.x
					local var_255_12 = var_255_6.sprite.bounds.size.y
					local var_255_13 = var_255_10 / var_255_11
					local var_255_14 = var_255_9 / var_255_12
					local var_255_15 = var_255_14 < var_255_13 and var_255_13 or var_255_14

					var_255_5.transform.localScale = Vector3.New(var_255_15, var_255_15, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "ST0512" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_255_16 = 0

			if var_255_16 < arg_252_1.time_ and arg_252_1.time_ <= var_255_16 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_17 = 2

			if var_255_16 <= arg_252_1.time_ and arg_252_1.time_ < var_255_16 + var_255_17 then
				local var_255_18 = (arg_252_1.time_ - var_255_16) / var_255_17
				local var_255_19 = Color.New(0, 0, 0)

				var_255_19.a = Mathf.Lerp(1, 0, var_255_18)
				arg_252_1.mask_.color = var_255_19
			end

			if arg_252_1.time_ >= var_255_16 + var_255_17 and arg_252_1.time_ < var_255_16 + var_255_17 + arg_255_0 then
				local var_255_20 = Color.New(0, 0, 0)
				local var_255_21 = 0

				arg_252_1.mask_.enabled = false
				var_255_20.a = var_255_21
				arg_252_1.mask_.color = var_255_20
			end

			local var_255_22 = 0

			if var_255_22 < arg_252_1.time_ and arg_252_1.time_ <= var_255_22 + arg_255_0 then
				SetActive(arg_252_1.dialog_, true)
				SetActive(arg_252_1.allBtn_.gameObject, true)
				arg_252_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_252_1.isInLoopVideo = false
			end

			local var_255_23 = 0.1

			if var_255_22 <= arg_252_1.time_ and arg_252_1.time_ < var_255_22 + var_255_23 then
				-- block empty
			end

			if arg_252_1.time_ >= var_255_22 + var_255_23 and arg_252_1.time_ < var_255_22 + var_255_23 + arg_255_0 then
				arg_252_1.marker = ""
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_24 = 2
			local var_255_25 = 0.175

			if var_255_24 < arg_252_1.time_ and arg_252_1.time_ <= var_255_24 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_26 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_26:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_27 = arg_252_1:FormatText(StoryNameCfg[7].name)

				arg_252_1.leftNameTxt_.text = var_255_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_28 = arg_252_1:GetWordFromCfg(322251073)
				local var_255_29 = arg_252_1:FormatText(var_255_28.content)

				arg_252_1.text_.text = var_255_29

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_30 = 7
				local var_255_31 = utf8.len(var_255_29)
				local var_255_32 = var_255_30 <= 0 and var_255_25 or var_255_25 * (var_255_31 / var_255_30)

				if var_255_32 > 0 and var_255_25 < var_255_32 then
					arg_252_1.talkMaxDuration = var_255_32
					var_255_24 = var_255_24 + 0.3

					if var_255_32 + var_255_24 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_32 + var_255_24
					end
				end

				arg_252_1.text_.text = var_255_29
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_33 = var_255_24 + 0.3
			local var_255_34 = math.max(var_255_25, arg_252_1.talkMaxDuration)

			if var_255_33 <= arg_252_1.time_ and arg_252_1.time_ < var_255_33 + var_255_34 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_33) / var_255_34

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_33 + var_255_34 and arg_252_1.time_ < var_255_33 + var_255_34 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play322251074 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 322251074
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play322251075(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.5

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

				local var_261_2 = arg_258_1:GetWordFromCfg(322251074)
				local var_261_3 = arg_258_1:FormatText(var_261_2.content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 20
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
	Play322251075 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 322251075
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play322251076(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 1.375

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_2 = arg_262_1:GetWordFromCfg(322251075)
				local var_265_3 = arg_262_1:FormatText(var_265_2.content)

				arg_262_1.text_.text = var_265_3

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 55
				local var_265_5 = utf8.len(var_265_3)
				local var_265_6 = var_265_4 <= 0 and var_265_1 or var_265_1 * (var_265_5 / var_265_4)

				if var_265_6 > 0 and var_265_1 < var_265_6 then
					arg_262_1.talkMaxDuration = var_265_6

					if var_265_6 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_3
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_7 and arg_262_1.time_ < var_265_0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play322251076 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 322251076
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play322251077(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 1.125

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_2 = arg_266_1:GetWordFromCfg(322251076)
				local var_269_3 = arg_266_1:FormatText(var_269_2.content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 45
				local var_269_5 = utf8.len(var_269_3)
				local var_269_6 = var_269_4 <= 0 and var_269_1 or var_269_1 * (var_269_5 / var_269_4)

				if var_269_6 > 0 and var_269_1 < var_269_6 then
					arg_266_1.talkMaxDuration = var_269_6

					if var_269_6 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_7 and arg_266_1.time_ < var_269_0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play322251077 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 322251077
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play322251078(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 1.425

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

				local var_273_2 = arg_270_1:GetWordFromCfg(322251077)
				local var_273_3 = arg_270_1:FormatText(var_273_2.content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 57
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
	Play322251078 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 322251078
		arg_274_1.duration_ = 2

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play322251079(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1020ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1020ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, -0.85, -6.25)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1020ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = arg_274_1.actors_["1020ui_story"]
			local var_277_10 = 0

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect1020ui_story == nil then
				arg_274_1.var_.characterEffect1020ui_story = var_277_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_11 = 0.200000002980232

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_11 and not isNil(var_277_9) then
				local var_277_12 = (arg_274_1.time_ - var_277_10) / var_277_11

				if arg_274_1.var_.characterEffect1020ui_story and not isNil(var_277_9) then
					arg_274_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_10 + var_277_11 and arg_274_1.time_ < var_277_10 + var_277_11 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect1020ui_story then
				arg_274_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_277_13 = 0

			if var_277_13 < arg_274_1.time_ and arg_274_1.time_ <= var_277_13 + arg_277_0 then
				arg_274_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_277_14 = 0

			if var_277_14 < arg_274_1.time_ and arg_274_1.time_ <= var_277_14 + arg_277_0 then
				arg_274_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_277_15 = 0
			local var_277_16 = 0.3

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				local var_277_17 = "play"
				local var_277_18 = "music"

				arg_274_1:AudioAction(var_277_17, var_277_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_277_19 = ""
				local var_277_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_277_20 ~= "" then
					if arg_274_1.bgmTxt_.text ~= var_277_20 and arg_274_1.bgmTxt_.text ~= "" then
						if arg_274_1.bgmTxt2_.text ~= "" then
							arg_274_1.bgmTxt_.text = arg_274_1.bgmTxt2_.text
						end

						arg_274_1.bgmTxt2_.text = var_277_20

						arg_274_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_274_1.bgmTxt_.text = var_277_20
						arg_274_1.bgmTxt2_.text = var_277_20
					end

					if arg_274_1.bgmTimer then
						arg_274_1.bgmTimer:Stop()

						arg_274_1.bgmTimer = nil
					end

					if arg_274_1.settingData.show_music_name == 1 then
						arg_274_1.musicController:SetSelectedState("show")
						arg_274_1.musicAnimator_:Play("open", 0, 0)

						if arg_274_1.settingData.music_time ~= 0 then
							arg_274_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_274_1.settingData.music_time), function()
								if arg_274_1 == nil or isNil(arg_274_1.bgmTxt_) then
									return
								end

								arg_274_1.musicController:SetSelectedState("hide")
								arg_274_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_277_21 = 0
			local var_277_22 = 0.1

			if var_277_21 < arg_274_1.time_ and arg_274_1.time_ <= var_277_21 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_23 = arg_274_1:FormatText(StoryNameCfg[613].name)

				arg_274_1.leftNameTxt_.text = var_277_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_24 = arg_274_1:GetWordFromCfg(322251078)
				local var_277_25 = arg_274_1:FormatText(var_277_24.content)

				arg_274_1.text_.text = var_277_25

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_26 = 4
				local var_277_27 = utf8.len(var_277_25)
				local var_277_28 = var_277_26 <= 0 and var_277_22 or var_277_22 * (var_277_27 / var_277_26)

				if var_277_28 > 0 and var_277_22 < var_277_28 then
					arg_274_1.talkMaxDuration = var_277_28

					if var_277_28 + var_277_21 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_28 + var_277_21
					end
				end

				arg_274_1.text_.text = var_277_25
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251078", "story_v_out_322251.awb") ~= 0 then
					local var_277_29 = manager.audio:GetVoiceLength("story_v_out_322251", "322251078", "story_v_out_322251.awb") / 1000

					if var_277_29 + var_277_21 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_29 + var_277_21
					end

					if var_277_24.prefab_name ~= "" and arg_274_1.actors_[var_277_24.prefab_name] ~= nil then
						local var_277_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_24.prefab_name].transform, "story_v_out_322251", "322251078", "story_v_out_322251.awb")

						arg_274_1:RecordAudio("322251078", var_277_30)
						arg_274_1:RecordAudio("322251078", var_277_30)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_322251", "322251078", "story_v_out_322251.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_322251", "322251078", "story_v_out_322251.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_31 = math.max(var_277_22, arg_274_1.talkMaxDuration)

			if var_277_21 <= arg_274_1.time_ and arg_274_1.time_ < var_277_21 + var_277_31 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_21) / var_277_31

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_21 + var_277_31 and arg_274_1.time_ < var_277_21 + var_277_31 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play322251079 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 322251079
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play322251080(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1020ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1020ui_story == nil then
				arg_279_1.var_.characterEffect1020ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect1020ui_story and not isNil(var_282_0) then
					local var_282_4 = Mathf.Lerp(0, 0.5, var_282_3)

					arg_279_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1020ui_story.fillRatio = var_282_4
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1020ui_story then
				local var_282_5 = 0.5

				arg_279_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1020ui_story.fillRatio = var_282_5
			end

			local var_282_6 = 0
			local var_282_7 = 0.45

			if var_282_6 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_8 = arg_279_1:FormatText(StoryNameCfg[7].name)

				arg_279_1.leftNameTxt_.text = var_282_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_9 = arg_279_1:GetWordFromCfg(322251079)
				local var_282_10 = arg_279_1:FormatText(var_282_9.content)

				arg_279_1.text_.text = var_282_10

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 18
				local var_282_12 = utf8.len(var_282_10)
				local var_282_13 = var_282_11 <= 0 and var_282_7 or var_282_7 * (var_282_12 / var_282_11)

				if var_282_13 > 0 and var_282_7 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_6
					end
				end

				arg_279_1.text_.text = var_282_10
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_14 = math.max(var_282_7, arg_279_1.talkMaxDuration)

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_14 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_6) / var_282_14

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_6 + var_282_14 and arg_279_1.time_ < var_282_6 + var_282_14 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play322251080 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 322251080
		arg_283_1.duration_ = 5.3

		local var_283_0 = {
			zh = 4.366,
			ja = 5.3
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play322251081(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1020ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1020ui_story == nil then
				arg_283_1.var_.characterEffect1020ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1020ui_story and not isNil(var_286_0) then
					arg_283_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1020ui_story then
				arg_283_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_286_4 = 0

			if var_286_4 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_286_5 = 0

			if var_286_5 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_286_6 = 0
			local var_286_7 = 0.45

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_8 = arg_283_1:FormatText(StoryNameCfg[613].name)

				arg_283_1.leftNameTxt_.text = var_286_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_9 = arg_283_1:GetWordFromCfg(322251080)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 18
				local var_286_12 = utf8.len(var_286_10)
				local var_286_13 = var_286_11 <= 0 and var_286_7 or var_286_7 * (var_286_12 / var_286_11)

				if var_286_13 > 0 and var_286_7 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251080", "story_v_out_322251.awb") ~= 0 then
					local var_286_14 = manager.audio:GetVoiceLength("story_v_out_322251", "322251080", "story_v_out_322251.awb") / 1000

					if var_286_14 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_6
					end

					if var_286_9.prefab_name ~= "" and arg_283_1.actors_[var_286_9.prefab_name] ~= nil then
						local var_286_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_9.prefab_name].transform, "story_v_out_322251", "322251080", "story_v_out_322251.awb")

						arg_283_1:RecordAudio("322251080", var_286_15)
						arg_283_1:RecordAudio("322251080", var_286_15)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_322251", "322251080", "story_v_out_322251.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_322251", "322251080", "story_v_out_322251.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_16 and arg_283_1.time_ < var_286_6 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play322251081 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 322251081
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play322251082(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1020ui_story"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1020ui_story == nil then
				arg_287_1.var_.characterEffect1020ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.characterEffect1020ui_story and not isNil(var_290_0) then
					local var_290_4 = Mathf.Lerp(0, 0.5, var_290_3)

					arg_287_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1020ui_story.fillRatio = var_290_4
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect1020ui_story then
				local var_290_5 = 0.5

				arg_287_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1020ui_story.fillRatio = var_290_5
			end

			local var_290_6 = 0
			local var_290_7 = 0.55

			if var_290_6 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_8 = arg_287_1:FormatText(StoryNameCfg[7].name)

				arg_287_1.leftNameTxt_.text = var_290_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_9 = arg_287_1:GetWordFromCfg(322251081)
				local var_290_10 = arg_287_1:FormatText(var_290_9.content)

				arg_287_1.text_.text = var_290_10

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_11 = 22
				local var_290_12 = utf8.len(var_290_10)
				local var_290_13 = var_290_11 <= 0 and var_290_7 or var_290_7 * (var_290_12 / var_290_11)

				if var_290_13 > 0 and var_290_7 < var_290_13 then
					arg_287_1.talkMaxDuration = var_290_13

					if var_290_13 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_6
					end
				end

				arg_287_1.text_.text = var_290_10
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_14 = math.max(var_290_7, arg_287_1.talkMaxDuration)

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_14 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_6) / var_290_14

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_6 + var_290_14 and arg_287_1.time_ < var_290_6 + var_290_14 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play322251082 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 322251082
		arg_291_1.duration_ = 6.37

		local var_291_0 = {
			zh = 4,
			ja = 6.366
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play322251083(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1020ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1020ui_story == nil then
				arg_291_1.var_.characterEffect1020ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1020ui_story and not isNil(var_294_0) then
					arg_291_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1020ui_story then
				arg_291_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_294_4 = 0

			if var_294_4 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_294_5 = 0
			local var_294_6 = 0.3

			if var_294_5 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 then
				local var_294_7 = "play"
				local var_294_8 = "music"

				arg_291_1:AudioAction(var_294_7, var_294_8, "ui_battle", "ui_battle_stopbgm", "")

				local var_294_9 = ""
				local var_294_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_294_10 ~= "" then
					if arg_291_1.bgmTxt_.text ~= var_294_10 and arg_291_1.bgmTxt_.text ~= "" then
						if arg_291_1.bgmTxt2_.text ~= "" then
							arg_291_1.bgmTxt_.text = arg_291_1.bgmTxt2_.text
						end

						arg_291_1.bgmTxt2_.text = var_294_10

						arg_291_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_291_1.bgmTxt_.text = var_294_10
						arg_291_1.bgmTxt2_.text = var_294_10
					end

					if arg_291_1.bgmTimer then
						arg_291_1.bgmTimer:Stop()

						arg_291_1.bgmTimer = nil
					end

					if arg_291_1.settingData.show_music_name == 1 then
						arg_291_1.musicController:SetSelectedState("show")
						arg_291_1.musicAnimator_:Play("open", 0, 0)

						if arg_291_1.settingData.music_time ~= 0 then
							arg_291_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_291_1.settingData.music_time), function()
								if arg_291_1 == nil or isNil(arg_291_1.bgmTxt_) then
									return
								end

								arg_291_1.musicController:SetSelectedState("hide")
								arg_291_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_294_11 = 0
			local var_294_12 = 0.375

			if var_294_11 < arg_291_1.time_ and arg_291_1.time_ <= var_294_11 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_13 = arg_291_1:FormatText(StoryNameCfg[613].name)

				arg_291_1.leftNameTxt_.text = var_294_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_14 = arg_291_1:GetWordFromCfg(322251082)
				local var_294_15 = arg_291_1:FormatText(var_294_14.content)

				arg_291_1.text_.text = var_294_15

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_16 = 15
				local var_294_17 = utf8.len(var_294_15)
				local var_294_18 = var_294_16 <= 0 and var_294_12 or var_294_12 * (var_294_17 / var_294_16)

				if var_294_18 > 0 and var_294_12 < var_294_18 then
					arg_291_1.talkMaxDuration = var_294_18

					if var_294_18 + var_294_11 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_18 + var_294_11
					end
				end

				arg_291_1.text_.text = var_294_15
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251082", "story_v_out_322251.awb") ~= 0 then
					local var_294_19 = manager.audio:GetVoiceLength("story_v_out_322251", "322251082", "story_v_out_322251.awb") / 1000

					if var_294_19 + var_294_11 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_19 + var_294_11
					end

					if var_294_14.prefab_name ~= "" and arg_291_1.actors_[var_294_14.prefab_name] ~= nil then
						local var_294_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_14.prefab_name].transform, "story_v_out_322251", "322251082", "story_v_out_322251.awb")

						arg_291_1:RecordAudio("322251082", var_294_20)
						arg_291_1:RecordAudio("322251082", var_294_20)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_322251", "322251082", "story_v_out_322251.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_322251", "322251082", "story_v_out_322251.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_21 = math.max(var_294_12, arg_291_1.talkMaxDuration)

			if var_294_11 <= arg_291_1.time_ and arg_291_1.time_ < var_294_11 + var_294_21 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_11) / var_294_21

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_11 + var_294_21 and arg_291_1.time_ < var_294_11 + var_294_21 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play322251083 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 322251083
		arg_296_1.duration_ = 7.97

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play322251084(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 4

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			local var_299_1 = 3.2

			if arg_296_1.time_ >= var_299_0 + var_299_1 and arg_296_1.time_ < var_299_0 + var_299_1 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end

			local var_299_2 = 2

			if var_299_2 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 then
				local var_299_3 = manager.ui.mainCamera.transform.localPosition
				local var_299_4 = Vector3.New(0, 0, 10) + Vector3.New(var_299_3.x, var_299_3.y, 0)
				local var_299_5 = arg_296_1.bgs_.STblack

				var_299_5.transform.localPosition = var_299_4
				var_299_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_299_6 = var_299_5:GetComponent("SpriteRenderer")

				if var_299_6 and var_299_6.sprite then
					local var_299_7 = (var_299_5.transform.localPosition - var_299_3).z
					local var_299_8 = manager.ui.mainCameraCom_
					local var_299_9 = 2 * var_299_7 * Mathf.Tan(var_299_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_299_10 = var_299_9 * var_299_8.aspect
					local var_299_11 = var_299_6.sprite.bounds.size.x
					local var_299_12 = var_299_6.sprite.bounds.size.y
					local var_299_13 = var_299_10 / var_299_11
					local var_299_14 = var_299_9 / var_299_12
					local var_299_15 = var_299_14 < var_299_13 and var_299_13 or var_299_14

					var_299_5.transform.localScale = Vector3.New(var_299_15, var_299_15, 0)
				end

				for iter_299_0, iter_299_1 in pairs(arg_296_1.bgs_) do
					if iter_299_0 ~= "STblack" then
						iter_299_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_299_16 = 0

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_17 = 2

			if var_299_16 <= arg_296_1.time_ and arg_296_1.time_ < var_299_16 + var_299_17 then
				local var_299_18 = (arg_296_1.time_ - var_299_16) / var_299_17
				local var_299_19 = Color.New(0, 0, 0)

				var_299_19.a = Mathf.Lerp(0, 1, var_299_18)
				arg_296_1.mask_.color = var_299_19
			end

			if arg_296_1.time_ >= var_299_16 + var_299_17 and arg_296_1.time_ < var_299_16 + var_299_17 + arg_299_0 then
				local var_299_20 = Color.New(0, 0, 0)

				var_299_20.a = 1
				arg_296_1.mask_.color = var_299_20
			end

			local var_299_21 = 2

			if var_299_21 < arg_296_1.time_ and arg_296_1.time_ <= var_299_21 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_22 = 2

			if var_299_21 <= arg_296_1.time_ and arg_296_1.time_ < var_299_21 + var_299_22 then
				local var_299_23 = (arg_296_1.time_ - var_299_21) / var_299_22
				local var_299_24 = Color.New(0, 0, 0)

				var_299_24.a = Mathf.Lerp(1, 0, var_299_23)
				arg_296_1.mask_.color = var_299_24
			end

			if arg_296_1.time_ >= var_299_21 + var_299_22 and arg_296_1.time_ < var_299_21 + var_299_22 + arg_299_0 then
				local var_299_25 = Color.New(0, 0, 0)
				local var_299_26 = 0

				arg_296_1.mask_.enabled = false
				var_299_25.a = var_299_26
				arg_296_1.mask_.color = var_299_25
			end

			local var_299_27 = arg_296_1.actors_["1020ui_story"].transform
			local var_299_28 = 2

			if var_299_28 < arg_296_1.time_ and arg_296_1.time_ <= var_299_28 + arg_299_0 then
				arg_296_1.var_.moveOldPos1020ui_story = var_299_27.localPosition
			end

			local var_299_29 = 0.001

			if var_299_28 <= arg_296_1.time_ and arg_296_1.time_ < var_299_28 + var_299_29 then
				local var_299_30 = (arg_296_1.time_ - var_299_28) / var_299_29
				local var_299_31 = Vector3.New(0, 100, 0)

				var_299_27.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1020ui_story, var_299_31, var_299_30)

				local var_299_32 = manager.ui.mainCamera.transform.position - var_299_27.position

				var_299_27.forward = Vector3.New(var_299_32.x, var_299_32.y, var_299_32.z)

				local var_299_33 = var_299_27.localEulerAngles

				var_299_33.z = 0
				var_299_33.x = 0
				var_299_27.localEulerAngles = var_299_33
			end

			if arg_296_1.time_ >= var_299_28 + var_299_29 and arg_296_1.time_ < var_299_28 + var_299_29 + arg_299_0 then
				var_299_27.localPosition = Vector3.New(0, 100, 0)

				local var_299_34 = manager.ui.mainCamera.transform.position - var_299_27.position

				var_299_27.forward = Vector3.New(var_299_34.x, var_299_34.y, var_299_34.z)

				local var_299_35 = var_299_27.localEulerAngles

				var_299_35.z = 0
				var_299_35.x = 0
				var_299_27.localEulerAngles = var_299_35
			end

			local var_299_36 = 4.86666666666667
			local var_299_37 = 1

			if var_299_36 < arg_296_1.time_ and arg_296_1.time_ <= var_299_36 + arg_299_0 then
				local var_299_38 = "play"
				local var_299_39 = "effect"

				arg_296_1:AudioAction(var_299_38, var_299_39, "se_story_140", "se_story_140_foley_down", "")
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = false,
				enableEffect = false,
				className = "StoryTextGroupNode",
				contentID = 102,
				charCount = 0,
				enableLayoutChange = false,
				duration = 1.23333333333333,
				groupID = "1083",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322251083,
				charCount = 55,
				enableLayoutChange = true,
				duration = 3.66666666666667,
				groupID = "10831",
				startTime = 3.23333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play322251084 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 322251084
		arg_300_1.duration_ = 5.1

		local var_300_0 = {
			zh = 5.1,
			ja = 4.149999999999
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play322251085(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 3

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.allBtn_.enabled = false
			end

			local var_303_1 = 0.15

			if arg_300_1.time_ >= var_303_0 + var_303_1 and arg_300_1.time_ < var_303_0 + var_303_1 + arg_303_0 then
				arg_300_1.allBtn_.enabled = true
			end

			local var_303_2 = "MS2207"

			if arg_300_1.bgs_[var_303_2] == nil then
				local var_303_3 = Object.Instantiate(arg_300_1.paintGo_)

				var_303_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_303_2)
				var_303_3.name = var_303_2
				var_303_3.transform.parent = arg_300_1.stage_.transform
				var_303_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_300_1.bgs_[var_303_2] = var_303_3
			end

			local var_303_4 = 1

			if var_303_4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				local var_303_5 = manager.ui.mainCamera.transform.localPosition
				local var_303_6 = Vector3.New(0, 0, 10) + Vector3.New(var_303_5.x, var_303_5.y, 0)
				local var_303_7 = arg_300_1.bgs_.MS2207

				var_303_7.transform.localPosition = var_303_6
				var_303_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_303_8 = var_303_7:GetComponent("SpriteRenderer")

				if var_303_8 and var_303_8.sprite then
					local var_303_9 = (var_303_7.transform.localPosition - var_303_5).z
					local var_303_10 = manager.ui.mainCameraCom_
					local var_303_11 = 2 * var_303_9 * Mathf.Tan(var_303_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_303_12 = var_303_11 * var_303_10.aspect
					local var_303_13 = var_303_8.sprite.bounds.size.x
					local var_303_14 = var_303_8.sprite.bounds.size.y
					local var_303_15 = var_303_12 / var_303_13
					local var_303_16 = var_303_11 / var_303_14
					local var_303_17 = var_303_16 < var_303_15 and var_303_15 or var_303_16

					var_303_7.transform.localScale = Vector3.New(var_303_17, var_303_17, 0)
				end

				for iter_303_0, iter_303_1 in pairs(arg_300_1.bgs_) do
					if iter_303_0 ~= "MS2207" then
						iter_303_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_303_18 = 0

			if var_303_18 < arg_300_1.time_ and arg_300_1.time_ <= var_303_18 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_19 = 1

			if var_303_18 <= arg_300_1.time_ and arg_300_1.time_ < var_303_18 + var_303_19 then
				local var_303_20 = (arg_300_1.time_ - var_303_18) / var_303_19
				local var_303_21 = Color.New(0, 0, 0)

				var_303_21.a = Mathf.Lerp(0, 1, var_303_20)
				arg_300_1.mask_.color = var_303_21
			end

			if arg_300_1.time_ >= var_303_18 + var_303_19 and arg_300_1.time_ < var_303_18 + var_303_19 + arg_303_0 then
				local var_303_22 = Color.New(0, 0, 0)

				var_303_22.a = 1
				arg_300_1.mask_.color = var_303_22
			end

			local var_303_23 = 1

			if var_303_23 < arg_300_1.time_ and arg_300_1.time_ <= var_303_23 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_24 = 2

			if var_303_23 <= arg_300_1.time_ and arg_300_1.time_ < var_303_23 + var_303_24 then
				local var_303_25 = (arg_300_1.time_ - var_303_23) / var_303_24
				local var_303_26 = Color.New(0, 0, 0)

				var_303_26.a = Mathf.Lerp(1, 0, var_303_25)
				arg_300_1.mask_.color = var_303_26
			end

			if arg_300_1.time_ >= var_303_23 + var_303_24 and arg_300_1.time_ < var_303_23 + var_303_24 + arg_303_0 then
				local var_303_27 = Color.New(0, 0, 0)
				local var_303_28 = 0

				arg_300_1.mask_.enabled = false
				var_303_27.a = var_303_28
				arg_300_1.mask_.color = var_303_27
			end

			local var_303_29 = arg_300_1.actors_["1020ui_story"]
			local var_303_30 = 0.833333330353101

			if var_303_30 < arg_300_1.time_ and arg_300_1.time_ <= var_303_30 + arg_303_0 and not isNil(var_303_29) and arg_300_1.var_.characterEffect1020ui_story == nil then
				arg_300_1.var_.characterEffect1020ui_story = var_303_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_31 = 0.200000002980232

			if var_303_30 <= arg_300_1.time_ and arg_300_1.time_ < var_303_30 + var_303_31 and not isNil(var_303_29) then
				local var_303_32 = (arg_300_1.time_ - var_303_30) / var_303_31

				if arg_300_1.var_.characterEffect1020ui_story and not isNil(var_303_29) then
					arg_300_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_30 + var_303_31 and arg_300_1.time_ < var_303_30 + var_303_31 + arg_303_0 and not isNil(var_303_29) and arg_300_1.var_.characterEffect1020ui_story then
				arg_300_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_33 = 3
			local var_303_34 = 0.15

			if var_303_33 < arg_300_1.time_ and arg_300_1.time_ <= var_303_33 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_35 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_35:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_36 = arg_300_1:FormatText(StoryNameCfg[613].name)

				arg_300_1.leftNameTxt_.text = var_303_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_37 = arg_300_1:GetWordFromCfg(322251084)
				local var_303_38 = arg_300_1:FormatText(var_303_37.content)

				arg_300_1.text_.text = var_303_38

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_39 = 6
				local var_303_40 = utf8.len(var_303_38)
				local var_303_41 = var_303_39 <= 0 and var_303_34 or var_303_34 * (var_303_40 / var_303_39)

				if var_303_41 > 0 and var_303_34 < var_303_41 then
					arg_300_1.talkMaxDuration = var_303_41
					var_303_33 = var_303_33 + 0.3

					if var_303_41 + var_303_33 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_41 + var_303_33
					end
				end

				arg_300_1.text_.text = var_303_38
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251084", "story_v_out_322251.awb") ~= 0 then
					local var_303_42 = manager.audio:GetVoiceLength("story_v_out_322251", "322251084", "story_v_out_322251.awb") / 1000

					if var_303_42 + var_303_33 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_42 + var_303_33
					end

					if var_303_37.prefab_name ~= "" and arg_300_1.actors_[var_303_37.prefab_name] ~= nil then
						local var_303_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_37.prefab_name].transform, "story_v_out_322251", "322251084", "story_v_out_322251.awb")

						arg_300_1:RecordAudio("322251084", var_303_43)
						arg_300_1:RecordAudio("322251084", var_303_43)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_322251", "322251084", "story_v_out_322251.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_322251", "322251084", "story_v_out_322251.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_44 = var_303_33 + 0.3
			local var_303_45 = math.max(var_303_34, arg_300_1.talkMaxDuration)

			if var_303_44 <= arg_300_1.time_ and arg_300_1.time_ < var_303_44 + var_303_45 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_44) / var_303_45

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_44 + var_303_45 and arg_300_1.time_ < var_303_44 + var_303_45 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				groupID = "1083",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "10831",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play322251085 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 322251085
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play322251086(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 0.3

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				local var_309_2 = "play"
				local var_309_3 = "music"

				arg_306_1:AudioAction(var_309_2, var_309_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_309_4 = ""
				local var_309_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_309_5 ~= "" then
					if arg_306_1.bgmTxt_.text ~= var_309_5 and arg_306_1.bgmTxt_.text ~= "" then
						if arg_306_1.bgmTxt2_.text ~= "" then
							arg_306_1.bgmTxt_.text = arg_306_1.bgmTxt2_.text
						end

						arg_306_1.bgmTxt2_.text = var_309_5

						arg_306_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_306_1.bgmTxt_.text = var_309_5
						arg_306_1.bgmTxt2_.text = var_309_5
					end

					if arg_306_1.bgmTimer then
						arg_306_1.bgmTimer:Stop()

						arg_306_1.bgmTimer = nil
					end

					if arg_306_1.settingData.show_music_name == 1 then
						arg_306_1.musicController:SetSelectedState("show")
						arg_306_1.musicAnimator_:Play("open", 0, 0)

						if arg_306_1.settingData.music_time ~= 0 then
							arg_306_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_306_1.settingData.music_time), function()
								if arg_306_1 == nil or isNil(arg_306_1.bgmTxt_) then
									return
								end

								arg_306_1.musicController:SetSelectedState("hide")
								arg_306_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_309_6 = 0.3
			local var_309_7 = 1

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				local var_309_8 = "play"
				local var_309_9 = "music"

				arg_306_1:AudioAction(var_309_8, var_309_9, "bgm_story_sad_1", "bgm_story_sad_1", "bgm_story_sad_1.awb")

				local var_309_10 = ""
				local var_309_11 = manager.audio:GetAudioName("bgm_story_sad_1", "bgm_story_sad_1")

				if var_309_11 ~= "" then
					if arg_306_1.bgmTxt_.text ~= var_309_11 and arg_306_1.bgmTxt_.text ~= "" then
						if arg_306_1.bgmTxt2_.text ~= "" then
							arg_306_1.bgmTxt_.text = arg_306_1.bgmTxt2_.text
						end

						arg_306_1.bgmTxt2_.text = var_309_11

						arg_306_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_306_1.bgmTxt_.text = var_309_11
						arg_306_1.bgmTxt2_.text = var_309_11
					end

					if arg_306_1.bgmTimer then
						arg_306_1.bgmTimer:Stop()

						arg_306_1.bgmTimer = nil
					end

					if arg_306_1.settingData.show_music_name == 1 then
						arg_306_1.musicController:SetSelectedState("show")
						arg_306_1.musicAnimator_:Play("open", 0, 0)

						if arg_306_1.settingData.music_time ~= 0 then
							arg_306_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_306_1.settingData.music_time), function()
								if arg_306_1 == nil or isNil(arg_306_1.bgmTxt_) then
									return
								end

								arg_306_1.musicController:SetSelectedState("hide")
								arg_306_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_309_12 = 0
			local var_309_13 = 1.075

			if var_309_12 < arg_306_1.time_ and arg_306_1.time_ <= var_309_12 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_14 = arg_306_1:GetWordFromCfg(322251085)
				local var_309_15 = arg_306_1:FormatText(var_309_14.content)

				arg_306_1.text_.text = var_309_15

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_16 = 43
				local var_309_17 = utf8.len(var_309_15)
				local var_309_18 = var_309_16 <= 0 and var_309_13 or var_309_13 * (var_309_17 / var_309_16)

				if var_309_18 > 0 and var_309_13 < var_309_18 then
					arg_306_1.talkMaxDuration = var_309_18

					if var_309_18 + var_309_12 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_18 + var_309_12
					end
				end

				arg_306_1.text_.text = var_309_15
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_19 = math.max(var_309_13, arg_306_1.talkMaxDuration)

			if var_309_12 <= arg_306_1.time_ and arg_306_1.time_ < var_309_12 + var_309_19 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_12) / var_309_19

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_12 + var_309_19 and arg_306_1.time_ < var_309_12 + var_309_19 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play322251086 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 322251086
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play322251087(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 1.35

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_2 = arg_312_1:GetWordFromCfg(322251086)
				local var_315_3 = arg_312_1:FormatText(var_315_2.content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 54
				local var_315_5 = utf8.len(var_315_3)
				local var_315_6 = var_315_4 <= 0 and var_315_1 or var_315_1 * (var_315_5 / var_315_4)

				if var_315_6 > 0 and var_315_1 < var_315_6 then
					arg_312_1.talkMaxDuration = var_315_6

					if var_315_6 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_6 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_3
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_7 and arg_312_1.time_ < var_315_0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play322251087 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 322251087
		arg_316_1.duration_ = 7.6

		local var_316_0 = {
			zh = 5.83333333333333,
			ja = 7.59933333333333
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play322251088(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.bgs_.MS2207.transform
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.var_.moveOldPosMS2207 = var_319_0.localPosition
			end

			local var_319_2 = 3.03333333333333

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2
				local var_319_4 = Vector3.New(0.5, 1, 8)

				var_319_0.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPosMS2207, var_319_4, var_319_3)
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 then
				var_319_0.localPosition = Vector3.New(0.5, 1, 8)
			end

			if arg_316_1.frameCnt_ <= 1 then
				arg_316_1.dialog_:SetActive(false)
			end

			local var_319_5 = 3.03333333333333
			local var_319_6 = 0.425

			if var_319_5 < arg_316_1.time_ and arg_316_1.time_ <= var_319_5 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0

				arg_316_1.dialog_:SetActive(true)

				arg_316_1.dialogCg_.alpha = 0

				local var_319_7 = LeanTween.value(arg_316_1.dialog_, 0, 1, 0.3)

				var_319_7:setOnUpdate(LuaHelper.FloatAction(function(arg_320_0)
					arg_316_1.dialogCg_.alpha = arg_320_0
				end))
				var_319_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_316_1.dialog_)
					var_319_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_316_1.duration_ = arg_316_1.duration_ + 0.3

				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_8 = arg_316_1:FormatText(StoryNameCfg[613].name)

				arg_316_1.leftNameTxt_.text = var_319_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_9 = arg_316_1:GetWordFromCfg(322251087)
				local var_319_10 = arg_316_1:FormatText(var_319_9.content)

				arg_316_1.text_.text = var_319_10

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_11 = 17
				local var_319_12 = utf8.len(var_319_10)
				local var_319_13 = var_319_11 <= 0 and var_319_6 or var_319_6 * (var_319_12 / var_319_11)

				if var_319_13 > 0 and var_319_6 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13
					var_319_5 = var_319_5 + 0.3

					if var_319_13 + var_319_5 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_5
					end
				end

				arg_316_1.text_.text = var_319_10
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251087", "story_v_out_322251.awb") ~= 0 then
					local var_319_14 = manager.audio:GetVoiceLength("story_v_out_322251", "322251087", "story_v_out_322251.awb") / 1000

					if var_319_14 + var_319_5 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_14 + var_319_5
					end

					if var_319_9.prefab_name ~= "" and arg_316_1.actors_[var_319_9.prefab_name] ~= nil then
						local var_319_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_9.prefab_name].transform, "story_v_out_322251", "322251087", "story_v_out_322251.awb")

						arg_316_1:RecordAudio("322251087", var_319_15)
						arg_316_1:RecordAudio("322251087", var_319_15)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_322251", "322251087", "story_v_out_322251.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_322251", "322251087", "story_v_out_322251.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = var_319_5 + 0.3
			local var_319_17 = math.max(var_319_6, arg_316_1.talkMaxDuration)

			if var_319_16 <= arg_316_1.time_ and arg_316_1.time_ < var_319_16 + var_319_17 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_16) / var_319_17

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_16 + var_319_17 and arg_316_1.time_ < var_319_16 + var_319_17 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2207",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.03333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0.5, 1, 8),
					easeType = LeanTweenType.easeInOutQuart
				}
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play322251088 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 322251088
		arg_322_1.duration_ = 7.7

		local var_322_0 = {
			zh = 4.7,
			ja = 7.7
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play322251089(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.375

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[613].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_3 = arg_322_1:GetWordFromCfg(322251088)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 15
				local var_325_6 = utf8.len(var_325_4)
				local var_325_7 = var_325_5 <= 0 and var_325_1 or var_325_1 * (var_325_6 / var_325_5)

				if var_325_7 > 0 and var_325_1 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251088", "story_v_out_322251.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251088", "story_v_out_322251.awb") / 1000

					if var_325_8 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_0
					end

					if var_325_3.prefab_name ~= "" and arg_322_1.actors_[var_325_3.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_3.prefab_name].transform, "story_v_out_322251", "322251088", "story_v_out_322251.awb")

						arg_322_1:RecordAudio("322251088", var_325_9)
						arg_322_1:RecordAudio("322251088", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_322251", "322251088", "story_v_out_322251.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_322251", "322251088", "story_v_out_322251.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_10 and arg_322_1.time_ < var_325_0 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play322251089 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 322251089
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play322251090(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.35

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[7].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_3 = arg_326_1:GetWordFromCfg(322251089)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 14
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_8 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_8 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_8

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_8 and arg_326_1.time_ < var_329_0 + var_329_8 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play322251090 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 322251090
		arg_330_1.duration_ = 7.17

		local var_330_0 = {
			zh = 6.033,
			ja = 7.166
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play322251091(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.525

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[613].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:GetWordFromCfg(322251090)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 21
				local var_333_6 = utf8.len(var_333_4)
				local var_333_7 = var_333_5 <= 0 and var_333_1 or var_333_1 * (var_333_6 / var_333_5)

				if var_333_7 > 0 and var_333_1 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251090", "story_v_out_322251.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251090", "story_v_out_322251.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_out_322251", "322251090", "story_v_out_322251.awb")

						arg_330_1:RecordAudio("322251090", var_333_9)
						arg_330_1:RecordAudio("322251090", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_322251", "322251090", "story_v_out_322251.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_322251", "322251090", "story_v_out_322251.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_10 and arg_330_1.time_ < var_333_0 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play322251091 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 322251091
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play322251092(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.125

			if var_337_0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_2 = arg_334_1:FormatText(StoryNameCfg[7].name)

				arg_334_1.leftNameTxt_.text = var_337_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_3 = arg_334_1:GetWordFromCfg(322251091)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 5
				local var_337_6 = utf8.len(var_337_4)
				local var_337_7 = var_337_5 <= 0 and var_337_1 or var_337_1 * (var_337_6 / var_337_5)

				if var_337_7 > 0 and var_337_1 < var_337_7 then
					arg_334_1.talkMaxDuration = var_337_7

					if var_337_7 + var_337_0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_0
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_8 = math.max(var_337_1, arg_334_1.talkMaxDuration)

			if var_337_0 <= arg_334_1.time_ and arg_334_1.time_ < var_337_0 + var_337_8 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_0) / var_337_8

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_0 + var_337_8 and arg_334_1.time_ < var_337_0 + var_337_8 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play322251092 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 322251092
		arg_338_1.duration_ = 11.6

		local var_338_0 = {
			zh = 9.333,
			ja = 11.6
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play322251093(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 1.125

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_2 = arg_338_1:FormatText(StoryNameCfg[613].name)

				arg_338_1.leftNameTxt_.text = var_341_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_3 = arg_338_1:GetWordFromCfg(322251092)
				local var_341_4 = arg_338_1:FormatText(var_341_3.content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 45
				local var_341_6 = utf8.len(var_341_4)
				local var_341_7 = var_341_5 <= 0 and var_341_1 or var_341_1 * (var_341_6 / var_341_5)

				if var_341_7 > 0 and var_341_1 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251092", "story_v_out_322251.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251092", "story_v_out_322251.awb") / 1000

					if var_341_8 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_0
					end

					if var_341_3.prefab_name ~= "" and arg_338_1.actors_[var_341_3.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_3.prefab_name].transform, "story_v_out_322251", "322251092", "story_v_out_322251.awb")

						arg_338_1:RecordAudio("322251092", var_341_9)
						arg_338_1:RecordAudio("322251092", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_322251", "322251092", "story_v_out_322251.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_322251", "322251092", "story_v_out_322251.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_10 and arg_338_1.time_ < var_341_0 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play322251093 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 322251093
		arg_342_1.duration_ = 12.47

		local var_342_0 = {
			zh = 12.266,
			ja = 12.466
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play322251094(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 1.175

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_2 = arg_342_1:FormatText(StoryNameCfg[613].name)

				arg_342_1.leftNameTxt_.text = var_345_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_3 = arg_342_1:GetWordFromCfg(322251093)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 47
				local var_345_6 = utf8.len(var_345_4)
				local var_345_7 = var_345_5 <= 0 and var_345_1 or var_345_1 * (var_345_6 / var_345_5)

				if var_345_7 > 0 and var_345_1 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251093", "story_v_out_322251.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251093", "story_v_out_322251.awb") / 1000

					if var_345_8 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_0
					end

					if var_345_3.prefab_name ~= "" and arg_342_1.actors_[var_345_3.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_3.prefab_name].transform, "story_v_out_322251", "322251093", "story_v_out_322251.awb")

						arg_342_1:RecordAudio("322251093", var_345_9)
						arg_342_1:RecordAudio("322251093", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_322251", "322251093", "story_v_out_322251.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_322251", "322251093", "story_v_out_322251.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_10 and arg_342_1.time_ < var_345_0 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play322251094 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 322251094
		arg_346_1.duration_ = 8.07

		local var_346_0 = {
			zh = 6.6,
			ja = 8.066
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
				arg_346_0:Play322251095(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.45

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[613].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_3 = arg_346_1:GetWordFromCfg(322251094)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 18
				local var_349_6 = utf8.len(var_349_4)
				local var_349_7 = var_349_5 <= 0 and var_349_1 or var_349_1 * (var_349_6 / var_349_5)

				if var_349_7 > 0 and var_349_1 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251094", "story_v_out_322251.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251094", "story_v_out_322251.awb") / 1000

					if var_349_8 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_0
					end

					if var_349_3.prefab_name ~= "" and arg_346_1.actors_[var_349_3.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_3.prefab_name].transform, "story_v_out_322251", "322251094", "story_v_out_322251.awb")

						arg_346_1:RecordAudio("322251094", var_349_9)
						arg_346_1:RecordAudio("322251094", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_322251", "322251094", "story_v_out_322251.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_322251", "322251094", "story_v_out_322251.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_10 and arg_346_1.time_ < var_349_0 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play322251095 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 322251095
		arg_350_1.duration_ = 9.43

		local var_350_0 = {
			zh = 6.766,
			ja = 9.433
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
				arg_350_0:Play322251096(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.475

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[613].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_3 = arg_350_1:GetWordFromCfg(322251095)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 19
				local var_353_6 = utf8.len(var_353_4)
				local var_353_7 = var_353_5 <= 0 and var_353_1 or var_353_1 * (var_353_6 / var_353_5)

				if var_353_7 > 0 and var_353_1 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_4
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251095", "story_v_out_322251.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251095", "story_v_out_322251.awb") / 1000

					if var_353_8 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_0
					end

					if var_353_3.prefab_name ~= "" and arg_350_1.actors_[var_353_3.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_3.prefab_name].transform, "story_v_out_322251", "322251095", "story_v_out_322251.awb")

						arg_350_1:RecordAudio("322251095", var_353_9)
						arg_350_1:RecordAudio("322251095", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_322251", "322251095", "story_v_out_322251.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_322251", "322251095", "story_v_out_322251.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_10 and arg_350_1.time_ < var_353_0 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play322251096 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 322251096
		arg_354_1.duration_ = 8.67

		local var_354_0 = {
			zh = 8.666,
			ja = 7.266
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play322251097(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 4

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.allBtn_.enabled = false
			end

			local var_357_1 = 0.3

			if arg_354_1.time_ >= var_357_0 + var_357_1 and arg_354_1.time_ < var_357_0 + var_357_1 + arg_357_0 then
				arg_354_1.allBtn_.enabled = true
			end

			local var_357_2 = "ST0402a"

			if arg_354_1.bgs_[var_357_2] == nil then
				local var_357_3 = Object.Instantiate(arg_354_1.paintGo_)

				var_357_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_357_2)
				var_357_3.name = var_357_2
				var_357_3.transform.parent = arg_354_1.stage_.transform
				var_357_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_354_1.bgs_[var_357_2] = var_357_3
			end

			local var_357_4 = 2

			if var_357_4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				local var_357_5 = manager.ui.mainCamera.transform.localPosition
				local var_357_6 = Vector3.New(0, 0, 10) + Vector3.New(var_357_5.x, var_357_5.y, 0)
				local var_357_7 = arg_354_1.bgs_.ST0402a

				var_357_7.transform.localPosition = var_357_6
				var_357_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_8 = var_357_7:GetComponent("SpriteRenderer")

				if var_357_8 and var_357_8.sprite then
					local var_357_9 = (var_357_7.transform.localPosition - var_357_5).z
					local var_357_10 = manager.ui.mainCameraCom_
					local var_357_11 = 2 * var_357_9 * Mathf.Tan(var_357_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_357_12 = var_357_11 * var_357_10.aspect
					local var_357_13 = var_357_8.sprite.bounds.size.x
					local var_357_14 = var_357_8.sprite.bounds.size.y
					local var_357_15 = var_357_12 / var_357_13
					local var_357_16 = var_357_11 / var_357_14
					local var_357_17 = var_357_16 < var_357_15 and var_357_15 or var_357_16

					var_357_7.transform.localScale = Vector3.New(var_357_17, var_357_17, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "ST0402a" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_357_18 = 0

			if var_357_18 < arg_354_1.time_ and arg_354_1.time_ <= var_357_18 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_19 = 2

			if var_357_18 <= arg_354_1.time_ and arg_354_1.time_ < var_357_18 + var_357_19 then
				local var_357_20 = (arg_354_1.time_ - var_357_18) / var_357_19
				local var_357_21 = Color.New(0, 0, 0)

				var_357_21.a = Mathf.Lerp(0, 1, var_357_20)
				arg_354_1.mask_.color = var_357_21
			end

			if arg_354_1.time_ >= var_357_18 + var_357_19 and arg_354_1.time_ < var_357_18 + var_357_19 + arg_357_0 then
				local var_357_22 = Color.New(0, 0, 0)

				var_357_22.a = 1
				arg_354_1.mask_.color = var_357_22
			end

			local var_357_23 = 2

			if var_357_23 < arg_354_1.time_ and arg_354_1.time_ <= var_357_23 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_24 = 2

			if var_357_23 <= arg_354_1.time_ and arg_354_1.time_ < var_357_23 + var_357_24 then
				local var_357_25 = (arg_354_1.time_ - var_357_23) / var_357_24
				local var_357_26 = Color.New(0, 0, 0)

				var_357_26.a = Mathf.Lerp(1, 0, var_357_25)
				arg_354_1.mask_.color = var_357_26
			end

			if arg_354_1.time_ >= var_357_23 + var_357_24 and arg_354_1.time_ < var_357_23 + var_357_24 + arg_357_0 then
				local var_357_27 = Color.New(0, 0, 0)
				local var_357_28 = 0

				arg_354_1.mask_.enabled = false
				var_357_27.a = var_357_28
				arg_354_1.mask_.color = var_357_27
			end

			local var_357_29 = 2

			arg_354_1.isInRecall_ = false

			if var_357_29 < arg_354_1.time_ and arg_354_1.time_ <= var_357_29 + arg_357_0 then
				arg_354_1.screenFilterGo_:SetActive(true)

				arg_354_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_357_2, iter_357_3 in pairs(arg_354_1.actors_) do
					local var_357_30 = iter_357_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_357_4, iter_357_5 in ipairs(var_357_30) do
						if iter_357_5.color.r > 0.51 then
							iter_357_5.color = Color.New(1, 1, 1)
						else
							iter_357_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_357_31 = 0.0166666666666667

			if var_357_29 <= arg_354_1.time_ and arg_354_1.time_ < var_357_29 + var_357_31 then
				local var_357_32 = (arg_354_1.time_ - var_357_29) / var_357_31

				arg_354_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_357_32)
			end

			if arg_354_1.time_ >= var_357_29 + var_357_31 and arg_354_1.time_ < var_357_29 + var_357_31 + arg_357_0 then
				arg_354_1.screenFilterEffect_.weight = 1
			end

			local var_357_33 = 0.2
			local var_357_34 = 1

			if var_357_33 < arg_354_1.time_ and arg_354_1.time_ <= var_357_33 + arg_357_0 then
				local var_357_35 = "stop"
				local var_357_36 = "effect"

				arg_354_1:AudioAction(var_357_35, var_357_36, "se_story_145", "se_story_145_amb_ST0512", "")
			end

			local var_357_37 = 1.6
			local var_357_38 = 1

			if var_357_37 < arg_354_1.time_ and arg_354_1.time_ <= var_357_37 + arg_357_0 then
				local var_357_39 = "play"
				local var_357_40 = "effect"

				arg_354_1:AudioAction(var_357_39, var_357_40, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_354_1.frameCnt_ <= 1 then
				arg_354_1.dialog_:SetActive(false)
			end

			local var_357_41 = 4
			local var_357_42 = 0.3

			if var_357_41 < arg_354_1.time_ and arg_354_1.time_ <= var_357_41 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				arg_354_1.dialog_:SetActive(true)

				arg_354_1.dialogCg_.alpha = 0

				local var_357_43 = LeanTween.value(arg_354_1.dialog_, 0, 1, 0.3)

				var_357_43:setOnUpdate(LuaHelper.FloatAction(function(arg_358_0)
					arg_354_1.dialogCg_.alpha = arg_358_0
				end))
				var_357_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_354_1.dialog_)
					var_357_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_354_1.duration_ = arg_354_1.duration_ + 0.3

				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_44 = arg_354_1:FormatText(StoryNameCfg[36].name)

				arg_354_1.leftNameTxt_.text = var_357_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1049")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_45 = arg_354_1:GetWordFromCfg(322251096)
				local var_357_46 = arg_354_1:FormatText(var_357_45.content)

				arg_354_1.text_.text = var_357_46

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_47 = 12
				local var_357_48 = utf8.len(var_357_46)
				local var_357_49 = var_357_47 <= 0 and var_357_42 or var_357_42 * (var_357_48 / var_357_47)

				if var_357_49 > 0 and var_357_42 < var_357_49 then
					arg_354_1.talkMaxDuration = var_357_49
					var_357_41 = var_357_41 + 0.3

					if var_357_49 + var_357_41 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_49 + var_357_41
					end
				end

				arg_354_1.text_.text = var_357_46
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251096", "story_v_out_322251.awb") ~= 0 then
					local var_357_50 = manager.audio:GetVoiceLength("story_v_out_322251", "322251096", "story_v_out_322251.awb") / 1000

					if var_357_50 + var_357_41 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_50 + var_357_41
					end

					if var_357_45.prefab_name ~= "" and arg_354_1.actors_[var_357_45.prefab_name] ~= nil then
						local var_357_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_45.prefab_name].transform, "story_v_out_322251", "322251096", "story_v_out_322251.awb")

						arg_354_1:RecordAudio("322251096", var_357_51)
						arg_354_1:RecordAudio("322251096", var_357_51)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_322251", "322251096", "story_v_out_322251.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_322251", "322251096", "story_v_out_322251.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_52 = var_357_41 + 0.3
			local var_357_53 = math.max(var_357_42, arg_354_1.talkMaxDuration)

			if var_357_52 <= arg_354_1.time_ and arg_354_1.time_ < var_357_52 + var_357_53 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_52) / var_357_53

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_52 + var_357_53 and arg_354_1.time_ < var_357_52 + var_357_53 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play322251097 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 322251097
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play322251098(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.0749999999999999
			local var_363_1 = 1

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				local var_363_2 = "play"
				local var_363_3 = "effect"

				arg_360_1:AudioAction(var_363_2, var_363_3, "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_363_4 = 0
			local var_363_5 = 1.075

			if var_363_4 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_6 = arg_360_1:GetWordFromCfg(322251097)
				local var_363_7 = arg_360_1:FormatText(var_363_6.content)

				arg_360_1.text_.text = var_363_7

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_8 = 43
				local var_363_9 = utf8.len(var_363_7)
				local var_363_10 = var_363_8 <= 0 and var_363_5 or var_363_5 * (var_363_9 / var_363_8)

				if var_363_10 > 0 and var_363_5 < var_363_10 then
					arg_360_1.talkMaxDuration = var_363_10

					if var_363_10 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_10 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_7
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_11 = math.max(var_363_5, arg_360_1.talkMaxDuration)

			if var_363_4 <= arg_360_1.time_ and arg_360_1.time_ < var_363_4 + var_363_11 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_4) / var_363_11

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_4 + var_363_11 and arg_360_1.time_ < var_363_4 + var_363_11 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play322251098 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 322251098
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play322251099(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.3
			local var_367_1 = 1

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				local var_367_2 = "play"
				local var_367_3 = "effect"

				arg_364_1:AudioAction(var_367_2, var_367_3, "se_story_145", "se_story_145_monster_scream02", "")
			end

			local var_367_4 = 0
			local var_367_5 = 1.3

			if var_367_4 < arg_364_1.time_ and arg_364_1.time_ <= var_367_4 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_6 = arg_364_1:GetWordFromCfg(322251098)
				local var_367_7 = arg_364_1:FormatText(var_367_6.content)

				arg_364_1.text_.text = var_367_7

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_8 = 52
				local var_367_9 = utf8.len(var_367_7)
				local var_367_10 = var_367_8 <= 0 and var_367_5 or var_367_5 * (var_367_9 / var_367_8)

				if var_367_10 > 0 and var_367_5 < var_367_10 then
					arg_364_1.talkMaxDuration = var_367_10

					if var_367_10 + var_367_4 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_10 + var_367_4
					end
				end

				arg_364_1.text_.text = var_367_7
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_11 = math.max(var_367_5, arg_364_1.talkMaxDuration)

			if var_367_4 <= arg_364_1.time_ and arg_364_1.time_ < var_367_4 + var_367_11 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_4) / var_367_11

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_4 + var_367_11 and arg_364_1.time_ < var_367_4 + var_367_11 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play322251099 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 322251099
		arg_368_1.duration_ = 1.6

		local var_368_0 = {
			zh = 1.6,
			ja = 1.1
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play322251100(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.1

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[36].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1049")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_3 = arg_368_1:GetWordFromCfg(322251099)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 4
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251099", "story_v_out_322251.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251099", "story_v_out_322251.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_322251", "322251099", "story_v_out_322251.awb")

						arg_368_1:RecordAudio("322251099", var_371_9)
						arg_368_1:RecordAudio("322251099", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_322251", "322251099", "story_v_out_322251.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_322251", "322251099", "story_v_out_322251.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_10 and arg_368_1.time_ < var_371_0 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play322251100 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 322251100
		arg_372_1.duration_ = 2

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play322251101(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = "6056ui_story"

			if arg_372_1.actors_[var_375_0] == nil then
				local var_375_1 = Asset.Load("Char/" .. "6056ui_story")

				if not isNil(var_375_1) then
					local var_375_2 = Object.Instantiate(Asset.Load("Char/" .. "6056ui_story"), arg_372_1.stage_.transform)

					var_375_2.name = var_375_0
					var_375_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_372_1.actors_[var_375_0] = var_375_2

					local var_375_3 = var_375_2:GetComponentInChildren(typeof(CharacterEffect))

					var_375_3.enabled = true

					local var_375_4 = GameObjectTools.GetOrAddComponent(var_375_2, typeof(DynamicBoneHelper))

					if var_375_4 then
						var_375_4:EnableDynamicBone(false)
					end

					arg_372_1:ShowWeapon(var_375_3.transform, false)

					arg_372_1.var_[var_375_0 .. "Animator"] = var_375_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_372_1.var_[var_375_0 .. "Animator"].applyRootMotion = true
					arg_372_1.var_[var_375_0 .. "LipSync"] = var_375_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_375_5 = arg_372_1.actors_["6056ui_story"].transform
			local var_375_6 = 0

			if var_375_6 < arg_372_1.time_ and arg_372_1.time_ <= var_375_6 + arg_375_0 then
				arg_372_1.var_.moveOldPos6056ui_story = var_375_5.localPosition
			end

			local var_375_7 = 0.001

			if var_375_6 <= arg_372_1.time_ and arg_372_1.time_ < var_375_6 + var_375_7 then
				local var_375_8 = (arg_372_1.time_ - var_375_6) / var_375_7
				local var_375_9 = Vector3.New(0.15, -1.16, -6.15)

				var_375_5.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos6056ui_story, var_375_9, var_375_8)

				local var_375_10 = manager.ui.mainCamera.transform.position - var_375_5.position

				var_375_5.forward = Vector3.New(var_375_10.x, var_375_10.y, var_375_10.z)

				local var_375_11 = var_375_5.localEulerAngles

				var_375_11.z = 0
				var_375_11.x = 0
				var_375_5.localEulerAngles = var_375_11
			end

			if arg_372_1.time_ >= var_375_6 + var_375_7 and arg_372_1.time_ < var_375_6 + var_375_7 + arg_375_0 then
				var_375_5.localPosition = Vector3.New(0.15, -1.16, -6.15)

				local var_375_12 = manager.ui.mainCamera.transform.position - var_375_5.position

				var_375_5.forward = Vector3.New(var_375_12.x, var_375_12.y, var_375_12.z)

				local var_375_13 = var_375_5.localEulerAngles

				var_375_13.z = 0
				var_375_13.x = 0
				var_375_5.localEulerAngles = var_375_13
			end

			local var_375_14 = arg_372_1.actors_["6056ui_story"]
			local var_375_15 = 0

			if var_375_15 < arg_372_1.time_ and arg_372_1.time_ <= var_375_15 + arg_375_0 and not isNil(var_375_14) and arg_372_1.var_.characterEffect6056ui_story == nil then
				arg_372_1.var_.characterEffect6056ui_story = var_375_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_16 = 0.200000002980232

			if var_375_15 <= arg_372_1.time_ and arg_372_1.time_ < var_375_15 + var_375_16 and not isNil(var_375_14) then
				local var_375_17 = (arg_372_1.time_ - var_375_15) / var_375_16

				if arg_372_1.var_.characterEffect6056ui_story and not isNil(var_375_14) then
					arg_372_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= var_375_15 + var_375_16 and arg_372_1.time_ < var_375_15 + var_375_16 + arg_375_0 and not isNil(var_375_14) and arg_372_1.var_.characterEffect6056ui_story then
				arg_372_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_375_18 = 0

			if var_375_18 < arg_372_1.time_ and arg_372_1.time_ <= var_375_18 + arg_375_0 then
				arg_372_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action1_1")
			end

			local var_375_19 = 0

			if var_375_19 < arg_372_1.time_ and arg_372_1.time_ <= var_375_19 + arg_375_0 then
				arg_372_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_375_20 = 0
			local var_375_21 = 0.125

			if var_375_20 < arg_372_1.time_ and arg_372_1.time_ <= var_375_20 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_22 = arg_372_1:FormatText(StoryNameCfg[613].name)

				arg_372_1.leftNameTxt_.text = var_375_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_23 = arg_372_1:GetWordFromCfg(322251100)
				local var_375_24 = arg_372_1:FormatText(var_375_23.content)

				arg_372_1.text_.text = var_375_24

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_25 = 5
				local var_375_26 = utf8.len(var_375_24)
				local var_375_27 = var_375_25 <= 0 and var_375_21 or var_375_21 * (var_375_26 / var_375_25)

				if var_375_27 > 0 and var_375_21 < var_375_27 then
					arg_372_1.talkMaxDuration = var_375_27

					if var_375_27 + var_375_20 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_27 + var_375_20
					end
				end

				arg_372_1.text_.text = var_375_24
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251100", "story_v_out_322251.awb") ~= 0 then
					local var_375_28 = manager.audio:GetVoiceLength("story_v_out_322251", "322251100", "story_v_out_322251.awb") / 1000

					if var_375_28 + var_375_20 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_28 + var_375_20
					end

					if var_375_23.prefab_name ~= "" and arg_372_1.actors_[var_375_23.prefab_name] ~= nil then
						local var_375_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_23.prefab_name].transform, "story_v_out_322251", "322251100", "story_v_out_322251.awb")

						arg_372_1:RecordAudio("322251100", var_375_29)
						arg_372_1:RecordAudio("322251100", var_375_29)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_322251", "322251100", "story_v_out_322251.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_322251", "322251100", "story_v_out_322251.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_30 = math.max(var_375_21, arg_372_1.talkMaxDuration)

			if var_375_20 <= arg_372_1.time_ and arg_372_1.time_ < var_375_20 + var_375_30 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_20) / var_375_30

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_20 + var_375_30 and arg_372_1.time_ < var_375_20 + var_375_30 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play322251101 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 322251101
		arg_376_1.duration_ = 4.33

		local var_376_0 = {
			zh = 4.333,
			ja = 3.2
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play322251102(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["6056ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect6056ui_story == nil then
				arg_376_1.var_.characterEffect6056ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect6056ui_story and not isNil(var_379_0) then
					local var_379_4 = Mathf.Lerp(0, 0.5, var_379_3)

					arg_376_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_376_1.var_.characterEffect6056ui_story.fillRatio = var_379_4
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect6056ui_story then
				local var_379_5 = 0.5

				arg_376_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_376_1.var_.characterEffect6056ui_story.fillRatio = var_379_5
			end

			local var_379_6 = 0
			local var_379_7 = 0.225

			if var_379_6 < arg_376_1.time_ and arg_376_1.time_ <= var_379_6 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_8 = arg_376_1:FormatText(StoryNameCfg[36].name)

				arg_376_1.leftNameTxt_.text = var_379_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1049")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_9 = arg_376_1:GetWordFromCfg(322251101)
				local var_379_10 = arg_376_1:FormatText(var_379_9.content)

				arg_376_1.text_.text = var_379_10

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_11 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251101", "story_v_out_322251.awb") ~= 0 then
					local var_379_14 = manager.audio:GetVoiceLength("story_v_out_322251", "322251101", "story_v_out_322251.awb") / 1000

					if var_379_14 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_14 + var_379_6
					end

					if var_379_9.prefab_name ~= "" and arg_376_1.actors_[var_379_9.prefab_name] ~= nil then
						local var_379_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_9.prefab_name].transform, "story_v_out_322251", "322251101", "story_v_out_322251.awb")

						arg_376_1:RecordAudio("322251101", var_379_15)
						arg_376_1:RecordAudio("322251101", var_379_15)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_322251", "322251101", "story_v_out_322251.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_322251", "322251101", "story_v_out_322251.awb")
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
	Play322251102 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 322251102
		arg_380_1.duration_ = 2.17

		local var_380_0 = {
			zh = 1.999999999999,
			ja = 2.166
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play322251103(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["6056ui_story"].transform
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.var_.moveOldPos6056ui_story = var_383_0.localPosition
			end

			local var_383_2 = 0.001

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_2 then
				local var_383_3 = (arg_380_1.time_ - var_383_1) / var_383_2
				local var_383_4 = Vector3.New(0.15, -1.16, -6.15)

				var_383_0.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos6056ui_story, var_383_4, var_383_3)

				local var_383_5 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_5.x, var_383_5.y, var_383_5.z)

				local var_383_6 = var_383_0.localEulerAngles

				var_383_6.z = 0
				var_383_6.x = 0
				var_383_0.localEulerAngles = var_383_6
			end

			if arg_380_1.time_ >= var_383_1 + var_383_2 and arg_380_1.time_ < var_383_1 + var_383_2 + arg_383_0 then
				var_383_0.localPosition = Vector3.New(0.15, -1.16, -6.15)

				local var_383_7 = manager.ui.mainCamera.transform.position - var_383_0.position

				var_383_0.forward = Vector3.New(var_383_7.x, var_383_7.y, var_383_7.z)

				local var_383_8 = var_383_0.localEulerAngles

				var_383_8.z = 0
				var_383_8.x = 0
				var_383_0.localEulerAngles = var_383_8
			end

			local var_383_9 = arg_380_1.actors_["6056ui_story"]
			local var_383_10 = 0

			if var_383_10 < arg_380_1.time_ and arg_380_1.time_ <= var_383_10 + arg_383_0 and not isNil(var_383_9) and arg_380_1.var_.characterEffect6056ui_story == nil then
				arg_380_1.var_.characterEffect6056ui_story = var_383_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_11 = 0.200000002980232

			if var_383_10 <= arg_380_1.time_ and arg_380_1.time_ < var_383_10 + var_383_11 and not isNil(var_383_9) then
				local var_383_12 = (arg_380_1.time_ - var_383_10) / var_383_11

				if arg_380_1.var_.characterEffect6056ui_story and not isNil(var_383_9) then
					arg_380_1.var_.characterEffect6056ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_10 + var_383_11 and arg_380_1.time_ < var_383_10 + var_383_11 + arg_383_0 and not isNil(var_383_9) and arg_380_1.var_.characterEffect6056ui_story then
				arg_380_1.var_.characterEffect6056ui_story.fillFlat = false
			end

			local var_383_13 = 0

			if var_383_13 < arg_380_1.time_ and arg_380_1.time_ <= var_383_13 + arg_383_0 then
				arg_380_1:PlayTimeline("6056ui_story", "StoryTimeline/CharAction/story6056/story6056action/6056action3_1")
			end

			local var_383_14 = 0
			local var_383_15 = 0.15

			if var_383_14 < arg_380_1.time_ and arg_380_1.time_ <= var_383_14 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_16 = arg_380_1:FormatText(StoryNameCfg[613].name)

				arg_380_1.leftNameTxt_.text = var_383_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_17 = arg_380_1:GetWordFromCfg(322251102)
				local var_383_18 = arg_380_1:FormatText(var_383_17.content)

				arg_380_1.text_.text = var_383_18

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_19 = 6
				local var_383_20 = utf8.len(var_383_18)
				local var_383_21 = var_383_19 <= 0 and var_383_15 or var_383_15 * (var_383_20 / var_383_19)

				if var_383_21 > 0 and var_383_15 < var_383_21 then
					arg_380_1.talkMaxDuration = var_383_21

					if var_383_21 + var_383_14 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_21 + var_383_14
					end
				end

				arg_380_1.text_.text = var_383_18
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251102", "story_v_out_322251.awb") ~= 0 then
					local var_383_22 = manager.audio:GetVoiceLength("story_v_out_322251", "322251102", "story_v_out_322251.awb") / 1000

					if var_383_22 + var_383_14 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_22 + var_383_14
					end

					if var_383_17.prefab_name ~= "" and arg_380_1.actors_[var_383_17.prefab_name] ~= nil then
						local var_383_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_17.prefab_name].transform, "story_v_out_322251", "322251102", "story_v_out_322251.awb")

						arg_380_1:RecordAudio("322251102", var_383_23)
						arg_380_1:RecordAudio("322251102", var_383_23)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_322251", "322251102", "story_v_out_322251.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_322251", "322251102", "story_v_out_322251.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_24 = math.max(var_383_15, arg_380_1.talkMaxDuration)

			if var_383_14 <= arg_380_1.time_ and arg_380_1.time_ < var_383_14 + var_383_24 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_14) / var_383_24

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_14 + var_383_24 and arg_380_1.time_ < var_383_14 + var_383_24 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play322251103 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 322251103
		arg_384_1.duration_ = 9.9

		local var_384_0 = {
			zh = 9.9,
			ja = 4.8
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play322251104(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["6056ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect6056ui_story == nil then
				arg_384_1.var_.characterEffect6056ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect6056ui_story and not isNil(var_387_0) then
					local var_387_4 = Mathf.Lerp(0, 0.5, var_387_3)

					arg_384_1.var_.characterEffect6056ui_story.fillFlat = true
					arg_384_1.var_.characterEffect6056ui_story.fillRatio = var_387_4
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect6056ui_story then
				local var_387_5 = 0.5

				arg_384_1.var_.characterEffect6056ui_story.fillFlat = true
				arg_384_1.var_.characterEffect6056ui_story.fillRatio = var_387_5
			end

			local var_387_6 = 0
			local var_387_7 = 0.525

			if var_387_6 < arg_384_1.time_ and arg_384_1.time_ <= var_387_6 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_8 = arg_384_1:FormatText(StoryNameCfg[36].name)

				arg_384_1.leftNameTxt_.text = var_387_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1049")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_9 = arg_384_1:GetWordFromCfg(322251103)
				local var_387_10 = arg_384_1:FormatText(var_387_9.content)

				arg_384_1.text_.text = var_387_10

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_11 = 21
				local var_387_12 = utf8.len(var_387_10)
				local var_387_13 = var_387_11 <= 0 and var_387_7 or var_387_7 * (var_387_12 / var_387_11)

				if var_387_13 > 0 and var_387_7 < var_387_13 then
					arg_384_1.talkMaxDuration = var_387_13

					if var_387_13 + var_387_6 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_13 + var_387_6
					end
				end

				arg_384_1.text_.text = var_387_10
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251103", "story_v_out_322251.awb") ~= 0 then
					local var_387_14 = manager.audio:GetVoiceLength("story_v_out_322251", "322251103", "story_v_out_322251.awb") / 1000

					if var_387_14 + var_387_6 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_14 + var_387_6
					end

					if var_387_9.prefab_name ~= "" and arg_384_1.actors_[var_387_9.prefab_name] ~= nil then
						local var_387_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_9.prefab_name].transform, "story_v_out_322251", "322251103", "story_v_out_322251.awb")

						arg_384_1:RecordAudio("322251103", var_387_15)
						arg_384_1:RecordAudio("322251103", var_387_15)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_322251", "322251103", "story_v_out_322251.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_322251", "322251103", "story_v_out_322251.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_16 = math.max(var_387_7, arg_384_1.talkMaxDuration)

			if var_387_6 <= arg_384_1.time_ and arg_384_1.time_ < var_387_6 + var_387_16 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_6) / var_387_16

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_6 + var_387_16 and arg_384_1.time_ < var_387_6 + var_387_16 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play322251104 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 322251104
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play322251105(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["6056ui_story"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos6056ui_story = var_391_0.localPosition

				local var_391_2 = "6056ui_story"

				arg_388_1:ShowWeapon(arg_388_1.var_[var_391_2 .. "Animator"].transform, false)
			end

			local var_391_3 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_3 then
				local var_391_4 = (arg_388_1.time_ - var_391_1) / var_391_3
				local var_391_5 = Vector3.New(0, 100, 0)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos6056ui_story, var_391_5, var_391_4)

				local var_391_6 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_6.x, var_391_6.y, var_391_6.z)

				local var_391_7 = var_391_0.localEulerAngles

				var_391_7.z = 0
				var_391_7.x = 0
				var_391_0.localEulerAngles = var_391_7
			end

			if arg_388_1.time_ >= var_391_1 + var_391_3 and arg_388_1.time_ < var_391_1 + var_391_3 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0, 100, 0)

				local var_391_8 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_8.x, var_391_8.y, var_391_8.z)

				local var_391_9 = var_391_0.localEulerAngles

				var_391_9.z = 0
				var_391_9.x = 0
				var_391_0.localEulerAngles = var_391_9
			end

			local var_391_10 = 0
			local var_391_11 = 0.85

			if var_391_10 < arg_388_1.time_ and arg_388_1.time_ <= var_391_10 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_12 = arg_388_1:GetWordFromCfg(322251104)
				local var_391_13 = arg_388_1:FormatText(var_391_12.content)

				arg_388_1.text_.text = var_391_13

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_14 = 34
				local var_391_15 = utf8.len(var_391_13)
				local var_391_16 = var_391_14 <= 0 and var_391_11 or var_391_11 * (var_391_15 / var_391_14)

				if var_391_16 > 0 and var_391_11 < var_391_16 then
					arg_388_1.talkMaxDuration = var_391_16

					if var_391_16 + var_391_10 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_16 + var_391_10
					end
				end

				arg_388_1.text_.text = var_391_13
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_17 = math.max(var_391_11, arg_388_1.talkMaxDuration)

			if var_391_10 <= arg_388_1.time_ and arg_388_1.time_ < var_391_10 + var_391_17 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_10) / var_391_17

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_10 + var_391_17 and arg_388_1.time_ < var_391_10 + var_391_17 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play322251105 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 322251105
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play322251106(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 1.375

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

				local var_395_2 = arg_392_1:GetWordFromCfg(322251105)
				local var_395_3 = arg_392_1:FormatText(var_395_2.content)

				arg_392_1.text_.text = var_395_3

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_4 = 55
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
	Play322251106 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 322251106
		arg_396_1.duration_ = 7.93

		local var_396_0 = {
			zh = 7.933,
			ja = 3.633
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play322251107(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0
			local var_399_1 = 0.225

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_2 = arg_396_1:FormatText(StoryNameCfg[36].name)

				arg_396_1.leftNameTxt_.text = var_399_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1049")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_3 = arg_396_1:GetWordFromCfg(322251106)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 9
				local var_399_6 = utf8.len(var_399_4)
				local var_399_7 = var_399_5 <= 0 and var_399_1 or var_399_1 * (var_399_6 / var_399_5)

				if var_399_7 > 0 and var_399_1 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_0
					end
				end

				arg_396_1.text_.text = var_399_4
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251106", "story_v_out_322251.awb") ~= 0 then
					local var_399_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251106", "story_v_out_322251.awb") / 1000

					if var_399_8 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_0
					end

					if var_399_3.prefab_name ~= "" and arg_396_1.actors_[var_399_3.prefab_name] ~= nil then
						local var_399_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_3.prefab_name].transform, "story_v_out_322251", "322251106", "story_v_out_322251.awb")

						arg_396_1:RecordAudio("322251106", var_399_9)
						arg_396_1:RecordAudio("322251106", var_399_9)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_322251", "322251106", "story_v_out_322251.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_322251", "322251106", "story_v_out_322251.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_10 = math.max(var_399_1, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_10 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_0) / var_399_10

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_10 and arg_396_1.time_ < var_399_0 + var_399_10 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play322251107 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 322251107
		arg_400_1.duration_ = 6.23

		local var_400_0 = {
			zh = 6.233,
			ja = 3.5
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play322251108(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.175

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_2 = arg_400_1:FormatText(StoryNameCfg[36].name)

				arg_400_1.leftNameTxt_.text = var_403_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1049")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_3 = arg_400_1:GetWordFromCfg(322251107)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 7
				local var_403_6 = utf8.len(var_403_4)
				local var_403_7 = var_403_5 <= 0 and var_403_1 or var_403_1 * (var_403_6 / var_403_5)

				if var_403_7 > 0 and var_403_1 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251107", "story_v_out_322251.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251107", "story_v_out_322251.awb") / 1000

					if var_403_8 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_0
					end

					if var_403_3.prefab_name ~= "" and arg_400_1.actors_[var_403_3.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_3.prefab_name].transform, "story_v_out_322251", "322251107", "story_v_out_322251.awb")

						arg_400_1:RecordAudio("322251107", var_403_9)
						arg_400_1:RecordAudio("322251107", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_322251", "322251107", "story_v_out_322251.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_322251", "322251107", "story_v_out_322251.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_10 and arg_400_1.time_ < var_403_0 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play322251108 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 322251108
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play322251109(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0
			local var_407_1 = 0.1

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_2 = arg_404_1:GetWordFromCfg(322251108)
				local var_407_3 = arg_404_1:FormatText(var_407_2.content)

				arg_404_1.text_.text = var_407_3

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 4
				local var_407_5 = utf8.len(var_407_3)
				local var_407_6 = var_407_4 <= 0 and var_407_1 or var_407_1 * (var_407_5 / var_407_4)

				if var_407_6 > 0 and var_407_1 < var_407_6 then
					arg_404_1.talkMaxDuration = var_407_6

					if var_407_6 + var_407_0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_6 + var_407_0
					end
				end

				arg_404_1.text_.text = var_407_3
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_1, arg_404_1.talkMaxDuration)

			if var_407_0 <= arg_404_1.time_ and arg_404_1.time_ < var_407_0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_0 + var_407_7 and arg_404_1.time_ < var_407_0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play322251109 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 322251109
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play322251110(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0
			local var_411_1 = 0.65

			if var_411_0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_2 = arg_408_1:GetWordFromCfg(322251109)
				local var_411_3 = arg_408_1:FormatText(var_411_2.content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 26
				local var_411_5 = utf8.len(var_411_3)
				local var_411_6 = var_411_4 <= 0 and var_411_1 or var_411_1 * (var_411_5 / var_411_4)

				if var_411_6 > 0 and var_411_1 < var_411_6 then
					arg_408_1.talkMaxDuration = var_411_6

					if var_411_6 + var_411_0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_0
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_1, arg_408_1.talkMaxDuration)

			if var_411_0 <= arg_408_1.time_ and arg_408_1.time_ < var_411_0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_0 + var_411_7 and arg_408_1.time_ < var_411_0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play322251110 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 322251110
		arg_412_1.duration_ = 9

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play322251111(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 4

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.allBtn_.enabled = false
			end

			local var_415_1 = 0.3

			if arg_412_1.time_ >= var_415_0 + var_415_1 and arg_412_1.time_ < var_415_0 + var_415_1 + arg_415_0 then
				arg_412_1.allBtn_.enabled = true
			end

			local var_415_2 = 2

			if var_415_2 < arg_412_1.time_ and arg_412_1.time_ <= var_415_2 + arg_415_0 then
				local var_415_3 = manager.ui.mainCamera.transform.localPosition
				local var_415_4 = Vector3.New(0, 0, 10) + Vector3.New(var_415_3.x, var_415_3.y, 0)
				local var_415_5 = arg_412_1.bgs_.MS2207

				var_415_5.transform.localPosition = var_415_4
				var_415_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_415_6 = var_415_5:GetComponent("SpriteRenderer")

				if var_415_6 and var_415_6.sprite then
					local var_415_7 = (var_415_5.transform.localPosition - var_415_3).z
					local var_415_8 = manager.ui.mainCameraCom_
					local var_415_9 = 2 * var_415_7 * Mathf.Tan(var_415_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_415_10 = var_415_9 * var_415_8.aspect
					local var_415_11 = var_415_6.sprite.bounds.size.x
					local var_415_12 = var_415_6.sprite.bounds.size.y
					local var_415_13 = var_415_10 / var_415_11
					local var_415_14 = var_415_9 / var_415_12
					local var_415_15 = var_415_14 < var_415_13 and var_415_13 or var_415_14

					var_415_5.transform.localScale = Vector3.New(var_415_15, var_415_15, 0)
				end

				for iter_415_0, iter_415_1 in pairs(arg_412_1.bgs_) do
					if iter_415_0 ~= "MS2207" then
						iter_415_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_415_16 = 0

			if var_415_16 < arg_412_1.time_ and arg_412_1.time_ <= var_415_16 + arg_415_0 then
				arg_412_1.mask_.enabled = true
				arg_412_1.mask_.raycastTarget = true

				arg_412_1:SetGaussion(false)
			end

			local var_415_17 = 2

			if var_415_16 <= arg_412_1.time_ and arg_412_1.time_ < var_415_16 + var_415_17 then
				local var_415_18 = (arg_412_1.time_ - var_415_16) / var_415_17
				local var_415_19 = Color.New(0, 0, 0)

				var_415_19.a = Mathf.Lerp(0, 1, var_415_18)
				arg_412_1.mask_.color = var_415_19
			end

			if arg_412_1.time_ >= var_415_16 + var_415_17 and arg_412_1.time_ < var_415_16 + var_415_17 + arg_415_0 then
				local var_415_20 = Color.New(0, 0, 0)

				var_415_20.a = 1
				arg_412_1.mask_.color = var_415_20
			end

			local var_415_21 = 2

			if var_415_21 < arg_412_1.time_ and arg_412_1.time_ <= var_415_21 + arg_415_0 then
				arg_412_1.mask_.enabled = true
				arg_412_1.mask_.raycastTarget = true

				arg_412_1:SetGaussion(false)
			end

			local var_415_22 = 2

			if var_415_21 <= arg_412_1.time_ and arg_412_1.time_ < var_415_21 + var_415_22 then
				local var_415_23 = (arg_412_1.time_ - var_415_21) / var_415_22
				local var_415_24 = Color.New(0, 0, 0)

				var_415_24.a = Mathf.Lerp(1, 0, var_415_23)
				arg_412_1.mask_.color = var_415_24
			end

			if arg_412_1.time_ >= var_415_21 + var_415_22 and arg_412_1.time_ < var_415_21 + var_415_22 + arg_415_0 then
				local var_415_25 = Color.New(0, 0, 0)
				local var_415_26 = 0

				arg_412_1.mask_.enabled = false
				var_415_25.a = var_415_26
				arg_412_1.mask_.color = var_415_25
			end

			local var_415_27 = 2

			arg_412_1.isInRecall_ = false

			if var_415_27 < arg_412_1.time_ and arg_412_1.time_ <= var_415_27 + arg_415_0 then
				arg_412_1.screenFilterGo_:SetActive(false)

				for iter_415_2, iter_415_3 in pairs(arg_412_1.actors_) do
					local var_415_28 = iter_415_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_415_4, iter_415_5 in ipairs(var_415_28) do
						if iter_415_5.color.r > 0.51 then
							iter_415_5.color = Color.New(1, 1, 1)
						else
							iter_415_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_415_29 = 0.0166666666666667

			if var_415_27 <= arg_412_1.time_ and arg_412_1.time_ < var_415_27 + var_415_29 then
				local var_415_30 = (arg_412_1.time_ - var_415_27) / var_415_29

				arg_412_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_415_30)
			end

			if arg_412_1.time_ >= var_415_27 + var_415_29 and arg_412_1.time_ < var_415_27 + var_415_29 + arg_415_0 then
				arg_412_1.screenFilterEffect_.weight = 0
			end

			local var_415_31 = 0.2
			local var_415_32 = 1

			if var_415_31 < arg_412_1.time_ and arg_412_1.time_ <= var_415_31 + arg_415_0 then
				local var_415_33 = "stop"
				local var_415_34 = "effect"

				arg_412_1:AudioAction(var_415_33, var_415_34, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_415_35 = 1.6
			local var_415_36 = 1

			if var_415_35 < arg_412_1.time_ and arg_412_1.time_ <= var_415_35 + arg_415_0 then
				local var_415_37 = "play"
				local var_415_38 = "effect"

				arg_412_1:AudioAction(var_415_37, var_415_38, "se_story_145", "se_story_145_amb_ST0512", "")
			end

			local var_415_39 = arg_412_1.bgs_.MS2207.transform
			local var_415_40 = 2.01666666666667

			if var_415_40 < arg_412_1.time_ and arg_412_1.time_ <= var_415_40 + arg_415_0 then
				arg_412_1.var_.moveOldPosMS2207 = var_415_39.localPosition
			end

			local var_415_41 = 2.01666666666667

			if var_415_40 <= arg_412_1.time_ and arg_412_1.time_ < var_415_40 + var_415_41 then
				local var_415_42 = (arg_412_1.time_ - var_415_40) / var_415_41
				local var_415_43 = Vector3.New(0, 1, 10)

				var_415_39.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPosMS2207, var_415_43, var_415_42)
			end

			if arg_412_1.time_ >= var_415_40 + var_415_41 and arg_412_1.time_ < var_415_40 + var_415_41 + arg_415_0 then
				var_415_39.localPosition = Vector3.New(0, 1, 10)
			end

			local var_415_44 = manager.ui.mainCamera.transform
			local var_415_45 = 2.01666666666667

			if var_415_45 < arg_412_1.time_ and arg_412_1.time_ <= var_415_45 + arg_415_0 then
				local var_415_46 = arg_412_1.var_.effect1110
				local var_415_47
				local var_415_48 = var_415_44

				if not var_415_46 then
					var_415_46 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), var_415_48)
					var_415_46.name = "1110"
					arg_412_1.var_.effect1110 = var_415_46
				else
					var_415_46.transform:SetParent(var_415_48)
				end

				var_415_46.transform.localPosition = Vector3.New(0, 0, -14.51)
				var_415_46.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_415_49 = manager.ui.mainCameraCom_
				local var_415_50 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_415_49.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_415_51 = var_415_46.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_415_52 = 15
				local var_415_53 = 2 * var_415_52 * Mathf.Tan(var_415_49.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_415_49.aspect
				local var_415_54 = 1
				local var_415_55 = 1.7777777777777777

				if var_415_55 < var_415_49.aspect then
					var_415_54 = var_415_53 / (2 * var_415_52 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_415_55)
				end

				for iter_415_6, iter_415_7 in ipairs(var_415_51) do
					local var_415_56 = iter_415_7.transform.localScale

					iter_415_7.transform.localScale = Vector3.New(var_415_56.x / var_415_50 * var_415_54, var_415_56.y / var_415_50, var_415_56.z)
				end
			end

			if arg_412_1.frameCnt_ <= 1 then
				arg_412_1.dialog_:SetActive(false)
			end

			local var_415_57 = 4
			local var_415_58 = 0.45

			if var_415_57 < arg_412_1.time_ and arg_412_1.time_ <= var_415_57 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0

				arg_412_1.dialog_:SetActive(true)

				arg_412_1.dialogCg_.alpha = 0

				local var_415_59 = LeanTween.value(arg_412_1.dialog_, 0, 1, 0.3)

				var_415_59:setOnUpdate(LuaHelper.FloatAction(function(arg_416_0)
					arg_412_1.dialogCg_.alpha = arg_416_0
				end))
				var_415_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_412_1.dialog_)
					var_415_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_412_1.duration_ = arg_412_1.duration_ + 0.3

				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_60 = arg_412_1:GetWordFromCfg(322251110)
				local var_415_61 = arg_412_1:FormatText(var_415_60.content)

				arg_412_1.text_.text = var_415_61

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_62 = 18
				local var_415_63 = utf8.len(var_415_61)
				local var_415_64 = var_415_62 <= 0 and var_415_58 or var_415_58 * (var_415_63 / var_415_62)

				if var_415_64 > 0 and var_415_58 < var_415_64 then
					arg_412_1.talkMaxDuration = var_415_64
					var_415_57 = var_415_57 + 0.3

					if var_415_64 + var_415_57 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_64 + var_415_57
					end
				end

				arg_412_1.text_.text = var_415_61
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_65 = var_415_57 + 0.3
			local var_415_66 = math.max(var_415_58, arg_412_1.talkMaxDuration)

			if var_415_65 <= arg_412_1.time_ and arg_412_1.time_ < var_415_65 + var_415_66 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_65) / var_415_66

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_65 + var_415_66 and arg_412_1.time_ < var_415_65 + var_415_66 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2207",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.01666666666667,
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play322251111 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 322251111
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play322251112(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 0.875

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_2 = arg_418_1:GetWordFromCfg(322251111)
				local var_421_3 = arg_418_1:FormatText(var_421_2.content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 35
				local var_421_5 = utf8.len(var_421_3)
				local var_421_6 = var_421_4 <= 0 and var_421_1 or var_421_1 * (var_421_5 / var_421_4)

				if var_421_6 > 0 and var_421_1 < var_421_6 then
					arg_418_1.talkMaxDuration = var_421_6

					if var_421_6 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_6 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_7 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_7 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_7

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_7 and arg_418_1.time_ < var_421_0 + var_421_7 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play322251112 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 322251112
		arg_422_1.duration_ = 15.67

		local var_422_0 = {
			zh = 10.8996666666667,
			ja = 15.6666666666667
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play322251113(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = manager.ui.mainCamera.transform
			local var_425_1 = 0.316666666666667

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				local var_425_2 = arg_422_1.var_.effect1110

				if var_425_2 then
					Object.Destroy(var_425_2)

					arg_422_1.var_.effect1110 = nil
				end
			end

			local var_425_3 = 0

			if var_425_3 < arg_422_1.time_ and arg_422_1.time_ <= var_425_3 + arg_425_0 then
				arg_422_1.mask_.enabled = true
				arg_422_1.mask_.raycastTarget = false

				arg_422_1:SetGaussion(false)
			end

			local var_425_4 = 0.333333333333333

			if var_425_3 <= arg_422_1.time_ and arg_422_1.time_ < var_425_3 + var_425_4 then
				local var_425_5 = (arg_422_1.time_ - var_425_3) / var_425_4
				local var_425_6 = Color.New(0, 0, 0)

				var_425_6.a = Mathf.Lerp(0, 1, var_425_5)
				arg_422_1.mask_.color = var_425_6
			end

			if arg_422_1.time_ >= var_425_3 + var_425_4 and arg_422_1.time_ < var_425_3 + var_425_4 + arg_425_0 then
				local var_425_7 = Color.New(0, 0, 0)

				var_425_7.a = 1
				arg_422_1.mask_.color = var_425_7
			end

			local var_425_8 = 0.333333333333333

			if var_425_8 < arg_422_1.time_ and arg_422_1.time_ <= var_425_8 + arg_425_0 then
				arg_422_1.mask_.enabled = true
				arg_422_1.mask_.raycastTarget = false

				arg_422_1:SetGaussion(false)
			end

			local var_425_9 = 0.333333333333333

			if var_425_8 <= arg_422_1.time_ and arg_422_1.time_ < var_425_8 + var_425_9 then
				local var_425_10 = (arg_422_1.time_ - var_425_8) / var_425_9
				local var_425_11 = Color.New(0, 0, 0)

				var_425_11.a = Mathf.Lerp(1, 0, var_425_10)
				arg_422_1.mask_.color = var_425_11
			end

			if arg_422_1.time_ >= var_425_8 + var_425_9 and arg_422_1.time_ < var_425_8 + var_425_9 + arg_425_0 then
				local var_425_12 = Color.New(0, 0, 0)
				local var_425_13 = 0

				arg_422_1.mask_.enabled = false
				var_425_12.a = var_425_13
				arg_422_1.mask_.color = var_425_12
			end

			if arg_422_1.frameCnt_ <= 1 then
				arg_422_1.dialog_:SetActive(false)
			end

			local var_425_14 = 0.666666666666667
			local var_425_15 = 1.1

			if var_425_14 < arg_422_1.time_ and arg_422_1.time_ <= var_425_14 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0

				arg_422_1.dialog_:SetActive(true)

				arg_422_1.dialogCg_.alpha = 0

				local var_425_16 = LeanTween.value(arg_422_1.dialog_, 0, 1, 0.3)

				var_425_16:setOnUpdate(LuaHelper.FloatAction(function(arg_426_0)
					arg_422_1.dialogCg_.alpha = arg_426_0
				end))
				var_425_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_422_1.dialog_)
					var_425_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_422_1.duration_ = arg_422_1.duration_ + 0.3

				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_17 = arg_422_1:FormatText(StoryNameCfg[613].name)

				arg_422_1.leftNameTxt_.text = var_425_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_18 = arg_422_1:GetWordFromCfg(322251112)
				local var_425_19 = arg_422_1:FormatText(var_425_18.content)

				arg_422_1.text_.text = var_425_19

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_20 = 44
				local var_425_21 = utf8.len(var_425_19)
				local var_425_22 = var_425_20 <= 0 and var_425_15 or var_425_15 * (var_425_21 / var_425_20)

				if var_425_22 > 0 and var_425_15 < var_425_22 then
					arg_422_1.talkMaxDuration = var_425_22
					var_425_14 = var_425_14 + 0.3

					if var_425_22 + var_425_14 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_22 + var_425_14
					end
				end

				arg_422_1.text_.text = var_425_19
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251112", "story_v_out_322251.awb") ~= 0 then
					local var_425_23 = manager.audio:GetVoiceLength("story_v_out_322251", "322251112", "story_v_out_322251.awb") / 1000

					if var_425_23 + var_425_14 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_23 + var_425_14
					end

					if var_425_18.prefab_name ~= "" and arg_422_1.actors_[var_425_18.prefab_name] ~= nil then
						local var_425_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_18.prefab_name].transform, "story_v_out_322251", "322251112", "story_v_out_322251.awb")

						arg_422_1:RecordAudio("322251112", var_425_24)
						arg_422_1:RecordAudio("322251112", var_425_24)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_322251", "322251112", "story_v_out_322251.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_322251", "322251112", "story_v_out_322251.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_25 = var_425_14 + 0.3
			local var_425_26 = math.max(var_425_15, arg_422_1.talkMaxDuration)

			if var_425_25 <= arg_422_1.time_ and arg_422_1.time_ < var_425_25 + var_425_26 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_25) / var_425_26

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_25 + var_425_26 and arg_422_1.time_ < var_425_25 + var_425_26 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play322251113 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 322251113
		arg_428_1.duration_ = 20.57

		local var_428_0 = {
			zh = 13.933,
			ja = 20.566
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play322251114(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0
			local var_431_1 = 1.45

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_2 = arg_428_1:FormatText(StoryNameCfg[613].name)

				arg_428_1.leftNameTxt_.text = var_431_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_3 = arg_428_1:GetWordFromCfg(322251113)
				local var_431_4 = arg_428_1:FormatText(var_431_3.content)

				arg_428_1.text_.text = var_431_4

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 58
				local var_431_6 = utf8.len(var_431_4)
				local var_431_7 = var_431_5 <= 0 and var_431_1 or var_431_1 * (var_431_6 / var_431_5)

				if var_431_7 > 0 and var_431_1 < var_431_7 then
					arg_428_1.talkMaxDuration = var_431_7

					if var_431_7 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_0
					end
				end

				arg_428_1.text_.text = var_431_4
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251113", "story_v_out_322251.awb") ~= 0 then
					local var_431_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251113", "story_v_out_322251.awb") / 1000

					if var_431_8 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_8 + var_431_0
					end

					if var_431_3.prefab_name ~= "" and arg_428_1.actors_[var_431_3.prefab_name] ~= nil then
						local var_431_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_3.prefab_name].transform, "story_v_out_322251", "322251113", "story_v_out_322251.awb")

						arg_428_1:RecordAudio("322251113", var_431_9)
						arg_428_1:RecordAudio("322251113", var_431_9)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_322251", "322251113", "story_v_out_322251.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_322251", "322251113", "story_v_out_322251.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_10 = math.max(var_431_1, arg_428_1.talkMaxDuration)

			if var_431_0 <= arg_428_1.time_ and arg_428_1.time_ < var_431_0 + var_431_10 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_0) / var_431_10

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_0 + var_431_10 and arg_428_1.time_ < var_431_0 + var_431_10 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play322251114 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 322251114
		arg_432_1.duration_ = 29.97

		local var_432_0 = {
			zh = 18.066,
			ja = 29.966
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play322251115(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 1.65

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_2 = arg_432_1:FormatText(StoryNameCfg[613].name)

				arg_432_1.leftNameTxt_.text = var_435_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_3 = arg_432_1:GetWordFromCfg(322251114)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 66
				local var_435_6 = utf8.len(var_435_4)
				local var_435_7 = var_435_5 <= 0 and var_435_1 or var_435_1 * (var_435_6 / var_435_5)

				if var_435_7 > 0 and var_435_1 < var_435_7 then
					arg_432_1.talkMaxDuration = var_435_7

					if var_435_7 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_4
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251114", "story_v_out_322251.awb") ~= 0 then
					local var_435_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251114", "story_v_out_322251.awb") / 1000

					if var_435_8 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_8 + var_435_0
					end

					if var_435_3.prefab_name ~= "" and arg_432_1.actors_[var_435_3.prefab_name] ~= nil then
						local var_435_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_3.prefab_name].transform, "story_v_out_322251", "322251114", "story_v_out_322251.awb")

						arg_432_1:RecordAudio("322251114", var_435_9)
						arg_432_1:RecordAudio("322251114", var_435_9)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_322251", "322251114", "story_v_out_322251.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_322251", "322251114", "story_v_out_322251.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_10 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_10 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_10

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_10 and arg_432_1.time_ < var_435_0 + var_435_10 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play322251115 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 322251115
		arg_436_1.duration_ = 14.1

		local var_436_0 = {
			zh = 9.766,
			ja = 14.1
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play322251116(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0
			local var_439_1 = 1.075

			if var_439_0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_2 = arg_436_1:FormatText(StoryNameCfg[613].name)

				arg_436_1.leftNameTxt_.text = var_439_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_3 = arg_436_1:GetWordFromCfg(322251115)
				local var_439_4 = arg_436_1:FormatText(var_439_3.content)

				arg_436_1.text_.text = var_439_4

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_5 = 43
				local var_439_6 = utf8.len(var_439_4)
				local var_439_7 = var_439_5 <= 0 and var_439_1 or var_439_1 * (var_439_6 / var_439_5)

				if var_439_7 > 0 and var_439_1 < var_439_7 then
					arg_436_1.talkMaxDuration = var_439_7

					if var_439_7 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_7 + var_439_0
					end
				end

				arg_436_1.text_.text = var_439_4
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251115", "story_v_out_322251.awb") ~= 0 then
					local var_439_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251115", "story_v_out_322251.awb") / 1000

					if var_439_8 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_8 + var_439_0
					end

					if var_439_3.prefab_name ~= "" and arg_436_1.actors_[var_439_3.prefab_name] ~= nil then
						local var_439_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_3.prefab_name].transform, "story_v_out_322251", "322251115", "story_v_out_322251.awb")

						arg_436_1:RecordAudio("322251115", var_439_9)
						arg_436_1:RecordAudio("322251115", var_439_9)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_322251", "322251115", "story_v_out_322251.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_322251", "322251115", "story_v_out_322251.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_10 = math.max(var_439_1, arg_436_1.talkMaxDuration)

			if var_439_0 <= arg_436_1.time_ and arg_436_1.time_ < var_439_0 + var_439_10 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_0) / var_439_10

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_0 + var_439_10 and arg_436_1.time_ < var_439_0 + var_439_10 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play322251116 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 322251116
		arg_440_1.duration_ = 18.3

		local var_440_0 = {
			zh = 13.066,
			ja = 18.3
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play322251117(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0
			local var_443_1 = 1.25

			if var_443_0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_2 = arg_440_1:FormatText(StoryNameCfg[613].name)

				arg_440_1.leftNameTxt_.text = var_443_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_3 = arg_440_1:GetWordFromCfg(322251116)
				local var_443_4 = arg_440_1:FormatText(var_443_3.content)

				arg_440_1.text_.text = var_443_4

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 50
				local var_443_6 = utf8.len(var_443_4)
				local var_443_7 = var_443_5 <= 0 and var_443_1 or var_443_1 * (var_443_6 / var_443_5)

				if var_443_7 > 0 and var_443_1 < var_443_7 then
					arg_440_1.talkMaxDuration = var_443_7

					if var_443_7 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_7 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_4
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251116", "story_v_out_322251.awb") ~= 0 then
					local var_443_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251116", "story_v_out_322251.awb") / 1000

					if var_443_8 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_8 + var_443_0
					end

					if var_443_3.prefab_name ~= "" and arg_440_1.actors_[var_443_3.prefab_name] ~= nil then
						local var_443_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_3.prefab_name].transform, "story_v_out_322251", "322251116", "story_v_out_322251.awb")

						arg_440_1:RecordAudio("322251116", var_443_9)
						arg_440_1:RecordAudio("322251116", var_443_9)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_322251", "322251116", "story_v_out_322251.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_322251", "322251116", "story_v_out_322251.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_10 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_10 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_10

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_10 and arg_440_1.time_ < var_443_0 + var_443_10 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play322251117 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 322251117
		arg_444_1.duration_ = 9.23

		local var_444_0 = {
			zh = 9.133,
			ja = 9.233
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play322251118(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 0.825

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_2 = arg_444_1:FormatText(StoryNameCfg[613].name)

				arg_444_1.leftNameTxt_.text = var_447_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_3 = arg_444_1:GetWordFromCfg(322251117)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 33
				local var_447_6 = utf8.len(var_447_4)
				local var_447_7 = var_447_5 <= 0 and var_447_1 or var_447_1 * (var_447_6 / var_447_5)

				if var_447_7 > 0 and var_447_1 < var_447_7 then
					arg_444_1.talkMaxDuration = var_447_7

					if var_447_7 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251117", "story_v_out_322251.awb") ~= 0 then
					local var_447_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251117", "story_v_out_322251.awb") / 1000

					if var_447_8 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_8 + var_447_0
					end

					if var_447_3.prefab_name ~= "" and arg_444_1.actors_[var_447_3.prefab_name] ~= nil then
						local var_447_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_3.prefab_name].transform, "story_v_out_322251", "322251117", "story_v_out_322251.awb")

						arg_444_1:RecordAudio("322251117", var_447_9)
						arg_444_1:RecordAudio("322251117", var_447_9)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_322251", "322251117", "story_v_out_322251.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_322251", "322251117", "story_v_out_322251.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_10 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_10 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_10

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_10 and arg_444_1.time_ < var_447_0 + var_447_10 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play322251118 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 322251118
		arg_448_1.duration_ = 8.13

		local var_448_0 = {
			zh = 5,
			ja = 8.133
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play322251119(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0
			local var_451_1 = 0.625

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_2 = arg_448_1:FormatText(StoryNameCfg[613].name)

				arg_448_1.leftNameTxt_.text = var_451_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_3 = arg_448_1:GetWordFromCfg(322251118)
				local var_451_4 = arg_448_1:FormatText(var_451_3.content)

				arg_448_1.text_.text = var_451_4

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 25
				local var_451_6 = utf8.len(var_451_4)
				local var_451_7 = var_451_5 <= 0 and var_451_1 or var_451_1 * (var_451_6 / var_451_5)

				if var_451_7 > 0 and var_451_1 < var_451_7 then
					arg_448_1.talkMaxDuration = var_451_7

					if var_451_7 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_7 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_4
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251118", "story_v_out_322251.awb") ~= 0 then
					local var_451_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251118", "story_v_out_322251.awb") / 1000

					if var_451_8 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_8 + var_451_0
					end

					if var_451_3.prefab_name ~= "" and arg_448_1.actors_[var_451_3.prefab_name] ~= nil then
						local var_451_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_3.prefab_name].transform, "story_v_out_322251", "322251118", "story_v_out_322251.awb")

						arg_448_1:RecordAudio("322251118", var_451_9)
						arg_448_1:RecordAudio("322251118", var_451_9)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_322251", "322251118", "story_v_out_322251.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_322251", "322251118", "story_v_out_322251.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_10 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_10 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_10

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_10 and arg_448_1.time_ < var_451_0 + var_451_10 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play322251119 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 322251119
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play322251120(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 0.25

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_2 = arg_452_1:FormatText(StoryNameCfg[7].name)

				arg_452_1.leftNameTxt_.text = var_455_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_3 = arg_452_1:GetWordFromCfg(322251119)
				local var_455_4 = arg_452_1:FormatText(var_455_3.content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 10
				local var_455_6 = utf8.len(var_455_4)
				local var_455_7 = var_455_5 <= 0 and var_455_1 or var_455_1 * (var_455_6 / var_455_5)

				if var_455_7 > 0 and var_455_1 < var_455_7 then
					arg_452_1.talkMaxDuration = var_455_7

					if var_455_7 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_7 + var_455_0
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_8 = math.max(var_455_1, arg_452_1.talkMaxDuration)

			if var_455_0 <= arg_452_1.time_ and arg_452_1.time_ < var_455_0 + var_455_8 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_0) / var_455_8

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_0 + var_455_8 and arg_452_1.time_ < var_455_0 + var_455_8 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play322251120 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 322251120
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play322251121(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 1.15

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_2 = arg_456_1:FormatText(StoryNameCfg[7].name)

				arg_456_1.leftNameTxt_.text = var_459_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_3 = arg_456_1:GetWordFromCfg(322251120)
				local var_459_4 = arg_456_1:FormatText(var_459_3.content)

				arg_456_1.text_.text = var_459_4

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 46
				local var_459_6 = utf8.len(var_459_4)
				local var_459_7 = var_459_5 <= 0 and var_459_1 or var_459_1 * (var_459_6 / var_459_5)

				if var_459_7 > 0 and var_459_1 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_0
					end
				end

				arg_456_1.text_.text = var_459_4
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_8 = math.max(var_459_1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_8 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_0) / var_459_8

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_8 and arg_456_1.time_ < var_459_0 + var_459_8 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play322251121 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 322251121
		arg_460_1.duration_ = 10.33

		local var_460_0 = {
			zh = 7.733,
			ja = 10.333
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play322251122(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0
			local var_463_1 = 0.875

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_2 = arg_460_1:FormatText(StoryNameCfg[613].name)

				arg_460_1.leftNameTxt_.text = var_463_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_3 = arg_460_1:GetWordFromCfg(322251121)
				local var_463_4 = arg_460_1:FormatText(var_463_3.content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 35
				local var_463_6 = utf8.len(var_463_4)
				local var_463_7 = var_463_5 <= 0 and var_463_1 or var_463_1 * (var_463_6 / var_463_5)

				if var_463_7 > 0 and var_463_1 < var_463_7 then
					arg_460_1.talkMaxDuration = var_463_7

					if var_463_7 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_7 + var_463_0
					end
				end

				arg_460_1.text_.text = var_463_4
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251121", "story_v_out_322251.awb") ~= 0 then
					local var_463_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251121", "story_v_out_322251.awb") / 1000

					if var_463_8 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_8 + var_463_0
					end

					if var_463_3.prefab_name ~= "" and arg_460_1.actors_[var_463_3.prefab_name] ~= nil then
						local var_463_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_3.prefab_name].transform, "story_v_out_322251", "322251121", "story_v_out_322251.awb")

						arg_460_1:RecordAudio("322251121", var_463_9)
						arg_460_1:RecordAudio("322251121", var_463_9)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_322251", "322251121", "story_v_out_322251.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_322251", "322251121", "story_v_out_322251.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_10 = math.max(var_463_1, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_10 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_0) / var_463_10

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_10 and arg_460_1.time_ < var_463_0 + var_463_10 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play322251122 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 322251122
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play322251123(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0
			local var_467_1 = 0.6

			if var_467_0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_2 = arg_464_1:FormatText(StoryNameCfg[7].name)

				arg_464_1.leftNameTxt_.text = var_467_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_3 = arg_464_1:GetWordFromCfg(322251122)
				local var_467_4 = arg_464_1:FormatText(var_467_3.content)

				arg_464_1.text_.text = var_467_4

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 24
				local var_467_6 = utf8.len(var_467_4)
				local var_467_7 = var_467_5 <= 0 and var_467_1 or var_467_1 * (var_467_6 / var_467_5)

				if var_467_7 > 0 and var_467_1 < var_467_7 then
					arg_464_1.talkMaxDuration = var_467_7

					if var_467_7 + var_467_0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_7 + var_467_0
					end
				end

				arg_464_1.text_.text = var_467_4
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_8 = math.max(var_467_1, arg_464_1.talkMaxDuration)

			if var_467_0 <= arg_464_1.time_ and arg_464_1.time_ < var_467_0 + var_467_8 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_0) / var_467_8

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_0 + var_467_8 and arg_464_1.time_ < var_467_0 + var_467_8 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play322251123 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 322251123
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play322251124(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.2

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_2 = arg_468_1:FormatText(StoryNameCfg[7].name)

				arg_468_1.leftNameTxt_.text = var_471_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_3 = arg_468_1:GetWordFromCfg(322251123)
				local var_471_4 = arg_468_1:FormatText(var_471_3.content)

				arg_468_1.text_.text = var_471_4

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_5 = 8
				local var_471_6 = utf8.len(var_471_4)
				local var_471_7 = var_471_5 <= 0 and var_471_1 or var_471_1 * (var_471_6 / var_471_5)

				if var_471_7 > 0 and var_471_1 < var_471_7 then
					arg_468_1.talkMaxDuration = var_471_7

					if var_471_7 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_7 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_4
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_8 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_8 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_8

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_8 and arg_468_1.time_ < var_471_0 + var_471_8 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play322251124 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 322251124
		arg_472_1.duration_ = 1.9

		local var_472_0 = {
			zh = 1.633,
			ja = 1.9
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play322251125(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = manager.ui.mainCamera.transform
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.var_.shakeOldPos = var_475_0.localPosition
			end

			local var_475_2 = 0.333333333333333

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_2 then
				local var_475_3 = (arg_472_1.time_ - var_475_1) / 0.066
				local var_475_4, var_475_5 = math.modf(var_475_3)

				var_475_0.localPosition = Vector3.New(var_475_5 * 0.13, var_475_5 * 0.13, var_475_5 * 0.13) + arg_472_1.var_.shakeOldPos
			end

			if arg_472_1.time_ >= var_475_1 + var_475_2 and arg_472_1.time_ < var_475_1 + var_475_2 + arg_475_0 then
				var_475_0.localPosition = arg_472_1.var_.shakeOldPos
			end

			local var_475_6 = 0
			local var_475_7 = 0.125

			if var_475_6 < arg_472_1.time_ and arg_472_1.time_ <= var_475_6 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_8 = arg_472_1:FormatText(StoryNameCfg[613].name)

				arg_472_1.leftNameTxt_.text = var_475_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_9 = arg_472_1:GetWordFromCfg(322251124)
				local var_475_10 = arg_472_1:FormatText(var_475_9.content)

				arg_472_1.text_.text = var_475_10

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_11 = 5
				local var_475_12 = utf8.len(var_475_10)
				local var_475_13 = var_475_11 <= 0 and var_475_7 or var_475_7 * (var_475_12 / var_475_11)

				if var_475_13 > 0 and var_475_7 < var_475_13 then
					arg_472_1.talkMaxDuration = var_475_13

					if var_475_13 + var_475_6 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_13 + var_475_6
					end
				end

				arg_472_1.text_.text = var_475_10
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251124", "story_v_out_322251.awb") ~= 0 then
					local var_475_14 = manager.audio:GetVoiceLength("story_v_out_322251", "322251124", "story_v_out_322251.awb") / 1000

					if var_475_14 + var_475_6 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_14 + var_475_6
					end

					if var_475_9.prefab_name ~= "" and arg_472_1.actors_[var_475_9.prefab_name] ~= nil then
						local var_475_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_9.prefab_name].transform, "story_v_out_322251", "322251124", "story_v_out_322251.awb")

						arg_472_1:RecordAudio("322251124", var_475_15)
						arg_472_1:RecordAudio("322251124", var_475_15)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_322251", "322251124", "story_v_out_322251.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_322251", "322251124", "story_v_out_322251.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_16 = math.max(var_475_7, arg_472_1.talkMaxDuration)

			if var_475_6 <= arg_472_1.time_ and arg_472_1.time_ < var_475_6 + var_475_16 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_6) / var_475_16

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_6 + var_475_16 and arg_472_1.time_ < var_475_6 + var_475_16 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play322251125 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 322251125
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play322251126(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 0.175

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_2 = arg_476_1:FormatText(StoryNameCfg[7].name)

				arg_476_1.leftNameTxt_.text = var_479_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_3 = arg_476_1:GetWordFromCfg(322251125)
				local var_479_4 = arg_476_1:FormatText(var_479_3.content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 7
				local var_479_6 = utf8.len(var_479_4)
				local var_479_7 = var_479_5 <= 0 and var_479_1 or var_479_1 * (var_479_6 / var_479_5)

				if var_479_7 > 0 and var_479_1 < var_479_7 then
					arg_476_1.talkMaxDuration = var_479_7

					if var_479_7 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_7 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_4
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_8 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_8 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_8

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_8 and arg_476_1.time_ < var_479_0 + var_479_8 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play322251126 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 322251126
		arg_480_1.duration_ = 8

		local var_480_0 = {
			zh = 7.033,
			ja = 8
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play322251127(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0
			local var_483_1 = 0.65

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_2 = arg_480_1:FormatText(StoryNameCfg[613].name)

				arg_480_1.leftNameTxt_.text = var_483_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_3 = arg_480_1:GetWordFromCfg(322251126)
				local var_483_4 = arg_480_1:FormatText(var_483_3.content)

				arg_480_1.text_.text = var_483_4

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_5 = 26
				local var_483_6 = utf8.len(var_483_4)
				local var_483_7 = var_483_5 <= 0 and var_483_1 or var_483_1 * (var_483_6 / var_483_5)

				if var_483_7 > 0 and var_483_1 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_0
					end
				end

				arg_480_1.text_.text = var_483_4
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251126", "story_v_out_322251.awb") ~= 0 then
					local var_483_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251126", "story_v_out_322251.awb") / 1000

					if var_483_8 + var_483_0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_8 + var_483_0
					end

					if var_483_3.prefab_name ~= "" and arg_480_1.actors_[var_483_3.prefab_name] ~= nil then
						local var_483_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_3.prefab_name].transform, "story_v_out_322251", "322251126", "story_v_out_322251.awb")

						arg_480_1:RecordAudio("322251126", var_483_9)
						arg_480_1:RecordAudio("322251126", var_483_9)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_322251", "322251126", "story_v_out_322251.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_322251", "322251126", "story_v_out_322251.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_10 = math.max(var_483_1, arg_480_1.talkMaxDuration)

			if var_483_0 <= arg_480_1.time_ and arg_480_1.time_ < var_483_0 + var_483_10 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_0) / var_483_10

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_0 + var_483_10 and arg_480_1.time_ < var_483_0 + var_483_10 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play322251127 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 322251127
		arg_484_1.duration_ = 9.13

		local var_484_0 = {
			zh = 8.1,
			ja = 9.133
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play322251128(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 0.95

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_2 = arg_484_1:FormatText(StoryNameCfg[613].name)

				arg_484_1.leftNameTxt_.text = var_487_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_3 = arg_484_1:GetWordFromCfg(322251127)
				local var_487_4 = arg_484_1:FormatText(var_487_3.content)

				arg_484_1.text_.text = var_487_4

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 38
				local var_487_6 = utf8.len(var_487_4)
				local var_487_7 = var_487_5 <= 0 and var_487_1 or var_487_1 * (var_487_6 / var_487_5)

				if var_487_7 > 0 and var_487_1 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_4
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251127", "story_v_out_322251.awb") ~= 0 then
					local var_487_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251127", "story_v_out_322251.awb") / 1000

					if var_487_8 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_0
					end

					if var_487_3.prefab_name ~= "" and arg_484_1.actors_[var_487_3.prefab_name] ~= nil then
						local var_487_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_3.prefab_name].transform, "story_v_out_322251", "322251127", "story_v_out_322251.awb")

						arg_484_1:RecordAudio("322251127", var_487_9)
						arg_484_1:RecordAudio("322251127", var_487_9)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_322251", "322251127", "story_v_out_322251.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_322251", "322251127", "story_v_out_322251.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_10 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_10 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_10

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_10 and arg_484_1.time_ < var_487_0 + var_487_10 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play322251128 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 322251128
		arg_488_1.duration_ = 9.6

		local var_488_0 = {
			zh = 8.333,
			ja = 9.6
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play322251129(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0
			local var_491_1 = 0.6

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_2 = arg_488_1:FormatText(StoryNameCfg[613].name)

				arg_488_1.leftNameTxt_.text = var_491_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_3 = arg_488_1:GetWordFromCfg(322251128)
				local var_491_4 = arg_488_1:FormatText(var_491_3.content)

				arg_488_1.text_.text = var_491_4

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 24
				local var_491_6 = utf8.len(var_491_4)
				local var_491_7 = var_491_5 <= 0 and var_491_1 or var_491_1 * (var_491_6 / var_491_5)

				if var_491_7 > 0 and var_491_1 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_0
					end
				end

				arg_488_1.text_.text = var_491_4
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251128", "story_v_out_322251.awb") ~= 0 then
					local var_491_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251128", "story_v_out_322251.awb") / 1000

					if var_491_8 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_8 + var_491_0
					end

					if var_491_3.prefab_name ~= "" and arg_488_1.actors_[var_491_3.prefab_name] ~= nil then
						local var_491_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_3.prefab_name].transform, "story_v_out_322251", "322251128", "story_v_out_322251.awb")

						arg_488_1:RecordAudio("322251128", var_491_9)
						arg_488_1:RecordAudio("322251128", var_491_9)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_322251", "322251128", "story_v_out_322251.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_322251", "322251128", "story_v_out_322251.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_10 = math.max(var_491_1, arg_488_1.talkMaxDuration)

			if var_491_0 <= arg_488_1.time_ and arg_488_1.time_ < var_491_0 + var_491_10 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_0) / var_491_10

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_0 + var_491_10 and arg_488_1.time_ < var_491_0 + var_491_10 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play322251129 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 322251129
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play322251130(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0
			local var_495_1 = 1.25

			if var_495_0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, false)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_2 = arg_492_1:GetWordFromCfg(322251129)
				local var_495_3 = arg_492_1:FormatText(var_495_2.content)

				arg_492_1.text_.text = var_495_3

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_4 = 50
				local var_495_5 = utf8.len(var_495_3)
				local var_495_6 = var_495_4 <= 0 and var_495_1 or var_495_1 * (var_495_5 / var_495_4)

				if var_495_6 > 0 and var_495_1 < var_495_6 then
					arg_492_1.talkMaxDuration = var_495_6

					if var_495_6 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_6 + var_495_0
					end
				end

				arg_492_1.text_.text = var_495_3
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_7 = math.max(var_495_1, arg_492_1.talkMaxDuration)

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_7 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_0) / var_495_7

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_0 + var_495_7 and arg_492_1.time_ < var_495_0 + var_495_7 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play322251130 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 322251130
		arg_496_1.duration_ = 2.9

		local var_496_0 = {
			zh = 2.9,
			ja = 2.533
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play322251131(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0
			local var_499_1 = 0.25

			if var_499_0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_2 = arg_496_1:FormatText(StoryNameCfg[613].name)

				arg_496_1.leftNameTxt_.text = var_499_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_3 = arg_496_1:GetWordFromCfg(322251130)
				local var_499_4 = arg_496_1:FormatText(var_499_3.content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_5 = 10
				local var_499_6 = utf8.len(var_499_4)
				local var_499_7 = var_499_5 <= 0 and var_499_1 or var_499_1 * (var_499_6 / var_499_5)

				if var_499_7 > 0 and var_499_1 < var_499_7 then
					arg_496_1.talkMaxDuration = var_499_7

					if var_499_7 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_0
					end
				end

				arg_496_1.text_.text = var_499_4
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251130", "story_v_out_322251.awb") ~= 0 then
					local var_499_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251130", "story_v_out_322251.awb") / 1000

					if var_499_8 + var_499_0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_8 + var_499_0
					end

					if var_499_3.prefab_name ~= "" and arg_496_1.actors_[var_499_3.prefab_name] ~= nil then
						local var_499_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_3.prefab_name].transform, "story_v_out_322251", "322251130", "story_v_out_322251.awb")

						arg_496_1:RecordAudio("322251130", var_499_9)
						arg_496_1:RecordAudio("322251130", var_499_9)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_322251", "322251130", "story_v_out_322251.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_322251", "322251130", "story_v_out_322251.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_10 = math.max(var_499_1, arg_496_1.talkMaxDuration)

			if var_499_0 <= arg_496_1.time_ and arg_496_1.time_ < var_499_0 + var_499_10 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_0) / var_499_10

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_0 + var_499_10 and arg_496_1.time_ < var_499_0 + var_499_10 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play322251131 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 322251131
		arg_500_1.duration_ = 7.7

		local var_500_0 = {
			zh = 6.4,
			ja = 7.7
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play322251132(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.725

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_2 = arg_500_1:FormatText(StoryNameCfg[613].name)

				arg_500_1.leftNameTxt_.text = var_503_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_3 = arg_500_1:GetWordFromCfg(322251131)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 29
				local var_503_6 = utf8.len(var_503_4)
				local var_503_7 = var_503_5 <= 0 and var_503_1 or var_503_1 * (var_503_6 / var_503_5)

				if var_503_7 > 0 and var_503_1 < var_503_7 then
					arg_500_1.talkMaxDuration = var_503_7

					if var_503_7 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_7 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_4
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251131", "story_v_out_322251.awb") ~= 0 then
					local var_503_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251131", "story_v_out_322251.awb") / 1000

					if var_503_8 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_8 + var_503_0
					end

					if var_503_3.prefab_name ~= "" and arg_500_1.actors_[var_503_3.prefab_name] ~= nil then
						local var_503_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_3.prefab_name].transform, "story_v_out_322251", "322251131", "story_v_out_322251.awb")

						arg_500_1:RecordAudio("322251131", var_503_9)
						arg_500_1:RecordAudio("322251131", var_503_9)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_322251", "322251131", "story_v_out_322251.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_322251", "322251131", "story_v_out_322251.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_10 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_10 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_10

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_10 and arg_500_1.time_ < var_503_0 + var_503_10 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play322251132 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 322251132
		arg_504_1.duration_ = 12.27

		local var_504_0 = {
			zh = 12.266,
			ja = 11.9
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play322251133(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.875

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_2 = arg_504_1:FormatText(StoryNameCfg[613].name)

				arg_504_1.leftNameTxt_.text = var_507_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_3 = arg_504_1:GetWordFromCfg(322251132)
				local var_507_4 = arg_504_1:FormatText(var_507_3.content)

				arg_504_1.text_.text = var_507_4

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 35
				local var_507_6 = utf8.len(var_507_4)
				local var_507_7 = var_507_5 <= 0 and var_507_1 or var_507_1 * (var_507_6 / var_507_5)

				if var_507_7 > 0 and var_507_1 < var_507_7 then
					arg_504_1.talkMaxDuration = var_507_7

					if var_507_7 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_7 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_4
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251132", "story_v_out_322251.awb") ~= 0 then
					local var_507_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251132", "story_v_out_322251.awb") / 1000

					if var_507_8 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_8 + var_507_0
					end

					if var_507_3.prefab_name ~= "" and arg_504_1.actors_[var_507_3.prefab_name] ~= nil then
						local var_507_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_3.prefab_name].transform, "story_v_out_322251", "322251132", "story_v_out_322251.awb")

						arg_504_1:RecordAudio("322251132", var_507_9)
						arg_504_1:RecordAudio("322251132", var_507_9)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_322251", "322251132", "story_v_out_322251.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_322251", "322251132", "story_v_out_322251.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_10 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_10 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_10

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_10 and arg_504_1.time_ < var_507_0 + var_507_10 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play322251133 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 322251133
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play322251134(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 0.3

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_2 = arg_508_1:FormatText(StoryNameCfg[7].name)

				arg_508_1.leftNameTxt_.text = var_511_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_3 = arg_508_1:GetWordFromCfg(322251133)
				local var_511_4 = arg_508_1:FormatText(var_511_3.content)

				arg_508_1.text_.text = var_511_4

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 12
				local var_511_6 = utf8.len(var_511_4)
				local var_511_7 = var_511_5 <= 0 and var_511_1 or var_511_1 * (var_511_6 / var_511_5)

				if var_511_7 > 0 and var_511_1 < var_511_7 then
					arg_508_1.talkMaxDuration = var_511_7

					if var_511_7 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_7 + var_511_0
					end
				end

				arg_508_1.text_.text = var_511_4
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_8 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_8 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_8

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_8 and arg_508_1.time_ < var_511_0 + var_511_8 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play322251134 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 322251134
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play322251135(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0
			local var_515_1 = 1.225

			if var_515_0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, false)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_2 = arg_512_1:GetWordFromCfg(322251134)
				local var_515_3 = arg_512_1:FormatText(var_515_2.content)

				arg_512_1.text_.text = var_515_3

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_4 = 49
				local var_515_5 = utf8.len(var_515_3)
				local var_515_6 = var_515_4 <= 0 and var_515_1 or var_515_1 * (var_515_5 / var_515_4)

				if var_515_6 > 0 and var_515_1 < var_515_6 then
					arg_512_1.talkMaxDuration = var_515_6

					if var_515_6 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_6 + var_515_0
					end
				end

				arg_512_1.text_.text = var_515_3
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_7 = math.max(var_515_1, arg_512_1.talkMaxDuration)

			if var_515_0 <= arg_512_1.time_ and arg_512_1.time_ < var_515_0 + var_515_7 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_0) / var_515_7

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_0 + var_515_7 and arg_512_1.time_ < var_515_0 + var_515_7 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play322251135 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 322251135
		arg_516_1.duration_ = 3.82

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play322251136(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 1.25833333333333

			if var_519_0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_0 + arg_519_0 then
				local var_519_1 = manager.ui.mainCamera.transform.localPosition
				local var_519_2 = Vector3.New(0, 0, 10) + Vector3.New(var_519_1.x, var_519_1.y, 0)
				local var_519_3 = arg_516_1.bgs_.STblack

				var_519_3.transform.localPosition = var_519_2
				var_519_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_519_4 = var_519_3:GetComponent("SpriteRenderer")

				if var_519_4 and var_519_4.sprite then
					local var_519_5 = (var_519_3.transform.localPosition - var_519_1).z
					local var_519_6 = manager.ui.mainCameraCom_
					local var_519_7 = 2 * var_519_5 * Mathf.Tan(var_519_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_519_8 = var_519_7 * var_519_6.aspect
					local var_519_9 = var_519_4.sprite.bounds.size.x
					local var_519_10 = var_519_4.sprite.bounds.size.y
					local var_519_11 = var_519_8 / var_519_9
					local var_519_12 = var_519_7 / var_519_10
					local var_519_13 = var_519_12 < var_519_11 and var_519_11 or var_519_12

					var_519_3.transform.localScale = Vector3.New(var_519_13, var_519_13, 0)
				end

				for iter_519_0, iter_519_1 in pairs(arg_516_1.bgs_) do
					if iter_519_0 ~= "STblack" then
						iter_519_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_519_14 = 1.25833333333333

			if var_519_14 < arg_516_1.time_ and arg_516_1.time_ <= var_519_14 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_15 = 0.833333333333333

			if var_519_14 <= arg_516_1.time_ and arg_516_1.time_ < var_519_14 + var_519_15 then
				local var_519_16 = (arg_516_1.time_ - var_519_14) / var_519_15
				local var_519_17 = Color.New(0, 0, 0)

				var_519_17.a = Mathf.Lerp(1, 0, var_519_16)
				arg_516_1.mask_.color = var_519_17
			end

			if arg_516_1.time_ >= var_519_14 + var_519_15 and arg_516_1.time_ < var_519_14 + var_519_15 + arg_519_0 then
				local var_519_18 = Color.New(0, 0, 0)
				local var_519_19 = 0

				arg_516_1.mask_.enabled = false
				var_519_18.a = var_519_19
				arg_516_1.mask_.color = var_519_18
			end

			local var_519_20 = 1.45833333333333
			local var_519_21 = 0.3

			if var_519_20 < arg_516_1.time_ and arg_516_1.time_ <= var_519_20 + arg_519_0 then
				local var_519_22 = "play"
				local var_519_23 = "music"

				arg_516_1:AudioAction(var_519_22, var_519_23, "ui_battle", "ui_battle_stopbgm", "")

				local var_519_24 = ""
				local var_519_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_519_25 ~= "" then
					if arg_516_1.bgmTxt_.text ~= var_519_25 and arg_516_1.bgmTxt_.text ~= "" then
						if arg_516_1.bgmTxt2_.text ~= "" then
							arg_516_1.bgmTxt_.text = arg_516_1.bgmTxt2_.text
						end

						arg_516_1.bgmTxt2_.text = var_519_25

						arg_516_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_516_1.bgmTxt_.text = var_519_25
						arg_516_1.bgmTxt2_.text = var_519_25
					end

					if arg_516_1.bgmTimer then
						arg_516_1.bgmTimer:Stop()

						arg_516_1.bgmTimer = nil
					end

					if arg_516_1.settingData.show_music_name == 1 then
						arg_516_1.musicController:SetSelectedState("show")
						arg_516_1.musicAnimator_:Play("open", 0, 0)

						if arg_516_1.settingData.music_time ~= 0 then
							arg_516_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_516_1.settingData.music_time), function()
								if arg_516_1 == nil or isNil(arg_516_1.bgmTxt_) then
									return
								end

								arg_516_1.musicController:SetSelectedState("hide")
								arg_516_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_519_26 = manager.ui.mainCamera.transform
			local var_519_27 = 1.24166666666667

			if var_519_27 < arg_516_1.time_ and arg_516_1.time_ <= var_519_27 + arg_519_0 then
				local var_519_28 = arg_516_1.var_.effect1134

				if var_519_28 then
					Object.Destroy(var_519_28)

					arg_516_1.var_.effect1134 = nil
				end
			end

			local var_519_29 = 0

			if var_519_29 < arg_516_1.time_ and arg_516_1.time_ <= var_519_29 + arg_519_0 then
				arg_516_1.mask_.enabled = true
				arg_516_1.mask_.raycastTarget = true

				arg_516_1:SetGaussion(false)
			end

			local var_519_30 = 1.24166666666667

			if var_519_29 <= arg_516_1.time_ and arg_516_1.time_ < var_519_29 + var_519_30 then
				local var_519_31 = (arg_516_1.time_ - var_519_29) / var_519_30
				local var_519_32 = Color.New(0, 0, 0)

				var_519_32.a = Mathf.Lerp(0, 1, var_519_31)
				arg_516_1.mask_.color = var_519_32
			end

			if arg_516_1.time_ >= var_519_29 + var_519_30 and arg_516_1.time_ < var_519_29 + var_519_30 + arg_519_0 then
				local var_519_33 = Color.New(0, 0, 0)

				var_519_33.a = 1
				arg_516_1.mask_.color = var_519_33
			end

			local var_519_34 = manager.ui.mainCamera.transform
			local var_519_35 = 0

			if var_519_35 < arg_516_1.time_ and arg_516_1.time_ <= var_519_35 + arg_519_0 then
				local var_519_36 = arg_516_1.var_.effect1134
				local var_519_37
				local var_519_38 = var_519_34

				if not var_519_36 then
					var_519_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapshut"), var_519_38)
					var_519_36.name = "1134"
					arg_516_1.var_.effect1134 = var_519_36
				else
					var_519_36.transform:SetParent(var_519_38)
				end

				var_519_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_519_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_519_39 = manager.ui.mainCamera.transform
			local var_519_40 = 1.24166666666667

			if var_519_40 < arg_516_1.time_ and arg_516_1.time_ <= var_519_40 + arg_519_0 then
				local var_519_41 = arg_516_1.var_.effect1084

				if var_519_41 then
					Object.Destroy(var_519_41)

					arg_516_1.var_.effect1084 = nil
				end
			end

			local var_519_42 = manager.ui.mainCamera.transform
			local var_519_43 = 1.24166666666667

			if var_519_43 < arg_516_1.time_ and arg_516_1.time_ <= var_519_43 + arg_519_0 then
				local var_519_44 = arg_516_1.var_.effect1110

				if var_519_44 then
					Object.Destroy(var_519_44)

					arg_516_1.var_.effect1110 = nil
				end
			end

			local var_519_45 = 0
			local var_519_46 = 0.3

			if var_519_45 < arg_516_1.time_ and arg_516_1.time_ <= var_519_45 + arg_519_0 then
				local var_519_47 = "play"
				local var_519_48 = "music"

				arg_516_1:AudioAction(var_519_47, var_519_48, "ui_battle", "ui_battle_stopbgm", "")

				local var_519_49 = ""
				local var_519_50 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_519_50 ~= "" then
					if arg_516_1.bgmTxt_.text ~= var_519_50 and arg_516_1.bgmTxt_.text ~= "" then
						if arg_516_1.bgmTxt2_.text ~= "" then
							arg_516_1.bgmTxt_.text = arg_516_1.bgmTxt2_.text
						end

						arg_516_1.bgmTxt2_.text = var_519_50

						arg_516_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_516_1.bgmTxt_.text = var_519_50
						arg_516_1.bgmTxt2_.text = var_519_50
					end

					if arg_516_1.bgmTimer then
						arg_516_1.bgmTimer:Stop()

						arg_516_1.bgmTimer = nil
					end

					if arg_516_1.settingData.show_music_name == 1 then
						arg_516_1.musicController:SetSelectedState("show")
						arg_516_1.musicAnimator_:Play("open", 0, 0)

						if arg_516_1.settingData.music_time ~= 0 then
							arg_516_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_516_1.settingData.music_time), function()
								if arg_516_1 == nil or isNil(arg_516_1.bgmTxt_) then
									return
								end

								arg_516_1.musicController:SetSelectedState("hide")
								arg_516_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_519_51 = 0.1
			local var_519_52 = 1

			if var_519_51 < arg_516_1.time_ and arg_516_1.time_ <= var_519_51 + arg_519_0 then
				local var_519_53 = "stop"
				local var_519_54 = "effect"

				arg_516_1:AudioAction(var_519_53, var_519_54, "se_story_145", "se_story_145_amb_ST0512", "")
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322251135,
				charCount = 23,
				enableLayoutChange = true,
				duration = 1.53333333333333,
				groupID = "1135",
				startTime = 1.25833333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play322251136 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 322251136
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play322251137(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = 0
			local var_525_1 = 0.3

			if var_525_0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_0 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_2 = arg_522_1:FormatText(StoryNameCfg[7].name)

				arg_522_1.leftNameTxt_.text = var_525_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_3 = arg_522_1:GetWordFromCfg(322251136)
				local var_525_4 = arg_522_1:FormatText(var_525_3.content)

				arg_522_1.text_.text = var_525_4

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_5 = 12
				local var_525_6 = utf8.len(var_525_4)
				local var_525_7 = var_525_5 <= 0 and var_525_1 or var_525_1 * (var_525_6 / var_525_5)

				if var_525_7 > 0 and var_525_1 < var_525_7 then
					arg_522_1.talkMaxDuration = var_525_7

					if var_525_7 + var_525_0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_7 + var_525_0
					end
				end

				arg_522_1.text_.text = var_525_4
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_8 = math.max(var_525_1, arg_522_1.talkMaxDuration)

			if var_525_0 <= arg_522_1.time_ and arg_522_1.time_ < var_525_0 + var_525_8 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_0) / var_525_8

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_0 + var_525_8 and arg_522_1.time_ < var_525_0 + var_525_8 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				groupID = "1135",
				duration = 1.53333333333333,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play322251137 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 322251137
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play322251138(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0
			local var_529_1 = 0.65

			if var_529_0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_2 = arg_526_1:FormatText(StoryNameCfg[7].name)

				arg_526_1.leftNameTxt_.text = var_529_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, true)
				arg_526_1.iconController_:SetSelectedState("hero")

				arg_526_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_526_1.callingController_:SetSelectedState("normal")

				arg_526_1.keyicon_.color = Color.New(1, 1, 1)
				arg_526_1.icon_.color = Color.New(1, 1, 1)

				local var_529_3 = arg_526_1:GetWordFromCfg(322251137)
				local var_529_4 = arg_526_1:FormatText(var_529_3.content)

				arg_526_1.text_.text = var_529_4

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_5 = 26
				local var_529_6 = utf8.len(var_529_4)
				local var_529_7 = var_529_5 <= 0 and var_529_1 or var_529_1 * (var_529_6 / var_529_5)

				if var_529_7 > 0 and var_529_1 < var_529_7 then
					arg_526_1.talkMaxDuration = var_529_7

					if var_529_7 + var_529_0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_7 + var_529_0
					end
				end

				arg_526_1.text_.text = var_529_4
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_8 = math.max(var_529_1, arg_526_1.talkMaxDuration)

			if var_529_0 <= arg_526_1.time_ and arg_526_1.time_ < var_529_0 + var_529_8 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_0) / var_529_8

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_0 + var_529_8 and arg_526_1.time_ < var_529_0 + var_529_8 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play322251138 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 322251138
		arg_530_1.duration_ = 1.33

		local var_530_0 = {
			zh = 1.333,
			ja = 1.3
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play322251139(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0
			local var_533_1 = 0.325

			if var_533_0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_2 = arg_530_1:FormatText(StoryNameCfg[36].name)

				arg_530_1.leftNameTxt_.text = var_533_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_3 = arg_530_1:GetWordFromCfg(322251138)
				local var_533_4 = arg_530_1:FormatText(var_533_3.content)

				arg_530_1.text_.text = var_533_4

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_5 = 13
				local var_533_6 = utf8.len(var_533_4)
				local var_533_7 = var_533_5 <= 0 and var_533_1 or var_533_1 * (var_533_6 / var_533_5)

				if var_533_7 > 0 and var_533_1 < var_533_7 then
					arg_530_1.talkMaxDuration = var_533_7

					if var_533_7 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_7 + var_533_0
					end
				end

				arg_530_1.text_.text = var_533_4
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251138", "story_v_out_322251.awb") ~= 0 then
					local var_533_8 = manager.audio:GetVoiceLength("story_v_out_322251", "322251138", "story_v_out_322251.awb") / 1000

					if var_533_8 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_8 + var_533_0
					end

					if var_533_3.prefab_name ~= "" and arg_530_1.actors_[var_533_3.prefab_name] ~= nil then
						local var_533_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_3.prefab_name].transform, "story_v_out_322251", "322251138", "story_v_out_322251.awb")

						arg_530_1:RecordAudio("322251138", var_533_9)
						arg_530_1:RecordAudio("322251138", var_533_9)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_322251", "322251138", "story_v_out_322251.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_322251", "322251138", "story_v_out_322251.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_10 = math.max(var_533_1, arg_530_1.talkMaxDuration)

			if var_533_0 <= arg_530_1.time_ and arg_530_1.time_ < var_533_0 + var_533_10 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_0) / var_533_10

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_0 + var_533_10 and arg_530_1.time_ < var_533_0 + var_533_10 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play322251139 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 322251139
		arg_534_1.duration_ = 9

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play322251140(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 4

			if var_537_0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_0 + arg_537_0 then
				arg_534_1.allBtn_.enabled = false
			end

			local var_537_1 = 0.766666666666667

			if arg_534_1.time_ >= var_537_0 + var_537_1 and arg_534_1.time_ < var_537_0 + var_537_1 + arg_537_0 then
				arg_534_1.allBtn_.enabled = true
			end

			local var_537_2 = 2

			if var_537_2 < arg_534_1.time_ and arg_534_1.time_ <= var_537_2 + arg_537_0 then
				local var_537_3 = manager.ui.mainCamera.transform.localPosition
				local var_537_4 = Vector3.New(0, 0, 10) + Vector3.New(var_537_3.x, var_537_3.y, 0)
				local var_537_5 = arg_534_1.bgs_.ST0512

				var_537_5.transform.localPosition = var_537_4
				var_537_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_537_6 = var_537_5:GetComponent("SpriteRenderer")

				if var_537_6 and var_537_6.sprite then
					local var_537_7 = (var_537_5.transform.localPosition - var_537_3).z
					local var_537_8 = manager.ui.mainCameraCom_
					local var_537_9 = 2 * var_537_7 * Mathf.Tan(var_537_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_537_10 = var_537_9 * var_537_8.aspect
					local var_537_11 = var_537_6.sprite.bounds.size.x
					local var_537_12 = var_537_6.sprite.bounds.size.y
					local var_537_13 = var_537_10 / var_537_11
					local var_537_14 = var_537_9 / var_537_12
					local var_537_15 = var_537_14 < var_537_13 and var_537_13 or var_537_14

					var_537_5.transform.localScale = Vector3.New(var_537_15, var_537_15, 0)
				end

				for iter_537_0, iter_537_1 in pairs(arg_534_1.bgs_) do
					if iter_537_0 ~= "ST0512" then
						iter_537_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_537_16 = 0

			if var_537_16 < arg_534_1.time_ and arg_534_1.time_ <= var_537_16 + arg_537_0 then
				arg_534_1.mask_.enabled = true
				arg_534_1.mask_.raycastTarget = true

				arg_534_1:SetGaussion(false)
			end

			local var_537_17 = 2

			if var_537_16 <= arg_534_1.time_ and arg_534_1.time_ < var_537_16 + var_537_17 then
				local var_537_18 = (arg_534_1.time_ - var_537_16) / var_537_17
				local var_537_19 = Color.New(0, 0, 0)

				var_537_19.a = Mathf.Lerp(0, 1, var_537_18)
				arg_534_1.mask_.color = var_537_19
			end

			if arg_534_1.time_ >= var_537_16 + var_537_17 and arg_534_1.time_ < var_537_16 + var_537_17 + arg_537_0 then
				local var_537_20 = Color.New(0, 0, 0)

				var_537_20.a = 1
				arg_534_1.mask_.color = var_537_20
			end

			local var_537_21 = 2

			if var_537_21 < arg_534_1.time_ and arg_534_1.time_ <= var_537_21 + arg_537_0 then
				arg_534_1.mask_.enabled = true
				arg_534_1.mask_.raycastTarget = true

				arg_534_1:SetGaussion(false)
			end

			local var_537_22 = 2.03333333333333

			if var_537_21 <= arg_534_1.time_ and arg_534_1.time_ < var_537_21 + var_537_22 then
				local var_537_23 = (arg_534_1.time_ - var_537_21) / var_537_22
				local var_537_24 = Color.New(0, 0, 0)

				var_537_24.a = Mathf.Lerp(1, 0, var_537_23)
				arg_534_1.mask_.color = var_537_24
			end

			if arg_534_1.time_ >= var_537_21 + var_537_22 and arg_534_1.time_ < var_537_21 + var_537_22 + arg_537_0 then
				local var_537_25 = Color.New(0, 0, 0)
				local var_537_26 = 0

				arg_534_1.mask_.enabled = false
				var_537_25.a = var_537_26
				arg_534_1.mask_.color = var_537_25
			end

			local var_537_27 = 1.53333333333333
			local var_537_28 = 1

			if var_537_27 < arg_534_1.time_ and arg_534_1.time_ <= var_537_27 + arg_537_0 then
				local var_537_29 = "play"
				local var_537_30 = "effect"

				arg_534_1:AudioAction(var_537_29, var_537_30, "se_story_145", "se_story_145_amb_ST0512", "")
			end

			if arg_534_1.frameCnt_ <= 1 then
				arg_534_1.dialog_:SetActive(false)
			end

			local var_537_31 = 4
			local var_537_32 = 1

			if var_537_31 < arg_534_1.time_ and arg_534_1.time_ <= var_537_31 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0

				arg_534_1.dialog_:SetActive(true)

				arg_534_1.dialogCg_.alpha = 0

				local var_537_33 = LeanTween.value(arg_534_1.dialog_, 0, 1, 0.3)

				var_537_33:setOnUpdate(LuaHelper.FloatAction(function(arg_538_0)
					arg_534_1.dialogCg_.alpha = arg_538_0
				end))
				var_537_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_534_1.dialog_)
					var_537_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_534_1.duration_ = arg_534_1.duration_ + 0.3

				SetActive(arg_534_1.leftNameGo_, false)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_34 = arg_534_1:GetWordFromCfg(322251139)
				local var_537_35 = arg_534_1:FormatText(var_537_34.content)

				arg_534_1.text_.text = var_537_35

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_36 = 40
				local var_537_37 = utf8.len(var_537_35)
				local var_537_38 = var_537_36 <= 0 and var_537_32 or var_537_32 * (var_537_37 / var_537_36)

				if var_537_38 > 0 and var_537_32 < var_537_38 then
					arg_534_1.talkMaxDuration = var_537_38
					var_537_31 = var_537_31 + 0.3

					if var_537_38 + var_537_31 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_38 + var_537_31
					end
				end

				arg_534_1.text_.text = var_537_35
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_39 = var_537_31 + 0.3
			local var_537_40 = math.max(var_537_32, arg_534_1.talkMaxDuration)

			if var_537_39 <= arg_534_1.time_ and arg_534_1.time_ < var_537_39 + var_537_40 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_39) / var_537_40

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_39 + var_537_40 and arg_534_1.time_ < var_537_39 + var_537_40 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play322251140 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 322251140
		arg_540_1.duration_ = 6.59

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play322251141(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = manager.ui.mainCamera.transform
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				local var_543_2 = arg_540_1.var_.effect1139
				local var_543_3
				local var_543_4 = var_543_0

				if not var_543_2 then
					var_543_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), var_543_4)
					var_543_2.name = "1139"
					arg_540_1.var_.effect1139 = var_543_2
				else
					var_543_2.transform:SetParent(var_543_4)
				end

				var_543_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_543_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_543_5 = manager.ui.mainCamera.transform
			local var_543_6 = 2.8

			if var_543_6 < arg_540_1.time_ and arg_540_1.time_ <= var_543_6 + arg_543_0 then
				local var_543_7 = arg_540_1.var_.effect1139

				if var_543_7 then
					Object.Destroy(var_543_7)

					arg_540_1.var_.effect1139 = nil
				end
			end

			if arg_540_1.frameCnt_ <= 1 then
				arg_540_1.dialog_:SetActive(false)
			end

			local var_543_8 = 1.58550699963234
			local var_543_9 = 1.175

			if var_543_8 < arg_540_1.time_ and arg_540_1.time_ <= var_543_8 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0

				arg_540_1.dialog_:SetActive(true)

				arg_540_1.dialogCg_.alpha = 0

				local var_543_10 = LeanTween.value(arg_540_1.dialog_, 0, 1, 0.3)

				var_543_10:setOnUpdate(LuaHelper.FloatAction(function(arg_544_0)
					arg_540_1.dialogCg_.alpha = arg_544_0
				end))
				var_543_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_540_1.dialog_)
					var_543_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_540_1.duration_ = arg_540_1.duration_ + 0.3

				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_11 = arg_540_1:GetWordFromCfg(322251140)
				local var_543_12 = arg_540_1:FormatText(var_543_11.content)

				arg_540_1.text_.text = var_543_12

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_13 = 47
				local var_543_14 = utf8.len(var_543_12)
				local var_543_15 = var_543_13 <= 0 and var_543_9 or var_543_9 * (var_543_14 / var_543_13)

				if var_543_15 > 0 and var_543_9 < var_543_15 then
					arg_540_1.talkMaxDuration = var_543_15
					var_543_8 = var_543_8 + 0.3

					if var_543_15 + var_543_8 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_15 + var_543_8
					end
				end

				arg_540_1.text_.text = var_543_12
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_16 = var_543_8 + 0.3
			local var_543_17 = math.max(var_543_9, arg_540_1.talkMaxDuration)

			if var_543_16 <= arg_540_1.time_ and arg_540_1.time_ < var_543_16 + var_543_17 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_16) / var_543_17

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_16 + var_543_17 and arg_540_1.time_ < var_543_16 + var_543_17 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play322251141 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 322251141
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play322251142(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 0.15

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_2 = arg_546_1:FormatText(StoryNameCfg[7].name)

				arg_546_1.leftNameTxt_.text = var_549_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, true)
				arg_546_1.iconController_:SetSelectedState("hero")

				arg_546_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_546_1.callingController_:SetSelectedState("normal")

				arg_546_1.keyicon_.color = Color.New(1, 1, 1)
				arg_546_1.icon_.color = Color.New(1, 1, 1)

				local var_549_3 = arg_546_1:GetWordFromCfg(322251141)
				local var_549_4 = arg_546_1:FormatText(var_549_3.content)

				arg_546_1.text_.text = var_549_4

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_5 = 6
				local var_549_6 = utf8.len(var_549_4)
				local var_549_7 = var_549_5 <= 0 and var_549_1 or var_549_1 * (var_549_6 / var_549_5)

				if var_549_7 > 0 and var_549_1 < var_549_7 then
					arg_546_1.talkMaxDuration = var_549_7

					if var_549_7 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_7 + var_549_0
					end
				end

				arg_546_1.text_.text = var_549_4
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_8 = math.max(var_549_1, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_8 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_0) / var_549_8

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_8 and arg_546_1.time_ < var_549_0 + var_549_8 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play322251142 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 322251142
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play322251143(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0
			local var_553_1 = 1.3

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_2 = arg_550_1:GetWordFromCfg(322251142)
				local var_553_3 = arg_550_1:FormatText(var_553_2.content)

				arg_550_1.text_.text = var_553_3

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_4 = 52
				local var_553_5 = utf8.len(var_553_3)
				local var_553_6 = var_553_4 <= 0 and var_553_1 or var_553_1 * (var_553_5 / var_553_4)

				if var_553_6 > 0 and var_553_1 < var_553_6 then
					arg_550_1.talkMaxDuration = var_553_6

					if var_553_6 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_6 + var_553_0
					end
				end

				arg_550_1.text_.text = var_553_3
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_7 = math.max(var_553_1, arg_550_1.talkMaxDuration)

			if var_553_0 <= arg_550_1.time_ and arg_550_1.time_ < var_553_0 + var_553_7 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_0) / var_553_7

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_0 + var_553_7 and arg_550_1.time_ < var_553_0 + var_553_7 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play322251143 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 322251143
		arg_554_1.duration_ = 2.63

		local var_554_0 = {
			zh = 2.633,
			ja = 2.4
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
			arg_554_1.auto_ = false
		end

		function arg_554_1.playNext_(arg_556_0)
			arg_554_1.onStoryFinished_()
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = "10149ui_story"

			if arg_554_1.actors_[var_557_0] == nil then
				local var_557_1 = Asset.Load("Char/" .. "10149ui_story")

				if not isNil(var_557_1) then
					local var_557_2 = Object.Instantiate(Asset.Load("Char/" .. "10149ui_story"), arg_554_1.stage_.transform)

					var_557_2.name = var_557_0
					var_557_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_554_1.actors_[var_557_0] = var_557_2

					local var_557_3 = var_557_2:GetComponentInChildren(typeof(CharacterEffect))

					var_557_3.enabled = true

					local var_557_4 = GameObjectTools.GetOrAddComponent(var_557_2, typeof(DynamicBoneHelper))

					if var_557_4 then
						var_557_4:EnableDynamicBone(false)
					end

					arg_554_1:ShowWeapon(var_557_3.transform, false)

					arg_554_1.var_[var_557_0 .. "Animator"] = var_557_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_554_1.var_[var_557_0 .. "Animator"].applyRootMotion = true
					arg_554_1.var_[var_557_0 .. "LipSync"] = var_557_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_557_5 = arg_554_1.actors_["10149ui_story"].transform
			local var_557_6 = 0

			if var_557_6 < arg_554_1.time_ and arg_554_1.time_ <= var_557_6 + arg_557_0 then
				arg_554_1.var_.moveOldPos10149ui_story = var_557_5.localPosition

				local var_557_7 = GameObjectTools.GetOrAddComponent(var_557_5.gameObject, typeof(DynamicBoneHelper))

				if var_557_7 then
					var_557_7:EnableDynamicBone(false)
				end
			end

			local var_557_8 = 0.001

			if var_557_6 <= arg_554_1.time_ and arg_554_1.time_ < var_557_6 + var_557_8 then
				local var_557_9 = (arg_554_1.time_ - var_557_6) / var_557_8
				local var_557_10 = Vector3.New(0, -1.05, -5.8)

				var_557_5.localPosition = Vector3.Lerp(arg_554_1.var_.moveOldPos10149ui_story, var_557_10, var_557_9)

				local var_557_11 = manager.ui.mainCamera.transform.position - var_557_5.position

				var_557_5.forward = Vector3.New(var_557_11.x, var_557_11.y, var_557_11.z)

				local var_557_12 = var_557_5.localEulerAngles

				var_557_12.z = 0
				var_557_12.x = 0
				var_557_5.localEulerAngles = var_557_12
			end

			if arg_554_1.time_ >= var_557_6 + var_557_8 and arg_554_1.time_ < var_557_6 + var_557_8 + arg_557_0 then
				var_557_5.localPosition = Vector3.New(0, -1.05, -5.8)

				local var_557_13 = manager.ui.mainCamera.transform.position - var_557_5.position

				var_557_5.forward = Vector3.New(var_557_13.x, var_557_13.y, var_557_13.z)

				local var_557_14 = var_557_5.localEulerAngles

				var_557_14.z = 0
				var_557_14.x = 0
				var_557_5.localEulerAngles = var_557_14

				local var_557_15 = GameObjectTools.GetOrAddComponent(var_557_5.gameObject, typeof(DynamicBoneHelper))

				if var_557_15 then
					var_557_15:EnableDynamicBone(true)
				end
			end

			local var_557_16 = arg_554_1.actors_["10149ui_story"]
			local var_557_17 = 0

			if var_557_17 < arg_554_1.time_ and arg_554_1.time_ <= var_557_17 + arg_557_0 and not isNil(var_557_16) and arg_554_1.var_.characterEffect10149ui_story == nil then
				arg_554_1.var_.characterEffect10149ui_story = var_557_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_18 = 0.200000002980232

			if var_557_17 <= arg_554_1.time_ and arg_554_1.time_ < var_557_17 + var_557_18 and not isNil(var_557_16) then
				local var_557_19 = (arg_554_1.time_ - var_557_17) / var_557_18

				if arg_554_1.var_.characterEffect10149ui_story and not isNil(var_557_16) then
					arg_554_1.var_.characterEffect10149ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= var_557_17 + var_557_18 and arg_554_1.time_ < var_557_17 + var_557_18 + arg_557_0 and not isNil(var_557_16) and arg_554_1.var_.characterEffect10149ui_story then
				arg_554_1.var_.characterEffect10149ui_story.fillFlat = false
			end

			local var_557_20 = 0

			if var_557_20 < arg_554_1.time_ and arg_554_1.time_ <= var_557_20 + arg_557_0 then
				arg_554_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/story10149/story10149action/10149action1_1")
			end

			local var_557_21 = 0

			if var_557_21 < arg_554_1.time_ and arg_554_1.time_ <= var_557_21 + arg_557_0 then
				arg_554_1:PlayTimeline("10149ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_557_22 = 0

			if var_557_22 < arg_554_1.time_ and arg_554_1.time_ <= var_557_22 + arg_557_0 then
				local var_557_23 = arg_554_1.actors_["10149ui_story"]

				if not isNil(var_557_23) then
					local var_557_24 = GameObjectTools.GetOrAddComponent(var_557_23, typeof(DynamicBoneHelper))

					if var_557_24 then
						var_557_24:EnableDynamicBone(true)
					end
				end
			end

			local var_557_25 = 0
			local var_557_26 = 0.2

			if var_557_25 < arg_554_1.time_ and arg_554_1.time_ <= var_557_25 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_27 = arg_554_1:FormatText(StoryNameCfg[36].name)

				arg_554_1.leftNameTxt_.text = var_557_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_28 = arg_554_1:GetWordFromCfg(322251143)
				local var_557_29 = arg_554_1:FormatText(var_557_28.content)

				arg_554_1.text_.text = var_557_29

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_30 = 8
				local var_557_31 = utf8.len(var_557_29)
				local var_557_32 = var_557_30 <= 0 and var_557_26 or var_557_26 * (var_557_31 / var_557_30)

				if var_557_32 > 0 and var_557_26 < var_557_32 then
					arg_554_1.talkMaxDuration = var_557_32

					if var_557_32 + var_557_25 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_32 + var_557_25
					end
				end

				arg_554_1.text_.text = var_557_29
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322251", "322251143", "story_v_out_322251.awb") ~= 0 then
					local var_557_33 = manager.audio:GetVoiceLength("story_v_out_322251", "322251143", "story_v_out_322251.awb") / 1000

					if var_557_33 + var_557_25 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_33 + var_557_25
					end

					if var_557_28.prefab_name ~= "" and arg_554_1.actors_[var_557_28.prefab_name] ~= nil then
						local var_557_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_28.prefab_name].transform, "story_v_out_322251", "322251143", "story_v_out_322251.awb")

						arg_554_1:RecordAudio("322251143", var_557_34)
						arg_554_1:RecordAudio("322251143", var_557_34)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_322251", "322251143", "story_v_out_322251.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_322251", "322251143", "story_v_out_322251.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_35 = math.max(var_557_26, arg_554_1.talkMaxDuration)

			if var_557_25 <= arg_554_1.time_ and arg_554_1.time_ < var_557_25 + var_557_35 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_25) / var_557_35

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_25 + var_557_35 and arg_554_1.time_ < var_557_25 + var_557_35 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10149ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_554_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST0512",
		"SofdecAsset/story/story_103222501_1.usm",
		"SofdecAsset/story/story_103222501_2.usm",
		"SofdecAsset/story/story_103222501_3.usm",
		"TextureConfig/Background/MS2207",
		"TextureConfig/Background/ST0402a"
	},
	voices = {
		"story_v_out_322251.awb"
	},
	skipMarkers = {
		322251048,
		322251060,
		322251069
	}
}
