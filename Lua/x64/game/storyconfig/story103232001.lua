return {
	Play323201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323201001
		arg_1_1.duration_ = 7.77

		local var_1_0 = {
			zh = 7.76666666666667,
			ja = 7.69966666666667
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
				arg_1_0:Play323201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2003"

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
				local var_4_5 = arg_1_1.bgs_.ST2003

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
					if iter_4_0 ~= "ST2003" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = 0
			local var_4_25 = 3
			local var_4_26 = "ST2003"

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_26)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_27 = arg_1_1:GetWordFromCfg(102)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_timeText_.text = var_4_28
				arg_1_1.text_timeText_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_29 = arg_1_1:GetWordFromCfg(501123)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_siteText_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_31 = 3

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_32 = 1.2

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_31) / var_4_32
				local var_4_34 = Color.New(0, 0, 0)

				var_4_34.a = Mathf.Lerp(0, 1, var_4_33)
				arg_1_1.mask_.color = var_4_34
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				local var_4_35 = Color.New(0, 0, 0)

				var_4_35.a = 1
				arg_1_1.mask_.color = var_4_35
			end

			local var_4_36 = 4.2

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_37 = 1.26666666666667

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

			local var_4_42 = "10171ui_story"

			if arg_1_1.actors_[var_4_42] == nil then
				local var_4_43 = Asset.Load("Char/" .. "10171ui_story")

				if not isNil(var_4_43) then
					local var_4_44 = Object.Instantiate(Asset.Load("Char/" .. "10171ui_story"), arg_1_1.stage_.transform)

					var_4_44.name = var_4_42
					var_4_44.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_42] = var_4_44

					local var_4_45 = var_4_44:GetComponentInChildren(typeof(CharacterEffect))

					var_4_45.enabled = true

					local var_4_46 = GameObjectTools.GetOrAddComponent(var_4_44, typeof(DynamicBoneHelper))

					if var_4_46 then
						var_4_46:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_45.transform, false)

					arg_1_1.var_[var_4_42 .. "Animator"] = var_4_45.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_42 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_42 .. "LipSync"] = var_4_45.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_47 = 0

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_4_48 = 0
			local var_4_49 = 0.3

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

			local var_4_54 = 3.9
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "music"

				arg_1_1:AudioAction(var_4_56, var_4_57, "bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong.awb")

				local var_4_58 = ""
				local var_4_59 = manager.audio:GetAudioName("bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong")

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

			local var_4_60 = 3.9
			local var_4_61 = 1

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				local var_4_62 = "play"
				local var_4_63 = "effect"

				arg_1_1:AudioAction(var_4_62, var_4_63, "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			local var_4_64 = "1070ui_story"

			if arg_1_1.actors_[var_4_64] == nil then
				local var_4_65 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_4_65) then
					local var_4_66 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_1_1.stage_.transform)

					var_4_66.name = var_4_64
					var_4_66.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_64] = var_4_66

					local var_4_67 = var_4_66:GetComponentInChildren(typeof(CharacterEffect))

					var_4_67.enabled = true

					local var_4_68 = GameObjectTools.GetOrAddComponent(var_4_66, typeof(DynamicBoneHelper))

					if var_4_68 then
						var_4_68:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_67.transform, false)

					arg_1_1.var_[var_4_64 .. "Animator"] = var_4_67.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_64 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_64 .. "LipSync"] = var_4_67.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_69 = arg_1_1.actors_["1070ui_story"]
			local var_4_70 = 0

			if var_4_70 < arg_1_1.time_ and arg_1_1.time_ <= var_4_70 + arg_4_0 and not isNil(var_4_69) and arg_1_1.var_.characterEffect1070ui_story == nil then
				arg_1_1.var_.characterEffect1070ui_story = var_4_69:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_71 = 0.200000002980232

			if var_4_70 <= arg_1_1.time_ and arg_1_1.time_ < var_4_70 + var_4_71 and not isNil(var_4_69) then
				local var_4_72 = (arg_1_1.time_ - var_4_70) / var_4_71

				if arg_1_1.var_.characterEffect1070ui_story and not isNil(var_4_69) then
					arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_70 + var_4_71 and arg_1_1.time_ < var_4_70 + var_4_71 + arg_4_0 and not isNil(var_4_69) and arg_1_1.var_.characterEffect1070ui_story then
				arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_73 = 5.26666666666667
			local var_4_74 = 0.2

			if var_4_73 < arg_1_1.time_ and arg_1_1.time_ <= var_4_73 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_75 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_75:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_75:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_75:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_76 = arg_1_1:FormatText(StoryNameCfg[318].name)

				arg_1_1.leftNameTxt_.text = var_4_76

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_77 = arg_1_1:GetWordFromCfg(323201001)
				local var_4_78 = arg_1_1:FormatText(var_4_77.content)

				arg_1_1.text_.text = var_4_78

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_79 = 8
				local var_4_80 = utf8.len(var_4_78)
				local var_4_81 = var_4_79 <= 0 and var_4_74 or var_4_74 * (var_4_80 / var_4_79)

				if var_4_81 > 0 and var_4_74 < var_4_81 then
					arg_1_1.talkMaxDuration = var_4_81
					var_4_73 = var_4_73 + 0.3

					if var_4_81 + var_4_73 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_81 + var_4_73
					end
				end

				arg_1_1.text_.text = var_4_78
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201001", "story_v_out_323201.awb") ~= 0 then
					local var_4_82 = manager.audio:GetVoiceLength("story_v_out_323201", "323201001", "story_v_out_323201.awb") / 1000

					if var_4_82 + var_4_73 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_82 + var_4_73
					end

					if var_4_77.prefab_name ~= "" and arg_1_1.actors_[var_4_77.prefab_name] ~= nil then
						local var_4_83 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_77.prefab_name].transform, "story_v_out_323201", "323201001", "story_v_out_323201.awb")

						arg_1_1:RecordAudio("323201001", var_4_83)
						arg_1_1:RecordAudio("323201001", var_4_83)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_323201", "323201001", "story_v_out_323201.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_323201", "323201001", "story_v_out_323201.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_84 = var_4_73 + 0.3
			local var_4_85 = math.max(var_4_74, arg_1_1.talkMaxDuration)

			if var_4_84 <= arg_1_1.time_ and arg_1_1.time_ < var_4_84 + var_4_85 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_84) / var_4_85

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_84 + var_4_85 and arg_1_1.time_ < var_4_84 + var_4_85 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323201002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 323201002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play323201003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["1070ui_story"]
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 and not isNil(var_13_0) and arg_10_1.var_.characterEffect1070ui_story == nil then
				arg_10_1.var_.characterEffect1070ui_story = var_13_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_2 = 0.200000002980232

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_2 and not isNil(var_13_0) then
				local var_13_3 = (arg_10_1.time_ - var_13_1) / var_13_2

				if arg_10_1.var_.characterEffect1070ui_story and not isNil(var_13_0) then
					local var_13_4 = Mathf.Lerp(0, 0.5, var_13_3)

					arg_10_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_10_1.var_.characterEffect1070ui_story.fillRatio = var_13_4
				end
			end

			if arg_10_1.time_ >= var_13_1 + var_13_2 and arg_10_1.time_ < var_13_1 + var_13_2 + arg_13_0 and not isNil(var_13_0) and arg_10_1.var_.characterEffect1070ui_story then
				local var_13_5 = 0.5

				arg_10_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_10_1.var_.characterEffect1070ui_story.fillRatio = var_13_5
			end

			local var_13_6 = 0
			local var_13_7 = 1.35

			if var_13_6 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_8 = arg_10_1:GetWordFromCfg(323201002)
				local var_13_9 = arg_10_1:FormatText(var_13_8.content)

				arg_10_1.text_.text = var_13_9

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_10 = 54
				local var_13_11 = utf8.len(var_13_9)
				local var_13_12 = var_13_10 <= 0 and var_13_7 or var_13_7 * (var_13_11 / var_13_10)

				if var_13_12 > 0 and var_13_7 < var_13_12 then
					arg_10_1.talkMaxDuration = var_13_12

					if var_13_12 + var_13_6 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_12 + var_13_6
					end
				end

				arg_10_1.text_.text = var_13_9
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_13 = math.max(var_13_7, arg_10_1.talkMaxDuration)

			if var_13_6 <= arg_10_1.time_ and arg_10_1.time_ < var_13_6 + var_13_13 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_6) / var_13_13

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_6 + var_13_13 and arg_10_1.time_ < var_13_6 + var_13_13 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play323201003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 323201003
		arg_14_1.duration_ = 7.13

		local var_14_0 = {
			zh = 5.066,
			ja = 7.133
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play323201004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["1070ui_story"].transform
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.moveOldPos1070ui_story = var_17_0.localPosition
			end

			local var_17_2 = 0.001

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2
				local var_17_4 = Vector3.New(0, -0.95, -6.05)

				var_17_0.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1070ui_story, var_17_4, var_17_3)

				local var_17_5 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_5.x, var_17_5.y, var_17_5.z)

				local var_17_6 = var_17_0.localEulerAngles

				var_17_6.z = 0
				var_17_6.x = 0
				var_17_0.localEulerAngles = var_17_6
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 then
				var_17_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_17_7 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_7.x, var_17_7.y, var_17_7.z)

				local var_17_8 = var_17_0.localEulerAngles

				var_17_8.z = 0
				var_17_8.x = 0
				var_17_0.localEulerAngles = var_17_8
			end

			local var_17_9 = arg_14_1.actors_["1070ui_story"]
			local var_17_10 = 0

			if var_17_10 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 and not isNil(var_17_9) and arg_14_1.var_.characterEffect1070ui_story == nil then
				arg_14_1.var_.characterEffect1070ui_story = var_17_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_11 = 0.200000002980232

			if var_17_10 <= arg_14_1.time_ and arg_14_1.time_ < var_17_10 + var_17_11 and not isNil(var_17_9) then
				local var_17_12 = (arg_14_1.time_ - var_17_10) / var_17_11

				if arg_14_1.var_.characterEffect1070ui_story and not isNil(var_17_9) then
					arg_14_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= var_17_10 + var_17_11 and arg_14_1.time_ < var_17_10 + var_17_11 + arg_17_0 and not isNil(var_17_9) and arg_14_1.var_.characterEffect1070ui_story then
				arg_14_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_17_13 = 0

			if var_17_13 < arg_14_1.time_ and arg_14_1.time_ <= var_17_13 + arg_17_0 then
				arg_14_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_17_14 = 0

			if var_17_14 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				arg_14_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_17_15 = 0
			local var_17_16 = 0.575

			if var_17_15 < arg_14_1.time_ and arg_14_1.time_ <= var_17_15 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_17 = arg_14_1:FormatText(StoryNameCfg[318].name)

				arg_14_1.leftNameTxt_.text = var_17_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_18 = arg_14_1:GetWordFromCfg(323201003)
				local var_17_19 = arg_14_1:FormatText(var_17_18.content)

				arg_14_1.text_.text = var_17_19

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_20 = 23
				local var_17_21 = utf8.len(var_17_19)
				local var_17_22 = var_17_20 <= 0 and var_17_16 or var_17_16 * (var_17_21 / var_17_20)

				if var_17_22 > 0 and var_17_16 < var_17_22 then
					arg_14_1.talkMaxDuration = var_17_22

					if var_17_22 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_22 + var_17_15
					end
				end

				arg_14_1.text_.text = var_17_19
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201003", "story_v_out_323201.awb") ~= 0 then
					local var_17_23 = manager.audio:GetVoiceLength("story_v_out_323201", "323201003", "story_v_out_323201.awb") / 1000

					if var_17_23 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_23 + var_17_15
					end

					if var_17_18.prefab_name ~= "" and arg_14_1.actors_[var_17_18.prefab_name] ~= nil then
						local var_17_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_18.prefab_name].transform, "story_v_out_323201", "323201003", "story_v_out_323201.awb")

						arg_14_1:RecordAudio("323201003", var_17_24)
						arg_14_1:RecordAudio("323201003", var_17_24)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_323201", "323201003", "story_v_out_323201.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_323201", "323201003", "story_v_out_323201.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_25 = math.max(var_17_16, arg_14_1.talkMaxDuration)

			if var_17_15 <= arg_14_1.time_ and arg_14_1.time_ < var_17_15 + var_17_25 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_15) / var_17_25

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_15 + var_17_25 and arg_14_1.time_ < var_17_15 + var_17_25 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play323201004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 323201004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play323201005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["10171ui_story"].transform
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.var_.moveOldPos10171ui_story = var_21_0.localPosition

				local var_21_2 = GameObjectTools.GetOrAddComponent(var_21_0.gameObject, typeof(DynamicBoneHelper))

				if var_21_2 then
					var_21_2:EnableDynamicBone(false)
				end
			end

			local var_21_3 = 0.001

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_3 then
				local var_21_4 = (arg_18_1.time_ - var_21_1) / var_21_3
				local var_21_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_21_0.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10171ui_story, var_21_5, var_21_4)

				local var_21_6 = manager.ui.mainCamera.transform.position - var_21_0.position

				var_21_0.forward = Vector3.New(var_21_6.x, var_21_6.y, var_21_6.z)

				local var_21_7 = var_21_0.localEulerAngles

				var_21_7.z = 0
				var_21_7.x = 0
				var_21_0.localEulerAngles = var_21_7
			end

			if arg_18_1.time_ >= var_21_1 + var_21_3 and arg_18_1.time_ < var_21_1 + var_21_3 + arg_21_0 then
				var_21_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_21_8 = manager.ui.mainCamera.transform.position - var_21_0.position

				var_21_0.forward = Vector3.New(var_21_8.x, var_21_8.y, var_21_8.z)

				local var_21_9 = var_21_0.localEulerAngles

				var_21_9.z = 0
				var_21_9.x = 0
				var_21_0.localEulerAngles = var_21_9

				local var_21_10 = GameObjectTools.GetOrAddComponent(var_21_0.gameObject, typeof(DynamicBoneHelper))

				if var_21_10 then
					var_21_10:EnableDynamicBone(true)
				end
			end

			local var_21_11 = arg_18_1.actors_["1070ui_story"].transform
			local var_21_12 = 0

			if var_21_12 < arg_18_1.time_ and arg_18_1.time_ <= var_21_12 + arg_21_0 then
				arg_18_1.var_.moveOldPos1070ui_story = var_21_11.localPosition
			end

			local var_21_13 = 0.001

			if var_21_12 <= arg_18_1.time_ and arg_18_1.time_ < var_21_12 + var_21_13 then
				local var_21_14 = (arg_18_1.time_ - var_21_12) / var_21_13
				local var_21_15 = Vector3.New(0.7, -0.95, -6.05)

				var_21_11.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1070ui_story, var_21_15, var_21_14)

				local var_21_16 = manager.ui.mainCamera.transform.position - var_21_11.position

				var_21_11.forward = Vector3.New(var_21_16.x, var_21_16.y, var_21_16.z)

				local var_21_17 = var_21_11.localEulerAngles

				var_21_17.z = 0
				var_21_17.x = 0
				var_21_11.localEulerAngles = var_21_17
			end

			if arg_18_1.time_ >= var_21_12 + var_21_13 and arg_18_1.time_ < var_21_12 + var_21_13 + arg_21_0 then
				var_21_11.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_21_18 = manager.ui.mainCamera.transform.position - var_21_11.position

				var_21_11.forward = Vector3.New(var_21_18.x, var_21_18.y, var_21_18.z)

				local var_21_19 = var_21_11.localEulerAngles

				var_21_19.z = 0
				var_21_19.x = 0
				var_21_11.localEulerAngles = var_21_19
			end

			local var_21_20 = arg_18_1.actors_["10171ui_story"]
			local var_21_21 = 0

			if var_21_21 < arg_18_1.time_ and arg_18_1.time_ <= var_21_21 + arg_21_0 and not isNil(var_21_20) and arg_18_1.var_.characterEffect10171ui_story == nil then
				arg_18_1.var_.characterEffect10171ui_story = var_21_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_22 = 0.200000002980232

			if var_21_21 <= arg_18_1.time_ and arg_18_1.time_ < var_21_21 + var_21_22 and not isNil(var_21_20) then
				local var_21_23 = (arg_18_1.time_ - var_21_21) / var_21_22

				if arg_18_1.var_.characterEffect10171ui_story and not isNil(var_21_20) then
					arg_18_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_21 + var_21_22 and arg_18_1.time_ < var_21_21 + var_21_22 + arg_21_0 and not isNil(var_21_20) and arg_18_1.var_.characterEffect10171ui_story then
				arg_18_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_21_24 = arg_18_1.actors_["1070ui_story"]
			local var_21_25 = 0

			if var_21_25 < arg_18_1.time_ and arg_18_1.time_ <= var_21_25 + arg_21_0 and not isNil(var_21_24) and arg_18_1.var_.characterEffect1070ui_story == nil then
				arg_18_1.var_.characterEffect1070ui_story = var_21_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_26 = 0.200000002980232

			if var_21_25 <= arg_18_1.time_ and arg_18_1.time_ < var_21_25 + var_21_26 and not isNil(var_21_24) then
				local var_21_27 = (arg_18_1.time_ - var_21_25) / var_21_26

				if arg_18_1.var_.characterEffect1070ui_story and not isNil(var_21_24) then
					local var_21_28 = Mathf.Lerp(0, 0.5, var_21_27)

					arg_18_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_18_1.var_.characterEffect1070ui_story.fillRatio = var_21_28
				end
			end

			if arg_18_1.time_ >= var_21_25 + var_21_26 and arg_18_1.time_ < var_21_25 + var_21_26 + arg_21_0 and not isNil(var_21_24) and arg_18_1.var_.characterEffect1070ui_story then
				local var_21_29 = 0.5

				arg_18_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_18_1.var_.characterEffect1070ui_story.fillRatio = var_21_29
			end

			local var_21_30 = 0

			if var_21_30 < arg_18_1.time_ and arg_18_1.time_ <= var_21_30 + arg_21_0 then
				arg_18_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_1")
			end

			local var_21_31 = 0

			if var_21_31 < arg_18_1.time_ and arg_18_1.time_ <= var_21_31 + arg_21_0 then
				arg_18_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_21_32 = arg_18_1.actors_["10171ui_story"]
			local var_21_33 = 0

			if var_21_33 < arg_18_1.time_ and arg_18_1.time_ <= var_21_33 + arg_21_0 then
				if arg_18_1.var_.characterEffect10171ui_story == nil then
					arg_18_1.var_.characterEffect10171ui_story = var_21_32:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_21_34 = arg_18_1.var_.characterEffect10171ui_story

				var_21_34.imageEffect:turnOff()

				var_21_34.interferenceEffect.enabled = true
				var_21_34.interferenceEffect.noise = 0.001
				var_21_34.interferenceEffect.simTimeScale = 1
				var_21_34.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_21_35 = arg_18_1.actors_["10171ui_story"]
			local var_21_36 = 0
			local var_21_37 = 5

			if var_21_36 < arg_18_1.time_ and arg_18_1.time_ <= var_21_36 + arg_21_0 then
				if arg_18_1.var_.characterEffect10171ui_story == nil then
					arg_18_1.var_.characterEffect10171ui_story = var_21_35:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_18_1.var_.characterEffect10171ui_story.imageEffect:turnOn(false)
			end

			local var_21_38 = 0
			local var_21_39 = 0.475

			if var_21_38 < arg_18_1.time_ and arg_18_1.time_ <= var_21_38 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_40 = arg_18_1:FormatText(StoryNameCfg[1451].name)

				arg_18_1.leftNameTxt_.text = var_21_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_41 = arg_18_1:GetWordFromCfg(323201004)
				local var_21_42 = arg_18_1:FormatText(var_21_41.content)

				arg_18_1.text_.text = var_21_42

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_43 = 19
				local var_21_44 = utf8.len(var_21_42)
				local var_21_45 = var_21_43 <= 0 and var_21_39 or var_21_39 * (var_21_44 / var_21_43)

				if var_21_45 > 0 and var_21_39 < var_21_45 then
					arg_18_1.talkMaxDuration = var_21_45

					if var_21_45 + var_21_38 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_45 + var_21_38
					end
				end

				arg_18_1.text_.text = var_21_42
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201004", "story_v_out_323201.awb") ~= 0 then
					local var_21_46 = manager.audio:GetVoiceLength("story_v_out_323201", "323201004", "story_v_out_323201.awb") / 1000

					if var_21_46 + var_21_38 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_46 + var_21_38
					end

					if var_21_41.prefab_name ~= "" and arg_18_1.actors_[var_21_41.prefab_name] ~= nil then
						local var_21_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_41.prefab_name].transform, "story_v_out_323201", "323201004", "story_v_out_323201.awb")

						arg_18_1:RecordAudio("323201004", var_21_47)
						arg_18_1:RecordAudio("323201004", var_21_47)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_323201", "323201004", "story_v_out_323201.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_323201", "323201004", "story_v_out_323201.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_48 = math.max(var_21_39, arg_18_1.talkMaxDuration)

			if var_21_38 <= arg_18_1.time_ and arg_18_1.time_ < var_21_38 + var_21_48 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_38) / var_21_48

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_38 + var_21_48 and arg_18_1.time_ < var_21_38 + var_21_48 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play323201005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 323201005
		arg_22_1.duration_ = 8.9

		local var_22_0 = {
			zh = 7.6,
			ja = 8.9
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play323201006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1070ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1070ui_story == nil then
				arg_22_1.var_.characterEffect1070ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.200000002980232

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect1070ui_story and not isNil(var_25_0) then
					arg_22_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1070ui_story then
				arg_22_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_25_4 = arg_22_1.actors_["10171ui_story"]
			local var_25_5 = 0

			if var_25_5 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.characterEffect10171ui_story == nil then
				arg_22_1.var_.characterEffect10171ui_story = var_25_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_6 = 0.200000002980232

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_6 and not isNil(var_25_4) then
				local var_25_7 = (arg_22_1.time_ - var_25_5) / var_25_6

				if arg_22_1.var_.characterEffect10171ui_story and not isNil(var_25_4) then
					local var_25_8 = Mathf.Lerp(0, 0.5, var_25_7)

					arg_22_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_22_1.var_.characterEffect10171ui_story.fillRatio = var_25_8
				end
			end

			if arg_22_1.time_ >= var_25_5 + var_25_6 and arg_22_1.time_ < var_25_5 + var_25_6 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.characterEffect10171ui_story then
				local var_25_9 = 0.5

				arg_22_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_22_1.var_.characterEffect10171ui_story.fillRatio = var_25_9
			end

			local var_25_10 = 0

			if var_25_10 < arg_22_1.time_ and arg_22_1.time_ <= var_25_10 + arg_25_0 then
				arg_22_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_25_11 = 0

			if var_25_11 < arg_22_1.time_ and arg_22_1.time_ <= var_25_11 + arg_25_0 then
				arg_22_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_25_12 = 0
			local var_25_13 = 0.95

			if var_25_12 < arg_22_1.time_ and arg_22_1.time_ <= var_25_12 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_14 = arg_22_1:FormatText(StoryNameCfg[318].name)

				arg_22_1.leftNameTxt_.text = var_25_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_15 = arg_22_1:GetWordFromCfg(323201005)
				local var_25_16 = arg_22_1:FormatText(var_25_15.content)

				arg_22_1.text_.text = var_25_16

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_17 = 38
				local var_25_18 = utf8.len(var_25_16)
				local var_25_19 = var_25_17 <= 0 and var_25_13 or var_25_13 * (var_25_18 / var_25_17)

				if var_25_19 > 0 and var_25_13 < var_25_19 then
					arg_22_1.talkMaxDuration = var_25_19

					if var_25_19 + var_25_12 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_19 + var_25_12
					end
				end

				arg_22_1.text_.text = var_25_16
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201005", "story_v_out_323201.awb") ~= 0 then
					local var_25_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201005", "story_v_out_323201.awb") / 1000

					if var_25_20 + var_25_12 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_20 + var_25_12
					end

					if var_25_15.prefab_name ~= "" and arg_22_1.actors_[var_25_15.prefab_name] ~= nil then
						local var_25_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_15.prefab_name].transform, "story_v_out_323201", "323201005", "story_v_out_323201.awb")

						arg_22_1:RecordAudio("323201005", var_25_21)
						arg_22_1:RecordAudio("323201005", var_25_21)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_323201", "323201005", "story_v_out_323201.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_323201", "323201005", "story_v_out_323201.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_22 = math.max(var_25_13, arg_22_1.talkMaxDuration)

			if var_25_12 <= arg_22_1.time_ and arg_22_1.time_ < var_25_12 + var_25_22 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_12) / var_25_22

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_12 + var_25_22 and arg_22_1.time_ < var_25_12 + var_25_22 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play323201006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 323201006
		arg_26_1.duration_ = 7.63

		local var_26_0 = {
			zh = 4.433,
			ja = 7.633
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play323201007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.625

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[318].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_3 = arg_26_1:GetWordFromCfg(323201006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 25
				local var_29_6 = utf8.len(var_29_4)
				local var_29_7 = var_29_5 <= 0 and var_29_1 or var_29_1 * (var_29_6 / var_29_5)

				if var_29_7 > 0 and var_29_1 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201006", "story_v_out_323201.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_323201", "323201006", "story_v_out_323201.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_323201", "323201006", "story_v_out_323201.awb")

						arg_26_1:RecordAudio("323201006", var_29_9)
						arg_26_1:RecordAudio("323201006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_323201", "323201006", "story_v_out_323201.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_323201", "323201006", "story_v_out_323201.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_10 and arg_26_1.time_ < var_29_0 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play323201007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 323201007
		arg_30_1.duration_ = 2

		local var_30_0 = {
			zh = 1.999999999999,
			ja = 2
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play323201008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10171ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10171ui_story == nil then
				arg_30_1.var_.characterEffect10171ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect10171ui_story and not isNil(var_33_0) then
					arg_30_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10171ui_story then
				arg_30_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_33_4 = arg_30_1.actors_["1070ui_story"]
			local var_33_5 = 0

			if var_33_5 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 and not isNil(var_33_4) and arg_30_1.var_.characterEffect1070ui_story == nil then
				arg_30_1.var_.characterEffect1070ui_story = var_33_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_6 = 0.200000002980232

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_6 and not isNil(var_33_4) then
				local var_33_7 = (arg_30_1.time_ - var_33_5) / var_33_6

				if arg_30_1.var_.characterEffect1070ui_story and not isNil(var_33_4) then
					local var_33_8 = Mathf.Lerp(0, 0.5, var_33_7)

					arg_30_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1070ui_story.fillRatio = var_33_8
				end
			end

			if arg_30_1.time_ >= var_33_5 + var_33_6 and arg_30_1.time_ < var_33_5 + var_33_6 + arg_33_0 and not isNil(var_33_4) and arg_30_1.var_.characterEffect1070ui_story then
				local var_33_9 = 0.5

				arg_30_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1070ui_story.fillRatio = var_33_9
			end

			local var_33_10 = 0

			if var_33_10 < arg_30_1.time_ and arg_30_1.time_ <= var_33_10 + arg_33_0 then
				arg_30_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_2")
			end

			local var_33_11 = 0

			if var_33_11 < arg_30_1.time_ and arg_30_1.time_ <= var_33_11 + arg_33_0 then
				arg_30_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_33_12 = 0
			local var_33_13 = 0.15

			if var_33_12 < arg_30_1.time_ and arg_30_1.time_ <= var_33_12 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_14 = arg_30_1:FormatText(StoryNameCfg[1451].name)

				arg_30_1.leftNameTxt_.text = var_33_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_15 = arg_30_1:GetWordFromCfg(323201007)
				local var_33_16 = arg_30_1:FormatText(var_33_15.content)

				arg_30_1.text_.text = var_33_16

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_17 = 6
				local var_33_18 = utf8.len(var_33_16)
				local var_33_19 = var_33_17 <= 0 and var_33_13 or var_33_13 * (var_33_18 / var_33_17)

				if var_33_19 > 0 and var_33_13 < var_33_19 then
					arg_30_1.talkMaxDuration = var_33_19

					if var_33_19 + var_33_12 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_19 + var_33_12
					end
				end

				arg_30_1.text_.text = var_33_16
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201007", "story_v_out_323201.awb") ~= 0 then
					local var_33_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201007", "story_v_out_323201.awb") / 1000

					if var_33_20 + var_33_12 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_20 + var_33_12
					end

					if var_33_15.prefab_name ~= "" and arg_30_1.actors_[var_33_15.prefab_name] ~= nil then
						local var_33_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_15.prefab_name].transform, "story_v_out_323201", "323201007", "story_v_out_323201.awb")

						arg_30_1:RecordAudio("323201007", var_33_21)
						arg_30_1:RecordAudio("323201007", var_33_21)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_323201", "323201007", "story_v_out_323201.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_323201", "323201007", "story_v_out_323201.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_22 = math.max(var_33_13, arg_30_1.talkMaxDuration)

			if var_33_12 <= arg_30_1.time_ and arg_30_1.time_ < var_33_12 + var_33_22 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_12) / var_33_22

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_12 + var_33_22 and arg_30_1.time_ < var_33_12 + var_33_22 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play323201008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 323201008
		arg_34_1.duration_ = 7.13

		local var_34_0 = {
			zh = 3.866,
			ja = 7.133
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play323201009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1070ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1070ui_story == nil then
				arg_34_1.var_.characterEffect1070ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect1070ui_story and not isNil(var_37_0) then
					arg_34_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1070ui_story then
				arg_34_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_37_4 = arg_34_1.actors_["10171ui_story"]
			local var_37_5 = 0

			if var_37_5 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.characterEffect10171ui_story == nil then
				arg_34_1.var_.characterEffect10171ui_story = var_37_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_6 = 0.200000002980232

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 and not isNil(var_37_4) then
				local var_37_7 = (arg_34_1.time_ - var_37_5) / var_37_6

				if arg_34_1.var_.characterEffect10171ui_story and not isNil(var_37_4) then
					local var_37_8 = Mathf.Lerp(0, 0.5, var_37_7)

					arg_34_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_34_1.var_.characterEffect10171ui_story.fillRatio = var_37_8
				end
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.characterEffect10171ui_story then
				local var_37_9 = 0.5

				arg_34_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_34_1.var_.characterEffect10171ui_story.fillRatio = var_37_9
			end

			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 then
				arg_34_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action467")
			end

			local var_37_11 = 0

			if var_37_11 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				arg_34_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_37_12 = 0
			local var_37_13 = 0.625

			if var_37_12 < arg_34_1.time_ and arg_34_1.time_ <= var_37_12 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_14 = arg_34_1:FormatText(StoryNameCfg[318].name)

				arg_34_1.leftNameTxt_.text = var_37_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_15 = arg_34_1:GetWordFromCfg(323201008)
				local var_37_16 = arg_34_1:FormatText(var_37_15.content)

				arg_34_1.text_.text = var_37_16

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_17 = 25
				local var_37_18 = utf8.len(var_37_16)
				local var_37_19 = var_37_17 <= 0 and var_37_13 or var_37_13 * (var_37_18 / var_37_17)

				if var_37_19 > 0 and var_37_13 < var_37_19 then
					arg_34_1.talkMaxDuration = var_37_19

					if var_37_19 + var_37_12 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_19 + var_37_12
					end
				end

				arg_34_1.text_.text = var_37_16
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201008", "story_v_out_323201.awb") ~= 0 then
					local var_37_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201008", "story_v_out_323201.awb") / 1000

					if var_37_20 + var_37_12 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_20 + var_37_12
					end

					if var_37_15.prefab_name ~= "" and arg_34_1.actors_[var_37_15.prefab_name] ~= nil then
						local var_37_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_15.prefab_name].transform, "story_v_out_323201", "323201008", "story_v_out_323201.awb")

						arg_34_1:RecordAudio("323201008", var_37_21)
						arg_34_1:RecordAudio("323201008", var_37_21)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_323201", "323201008", "story_v_out_323201.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_323201", "323201008", "story_v_out_323201.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_22 = math.max(var_37_13, arg_34_1.talkMaxDuration)

			if var_37_12 <= arg_34_1.time_ and arg_34_1.time_ < var_37_12 + var_37_22 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_12) / var_37_22

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_12 + var_37_22 and arg_34_1.time_ < var_37_12 + var_37_22 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play323201009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 323201009
		arg_38_1.duration_ = 15.5

		local var_38_0 = {
			zh = 12.433,
			ja = 15.5
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play323201010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 1.625

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_2 = arg_38_1:FormatText(StoryNameCfg[318].name)

				arg_38_1.leftNameTxt_.text = var_41_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_3 = arg_38_1:GetWordFromCfg(323201009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 65
				local var_41_6 = utf8.len(var_41_4)
				local var_41_7 = var_41_5 <= 0 and var_41_1 or var_41_1 * (var_41_6 / var_41_5)

				if var_41_7 > 0 and var_41_1 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201009", "story_v_out_323201.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_323201", "323201009", "story_v_out_323201.awb") / 1000

					if var_41_8 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_0
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_out_323201", "323201009", "story_v_out_323201.awb")

						arg_38_1:RecordAudio("323201009", var_41_9)
						arg_38_1:RecordAudio("323201009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_323201", "323201009", "story_v_out_323201.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_323201", "323201009", "story_v_out_323201.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_10 and arg_38_1.time_ < var_41_0 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play323201010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 323201010
		arg_42_1.duration_ = 7.5

		local var_42_0 = {
			zh = 4.633,
			ja = 7.5
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play323201011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_45_1 = 0
			local var_45_2 = 0.55

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_3 = arg_42_1:FormatText(StoryNameCfg[318].name)

				arg_42_1.leftNameTxt_.text = var_45_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_4 = arg_42_1:GetWordFromCfg(323201010)
				local var_45_5 = arg_42_1:FormatText(var_45_4.content)

				arg_42_1.text_.text = var_45_5

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_6 = 22
				local var_45_7 = utf8.len(var_45_5)
				local var_45_8 = var_45_6 <= 0 and var_45_2 or var_45_2 * (var_45_7 / var_45_6)

				if var_45_8 > 0 and var_45_2 < var_45_8 then
					arg_42_1.talkMaxDuration = var_45_8

					if var_45_8 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_5
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201010", "story_v_out_323201.awb") ~= 0 then
					local var_45_9 = manager.audio:GetVoiceLength("story_v_out_323201", "323201010", "story_v_out_323201.awb") / 1000

					if var_45_9 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_9 + var_45_1
					end

					if var_45_4.prefab_name ~= "" and arg_42_1.actors_[var_45_4.prefab_name] ~= nil then
						local var_45_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_4.prefab_name].transform, "story_v_out_323201", "323201010", "story_v_out_323201.awb")

						arg_42_1:RecordAudio("323201010", var_45_10)
						arg_42_1:RecordAudio("323201010", var_45_10)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_323201", "323201010", "story_v_out_323201.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_323201", "323201010", "story_v_out_323201.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_11 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_11 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_11

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_11 and arg_42_1.time_ < var_45_1 + var_45_11 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play323201011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 323201011
		arg_46_1.duration_ = 4.6

		local var_46_0 = {
			zh = 2.5,
			ja = 4.6
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play323201012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["10171ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10171ui_story == nil then
				arg_46_1.var_.characterEffect10171ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect10171ui_story and not isNil(var_49_0) then
					arg_46_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect10171ui_story then
				arg_46_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_49_4 = arg_46_1.actors_["1070ui_story"]
			local var_49_5 = 0

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 and not isNil(var_49_4) and arg_46_1.var_.characterEffect1070ui_story == nil then
				arg_46_1.var_.characterEffect1070ui_story = var_49_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_6 = 0.200000002980232

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 and not isNil(var_49_4) then
				local var_49_7 = (arg_46_1.time_ - var_49_5) / var_49_6

				if arg_46_1.var_.characterEffect1070ui_story and not isNil(var_49_4) then
					local var_49_8 = Mathf.Lerp(0, 0.5, var_49_7)

					arg_46_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1070ui_story.fillRatio = var_49_8
				end
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 and not isNil(var_49_4) and arg_46_1.var_.characterEffect1070ui_story then
				local var_49_9 = 0.5

				arg_46_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1070ui_story.fillRatio = var_49_9
			end

			local var_49_10 = 0

			if var_49_10 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_49_11 = 0

			if var_49_11 < arg_46_1.time_ and arg_46_1.time_ <= var_49_11 + arg_49_0 then
				arg_46_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			local var_49_12 = 0
			local var_49_13 = 0.3

			if var_49_12 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_14 = arg_46_1:FormatText(StoryNameCfg[1451].name)

				arg_46_1.leftNameTxt_.text = var_49_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_15 = arg_46_1:GetWordFromCfg(323201011)
				local var_49_16 = arg_46_1:FormatText(var_49_15.content)

				arg_46_1.text_.text = var_49_16

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_17 = 12
				local var_49_18 = utf8.len(var_49_16)
				local var_49_19 = var_49_17 <= 0 and var_49_13 or var_49_13 * (var_49_18 / var_49_17)

				if var_49_19 > 0 and var_49_13 < var_49_19 then
					arg_46_1.talkMaxDuration = var_49_19

					if var_49_19 + var_49_12 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_19 + var_49_12
					end
				end

				arg_46_1.text_.text = var_49_16
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201011", "story_v_out_323201.awb") ~= 0 then
					local var_49_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201011", "story_v_out_323201.awb") / 1000

					if var_49_20 + var_49_12 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_20 + var_49_12
					end

					if var_49_15.prefab_name ~= "" and arg_46_1.actors_[var_49_15.prefab_name] ~= nil then
						local var_49_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_15.prefab_name].transform, "story_v_out_323201", "323201011", "story_v_out_323201.awb")

						arg_46_1:RecordAudio("323201011", var_49_21)
						arg_46_1:RecordAudio("323201011", var_49_21)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_323201", "323201011", "story_v_out_323201.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_323201", "323201011", "story_v_out_323201.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_22 = math.max(var_49_13, arg_46_1.talkMaxDuration)

			if var_49_12 <= arg_46_1.time_ and arg_46_1.time_ < var_49_12 + var_49_22 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_12) / var_49_22

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_12 + var_49_22 and arg_46_1.time_ < var_49_12 + var_49_22 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play323201012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 323201012
		arg_50_1.duration_ = 6

		local var_50_0 = {
			zh = 5.6,
			ja = 6
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play323201013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.7

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[1451].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_3 = arg_50_1:GetWordFromCfg(323201012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 28
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201012", "story_v_out_323201.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_out_323201", "323201012", "story_v_out_323201.awb") / 1000

					if var_53_8 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_0
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_323201", "323201012", "story_v_out_323201.awb")

						arg_50_1:RecordAudio("323201012", var_53_9)
						arg_50_1:RecordAudio("323201012", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_323201", "323201012", "story_v_out_323201.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_323201", "323201012", "story_v_out_323201.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_10 and arg_50_1.time_ < var_53_0 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play323201013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 323201013
		arg_54_1.duration_ = 4

		local var_54_0 = {
			zh = 4,
			ja = 3.266
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play323201014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1070ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1070ui_story == nil then
				arg_54_1.var_.characterEffect1070ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1070ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1070ui_story then
				arg_54_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_57_4 = arg_54_1.actors_["10171ui_story"]
			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect10171ui_story == nil then
				arg_54_1.var_.characterEffect10171ui_story = var_57_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_6 = 0.200000002980232

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_6 and not isNil(var_57_4) then
				local var_57_7 = (arg_54_1.time_ - var_57_5) / var_57_6

				if arg_54_1.var_.characterEffect10171ui_story and not isNil(var_57_4) then
					local var_57_8 = Mathf.Lerp(0, 0.5, var_57_7)

					arg_54_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10171ui_story.fillRatio = var_57_8
				end
			end

			if arg_54_1.time_ >= var_57_5 + var_57_6 and arg_54_1.time_ < var_57_5 + var_57_6 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect10171ui_story then
				local var_57_9 = 0.5

				arg_54_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10171ui_story.fillRatio = var_57_9
			end

			local var_57_10 = 0

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 then
				arg_54_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_57_11 = 0

			if var_57_11 < arg_54_1.time_ and arg_54_1.time_ <= var_57_11 + arg_57_0 then
				arg_54_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_57_12 = 0
			local var_57_13 = 0.25

			if var_57_12 < arg_54_1.time_ and arg_54_1.time_ <= var_57_12 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_14 = arg_54_1:FormatText(StoryNameCfg[318].name)

				arg_54_1.leftNameTxt_.text = var_57_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_15 = arg_54_1:GetWordFromCfg(323201013)
				local var_57_16 = arg_54_1:FormatText(var_57_15.content)

				arg_54_1.text_.text = var_57_16

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_17 = 10
				local var_57_18 = utf8.len(var_57_16)
				local var_57_19 = var_57_17 <= 0 and var_57_13 or var_57_13 * (var_57_18 / var_57_17)

				if var_57_19 > 0 and var_57_13 < var_57_19 then
					arg_54_1.talkMaxDuration = var_57_19

					if var_57_19 + var_57_12 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_19 + var_57_12
					end
				end

				arg_54_1.text_.text = var_57_16
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201013", "story_v_out_323201.awb") ~= 0 then
					local var_57_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201013", "story_v_out_323201.awb") / 1000

					if var_57_20 + var_57_12 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_20 + var_57_12
					end

					if var_57_15.prefab_name ~= "" and arg_54_1.actors_[var_57_15.prefab_name] ~= nil then
						local var_57_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_15.prefab_name].transform, "story_v_out_323201", "323201013", "story_v_out_323201.awb")

						arg_54_1:RecordAudio("323201013", var_57_21)
						arg_54_1:RecordAudio("323201013", var_57_21)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_323201", "323201013", "story_v_out_323201.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_323201", "323201013", "story_v_out_323201.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_22 = math.max(var_57_13, arg_54_1.talkMaxDuration)

			if var_57_12 <= arg_54_1.time_ and arg_54_1.time_ < var_57_12 + var_57_22 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_12) / var_57_22

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_12 + var_57_22 and arg_54_1.time_ < var_57_12 + var_57_22 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play323201014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 323201014
		arg_58_1.duration_ = 9.4

		local var_58_0 = {
			zh = 9.4,
			ja = 9.1
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play323201015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10171ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10171ui_story == nil then
				arg_58_1.var_.characterEffect10171ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect10171ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10171ui_story then
				arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_61_4 = arg_58_1.actors_["1070ui_story"]
			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1070ui_story == nil then
				arg_58_1.var_.characterEffect1070ui_story = var_61_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_6 = 0.200000002980232

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 and not isNil(var_61_4) then
				local var_61_7 = (arg_58_1.time_ - var_61_5) / var_61_6

				if arg_58_1.var_.characterEffect1070ui_story and not isNil(var_61_4) then
					local var_61_8 = Mathf.Lerp(0, 0.5, var_61_7)

					arg_58_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1070ui_story.fillRatio = var_61_8
				end
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1070ui_story then
				local var_61_9 = 0.5

				arg_58_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1070ui_story.fillRatio = var_61_9
			end

			local var_61_10 = 0

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			local var_61_11 = 0

			if var_61_11 < arg_58_1.time_ and arg_58_1.time_ <= var_61_11 + arg_61_0 then
				arg_58_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_61_12 = 0
			local var_61_13 = 1.15

			if var_61_12 < arg_58_1.time_ and arg_58_1.time_ <= var_61_12 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_14 = arg_58_1:FormatText(StoryNameCfg[1451].name)

				arg_58_1.leftNameTxt_.text = var_61_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_15 = arg_58_1:GetWordFromCfg(323201014)
				local var_61_16 = arg_58_1:FormatText(var_61_15.content)

				arg_58_1.text_.text = var_61_16

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_17 = 46
				local var_61_18 = utf8.len(var_61_16)
				local var_61_19 = var_61_17 <= 0 and var_61_13 or var_61_13 * (var_61_18 / var_61_17)

				if var_61_19 > 0 and var_61_13 < var_61_19 then
					arg_58_1.talkMaxDuration = var_61_19

					if var_61_19 + var_61_12 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_19 + var_61_12
					end
				end

				arg_58_1.text_.text = var_61_16
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201014", "story_v_out_323201.awb") ~= 0 then
					local var_61_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201014", "story_v_out_323201.awb") / 1000

					if var_61_20 + var_61_12 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_20 + var_61_12
					end

					if var_61_15.prefab_name ~= "" and arg_58_1.actors_[var_61_15.prefab_name] ~= nil then
						local var_61_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_15.prefab_name].transform, "story_v_out_323201", "323201014", "story_v_out_323201.awb")

						arg_58_1:RecordAudio("323201014", var_61_21)
						arg_58_1:RecordAudio("323201014", var_61_21)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_323201", "323201014", "story_v_out_323201.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_323201", "323201014", "story_v_out_323201.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_22 = math.max(var_61_13, arg_58_1.talkMaxDuration)

			if var_61_12 <= arg_58_1.time_ and arg_58_1.time_ < var_61_12 + var_61_22 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_12) / var_61_22

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_12 + var_61_22 and arg_58_1.time_ < var_61_12 + var_61_22 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play323201015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 323201015
		arg_62_1.duration_ = 9.7

		local var_62_0 = {
			zh = 9.133,
			ja = 9.7
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play323201016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_65_1 = 0
			local var_65_2 = 1.3

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_3 = arg_62_1:FormatText(StoryNameCfg[1451].name)

				arg_62_1.leftNameTxt_.text = var_65_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:GetWordFromCfg(323201015)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_6 = 52
				local var_65_7 = utf8.len(var_65_5)
				local var_65_8 = var_65_6 <= 0 and var_65_2 or var_65_2 * (var_65_7 / var_65_6)

				if var_65_8 > 0 and var_65_2 < var_65_8 then
					arg_62_1.talkMaxDuration = var_65_8

					if var_65_8 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201015", "story_v_out_323201.awb") ~= 0 then
					local var_65_9 = manager.audio:GetVoiceLength("story_v_out_323201", "323201015", "story_v_out_323201.awb") / 1000

					if var_65_9 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_1
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_323201", "323201015", "story_v_out_323201.awb")

						arg_62_1:RecordAudio("323201015", var_65_10)
						arg_62_1:RecordAudio("323201015", var_65_10)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_323201", "323201015", "story_v_out_323201.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_323201", "323201015", "story_v_out_323201.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_11 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_11 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_11

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_11 and arg_62_1.time_ < var_65_1 + var_65_11 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play323201016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 323201016
		arg_66_1.duration_ = 7.93

		local var_66_0 = {
			zh = 4.266,
			ja = 7.933
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
				arg_66_0:Play323201017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1070ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1070ui_story == nil then
				arg_66_1.var_.characterEffect1070ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1070ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1070ui_story then
				arg_66_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["10171ui_story"]
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect10171ui_story == nil then
				arg_66_1.var_.characterEffect10171ui_story = var_69_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.200000002980232

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 and not isNil(var_69_4) then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6

				if arg_66_1.var_.characterEffect10171ui_story and not isNil(var_69_4) then
					local var_69_8 = Mathf.Lerp(0, 0.5, var_69_7)

					arg_66_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_66_1.var_.characterEffect10171ui_story.fillRatio = var_69_8
				end
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect10171ui_story then
				local var_69_9 = 0.5

				arg_66_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_66_1.var_.characterEffect10171ui_story.fillRatio = var_69_9
			end

			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_69_11 = 0

			if var_69_11 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_69_12 = 0
			local var_69_13 = 0.425

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_14 = arg_66_1:FormatText(StoryNameCfg[318].name)

				arg_66_1.leftNameTxt_.text = var_69_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_15 = arg_66_1:GetWordFromCfg(323201016)
				local var_69_16 = arg_66_1:FormatText(var_69_15.content)

				arg_66_1.text_.text = var_69_16

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_17 = 17
				local var_69_18 = utf8.len(var_69_16)
				local var_69_19 = var_69_17 <= 0 and var_69_13 or var_69_13 * (var_69_18 / var_69_17)

				if var_69_19 > 0 and var_69_13 < var_69_19 then
					arg_66_1.talkMaxDuration = var_69_19

					if var_69_19 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_19 + var_69_12
					end
				end

				arg_66_1.text_.text = var_69_16
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201016", "story_v_out_323201.awb") ~= 0 then
					local var_69_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201016", "story_v_out_323201.awb") / 1000

					if var_69_20 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_20 + var_69_12
					end

					if var_69_15.prefab_name ~= "" and arg_66_1.actors_[var_69_15.prefab_name] ~= nil then
						local var_69_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_15.prefab_name].transform, "story_v_out_323201", "323201016", "story_v_out_323201.awb")

						arg_66_1:RecordAudio("323201016", var_69_21)
						arg_66_1:RecordAudio("323201016", var_69_21)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_323201", "323201016", "story_v_out_323201.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_323201", "323201016", "story_v_out_323201.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_22 = math.max(var_69_13, arg_66_1.talkMaxDuration)

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_22 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_12) / var_69_22

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_12 + var_69_22 and arg_66_1.time_ < var_69_12 + var_69_22 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play323201017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 323201017
		arg_70_1.duration_ = 6.03

		local var_70_0 = {
			zh = 4.966,
			ja = 6.033
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play323201018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10171ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10171ui_story == nil then
				arg_70_1.var_.characterEffect10171ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10171ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10171ui_story then
				arg_70_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1070ui_story"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1070ui_story == nil then
				arg_70_1.var_.characterEffect1070ui_story = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.200000002980232

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect1070ui_story and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1070ui_story.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1070ui_story then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1070ui_story.fillRatio = var_73_9
			end

			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			local var_73_11 = 0

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				arg_70_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_73_12 = 0
			local var_73_13 = 0.625

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_14 = arg_70_1:FormatText(StoryNameCfg[1451].name)

				arg_70_1.leftNameTxt_.text = var_73_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_15 = arg_70_1:GetWordFromCfg(323201017)
				local var_73_16 = arg_70_1:FormatText(var_73_15.content)

				arg_70_1.text_.text = var_73_16

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_17 = 25
				local var_73_18 = utf8.len(var_73_16)
				local var_73_19 = var_73_17 <= 0 and var_73_13 or var_73_13 * (var_73_18 / var_73_17)

				if var_73_19 > 0 and var_73_13 < var_73_19 then
					arg_70_1.talkMaxDuration = var_73_19

					if var_73_19 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_19 + var_73_12
					end
				end

				arg_70_1.text_.text = var_73_16
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201017", "story_v_out_323201.awb") ~= 0 then
					local var_73_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201017", "story_v_out_323201.awb") / 1000

					if var_73_20 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_20 + var_73_12
					end

					if var_73_15.prefab_name ~= "" and arg_70_1.actors_[var_73_15.prefab_name] ~= nil then
						local var_73_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_15.prefab_name].transform, "story_v_out_323201", "323201017", "story_v_out_323201.awb")

						arg_70_1:RecordAudio("323201017", var_73_21)
						arg_70_1:RecordAudio("323201017", var_73_21)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_323201", "323201017", "story_v_out_323201.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_323201", "323201017", "story_v_out_323201.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_22 = math.max(var_73_13, arg_70_1.talkMaxDuration)

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_22 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_12) / var_73_22

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_12 + var_73_22 and arg_70_1.time_ < var_73_12 + var_73_22 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play323201018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 323201018
		arg_74_1.duration_ = 7.9

		local var_74_0 = {
			zh = 7.1,
			ja = 7.9
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
				arg_74_0:Play323201019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 1.075

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[1451].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(323201018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 43
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201018", "story_v_out_323201.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_323201", "323201018", "story_v_out_323201.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_323201", "323201018", "story_v_out_323201.awb")

						arg_74_1:RecordAudio("323201018", var_77_9)
						arg_74_1:RecordAudio("323201018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_323201", "323201018", "story_v_out_323201.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_323201", "323201018", "story_v_out_323201.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play323201019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 323201019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play323201020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10171ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10171ui_story == nil then
				arg_78_1.var_.characterEffect10171ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect10171ui_story and not isNil(var_81_0) then
					local var_81_4 = Mathf.Lerp(0, 0.5, var_81_3)

					arg_78_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10171ui_story.fillRatio = var_81_4
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10171ui_story then
				local var_81_5 = 0.5

				arg_78_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10171ui_story.fillRatio = var_81_5
			end

			local var_81_6 = 0.4
			local var_81_7 = 1

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				local var_81_8 = "play"
				local var_81_9 = "effect"

				arg_78_1:AudioAction(var_81_8, var_81_9, "se_story_221_00", "se_story_221_00_clap01", "")
			end

			local var_81_10 = 0
			local var_81_11 = 0.7

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_12 = arg_78_1:GetWordFromCfg(323201019)
				local var_81_13 = arg_78_1:FormatText(var_81_12.content)

				arg_78_1.text_.text = var_81_13

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_14 = 28
				local var_81_15 = utf8.len(var_81_13)
				local var_81_16 = var_81_14 <= 0 and var_81_11 or var_81_11 * (var_81_15 / var_81_14)

				if var_81_16 > 0 and var_81_11 < var_81_16 then
					arg_78_1.talkMaxDuration = var_81_16

					if var_81_16 + var_81_10 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_16 + var_81_10
					end
				end

				arg_78_1.text_.text = var_81_13
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_17 = math.max(var_81_11, arg_78_1.talkMaxDuration)

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_17 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_10) / var_81_17

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_10 + var_81_17 and arg_78_1.time_ < var_81_10 + var_81_17 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play323201020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 323201020
		arg_82_1.duration_ = 4.17

		local var_82_0 = {
			zh = 2.5,
			ja = 4.166
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
				arg_82_0:Play323201021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1070ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1070ui_story == nil then
				arg_82_1.var_.characterEffect1070ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect1070ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1070ui_story then
				arg_82_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_85_4 = 0

			if var_85_4 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action443")
			end

			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_85_6 = 0
			local var_85_7 = 0.3

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_8 = arg_82_1:FormatText(StoryNameCfg[318].name)

				arg_82_1.leftNameTxt_.text = var_85_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_9 = arg_82_1:GetWordFromCfg(323201020)
				local var_85_10 = arg_82_1:FormatText(var_85_9.content)

				arg_82_1.text_.text = var_85_10

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_11 = 12
				local var_85_12 = utf8.len(var_85_10)
				local var_85_13 = var_85_11 <= 0 and var_85_7 or var_85_7 * (var_85_12 / var_85_11)

				if var_85_13 > 0 and var_85_7 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_6
					end
				end

				arg_82_1.text_.text = var_85_10
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201020", "story_v_out_323201.awb") ~= 0 then
					local var_85_14 = manager.audio:GetVoiceLength("story_v_out_323201", "323201020", "story_v_out_323201.awb") / 1000

					if var_85_14 + var_85_6 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_6
					end

					if var_85_9.prefab_name ~= "" and arg_82_1.actors_[var_85_9.prefab_name] ~= nil then
						local var_85_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_9.prefab_name].transform, "story_v_out_323201", "323201020", "story_v_out_323201.awb")

						arg_82_1:RecordAudio("323201020", var_85_15)
						arg_82_1:RecordAudio("323201020", var_85_15)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_323201", "323201020", "story_v_out_323201.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_323201", "323201020", "story_v_out_323201.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_16 = math.max(var_85_7, arg_82_1.talkMaxDuration)

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_16 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_6) / var_85_16

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_6 + var_85_16 and arg_82_1.time_ < var_85_6 + var_85_16 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play323201021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 323201021
		arg_86_1.duration_ = 12.07

		local var_86_0 = {
			zh = 8.2,
			ja = 12.066
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play323201022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10171ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10171ui_story == nil then
				arg_86_1.var_.characterEffect10171ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect10171ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10171ui_story then
				arg_86_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["1070ui_story"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect1070ui_story == nil then
				arg_86_1.var_.characterEffect1070ui_story = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.200000002980232

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect1070ui_story and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1070ui_story.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect1070ui_story then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1070ui_story.fillRatio = var_89_9
			end

			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action43029")
			end

			local var_89_11 = 0

			if var_89_11 < arg_86_1.time_ and arg_86_1.time_ <= var_89_11 + arg_89_0 then
				arg_86_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_89_12 = 0
			local var_89_13 = 1.075

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_14 = arg_86_1:FormatText(StoryNameCfg[1451].name)

				arg_86_1.leftNameTxt_.text = var_89_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_15 = arg_86_1:GetWordFromCfg(323201021)
				local var_89_16 = arg_86_1:FormatText(var_89_15.content)

				arg_86_1.text_.text = var_89_16

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_17 = 43
				local var_89_18 = utf8.len(var_89_16)
				local var_89_19 = var_89_17 <= 0 and var_89_13 or var_89_13 * (var_89_18 / var_89_17)

				if var_89_19 > 0 and var_89_13 < var_89_19 then
					arg_86_1.talkMaxDuration = var_89_19

					if var_89_19 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_19 + var_89_12
					end
				end

				arg_86_1.text_.text = var_89_16
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201021", "story_v_out_323201.awb") ~= 0 then
					local var_89_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201021", "story_v_out_323201.awb") / 1000

					if var_89_20 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_20 + var_89_12
					end

					if var_89_15.prefab_name ~= "" and arg_86_1.actors_[var_89_15.prefab_name] ~= nil then
						local var_89_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_15.prefab_name].transform, "story_v_out_323201", "323201021", "story_v_out_323201.awb")

						arg_86_1:RecordAudio("323201021", var_89_21)
						arg_86_1:RecordAudio("323201021", var_89_21)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_323201", "323201021", "story_v_out_323201.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_323201", "323201021", "story_v_out_323201.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_22 = math.max(var_89_13, arg_86_1.talkMaxDuration)

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_22 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_12) / var_89_22

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_12 + var_89_22 and arg_86_1.time_ < var_89_12 + var_89_22 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play323201022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 323201022
		arg_90_1.duration_ = 7.37

		local var_90_0 = {
			zh = 5.966,
			ja = 7.366
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play323201023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.85

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[1451].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(323201022)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 34
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201022", "story_v_out_323201.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_323201", "323201022", "story_v_out_323201.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_323201", "323201022", "story_v_out_323201.awb")

						arg_90_1:RecordAudio("323201022", var_93_9)
						arg_90_1:RecordAudio("323201022", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_323201", "323201022", "story_v_out_323201.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_323201", "323201022", "story_v_out_323201.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play323201023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 323201023
		arg_94_1.duration_ = 3.87

		local var_94_0 = {
			zh = 3.5,
			ja = 3.866
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
				arg_94_0:Play323201024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1070ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1070ui_story == nil then
				arg_94_1.var_.characterEffect1070ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1070ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1070ui_story then
				arg_94_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["10171ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect10171ui_story == nil then
				arg_94_1.var_.characterEffect10171ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.200000002980232

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect10171ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_94_1.var_.characterEffect10171ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect10171ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_94_1.var_.characterEffect10171ui_story.fillRatio = var_97_9
			end

			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			local var_97_11 = 0

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_97_12 = 0
			local var_97_13 = 0.25

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_14 = arg_94_1:FormatText(StoryNameCfg[318].name)

				arg_94_1.leftNameTxt_.text = var_97_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_15 = arg_94_1:GetWordFromCfg(323201023)
				local var_97_16 = arg_94_1:FormatText(var_97_15.content)

				arg_94_1.text_.text = var_97_16

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_17 = 10
				local var_97_18 = utf8.len(var_97_16)
				local var_97_19 = var_97_17 <= 0 and var_97_13 or var_97_13 * (var_97_18 / var_97_17)

				if var_97_19 > 0 and var_97_13 < var_97_19 then
					arg_94_1.talkMaxDuration = var_97_19

					if var_97_19 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_19 + var_97_12
					end
				end

				arg_94_1.text_.text = var_97_16
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201023", "story_v_out_323201.awb") ~= 0 then
					local var_97_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201023", "story_v_out_323201.awb") / 1000

					if var_97_20 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_20 + var_97_12
					end

					if var_97_15.prefab_name ~= "" and arg_94_1.actors_[var_97_15.prefab_name] ~= nil then
						local var_97_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_15.prefab_name].transform, "story_v_out_323201", "323201023", "story_v_out_323201.awb")

						arg_94_1:RecordAudio("323201023", var_97_21)
						arg_94_1:RecordAudio("323201023", var_97_21)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_323201", "323201023", "story_v_out_323201.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_323201", "323201023", "story_v_out_323201.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_22 = math.max(var_97_13, arg_94_1.talkMaxDuration)

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_22 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_12) / var_97_22

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_12 + var_97_22 and arg_94_1.time_ < var_97_12 + var_97_22 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play323201024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 323201024
		arg_98_1.duration_ = 2

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play323201025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10171ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10171ui_story == nil then
				arg_98_1.var_.characterEffect10171ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect10171ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect10171ui_story then
				arg_98_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["1070ui_story"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1070ui_story == nil then
				arg_98_1.var_.characterEffect1070ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.200000002980232

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect1070ui_story and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1070ui_story.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1070ui_story then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1070ui_story.fillRatio = var_101_9
			end

			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action29_2")
			end

			local var_101_11 = 0
			local var_101_12 = 0.125

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_13 = arg_98_1:FormatText(StoryNameCfg[1451].name)

				arg_98_1.leftNameTxt_.text = var_101_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_14 = arg_98_1:GetWordFromCfg(323201024)
				local var_101_15 = arg_98_1:FormatText(var_101_14.content)

				arg_98_1.text_.text = var_101_15

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_16 = 5
				local var_101_17 = utf8.len(var_101_15)
				local var_101_18 = var_101_16 <= 0 and var_101_12 or var_101_12 * (var_101_17 / var_101_16)

				if var_101_18 > 0 and var_101_12 < var_101_18 then
					arg_98_1.talkMaxDuration = var_101_18

					if var_101_18 + var_101_11 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_18 + var_101_11
					end
				end

				arg_98_1.text_.text = var_101_15
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201024", "story_v_out_323201.awb") ~= 0 then
					local var_101_19 = manager.audio:GetVoiceLength("story_v_out_323201", "323201024", "story_v_out_323201.awb") / 1000

					if var_101_19 + var_101_11 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_19 + var_101_11
					end

					if var_101_14.prefab_name ~= "" and arg_98_1.actors_[var_101_14.prefab_name] ~= nil then
						local var_101_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_14.prefab_name].transform, "story_v_out_323201", "323201024", "story_v_out_323201.awb")

						arg_98_1:RecordAudio("323201024", var_101_20)
						arg_98_1:RecordAudio("323201024", var_101_20)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_323201", "323201024", "story_v_out_323201.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_323201", "323201024", "story_v_out_323201.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_21 = math.max(var_101_12, arg_98_1.talkMaxDuration)

			if var_101_11 <= arg_98_1.time_ and arg_98_1.time_ < var_101_11 + var_101_21 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_11) / var_101_21

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_11 + var_101_21 and arg_98_1.time_ < var_101_11 + var_101_21 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play323201025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 323201025
		arg_102_1.duration_ = 9.27

		local var_102_0 = {
			zh = 9.033,
			ja = 9.266
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play323201026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1070ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1070ui_story == nil then
				arg_102_1.var_.characterEffect1070ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1070ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1070ui_story then
				arg_102_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["10171ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect10171ui_story == nil then
				arg_102_1.var_.characterEffect10171ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.200000002980232

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect10171ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10171ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect10171ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10171ui_story.fillRatio = var_105_9
			end

			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_12 = 0
			local var_105_13 = 1

			if var_105_12 < arg_102_1.time_ and arg_102_1.time_ <= var_105_12 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_14 = arg_102_1:FormatText(StoryNameCfg[318].name)

				arg_102_1.leftNameTxt_.text = var_105_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_15 = arg_102_1:GetWordFromCfg(323201025)
				local var_105_16 = arg_102_1:FormatText(var_105_15.content)

				arg_102_1.text_.text = var_105_16

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_17 = 40
				local var_105_18 = utf8.len(var_105_16)
				local var_105_19 = var_105_17 <= 0 and var_105_13 or var_105_13 * (var_105_18 / var_105_17)

				if var_105_19 > 0 and var_105_13 < var_105_19 then
					arg_102_1.talkMaxDuration = var_105_19

					if var_105_19 + var_105_12 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_19 + var_105_12
					end
				end

				arg_102_1.text_.text = var_105_16
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201025", "story_v_out_323201.awb") ~= 0 then
					local var_105_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201025", "story_v_out_323201.awb") / 1000

					if var_105_20 + var_105_12 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_20 + var_105_12
					end

					if var_105_15.prefab_name ~= "" and arg_102_1.actors_[var_105_15.prefab_name] ~= nil then
						local var_105_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_15.prefab_name].transform, "story_v_out_323201", "323201025", "story_v_out_323201.awb")

						arg_102_1:RecordAudio("323201025", var_105_21)
						arg_102_1:RecordAudio("323201025", var_105_21)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_323201", "323201025", "story_v_out_323201.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_323201", "323201025", "story_v_out_323201.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_22 = math.max(var_105_13, arg_102_1.talkMaxDuration)

			if var_105_12 <= arg_102_1.time_ and arg_102_1.time_ < var_105_12 + var_105_22 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_12) / var_105_22

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_12 + var_105_22 and arg_102_1.time_ < var_105_12 + var_105_22 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play323201026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 323201026
		arg_106_1.duration_ = 7.3

		local var_106_0 = {
			zh = 4.5,
			ja = 7.3
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play323201027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10171ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10171ui_story == nil then
				arg_106_1.var_.characterEffect10171ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect10171ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10171ui_story then
				arg_106_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_109_4 = arg_106_1.actors_["1070ui_story"]
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1070ui_story == nil then
				arg_106_1.var_.characterEffect1070ui_story = var_109_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.200000002980232

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 and not isNil(var_109_4) then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6

				if arg_106_1.var_.characterEffect1070ui_story and not isNil(var_109_4) then
					local var_109_8 = Mathf.Lerp(0, 0.5, var_109_7)

					arg_106_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1070ui_story.fillRatio = var_109_8
				end
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1070ui_story then
				local var_109_9 = 0.5

				arg_106_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1070ui_story.fillRatio = var_109_9
			end

			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_109_11 = 0

			if var_109_11 < arg_106_1.time_ and arg_106_1.time_ <= var_109_11 + arg_109_0 then
				arg_106_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_109_12 = 0
			local var_109_13 = 0.525

			if var_109_12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_14 = arg_106_1:FormatText(StoryNameCfg[1451].name)

				arg_106_1.leftNameTxt_.text = var_109_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_15 = arg_106_1:GetWordFromCfg(323201026)
				local var_109_16 = arg_106_1:FormatText(var_109_15.content)

				arg_106_1.text_.text = var_109_16

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_17 = 21
				local var_109_18 = utf8.len(var_109_16)
				local var_109_19 = var_109_17 <= 0 and var_109_13 or var_109_13 * (var_109_18 / var_109_17)

				if var_109_19 > 0 and var_109_13 < var_109_19 then
					arg_106_1.talkMaxDuration = var_109_19

					if var_109_19 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_19 + var_109_12
					end
				end

				arg_106_1.text_.text = var_109_16
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201026", "story_v_out_323201.awb") ~= 0 then
					local var_109_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201026", "story_v_out_323201.awb") / 1000

					if var_109_20 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_20 + var_109_12
					end

					if var_109_15.prefab_name ~= "" and arg_106_1.actors_[var_109_15.prefab_name] ~= nil then
						local var_109_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_15.prefab_name].transform, "story_v_out_323201", "323201026", "story_v_out_323201.awb")

						arg_106_1:RecordAudio("323201026", var_109_21)
						arg_106_1:RecordAudio("323201026", var_109_21)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_323201", "323201026", "story_v_out_323201.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_323201", "323201026", "story_v_out_323201.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_22 = math.max(var_109_13, arg_106_1.talkMaxDuration)

			if var_109_12 <= arg_106_1.time_ and arg_106_1.time_ < var_109_12 + var_109_22 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_12) / var_109_22

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_12 + var_109_22 and arg_106_1.time_ < var_109_12 + var_109_22 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play323201027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 323201027
		arg_110_1.duration_ = 9

		local var_110_0 = {
			zh = 4.833,
			ja = 9
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
				arg_110_0:Play323201028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1070ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1070ui_story == nil then
				arg_110_1.var_.characterEffect1070ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1070ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1070ui_story then
				arg_110_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["10171ui_story"]
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect10171ui_story == nil then
				arg_110_1.var_.characterEffect10171ui_story = var_113_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_6 = 0.200000002980232

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 and not isNil(var_113_4) then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6

				if arg_110_1.var_.characterEffect10171ui_story and not isNil(var_113_4) then
					local var_113_8 = Mathf.Lerp(0, 0.5, var_113_7)

					arg_110_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10171ui_story.fillRatio = var_113_8
				end
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect10171ui_story then
				local var_113_9 = 0.5

				arg_110_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10171ui_story.fillRatio = var_113_9
			end

			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_113_11 = 0

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_113_12 = 0
			local var_113_13 = 0.7

			if var_113_12 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_14 = arg_110_1:FormatText(StoryNameCfg[318].name)

				arg_110_1.leftNameTxt_.text = var_113_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_15 = arg_110_1:GetWordFromCfg(323201027)
				local var_113_16 = arg_110_1:FormatText(var_113_15.content)

				arg_110_1.text_.text = var_113_16

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_17 = 28
				local var_113_18 = utf8.len(var_113_16)
				local var_113_19 = var_113_17 <= 0 and var_113_13 or var_113_13 * (var_113_18 / var_113_17)

				if var_113_19 > 0 and var_113_13 < var_113_19 then
					arg_110_1.talkMaxDuration = var_113_19

					if var_113_19 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_19 + var_113_12
					end
				end

				arg_110_1.text_.text = var_113_16
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201027", "story_v_out_323201.awb") ~= 0 then
					local var_113_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201027", "story_v_out_323201.awb") / 1000

					if var_113_20 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_20 + var_113_12
					end

					if var_113_15.prefab_name ~= "" and arg_110_1.actors_[var_113_15.prefab_name] ~= nil then
						local var_113_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_15.prefab_name].transform, "story_v_out_323201", "323201027", "story_v_out_323201.awb")

						arg_110_1:RecordAudio("323201027", var_113_21)
						arg_110_1:RecordAudio("323201027", var_113_21)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_323201", "323201027", "story_v_out_323201.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_323201", "323201027", "story_v_out_323201.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_22 = math.max(var_113_13, arg_110_1.talkMaxDuration)

			if var_113_12 <= arg_110_1.time_ and arg_110_1.time_ < var_113_12 + var_113_22 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_12) / var_113_22

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_12 + var_113_22 and arg_110_1.time_ < var_113_12 + var_113_22 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play323201028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 323201028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play323201029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["10171ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos10171ui_story = var_117_0.localPosition

				local var_117_2 = GameObjectTools.GetOrAddComponent(var_117_0.gameObject, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(false)
				end
			end

			local var_117_3 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_3 then
				local var_117_4 = (arg_114_1.time_ - var_117_1) / var_117_3
				local var_117_5 = Vector3.New(0, 100, 0)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10171ui_story, var_117_5, var_117_4)

				local var_117_6 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_6.x, var_117_6.y, var_117_6.z)

				local var_117_7 = var_117_0.localEulerAngles

				var_117_7.z = 0
				var_117_7.x = 0
				var_117_0.localEulerAngles = var_117_7
			end

			if arg_114_1.time_ >= var_117_1 + var_117_3 and arg_114_1.time_ < var_117_1 + var_117_3 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_117_11 = arg_114_1.actors_["1070ui_story"].transform
			local var_117_12 = 0

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.var_.moveOldPos1070ui_story = var_117_11.localPosition
			end

			local var_117_13 = 0.001

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_13 then
				local var_117_14 = (arg_114_1.time_ - var_117_12) / var_117_13
				local var_117_15 = Vector3.New(0, 100, 0)

				var_117_11.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1070ui_story, var_117_15, var_117_14)

				local var_117_16 = manager.ui.mainCamera.transform.position - var_117_11.position

				var_117_11.forward = Vector3.New(var_117_16.x, var_117_16.y, var_117_16.z)

				local var_117_17 = var_117_11.localEulerAngles

				var_117_17.z = 0
				var_117_17.x = 0
				var_117_11.localEulerAngles = var_117_17
			end

			if arg_114_1.time_ >= var_117_12 + var_117_13 and arg_114_1.time_ < var_117_12 + var_117_13 + arg_117_0 then
				var_117_11.localPosition = Vector3.New(0, 100, 0)

				local var_117_18 = manager.ui.mainCamera.transform.position - var_117_11.position

				var_117_11.forward = Vector3.New(var_117_18.x, var_117_18.y, var_117_18.z)

				local var_117_19 = var_117_11.localEulerAngles

				var_117_19.z = 0
				var_117_19.x = 0
				var_117_11.localEulerAngles = var_117_19
			end

			local var_117_20 = arg_114_1.actors_["1070ui_story"]
			local var_117_21 = 0

			if var_117_21 < arg_114_1.time_ and arg_114_1.time_ <= var_117_21 + arg_117_0 and not isNil(var_117_20) and arg_114_1.var_.characterEffect1070ui_story == nil then
				arg_114_1.var_.characterEffect1070ui_story = var_117_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_22 = 0.200000002980232

			if var_117_21 <= arg_114_1.time_ and arg_114_1.time_ < var_117_21 + var_117_22 and not isNil(var_117_20) then
				local var_117_23 = (arg_114_1.time_ - var_117_21) / var_117_22

				if arg_114_1.var_.characterEffect1070ui_story and not isNil(var_117_20) then
					local var_117_24 = Mathf.Lerp(0, 0.5, var_117_23)

					arg_114_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1070ui_story.fillRatio = var_117_24
				end
			end

			if arg_114_1.time_ >= var_117_21 + var_117_22 and arg_114_1.time_ < var_117_21 + var_117_22 + arg_117_0 and not isNil(var_117_20) and arg_114_1.var_.characterEffect1070ui_story then
				local var_117_25 = 0.5

				arg_114_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1070ui_story.fillRatio = var_117_25
			end

			local var_117_26 = 0
			local var_117_27 = 0.75

			if var_117_26 < arg_114_1.time_ and arg_114_1.time_ <= var_117_26 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_28 = arg_114_1:GetWordFromCfg(323201028)
				local var_117_29 = arg_114_1:FormatText(var_117_28.content)

				arg_114_1.text_.text = var_117_29

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_30 = 30
				local var_117_31 = utf8.len(var_117_29)
				local var_117_32 = var_117_30 <= 0 and var_117_27 or var_117_27 * (var_117_31 / var_117_30)

				if var_117_32 > 0 and var_117_27 < var_117_32 then
					arg_114_1.talkMaxDuration = var_117_32

					if var_117_32 + var_117_26 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_32 + var_117_26
					end
				end

				arg_114_1.text_.text = var_117_29
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_33 = math.max(var_117_27, arg_114_1.talkMaxDuration)

			if var_117_26 <= arg_114_1.time_ and arg_114_1.time_ < var_117_26 + var_117_33 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_26) / var_117_33

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_26 + var_117_33 and arg_114_1.time_ < var_117_26 + var_117_33 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play323201029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 323201029
		arg_118_1.duration_ = 9.8

		local var_118_0 = {
			zh = 7.9,
			ja = 9.8
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
				arg_118_0:Play323201030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1070ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1070ui_story == nil then
				arg_118_1.var_.characterEffect1070ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1070ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1070ui_story then
				arg_118_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_121_4 = 0

			if var_121_4 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 then
				arg_118_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_121_6 = arg_118_1.actors_["1070ui_story"].transform
			local var_121_7 = 0

			if var_121_7 < arg_118_1.time_ and arg_118_1.time_ <= var_121_7 + arg_121_0 then
				arg_118_1.var_.moveOldPos1070ui_story = var_121_6.localPosition
			end

			local var_121_8 = 0.001

			if var_121_7 <= arg_118_1.time_ and arg_118_1.time_ < var_121_7 + var_121_8 then
				local var_121_9 = (arg_118_1.time_ - var_121_7) / var_121_8
				local var_121_10 = Vector3.New(0, -0.95, -6.05)

				var_121_6.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1070ui_story, var_121_10, var_121_9)

				local var_121_11 = manager.ui.mainCamera.transform.position - var_121_6.position

				var_121_6.forward = Vector3.New(var_121_11.x, var_121_11.y, var_121_11.z)

				local var_121_12 = var_121_6.localEulerAngles

				var_121_12.z = 0
				var_121_12.x = 0
				var_121_6.localEulerAngles = var_121_12
			end

			if arg_118_1.time_ >= var_121_7 + var_121_8 and arg_118_1.time_ < var_121_7 + var_121_8 + arg_121_0 then
				var_121_6.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_121_13 = manager.ui.mainCamera.transform.position - var_121_6.position

				var_121_6.forward = Vector3.New(var_121_13.x, var_121_13.y, var_121_13.z)

				local var_121_14 = var_121_6.localEulerAngles

				var_121_14.z = 0
				var_121_14.x = 0
				var_121_6.localEulerAngles = var_121_14
			end

			local var_121_15 = 0
			local var_121_16 = 1.2

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[318].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(323201029)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 48
				local var_121_21 = utf8.len(var_121_19)
				local var_121_22 = var_121_20 <= 0 and var_121_16 or var_121_16 * (var_121_21 / var_121_20)

				if var_121_22 > 0 and var_121_16 < var_121_22 then
					arg_118_1.talkMaxDuration = var_121_22

					if var_121_22 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_22 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_19
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201029", "story_v_out_323201.awb") ~= 0 then
					local var_121_23 = manager.audio:GetVoiceLength("story_v_out_323201", "323201029", "story_v_out_323201.awb") / 1000

					if var_121_23 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_15
					end

					if var_121_18.prefab_name ~= "" and arg_118_1.actors_[var_121_18.prefab_name] ~= nil then
						local var_121_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_18.prefab_name].transform, "story_v_out_323201", "323201029", "story_v_out_323201.awb")

						arg_118_1:RecordAudio("323201029", var_121_24)
						arg_118_1:RecordAudio("323201029", var_121_24)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_323201", "323201029", "story_v_out_323201.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_323201", "323201029", "story_v_out_323201.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_25 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_25 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_15) / var_121_25

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_15 + var_121_25 and arg_118_1.time_ < var_121_15 + var_121_25 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play323201030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 323201030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play323201031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1070ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1070ui_story == nil then
				arg_122_1.var_.characterEffect1070ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1070ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1070ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1070ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1070ui_story.fillRatio = var_125_5
			end

			local var_125_6 = arg_122_1.actors_["10171ui_story"].transform
			local var_125_7 = 0

			if var_125_7 < arg_122_1.time_ and arg_122_1.time_ <= var_125_7 + arg_125_0 then
				arg_122_1.var_.moveOldPos10171ui_story = var_125_6.localPosition

				local var_125_8 = GameObjectTools.GetOrAddComponent(var_125_6.gameObject, typeof(DynamicBoneHelper))

				if var_125_8 then
					var_125_8:EnableDynamicBone(false)
				end
			end

			local var_125_9 = 0.001

			if var_125_7 <= arg_122_1.time_ and arg_122_1.time_ < var_125_7 + var_125_9 then
				local var_125_10 = (arg_122_1.time_ - var_125_7) / var_125_9
				local var_125_11 = Vector3.New(0, 100, 0)

				var_125_6.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10171ui_story, var_125_11, var_125_10)

				local var_125_12 = manager.ui.mainCamera.transform.position - var_125_6.position

				var_125_6.forward = Vector3.New(var_125_12.x, var_125_12.y, var_125_12.z)

				local var_125_13 = var_125_6.localEulerAngles

				var_125_13.z = 0
				var_125_13.x = 0
				var_125_6.localEulerAngles = var_125_13
			end

			if arg_122_1.time_ >= var_125_7 + var_125_9 and arg_122_1.time_ < var_125_7 + var_125_9 + arg_125_0 then
				var_125_6.localPosition = Vector3.New(0, 100, 0)

				local var_125_14 = manager.ui.mainCamera.transform.position - var_125_6.position

				var_125_6.forward = Vector3.New(var_125_14.x, var_125_14.y, var_125_14.z)

				local var_125_15 = var_125_6.localEulerAngles

				var_125_15.z = 0
				var_125_15.x = 0
				var_125_6.localEulerAngles = var_125_15

				local var_125_16 = GameObjectTools.GetOrAddComponent(var_125_6.gameObject, typeof(DynamicBoneHelper))

				if var_125_16 then
					var_125_16:EnableDynamicBone(true)
				end
			end

			local var_125_17 = arg_122_1.actors_["1070ui_story"].transform
			local var_125_18 = 0

			if var_125_18 < arg_122_1.time_ and arg_122_1.time_ <= var_125_18 + arg_125_0 then
				arg_122_1.var_.moveOldPos1070ui_story = var_125_17.localPosition
			end

			local var_125_19 = 0.001

			if var_125_18 <= arg_122_1.time_ and arg_122_1.time_ < var_125_18 + var_125_19 then
				local var_125_20 = (arg_122_1.time_ - var_125_18) / var_125_19
				local var_125_21 = Vector3.New(0, 100, 0)

				var_125_17.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1070ui_story, var_125_21, var_125_20)

				local var_125_22 = manager.ui.mainCamera.transform.position - var_125_17.position

				var_125_17.forward = Vector3.New(var_125_22.x, var_125_22.y, var_125_22.z)

				local var_125_23 = var_125_17.localEulerAngles

				var_125_23.z = 0
				var_125_23.x = 0
				var_125_17.localEulerAngles = var_125_23
			end

			if arg_122_1.time_ >= var_125_18 + var_125_19 and arg_122_1.time_ < var_125_18 + var_125_19 + arg_125_0 then
				var_125_17.localPosition = Vector3.New(0, 100, 0)

				local var_125_24 = manager.ui.mainCamera.transform.position - var_125_17.position

				var_125_17.forward = Vector3.New(var_125_24.x, var_125_24.y, var_125_24.z)

				local var_125_25 = var_125_17.localEulerAngles

				var_125_25.z = 0
				var_125_25.x = 0
				var_125_17.localEulerAngles = var_125_25
			end

			local var_125_26 = 0
			local var_125_27 = 0.925

			if var_125_26 < arg_122_1.time_ and arg_122_1.time_ <= var_125_26 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_28 = arg_122_1:GetWordFromCfg(323201030)
				local var_125_29 = arg_122_1:FormatText(var_125_28.content)

				arg_122_1.text_.text = var_125_29

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_30 = 37
				local var_125_31 = utf8.len(var_125_29)
				local var_125_32 = var_125_30 <= 0 and var_125_27 or var_125_27 * (var_125_31 / var_125_30)

				if var_125_32 > 0 and var_125_27 < var_125_32 then
					arg_122_1.talkMaxDuration = var_125_32

					if var_125_32 + var_125_26 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_32 + var_125_26
					end
				end

				arg_122_1.text_.text = var_125_29
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_33 = math.max(var_125_27, arg_122_1.talkMaxDuration)

			if var_125_26 <= arg_122_1.time_ and arg_122_1.time_ < var_125_26 + var_125_33 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_26) / var_125_33

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_26 + var_125_33 and arg_122_1.time_ < var_125_26 + var_125_33 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play323201031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 323201031
		arg_126_1.duration_ = 3.47

		local var_126_0 = {
			zh = 2.3,
			ja = 3.466
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
				arg_126_0:Play323201032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1070ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos1070ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(0, 100, 0)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1070ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0, 100, 0)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = arg_126_1.actors_["1070ui_story"]
			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect1070ui_story == nil then
				arg_126_1.var_.characterEffect1070ui_story = var_129_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_11 = 0.200000002980232

			if var_129_10 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_11 and not isNil(var_129_9) then
				local var_129_12 = (arg_126_1.time_ - var_129_10) / var_129_11

				if arg_126_1.var_.characterEffect1070ui_story and not isNil(var_129_9) then
					arg_126_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_10 + var_129_11 and arg_126_1.time_ < var_129_10 + var_129_11 + arg_129_0 and not isNil(var_129_9) and arg_126_1.var_.characterEffect1070ui_story then
				arg_126_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_129_13 = 0

			if var_129_13 < arg_126_1.time_ and arg_126_1.time_ <= var_129_13 + arg_129_0 then
				arg_126_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_129_14 = 0

			if var_129_14 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 then
				arg_126_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_129_15 = 0
			local var_129_16 = 0.3

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_17 = arg_126_1:FormatText(StoryNameCfg[318].name)

				arg_126_1.leftNameTxt_.text = var_129_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_18 = arg_126_1:GetWordFromCfg(323201031)
				local var_129_19 = arg_126_1:FormatText(var_129_18.content)

				arg_126_1.text_.text = var_129_19

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_20 = 12
				local var_129_21 = utf8.len(var_129_19)
				local var_129_22 = var_129_20 <= 0 and var_129_16 or var_129_16 * (var_129_21 / var_129_20)

				if var_129_22 > 0 and var_129_16 < var_129_22 then
					arg_126_1.talkMaxDuration = var_129_22

					if var_129_22 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_22 + var_129_15
					end
				end

				arg_126_1.text_.text = var_129_19
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201031", "story_v_out_323201.awb") ~= 0 then
					local var_129_23 = manager.audio:GetVoiceLength("story_v_out_323201", "323201031", "story_v_out_323201.awb") / 1000

					if var_129_23 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_23 + var_129_15
					end

					if var_129_18.prefab_name ~= "" and arg_126_1.actors_[var_129_18.prefab_name] ~= nil then
						local var_129_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_18.prefab_name].transform, "story_v_out_323201", "323201031", "story_v_out_323201.awb")

						arg_126_1:RecordAudio("323201031", var_129_24)
						arg_126_1:RecordAudio("323201031", var_129_24)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_323201", "323201031", "story_v_out_323201.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_323201", "323201031", "story_v_out_323201.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_25 = math.max(var_129_16, arg_126_1.talkMaxDuration)

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_25 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_15) / var_129_25

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_15 + var_129_25 and arg_126_1.time_ < var_129_15 + var_129_25 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play323201032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 323201032
		arg_130_1.duration_ = 3.1

		local var_130_0 = {
			zh = 1.933,
			ja = 3.1
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play323201033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.25

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_2 = arg_130_1:FormatText(StoryNameCfg[318].name)

				arg_130_1.leftNameTxt_.text = var_133_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_3 = arg_130_1:GetWordFromCfg(323201032)
				local var_133_4 = arg_130_1:FormatText(var_133_3.content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 10
				local var_133_6 = utf8.len(var_133_4)
				local var_133_7 = var_133_5 <= 0 and var_133_1 or var_133_1 * (var_133_6 / var_133_5)

				if var_133_7 > 0 and var_133_1 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201032", "story_v_out_323201.awb") ~= 0 then
					local var_133_8 = manager.audio:GetVoiceLength("story_v_out_323201", "323201032", "story_v_out_323201.awb") / 1000

					if var_133_8 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_0
					end

					if var_133_3.prefab_name ~= "" and arg_130_1.actors_[var_133_3.prefab_name] ~= nil then
						local var_133_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_3.prefab_name].transform, "story_v_out_323201", "323201032", "story_v_out_323201.awb")

						arg_130_1:RecordAudio("323201032", var_133_9)
						arg_130_1:RecordAudio("323201032", var_133_9)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_323201", "323201032", "story_v_out_323201.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_323201", "323201032", "story_v_out_323201.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_10 and arg_130_1.time_ < var_133_0 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play323201033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 323201033
		arg_134_1.duration_ = 5.63

		local var_134_0 = {
			zh = 5.033,
			ja = 5.633
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play323201034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_2 = 0
			local var_137_3 = 0.425

			if var_137_2 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_4 = arg_134_1:FormatText(StoryNameCfg[318].name)

				arg_134_1.leftNameTxt_.text = var_137_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_5 = arg_134_1:GetWordFromCfg(323201033)
				local var_137_6 = arg_134_1:FormatText(var_137_5.content)

				arg_134_1.text_.text = var_137_6

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 17
				local var_137_8 = utf8.len(var_137_6)
				local var_137_9 = var_137_7 <= 0 and var_137_3 or var_137_3 * (var_137_8 / var_137_7)

				if var_137_9 > 0 and var_137_3 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_2
					end
				end

				arg_134_1.text_.text = var_137_6
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201033", "story_v_out_323201.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_323201", "323201033", "story_v_out_323201.awb") / 1000

					if var_137_10 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_2
					end

					if var_137_5.prefab_name ~= "" and arg_134_1.actors_[var_137_5.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_5.prefab_name].transform, "story_v_out_323201", "323201033", "story_v_out_323201.awb")

						arg_134_1:RecordAudio("323201033", var_137_11)
						arg_134_1:RecordAudio("323201033", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_323201", "323201033", "story_v_out_323201.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_323201", "323201033", "story_v_out_323201.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_3, arg_134_1.talkMaxDuration)

			if var_137_2 <= arg_134_1.time_ and arg_134_1.time_ < var_137_2 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_2) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_2 + var_137_12 and arg_134_1.time_ < var_137_2 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play323201034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 323201034
		arg_138_1.duration_ = 5.03

		local var_138_0 = {
			zh = 2.8,
			ja = 5.033
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play323201035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1070ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos1070ui_story = var_141_0.localPosition
			end

			local var_141_2 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2
				local var_141_4 = Vector3.New(0, 100, 0)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1070ui_story, var_141_4, var_141_3)

				local var_141_5 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_5.x, var_141_5.y, var_141_5.z)

				local var_141_6 = var_141_0.localEulerAngles

				var_141_6.z = 0
				var_141_6.x = 0
				var_141_0.localEulerAngles = var_141_6
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(0, 100, 0)

				local var_141_7 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_7.x, var_141_7.y, var_141_7.z)

				local var_141_8 = var_141_0.localEulerAngles

				var_141_8.z = 0
				var_141_8.x = 0
				var_141_0.localEulerAngles = var_141_8
			end

			local var_141_9 = 0

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 then
				arg_138_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_141_11 = 0

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1.allBtn_.enabled = false
			end

			local var_141_12 = 1.7

			if arg_138_1.time_ >= var_141_11 + var_141_12 and arg_138_1.time_ < var_141_11 + var_141_12 + arg_141_0 then
				arg_138_1.allBtn_.enabled = true
			end

			local var_141_13 = 1.13333333333333
			local var_141_14 = 0.866666666666667

			if var_141_13 < arg_138_1.time_ and arg_138_1.time_ <= var_141_13 + arg_141_0 then
				local var_141_15 = "play"
				local var_141_16 = "effect"

				arg_138_1:AudioAction(var_141_15, var_141_16, "se_story_145", "se_story_145_1032206shake", "")
			end

			local var_141_17 = 0.366666666666667
			local var_141_18 = 1

			if var_141_17 < arg_138_1.time_ and arg_138_1.time_ <= var_141_17 + arg_141_0 then
				local var_141_19 = "play"
				local var_141_20 = "effect"

				arg_138_1:AudioAction(var_141_19, var_141_20, "se_story_148", "se_story_148_forest_loop_down", "")
			end

			local var_141_21 = 0
			local var_141_22 = 0.225

			if var_141_21 < arg_138_1.time_ and arg_138_1.time_ <= var_141_21 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_23 = arg_138_1:FormatText(StoryNameCfg[318].name)

				arg_138_1.leftNameTxt_.text = var_141_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_5")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_24 = arg_138_1:GetWordFromCfg(323201034)
				local var_141_25 = arg_138_1:FormatText(var_141_24.content)

				arg_138_1.text_.text = var_141_25

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_26 = 9
				local var_141_27 = utf8.len(var_141_25)
				local var_141_28 = var_141_26 <= 0 and var_141_22 or var_141_22 * (var_141_27 / var_141_26)

				if var_141_28 > 0 and var_141_22 < var_141_28 then
					arg_138_1.talkMaxDuration = var_141_28

					if var_141_28 + var_141_21 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_28 + var_141_21
					end
				end

				arg_138_1.text_.text = var_141_25
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201034", "story_v_out_323201.awb") ~= 0 then
					local var_141_29 = manager.audio:GetVoiceLength("story_v_out_323201", "323201034", "story_v_out_323201.awb") / 1000

					if var_141_29 + var_141_21 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_29 + var_141_21
					end

					if var_141_24.prefab_name ~= "" and arg_138_1.actors_[var_141_24.prefab_name] ~= nil then
						local var_141_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_24.prefab_name].transform, "story_v_out_323201", "323201034", "story_v_out_323201.awb")

						arg_138_1:RecordAudio("323201034", var_141_30)
						arg_138_1:RecordAudio("323201034", var_141_30)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_323201", "323201034", "story_v_out_323201.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_323201", "323201034", "story_v_out_323201.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_31 = math.max(var_141_22, arg_138_1.talkMaxDuration)

			if var_141_21 <= arg_138_1.time_ and arg_138_1.time_ < var_141_21 + var_141_31 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_21) / var_141_31

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_21 + var_141_31 and arg_138_1.time_ < var_141_21 + var_141_31 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequency = 8,
				className = "StoryShakeNode",
				duration = 0.9,
				startTime = 0.366666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(7, 1, 0.1)
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play323201035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 323201035
		arg_142_1.duration_ = 5.65

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play323201036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1070ui_story"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos1070ui_story = var_145_0.localPosition
			end

			local var_145_2 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2
				local var_145_4 = Vector3.New(0, 100, 0)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1070ui_story, var_145_4, var_145_3)

				local var_145_5 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_5.x, var_145_5.y, var_145_5.z)

				local var_145_6 = var_145_0.localEulerAngles

				var_145_6.z = 0
				var_145_6.x = 0
				var_145_0.localEulerAngles = var_145_6
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(0, 100, 0)

				local var_145_7 = manager.ui.mainCamera.transform.position - var_145_0.position

				var_145_0.forward = Vector3.New(var_145_7.x, var_145_7.y, var_145_7.z)

				local var_145_8 = var_145_0.localEulerAngles

				var_145_8.z = 0
				var_145_8.x = 0
				var_145_0.localEulerAngles = var_145_8
			end

			local var_145_9 = arg_142_1.actors_["1070ui_story"]
			local var_145_10 = 0

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect1070ui_story == nil then
				arg_142_1.var_.characterEffect1070ui_story = var_145_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_11 = 0.200000002980232

			if var_145_10 <= arg_142_1.time_ and arg_142_1.time_ < var_145_10 + var_145_11 and not isNil(var_145_9) then
				local var_145_12 = (arg_142_1.time_ - var_145_10) / var_145_11

				if arg_142_1.var_.characterEffect1070ui_story and not isNil(var_145_9) then
					local var_145_13 = Mathf.Lerp(0, 0.5, var_145_12)

					arg_142_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1070ui_story.fillRatio = var_145_13
				end
			end

			if arg_142_1.time_ >= var_145_10 + var_145_11 and arg_142_1.time_ < var_145_10 + var_145_11 + arg_145_0 and not isNil(var_145_9) and arg_142_1.var_.characterEffect1070ui_story then
				local var_145_14 = 0.5

				arg_142_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1070ui_story.fillRatio = var_145_14
			end

			local var_145_15 = 0

			if var_145_15 < arg_142_1.time_ and arg_142_1.time_ <= var_145_15 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = true

				arg_142_1:SetGaussion(false)
			end

			local var_145_16 = 1.05

			if var_145_15 <= arg_142_1.time_ and arg_142_1.time_ < var_145_15 + var_145_16 then
				local var_145_17 = (arg_142_1.time_ - var_145_15) / var_145_16
				local var_145_18 = Color.New(1, 1, 1)

				var_145_18.a = Mathf.Lerp(1, 0, var_145_17)
				arg_142_1.mask_.color = var_145_18
			end

			if arg_142_1.time_ >= var_145_15 + var_145_16 and arg_142_1.time_ < var_145_15 + var_145_16 + arg_145_0 then
				local var_145_19 = Color.New(1, 1, 1)
				local var_145_20 = 0

				arg_142_1.mask_.enabled = false
				var_145_19.a = var_145_20
				arg_142_1.mask_.color = var_145_19
			end

			local var_145_21 = 0.0166666666666668

			arg_142_1.isInRecall_ = false

			if var_145_21 < arg_142_1.time_ and arg_142_1.time_ <= var_145_21 + arg_145_0 then
				arg_142_1.screenFilterGo_:SetActive(true)

				arg_142_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")

				for iter_145_0, iter_145_1 in pairs(arg_142_1.actors_) do
					local var_145_22 = iter_145_1:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_145_2, iter_145_3 in ipairs(var_145_22) do
						if iter_145_3.color.r > 0.51 then
							iter_145_3.color = Color.New(1, 1, 1)
						else
							iter_145_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_145_23 = 1.68333333333333

			if var_145_21 <= arg_142_1.time_ and arg_142_1.time_ < var_145_21 + var_145_23 then
				local var_145_24 = (arg_142_1.time_ - var_145_21) / var_145_23

				arg_142_1.screenFilterEffect_.weight = Mathf.Lerp(0, 0.099, var_145_24)
			end

			if arg_142_1.time_ >= var_145_21 + var_145_23 and arg_142_1.time_ < var_145_21 + var_145_23 + arg_145_0 then
				arg_142_1.screenFilterEffect_.weight = 0.099
			end

			local var_145_25 = 0

			if var_145_25 < arg_142_1.time_ and arg_142_1.time_ <= var_145_25 + arg_145_0 then
				arg_142_1.allBtn_.enabled = false
			end

			local var_145_26 = 1.3

			if arg_142_1.time_ >= var_145_25 + var_145_26 and arg_142_1.time_ < var_145_25 + var_145_26 + arg_145_0 then
				arg_142_1.allBtn_.enabled = true
			end

			if arg_142_1.frameCnt_ <= 1 then
				arg_142_1.dialog_:SetActive(false)
			end

			local var_145_27 = 0.649999999999
			local var_145_28 = 1.05

			if var_145_27 < arg_142_1.time_ and arg_142_1.time_ <= var_145_27 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0

				arg_142_1.dialog_:SetActive(true)

				arg_142_1.dialogCg_.alpha = 0

				local var_145_29 = LeanTween.value(arg_142_1.dialog_, 0, 1, 0.3)

				var_145_29:setOnUpdate(LuaHelper.FloatAction(function(arg_146_0)
					arg_142_1.dialogCg_.alpha = arg_146_0
				end))
				var_145_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_142_1.dialog_)
					var_145_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_142_1.duration_ = arg_142_1.duration_ + 0.3

				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_30 = arg_142_1:GetWordFromCfg(323201035)
				local var_145_31 = arg_142_1:FormatText(var_145_30.content)

				arg_142_1.text_.text = var_145_31

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_32 = 42
				local var_145_33 = utf8.len(var_145_31)
				local var_145_34 = var_145_32 <= 0 and var_145_28 or var_145_28 * (var_145_33 / var_145_32)

				if var_145_34 > 0 and var_145_28 < var_145_34 then
					arg_142_1.talkMaxDuration = var_145_34
					var_145_27 = var_145_27 + 0.3

					if var_145_34 + var_145_27 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_34 + var_145_27
					end
				end

				arg_142_1.text_.text = var_145_31
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_35 = var_145_27 + 0.3
			local var_145_36 = math.max(var_145_28, arg_142_1.talkMaxDuration)

			if var_145_35 <= arg_142_1.time_ and arg_142_1.time_ < var_145_35 + var_145_36 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_35) / var_145_36

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_35 + var_145_36 and arg_142_1.time_ < var_145_35 + var_145_36 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play323201036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 323201036
		arg_148_1.duration_ = 6.4

		local var_148_0 = {
			zh = 3.833,
			ja = 6.4
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play323201037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1070ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1070ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, -0.95, -6.05)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1070ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["1070ui_story"]
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1070ui_story == nil then
				arg_148_1.var_.characterEffect1070ui_story = var_151_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_11 = 0.200000002980232

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_11 and not isNil(var_151_9) then
				local var_151_12 = (arg_148_1.time_ - var_151_10) / var_151_11

				if arg_148_1.var_.characterEffect1070ui_story and not isNil(var_151_9) then
					arg_148_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_10 + var_151_11 and arg_148_1.time_ < var_151_10 + var_151_11 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1070ui_story then
				arg_148_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_151_13 = 0

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				arg_148_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_151_14 = 0

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				arg_148_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_151_15 = 0
			local var_151_16 = 0.4

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_17 = arg_148_1:FormatText(StoryNameCfg[318].name)

				arg_148_1.leftNameTxt_.text = var_151_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_18 = arg_148_1:GetWordFromCfg(323201036)
				local var_151_19 = arg_148_1:FormatText(var_151_18.content)

				arg_148_1.text_.text = var_151_19

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_20 = 16
				local var_151_21 = utf8.len(var_151_19)
				local var_151_22 = var_151_20 <= 0 and var_151_16 or var_151_16 * (var_151_21 / var_151_20)

				if var_151_22 > 0 and var_151_16 < var_151_22 then
					arg_148_1.talkMaxDuration = var_151_22

					if var_151_22 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_22 + var_151_15
					end
				end

				arg_148_1.text_.text = var_151_19
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201036", "story_v_out_323201.awb") ~= 0 then
					local var_151_23 = manager.audio:GetVoiceLength("story_v_out_323201", "323201036", "story_v_out_323201.awb") / 1000

					if var_151_23 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_15
					end

					if var_151_18.prefab_name ~= "" and arg_148_1.actors_[var_151_18.prefab_name] ~= nil then
						local var_151_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_18.prefab_name].transform, "story_v_out_323201", "323201036", "story_v_out_323201.awb")

						arg_148_1:RecordAudio("323201036", var_151_24)
						arg_148_1:RecordAudio("323201036", var_151_24)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_323201", "323201036", "story_v_out_323201.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_323201", "323201036", "story_v_out_323201.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_25 = math.max(var_151_16, arg_148_1.talkMaxDuration)

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_25 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_15) / var_151_25

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_15 + var_151_25 and arg_148_1.time_ < var_151_15 + var_151_25 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play323201037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 323201037
		arg_152_1.duration_ = 6.13

		local var_152_0 = {
			zh = 6.133,
			ja = 5.933
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play323201038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = "10039ui_story"

			if arg_152_1.actors_[var_155_0] == nil then
				local var_155_1 = Asset.Load("Char/" .. "10039ui_story")

				if not isNil(var_155_1) then
					local var_155_2 = Object.Instantiate(Asset.Load("Char/" .. "10039ui_story"), arg_152_1.stage_.transform)

					var_155_2.name = var_155_0
					var_155_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_152_1.actors_[var_155_0] = var_155_2

					local var_155_3 = var_155_2:GetComponentInChildren(typeof(CharacterEffect))

					var_155_3.enabled = true

					local var_155_4 = GameObjectTools.GetOrAddComponent(var_155_2, typeof(DynamicBoneHelper))

					if var_155_4 then
						var_155_4:EnableDynamicBone(false)
					end

					arg_152_1:ShowWeapon(var_155_3.transform, false)

					arg_152_1.var_[var_155_0 .. "Animator"] = var_155_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_152_1.var_[var_155_0 .. "Animator"].applyRootMotion = true
					arg_152_1.var_[var_155_0 .. "LipSync"] = var_155_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_155_5 = arg_152_1.actors_["10039ui_story"].transform
			local var_155_6 = 0

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.var_.moveOldPos10039ui_story = var_155_5.localPosition
			end

			local var_155_7 = 0.001

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_7 then
				local var_155_8 = (arg_152_1.time_ - var_155_6) / var_155_7
				local var_155_9 = Vector3.New(-0.7, -0.8, -6.2)

				var_155_5.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10039ui_story, var_155_9, var_155_8)

				local var_155_10 = manager.ui.mainCamera.transform.position - var_155_5.position

				var_155_5.forward = Vector3.New(var_155_10.x, var_155_10.y, var_155_10.z)

				local var_155_11 = var_155_5.localEulerAngles

				var_155_11.z = 0
				var_155_11.x = 0
				var_155_5.localEulerAngles = var_155_11
			end

			if arg_152_1.time_ >= var_155_6 + var_155_7 and arg_152_1.time_ < var_155_6 + var_155_7 + arg_155_0 then
				var_155_5.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_155_12 = manager.ui.mainCamera.transform.position - var_155_5.position

				var_155_5.forward = Vector3.New(var_155_12.x, var_155_12.y, var_155_12.z)

				local var_155_13 = var_155_5.localEulerAngles

				var_155_13.z = 0
				var_155_13.x = 0
				var_155_5.localEulerAngles = var_155_13
			end

			local var_155_14 = arg_152_1.actors_["1070ui_story"].transform
			local var_155_15 = 0

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.var_.moveOldPos1070ui_story = var_155_14.localPosition
			end

			local var_155_16 = 0.001

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_16 then
				local var_155_17 = (arg_152_1.time_ - var_155_15) / var_155_16
				local var_155_18 = Vector3.New(0.7, -0.95, -6.05)

				var_155_14.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1070ui_story, var_155_18, var_155_17)

				local var_155_19 = manager.ui.mainCamera.transform.position - var_155_14.position

				var_155_14.forward = Vector3.New(var_155_19.x, var_155_19.y, var_155_19.z)

				local var_155_20 = var_155_14.localEulerAngles

				var_155_20.z = 0
				var_155_20.x = 0
				var_155_14.localEulerAngles = var_155_20
			end

			if arg_152_1.time_ >= var_155_15 + var_155_16 and arg_152_1.time_ < var_155_15 + var_155_16 + arg_155_0 then
				var_155_14.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_155_21 = manager.ui.mainCamera.transform.position - var_155_14.position

				var_155_14.forward = Vector3.New(var_155_21.x, var_155_21.y, var_155_21.z)

				local var_155_22 = var_155_14.localEulerAngles

				var_155_22.z = 0
				var_155_22.x = 0
				var_155_14.localEulerAngles = var_155_22
			end

			local var_155_23 = arg_152_1.actors_["10039ui_story"]
			local var_155_24 = 0

			if var_155_24 < arg_152_1.time_ and arg_152_1.time_ <= var_155_24 + arg_155_0 and not isNil(var_155_23) and arg_152_1.var_.characterEffect10039ui_story == nil then
				arg_152_1.var_.characterEffect10039ui_story = var_155_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_25 = 0.200000002980232

			if var_155_24 <= arg_152_1.time_ and arg_152_1.time_ < var_155_24 + var_155_25 and not isNil(var_155_23) then
				local var_155_26 = (arg_152_1.time_ - var_155_24) / var_155_25

				if arg_152_1.var_.characterEffect10039ui_story and not isNil(var_155_23) then
					arg_152_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_24 + var_155_25 and arg_152_1.time_ < var_155_24 + var_155_25 + arg_155_0 and not isNil(var_155_23) and arg_152_1.var_.characterEffect10039ui_story then
				arg_152_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_155_27 = arg_152_1.actors_["1070ui_story"]
			local var_155_28 = 0

			if var_155_28 < arg_152_1.time_ and arg_152_1.time_ <= var_155_28 + arg_155_0 and not isNil(var_155_27) and arg_152_1.var_.characterEffect1070ui_story == nil then
				arg_152_1.var_.characterEffect1070ui_story = var_155_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_29 = 0.200000002980232

			if var_155_28 <= arg_152_1.time_ and arg_152_1.time_ < var_155_28 + var_155_29 and not isNil(var_155_27) then
				local var_155_30 = (arg_152_1.time_ - var_155_28) / var_155_29

				if arg_152_1.var_.characterEffect1070ui_story and not isNil(var_155_27) then
					local var_155_31 = Mathf.Lerp(0, 0.5, var_155_30)

					arg_152_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1070ui_story.fillRatio = var_155_31
				end
			end

			if arg_152_1.time_ >= var_155_28 + var_155_29 and arg_152_1.time_ < var_155_28 + var_155_29 + arg_155_0 and not isNil(var_155_27) and arg_152_1.var_.characterEffect1070ui_story then
				local var_155_32 = 0.5

				arg_152_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1070ui_story.fillRatio = var_155_32
			end

			local var_155_33 = 0

			if var_155_33 < arg_152_1.time_ and arg_152_1.time_ <= var_155_33 + arg_155_0 then
				arg_152_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_155_34 = 0

			if var_155_34 < arg_152_1.time_ and arg_152_1.time_ <= var_155_34 + arg_155_0 then
				arg_152_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_155_35 = 0
			local var_155_36 = 0.6

			if var_155_35 < arg_152_1.time_ and arg_152_1.time_ <= var_155_35 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_37 = arg_152_1:FormatText(StoryNameCfg[472].name)

				arg_152_1.leftNameTxt_.text = var_155_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_38 = arg_152_1:GetWordFromCfg(323201037)
				local var_155_39 = arg_152_1:FormatText(var_155_38.content)

				arg_152_1.text_.text = var_155_39

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_40 = 24
				local var_155_41 = utf8.len(var_155_39)
				local var_155_42 = var_155_40 <= 0 and var_155_36 or var_155_36 * (var_155_41 / var_155_40)

				if var_155_42 > 0 and var_155_36 < var_155_42 then
					arg_152_1.talkMaxDuration = var_155_42

					if var_155_42 + var_155_35 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_42 + var_155_35
					end
				end

				arg_152_1.text_.text = var_155_39
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201037", "story_v_out_323201.awb") ~= 0 then
					local var_155_43 = manager.audio:GetVoiceLength("story_v_out_323201", "323201037", "story_v_out_323201.awb") / 1000

					if var_155_43 + var_155_35 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_43 + var_155_35
					end

					if var_155_38.prefab_name ~= "" and arg_152_1.actors_[var_155_38.prefab_name] ~= nil then
						local var_155_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_38.prefab_name].transform, "story_v_out_323201", "323201037", "story_v_out_323201.awb")

						arg_152_1:RecordAudio("323201037", var_155_44)
						arg_152_1:RecordAudio("323201037", var_155_44)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_323201", "323201037", "story_v_out_323201.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_323201", "323201037", "story_v_out_323201.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_45 = math.max(var_155_36, arg_152_1.talkMaxDuration)

			if var_155_35 <= arg_152_1.time_ and arg_152_1.time_ < var_155_35 + var_155_45 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_35) / var_155_45

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_35 + var_155_45 and arg_152_1.time_ < var_155_35 + var_155_45 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play323201038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 323201038
		arg_156_1.duration_ = 4.9

		local var_156_0 = {
			zh = 4.3,
			ja = 4.9
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play323201039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1070ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1070ui_story == nil then
				arg_156_1.var_.characterEffect1070ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1070ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1070ui_story then
				arg_156_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_159_4 = arg_156_1.actors_["10039ui_story"]
			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect10039ui_story == nil then
				arg_156_1.var_.characterEffect10039ui_story = var_159_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_6 = 0.200000002980232

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 and not isNil(var_159_4) then
				local var_159_7 = (arg_156_1.time_ - var_159_5) / var_159_6

				if arg_156_1.var_.characterEffect10039ui_story and not isNil(var_159_4) then
					local var_159_8 = Mathf.Lerp(0, 0.5, var_159_7)

					arg_156_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10039ui_story.fillRatio = var_159_8
				end
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect10039ui_story then
				local var_159_9 = 0.5

				arg_156_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10039ui_story.fillRatio = var_159_9
			end

			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			local var_159_11 = 0

			if var_159_11 < arg_156_1.time_ and arg_156_1.time_ <= var_159_11 + arg_159_0 then
				arg_156_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_159_12 = 0
			local var_159_13 = 0.525

			if var_159_12 < arg_156_1.time_ and arg_156_1.time_ <= var_159_12 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_14 = arg_156_1:FormatText(StoryNameCfg[318].name)

				arg_156_1.leftNameTxt_.text = var_159_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_15 = arg_156_1:GetWordFromCfg(323201038)
				local var_159_16 = arg_156_1:FormatText(var_159_15.content)

				arg_156_1.text_.text = var_159_16

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_17 = 21
				local var_159_18 = utf8.len(var_159_16)
				local var_159_19 = var_159_17 <= 0 and var_159_13 or var_159_13 * (var_159_18 / var_159_17)

				if var_159_19 > 0 and var_159_13 < var_159_19 then
					arg_156_1.talkMaxDuration = var_159_19

					if var_159_19 + var_159_12 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_19 + var_159_12
					end
				end

				arg_156_1.text_.text = var_159_16
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201038", "story_v_out_323201.awb") ~= 0 then
					local var_159_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201038", "story_v_out_323201.awb") / 1000

					if var_159_20 + var_159_12 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_20 + var_159_12
					end

					if var_159_15.prefab_name ~= "" and arg_156_1.actors_[var_159_15.prefab_name] ~= nil then
						local var_159_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_15.prefab_name].transform, "story_v_out_323201", "323201038", "story_v_out_323201.awb")

						arg_156_1:RecordAudio("323201038", var_159_21)
						arg_156_1:RecordAudio("323201038", var_159_21)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_323201", "323201038", "story_v_out_323201.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_323201", "323201038", "story_v_out_323201.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_22 = math.max(var_159_13, arg_156_1.talkMaxDuration)

			if var_159_12 <= arg_156_1.time_ and arg_156_1.time_ < var_159_12 + var_159_22 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_12) / var_159_22

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_12 + var_159_22 and arg_156_1.time_ < var_159_12 + var_159_22 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play323201039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 323201039
		arg_160_1.duration_ = 2.33

		local var_160_0 = {
			zh = 1.8,
			ja = 2.333
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
				arg_160_0:Play323201040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10039ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10039ui_story == nil then
				arg_160_1.var_.characterEffect10039ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect10039ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10039ui_story then
				arg_160_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_163_4 = arg_160_1.actors_["1070ui_story"]
			local var_163_5 = 0

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect1070ui_story == nil then
				arg_160_1.var_.characterEffect1070ui_story = var_163_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_6 = 0.200000002980232

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 and not isNil(var_163_4) then
				local var_163_7 = (arg_160_1.time_ - var_163_5) / var_163_6

				if arg_160_1.var_.characterEffect1070ui_story and not isNil(var_163_4) then
					local var_163_8 = Mathf.Lerp(0, 0.5, var_163_7)

					arg_160_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1070ui_story.fillRatio = var_163_8
				end
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect1070ui_story then
				local var_163_9 = 0.5

				arg_160_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1070ui_story.fillRatio = var_163_9
			end

			local var_163_10 = 0

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_163_11 = 0

			if var_163_11 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_163_12 = 0
			local var_163_13 = 0.15

			if var_163_12 < arg_160_1.time_ and arg_160_1.time_ <= var_163_12 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_14 = arg_160_1:FormatText(StoryNameCfg[472].name)

				arg_160_1.leftNameTxt_.text = var_163_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_15 = arg_160_1:GetWordFromCfg(323201039)
				local var_163_16 = arg_160_1:FormatText(var_163_15.content)

				arg_160_1.text_.text = var_163_16

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_17 = 6
				local var_163_18 = utf8.len(var_163_16)
				local var_163_19 = var_163_17 <= 0 and var_163_13 or var_163_13 * (var_163_18 / var_163_17)

				if var_163_19 > 0 and var_163_13 < var_163_19 then
					arg_160_1.talkMaxDuration = var_163_19

					if var_163_19 + var_163_12 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_19 + var_163_12
					end
				end

				arg_160_1.text_.text = var_163_16
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201039", "story_v_out_323201.awb") ~= 0 then
					local var_163_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201039", "story_v_out_323201.awb") / 1000

					if var_163_20 + var_163_12 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_20 + var_163_12
					end

					if var_163_15.prefab_name ~= "" and arg_160_1.actors_[var_163_15.prefab_name] ~= nil then
						local var_163_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_15.prefab_name].transform, "story_v_out_323201", "323201039", "story_v_out_323201.awb")

						arg_160_1:RecordAudio("323201039", var_163_21)
						arg_160_1:RecordAudio("323201039", var_163_21)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_323201", "323201039", "story_v_out_323201.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_323201", "323201039", "story_v_out_323201.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_22 = math.max(var_163_13, arg_160_1.talkMaxDuration)

			if var_163_12 <= arg_160_1.time_ and arg_160_1.time_ < var_163_12 + var_163_22 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_12) / var_163_22

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_12 + var_163_22 and arg_160_1.time_ < var_163_12 + var_163_22 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play323201040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 323201040
		arg_164_1.duration_ = 4.53

		local var_164_0 = {
			zh = 2.7,
			ja = 4.533
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
				arg_164_0:Play323201041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1070ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1070ui_story == nil then
				arg_164_1.var_.characterEffect1070ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1070ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1070ui_story then
				arg_164_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_167_4 = arg_164_1.actors_["10039ui_story"]
			local var_167_5 = 0

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.characterEffect10039ui_story == nil then
				arg_164_1.var_.characterEffect10039ui_story = var_167_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_6 = 0.200000002980232

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_6 and not isNil(var_167_4) then
				local var_167_7 = (arg_164_1.time_ - var_167_5) / var_167_6

				if arg_164_1.var_.characterEffect10039ui_story and not isNil(var_167_4) then
					local var_167_8 = Mathf.Lerp(0, 0.5, var_167_7)

					arg_164_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_164_1.var_.characterEffect10039ui_story.fillRatio = var_167_8
				end
			end

			if arg_164_1.time_ >= var_167_5 + var_167_6 and arg_164_1.time_ < var_167_5 + var_167_6 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.characterEffect10039ui_story then
				local var_167_9 = 0.5

				arg_164_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_164_1.var_.characterEffect10039ui_story.fillRatio = var_167_9
			end

			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 then
				arg_164_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_167_11 = 0

			if var_167_11 < arg_164_1.time_ and arg_164_1.time_ <= var_167_11 + arg_167_0 then
				arg_164_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_167_12 = 0
			local var_167_13 = 0.3

			if var_167_12 < arg_164_1.time_ and arg_164_1.time_ <= var_167_12 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_14 = arg_164_1:FormatText(StoryNameCfg[318].name)

				arg_164_1.leftNameTxt_.text = var_167_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_15 = arg_164_1:GetWordFromCfg(323201040)
				local var_167_16 = arg_164_1:FormatText(var_167_15.content)

				arg_164_1.text_.text = var_167_16

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_17 = 12
				local var_167_18 = utf8.len(var_167_16)
				local var_167_19 = var_167_17 <= 0 and var_167_13 or var_167_13 * (var_167_18 / var_167_17)

				if var_167_19 > 0 and var_167_13 < var_167_19 then
					arg_164_1.talkMaxDuration = var_167_19

					if var_167_19 + var_167_12 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_19 + var_167_12
					end
				end

				arg_164_1.text_.text = var_167_16
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201040", "story_v_out_323201.awb") ~= 0 then
					local var_167_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201040", "story_v_out_323201.awb") / 1000

					if var_167_20 + var_167_12 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_20 + var_167_12
					end

					if var_167_15.prefab_name ~= "" and arg_164_1.actors_[var_167_15.prefab_name] ~= nil then
						local var_167_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_15.prefab_name].transform, "story_v_out_323201", "323201040", "story_v_out_323201.awb")

						arg_164_1:RecordAudio("323201040", var_167_21)
						arg_164_1:RecordAudio("323201040", var_167_21)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_323201", "323201040", "story_v_out_323201.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_323201", "323201040", "story_v_out_323201.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_22 = math.max(var_167_13, arg_164_1.talkMaxDuration)

			if var_167_12 <= arg_164_1.time_ and arg_164_1.time_ < var_167_12 + var_167_22 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_12) / var_167_22

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_12 + var_167_22 and arg_164_1.time_ < var_167_12 + var_167_22 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play323201041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 323201041
		arg_168_1.duration_ = 8.3

		local var_168_0 = {
			zh = 5.7,
			ja = 8.3
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
				arg_168_0:Play323201042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 0.8

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_2 = arg_168_1:FormatText(StoryNameCfg[318].name)

				arg_168_1.leftNameTxt_.text = var_171_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_3 = arg_168_1:GetWordFromCfg(323201041)
				local var_171_4 = arg_168_1:FormatText(var_171_3.content)

				arg_168_1.text_.text = var_171_4

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 32
				local var_171_6 = utf8.len(var_171_4)
				local var_171_7 = var_171_5 <= 0 and var_171_1 or var_171_1 * (var_171_6 / var_171_5)

				if var_171_7 > 0 and var_171_1 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_4
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201041", "story_v_out_323201.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_323201", "323201041", "story_v_out_323201.awb") / 1000

					if var_171_8 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_0
					end

					if var_171_3.prefab_name ~= "" and arg_168_1.actors_[var_171_3.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_3.prefab_name].transform, "story_v_out_323201", "323201041", "story_v_out_323201.awb")

						arg_168_1:RecordAudio("323201041", var_171_9)
						arg_168_1:RecordAudio("323201041", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_323201", "323201041", "story_v_out_323201.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_323201", "323201041", "story_v_out_323201.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_10 and arg_168_1.time_ < var_171_0 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play323201042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 323201042
		arg_172_1.duration_ = 9.03

		local var_172_0 = {
			zh = 6.433,
			ja = 9.033
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
				arg_172_0:Play323201043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10039ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10039ui_story == nil then
				arg_172_1.var_.characterEffect10039ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect10039ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10039ui_story then
				arg_172_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_175_4 = arg_172_1.actors_["1070ui_story"]
			local var_175_5 = 0

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1070ui_story == nil then
				arg_172_1.var_.characterEffect1070ui_story = var_175_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_6 = 0.200000002980232

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_6 and not isNil(var_175_4) then
				local var_175_7 = (arg_172_1.time_ - var_175_5) / var_175_6

				if arg_172_1.var_.characterEffect1070ui_story and not isNil(var_175_4) then
					local var_175_8 = Mathf.Lerp(0, 0.5, var_175_7)

					arg_172_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1070ui_story.fillRatio = var_175_8
				end
			end

			if arg_172_1.time_ >= var_175_5 + var_175_6 and arg_172_1.time_ < var_175_5 + var_175_6 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect1070ui_story then
				local var_175_9 = 0.5

				arg_172_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1070ui_story.fillRatio = var_175_9
			end

			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_175_11 = 0

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				arg_172_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_175_12 = 0
			local var_175_13 = 0.65

			if var_175_12 < arg_172_1.time_ and arg_172_1.time_ <= var_175_12 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_14 = arg_172_1:FormatText(StoryNameCfg[472].name)

				arg_172_1.leftNameTxt_.text = var_175_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_15 = arg_172_1:GetWordFromCfg(323201042)
				local var_175_16 = arg_172_1:FormatText(var_175_15.content)

				arg_172_1.text_.text = var_175_16

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_17 = 26
				local var_175_18 = utf8.len(var_175_16)
				local var_175_19 = var_175_17 <= 0 and var_175_13 or var_175_13 * (var_175_18 / var_175_17)

				if var_175_19 > 0 and var_175_13 < var_175_19 then
					arg_172_1.talkMaxDuration = var_175_19

					if var_175_19 + var_175_12 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_19 + var_175_12
					end
				end

				arg_172_1.text_.text = var_175_16
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201042", "story_v_out_323201.awb") ~= 0 then
					local var_175_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201042", "story_v_out_323201.awb") / 1000

					if var_175_20 + var_175_12 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_20 + var_175_12
					end

					if var_175_15.prefab_name ~= "" and arg_172_1.actors_[var_175_15.prefab_name] ~= nil then
						local var_175_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_15.prefab_name].transform, "story_v_out_323201", "323201042", "story_v_out_323201.awb")

						arg_172_1:RecordAudio("323201042", var_175_21)
						arg_172_1:RecordAudio("323201042", var_175_21)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_323201", "323201042", "story_v_out_323201.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_323201", "323201042", "story_v_out_323201.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_22 = math.max(var_175_13, arg_172_1.talkMaxDuration)

			if var_175_12 <= arg_172_1.time_ and arg_172_1.time_ < var_175_12 + var_175_22 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_12) / var_175_22

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_12 + var_175_22 and arg_172_1.time_ < var_175_12 + var_175_22 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play323201043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 323201043
		arg_176_1.duration_ = 5.2

		local var_176_0 = {
			zh = 5.033,
			ja = 5.2
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
				arg_176_0:Play323201044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1070ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1070ui_story == nil then
				arg_176_1.var_.characterEffect1070ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1070ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1070ui_story then
				arg_176_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_179_4 = arg_176_1.actors_["10039ui_story"]
			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect10039ui_story == nil then
				arg_176_1.var_.characterEffect10039ui_story = var_179_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_6 = 0.200000002980232

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_6 and not isNil(var_179_4) then
				local var_179_7 = (arg_176_1.time_ - var_179_5) / var_179_6

				if arg_176_1.var_.characterEffect10039ui_story and not isNil(var_179_4) then
					local var_179_8 = Mathf.Lerp(0, 0.5, var_179_7)

					arg_176_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10039ui_story.fillRatio = var_179_8
				end
			end

			if arg_176_1.time_ >= var_179_5 + var_179_6 and arg_176_1.time_ < var_179_5 + var_179_6 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect10039ui_story then
				local var_179_9 = 0.5

				arg_176_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10039ui_story.fillRatio = var_179_9
			end

			local var_179_10 = 0

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 then
				arg_176_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_179_11 = 0

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_179_12 = 0
			local var_179_13 = 0.4

			if var_179_12 < arg_176_1.time_ and arg_176_1.time_ <= var_179_12 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_14 = arg_176_1:FormatText(StoryNameCfg[318].name)

				arg_176_1.leftNameTxt_.text = var_179_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_15 = arg_176_1:GetWordFromCfg(323201043)
				local var_179_16 = arg_176_1:FormatText(var_179_15.content)

				arg_176_1.text_.text = var_179_16

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_17 = 16
				local var_179_18 = utf8.len(var_179_16)
				local var_179_19 = var_179_17 <= 0 and var_179_13 or var_179_13 * (var_179_18 / var_179_17)

				if var_179_19 > 0 and var_179_13 < var_179_19 then
					arg_176_1.talkMaxDuration = var_179_19

					if var_179_19 + var_179_12 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_19 + var_179_12
					end
				end

				arg_176_1.text_.text = var_179_16
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201043", "story_v_out_323201.awb") ~= 0 then
					local var_179_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201043", "story_v_out_323201.awb") / 1000

					if var_179_20 + var_179_12 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_20 + var_179_12
					end

					if var_179_15.prefab_name ~= "" and arg_176_1.actors_[var_179_15.prefab_name] ~= nil then
						local var_179_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_15.prefab_name].transform, "story_v_out_323201", "323201043", "story_v_out_323201.awb")

						arg_176_1:RecordAudio("323201043", var_179_21)
						arg_176_1:RecordAudio("323201043", var_179_21)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_323201", "323201043", "story_v_out_323201.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_323201", "323201043", "story_v_out_323201.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_22 = math.max(var_179_13, arg_176_1.talkMaxDuration)

			if var_179_12 <= arg_176_1.time_ and arg_176_1.time_ < var_179_12 + var_179_22 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_12) / var_179_22

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_12 + var_179_22 and arg_176_1.time_ < var_179_12 + var_179_22 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play323201044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 323201044
		arg_180_1.duration_ = 7.5

		local var_180_0 = {
			zh = 4.566,
			ja = 7.5
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play323201045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10039ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10039ui_story == nil then
				arg_180_1.var_.characterEffect10039ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect10039ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10039ui_story then
				arg_180_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_183_4 = arg_180_1.actors_["1070ui_story"]
			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect1070ui_story == nil then
				arg_180_1.var_.characterEffect1070ui_story = var_183_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_6 = 0.200000002980232

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_6 and not isNil(var_183_4) then
				local var_183_7 = (arg_180_1.time_ - var_183_5) / var_183_6

				if arg_180_1.var_.characterEffect1070ui_story and not isNil(var_183_4) then
					local var_183_8 = Mathf.Lerp(0, 0.5, var_183_7)

					arg_180_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1070ui_story.fillRatio = var_183_8
				end
			end

			if arg_180_1.time_ >= var_183_5 + var_183_6 and arg_180_1.time_ < var_183_5 + var_183_6 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect1070ui_story then
				local var_183_9 = 0.5

				arg_180_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1070ui_story.fillRatio = var_183_9
			end

			local var_183_10 = 0
			local var_183_11 = 0.3

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 then
				local var_183_12 = "play"
				local var_183_13 = "music"

				arg_180_1:AudioAction(var_183_12, var_183_13, "ui_battle", "ui_battle_stopbgm", "")

				local var_183_14 = ""
				local var_183_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_183_15 ~= "" then
					if arg_180_1.bgmTxt_.text ~= var_183_15 and arg_180_1.bgmTxt_.text ~= "" then
						if arg_180_1.bgmTxt2_.text ~= "" then
							arg_180_1.bgmTxt_.text = arg_180_1.bgmTxt2_.text
						end

						arg_180_1.bgmTxt2_.text = var_183_15

						arg_180_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_180_1.bgmTxt_.text = var_183_15
						arg_180_1.bgmTxt2_.text = var_183_15
					end

					if arg_180_1.bgmTimer then
						arg_180_1.bgmTimer:Stop()

						arg_180_1.bgmTimer = nil
					end

					if arg_180_1.settingData.show_music_name == 1 then
						arg_180_1.musicController:SetSelectedState("show")
						arg_180_1.musicAnimator_:Play("open", 0, 0)

						if arg_180_1.settingData.music_time ~= 0 then
							arg_180_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_180_1.settingData.music_time), function()
								if arg_180_1 == nil or isNil(arg_180_1.bgmTxt_) then
									return
								end

								arg_180_1.musicController:SetSelectedState("hide")
								arg_180_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_183_16 = 0
			local var_183_17 = 1

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				local var_183_18 = "play"
				local var_183_19 = "effect"

				arg_180_1:AudioAction(var_183_18, var_183_19, "se_story_148", "se_story_148_amb_drone02", "")
			end

			local var_183_20 = 0
			local var_183_21 = 1

			if var_183_20 < arg_180_1.time_ and arg_180_1.time_ <= var_183_20 + arg_183_0 then
				local var_183_22 = "stop"
				local var_183_23 = "effect"

				arg_180_1:AudioAction(var_183_22, var_183_23, "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			local var_183_24 = 0
			local var_183_25 = 0.525

			if var_183_24 < arg_180_1.time_ and arg_180_1.time_ <= var_183_24 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_26 = arg_180_1:FormatText(StoryNameCfg[472].name)

				arg_180_1.leftNameTxt_.text = var_183_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_27 = arg_180_1:GetWordFromCfg(323201044)
				local var_183_28 = arg_180_1:FormatText(var_183_27.content)

				arg_180_1.text_.text = var_183_28

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_29 = 21
				local var_183_30 = utf8.len(var_183_28)
				local var_183_31 = var_183_29 <= 0 and var_183_25 or var_183_25 * (var_183_30 / var_183_29)

				if var_183_31 > 0 and var_183_25 < var_183_31 then
					arg_180_1.talkMaxDuration = var_183_31

					if var_183_31 + var_183_24 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_31 + var_183_24
					end
				end

				arg_180_1.text_.text = var_183_28
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201044", "story_v_out_323201.awb") ~= 0 then
					local var_183_32 = manager.audio:GetVoiceLength("story_v_out_323201", "323201044", "story_v_out_323201.awb") / 1000

					if var_183_32 + var_183_24 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_32 + var_183_24
					end

					if var_183_27.prefab_name ~= "" and arg_180_1.actors_[var_183_27.prefab_name] ~= nil then
						local var_183_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_27.prefab_name].transform, "story_v_out_323201", "323201044", "story_v_out_323201.awb")

						arg_180_1:RecordAudio("323201044", var_183_33)
						arg_180_1:RecordAudio("323201044", var_183_33)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_323201", "323201044", "story_v_out_323201.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_323201", "323201044", "story_v_out_323201.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_34 = math.max(var_183_25, arg_180_1.talkMaxDuration)

			if var_183_24 <= arg_180_1.time_ and arg_180_1.time_ < var_183_24 + var_183_34 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_24) / var_183_34

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_24 + var_183_34 and arg_180_1.time_ < var_183_24 + var_183_34 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play323201045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 323201045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play323201046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10039ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect10039ui_story == nil then
				arg_185_1.var_.characterEffect10039ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect10039ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10039ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect10039ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10039ui_story.fillRatio = var_188_5
			end

			local var_188_6 = 0
			local var_188_7 = 1

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				local var_188_8 = "play"
				local var_188_9 = "effect"

				arg_185_1:AudioAction(var_188_8, var_188_9, "se_story_148", "se_story_148_impact", "")
			end

			local var_188_10 = 0
			local var_188_11 = 1.375

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_12 = arg_185_1:GetWordFromCfg(323201045)
				local var_188_13 = arg_185_1:FormatText(var_188_12.content)

				arg_185_1.text_.text = var_188_13

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_14 = 55
				local var_188_15 = utf8.len(var_188_13)
				local var_188_16 = var_188_14 <= 0 and var_188_11 or var_188_11 * (var_188_15 / var_188_14)

				if var_188_16 > 0 and var_188_11 < var_188_16 then
					arg_185_1.talkMaxDuration = var_188_16

					if var_188_16 + var_188_10 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_16 + var_188_10
					end
				end

				arg_185_1.text_.text = var_188_13
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_17 = math.max(var_188_11, arg_185_1.talkMaxDuration)

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_17 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_10) / var_188_17

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_10 + var_188_17 and arg_185_1.time_ < var_188_10 + var_188_17 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play323201046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 323201046
		arg_189_1.duration_ = 11.6

		local var_189_0 = {
			zh = 7.533,
			ja = 11.6
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
				arg_189_0:Play323201047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10039ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10039ui_story == nil then
				arg_189_1.var_.characterEffect10039ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect10039ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect10039ui_story then
				arg_189_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_192_4 = 0

			if var_192_4 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_192_5 = 0

			if var_192_5 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_192_6 = 0
			local var_192_7 = 0.975

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_8 = arg_189_1:FormatText(StoryNameCfg[472].name)

				arg_189_1.leftNameTxt_.text = var_192_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_9 = arg_189_1:GetWordFromCfg(323201046)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 39
				local var_192_12 = utf8.len(var_192_10)
				local var_192_13 = var_192_11 <= 0 and var_192_7 or var_192_7 * (var_192_12 / var_192_11)

				if var_192_13 > 0 and var_192_7 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201046", "story_v_out_323201.awb") ~= 0 then
					local var_192_14 = manager.audio:GetVoiceLength("story_v_out_323201", "323201046", "story_v_out_323201.awb") / 1000

					if var_192_14 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_6
					end

					if var_192_9.prefab_name ~= "" and arg_189_1.actors_[var_192_9.prefab_name] ~= nil then
						local var_192_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_9.prefab_name].transform, "story_v_out_323201", "323201046", "story_v_out_323201.awb")

						arg_189_1:RecordAudio("323201046", var_192_15)
						arg_189_1:RecordAudio("323201046", var_192_15)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_323201", "323201046", "story_v_out_323201.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_323201", "323201046", "story_v_out_323201.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_16 and arg_189_1.time_ < var_192_6 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play323201047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 323201047
		arg_193_1.duration_ = 11.33

		local var_193_0 = {
			zh = 11.333,
			ja = 10.133
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
				arg_193_0:Play323201048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1070ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1070ui_story == nil then
				arg_193_1.var_.characterEffect1070ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1070ui_story and not isNil(var_196_0) then
					arg_193_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1070ui_story then
				arg_193_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_196_4 = arg_193_1.actors_["10039ui_story"]
			local var_196_5 = 0

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect10039ui_story == nil then
				arg_193_1.var_.characterEffect10039ui_story = var_196_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_6 = 0.200000002980232

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_6 and not isNil(var_196_4) then
				local var_196_7 = (arg_193_1.time_ - var_196_5) / var_196_6

				if arg_193_1.var_.characterEffect10039ui_story and not isNil(var_196_4) then
					local var_196_8 = Mathf.Lerp(0, 0.5, var_196_7)

					arg_193_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10039ui_story.fillRatio = var_196_8
				end
			end

			if arg_193_1.time_ >= var_196_5 + var_196_6 and arg_193_1.time_ < var_196_5 + var_196_6 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect10039ui_story then
				local var_196_9 = 0.5

				arg_193_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10039ui_story.fillRatio = var_196_9
			end

			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_196_11 = 0

			if var_196_11 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_196_12 = 0
			local var_196_13 = 0.9

			if var_196_12 < arg_193_1.time_ and arg_193_1.time_ <= var_196_12 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_14 = arg_193_1:FormatText(StoryNameCfg[318].name)

				arg_193_1.leftNameTxt_.text = var_196_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_15 = arg_193_1:GetWordFromCfg(323201047)
				local var_196_16 = arg_193_1:FormatText(var_196_15.content)

				arg_193_1.text_.text = var_196_16

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_17 = 36
				local var_196_18 = utf8.len(var_196_16)
				local var_196_19 = var_196_17 <= 0 and var_196_13 or var_196_13 * (var_196_18 / var_196_17)

				if var_196_19 > 0 and var_196_13 < var_196_19 then
					arg_193_1.talkMaxDuration = var_196_19

					if var_196_19 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_19 + var_196_12
					end
				end

				arg_193_1.text_.text = var_196_16
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201047", "story_v_out_323201.awb") ~= 0 then
					local var_196_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201047", "story_v_out_323201.awb") / 1000

					if var_196_20 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_20 + var_196_12
					end

					if var_196_15.prefab_name ~= "" and arg_193_1.actors_[var_196_15.prefab_name] ~= nil then
						local var_196_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_15.prefab_name].transform, "story_v_out_323201", "323201047", "story_v_out_323201.awb")

						arg_193_1:RecordAudio("323201047", var_196_21)
						arg_193_1:RecordAudio("323201047", var_196_21)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_323201", "323201047", "story_v_out_323201.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_323201", "323201047", "story_v_out_323201.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_22 = math.max(var_196_13, arg_193_1.talkMaxDuration)

			if var_196_12 <= arg_193_1.time_ and arg_193_1.time_ < var_196_12 + var_196_22 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_12) / var_196_22

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_12 + var_196_22 and arg_193_1.time_ < var_196_12 + var_196_22 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play323201048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 323201048
		arg_197_1.duration_ = 2.7

		local var_197_0 = {
			zh = 2.5,
			ja = 2.7
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
				arg_197_0:Play323201049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10039ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect10039ui_story == nil then
				arg_197_1.var_.characterEffect10039ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect10039ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect10039ui_story then
				arg_197_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_200_4 = arg_197_1.actors_["1070ui_story"]
			local var_200_5 = 0

			if var_200_5 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1070ui_story == nil then
				arg_197_1.var_.characterEffect1070ui_story = var_200_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_6 = 0.200000002980232

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_6 and not isNil(var_200_4) then
				local var_200_7 = (arg_197_1.time_ - var_200_5) / var_200_6

				if arg_197_1.var_.characterEffect1070ui_story and not isNil(var_200_4) then
					local var_200_8 = Mathf.Lerp(0, 0.5, var_200_7)

					arg_197_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1070ui_story.fillRatio = var_200_8
				end
			end

			if arg_197_1.time_ >= var_200_5 + var_200_6 and arg_197_1.time_ < var_200_5 + var_200_6 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1070ui_story then
				local var_200_9 = 0.5

				arg_197_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1070ui_story.fillRatio = var_200_9
			end

			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 then
				arg_197_1.allBtn_.enabled = false
			end

			local var_200_11 = 1

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 then
				arg_197_1.allBtn_.enabled = true
			end

			local var_200_12 = 0
			local var_200_13 = 0.275

			if var_200_12 < arg_197_1.time_ and arg_197_1.time_ <= var_200_12 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_14 = arg_197_1:FormatText(StoryNameCfg[472].name)

				arg_197_1.leftNameTxt_.text = var_200_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_15 = arg_197_1:GetWordFromCfg(323201048)
				local var_200_16 = arg_197_1:FormatText(var_200_15.content)

				arg_197_1.text_.text = var_200_16

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_17 = 11
				local var_200_18 = utf8.len(var_200_16)
				local var_200_19 = var_200_17 <= 0 and var_200_13 or var_200_13 * (var_200_18 / var_200_17)

				if var_200_19 > 0 and var_200_13 < var_200_19 then
					arg_197_1.talkMaxDuration = var_200_19

					if var_200_19 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_19 + var_200_12
					end
				end

				arg_197_1.text_.text = var_200_16
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201048", "story_v_out_323201.awb") ~= 0 then
					local var_200_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201048", "story_v_out_323201.awb") / 1000

					if var_200_20 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_20 + var_200_12
					end

					if var_200_15.prefab_name ~= "" and arg_197_1.actors_[var_200_15.prefab_name] ~= nil then
						local var_200_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_15.prefab_name].transform, "story_v_out_323201", "323201048", "story_v_out_323201.awb")

						arg_197_1:RecordAudio("323201048", var_200_21)
						arg_197_1:RecordAudio("323201048", var_200_21)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_323201", "323201048", "story_v_out_323201.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_323201", "323201048", "story_v_out_323201.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_22 = math.max(var_200_13, arg_197_1.talkMaxDuration)

			if var_200_12 <= arg_197_1.time_ and arg_197_1.time_ < var_200_12 + var_200_22 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_12) / var_200_22

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_12 + var_200_22 and arg_197_1.time_ < var_200_12 + var_200_22 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play323201049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 323201049
		arg_201_1.duration_ = 2.87

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play323201050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1070ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1070ui_story == nil then
				arg_201_1.var_.characterEffect1070ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1070ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1070ui_story then
				arg_201_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["10039ui_story"]
			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect10039ui_story == nil then
				arg_201_1.var_.characterEffect10039ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_6 = 0.200000002980232

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 and not isNil(var_204_4) then
				local var_204_7 = (arg_201_1.time_ - var_204_5) / var_204_6

				if arg_201_1.var_.characterEffect10039ui_story and not isNil(var_204_4) then
					local var_204_8 = Mathf.Lerp(0, 0.5, var_204_7)

					arg_201_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10039ui_story.fillRatio = var_204_8
				end
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect10039ui_story then
				local var_204_9 = 0.5

				arg_201_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10039ui_story.fillRatio = var_204_9
			end

			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_204_11 = 0

			if var_204_11 < arg_201_1.time_ and arg_201_1.time_ <= var_204_11 + arg_204_0 then
				arg_201_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_204_12
			local var_204_13 = 0

			if var_204_13 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 then
				local var_204_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_204_14 then
					var_204_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_204_14.radialBlurScale = 0
					var_204_14.radialBlurGradient = 1
					var_204_14.radialBlurIntensity = 1

					if var_204_12 then
						var_204_14.radialBlurTarget = var_204_12.transform
					end
				end
			end

			local var_204_15 = 0.9

			if var_204_13 <= arg_201_1.time_ and arg_201_1.time_ < var_204_13 + var_204_15 then
				local var_204_16 = (arg_201_1.time_ - var_204_13) / var_204_15
				local var_204_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_204_17 then
					var_204_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_204_17.radialBlurScale = Mathf.Lerp(0, 0.477, var_204_16)
					var_204_17.radialBlurGradient = Mathf.Lerp(1, 1, var_204_16)
					var_204_17.radialBlurIntensity = Mathf.Lerp(1, 1, var_204_16)
				end
			end

			if arg_201_1.time_ >= var_204_13 + var_204_15 and arg_201_1.time_ < var_204_13 + var_204_15 + arg_204_0 then
				local var_204_18 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_204_18 then
					var_204_18.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_204_18.radialBlurScale = 0.477
					var_204_18.radialBlurGradient = 1
					var_204_18.radialBlurIntensity = 1
				end
			end

			local var_204_19
			local var_204_20 = 1.3

			if var_204_20 < arg_201_1.time_ and arg_201_1.time_ <= var_204_20 + arg_204_0 then
				local var_204_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_204_21 then
					var_204_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_204_21.radialBlurScale = 0.482
					var_204_21.radialBlurGradient = 1
					var_204_21.radialBlurIntensity = 1

					if var_204_19 then
						var_204_21.radialBlurTarget = var_204_19.transform
					end
				end
			end

			local var_204_22 = 0.9

			if var_204_20 <= arg_201_1.time_ and arg_201_1.time_ < var_204_20 + var_204_22 then
				local var_204_23 = (arg_201_1.time_ - var_204_20) / var_204_22
				local var_204_24 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_204_24 then
					var_204_24.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_204_24.radialBlurScale = Mathf.Lerp(0.482, 0.877, var_204_23)
					var_204_24.radialBlurGradient = Mathf.Lerp(1, 1, var_204_23)
					var_204_24.radialBlurIntensity = Mathf.Lerp(1, 1, var_204_23)
				end
			end

			if arg_201_1.time_ >= var_204_20 + var_204_22 and arg_201_1.time_ < var_204_20 + var_204_22 + arg_204_0 then
				local var_204_25 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_204_25 then
					var_204_25.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_204_25.radialBlurScale = 0.877
					var_204_25.radialBlurGradient = 1
					var_204_25.radialBlurIntensity = 1
				end
			end

			local var_204_26 = 0

			if var_204_26 < arg_201_1.time_ and arg_201_1.time_ <= var_204_26 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_27 = 0.433333333333333

			if var_204_26 <= arg_201_1.time_ and arg_201_1.time_ < var_204_26 + var_204_27 then
				local var_204_28 = (arg_201_1.time_ - var_204_26) / var_204_27
				local var_204_29 = Color.New(1, 1, 1)

				var_204_29.a = Mathf.Lerp(1, 0, var_204_28)
				arg_201_1.mask_.color = var_204_29
			end

			if arg_201_1.time_ >= var_204_26 + var_204_27 and arg_201_1.time_ < var_204_26 + var_204_27 + arg_204_0 then
				local var_204_30 = Color.New(1, 1, 1)
				local var_204_31 = 0

				arg_201_1.mask_.enabled = false
				var_204_30.a = var_204_31
				arg_201_1.mask_.color = var_204_30
			end

			local var_204_32 = manager.ui.mainCamera.transform
			local var_204_33 = 0.6

			if var_204_33 < arg_201_1.time_ and arg_201_1.time_ <= var_204_33 + arg_204_0 then
				local var_204_34 = arg_201_1.var_.effect87878
				local var_204_35
				local var_204_36 = var_204_32

				if not var_204_34 then
					var_204_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_204_36)
					var_204_34.name = "87878"
					arg_201_1.var_.effect87878 = var_204_34
				else
					var_204_34.transform:SetParent(var_204_36)
				end

				var_204_34.transform.localPosition = Vector3.New(0, 0, 0)
				var_204_34.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_204_37 = 1.7777777777777777
				local var_204_38 = Screen.width / Screen.height
				local var_204_39 = var_204_38 / var_204_37
				local var_204_40 = Mathf.Max(var_204_37 / var_204_38, 1)

				var_204_34.transform.localScale = Vector3.New(var_204_34.transform.localScale.x * var_204_39, var_204_34.transform.localScale.y * var_204_40, var_204_34.transform.localScale.z)
			end

			local var_204_41 = manager.ui.mainCamera.transform
			local var_204_42 = 1.73333333333333

			if var_204_42 < arg_201_1.time_ and arg_201_1.time_ <= var_204_42 + arg_204_0 then
				local var_204_43 = arg_201_1.var_.effect87878

				if var_204_43 then
					Object.Destroy(var_204_43)

					arg_201_1.var_.effect87878 = nil
				end
			end

			local var_204_44 = arg_201_1.actors_["10039ui_story"].transform
			local var_204_45 = 0

			if var_204_45 < arg_201_1.time_ and arg_201_1.time_ <= var_204_45 + arg_204_0 then
				arg_201_1.var_.moveOldPos10039ui_story = var_204_44.localPosition
			end

			local var_204_46 = 0.001

			if var_204_45 <= arg_201_1.time_ and arg_201_1.time_ < var_204_45 + var_204_46 then
				local var_204_47 = (arg_201_1.time_ - var_204_45) / var_204_46
				local var_204_48 = Vector3.New(0, 100, 0)

				var_204_44.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10039ui_story, var_204_48, var_204_47)

				local var_204_49 = manager.ui.mainCamera.transform.position - var_204_44.position

				var_204_44.forward = Vector3.New(var_204_49.x, var_204_49.y, var_204_49.z)

				local var_204_50 = var_204_44.localEulerAngles

				var_204_50.z = 0
				var_204_50.x = 0
				var_204_44.localEulerAngles = var_204_50
			end

			if arg_201_1.time_ >= var_204_45 + var_204_46 and arg_201_1.time_ < var_204_45 + var_204_46 + arg_204_0 then
				var_204_44.localPosition = Vector3.New(0, 100, 0)

				local var_204_51 = manager.ui.mainCamera.transform.position - var_204_44.position

				var_204_44.forward = Vector3.New(var_204_51.x, var_204_51.y, var_204_51.z)

				local var_204_52 = var_204_44.localEulerAngles

				var_204_52.z = 0
				var_204_52.x = 0
				var_204_44.localEulerAngles = var_204_52
			end

			local var_204_53 = arg_201_1.actors_["1070ui_story"].transform
			local var_204_54 = 0

			if var_204_54 < arg_201_1.time_ and arg_201_1.time_ <= var_204_54 + arg_204_0 then
				arg_201_1.var_.moveOldPos1070ui_story = var_204_53.localPosition
			end

			local var_204_55 = 0.001

			if var_204_54 <= arg_201_1.time_ and arg_201_1.time_ < var_204_54 + var_204_55 then
				local var_204_56 = (arg_201_1.time_ - var_204_54) / var_204_55
				local var_204_57 = Vector3.New(0, 100, 0)

				var_204_53.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1070ui_story, var_204_57, var_204_56)

				local var_204_58 = manager.ui.mainCamera.transform.position - var_204_53.position

				var_204_53.forward = Vector3.New(var_204_58.x, var_204_58.y, var_204_58.z)

				local var_204_59 = var_204_53.localEulerAngles

				var_204_59.z = 0
				var_204_59.x = 0
				var_204_53.localEulerAngles = var_204_59
			end

			if arg_201_1.time_ >= var_204_54 + var_204_55 and arg_201_1.time_ < var_204_54 + var_204_55 + arg_204_0 then
				var_204_53.localPosition = Vector3.New(0, 100, 0)

				local var_204_60 = manager.ui.mainCamera.transform.position - var_204_53.position

				var_204_53.forward = Vector3.New(var_204_60.x, var_204_60.y, var_204_60.z)

				local var_204_61 = var_204_53.localEulerAngles

				var_204_61.z = 0
				var_204_61.x = 0
				var_204_53.localEulerAngles = var_204_61
			end

			local var_204_62 = 0

			if var_204_62 < arg_201_1.time_ and arg_201_1.time_ <= var_204_62 + arg_204_0 then
				arg_201_1.allBtn_.enabled = false
			end

			local var_204_63 = 0.9

			if arg_201_1.time_ >= var_204_62 + var_204_63 and arg_201_1.time_ < var_204_62 + var_204_63 + arg_204_0 then
				arg_201_1.allBtn_.enabled = true
			end

			local var_204_64 = 0.6
			local var_204_65 = 1

			if var_204_64 < arg_201_1.time_ and arg_201_1.time_ <= var_204_64 + arg_204_0 then
				local var_204_66 = "play"
				local var_204_67 = "effect"

				arg_201_1:AudioAction(var_204_66, var_204_67, "se_story_148", "se_story_148_horror", "")
			end

			if arg_201_1.frameCnt_ <= 1 then
				arg_201_1.dialog_:SetActive(false)
			end

			local var_204_68 = 1.13333333333333
			local var_204_69 = 0.05

			if var_204_68 < arg_201_1.time_ and arg_201_1.time_ <= var_204_68 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_70 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_70:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_71 = arg_201_1:FormatText(StoryNameCfg[318].name)

				arg_201_1.leftNameTxt_.text = var_204_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_72 = arg_201_1:GetWordFromCfg(323201049)
				local var_204_73 = arg_201_1:FormatText(var_204_72.content)

				arg_201_1.text_.text = var_204_73

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_74 = 2
				local var_204_75 = utf8.len(var_204_73)
				local var_204_76 = var_204_74 <= 0 and var_204_69 or var_204_69 * (var_204_75 / var_204_74)

				if var_204_76 > 0 and var_204_69 < var_204_76 then
					arg_201_1.talkMaxDuration = var_204_76
					var_204_68 = var_204_68 + 0.3

					if var_204_76 + var_204_68 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_76 + var_204_68
					end
				end

				arg_201_1.text_.text = var_204_73
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201049", "story_v_out_323201.awb") ~= 0 then
					local var_204_77 = manager.audio:GetVoiceLength("story_v_out_323201", "323201049", "story_v_out_323201.awb") / 1000

					if var_204_77 + var_204_68 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_77 + var_204_68
					end

					if var_204_72.prefab_name ~= "" and arg_201_1.actors_[var_204_72.prefab_name] ~= nil then
						local var_204_78 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_72.prefab_name].transform, "story_v_out_323201", "323201049", "story_v_out_323201.awb")

						arg_201_1:RecordAudio("323201049", var_204_78)
						arg_201_1:RecordAudio("323201049", var_204_78)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_323201", "323201049", "story_v_out_323201.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_323201", "323201049", "story_v_out_323201.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_79 = var_204_68 + 0.3
			local var_204_80 = math.max(var_204_69, arg_201_1.talkMaxDuration)

			if var_204_79 <= arg_201_1.time_ and arg_201_1.time_ < var_204_79 + var_204_80 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_79) / var_204_80

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_79 + var_204_80 and arg_201_1.time_ < var_204_79 + var_204_80 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play323201050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 323201050
		arg_207_1.duration_ = 10.37

		local var_207_0 = {
			zh = 9.76633333333333,
			ja = 10.3663333333333
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play323201051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10039ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10039ui_story == nil then
				arg_207_1.var_.characterEffect10039ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect10039ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10039ui_story then
				arg_207_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_210_4 = arg_207_1.actors_["1070ui_story"]
			local var_210_5 = 0

			if var_210_5 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1070ui_story == nil then
				arg_207_1.var_.characterEffect1070ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_6 and not isNil(var_210_4) then
				local var_210_7 = (arg_207_1.time_ - var_210_5) / var_210_6

				if arg_207_1.var_.characterEffect1070ui_story and not isNil(var_210_4) then
					local var_210_8 = Mathf.Lerp(0, 0.5, var_210_7)

					arg_207_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1070ui_story.fillRatio = var_210_8
				end
			end

			if arg_207_1.time_ >= var_210_5 + var_210_6 and arg_207_1.time_ < var_210_5 + var_210_6 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect1070ui_story then
				local var_210_9 = 0.5

				arg_207_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1070ui_story.fillRatio = var_210_9
			end

			local var_210_10 = arg_207_1.actors_["10039ui_story"].transform
			local var_210_11 = 0

			if var_210_11 < arg_207_1.time_ and arg_207_1.time_ <= var_210_11 + arg_210_0 then
				arg_207_1.var_.moveOldPos10039ui_story = var_210_10.localPosition
			end

			local var_210_12 = 0.001

			if var_210_11 <= arg_207_1.time_ and arg_207_1.time_ < var_210_11 + var_210_12 then
				local var_210_13 = (arg_207_1.time_ - var_210_11) / var_210_12
				local var_210_14 = Vector3.New(0, -0.8, -6.2)

				var_210_10.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10039ui_story, var_210_14, var_210_13)

				local var_210_15 = manager.ui.mainCamera.transform.position - var_210_10.position

				var_210_10.forward = Vector3.New(var_210_15.x, var_210_15.y, var_210_15.z)

				local var_210_16 = var_210_10.localEulerAngles

				var_210_16.z = 0
				var_210_16.x = 0
				var_210_10.localEulerAngles = var_210_16
			end

			if arg_207_1.time_ >= var_210_11 + var_210_12 and arg_207_1.time_ < var_210_11 + var_210_12 + arg_210_0 then
				var_210_10.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_210_17 = manager.ui.mainCamera.transform.position - var_210_10.position

				var_210_10.forward = Vector3.New(var_210_17.x, var_210_17.y, var_210_17.z)

				local var_210_18 = var_210_10.localEulerAngles

				var_210_18.z = 0
				var_210_18.x = 0
				var_210_10.localEulerAngles = var_210_18
			end

			local var_210_19 = manager.ui.mainCamera.transform
			local var_210_20 = manager.ui.mainCameraCom_
			local var_210_21 = 0
			local var_210_22 = Vector3.New(0, 1, -10)
			local var_210_23 = Quaternion.Euler(0, 0, 0)
			local var_210_24 = 25

			if var_210_21 < arg_207_1.time_ and arg_207_1.time_ <= var_210_21 + arg_210_0 then
				arg_207_1.var_.cameraOldPos = var_210_19.localPosition
				arg_207_1.var_.cameraOldRot = var_210_19.localRotation
				arg_207_1.var_.cameraOldFov = var_210_20.fieldOfView
			end

			local var_210_25 = 0.0166666666666667

			if var_210_21 <= arg_207_1.time_ and arg_207_1.time_ < var_210_21 + var_210_25 then
				local var_210_26 = (arg_207_1.time_ - var_210_21) / var_210_25

				var_210_19.localPosition = Vector3.Lerp(arg_207_1.var_.cameraOldPos, var_210_22, var_210_26)
				var_210_19.localRotation = Quaternion.Slerp(arg_207_1.var_.cameraOldRot, var_210_23, var_210_26)
				var_210_20.fieldOfView = Mathf.Lerp(arg_207_1.var_.cameraOldFov, var_210_24, var_210_26)
			end

			if arg_207_1.time_ >= var_210_21 + var_210_25 and arg_207_1.time_ < var_210_21 + var_210_25 + arg_210_0 then
				var_210_19.localPosition = var_210_22
				var_210_19.localRotation = var_210_23
				var_210_20.fieldOfView = var_210_24
			end

			local var_210_27 = manager.ui.mainCamera.transform
			local var_210_28 = manager.ui.mainCameraCom_
			local var_210_29 = 0.366666666666667
			local var_210_30 = Vector3.New(0, 0.52, -10.91)
			local var_210_31 = Quaternion.Euler(-6.55, 0, 0)
			local var_210_32 = 13.3

			if var_210_29 < arg_207_1.time_ and arg_207_1.time_ <= var_210_29 + arg_210_0 then
				arg_207_1.var_.cameraOldPos = var_210_27.localPosition
				arg_207_1.var_.cameraOldRot = var_210_27.localRotation
				arg_207_1.var_.cameraOldFov = var_210_28.fieldOfView
			end

			local var_210_33 = 0.966666666666667

			if var_210_29 <= arg_207_1.time_ and arg_207_1.time_ < var_210_29 + var_210_33 then
				local var_210_34 = (arg_207_1.time_ - var_210_29) / var_210_33

				var_210_27.localPosition = Vector3.Lerp(arg_207_1.var_.cameraOldPos, var_210_30, var_210_34)
				var_210_27.localRotation = Quaternion.Slerp(arg_207_1.var_.cameraOldRot, var_210_31, var_210_34)
				var_210_28.fieldOfView = Mathf.Lerp(arg_207_1.var_.cameraOldFov, var_210_32, var_210_34)
			end

			if arg_207_1.time_ >= var_210_29 + var_210_33 and arg_207_1.time_ < var_210_29 + var_210_33 + arg_210_0 then
				var_210_27.localPosition = var_210_30
				var_210_27.localRotation = var_210_31
				var_210_28.fieldOfView = var_210_32
			end

			local var_210_35 = 0

			if var_210_35 < arg_207_1.time_ and arg_207_1.time_ <= var_210_35 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_36 = 0.866666666666667

			if var_210_35 <= arg_207_1.time_ and arg_207_1.time_ < var_210_35 + var_210_36 then
				local var_210_37 = (arg_207_1.time_ - var_210_35) / var_210_36
				local var_210_38 = Color.New(1, 1, 1)

				var_210_38.a = Mathf.Lerp(1, 0, var_210_37)
				arg_207_1.mask_.color = var_210_38
			end

			if arg_207_1.time_ >= var_210_35 + var_210_36 and arg_207_1.time_ < var_210_35 + var_210_36 + arg_210_0 then
				local var_210_39 = Color.New(1, 1, 1)
				local var_210_40 = 0

				arg_207_1.mask_.enabled = false
				var_210_39.a = var_210_40
				arg_207_1.mask_.color = var_210_39
			end

			local var_210_41 = 0

			if var_210_41 < arg_207_1.time_ and arg_207_1.time_ <= var_210_41 + arg_210_0 then
				arg_207_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_210_42 = 0

			if var_210_42 < arg_207_1.time_ and arg_207_1.time_ <= var_210_42 + arg_210_0 then
				arg_207_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_210_43 = 0

			if var_210_43 < arg_207_1.time_ and arg_207_1.time_ <= var_210_43 + arg_210_0 then
				arg_207_1.allBtn_.enabled = false
			end

			local var_210_44 = 1.7

			if arg_207_1.time_ >= var_210_43 + var_210_44 and arg_207_1.time_ < var_210_43 + var_210_44 + arg_210_0 then
				arg_207_1.allBtn_.enabled = true
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_45 = 1.13333333333333
			local var_210_46 = 0.725

			if var_210_45 < arg_207_1.time_ and arg_207_1.time_ <= var_210_45 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_47 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_47:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_48 = arg_207_1:FormatText(StoryNameCfg[472].name)

				arg_207_1.leftNameTxt_.text = var_210_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_49 = arg_207_1:GetWordFromCfg(323201050)
				local var_210_50 = arg_207_1:FormatText(var_210_49.content)

				arg_207_1.text_.text = var_210_50

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_51 = 29
				local var_210_52 = utf8.len(var_210_50)
				local var_210_53 = var_210_51 <= 0 and var_210_46 or var_210_46 * (var_210_52 / var_210_51)

				if var_210_53 > 0 and var_210_46 < var_210_53 then
					arg_207_1.talkMaxDuration = var_210_53
					var_210_45 = var_210_45 + 0.3

					if var_210_53 + var_210_45 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_53 + var_210_45
					end
				end

				arg_207_1.text_.text = var_210_50
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201050", "story_v_out_323201.awb") ~= 0 then
					local var_210_54 = manager.audio:GetVoiceLength("story_v_out_323201", "323201050", "story_v_out_323201.awb") / 1000

					if var_210_54 + var_210_45 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_54 + var_210_45
					end

					if var_210_49.prefab_name ~= "" and arg_207_1.actors_[var_210_49.prefab_name] ~= nil then
						local var_210_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_49.prefab_name].transform, "story_v_out_323201", "323201050", "story_v_out_323201.awb")

						arg_207_1:RecordAudio("323201050", var_210_55)
						arg_207_1:RecordAudio("323201050", var_210_55)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_323201", "323201050", "story_v_out_323201.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_323201", "323201050", "story_v_out_323201.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_56 = var_210_45 + 0.3
			local var_210_57 = math.max(var_210_46, arg_207_1.talkMaxDuration)

			if var_210_56 <= arg_207_1.time_ and arg_207_1.time_ < var_210_56 + var_210_57 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_56) / var_210_57

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_56 + var_210_57 and arg_207_1.time_ < var_210_56 + var_210_57 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play323201051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 323201051
		arg_213_1.duration_ = 4.9

		local var_213_0 = {
			zh = 4.9,
			ja = 2.266
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play323201052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1070ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1070ui_story == nil then
				arg_213_1.var_.characterEffect1070ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1070ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1070ui_story then
				arg_213_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_216_4 = arg_213_1.actors_["10039ui_story"]
			local var_216_5 = 0

			if var_216_5 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect10039ui_story == nil then
				arg_213_1.var_.characterEffect10039ui_story = var_216_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_6 = 0.200000002980232

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_6 and not isNil(var_216_4) then
				local var_216_7 = (arg_213_1.time_ - var_216_5) / var_216_6

				if arg_213_1.var_.characterEffect10039ui_story and not isNil(var_216_4) then
					local var_216_8 = Mathf.Lerp(0, 0.5, var_216_7)

					arg_213_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10039ui_story.fillRatio = var_216_8
				end
			end

			if arg_213_1.time_ >= var_216_5 + var_216_6 and arg_213_1.time_ < var_216_5 + var_216_6 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect10039ui_story then
				local var_216_9 = 0.5

				arg_213_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10039ui_story.fillRatio = var_216_9
			end

			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_216_11 = 0

			if var_216_11 < arg_213_1.time_ and arg_213_1.time_ <= var_216_11 + arg_216_0 then
				arg_213_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_216_12 = 0
			local var_216_13 = 0.05

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_14 = arg_213_1:FormatText(StoryNameCfg[318].name)

				arg_213_1.leftNameTxt_.text = var_216_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_4")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_15 = arg_213_1:GetWordFromCfg(323201051)
				local var_216_16 = arg_213_1:FormatText(var_216_15.content)

				arg_213_1.text_.text = var_216_16

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_17 = 2
				local var_216_18 = utf8.len(var_216_16)
				local var_216_19 = var_216_17 <= 0 and var_216_13 or var_216_13 * (var_216_18 / var_216_17)

				if var_216_19 > 0 and var_216_13 < var_216_19 then
					arg_213_1.talkMaxDuration = var_216_19

					if var_216_19 + var_216_12 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_19 + var_216_12
					end
				end

				arg_213_1.text_.text = var_216_16
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201051", "story_v_out_323201.awb") ~= 0 then
					local var_216_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201051", "story_v_out_323201.awb") / 1000

					if var_216_20 + var_216_12 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_20 + var_216_12
					end

					if var_216_15.prefab_name ~= "" and arg_213_1.actors_[var_216_15.prefab_name] ~= nil then
						local var_216_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_15.prefab_name].transform, "story_v_out_323201", "323201051", "story_v_out_323201.awb")

						arg_213_1:RecordAudio("323201051", var_216_21)
						arg_213_1:RecordAudio("323201051", var_216_21)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_323201", "323201051", "story_v_out_323201.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_323201", "323201051", "story_v_out_323201.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_22 = math.max(var_216_13, arg_213_1.talkMaxDuration)

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_22 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_12) / var_216_22

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_12 + var_216_22 and arg_213_1.time_ < var_216_12 + var_216_22 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play323201052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 323201052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play323201053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10039ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10039ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0, 100, 0)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10039ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, 100, 0)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["1070ui_story"].transform
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 then
				arg_217_1.var_.moveOldPos1070ui_story = var_220_9.localPosition
			end

			local var_220_11 = 0.001

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11
				local var_220_13 = Vector3.New(0, 100, 0)

				var_220_9.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1070ui_story, var_220_13, var_220_12)

				local var_220_14 = manager.ui.mainCamera.transform.position - var_220_9.position

				var_220_9.forward = Vector3.New(var_220_14.x, var_220_14.y, var_220_14.z)

				local var_220_15 = var_220_9.localEulerAngles

				var_220_15.z = 0
				var_220_15.x = 0
				var_220_9.localEulerAngles = var_220_15
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 then
				var_220_9.localPosition = Vector3.New(0, 100, 0)

				local var_220_16 = manager.ui.mainCamera.transform.position - var_220_9.position

				var_220_9.forward = Vector3.New(var_220_16.x, var_220_16.y, var_220_16.z)

				local var_220_17 = var_220_9.localEulerAngles

				var_220_17.z = 0
				var_220_17.x = 0
				var_220_9.localEulerAngles = var_220_17
			end

			local var_220_18 = arg_217_1.actors_["1070ui_story"]
			local var_220_19 = 0

			if var_220_19 < arg_217_1.time_ and arg_217_1.time_ <= var_220_19 + arg_220_0 and not isNil(var_220_18) and arg_217_1.var_.characterEffect1070ui_story == nil then
				arg_217_1.var_.characterEffect1070ui_story = var_220_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_20 = 0.200000002980232

			if var_220_19 <= arg_217_1.time_ and arg_217_1.time_ < var_220_19 + var_220_20 and not isNil(var_220_18) then
				local var_220_21 = (arg_217_1.time_ - var_220_19) / var_220_20

				if arg_217_1.var_.characterEffect1070ui_story and not isNil(var_220_18) then
					local var_220_22 = Mathf.Lerp(0, 0.5, var_220_21)

					arg_217_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1070ui_story.fillRatio = var_220_22
				end
			end

			if arg_217_1.time_ >= var_220_19 + var_220_20 and arg_217_1.time_ < var_220_19 + var_220_20 + arg_220_0 and not isNil(var_220_18) and arg_217_1.var_.characterEffect1070ui_story then
				local var_220_23 = 0.5

				arg_217_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1070ui_story.fillRatio = var_220_23
			end

			local var_220_24 = 0
			local var_220_25 = 1.6

			if var_220_24 < arg_217_1.time_ and arg_217_1.time_ <= var_220_24 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_26 = arg_217_1:GetWordFromCfg(323201052)
				local var_220_27 = arg_217_1:FormatText(var_220_26.content)

				arg_217_1.text_.text = var_220_27

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_28 = 64
				local var_220_29 = utf8.len(var_220_27)
				local var_220_30 = var_220_28 <= 0 and var_220_25 or var_220_25 * (var_220_29 / var_220_28)

				if var_220_30 > 0 and var_220_25 < var_220_30 then
					arg_217_1.talkMaxDuration = var_220_30

					if var_220_30 + var_220_24 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_30 + var_220_24
					end
				end

				arg_217_1.text_.text = var_220_27
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_31 = math.max(var_220_25, arg_217_1.talkMaxDuration)

			if var_220_24 <= arg_217_1.time_ and arg_217_1.time_ < var_220_24 + var_220_31 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_24) / var_220_31

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_24 + var_220_31 and arg_217_1.time_ < var_220_24 + var_220_31 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play323201053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 323201053
		arg_221_1.duration_ = 6.13

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play323201054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = manager.ui.mainCamera.transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				local var_224_2 = arg_221_1.var_.effect878789
				local var_224_3
				local var_224_4 = var_224_0

				if not var_224_2 then
					var_224_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_224_4)
					var_224_2.name = "878789"
					arg_221_1.var_.effect878789 = var_224_2
				else
					var_224_2.transform:SetParent(var_224_4)
				end

				var_224_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_224_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_224_5 = 1.7777777777777777
				local var_224_6 = Screen.width / Screen.height
				local var_224_7 = var_224_6 / var_224_5
				local var_224_8 = Mathf.Max(var_224_5 / var_224_6, 1)

				var_224_2.transform.localScale = Vector3.New(var_224_2.transform.localScale.x * var_224_7, var_224_2.transform.localScale.y * var_224_8, var_224_2.transform.localScale.z)
			end

			local var_224_9 = manager.ui.mainCamera.transform
			local var_224_10 = 1.13333333333333

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 then
				local var_224_11 = arg_221_1.var_.effect878789

				if var_224_11 then
					Object.Destroy(var_224_11)

					arg_221_1.var_.effect878789 = nil
				end
			end

			local var_224_12 = 0

			if var_224_12 < arg_221_1.time_ and arg_221_1.time_ <= var_224_12 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			local var_224_13 = 1.7

			if arg_221_1.time_ >= var_224_12 + var_224_13 and arg_221_1.time_ < var_224_12 + var_224_13 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end

			local var_224_14 = 0
			local var_224_15 = 1

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				local var_224_16 = "play"
				local var_224_17 = "effect"

				arg_221_1:AudioAction(var_224_16, var_224_17, "se_story_145", "se_story_145_horror", "")
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_18 = 1.13333333333333
			local var_224_19 = 1.475

			if var_224_18 < arg_221_1.time_ and arg_221_1.time_ <= var_224_18 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_20 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_20:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_21 = arg_221_1:GetWordFromCfg(323201053)
				local var_224_22 = arg_221_1:FormatText(var_224_21.content)

				arg_221_1.text_.text = var_224_22

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_23 = 59
				local var_224_24 = utf8.len(var_224_22)
				local var_224_25 = var_224_23 <= 0 and var_224_19 or var_224_19 * (var_224_24 / var_224_23)

				if var_224_25 > 0 and var_224_19 < var_224_25 then
					arg_221_1.talkMaxDuration = var_224_25
					var_224_18 = var_224_18 + 0.3

					if var_224_25 + var_224_18 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_25 + var_224_18
					end
				end

				arg_221_1.text_.text = var_224_22
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_26 = var_224_18 + 0.3
			local var_224_27 = math.max(var_224_19, arg_221_1.talkMaxDuration)

			if var_224_26 <= arg_221_1.time_ and arg_221_1.time_ < var_224_26 + var_224_27 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_26) / var_224_27

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_26 + var_224_27 and arg_221_1.time_ < var_224_26 + var_224_27 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play323201054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 323201054
		arg_227_1.duration_ = 7.8

		local var_227_0 = {
			zh = 5.533,
			ja = 7.8
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play323201055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1070ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1070ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(0, -0.95, -6.05)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1070ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["1070ui_story"]
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1070ui_story == nil then
				arg_227_1.var_.characterEffect1070ui_story = var_230_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_11 = 0.200000002980232

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 and not isNil(var_230_9) then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11

				if arg_227_1.var_.characterEffect1070ui_story and not isNil(var_230_9) then
					arg_227_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect1070ui_story then
				arg_227_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_230_13 = 0

			if var_230_13 < arg_227_1.time_ and arg_227_1.time_ <= var_230_13 + arg_230_0 then
				arg_227_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_230_14 = 0

			if var_230_14 < arg_227_1.time_ and arg_227_1.time_ <= var_230_14 + arg_230_0 then
				arg_227_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva", "EmotionTimelineAnimator")
			end

			local var_230_15 = 0
			local var_230_16 = 0.55

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_17 = arg_227_1:FormatText(StoryNameCfg[318].name)

				arg_227_1.leftNameTxt_.text = var_230_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_18 = arg_227_1:GetWordFromCfg(323201054)
				local var_230_19 = arg_227_1:FormatText(var_230_18.content)

				arg_227_1.text_.text = var_230_19

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_20 = 22
				local var_230_21 = utf8.len(var_230_19)
				local var_230_22 = var_230_20 <= 0 and var_230_16 or var_230_16 * (var_230_21 / var_230_20)

				if var_230_22 > 0 and var_230_16 < var_230_22 then
					arg_227_1.talkMaxDuration = var_230_22

					if var_230_22 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_22 + var_230_15
					end
				end

				arg_227_1.text_.text = var_230_19
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201054", "story_v_out_323201.awb") ~= 0 then
					local var_230_23 = manager.audio:GetVoiceLength("story_v_out_323201", "323201054", "story_v_out_323201.awb") / 1000

					if var_230_23 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_23 + var_230_15
					end

					if var_230_18.prefab_name ~= "" and arg_227_1.actors_[var_230_18.prefab_name] ~= nil then
						local var_230_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_18.prefab_name].transform, "story_v_out_323201", "323201054", "story_v_out_323201.awb")

						arg_227_1:RecordAudio("323201054", var_230_24)
						arg_227_1:RecordAudio("323201054", var_230_24)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_323201", "323201054", "story_v_out_323201.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_323201", "323201054", "story_v_out_323201.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_25 = math.max(var_230_16, arg_227_1.talkMaxDuration)

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_25 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_15) / var_230_25

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_15 + var_230_25 and arg_227_1.time_ < var_230_15 + var_230_25 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play323201055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 323201055
		arg_231_1.duration_ = 6.3

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play323201056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1070ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1070ui_story == nil then
				arg_231_1.var_.characterEffect1070ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1070ui_story and not isNil(var_234_0) then
					local var_234_4 = Mathf.Lerp(0, 0.5, var_234_3)

					arg_231_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1070ui_story.fillRatio = var_234_4
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1070ui_story then
				local var_234_5 = 0.5

				arg_231_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1070ui_story.fillRatio = var_234_5
			end

			local var_234_6 = manager.ui.mainCamera.transform
			local var_234_7 = manager.ui.mainCameraCom_
			local var_234_8 = 0
			local var_234_9 = Vector3.New(0, 0.52, -10.91)
			local var_234_10 = Quaternion.Euler(-6.55, 0, 0)
			local var_234_11 = 13.3

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.var_.cameraOldPos = var_234_6.localPosition
				arg_231_1.var_.cameraOldRot = var_234_6.localRotation
				arg_231_1.var_.cameraOldFov = var_234_7.fieldOfView
			end

			local var_234_12 = 0.0166666666666667

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_12 then
				local var_234_13 = (arg_231_1.time_ - var_234_8) / var_234_12

				var_234_6.localPosition = Vector3.Lerp(arg_231_1.var_.cameraOldPos, var_234_9, var_234_13)
				var_234_6.localRotation = Quaternion.Slerp(arg_231_1.var_.cameraOldRot, var_234_10, var_234_13)
				var_234_7.fieldOfView = Mathf.Lerp(arg_231_1.var_.cameraOldFov, var_234_11, var_234_13)
			end

			if arg_231_1.time_ >= var_234_8 + var_234_12 and arg_231_1.time_ < var_234_8 + var_234_12 + arg_234_0 then
				var_234_6.localPosition = var_234_9
				var_234_6.localRotation = var_234_10
				var_234_7.fieldOfView = var_234_11
			end

			local var_234_14 = manager.ui.mainCamera.transform
			local var_234_15 = manager.ui.mainCameraCom_
			local var_234_16 = 0.0166666666666667
			local var_234_17 = Vector3.New(0, 1, -10)
			local var_234_18 = Quaternion.Euler(0, 0, 0)
			local var_234_19 = 25

			if var_234_16 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 then
				arg_231_1.var_.cameraOldPos = var_234_14.localPosition
				arg_231_1.var_.cameraOldRot = var_234_14.localRotation
				arg_231_1.var_.cameraOldFov = var_234_15.fieldOfView
			end

			local var_234_20 = 1.46666666666667

			if var_234_16 <= arg_231_1.time_ and arg_231_1.time_ < var_234_16 + var_234_20 then
				local var_234_21 = (arg_231_1.time_ - var_234_16) / var_234_20

				var_234_14.localPosition = Vector3.Lerp(arg_231_1.var_.cameraOldPos, var_234_17, var_234_21)
				var_234_14.localRotation = Quaternion.Slerp(arg_231_1.var_.cameraOldRot, var_234_18, var_234_21)
				var_234_15.fieldOfView = Mathf.Lerp(arg_231_1.var_.cameraOldFov, var_234_19, var_234_21)
			end

			if arg_231_1.time_ >= var_234_16 + var_234_20 and arg_231_1.time_ < var_234_16 + var_234_20 + arg_234_0 then
				var_234_14.localPosition = var_234_17
				var_234_14.localRotation = var_234_18
				var_234_15.fieldOfView = var_234_19
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_22 = 1.3
			local var_234_23 = 1.275

			if var_234_22 < arg_231_1.time_ and arg_231_1.time_ <= var_234_22 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_24 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_24:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_25 = arg_231_1:GetWordFromCfg(323201055)
				local var_234_26 = arg_231_1:FormatText(var_234_25.content)

				arg_231_1.text_.text = var_234_26

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_27 = 51
				local var_234_28 = utf8.len(var_234_26)
				local var_234_29 = var_234_27 <= 0 and var_234_23 or var_234_23 * (var_234_28 / var_234_27)

				if var_234_29 > 0 and var_234_23 < var_234_29 then
					arg_231_1.talkMaxDuration = var_234_29
					var_234_22 = var_234_22 + 0.3

					if var_234_29 + var_234_22 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_29 + var_234_22
					end
				end

				arg_231_1.text_.text = var_234_26
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_30 = var_234_22 + 0.3
			local var_234_31 = math.max(var_234_23, arg_231_1.talkMaxDuration)

			if var_234_30 <= arg_231_1.time_ and arg_231_1.time_ < var_234_30 + var_234_31 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_30) / var_234_31

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_30 + var_234_31 and arg_231_1.time_ < var_234_30 + var_234_31 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play323201056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 323201056
		arg_237_1.duration_ = 3.23

		local var_237_0 = {
			zh = 3.233,
			ja = 1.999999999999
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
				arg_237_0:Play323201057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1070ui_story"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1070ui_story == nil then
				arg_237_1.var_.characterEffect1070ui_story = var_240_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.characterEffect1070ui_story and not isNil(var_240_0) then
					arg_237_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.characterEffect1070ui_story then
				arg_237_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_240_4 = 0

			if var_240_4 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_240_5 = arg_237_1.actors_["1070ui_story"].transform
			local var_240_6 = 0

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.var_.moveOldPos1070ui_story = var_240_5.localPosition
			end

			local var_240_7 = 0.001

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_7 then
				local var_240_8 = (arg_237_1.time_ - var_240_6) / var_240_7
				local var_240_9 = Vector3.New(0, -0.95, -6.05)

				var_240_5.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1070ui_story, var_240_9, var_240_8)

				local var_240_10 = manager.ui.mainCamera.transform.position - var_240_5.position

				var_240_5.forward = Vector3.New(var_240_10.x, var_240_10.y, var_240_10.z)

				local var_240_11 = var_240_5.localEulerAngles

				var_240_11.z = 0
				var_240_11.x = 0
				var_240_5.localEulerAngles = var_240_11
			end

			if arg_237_1.time_ >= var_240_6 + var_240_7 and arg_237_1.time_ < var_240_6 + var_240_7 + arg_240_0 then
				var_240_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_240_12 = manager.ui.mainCamera.transform.position - var_240_5.position

				var_240_5.forward = Vector3.New(var_240_12.x, var_240_12.y, var_240_12.z)

				local var_240_13 = var_240_5.localEulerAngles

				var_240_13.z = 0
				var_240_13.x = 0
				var_240_5.localEulerAngles = var_240_13
			end

			local var_240_14 = 0
			local var_240_15 = 0.15

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_16 = arg_237_1:FormatText(StoryNameCfg[318].name)

				arg_237_1.leftNameTxt_.text = var_240_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_17 = arg_237_1:GetWordFromCfg(323201056)
				local var_240_18 = arg_237_1:FormatText(var_240_17.content)

				arg_237_1.text_.text = var_240_18

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_19 = 6
				local var_240_20 = utf8.len(var_240_18)
				local var_240_21 = var_240_19 <= 0 and var_240_15 or var_240_15 * (var_240_20 / var_240_19)

				if var_240_21 > 0 and var_240_15 < var_240_21 then
					arg_237_1.talkMaxDuration = var_240_21

					if var_240_21 + var_240_14 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_21 + var_240_14
					end
				end

				arg_237_1.text_.text = var_240_18
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201056", "story_v_out_323201.awb") ~= 0 then
					local var_240_22 = manager.audio:GetVoiceLength("story_v_out_323201", "323201056", "story_v_out_323201.awb") / 1000

					if var_240_22 + var_240_14 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_22 + var_240_14
					end

					if var_240_17.prefab_name ~= "" and arg_237_1.actors_[var_240_17.prefab_name] ~= nil then
						local var_240_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_17.prefab_name].transform, "story_v_out_323201", "323201056", "story_v_out_323201.awb")

						arg_237_1:RecordAudio("323201056", var_240_23)
						arg_237_1:RecordAudio("323201056", var_240_23)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_323201", "323201056", "story_v_out_323201.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_323201", "323201056", "story_v_out_323201.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_24 = math.max(var_240_15, arg_237_1.talkMaxDuration)

			if var_240_14 <= arg_237_1.time_ and arg_237_1.time_ < var_240_14 + var_240_24 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_14) / var_240_24

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_14 + var_240_24 and arg_237_1.time_ < var_240_14 + var_240_24 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play323201057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 323201057
		arg_241_1.duration_ = 2.73

		local var_241_0 = {
			zh = 1.266,
			ja = 2.733
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play323201058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10039ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect10039ui_story == nil then
				arg_241_1.var_.characterEffect10039ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect10039ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect10039ui_story then
				arg_241_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_244_4 = arg_241_1.actors_["1070ui_story"]
			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect1070ui_story == nil then
				arg_241_1.var_.characterEffect1070ui_story = var_244_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_6 = 0.200000002980232

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_6 and not isNil(var_244_4) then
				local var_244_7 = (arg_241_1.time_ - var_244_5) / var_244_6

				if arg_241_1.var_.characterEffect1070ui_story and not isNil(var_244_4) then
					local var_244_8 = Mathf.Lerp(0, 0.5, var_244_7)

					arg_241_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1070ui_story.fillRatio = var_244_8
				end
			end

			if arg_241_1.time_ >= var_244_5 + var_244_6 and arg_241_1.time_ < var_244_5 + var_244_6 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect1070ui_story then
				local var_244_9 = 0.5

				arg_241_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1070ui_story.fillRatio = var_244_9
			end

			local var_244_10 = arg_241_1.actors_["10039ui_story"].transform
			local var_244_11 = 0

			if var_244_11 < arg_241_1.time_ and arg_241_1.time_ <= var_244_11 + arg_244_0 then
				arg_241_1.var_.moveOldPos10039ui_story = var_244_10.localPosition
			end

			local var_244_12 = 0.001

			if var_244_11 <= arg_241_1.time_ and arg_241_1.time_ < var_244_11 + var_244_12 then
				local var_244_13 = (arg_241_1.time_ - var_244_11) / var_244_12
				local var_244_14 = Vector3.New(-0.7, -0.8, -6.2)

				var_244_10.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10039ui_story, var_244_14, var_244_13)

				local var_244_15 = manager.ui.mainCamera.transform.position - var_244_10.position

				var_244_10.forward = Vector3.New(var_244_15.x, var_244_15.y, var_244_15.z)

				local var_244_16 = var_244_10.localEulerAngles

				var_244_16.z = 0
				var_244_16.x = 0
				var_244_10.localEulerAngles = var_244_16
			end

			if arg_241_1.time_ >= var_244_11 + var_244_12 and arg_241_1.time_ < var_244_11 + var_244_12 + arg_244_0 then
				var_244_10.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_244_17 = manager.ui.mainCamera.transform.position - var_244_10.position

				var_244_10.forward = Vector3.New(var_244_17.x, var_244_17.y, var_244_17.z)

				local var_244_18 = var_244_10.localEulerAngles

				var_244_18.z = 0
				var_244_18.x = 0
				var_244_10.localEulerAngles = var_244_18
			end

			local var_244_19 = arg_241_1.actors_["1070ui_story"].transform
			local var_244_20 = 0

			if var_244_20 < arg_241_1.time_ and arg_241_1.time_ <= var_244_20 + arg_244_0 then
				arg_241_1.var_.moveOldPos1070ui_story = var_244_19.localPosition
			end

			local var_244_21 = 0.001

			if var_244_20 <= arg_241_1.time_ and arg_241_1.time_ < var_244_20 + var_244_21 then
				local var_244_22 = (arg_241_1.time_ - var_244_20) / var_244_21
				local var_244_23 = Vector3.New(0.7, -0.95, -6.05)

				var_244_19.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1070ui_story, var_244_23, var_244_22)

				local var_244_24 = manager.ui.mainCamera.transform.position - var_244_19.position

				var_244_19.forward = Vector3.New(var_244_24.x, var_244_24.y, var_244_24.z)

				local var_244_25 = var_244_19.localEulerAngles

				var_244_25.z = 0
				var_244_25.x = 0
				var_244_19.localEulerAngles = var_244_25
			end

			if arg_241_1.time_ >= var_244_20 + var_244_21 and arg_241_1.time_ < var_244_20 + var_244_21 + arg_244_0 then
				var_244_19.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_244_26 = manager.ui.mainCamera.transform.position - var_244_19.position

				var_244_19.forward = Vector3.New(var_244_26.x, var_244_26.y, var_244_26.z)

				local var_244_27 = var_244_19.localEulerAngles

				var_244_27.z = 0
				var_244_27.x = 0
				var_244_19.localEulerAngles = var_244_27
			end

			local var_244_28 = 0

			if var_244_28 < arg_241_1.time_ and arg_241_1.time_ <= var_244_28 + arg_244_0 then
				arg_241_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_244_29 = 0

			if var_244_29 < arg_241_1.time_ and arg_241_1.time_ <= var_244_29 + arg_244_0 then
				arg_241_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_244_30 = 0
			local var_244_31 = 0.05

			if var_244_30 < arg_241_1.time_ and arg_241_1.time_ <= var_244_30 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_32 = arg_241_1:FormatText(StoryNameCfg[472].name)

				arg_241_1.leftNameTxt_.text = var_244_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_33 = arg_241_1:GetWordFromCfg(323201057)
				local var_244_34 = arg_241_1:FormatText(var_244_33.content)

				arg_241_1.text_.text = var_244_34

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_35 = 2
				local var_244_36 = utf8.len(var_244_34)
				local var_244_37 = var_244_35 <= 0 and var_244_31 or var_244_31 * (var_244_36 / var_244_35)

				if var_244_37 > 0 and var_244_31 < var_244_37 then
					arg_241_1.talkMaxDuration = var_244_37

					if var_244_37 + var_244_30 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_37 + var_244_30
					end
				end

				arg_241_1.text_.text = var_244_34
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201057", "story_v_out_323201.awb") ~= 0 then
					local var_244_38 = manager.audio:GetVoiceLength("story_v_out_323201", "323201057", "story_v_out_323201.awb") / 1000

					if var_244_38 + var_244_30 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_38 + var_244_30
					end

					if var_244_33.prefab_name ~= "" and arg_241_1.actors_[var_244_33.prefab_name] ~= nil then
						local var_244_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_33.prefab_name].transform, "story_v_out_323201", "323201057", "story_v_out_323201.awb")

						arg_241_1:RecordAudio("323201057", var_244_39)
						arg_241_1:RecordAudio("323201057", var_244_39)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_323201", "323201057", "story_v_out_323201.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_323201", "323201057", "story_v_out_323201.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_40 = math.max(var_244_31, arg_241_1.talkMaxDuration)

			if var_244_30 <= arg_241_1.time_ and arg_241_1.time_ < var_244_30 + var_244_40 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_30) / var_244_40

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_30 + var_244_40 and arg_241_1.time_ < var_244_30 + var_244_40 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play323201058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 323201058
		arg_245_1.duration_ = 8.6

		local var_245_0 = {
			zh = 7.9,
			ja = 8.6
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play323201059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1070ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1070ui_story == nil then
				arg_245_1.var_.characterEffect1070ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1070ui_story and not isNil(var_248_0) then
					arg_245_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1070ui_story then
				arg_245_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_248_4 = arg_245_1.actors_["10039ui_story"]
			local var_248_5 = 0

			if var_248_5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect10039ui_story == nil then
				arg_245_1.var_.characterEffect10039ui_story = var_248_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_6 = 0.200000002980232

			if var_248_5 <= arg_245_1.time_ and arg_245_1.time_ < var_248_5 + var_248_6 and not isNil(var_248_4) then
				local var_248_7 = (arg_245_1.time_ - var_248_5) / var_248_6

				if arg_245_1.var_.characterEffect10039ui_story and not isNil(var_248_4) then
					local var_248_8 = Mathf.Lerp(0, 0.5, var_248_7)

					arg_245_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10039ui_story.fillRatio = var_248_8
				end
			end

			if arg_245_1.time_ >= var_248_5 + var_248_6 and arg_245_1.time_ < var_248_5 + var_248_6 + arg_248_0 and not isNil(var_248_4) and arg_245_1.var_.characterEffect10039ui_story then
				local var_248_9 = 0.5

				arg_245_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10039ui_story.fillRatio = var_248_9
			end

			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				arg_245_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_248_11 = 0
			local var_248_12 = 0.675

			if var_248_11 < arg_245_1.time_ and arg_245_1.time_ <= var_248_11 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_13 = arg_245_1:FormatText(StoryNameCfg[318].name)

				arg_245_1.leftNameTxt_.text = var_248_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_14 = arg_245_1:GetWordFromCfg(323201058)
				local var_248_15 = arg_245_1:FormatText(var_248_14.content)

				arg_245_1.text_.text = var_248_15

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_16 = 27
				local var_248_17 = utf8.len(var_248_15)
				local var_248_18 = var_248_16 <= 0 and var_248_12 or var_248_12 * (var_248_17 / var_248_16)

				if var_248_18 > 0 and var_248_12 < var_248_18 then
					arg_245_1.talkMaxDuration = var_248_18

					if var_248_18 + var_248_11 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_18 + var_248_11
					end
				end

				arg_245_1.text_.text = var_248_15
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201058", "story_v_out_323201.awb") ~= 0 then
					local var_248_19 = manager.audio:GetVoiceLength("story_v_out_323201", "323201058", "story_v_out_323201.awb") / 1000

					if var_248_19 + var_248_11 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_19 + var_248_11
					end

					if var_248_14.prefab_name ~= "" and arg_245_1.actors_[var_248_14.prefab_name] ~= nil then
						local var_248_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_14.prefab_name].transform, "story_v_out_323201", "323201058", "story_v_out_323201.awb")

						arg_245_1:RecordAudio("323201058", var_248_20)
						arg_245_1:RecordAudio("323201058", var_248_20)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_323201", "323201058", "story_v_out_323201.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_323201", "323201058", "story_v_out_323201.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_21 = math.max(var_248_12, arg_245_1.talkMaxDuration)

			if var_248_11 <= arg_245_1.time_ and arg_245_1.time_ < var_248_11 + var_248_21 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_11) / var_248_21

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_11 + var_248_21 and arg_245_1.time_ < var_248_11 + var_248_21 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play323201059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 323201059
		arg_249_1.duration_ = 15.4

		local var_249_0 = {
			zh = 9.9,
			ja = 15.4
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play323201060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.9

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[318].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:GetWordFromCfg(323201059)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 36
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201059", "story_v_out_323201.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_323201", "323201059", "story_v_out_323201.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_323201", "323201059", "story_v_out_323201.awb")

						arg_249_1:RecordAudio("323201059", var_252_9)
						arg_249_1:RecordAudio("323201059", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_323201", "323201059", "story_v_out_323201.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_323201", "323201059", "story_v_out_323201.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_10 and arg_249_1.time_ < var_252_0 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play323201060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 323201060
		arg_253_1.duration_ = 1.83

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play323201061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10039ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10039ui_story == nil then
				arg_253_1.var_.characterEffect10039ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect10039ui_story and not isNil(var_256_0) then
					arg_253_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10039ui_story then
				arg_253_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_256_4 = arg_253_1.actors_["1070ui_story"]
			local var_256_5 = 0

			if var_256_5 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect1070ui_story == nil then
				arg_253_1.var_.characterEffect1070ui_story = var_256_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_6 = 0.200000002980232

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_6 and not isNil(var_256_4) then
				local var_256_7 = (arg_253_1.time_ - var_256_5) / var_256_6

				if arg_253_1.var_.characterEffect1070ui_story and not isNil(var_256_4) then
					local var_256_8 = Mathf.Lerp(0, 0.5, var_256_7)

					arg_253_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1070ui_story.fillRatio = var_256_8
				end
			end

			if arg_253_1.time_ >= var_256_5 + var_256_6 and arg_253_1.time_ < var_256_5 + var_256_6 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect1070ui_story then
				local var_256_9 = 0.5

				arg_253_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1070ui_story.fillRatio = var_256_9
			end

			local var_256_10 = 0
			local var_256_11 = 0.05

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_12 = arg_253_1:FormatText(StoryNameCfg[472].name)

				arg_253_1.leftNameTxt_.text = var_256_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_13 = arg_253_1:GetWordFromCfg(323201060)
				local var_256_14 = arg_253_1:FormatText(var_256_13.content)

				arg_253_1.text_.text = var_256_14

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_15 = 2
				local var_256_16 = utf8.len(var_256_14)
				local var_256_17 = var_256_15 <= 0 and var_256_11 or var_256_11 * (var_256_16 / var_256_15)

				if var_256_17 > 0 and var_256_11 < var_256_17 then
					arg_253_1.talkMaxDuration = var_256_17

					if var_256_17 + var_256_10 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_17 + var_256_10
					end
				end

				arg_253_1.text_.text = var_256_14
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201060", "story_v_out_323201.awb") ~= 0 then
					local var_256_18 = manager.audio:GetVoiceLength("story_v_out_323201", "323201060", "story_v_out_323201.awb") / 1000

					if var_256_18 + var_256_10 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_18 + var_256_10
					end

					if var_256_13.prefab_name ~= "" and arg_253_1.actors_[var_256_13.prefab_name] ~= nil then
						local var_256_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_13.prefab_name].transform, "story_v_out_323201", "323201060", "story_v_out_323201.awb")

						arg_253_1:RecordAudio("323201060", var_256_19)
						arg_253_1:RecordAudio("323201060", var_256_19)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_323201", "323201060", "story_v_out_323201.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_323201", "323201060", "story_v_out_323201.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_20 = math.max(var_256_11, arg_253_1.talkMaxDuration)

			if var_256_10 <= arg_253_1.time_ and arg_253_1.time_ < var_256_10 + var_256_20 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_10) / var_256_20

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_10 + var_256_20 and arg_253_1.time_ < var_256_10 + var_256_20 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play323201061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 323201061
		arg_257_1.duration_ = 20.23

		local var_257_0 = {
			zh = 8.933,
			ja = 20.233
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play323201062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1070ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1070ui_story == nil then
				arg_257_1.var_.characterEffect1070ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1070ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1070ui_story then
				arg_257_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_260_4 = arg_257_1.actors_["10039ui_story"]
			local var_260_5 = 0

			if var_260_5 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect10039ui_story == nil then
				arg_257_1.var_.characterEffect10039ui_story = var_260_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_6 = 0.200000002980232

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_6 and not isNil(var_260_4) then
				local var_260_7 = (arg_257_1.time_ - var_260_5) / var_260_6

				if arg_257_1.var_.characterEffect10039ui_story and not isNil(var_260_4) then
					local var_260_8 = Mathf.Lerp(0, 0.5, var_260_7)

					arg_257_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_257_1.var_.characterEffect10039ui_story.fillRatio = var_260_8
				end
			end

			if arg_257_1.time_ >= var_260_5 + var_260_6 and arg_257_1.time_ < var_260_5 + var_260_6 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect10039ui_story then
				local var_260_9 = 0.5

				arg_257_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_257_1.var_.characterEffect10039ui_story.fillRatio = var_260_9
			end

			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_260_11 = 0

			if var_260_11 < arg_257_1.time_ and arg_257_1.time_ <= var_260_11 + arg_260_0 then
				arg_257_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_260_12 = 0
			local var_260_13 = 1

			if var_260_12 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_14 = arg_257_1:FormatText(StoryNameCfg[318].name)

				arg_257_1.leftNameTxt_.text = var_260_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_15 = arg_257_1:GetWordFromCfg(323201061)
				local var_260_16 = arg_257_1:FormatText(var_260_15.content)

				arg_257_1.text_.text = var_260_16

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_17 = 40
				local var_260_18 = utf8.len(var_260_16)
				local var_260_19 = var_260_17 <= 0 and var_260_13 or var_260_13 * (var_260_18 / var_260_17)

				if var_260_19 > 0 and var_260_13 < var_260_19 then
					arg_257_1.talkMaxDuration = var_260_19

					if var_260_19 + var_260_12 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_19 + var_260_12
					end
				end

				arg_257_1.text_.text = var_260_16
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201061", "story_v_out_323201.awb") ~= 0 then
					local var_260_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201061", "story_v_out_323201.awb") / 1000

					if var_260_20 + var_260_12 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_20 + var_260_12
					end

					if var_260_15.prefab_name ~= "" and arg_257_1.actors_[var_260_15.prefab_name] ~= nil then
						local var_260_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_15.prefab_name].transform, "story_v_out_323201", "323201061", "story_v_out_323201.awb")

						arg_257_1:RecordAudio("323201061", var_260_21)
						arg_257_1:RecordAudio("323201061", var_260_21)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_323201", "323201061", "story_v_out_323201.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_323201", "323201061", "story_v_out_323201.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_22 = math.max(var_260_13, arg_257_1.talkMaxDuration)

			if var_260_12 <= arg_257_1.time_ and arg_257_1.time_ < var_260_12 + var_260_22 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_12) / var_260_22

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_12 + var_260_22 and arg_257_1.time_ < var_260_12 + var_260_22 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play323201062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 323201062
		arg_261_1.duration_ = 1.83

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play323201063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10039ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect10039ui_story == nil then
				arg_261_1.var_.characterEffect10039ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect10039ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect10039ui_story then
				arg_261_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_264_4 = arg_261_1.actors_["1070ui_story"]
			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect1070ui_story == nil then
				arg_261_1.var_.characterEffect1070ui_story = var_264_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_6 and not isNil(var_264_4) then
				local var_264_7 = (arg_261_1.time_ - var_264_5) / var_264_6

				if arg_261_1.var_.characterEffect1070ui_story and not isNil(var_264_4) then
					local var_264_8 = Mathf.Lerp(0, 0.5, var_264_7)

					arg_261_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1070ui_story.fillRatio = var_264_8
				end
			end

			if arg_261_1.time_ >= var_264_5 + var_264_6 and arg_261_1.time_ < var_264_5 + var_264_6 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect1070ui_story then
				local var_264_9 = 0.5

				arg_261_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1070ui_story.fillRatio = var_264_9
			end

			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_264_11 = 0

			if var_264_11 < arg_261_1.time_ and arg_261_1.time_ <= var_264_11 + arg_264_0 then
				arg_261_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_264_12 = 0
			local var_264_13 = 0.05

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_14 = arg_261_1:FormatText(StoryNameCfg[472].name)

				arg_261_1.leftNameTxt_.text = var_264_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_15 = arg_261_1:GetWordFromCfg(323201062)
				local var_264_16 = arg_261_1:FormatText(var_264_15.content)

				arg_261_1.text_.text = var_264_16

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_17 = 2
				local var_264_18 = utf8.len(var_264_16)
				local var_264_19 = var_264_17 <= 0 and var_264_13 or var_264_13 * (var_264_18 / var_264_17)

				if var_264_19 > 0 and var_264_13 < var_264_19 then
					arg_261_1.talkMaxDuration = var_264_19

					if var_264_19 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_19 + var_264_12
					end
				end

				arg_261_1.text_.text = var_264_16
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201062", "story_v_out_323201.awb") ~= 0 then
					local var_264_20 = manager.audio:GetVoiceLength("story_v_out_323201", "323201062", "story_v_out_323201.awb") / 1000

					if var_264_20 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_20 + var_264_12
					end

					if var_264_15.prefab_name ~= "" and arg_261_1.actors_[var_264_15.prefab_name] ~= nil then
						local var_264_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_15.prefab_name].transform, "story_v_out_323201", "323201062", "story_v_out_323201.awb")

						arg_261_1:RecordAudio("323201062", var_264_21)
						arg_261_1:RecordAudio("323201062", var_264_21)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_323201", "323201062", "story_v_out_323201.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_323201", "323201062", "story_v_out_323201.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_22 = math.max(var_264_13, arg_261_1.talkMaxDuration)

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_22 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_12) / var_264_22

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_12 + var_264_22 and arg_261_1.time_ < var_264_12 + var_264_22 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play323201063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 323201063
		arg_265_1.duration_ = 2.74

		local var_265_0 = {
			zh = 2.675,
			ja = 2.741
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play323201064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1070ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1070ui_story == nil then
				arg_265_1.var_.characterEffect1070ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1070ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1070ui_story then
				arg_265_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_268_4 = arg_265_1.actors_["10039ui_story"]
			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect10039ui_story == nil then
				arg_265_1.var_.characterEffect10039ui_story = var_268_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_6 = 0.200000002980232

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_6 and not isNil(var_268_4) then
				local var_268_7 = (arg_265_1.time_ - var_268_5) / var_268_6

				if arg_265_1.var_.characterEffect10039ui_story and not isNil(var_268_4) then
					local var_268_8 = Mathf.Lerp(0, 0.5, var_268_7)

					arg_265_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10039ui_story.fillRatio = var_268_8
				end
			end

			if arg_265_1.time_ >= var_268_5 + var_268_6 and arg_265_1.time_ < var_268_5 + var_268_6 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect10039ui_story then
				local var_268_9 = 0.5

				arg_265_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10039ui_story.fillRatio = var_268_9
			end

			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 then
				arg_265_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_268_11 = 0

			if var_268_11 < arg_265_1.time_ and arg_265_1.time_ <= var_268_11 + arg_268_0 then
				arg_265_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_268_12 = 0

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			local var_268_13 = 1.53333333333333

			if arg_265_1.time_ >= var_268_12 + var_268_13 and arg_265_1.time_ < var_268_12 + var_268_13 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_14 = 0.875
			local var_268_15 = 0.125

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_16 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_16:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_17 = arg_265_1:FormatText(StoryNameCfg[318].name)

				arg_265_1.leftNameTxt_.text = var_268_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_18 = arg_265_1:GetWordFromCfg(323201063)
				local var_268_19 = arg_265_1:FormatText(var_268_18.content)

				arg_265_1.text_.text = var_268_19

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_20 = 5
				local var_268_21 = utf8.len(var_268_19)
				local var_268_22 = var_268_20 <= 0 and var_268_15 or var_268_15 * (var_268_21 / var_268_20)

				if var_268_22 > 0 and var_268_15 < var_268_22 then
					arg_265_1.talkMaxDuration = var_268_22
					var_268_14 = var_268_14 + 0.3

					if var_268_22 + var_268_14 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_22 + var_268_14
					end
				end

				arg_265_1.text_.text = var_268_19
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201063", "story_v_out_323201.awb") ~= 0 then
					local var_268_23 = manager.audio:GetVoiceLength("story_v_out_323201", "323201063", "story_v_out_323201.awb") / 1000

					if var_268_23 + var_268_14 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_14
					end

					if var_268_18.prefab_name ~= "" and arg_265_1.actors_[var_268_18.prefab_name] ~= nil then
						local var_268_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_18.prefab_name].transform, "story_v_out_323201", "323201063", "story_v_out_323201.awb")

						arg_265_1:RecordAudio("323201063", var_268_24)
						arg_265_1:RecordAudio("323201063", var_268_24)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_323201", "323201063", "story_v_out_323201.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_323201", "323201063", "story_v_out_323201.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_25 = var_268_14 + 0.3
			local var_268_26 = math.max(var_268_15, arg_265_1.talkMaxDuration)

			if var_268_25 <= arg_265_1.time_ and arg_265_1.time_ < var_268_25 + var_268_26 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_25) / var_268_26

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_25 + var_268_26 and arg_265_1.time_ < var_268_25 + var_268_26 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play323201064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 323201064
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play323201065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1070ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1070ui_story == nil then
				arg_271_1.var_.characterEffect1070ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1070ui_story and not isNil(var_274_0) then
					local var_274_4 = Mathf.Lerp(0, 0.5, var_274_3)

					arg_271_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1070ui_story.fillRatio = var_274_4
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1070ui_story then
				local var_274_5 = 0.5

				arg_271_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1070ui_story.fillRatio = var_274_5
			end

			local var_274_6 = 0
			local var_274_7 = 1.025

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:GetWordFromCfg(323201064)
				local var_274_9 = arg_271_1:FormatText(var_274_8.content)

				arg_271_1.text_.text = var_274_9

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 41
				local var_274_11 = utf8.len(var_274_9)
				local var_274_12 = var_274_10 <= 0 and var_274_7 or var_274_7 * (var_274_11 / var_274_10)

				if var_274_12 > 0 and var_274_7 < var_274_12 then
					arg_271_1.talkMaxDuration = var_274_12

					if var_274_12 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_9
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_13 and arg_271_1.time_ < var_274_6 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play323201065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 323201065
		arg_275_1.duration_ = 6.9

		local var_275_0 = {
			zh = 5.8,
			ja = 6.9
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play323201066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1070ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1070ui_story == nil then
				arg_275_1.var_.characterEffect1070ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect1070ui_story and not isNil(var_278_0) then
					arg_275_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1070ui_story then
				arg_275_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_278_4 = 0
			local var_278_5 = 0.525

			if var_278_4 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_6 = arg_275_1:FormatText(StoryNameCfg[318].name)

				arg_275_1.leftNameTxt_.text = var_278_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_7 = arg_275_1:GetWordFromCfg(323201065)
				local var_278_8 = arg_275_1:FormatText(var_278_7.content)

				arg_275_1.text_.text = var_278_8

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 21
				local var_278_10 = utf8.len(var_278_8)
				local var_278_11 = var_278_9 <= 0 and var_278_5 or var_278_5 * (var_278_10 / var_278_9)

				if var_278_11 > 0 and var_278_5 < var_278_11 then
					arg_275_1.talkMaxDuration = var_278_11

					if var_278_11 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_8
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201065", "story_v_out_323201.awb") ~= 0 then
					local var_278_12 = manager.audio:GetVoiceLength("story_v_out_323201", "323201065", "story_v_out_323201.awb") / 1000

					if var_278_12 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_4
					end

					if var_278_7.prefab_name ~= "" and arg_275_1.actors_[var_278_7.prefab_name] ~= nil then
						local var_278_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_7.prefab_name].transform, "story_v_out_323201", "323201065", "story_v_out_323201.awb")

						arg_275_1:RecordAudio("323201065", var_278_13)
						arg_275_1:RecordAudio("323201065", var_278_13)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_323201", "323201065", "story_v_out_323201.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_323201", "323201065", "story_v_out_323201.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_14 and arg_275_1.time_ < var_278_4 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play323201066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 323201066
		arg_279_1.duration_ = 17.7

		local var_279_0 = {
			zh = 8.333,
			ja = 17.7
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play323201067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_282_2 = 0
			local var_282_3 = 0.95

			if var_282_2 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_4 = arg_279_1:FormatText(StoryNameCfg[318].name)

				arg_279_1.leftNameTxt_.text = var_282_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_5 = arg_279_1:GetWordFromCfg(323201066)
				local var_282_6 = arg_279_1:FormatText(var_282_5.content)

				arg_279_1.text_.text = var_282_6

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 38
				local var_282_8 = utf8.len(var_282_6)
				local var_282_9 = var_282_7 <= 0 and var_282_3 or var_282_3 * (var_282_8 / var_282_7)

				if var_282_9 > 0 and var_282_3 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_6
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201066", "story_v_out_323201.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_323201", "323201066", "story_v_out_323201.awb") / 1000

					if var_282_10 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_2
					end

					if var_282_5.prefab_name ~= "" and arg_279_1.actors_[var_282_5.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_5.prefab_name].transform, "story_v_out_323201", "323201066", "story_v_out_323201.awb")

						arg_279_1:RecordAudio("323201066", var_282_11)
						arg_279_1:RecordAudio("323201066", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_323201", "323201066", "story_v_out_323201.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_323201", "323201066", "story_v_out_323201.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_12 and arg_279_1.time_ < var_282_2 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play323201067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 323201067
		arg_283_1.duration_ = 1.83

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play323201068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10039ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect10039ui_story == nil then
				arg_283_1.var_.characterEffect10039ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect10039ui_story and not isNil(var_286_0) then
					arg_283_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect10039ui_story then
				arg_283_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_286_4 = arg_283_1.actors_["1070ui_story"]
			local var_286_5 = 0

			if var_286_5 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect1070ui_story == nil then
				arg_283_1.var_.characterEffect1070ui_story = var_286_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_6 = 0.200000002980232

			if var_286_5 <= arg_283_1.time_ and arg_283_1.time_ < var_286_5 + var_286_6 and not isNil(var_286_4) then
				local var_286_7 = (arg_283_1.time_ - var_286_5) / var_286_6

				if arg_283_1.var_.characterEffect1070ui_story and not isNil(var_286_4) then
					local var_286_8 = Mathf.Lerp(0, 0.5, var_286_7)

					arg_283_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1070ui_story.fillRatio = var_286_8
				end
			end

			if arg_283_1.time_ >= var_286_5 + var_286_6 and arg_283_1.time_ < var_286_5 + var_286_6 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect1070ui_story then
				local var_286_9 = 0.5

				arg_283_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1070ui_story.fillRatio = var_286_9
			end

			local var_286_10 = 0
			local var_286_11 = 0.05

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_12 = arg_283_1:FormatText(StoryNameCfg[472].name)

				arg_283_1.leftNameTxt_.text = var_286_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_13 = arg_283_1:GetWordFromCfg(323201067)
				local var_286_14 = arg_283_1:FormatText(var_286_13.content)

				arg_283_1.text_.text = var_286_14

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_15 = 2
				local var_286_16 = utf8.len(var_286_14)
				local var_286_17 = var_286_15 <= 0 and var_286_11 or var_286_11 * (var_286_16 / var_286_15)

				if var_286_17 > 0 and var_286_11 < var_286_17 then
					arg_283_1.talkMaxDuration = var_286_17

					if var_286_17 + var_286_10 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_17 + var_286_10
					end
				end

				arg_283_1.text_.text = var_286_14
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201067", "story_v_out_323201.awb") ~= 0 then
					local var_286_18 = manager.audio:GetVoiceLength("story_v_out_323201", "323201067", "story_v_out_323201.awb") / 1000

					if var_286_18 + var_286_10 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_18 + var_286_10
					end

					if var_286_13.prefab_name ~= "" and arg_283_1.actors_[var_286_13.prefab_name] ~= nil then
						local var_286_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_13.prefab_name].transform, "story_v_out_323201", "323201067", "story_v_out_323201.awb")

						arg_283_1:RecordAudio("323201067", var_286_19)
						arg_283_1:RecordAudio("323201067", var_286_19)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_323201", "323201067", "story_v_out_323201.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_323201", "323201067", "story_v_out_323201.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_20 = math.max(var_286_11, arg_283_1.talkMaxDuration)

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_20 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_10) / var_286_20

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_10 + var_286_20 and arg_283_1.time_ < var_286_10 + var_286_20 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play323201068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 323201068
		arg_287_1.duration_ = 6.2

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play323201069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1070ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1070ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(0, 100, 0)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1070ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(0, 100, 0)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["10039ui_story"].transform
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 then
				arg_287_1.var_.moveOldPos10039ui_story = var_290_9.localPosition
			end

			local var_290_11 = 0.001

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11
				local var_290_13 = Vector3.New(0, 100, 0)

				var_290_9.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10039ui_story, var_290_13, var_290_12)

				local var_290_14 = manager.ui.mainCamera.transform.position - var_290_9.position

				var_290_9.forward = Vector3.New(var_290_14.x, var_290_14.y, var_290_14.z)

				local var_290_15 = var_290_9.localEulerAngles

				var_290_15.z = 0
				var_290_15.x = 0
				var_290_9.localEulerAngles = var_290_15
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 then
				var_290_9.localPosition = Vector3.New(0, 100, 0)

				local var_290_16 = manager.ui.mainCamera.transform.position - var_290_9.position

				var_290_9.forward = Vector3.New(var_290_16.x, var_290_16.y, var_290_16.z)

				local var_290_17 = var_290_9.localEulerAngles

				var_290_17.z = 0
				var_290_17.x = 0
				var_290_9.localEulerAngles = var_290_17
			end

			local var_290_18 = arg_287_1.actors_["10039ui_story"]
			local var_290_19 = 0

			if var_290_19 < arg_287_1.time_ and arg_287_1.time_ <= var_290_19 + arg_290_0 and not isNil(var_290_18) and arg_287_1.var_.characterEffect10039ui_story == nil then
				arg_287_1.var_.characterEffect10039ui_story = var_290_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_20 = 0.200000002980232

			if var_290_19 <= arg_287_1.time_ and arg_287_1.time_ < var_290_19 + var_290_20 and not isNil(var_290_18) then
				local var_290_21 = (arg_287_1.time_ - var_290_19) / var_290_20

				if arg_287_1.var_.characterEffect10039ui_story and not isNil(var_290_18) then
					local var_290_22 = Mathf.Lerp(0, 0.5, var_290_21)

					arg_287_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10039ui_story.fillRatio = var_290_22
				end
			end

			if arg_287_1.time_ >= var_290_19 + var_290_20 and arg_287_1.time_ < var_290_19 + var_290_20 + arg_290_0 and not isNil(var_290_18) and arg_287_1.var_.characterEffect10039ui_story then
				local var_290_23 = 0.5

				arg_287_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10039ui_story.fillRatio = var_290_23
			end

			local var_290_24
			local var_290_25 = 0

			if var_290_25 < arg_287_1.time_ and arg_287_1.time_ <= var_290_25 + arg_290_0 then
				local var_290_26 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_290_26 then
					var_290_26.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_290_26.radialBlurScale = 0
					var_290_26.radialBlurGradient = 1
					var_290_26.radialBlurIntensity = 1

					if var_290_24 then
						var_290_26.radialBlurTarget = var_290_24.transform
					end
				end
			end

			local var_290_27 = 0.200000002980232

			if var_290_25 <= arg_287_1.time_ and arg_287_1.time_ < var_290_25 + var_290_27 then
				local var_290_28 = (arg_287_1.time_ - var_290_25) / var_290_27
				local var_290_29 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_290_29 then
					var_290_29.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_290_29.radialBlurScale = Mathf.Lerp(0, 0, var_290_28)
					var_290_29.radialBlurGradient = Mathf.Lerp(1, 1, var_290_28)
					var_290_29.radialBlurIntensity = Mathf.Lerp(1, 1, var_290_28)
				end
			end

			if arg_287_1.time_ >= var_290_25 + var_290_27 and arg_287_1.time_ < var_290_25 + var_290_27 + arg_290_0 then
				local var_290_30 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_290_30 then
					var_290_30.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_290_30.radialBlurScale = 0
					var_290_30.radialBlurGradient = 1
					var_290_30.radialBlurIntensity = 1
				end
			end

			local var_290_31 = 0

			if var_290_31 < arg_287_1.time_ and arg_287_1.time_ <= var_290_31 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_32 = 0.6

			if var_290_31 <= arg_287_1.time_ and arg_287_1.time_ < var_290_31 + var_290_32 then
				local var_290_33 = (arg_287_1.time_ - var_290_31) / var_290_32
				local var_290_34 = Color.New(1, 1, 1)

				var_290_34.a = Mathf.Lerp(1, 0, var_290_33)
				arg_287_1.mask_.color = var_290_34
			end

			if arg_287_1.time_ >= var_290_31 + var_290_32 and arg_287_1.time_ < var_290_31 + var_290_32 + arg_290_0 then
				local var_290_35 = Color.New(1, 1, 1)
				local var_290_36 = 0

				arg_287_1.mask_.enabled = false
				var_290_35.a = var_290_36
				arg_287_1.mask_.color = var_290_35
			end

			local var_290_37 = manager.ui.mainCamera.transform
			local var_290_38 = 0.366666666666667

			if var_290_38 < arg_287_1.time_ and arg_287_1.time_ <= var_290_38 + arg_290_0 then
				local var_290_39 = arg_287_1.var_.effect444
				local var_290_40
				local var_290_41 = var_290_37

				if not var_290_39 then
					var_290_39 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), var_290_41)
					var_290_39.name = "444"
					arg_287_1.var_.effect444 = var_290_39
				else
					var_290_39.transform:SetParent(var_290_41)
				end

				var_290_39.transform.localPosition = Vector3.New(0, 0, 0)
				var_290_39.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_290_42 = 1.7777777777777777
				local var_290_43 = Screen.width / Screen.height
				local var_290_44 = var_290_43 / var_290_42
				local var_290_45 = Mathf.Max(var_290_42 / var_290_43, 1)
				local var_290_46 = Mathf.Max(var_290_44, var_290_45)

				var_290_39.transform.localScale = Vector3.New(var_290_39.transform.localScale.x * var_290_46, var_290_39.transform.localScale.y * var_290_46, var_290_39.transform.localScale.z * var_290_46)
			end

			local var_290_47 = manager.ui.mainCamera.transform
			local var_290_48 = 1.33259377113233

			if var_290_48 < arg_287_1.time_ and arg_287_1.time_ <= var_290_48 + arg_290_0 then
				local var_290_49 = arg_287_1.var_.effect444

				if var_290_49 then
					Object.Destroy(var_290_49)

					arg_287_1.var_.effect444 = nil
				end
			end

			local var_290_50 = 0

			if var_290_50 < arg_287_1.time_ and arg_287_1.time_ <= var_290_50 + arg_290_0 then
				arg_287_1.allBtn_.enabled = false
			end

			local var_290_51 = 1.7

			if arg_287_1.time_ >= var_290_50 + var_290_51 and arg_287_1.time_ < var_290_50 + var_290_51 + arg_290_0 then
				arg_287_1.allBtn_.enabled = true
			end

			local var_290_52 = 0
			local var_290_53 = 0.3

			if var_290_52 < arg_287_1.time_ and arg_287_1.time_ <= var_290_52 + arg_290_0 then
				local var_290_54 = "play"
				local var_290_55 = "music"

				arg_287_1:AudioAction(var_290_54, var_290_55, "ui_battle", "ui_battle_stopbgm", "")

				local var_290_56 = ""
				local var_290_57 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_290_57 ~= "" then
					if arg_287_1.bgmTxt_.text ~= var_290_57 and arg_287_1.bgmTxt_.text ~= "" then
						if arg_287_1.bgmTxt2_.text ~= "" then
							arg_287_1.bgmTxt_.text = arg_287_1.bgmTxt2_.text
						end

						arg_287_1.bgmTxt2_.text = var_290_57

						arg_287_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_287_1.bgmTxt_.text = var_290_57
						arg_287_1.bgmTxt2_.text = var_290_57
					end

					if arg_287_1.bgmTimer then
						arg_287_1.bgmTimer:Stop()

						arg_287_1.bgmTimer = nil
					end

					if arg_287_1.settingData.show_music_name == 1 then
						arg_287_1.musicController:SetSelectedState("show")
						arg_287_1.musicAnimator_:Play("open", 0, 0)

						if arg_287_1.settingData.music_time ~= 0 then
							arg_287_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_287_1.settingData.music_time), function()
								if arg_287_1 == nil or isNil(arg_287_1.bgmTxt_) then
									return
								end

								arg_287_1.musicController:SetSelectedState("hide")
								arg_287_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_290_58 = 0.3
			local var_290_59 = 1

			if var_290_58 < arg_287_1.time_ and arg_287_1.time_ <= var_290_58 + arg_290_0 then
				local var_290_60 = "play"
				local var_290_61 = "music"

				arg_287_1:AudioAction(var_290_60, var_290_61, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_290_62 = ""
				local var_290_63 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_290_63 ~= "" then
					if arg_287_1.bgmTxt_.text ~= var_290_63 and arg_287_1.bgmTxt_.text ~= "" then
						if arg_287_1.bgmTxt2_.text ~= "" then
							arg_287_1.bgmTxt_.text = arg_287_1.bgmTxt2_.text
						end

						arg_287_1.bgmTxt2_.text = var_290_63

						arg_287_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_287_1.bgmTxt_.text = var_290_63
						arg_287_1.bgmTxt2_.text = var_290_63
					end

					if arg_287_1.bgmTimer then
						arg_287_1.bgmTimer:Stop()

						arg_287_1.bgmTimer = nil
					end

					if arg_287_1.settingData.show_music_name == 1 then
						arg_287_1.musicController:SetSelectedState("show")
						arg_287_1.musicAnimator_:Play("open", 0, 0)

						if arg_287_1.settingData.music_time ~= 0 then
							arg_287_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_287_1.settingData.music_time), function()
								if arg_287_1 == nil or isNil(arg_287_1.bgmTxt_) then
									return
								end

								arg_287_1.musicController:SetSelectedState("hide")
								arg_287_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_290_64 = 0.33259377113233
			local var_290_65 = 1

			if var_290_64 < arg_287_1.time_ and arg_287_1.time_ <= var_290_64 + arg_290_0 then
				local var_290_66 = "play"
				local var_290_67 = "effect"

				arg_287_1:AudioAction(var_290_66, var_290_67, "se_story_3", "se_story_3_windspear", "")
			end

			local var_290_68 = 0
			local var_290_69 = 1

			if var_290_68 < arg_287_1.time_ and arg_287_1.time_ <= var_290_68 + arg_290_0 then
				local var_290_70 = "stop"
				local var_290_71 = "effect"

				arg_287_1:AudioAction(var_290_70, var_290_71, "se_story_148", "se_story_148_amb_drone02", "")
			end

			local var_290_72 = 0.366666666666667
			local var_290_73 = 1

			if var_290_72 < arg_287_1.time_ and arg_287_1.time_ <= var_290_72 + arg_290_0 then
				local var_290_74 = "play"
				local var_290_75 = "effect"

				arg_287_1:AudioAction(var_290_74, var_290_75, "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_76 = 1.2
			local var_290_77 = 1

			if var_290_76 < arg_287_1.time_ and arg_287_1.time_ <= var_290_76 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_78 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_78:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_287_1.dialogCg_.alpha = arg_293_0
				end))
				var_290_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_79 = arg_287_1:GetWordFromCfg(323201068)
				local var_290_80 = arg_287_1:FormatText(var_290_79.content)

				arg_287_1.text_.text = var_290_80

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_81 = 40
				local var_290_82 = utf8.len(var_290_80)
				local var_290_83 = var_290_81 <= 0 and var_290_77 or var_290_77 * (var_290_82 / var_290_81)

				if var_290_83 > 0 and var_290_77 < var_290_83 then
					arg_287_1.talkMaxDuration = var_290_83
					var_290_76 = var_290_76 + 0.3

					if var_290_83 + var_290_76 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_83 + var_290_76
					end
				end

				arg_287_1.text_.text = var_290_80
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_84 = var_290_76 + 0.3
			local var_290_85 = math.max(var_290_77, arg_287_1.talkMaxDuration)

			if var_290_84 <= arg_287_1.time_ and arg_287_1.time_ < var_290_84 + var_290_85 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_84) / var_290_85

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_84 + var_290_85 and arg_287_1.time_ < var_290_84 + var_290_85 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play323201069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 323201069
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play323201070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 1

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				local var_298_2 = "play"
				local var_298_3 = "effect"

				arg_295_1:AudioAction(var_298_2, var_298_3, "se_story_148", "se_story_148_smoke", "")
			end

			local var_298_4 = 0
			local var_298_5 = 1.575

			if var_298_4 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(323201069)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_8 = 63
				local var_298_9 = utf8.len(var_298_7)
				local var_298_10 = var_298_8 <= 0 and var_298_5 or var_298_5 * (var_298_9 / var_298_8)

				if var_298_10 > 0 and var_298_5 < var_298_10 then
					arg_295_1.talkMaxDuration = var_298_10

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_11 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_11 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_11

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_11 and arg_295_1.time_ < var_298_4 + var_298_11 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play323201070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 323201070
		arg_299_1.duration_ = 7.8

		local var_299_0 = {
			zh = 5.4,
			ja = 7.8
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play323201071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1070ui_story"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos1070ui_story = var_302_0.localPosition
			end

			local var_302_2 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2
				local var_302_4 = Vector3.New(0, -0.95, -6.05)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1070ui_story, var_302_4, var_302_3)

				local var_302_5 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_5.x, var_302_5.y, var_302_5.z)

				local var_302_6 = var_302_0.localEulerAngles

				var_302_6.z = 0
				var_302_6.x = 0
				var_302_0.localEulerAngles = var_302_6
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_302_7 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_7.x, var_302_7.y, var_302_7.z)

				local var_302_8 = var_302_0.localEulerAngles

				var_302_8.z = 0
				var_302_8.x = 0
				var_302_0.localEulerAngles = var_302_8
			end

			local var_302_9 = arg_299_1.actors_["1070ui_story"]
			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1070ui_story == nil then
				arg_299_1.var_.characterEffect1070ui_story = var_302_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_11 = 0.200000002980232

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_11 and not isNil(var_302_9) then
				local var_302_12 = (arg_299_1.time_ - var_302_10) / var_302_11

				if arg_299_1.var_.characterEffect1070ui_story and not isNil(var_302_9) then
					arg_299_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_10 + var_302_11 and arg_299_1.time_ < var_302_10 + var_302_11 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1070ui_story then
				arg_299_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_302_13 = 0

			if var_302_13 < arg_299_1.time_ and arg_299_1.time_ <= var_302_13 + arg_302_0 then
				arg_299_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			local var_302_14 = 0

			if var_302_14 < arg_299_1.time_ and arg_299_1.time_ <= var_302_14 + arg_302_0 then
				arg_299_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_302_15 = 0.200000002980232
			local var_302_16 = 1

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				local var_302_17 = "play"
				local var_302_18 = "effect"

				arg_299_1:AudioAction(var_302_17, var_302_18, "se_story_148", "se_story_148_earthquake02", "")
			end

			local var_302_19 = 0
			local var_302_20 = 0.7

			if var_302_19 < arg_299_1.time_ and arg_299_1.time_ <= var_302_19 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_21 = arg_299_1:FormatText(StoryNameCfg[318].name)

				arg_299_1.leftNameTxt_.text = var_302_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_22 = arg_299_1:GetWordFromCfg(323201070)
				local var_302_23 = arg_299_1:FormatText(var_302_22.content)

				arg_299_1.text_.text = var_302_23

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_24 = 28
				local var_302_25 = utf8.len(var_302_23)
				local var_302_26 = var_302_24 <= 0 and var_302_20 or var_302_20 * (var_302_25 / var_302_24)

				if var_302_26 > 0 and var_302_20 < var_302_26 then
					arg_299_1.talkMaxDuration = var_302_26

					if var_302_26 + var_302_19 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_26 + var_302_19
					end
				end

				arg_299_1.text_.text = var_302_23
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201070", "story_v_out_323201.awb") ~= 0 then
					local var_302_27 = manager.audio:GetVoiceLength("story_v_out_323201", "323201070", "story_v_out_323201.awb") / 1000

					if var_302_27 + var_302_19 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_27 + var_302_19
					end

					if var_302_22.prefab_name ~= "" and arg_299_1.actors_[var_302_22.prefab_name] ~= nil then
						local var_302_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_22.prefab_name].transform, "story_v_out_323201", "323201070", "story_v_out_323201.awb")

						arg_299_1:RecordAudio("323201070", var_302_28)
						arg_299_1:RecordAudio("323201070", var_302_28)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_323201", "323201070", "story_v_out_323201.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_323201", "323201070", "story_v_out_323201.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_29 = math.max(var_302_20, arg_299_1.talkMaxDuration)

			if var_302_19 <= arg_299_1.time_ and arg_299_1.time_ < var_302_19 + var_302_29 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_19) / var_302_29

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_19 + var_302_29 and arg_299_1.time_ < var_302_19 + var_302_29 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play323201071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 323201071
		arg_303_1.duration_ = 6

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play323201072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1070ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1070ui_story == nil then
				arg_303_1.var_.characterEffect1070ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1070ui_story and not isNil(var_306_0) then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1070ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1070ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1070ui_story.fillRatio = var_306_5
			end

			local var_306_6 = arg_303_1.actors_["1070ui_story"].transform
			local var_306_7 = 0

			if var_306_7 < arg_303_1.time_ and arg_303_1.time_ <= var_306_7 + arg_306_0 then
				arg_303_1.var_.moveOldPos1070ui_story = var_306_6.localPosition
			end

			local var_306_8 = 0.001

			if var_306_7 <= arg_303_1.time_ and arg_303_1.time_ < var_306_7 + var_306_8 then
				local var_306_9 = (arg_303_1.time_ - var_306_7) / var_306_8
				local var_306_10 = Vector3.New(0, 100, 0)

				var_306_6.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1070ui_story, var_306_10, var_306_9)

				local var_306_11 = manager.ui.mainCamera.transform.position - var_306_6.position

				var_306_6.forward = Vector3.New(var_306_11.x, var_306_11.y, var_306_11.z)

				local var_306_12 = var_306_6.localEulerAngles

				var_306_12.z = 0
				var_306_12.x = 0
				var_306_6.localEulerAngles = var_306_12
			end

			if arg_303_1.time_ >= var_306_7 + var_306_8 and arg_303_1.time_ < var_306_7 + var_306_8 + arg_306_0 then
				var_306_6.localPosition = Vector3.New(0, 100, 0)

				local var_306_13 = manager.ui.mainCamera.transform.position - var_306_6.position

				var_306_6.forward = Vector3.New(var_306_13.x, var_306_13.y, var_306_13.z)

				local var_306_14 = var_306_6.localEulerAngles

				var_306_14.z = 0
				var_306_14.x = 0
				var_306_6.localEulerAngles = var_306_14
			end

			local var_306_15 = manager.ui.mainCamera.transform
			local var_306_16 = 0

			if var_306_16 < arg_303_1.time_ and arg_303_1.time_ <= var_306_16 + arg_306_0 then
				local var_306_17 = arg_303_1.var_.effect2344233
				local var_306_18
				local var_306_19 = var_306_15

				if not var_306_17 then
					var_306_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_306_19)
					var_306_17.name = "233"
					arg_303_1.var_.effect2344233 = var_306_17
				else
					var_306_17.transform:SetParent(var_306_19)
				end

				var_306_17.transform.localPosition = Vector3.New(0, -0.34, 0)
				var_306_17.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_306_20 = 1.7777777777777777
				local var_306_21 = Screen.width / Screen.height
				local var_306_22 = var_306_21 / var_306_20
				local var_306_23 = Mathf.Max(var_306_20 / var_306_21, 1)
				local var_306_24 = Mathf.Max(var_306_22, var_306_23)

				var_306_17.transform.localScale = Vector3.New(var_306_17.transform.localScale.x * var_306_24, var_306_17.transform.localScale.y * var_306_24, var_306_17.transform.localScale.z * var_306_24)
			end

			local var_306_25 = 0

			if var_306_25 < arg_303_1.time_ and arg_303_1.time_ <= var_306_25 + arg_306_0 then
				arg_303_1.allBtn_.enabled = false
			end

			local var_306_26 = 1.4

			if arg_303_1.time_ >= var_306_25 + var_306_26 and arg_303_1.time_ < var_306_25 + var_306_26 + arg_306_0 then
				arg_303_1.allBtn_.enabled = true
			end

			local var_306_27 = manager.ui.mainCamera.transform
			local var_306_28 = 0.200000002980232

			if var_306_28 < arg_303_1.time_ and arg_303_1.time_ <= var_306_28 + arg_306_0 then
				local var_306_29 = arg_303_1.var_.effect34
				local var_306_30
				local var_306_31 = var_306_27

				if not var_306_29 then
					var_306_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_in"), var_306_31)
					var_306_29.name = "34"
					arg_303_1.var_.effect34 = var_306_29
				else
					var_306_29.transform:SetParent(var_306_31)
				end

				var_306_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_306_29.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_306_32 = 1.7777777777777777
				local var_306_33 = Screen.width / Screen.height
				local var_306_34 = var_306_33 / var_306_32
				local var_306_35 = Mathf.Max(var_306_32 / var_306_33, 1)

				var_306_29.transform.localScale = Vector3.New(var_306_29.transform.localScale.x * var_306_34, var_306_29.transform.localScale.y * var_306_35, var_306_29.transform.localScale.z)
			end

			local var_306_36 = 0.200000002980232
			local var_306_37 = 1

			if var_306_36 < arg_303_1.time_ and arg_303_1.time_ <= var_306_36 + arg_306_0 then
				local var_306_38 = "play"
				local var_306_39 = "effect"

				arg_303_1:AudioAction(var_306_38, var_306_39, "se_story_148", "se_story_148_earthquake03", "")
			end

			if arg_303_1.frameCnt_ <= 1 then
				arg_303_1.dialog_:SetActive(false)
			end

			local var_306_40 = 1
			local var_306_41 = 1.425

			if var_306_40 < arg_303_1.time_ and arg_303_1.time_ <= var_306_40 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0

				arg_303_1.dialog_:SetActive(true)

				arg_303_1.dialogCg_.alpha = 0

				local var_306_42 = LeanTween.value(arg_303_1.dialog_, 0, 1, 0.3)

				var_306_42:setOnUpdate(LuaHelper.FloatAction(function(arg_307_0)
					arg_303_1.dialogCg_.alpha = arg_307_0
				end))
				var_306_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_303_1.dialog_)
					var_306_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_303_1.duration_ = arg_303_1.duration_ + 0.3

				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_43 = arg_303_1:GetWordFromCfg(323201071)
				local var_306_44 = arg_303_1:FormatText(var_306_43.content)

				arg_303_1.text_.text = var_306_44

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_45 = 57
				local var_306_46 = utf8.len(var_306_44)
				local var_306_47 = var_306_45 <= 0 and var_306_41 or var_306_41 * (var_306_46 / var_306_45)

				if var_306_47 > 0 and var_306_41 < var_306_47 then
					arg_303_1.talkMaxDuration = var_306_47
					var_306_40 = var_306_40 + 0.3

					if var_306_47 + var_306_40 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_47 + var_306_40
					end
				end

				arg_303_1.text_.text = var_306_44
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_48 = var_306_40 + 0.3
			local var_306_49 = math.max(var_306_41, arg_303_1.talkMaxDuration)

			if var_306_48 <= arg_303_1.time_ and arg_303_1.time_ < var_306_48 + var_306_49 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_48) / var_306_49

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_48 + var_306_49 and arg_303_1.time_ < var_306_48 + var_306_49 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 1,
				startTime = 0.200000002980232,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play323201072 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 323201072
		arg_309_1.duration_ = 10.23

		local var_309_0 = {
			zh = 5.833,
			ja = 10.233
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
				arg_309_0:Play323201073(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1070ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1070ui_story == nil then
				arg_309_1.var_.characterEffect1070ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect1070ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect1070ui_story then
				arg_309_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_312_4 = 0

			if var_312_4 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_312_5 = 0

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_312_6 = 0
			local var_312_7 = 0.7

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_8 = arg_309_1:FormatText(StoryNameCfg[318].name)

				arg_309_1.leftNameTxt_.text = var_312_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_6")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_9 = arg_309_1:GetWordFromCfg(323201072)
				local var_312_10 = arg_309_1:FormatText(var_312_9.content)

				arg_309_1.text_.text = var_312_10

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_11 = 28
				local var_312_12 = utf8.len(var_312_10)
				local var_312_13 = var_312_11 <= 0 and var_312_7 or var_312_7 * (var_312_12 / var_312_11)

				if var_312_13 > 0 and var_312_7 < var_312_13 then
					arg_309_1.talkMaxDuration = var_312_13

					if var_312_13 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_13 + var_312_6
					end
				end

				arg_309_1.text_.text = var_312_10
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201072", "story_v_out_323201.awb") ~= 0 then
					local var_312_14 = manager.audio:GetVoiceLength("story_v_out_323201", "323201072", "story_v_out_323201.awb") / 1000

					if var_312_14 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_14 + var_312_6
					end

					if var_312_9.prefab_name ~= "" and arg_309_1.actors_[var_312_9.prefab_name] ~= nil then
						local var_312_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_9.prefab_name].transform, "story_v_out_323201", "323201072", "story_v_out_323201.awb")

						arg_309_1:RecordAudio("323201072", var_312_15)
						arg_309_1:RecordAudio("323201072", var_312_15)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_323201", "323201072", "story_v_out_323201.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_323201", "323201072", "story_v_out_323201.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_16 = math.max(var_312_7, arg_309_1.talkMaxDuration)

			if var_312_6 <= arg_309_1.time_ and arg_309_1.time_ < var_312_6 + var_312_16 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_6) / var_312_16

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_6 + var_312_16 and arg_309_1.time_ < var_312_6 + var_312_16 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play323201073 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 323201073
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play323201074(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1070ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1070ui_story == nil then
				arg_313_1.var_.characterEffect1070ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1070ui_story and not isNil(var_316_0) then
					local var_316_4 = Mathf.Lerp(0, 0.5, var_316_3)

					arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1070ui_story.fillRatio = var_316_4
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1070ui_story then
				local var_316_5 = 0.5

				arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1070ui_story.fillRatio = var_316_5
			end

			local var_316_6 = 0.3
			local var_316_7 = 1

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				local var_316_8 = "play"
				local var_316_9 = "effect"

				arg_313_1:AudioAction(var_316_8, var_316_9, "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_316_10 = 0
			local var_316_11 = 0.6

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_12 = arg_313_1:GetWordFromCfg(323201073)
				local var_316_13 = arg_313_1:FormatText(var_316_12.content)

				arg_313_1.text_.text = var_316_13

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_14 = 24
				local var_316_15 = utf8.len(var_316_13)
				local var_316_16 = var_316_14 <= 0 and var_316_11 or var_316_11 * (var_316_15 / var_316_14)

				if var_316_16 > 0 and var_316_11 < var_316_16 then
					arg_313_1.talkMaxDuration = var_316_16

					if var_316_16 + var_316_10 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_16 + var_316_10
					end
				end

				arg_313_1.text_.text = var_316_13
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_17 = math.max(var_316_11, arg_313_1.talkMaxDuration)

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_17 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_10) / var_316_17

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_10 + var_316_17 and arg_313_1.time_ < var_316_10 + var_316_17 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play323201074 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 323201074
		arg_317_1.duration_ = 13.43

		local var_317_0 = {
			zh = 8.066,
			ja = 13.433
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play323201075(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = "J16f"

			if arg_317_1.bgs_[var_320_0] == nil then
				local var_320_1 = Object.Instantiate(arg_317_1.paintGo_)

				var_320_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_320_0)
				var_320_1.name = var_320_0
				var_320_1.transform.parent = arg_317_1.stage_.transform
				var_320_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.bgs_[var_320_0] = var_320_1
			end

			local var_320_2 = 1.3

			if var_320_2 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				local var_320_3 = manager.ui.mainCamera.transform.localPosition
				local var_320_4 = Vector3.New(0, 0, 10) + Vector3.New(var_320_3.x, var_320_3.y, 0)
				local var_320_5 = arg_317_1.bgs_.J16f

				var_320_5.transform.localPosition = var_320_4
				var_320_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_320_6 = var_320_5:GetComponent("SpriteRenderer")

				if var_320_6 and var_320_6.sprite then
					local var_320_7 = (var_320_5.transform.localPosition - var_320_3).z
					local var_320_8 = manager.ui.mainCameraCom_
					local var_320_9 = 2 * var_320_7 * Mathf.Tan(var_320_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_320_10 = var_320_9 * var_320_8.aspect
					local var_320_11 = var_320_6.sprite.bounds.size.x
					local var_320_12 = var_320_6.sprite.bounds.size.y
					local var_320_13 = var_320_10 / var_320_11
					local var_320_14 = var_320_9 / var_320_12
					local var_320_15 = var_320_14 < var_320_13 and var_320_13 or var_320_14

					var_320_5.transform.localScale = Vector3.New(var_320_15, var_320_15, 0)
				end

				for iter_320_0, iter_320_1 in pairs(arg_317_1.bgs_) do
					if iter_320_0 ~= "J16f" then
						iter_320_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_320_16 = 0

			if var_320_16 < arg_317_1.time_ and arg_317_1.time_ <= var_320_16 + arg_320_0 then
				arg_317_1.allBtn_.enabled = false
			end

			local var_320_17 = 0.3

			if arg_317_1.time_ >= var_320_16 + var_320_17 and arg_317_1.time_ < var_320_16 + var_320_17 + arg_320_0 then
				arg_317_1.allBtn_.enabled = true
			end

			local var_320_18 = 0

			if var_320_18 < arg_317_1.time_ and arg_317_1.time_ <= var_320_18 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_19 = 1.3

			if var_320_18 <= arg_317_1.time_ and arg_317_1.time_ < var_320_18 + var_320_19 then
				local var_320_20 = (arg_317_1.time_ - var_320_18) / var_320_19
				local var_320_21 = Color.New(0, 0, 0)

				var_320_21.a = Mathf.Lerp(0, 1, var_320_20)
				arg_317_1.mask_.color = var_320_21
			end

			if arg_317_1.time_ >= var_320_18 + var_320_19 and arg_317_1.time_ < var_320_18 + var_320_19 + arg_320_0 then
				local var_320_22 = Color.New(0, 0, 0)

				var_320_22.a = 1
				arg_317_1.mask_.color = var_320_22
			end

			local var_320_23 = 1.3

			if var_320_23 < arg_317_1.time_ and arg_317_1.time_ <= var_320_23 + arg_320_0 then
				arg_317_1.mask_.enabled = true
				arg_317_1.mask_.raycastTarget = true

				arg_317_1:SetGaussion(false)
			end

			local var_320_24 = 1.3

			if var_320_23 <= arg_317_1.time_ and arg_317_1.time_ < var_320_23 + var_320_24 then
				local var_320_25 = (arg_317_1.time_ - var_320_23) / var_320_24
				local var_320_26 = Color.New(0, 0, 0)

				var_320_26.a = Mathf.Lerp(1, 0, var_320_25)
				arg_317_1.mask_.color = var_320_26
			end

			if arg_317_1.time_ >= var_320_23 + var_320_24 and arg_317_1.time_ < var_320_23 + var_320_24 + arg_320_0 then
				local var_320_27 = Color.New(0, 0, 0)
				local var_320_28 = 0

				arg_317_1.mask_.enabled = false
				var_320_27.a = var_320_28
				arg_317_1.mask_.color = var_320_27
			end

			local var_320_29 = arg_317_1.actors_["1070ui_story"].transform
			local var_320_30 = 0

			if var_320_30 < arg_317_1.time_ and arg_317_1.time_ <= var_320_30 + arg_320_0 then
				arg_317_1.var_.moveOldPos1070ui_story = var_320_29.localPosition
			end

			local var_320_31 = 0.001

			if var_320_30 <= arg_317_1.time_ and arg_317_1.time_ < var_320_30 + var_320_31 then
				local var_320_32 = (arg_317_1.time_ - var_320_30) / var_320_31
				local var_320_33 = Vector3.New(0, 100, 0)

				var_320_29.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1070ui_story, var_320_33, var_320_32)

				local var_320_34 = manager.ui.mainCamera.transform.position - var_320_29.position

				var_320_29.forward = Vector3.New(var_320_34.x, var_320_34.y, var_320_34.z)

				local var_320_35 = var_320_29.localEulerAngles

				var_320_35.z = 0
				var_320_35.x = 0
				var_320_29.localEulerAngles = var_320_35
			end

			if arg_317_1.time_ >= var_320_30 + var_320_31 and arg_317_1.time_ < var_320_30 + var_320_31 + arg_320_0 then
				var_320_29.localPosition = Vector3.New(0, 100, 0)

				local var_320_36 = manager.ui.mainCamera.transform.position - var_320_29.position

				var_320_29.forward = Vector3.New(var_320_36.x, var_320_36.y, var_320_36.z)

				local var_320_37 = var_320_29.localEulerAngles

				var_320_37.z = 0
				var_320_37.x = 0
				var_320_29.localEulerAngles = var_320_37
			end

			local var_320_38 = arg_317_1.actors_["1070ui_story"]
			local var_320_39 = 0

			if var_320_39 < arg_317_1.time_ and arg_317_1.time_ <= var_320_39 + arg_320_0 and not isNil(var_320_38) and arg_317_1.var_.characterEffect1070ui_story == nil then
				arg_317_1.var_.characterEffect1070ui_story = var_320_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_40 = 0.200000002980232

			if var_320_39 <= arg_317_1.time_ and arg_317_1.time_ < var_320_39 + var_320_40 and not isNil(var_320_38) then
				local var_320_41 = (arg_317_1.time_ - var_320_39) / var_320_40

				if arg_317_1.var_.characterEffect1070ui_story and not isNil(var_320_38) then
					arg_317_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_39 + var_320_40 and arg_317_1.time_ < var_320_39 + var_320_40 + arg_320_0 and not isNil(var_320_38) and arg_317_1.var_.characterEffect1070ui_story then
				arg_317_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_320_42 = manager.ui.mainCamera.transform
			local var_320_43 = 1.3

			if var_320_43 < arg_317_1.time_ and arg_317_1.time_ <= var_320_43 + arg_320_0 then
				local var_320_44 = arg_317_1.var_.effect34

				if var_320_44 then
					Object.Destroy(var_320_44)

					arg_317_1.var_.effect34 = nil
				end
			end

			local var_320_45 = 0.966666666666667
			local var_320_46 = 1

			if var_320_45 < arg_317_1.time_ and arg_317_1.time_ <= var_320_45 + arg_320_0 then
				local var_320_47 = "play"
				local var_320_48 = "effect"

				arg_317_1:AudioAction(var_320_47, var_320_48, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_317_1.frameCnt_ <= 1 then
				arg_317_1.dialog_:SetActive(false)
			end

			local var_320_49 = 2.7
			local var_320_50 = 0.825

			if var_320_49 < arg_317_1.time_ and arg_317_1.time_ <= var_320_49 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				arg_317_1.dialog_:SetActive(true)

				arg_317_1.dialogCg_.alpha = 0

				local var_320_51 = LeanTween.value(arg_317_1.dialog_, 0, 1, 0.3)

				var_320_51:setOnUpdate(LuaHelper.FloatAction(function(arg_321_0)
					arg_317_1.dialogCg_.alpha = arg_321_0
				end))
				var_320_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_317_1.dialog_)
					var_320_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_317_1.duration_ = arg_317_1.duration_ + 0.3

				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_52 = arg_317_1:FormatText(StoryNameCfg[318].name)

				arg_317_1.leftNameTxt_.text = var_320_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_53 = arg_317_1:GetWordFromCfg(323201074)
				local var_320_54 = arg_317_1:FormatText(var_320_53.content)

				arg_317_1.text_.text = var_320_54

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_55 = 33
				local var_320_56 = utf8.len(var_320_54)
				local var_320_57 = var_320_55 <= 0 and var_320_50 or var_320_50 * (var_320_56 / var_320_55)

				if var_320_57 > 0 and var_320_50 < var_320_57 then
					arg_317_1.talkMaxDuration = var_320_57
					var_320_49 = var_320_49 + 0.3

					if var_320_57 + var_320_49 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_57 + var_320_49
					end
				end

				arg_317_1.text_.text = var_320_54
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201074", "story_v_out_323201.awb") ~= 0 then
					local var_320_58 = manager.audio:GetVoiceLength("story_v_out_323201", "323201074", "story_v_out_323201.awb") / 1000

					if var_320_58 + var_320_49 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_58 + var_320_49
					end

					if var_320_53.prefab_name ~= "" and arg_317_1.actors_[var_320_53.prefab_name] ~= nil then
						local var_320_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_53.prefab_name].transform, "story_v_out_323201", "323201074", "story_v_out_323201.awb")

						arg_317_1:RecordAudio("323201074", var_320_59)
						arg_317_1:RecordAudio("323201074", var_320_59)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_323201", "323201074", "story_v_out_323201.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_323201", "323201074", "story_v_out_323201.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_60 = var_320_49 + 0.3
			local var_320_61 = math.max(var_320_50, arg_317_1.talkMaxDuration)

			if var_320_60 <= arg_317_1.time_ and arg_317_1.time_ < var_320_60 + var_320_61 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_60) / var_320_61

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_60 + var_320_61 and arg_317_1.time_ < var_320_60 + var_320_61 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play323201075 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 323201075
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play323201076(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1070ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1070ui_story == nil then
				arg_323_1.var_.characterEffect1070ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1070ui_story and not isNil(var_326_0) then
					local var_326_4 = Mathf.Lerp(0, 0.5, var_326_3)

					arg_323_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1070ui_story.fillRatio = var_326_4
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1070ui_story then
				local var_326_5 = 0.5

				arg_323_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1070ui_story.fillRatio = var_326_5
			end

			local var_326_6 = 0
			local var_326_7 = 1.1

			if var_326_6 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_8 = arg_323_1:GetWordFromCfg(323201075)
				local var_326_9 = arg_323_1:FormatText(var_326_8.content)

				arg_323_1.text_.text = var_326_9

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_10 = 44
				local var_326_11 = utf8.len(var_326_9)
				local var_326_12 = var_326_10 <= 0 and var_326_7 or var_326_7 * (var_326_11 / var_326_10)

				if var_326_12 > 0 and var_326_7 < var_326_12 then
					arg_323_1.talkMaxDuration = var_326_12

					if var_326_12 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_9
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_13 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_13 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_13

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_13 and arg_323_1.time_ < var_326_6 + var_326_13 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play323201076 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 323201076
		arg_327_1.duration_ = 7.5

		local var_327_0 = {
			zh = 4.233,
			ja = 7.5
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play323201077(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1070ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1070ui_story == nil then
				arg_327_1.var_.characterEffect1070ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect1070ui_story and not isNil(var_330_0) then
					arg_327_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1070ui_story then
				arg_327_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_330_4 = 0
			local var_330_5 = 0.625

			if var_330_4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_6 = arg_327_1:FormatText(StoryNameCfg[318].name)

				arg_327_1.leftNameTxt_.text = var_330_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_7 = arg_327_1:GetWordFromCfg(323201076)
				local var_330_8 = arg_327_1:FormatText(var_330_7.content)

				arg_327_1.text_.text = var_330_8

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 25
				local var_330_10 = utf8.len(var_330_8)
				local var_330_11 = var_330_9 <= 0 and var_330_5 or var_330_5 * (var_330_10 / var_330_9)

				if var_330_11 > 0 and var_330_5 < var_330_11 then
					arg_327_1.talkMaxDuration = var_330_11

					if var_330_11 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_11 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_8
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201076", "story_v_out_323201.awb") ~= 0 then
					local var_330_12 = manager.audio:GetVoiceLength("story_v_out_323201", "323201076", "story_v_out_323201.awb") / 1000

					if var_330_12 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_12 + var_330_4
					end

					if var_330_7.prefab_name ~= "" and arg_327_1.actors_[var_330_7.prefab_name] ~= nil then
						local var_330_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_7.prefab_name].transform, "story_v_out_323201", "323201076", "story_v_out_323201.awb")

						arg_327_1:RecordAudio("323201076", var_330_13)
						arg_327_1:RecordAudio("323201076", var_330_13)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_323201", "323201076", "story_v_out_323201.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_323201", "323201076", "story_v_out_323201.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_14 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_14 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_14

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_14 and arg_327_1.time_ < var_330_4 + var_330_14 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play323201077 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 323201077
		arg_331_1.duration_ = 2.47

		local var_331_0 = {
			zh = 1.5,
			ja = 2.466
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play323201078(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0
			local var_334_1 = 0.125

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_2 = arg_331_1:FormatText(StoryNameCfg[318].name)

				arg_331_1.leftNameTxt_.text = var_334_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_3 = arg_331_1:GetWordFromCfg(323201077)
				local var_334_4 = arg_331_1:FormatText(var_334_3.content)

				arg_331_1.text_.text = var_334_4

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 5
				local var_334_6 = utf8.len(var_334_4)
				local var_334_7 = var_334_5 <= 0 and var_334_1 or var_334_1 * (var_334_6 / var_334_5)

				if var_334_7 > 0 and var_334_1 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_4
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201077", "story_v_out_323201.awb") ~= 0 then
					local var_334_8 = manager.audio:GetVoiceLength("story_v_out_323201", "323201077", "story_v_out_323201.awb") / 1000

					if var_334_8 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_0
					end

					if var_334_3.prefab_name ~= "" and arg_331_1.actors_[var_334_3.prefab_name] ~= nil then
						local var_334_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_3.prefab_name].transform, "story_v_out_323201", "323201077", "story_v_out_323201.awb")

						arg_331_1:RecordAudio("323201077", var_334_9)
						arg_331_1:RecordAudio("323201077", var_334_9)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_323201", "323201077", "story_v_out_323201.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_323201", "323201077", "story_v_out_323201.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_10 and arg_331_1.time_ < var_334_0 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play323201078 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 323201078
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play323201079(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1070ui_story"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1070ui_story == nil then
				arg_335_1.var_.characterEffect1070ui_story = var_338_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.characterEffect1070ui_story and not isNil(var_338_0) then
					local var_338_4 = Mathf.Lerp(0, 0.5, var_338_3)

					arg_335_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1070ui_story.fillRatio = var_338_4
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.characterEffect1070ui_story then
				local var_338_5 = 0.5

				arg_335_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1070ui_story.fillRatio = var_338_5
			end

			local var_338_6 = 0
			local var_338_7 = 0.875

			if var_338_6 < arg_335_1.time_ and arg_335_1.time_ <= var_338_6 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_8 = arg_335_1:GetWordFromCfg(323201078)
				local var_338_9 = arg_335_1:FormatText(var_338_8.content)

				arg_335_1.text_.text = var_338_9

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_10 = 35
				local var_338_11 = utf8.len(var_338_9)
				local var_338_12 = var_338_10 <= 0 and var_338_7 or var_338_7 * (var_338_11 / var_338_10)

				if var_338_12 > 0 and var_338_7 < var_338_12 then
					arg_335_1.talkMaxDuration = var_338_12

					if var_338_12 + var_338_6 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_12 + var_338_6
					end
				end

				arg_335_1.text_.text = var_338_9
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_13 = math.max(var_338_7, arg_335_1.talkMaxDuration)

			if var_338_6 <= arg_335_1.time_ and arg_335_1.time_ < var_338_6 + var_338_13 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_6) / var_338_13

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_6 + var_338_13 and arg_335_1.time_ < var_338_6 + var_338_13 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play323201079 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 323201079
		arg_339_1.duration_ = 9.2

		local var_339_0 = {
			zh = 5.466,
			ja = 9.2
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play323201080(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1070ui_story"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos1070ui_story = var_342_0.localPosition
			end

			local var_342_2 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2
				local var_342_4 = Vector3.New(0, -0.95, -6.05)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1070ui_story, var_342_4, var_342_3)

				local var_342_5 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_5.x, var_342_5.y, var_342_5.z)

				local var_342_6 = var_342_0.localEulerAngles

				var_342_6.z = 0
				var_342_6.x = 0
				var_342_0.localEulerAngles = var_342_6
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_342_7 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_7.x, var_342_7.y, var_342_7.z)

				local var_342_8 = var_342_0.localEulerAngles

				var_342_8.z = 0
				var_342_8.x = 0
				var_342_0.localEulerAngles = var_342_8
			end

			local var_342_9 = arg_339_1.actors_["1070ui_story"]
			local var_342_10 = 0

			if var_342_10 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1070ui_story == nil then
				arg_339_1.var_.characterEffect1070ui_story = var_342_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_11 = 0.200000002980232

			if var_342_10 <= arg_339_1.time_ and arg_339_1.time_ < var_342_10 + var_342_11 and not isNil(var_342_9) then
				local var_342_12 = (arg_339_1.time_ - var_342_10) / var_342_11

				if arg_339_1.var_.characterEffect1070ui_story and not isNil(var_342_9) then
					arg_339_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_10 + var_342_11 and arg_339_1.time_ < var_342_10 + var_342_11 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1070ui_story then
				arg_339_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_342_13 = 0

			if var_342_13 < arg_339_1.time_ and arg_339_1.time_ <= var_342_13 + arg_342_0 then
				arg_339_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_342_14 = 0

			if var_342_14 < arg_339_1.time_ and arg_339_1.time_ <= var_342_14 + arg_342_0 then
				arg_339_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_342_15 = 0
			local var_342_16 = 0.725

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_17 = arg_339_1:FormatText(StoryNameCfg[318].name)

				arg_339_1.leftNameTxt_.text = var_342_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_18 = arg_339_1:GetWordFromCfg(323201079)
				local var_342_19 = arg_339_1:FormatText(var_342_18.content)

				arg_339_1.text_.text = var_342_19

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_20 = 29
				local var_342_21 = utf8.len(var_342_19)
				local var_342_22 = var_342_20 <= 0 and var_342_16 or var_342_16 * (var_342_21 / var_342_20)

				if var_342_22 > 0 and var_342_16 < var_342_22 then
					arg_339_1.talkMaxDuration = var_342_22

					if var_342_22 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_22 + var_342_15
					end
				end

				arg_339_1.text_.text = var_342_19
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201079", "story_v_out_323201.awb") ~= 0 then
					local var_342_23 = manager.audio:GetVoiceLength("story_v_out_323201", "323201079", "story_v_out_323201.awb") / 1000

					if var_342_23 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_23 + var_342_15
					end

					if var_342_18.prefab_name ~= "" and arg_339_1.actors_[var_342_18.prefab_name] ~= nil then
						local var_342_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_18.prefab_name].transform, "story_v_out_323201", "323201079", "story_v_out_323201.awb")

						arg_339_1:RecordAudio("323201079", var_342_24)
						arg_339_1:RecordAudio("323201079", var_342_24)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_323201", "323201079", "story_v_out_323201.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_323201", "323201079", "story_v_out_323201.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_25 = math.max(var_342_16, arg_339_1.talkMaxDuration)

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_25 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_15) / var_342_25

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_15 + var_342_25 and arg_339_1.time_ < var_342_15 + var_342_25 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play323201080 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 323201080
		arg_343_1.duration_ = 9.07

		local var_343_0 = {
			zh = 4.666,
			ja = 9.066
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play323201081(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.6

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[318].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:GetWordFromCfg(323201080)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 24
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201080", "story_v_out_323201.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_out_323201", "323201080", "story_v_out_323201.awb") / 1000

					if var_346_8 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_0
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_323201", "323201080", "story_v_out_323201.awb")

						arg_343_1:RecordAudio("323201080", var_346_9)
						arg_343_1:RecordAudio("323201080", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_323201", "323201080", "story_v_out_323201.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_323201", "323201080", "story_v_out_323201.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_10 and arg_343_1.time_ < var_346_0 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play323201081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 323201081
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play323201082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1070ui_story"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos1070ui_story = var_350_0.localPosition
			end

			local var_350_2 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2
				local var_350_4 = Vector3.New(0, 100, 0)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1070ui_story, var_350_4, var_350_3)

				local var_350_5 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_5.x, var_350_5.y, var_350_5.z)

				local var_350_6 = var_350_0.localEulerAngles

				var_350_6.z = 0
				var_350_6.x = 0
				var_350_0.localEulerAngles = var_350_6
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(0, 100, 0)

				local var_350_7 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_7.x, var_350_7.y, var_350_7.z)

				local var_350_8 = var_350_0.localEulerAngles

				var_350_8.z = 0
				var_350_8.x = 0
				var_350_0.localEulerAngles = var_350_8
			end

			local var_350_9 = arg_347_1.actors_["1070ui_story"]
			local var_350_10 = 0

			if var_350_10 < arg_347_1.time_ and arg_347_1.time_ <= var_350_10 + arg_350_0 and not isNil(var_350_9) and arg_347_1.var_.characterEffect1070ui_story == nil then
				arg_347_1.var_.characterEffect1070ui_story = var_350_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_11 = 0.200000002980232

			if var_350_10 <= arg_347_1.time_ and arg_347_1.time_ < var_350_10 + var_350_11 and not isNil(var_350_9) then
				local var_350_12 = (arg_347_1.time_ - var_350_10) / var_350_11

				if arg_347_1.var_.characterEffect1070ui_story and not isNil(var_350_9) then
					local var_350_13 = Mathf.Lerp(0, 0.5, var_350_12)

					arg_347_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_347_1.var_.characterEffect1070ui_story.fillRatio = var_350_13
				end
			end

			if arg_347_1.time_ >= var_350_10 + var_350_11 and arg_347_1.time_ < var_350_10 + var_350_11 + arg_350_0 and not isNil(var_350_9) and arg_347_1.var_.characterEffect1070ui_story then
				local var_350_14 = 0.5

				arg_347_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_347_1.var_.characterEffect1070ui_story.fillRatio = var_350_14
			end

			local var_350_15 = 0
			local var_350_16 = 1.2

			if var_350_15 < arg_347_1.time_ and arg_347_1.time_ <= var_350_15 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_17 = arg_347_1:GetWordFromCfg(323201081)
				local var_350_18 = arg_347_1:FormatText(var_350_17.content)

				arg_347_1.text_.text = var_350_18

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_19 = 48
				local var_350_20 = utf8.len(var_350_18)
				local var_350_21 = var_350_19 <= 0 and var_350_16 or var_350_16 * (var_350_20 / var_350_19)

				if var_350_21 > 0 and var_350_16 < var_350_21 then
					arg_347_1.talkMaxDuration = var_350_21

					if var_350_21 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_21 + var_350_15
					end
				end

				arg_347_1.text_.text = var_350_18
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_22 = math.max(var_350_16, arg_347_1.talkMaxDuration)

			if var_350_15 <= arg_347_1.time_ and arg_347_1.time_ < var_350_15 + var_350_22 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_15) / var_350_22

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_15 + var_350_22 and arg_347_1.time_ < var_350_15 + var_350_22 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play323201082 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 323201082
		arg_351_1.duration_ = 9.73

		local var_351_0 = {
			zh = 5.333,
			ja = 9.733
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play323201083(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1070ui_story"].transform
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.var_.moveOldPos1070ui_story = var_354_0.localPosition
			end

			local var_354_2 = 0.001

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2
				local var_354_4 = Vector3.New(0, -0.95, -6.05)

				var_354_0.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1070ui_story, var_354_4, var_354_3)

				local var_354_5 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_5.x, var_354_5.y, var_354_5.z)

				local var_354_6 = var_354_0.localEulerAngles

				var_354_6.z = 0
				var_354_6.x = 0
				var_354_0.localEulerAngles = var_354_6
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 then
				var_354_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_354_7 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_7.x, var_354_7.y, var_354_7.z)

				local var_354_8 = var_354_0.localEulerAngles

				var_354_8.z = 0
				var_354_8.x = 0
				var_354_0.localEulerAngles = var_354_8
			end

			local var_354_9 = arg_351_1.actors_["1070ui_story"]
			local var_354_10 = 0

			if var_354_10 < arg_351_1.time_ and arg_351_1.time_ <= var_354_10 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect1070ui_story == nil then
				arg_351_1.var_.characterEffect1070ui_story = var_354_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_11 = 0.200000002980232

			if var_354_10 <= arg_351_1.time_ and arg_351_1.time_ < var_354_10 + var_354_11 and not isNil(var_354_9) then
				local var_354_12 = (arg_351_1.time_ - var_354_10) / var_354_11

				if arg_351_1.var_.characterEffect1070ui_story and not isNil(var_354_9) then
					arg_351_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_10 + var_354_11 and arg_351_1.time_ < var_354_10 + var_354_11 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect1070ui_story then
				arg_351_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_354_13 = 0.366666666666667

			if var_354_13 < arg_351_1.time_ and arg_351_1.time_ <= var_354_13 + arg_354_0 then
				arg_351_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action432")
			end

			local var_354_14 = 0

			if var_354_14 < arg_351_1.time_ and arg_351_1.time_ <= var_354_14 + arg_354_0 then
				arg_351_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_354_15 = 0

			if var_354_15 < arg_351_1.time_ and arg_351_1.time_ <= var_354_15 + arg_354_0 then
				arg_351_1.allBtn_.enabled = false
			end

			local var_354_16 = 1.7

			if arg_351_1.time_ >= var_354_15 + var_354_16 and arg_351_1.time_ < var_354_15 + var_354_16 + arg_354_0 then
				arg_351_1.allBtn_.enabled = true
			end

			local var_354_17 = 0
			local var_354_18 = 0.6

			if var_354_17 < arg_351_1.time_ and arg_351_1.time_ <= var_354_17 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_19 = arg_351_1:FormatText(StoryNameCfg[318].name)

				arg_351_1.leftNameTxt_.text = var_354_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_20 = arg_351_1:GetWordFromCfg(323201082)
				local var_354_21 = arg_351_1:FormatText(var_354_20.content)

				arg_351_1.text_.text = var_354_21

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_22 = 24
				local var_354_23 = utf8.len(var_354_21)
				local var_354_24 = var_354_22 <= 0 and var_354_18 or var_354_18 * (var_354_23 / var_354_22)

				if var_354_24 > 0 and var_354_18 < var_354_24 then
					arg_351_1.talkMaxDuration = var_354_24

					if var_354_24 + var_354_17 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_24 + var_354_17
					end
				end

				arg_351_1.text_.text = var_354_21
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201082", "story_v_out_323201.awb") ~= 0 then
					local var_354_25 = manager.audio:GetVoiceLength("story_v_out_323201", "323201082", "story_v_out_323201.awb") / 1000

					if var_354_25 + var_354_17 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_25 + var_354_17
					end

					if var_354_20.prefab_name ~= "" and arg_351_1.actors_[var_354_20.prefab_name] ~= nil then
						local var_354_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_20.prefab_name].transform, "story_v_out_323201", "323201082", "story_v_out_323201.awb")

						arg_351_1:RecordAudio("323201082", var_354_26)
						arg_351_1:RecordAudio("323201082", var_354_26)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_323201", "323201082", "story_v_out_323201.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_323201", "323201082", "story_v_out_323201.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_27 = math.max(var_354_18, arg_351_1.talkMaxDuration)

			if var_354_17 <= arg_351_1.time_ and arg_351_1.time_ < var_354_17 + var_354_27 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_17) / var_354_27

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_17 + var_354_27 and arg_351_1.time_ < var_354_17 + var_354_27 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play323201083 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 323201083
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play323201084(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1070ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1070ui_story == nil then
				arg_355_1.var_.characterEffect1070ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect1070ui_story and not isNil(var_358_0) then
					local var_358_4 = Mathf.Lerp(0, 0.5, var_358_3)

					arg_355_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1070ui_story.fillRatio = var_358_4
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect1070ui_story then
				local var_358_5 = 0.5

				arg_355_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1070ui_story.fillRatio = var_358_5
			end

			local var_358_6 = arg_355_1.actors_["1070ui_story"].transform
			local var_358_7 = 0

			if var_358_7 < arg_355_1.time_ and arg_355_1.time_ <= var_358_7 + arg_358_0 then
				arg_355_1.var_.moveOldPos1070ui_story = var_358_6.localPosition
			end

			local var_358_8 = 0.001

			if var_358_7 <= arg_355_1.time_ and arg_355_1.time_ < var_358_7 + var_358_8 then
				local var_358_9 = (arg_355_1.time_ - var_358_7) / var_358_8
				local var_358_10 = Vector3.New(0, 100, 0)

				var_358_6.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1070ui_story, var_358_10, var_358_9)

				local var_358_11 = manager.ui.mainCamera.transform.position - var_358_6.position

				var_358_6.forward = Vector3.New(var_358_11.x, var_358_11.y, var_358_11.z)

				local var_358_12 = var_358_6.localEulerAngles

				var_358_12.z = 0
				var_358_12.x = 0
				var_358_6.localEulerAngles = var_358_12
			end

			if arg_355_1.time_ >= var_358_7 + var_358_8 and arg_355_1.time_ < var_358_7 + var_358_8 + arg_358_0 then
				var_358_6.localPosition = Vector3.New(0, 100, 0)

				local var_358_13 = manager.ui.mainCamera.transform.position - var_358_6.position

				var_358_6.forward = Vector3.New(var_358_13.x, var_358_13.y, var_358_13.z)

				local var_358_14 = var_358_6.localEulerAngles

				var_358_14.z = 0
				var_358_14.x = 0
				var_358_6.localEulerAngles = var_358_14
			end

			local var_358_15 = 0
			local var_358_16 = 1

			if var_358_15 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				local var_358_17 = "play"
				local var_358_18 = "effect"

				arg_355_1:AudioAction(var_358_17, var_358_18, "se_story_140", "se_story_140_perish2", "")
			end

			local var_358_19 = 0
			local var_358_20 = 1.25

			if var_358_19 < arg_355_1.time_ and arg_355_1.time_ <= var_358_19 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_21 = arg_355_1:GetWordFromCfg(323201083)
				local var_358_22 = arg_355_1:FormatText(var_358_21.content)

				arg_355_1.text_.text = var_358_22

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_23 = 50
				local var_358_24 = utf8.len(var_358_22)
				local var_358_25 = var_358_23 <= 0 and var_358_20 or var_358_20 * (var_358_24 / var_358_23)

				if var_358_25 > 0 and var_358_20 < var_358_25 then
					arg_355_1.talkMaxDuration = var_358_25

					if var_358_25 + var_358_19 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_25 + var_358_19
					end
				end

				arg_355_1.text_.text = var_358_22
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_26 = math.max(var_358_20, arg_355_1.talkMaxDuration)

			if var_358_19 <= arg_355_1.time_ and arg_355_1.time_ < var_358_19 + var_358_26 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_19) / var_358_26

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_19 + var_358_26 and arg_355_1.time_ < var_358_19 + var_358_26 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play323201084 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 323201084
		arg_359_1.duration_ = 7.9

		local var_359_0 = {
			zh = 7.166,
			ja = 7.9
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
			arg_359_1.auto_ = false
		end

		function arg_359_1.playNext_(arg_361_0)
			arg_359_1.onStoryFinished_()
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1070ui_story"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1070ui_story == nil then
				arg_359_1.var_.characterEffect1070ui_story = var_362_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.characterEffect1070ui_story and not isNil(var_362_0) then
					arg_359_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.characterEffect1070ui_story then
				arg_359_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_362_4 = 0

			if var_362_4 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			local var_362_5 = 0

			if var_362_5 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_362_6 = arg_359_1.actors_["1070ui_story"].transform
			local var_362_7 = 0

			if var_362_7 < arg_359_1.time_ and arg_359_1.time_ <= var_362_7 + arg_362_0 then
				arg_359_1.var_.moveOldPos1070ui_story = var_362_6.localPosition
			end

			local var_362_8 = 0.001

			if var_362_7 <= arg_359_1.time_ and arg_359_1.time_ < var_362_7 + var_362_8 then
				local var_362_9 = (arg_359_1.time_ - var_362_7) / var_362_8
				local var_362_10 = Vector3.New(0, -0.95, -6.05)

				var_362_6.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1070ui_story, var_362_10, var_362_9)

				local var_362_11 = manager.ui.mainCamera.transform.position - var_362_6.position

				var_362_6.forward = Vector3.New(var_362_11.x, var_362_11.y, var_362_11.z)

				local var_362_12 = var_362_6.localEulerAngles

				var_362_12.z = 0
				var_362_12.x = 0
				var_362_6.localEulerAngles = var_362_12
			end

			if arg_359_1.time_ >= var_362_7 + var_362_8 and arg_359_1.time_ < var_362_7 + var_362_8 + arg_362_0 then
				var_362_6.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_362_13 = manager.ui.mainCamera.transform.position - var_362_6.position

				var_362_6.forward = Vector3.New(var_362_13.x, var_362_13.y, var_362_13.z)

				local var_362_14 = var_362_6.localEulerAngles

				var_362_14.z = 0
				var_362_14.x = 0
				var_362_6.localEulerAngles = var_362_14
			end

			local var_362_15 = 0
			local var_362_16 = 0.725

			if var_362_15 < arg_359_1.time_ and arg_359_1.time_ <= var_362_15 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_17 = arg_359_1:FormatText(StoryNameCfg[318].name)

				arg_359_1.leftNameTxt_.text = var_362_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_18 = arg_359_1:GetWordFromCfg(323201084)
				local var_362_19 = arg_359_1:FormatText(var_362_18.content)

				arg_359_1.text_.text = var_362_19

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_20 = 29
				local var_362_21 = utf8.len(var_362_19)
				local var_362_22 = var_362_20 <= 0 and var_362_16 or var_362_16 * (var_362_21 / var_362_20)

				if var_362_22 > 0 and var_362_16 < var_362_22 then
					arg_359_1.talkMaxDuration = var_362_22

					if var_362_22 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_22 + var_362_15
					end
				end

				arg_359_1.text_.text = var_362_19
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323201", "323201084", "story_v_out_323201.awb") ~= 0 then
					local var_362_23 = manager.audio:GetVoiceLength("story_v_out_323201", "323201084", "story_v_out_323201.awb") / 1000

					if var_362_23 + var_362_15 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_23 + var_362_15
					end

					if var_362_18.prefab_name ~= "" and arg_359_1.actors_[var_362_18.prefab_name] ~= nil then
						local var_362_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_18.prefab_name].transform, "story_v_out_323201", "323201084", "story_v_out_323201.awb")

						arg_359_1:RecordAudio("323201084", var_362_24)
						arg_359_1:RecordAudio("323201084", var_362_24)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_323201", "323201084", "story_v_out_323201.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_323201", "323201084", "story_v_out_323201.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_25 = math.max(var_362_16, arg_359_1.talkMaxDuration)

			if var_362_15 <= arg_359_1.time_ and arg_359_1.time_ < var_362_15 + var_362_25 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_15) / var_362_25

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_15 + var_362_25 and arg_359_1.time_ < var_362_15 + var_362_25 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2003",
		"TextureConfig/Background/J16f"
	},
	voices = {
		"story_v_out_323201.awb"
	}
}
