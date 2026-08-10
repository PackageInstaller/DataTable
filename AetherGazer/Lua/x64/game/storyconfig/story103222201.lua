return {
	Play322221001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322221001
		arg_1_1.duration_ = 16.07

		local var_1_0 = {
			zh = 14.965999999999,
			ja = 16.065999999999
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
				arg_1_0:Play322221002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L09f"

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
				local var_4_5 = arg_1_1.bgs_.L09f

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
					if iter_4_0 ~= "L09f" then
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

			local var_4_24 = "1111ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1111ui_story"].transform
			local var_4_30 = 2

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1111ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -0.87, -5.7)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1111ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1111ui_story"]
			local var_4_39 = 2

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1111ui_story == nil then
				arg_1_1.var_.characterEffect1111ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1111ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1111ui_story then
				arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_4_42 = 2

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_4_43 = 2

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0.166666666666667
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "effect"

				arg_1_1:AudioAction(var_4_46, var_4_47, "se_story_145", "se_story_145_amb_dark_L09", "")
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

			local var_4_54 = 0.466666666666667
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "music"

				arg_1_1:AudioAction(var_4_56, var_4_57, "bgm_activity_4_5_story_ra_piano", "bgm_activity_4_5_story_ra_piano", "bgm_activity_4_5_story_ra_piano.awb")

				local var_4_58 = ""
				local var_4_59 = manager.audio:GetAudioName("bgm_activity_4_5_story_ra_piano", "bgm_activity_4_5_story_ra_piano")

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
			local var_4_61 = 1.35

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

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[67].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(322221001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 54
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

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221001", "story_v_out_322221.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_322221", "322221001", "story_v_out_322221.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_322221", "322221001", "story_v_out_322221.awb")

						arg_1_1:RecordAudio("322221001", var_4_70)
						arg_1_1:RecordAudio("322221001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322221", "322221001", "story_v_out_322221.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322221", "322221001", "story_v_out_322221.awb")
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
				actorName = "1111ui_story",
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
	Play322221002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322221002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322221003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1111ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1111ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1111ui_story, var_12_4, var_12_3)

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
			local var_12_10 = 0.975

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

				local var_12_11 = arg_9_1:GetWordFromCfg(322221002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 39
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
				actorName = "1111ui_story",
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
	Play322221003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322221003
		arg_13_1.duration_ = 4.27

		local var_13_0 = {
			zh = 2.066,
			ja = 4.266
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
				arg_13_0:Play322221004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1111ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1111ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0, -0.87, -5.7)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1111ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1111ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1111ui_story == nil then
				arg_13_1.var_.characterEffect1111ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1111ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1111ui_story then
				arg_13_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_16_14 = 0
			local var_16_15 = 0.25

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_16 = arg_13_1:FormatText(StoryNameCfg[67].name)

				arg_13_1.leftNameTxt_.text = var_16_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_17 = arg_13_1:GetWordFromCfg(322221003)
				local var_16_18 = arg_13_1:FormatText(var_16_17.content)

				arg_13_1.text_.text = var_16_18

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 10
				local var_16_20 = utf8.len(var_16_18)
				local var_16_21 = var_16_19 <= 0 and var_16_15 or var_16_15 * (var_16_20 / var_16_19)

				if var_16_21 > 0 and var_16_15 < var_16_21 then
					arg_13_1.talkMaxDuration = var_16_21

					if var_16_21 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_21 + var_16_14
					end
				end

				arg_13_1.text_.text = var_16_18
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221003", "story_v_out_322221.awb") ~= 0 then
					local var_16_22 = manager.audio:GetVoiceLength("story_v_out_322221", "322221003", "story_v_out_322221.awb") / 1000

					if var_16_22 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_22 + var_16_14
					end

					if var_16_17.prefab_name ~= "" and arg_13_1.actors_[var_16_17.prefab_name] ~= nil then
						local var_16_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_17.prefab_name].transform, "story_v_out_322221", "322221003", "story_v_out_322221.awb")

						arg_13_1:RecordAudio("322221003", var_16_23)
						arg_13_1:RecordAudio("322221003", var_16_23)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322221", "322221003", "story_v_out_322221.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322221", "322221003", "story_v_out_322221.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_24 = math.max(var_16_15, arg_13_1.talkMaxDuration)

			if var_16_14 <= arg_13_1.time_ and arg_13_1.time_ < var_16_14 + var_16_24 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_14) / var_16_24

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_14 + var_16_24 and arg_13_1.time_ < var_16_14 + var_16_24 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play322221004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322221004
		arg_17_1.duration_ = 8.07

		local var_17_0 = {
			zh = 7,
			ja = 8.066
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
				arg_17_0:Play322221005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_20_1 = 0
			local var_20_2 = 0.75

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_3 = arg_17_1:FormatText(StoryNameCfg[67].name)

				arg_17_1.leftNameTxt_.text = var_20_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(322221004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221004", "story_v_out_322221.awb") ~= 0 then
					local var_20_9 = manager.audio:GetVoiceLength("story_v_out_322221", "322221004", "story_v_out_322221.awb") / 1000

					if var_20_9 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_1
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_322221", "322221004", "story_v_out_322221.awb")

						arg_17_1:RecordAudio("322221004", var_20_10)
						arg_17_1:RecordAudio("322221004", var_20_10)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322221", "322221004", "story_v_out_322221.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322221", "322221004", "story_v_out_322221.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_11 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_11 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_11

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_11 and arg_17_1.time_ < var_20_1 + var_20_11 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play322221005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322221005
		arg_21_1.duration_ = 4.37

		local var_21_0 = {
			zh = 3.166,
			ja = 4.366
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
				arg_21_0:Play322221006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1111ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1111ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1111ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = "10131ui_story"

			if arg_21_1.actors_[var_24_9] == nil then
				local var_24_10 = Asset.Load("Char/" .. "10131ui_story")

				if not isNil(var_24_10) then
					local var_24_11 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_21_1.stage_.transform)

					var_24_11.name = var_24_9
					var_24_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_9] = var_24_11

					local var_24_12 = var_24_11:GetComponentInChildren(typeof(CharacterEffect))

					var_24_12.enabled = true

					local var_24_13 = GameObjectTools.GetOrAddComponent(var_24_11, typeof(DynamicBoneHelper))

					if var_24_13 then
						var_24_13:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_12.transform, false)

					arg_21_1.var_[var_24_9 .. "Animator"] = var_24_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_9 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_9 .. "LipSync"] = var_24_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_14 = arg_21_1.actors_["10131ui_story"].transform
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.var_.moveOldPos10131ui_story = var_24_14.localPosition
			end

			local var_24_16 = 0.001

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16
				local var_24_18 = Vector3.New(0.83, -0.96, -5.8)

				var_24_14.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10131ui_story, var_24_18, var_24_17)

				local var_24_19 = manager.ui.mainCamera.transform.position - var_24_14.position

				var_24_14.forward = Vector3.New(var_24_19.x, var_24_19.y, var_24_19.z)

				local var_24_20 = var_24_14.localEulerAngles

				var_24_20.z = 0
				var_24_20.x = 0
				var_24_14.localEulerAngles = var_24_20
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 then
				var_24_14.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_24_21 = manager.ui.mainCamera.transform.position - var_24_14.position

				var_24_14.forward = Vector3.New(var_24_21.x, var_24_21.y, var_24_21.z)

				local var_24_22 = var_24_14.localEulerAngles

				var_24_22.z = 0
				var_24_22.x = 0
				var_24_14.localEulerAngles = var_24_22
			end

			local var_24_23 = arg_21_1.actors_["10131ui_story"]
			local var_24_24 = 0

			if var_24_24 < arg_21_1.time_ and arg_21_1.time_ <= var_24_24 + arg_24_0 and not isNil(var_24_23) and arg_21_1.var_.characterEffect10131ui_story == nil then
				arg_21_1.var_.characterEffect10131ui_story = var_24_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_25 = 0.200000002980232

			if var_24_24 <= arg_21_1.time_ and arg_21_1.time_ < var_24_24 + var_24_25 and not isNil(var_24_23) then
				local var_24_26 = (arg_21_1.time_ - var_24_24) / var_24_25

				if arg_21_1.var_.characterEffect10131ui_story and not isNil(var_24_23) then
					arg_21_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_24 + var_24_25 and arg_21_1.time_ < var_24_24 + var_24_25 + arg_24_0 and not isNil(var_24_23) and arg_21_1.var_.characterEffect10131ui_story then
				arg_21_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_24_27 = arg_21_1.actors_["1111ui_story"]
			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 and not isNil(var_24_27) and arg_21_1.var_.characterEffect1111ui_story == nil then
				arg_21_1.var_.characterEffect1111ui_story = var_24_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_29 = 0.200000002980232

			if var_24_28 <= arg_21_1.time_ and arg_21_1.time_ < var_24_28 + var_24_29 and not isNil(var_24_27) then
				local var_24_30 = (arg_21_1.time_ - var_24_28) / var_24_29

				if arg_21_1.var_.characterEffect1111ui_story and not isNil(var_24_27) then
					local var_24_31 = Mathf.Lerp(0, 0.5, var_24_30)

					arg_21_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1111ui_story.fillRatio = var_24_31
				end
			end

			if arg_21_1.time_ >= var_24_28 + var_24_29 and arg_21_1.time_ < var_24_28 + var_24_29 + arg_24_0 and not isNil(var_24_27) and arg_21_1.var_.characterEffect1111ui_story then
				local var_24_32 = 0.5

				arg_21_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1111ui_story.fillRatio = var_24_32
			end

			local var_24_33 = 0

			if var_24_33 < arg_21_1.time_ and arg_21_1.time_ <= var_24_33 + arg_24_0 then
				arg_21_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_24_34 = 0

			if var_24_34 < arg_21_1.time_ and arg_21_1.time_ <= var_24_34 + arg_24_0 then
				arg_21_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_24_35 = 0
			local var_24_36 = 0.4

			if var_24_35 < arg_21_1.time_ and arg_21_1.time_ <= var_24_35 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_37 = arg_21_1:FormatText(StoryNameCfg[1366].name)

				arg_21_1.leftNameTxt_.text = var_24_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_38 = arg_21_1:GetWordFromCfg(322221005)
				local var_24_39 = arg_21_1:FormatText(var_24_38.content)

				arg_21_1.text_.text = var_24_39

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_40 = 16
				local var_24_41 = utf8.len(var_24_39)
				local var_24_42 = var_24_40 <= 0 and var_24_36 or var_24_36 * (var_24_41 / var_24_40)

				if var_24_42 > 0 and var_24_36 < var_24_42 then
					arg_21_1.talkMaxDuration = var_24_42

					if var_24_42 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_35
					end
				end

				arg_21_1.text_.text = var_24_39
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221005", "story_v_out_322221.awb") ~= 0 then
					local var_24_43 = manager.audio:GetVoiceLength("story_v_out_322221", "322221005", "story_v_out_322221.awb") / 1000

					if var_24_43 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_43 + var_24_35
					end

					if var_24_38.prefab_name ~= "" and arg_21_1.actors_[var_24_38.prefab_name] ~= nil then
						local var_24_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_38.prefab_name].transform, "story_v_out_322221", "322221005", "story_v_out_322221.awb")

						arg_21_1:RecordAudio("322221005", var_24_44)
						arg_21_1:RecordAudio("322221005", var_24_44)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_322221", "322221005", "story_v_out_322221.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_322221", "322221005", "story_v_out_322221.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_45 = math.max(var_24_36, arg_21_1.talkMaxDuration)

			if var_24_35 <= arg_21_1.time_ and arg_21_1.time_ < var_24_35 + var_24_45 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_35) / var_24_45

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_35 + var_24_45 and arg_21_1.time_ < var_24_35 + var_24_45 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play322221006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322221006
		arg_25_1.duration_ = 3.47

		local var_25_0 = {
			zh = 2.533,
			ja = 3.466
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
				arg_25_0:Play322221007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1111ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1111ui_story == nil then
				arg_25_1.var_.characterEffect1111ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1111ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1111ui_story then
				arg_25_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_28_4 = arg_25_1.actors_["10131ui_story"]
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect10131ui_story == nil then
				arg_25_1.var_.characterEffect10131ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_6 and not isNil(var_28_4) then
				local var_28_7 = (arg_25_1.time_ - var_28_5) / var_28_6

				if arg_25_1.var_.characterEffect10131ui_story and not isNil(var_28_4) then
					local var_28_8 = Mathf.Lerp(0, 0.5, var_28_7)

					arg_25_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10131ui_story.fillRatio = var_28_8
				end
			end

			if arg_25_1.time_ >= var_28_5 + var_28_6 and arg_25_1.time_ < var_28_5 + var_28_6 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect10131ui_story then
				local var_28_9 = 0.5

				arg_25_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10131ui_story.fillRatio = var_28_9
			end

			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_28_11 = 0
			local var_28_12 = 0.25

			if var_28_11 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_13 = arg_25_1:FormatText(StoryNameCfg[67].name)

				arg_25_1.leftNameTxt_.text = var_28_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_14 = arg_25_1:GetWordFromCfg(322221006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_16 = 10
				local var_28_17 = utf8.len(var_28_15)
				local var_28_18 = var_28_16 <= 0 and var_28_12 or var_28_12 * (var_28_17 / var_28_16)

				if var_28_18 > 0 and var_28_12 < var_28_18 then
					arg_25_1.talkMaxDuration = var_28_18

					if var_28_18 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_11
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221006", "story_v_out_322221.awb") ~= 0 then
					local var_28_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221006", "story_v_out_322221.awb") / 1000

					if var_28_19 + var_28_11 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_11
					end

					if var_28_14.prefab_name ~= "" and arg_25_1.actors_[var_28_14.prefab_name] ~= nil then
						local var_28_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_14.prefab_name].transform, "story_v_out_322221", "322221006", "story_v_out_322221.awb")

						arg_25_1:RecordAudio("322221006", var_28_20)
						arg_25_1:RecordAudio("322221006", var_28_20)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322221", "322221006", "story_v_out_322221.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322221", "322221006", "story_v_out_322221.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_21 = math.max(var_28_12, arg_25_1.talkMaxDuration)

			if var_28_11 <= arg_25_1.time_ and arg_25_1.time_ < var_28_11 + var_28_21 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_11) / var_28_21

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_11 + var_28_21 and arg_25_1.time_ < var_28_11 + var_28_21 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play322221007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322221007
		arg_29_1.duration_ = 10.87

		local var_29_0 = {
			zh = 7.933,
			ja = 10.866
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
				arg_29_0:Play322221008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.85

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[67].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(322221007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 34
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221007", "story_v_out_322221.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221007", "story_v_out_322221.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_322221", "322221007", "story_v_out_322221.awb")

						arg_29_1:RecordAudio("322221007", var_32_9)
						arg_29_1:RecordAudio("322221007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322221", "322221007", "story_v_out_322221.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322221", "322221007", "story_v_out_322221.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322221008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322221008
		arg_33_1.duration_ = 13.53

		local var_33_0 = {
			zh = 8,
			ja = 13.533
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
				arg_33_0:Play322221009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action456")
			end

			local var_36_1 = 0
			local var_36_2 = 0.95

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_3 = arg_33_1:FormatText(StoryNameCfg[67].name)

				arg_33_1.leftNameTxt_.text = var_36_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(322221008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 38
				local var_36_7 = utf8.len(var_36_5)
				local var_36_8 = var_36_6 <= 0 and var_36_2 or var_36_2 * (var_36_7 / var_36_6)

				if var_36_8 > 0 and var_36_2 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221008", "story_v_out_322221.awb") ~= 0 then
					local var_36_9 = manager.audio:GetVoiceLength("story_v_out_322221", "322221008", "story_v_out_322221.awb") / 1000

					if var_36_9 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_1
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_322221", "322221008", "story_v_out_322221.awb")

						arg_33_1:RecordAudio("322221008", var_36_10)
						arg_33_1:RecordAudio("322221008", var_36_10)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322221", "322221008", "story_v_out_322221.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322221", "322221008", "story_v_out_322221.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_11 and arg_33_1.time_ < var_36_1 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322221009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322221009
		arg_37_1.duration_ = 2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play322221010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10131ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10131ui_story == nil then
				arg_37_1.var_.characterEffect10131ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10131ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10131ui_story then
				arg_37_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["1111ui_story"]
			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1111ui_story == nil then
				arg_37_1.var_.characterEffect1111ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 and not isNil(var_40_4) then
				local var_40_7 = (arg_37_1.time_ - var_40_5) / var_40_6

				if arg_37_1.var_.characterEffect1111ui_story and not isNil(var_40_4) then
					local var_40_8 = Mathf.Lerp(0, 0.5, var_40_7)

					arg_37_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1111ui_story.fillRatio = var_40_8
				end
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1111ui_story then
				local var_40_9 = 0.5

				arg_37_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1111ui_story.fillRatio = var_40_9
			end

			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_40_11 = 0
			local var_40_12 = 0.125

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_13 = arg_37_1:FormatText(StoryNameCfg[1366].name)

				arg_37_1.leftNameTxt_.text = var_40_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(322221009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221009", "story_v_out_322221.awb") ~= 0 then
					local var_40_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221009", "story_v_out_322221.awb") / 1000

					if var_40_19 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_11
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_322221", "322221009", "story_v_out_322221.awb")

						arg_37_1:RecordAudio("322221009", var_40_20)
						arg_37_1:RecordAudio("322221009", var_40_20)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322221", "322221009", "story_v_out_322221.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322221", "322221009", "story_v_out_322221.awb")
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
	Play322221010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322221010
		arg_41_1.duration_ = 5.6

		local var_41_0 = {
			zh = 4.666,
			ja = 5.6
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
				arg_41_0:Play322221011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1111ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1111ui_story == nil then
				arg_41_1.var_.characterEffect1111ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1111ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1111ui_story then
				arg_41_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["10131ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect10131ui_story == nil then
				arg_41_1.var_.characterEffect10131ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect10131ui_story and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10131ui_story.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect10131ui_story then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10131ui_story.fillRatio = var_44_9
			end

			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_44_11 = 0
			local var_44_12 = 0.475

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_13 = arg_41_1:FormatText(StoryNameCfg[67].name)

				arg_41_1.leftNameTxt_.text = var_44_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_14 = arg_41_1:GetWordFromCfg(322221010)
				local var_44_15 = arg_41_1:FormatText(var_44_14.content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 19
				local var_44_17 = utf8.len(var_44_15)
				local var_44_18 = var_44_16 <= 0 and var_44_12 or var_44_12 * (var_44_17 / var_44_16)

				if var_44_18 > 0 and var_44_12 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18

					if var_44_18 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221010", "story_v_out_322221.awb") ~= 0 then
					local var_44_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221010", "story_v_out_322221.awb") / 1000

					if var_44_19 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_11
					end

					if var_44_14.prefab_name ~= "" and arg_41_1.actors_[var_44_14.prefab_name] ~= nil then
						local var_44_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_14.prefab_name].transform, "story_v_out_322221", "322221010", "story_v_out_322221.awb")

						arg_41_1:RecordAudio("322221010", var_44_20)
						arg_41_1:RecordAudio("322221010", var_44_20)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322221", "322221010", "story_v_out_322221.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322221", "322221010", "story_v_out_322221.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_21 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_21 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_21

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_21 and arg_41_1.time_ < var_44_11 + var_44_21 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322221011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322221011
		arg_45_1.duration_ = 8.7

		local var_45_0 = {
			zh = 6.233,
			ja = 8.7
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
				arg_45_0:Play322221012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.75

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[67].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(322221011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 30
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221011", "story_v_out_322221.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221011", "story_v_out_322221.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_322221", "322221011", "story_v_out_322221.awb")

						arg_45_1:RecordAudio("322221011", var_48_9)
						arg_45_1:RecordAudio("322221011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322221", "322221011", "story_v_out_322221.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322221", "322221011", "story_v_out_322221.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322221012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322221012
		arg_49_1.duration_ = 2

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322221013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10131ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10131ui_story == nil then
				arg_49_1.var_.characterEffect10131ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10131ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10131ui_story then
				arg_49_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1111ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1111ui_story == nil then
				arg_49_1.var_.characterEffect1111ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.characterEffect1111ui_story and not isNil(var_52_4) then
					local var_52_8 = Mathf.Lerp(0, 0.5, var_52_7)

					arg_49_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1111ui_story.fillRatio = var_52_8
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1111ui_story then
				local var_52_9 = 0.5

				arg_49_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1111ui_story.fillRatio = var_52_9
			end

			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_52_11 = 0
			local var_52_12 = 0.075

			if var_52_11 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_13 = arg_49_1:FormatText(StoryNameCfg[1366].name)

				arg_49_1.leftNameTxt_.text = var_52_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_14 = arg_49_1:GetWordFromCfg(322221012)
				local var_52_15 = arg_49_1:FormatText(var_52_14.content)

				arg_49_1.text_.text = var_52_15

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_16 = 3
				local var_52_17 = utf8.len(var_52_15)
				local var_52_18 = var_52_16 <= 0 and var_52_12 or var_52_12 * (var_52_17 / var_52_16)

				if var_52_18 > 0 and var_52_12 < var_52_18 then
					arg_49_1.talkMaxDuration = var_52_18

					if var_52_18 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_11
					end
				end

				arg_49_1.text_.text = var_52_15
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221012", "story_v_out_322221.awb") ~= 0 then
					local var_52_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221012", "story_v_out_322221.awb") / 1000

					if var_52_19 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_11
					end

					if var_52_14.prefab_name ~= "" and arg_49_1.actors_[var_52_14.prefab_name] ~= nil then
						local var_52_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_14.prefab_name].transform, "story_v_out_322221", "322221012", "story_v_out_322221.awb")

						arg_49_1:RecordAudio("322221012", var_52_20)
						arg_49_1:RecordAudio("322221012", var_52_20)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322221", "322221012", "story_v_out_322221.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322221", "322221012", "story_v_out_322221.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_21 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_21 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_21

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_21 and arg_49_1.time_ < var_52_11 + var_52_21 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322221013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322221013
		arg_53_1.duration_ = 5.23

		local var_53_0 = {
			zh = 4.566,
			ja = 5.233
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
				arg_53_0:Play322221014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1111ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1111ui_story == nil then
				arg_53_1.var_.characterEffect1111ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1111ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1111ui_story then
				arg_53_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_56_4 = arg_53_1.actors_["10131ui_story"]
			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect10131ui_story == nil then
				arg_53_1.var_.characterEffect10131ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_6 and not isNil(var_56_4) then
				local var_56_7 = (arg_53_1.time_ - var_56_5) / var_56_6

				if arg_53_1.var_.characterEffect10131ui_story and not isNil(var_56_4) then
					local var_56_8 = Mathf.Lerp(0, 0.5, var_56_7)

					arg_53_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10131ui_story.fillRatio = var_56_8
				end
			end

			if arg_53_1.time_ >= var_56_5 + var_56_6 and arg_53_1.time_ < var_56_5 + var_56_6 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect10131ui_story then
				local var_56_9 = 0.5

				arg_53_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10131ui_story.fillRatio = var_56_9
			end

			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_56_11 = 0
			local var_56_12 = 0.475

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_13 = arg_53_1:FormatText(StoryNameCfg[67].name)

				arg_53_1.leftNameTxt_.text = var_56_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(322221013)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 19
				local var_56_17 = utf8.len(var_56_15)
				local var_56_18 = var_56_16 <= 0 and var_56_12 or var_56_12 * (var_56_17 / var_56_16)

				if var_56_18 > 0 and var_56_12 < var_56_18 then
					arg_53_1.talkMaxDuration = var_56_18

					if var_56_18 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_11
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221013", "story_v_out_322221.awb") ~= 0 then
					local var_56_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221013", "story_v_out_322221.awb") / 1000

					if var_56_19 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_11
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_322221", "322221013", "story_v_out_322221.awb")

						arg_53_1:RecordAudio("322221013", var_56_20)
						arg_53_1:RecordAudio("322221013", var_56_20)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322221", "322221013", "story_v_out_322221.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322221", "322221013", "story_v_out_322221.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_21 = math.max(var_56_12, arg_53_1.talkMaxDuration)

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_21 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_11) / var_56_21

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_11 + var_56_21 and arg_53_1.time_ < var_56_11 + var_56_21 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322221014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322221014
		arg_57_1.duration_ = 16.3

		local var_57_0 = {
			zh = 12.4,
			ja = 16.3
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
				arg_57_0:Play322221015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.325

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[67].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(322221014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221014", "story_v_out_322221.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221014", "story_v_out_322221.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_322221", "322221014", "story_v_out_322221.awb")

						arg_57_1:RecordAudio("322221014", var_60_9)
						arg_57_1:RecordAudio("322221014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322221", "322221014", "story_v_out_322221.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322221", "322221014", "story_v_out_322221.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play322221015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322221015
		arg_61_1.duration_ = 13.53

		local var_61_0 = {
			zh = 8.3,
			ja = 13.533
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
				arg_61_0:Play322221016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_64_1 = 0
			local var_64_2 = 0.9

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_3 = arg_61_1:FormatText(StoryNameCfg[67].name)

				arg_61_1.leftNameTxt_.text = var_64_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(322221015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 36
				local var_64_7 = utf8.len(var_64_5)
				local var_64_8 = var_64_6 <= 0 and var_64_2 or var_64_2 * (var_64_7 / var_64_6)

				if var_64_8 > 0 and var_64_2 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221015", "story_v_out_322221.awb") ~= 0 then
					local var_64_9 = manager.audio:GetVoiceLength("story_v_out_322221", "322221015", "story_v_out_322221.awb") / 1000

					if var_64_9 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_1
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_322221", "322221015", "story_v_out_322221.awb")

						arg_61_1:RecordAudio("322221015", var_64_10)
						arg_61_1:RecordAudio("322221015", var_64_10)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322221", "322221015", "story_v_out_322221.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322221", "322221015", "story_v_out_322221.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_11 and arg_61_1.time_ < var_64_1 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play322221016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322221016
		arg_65_1.duration_ = 8.57

		local var_65_0 = {
			zh = 6.3,
			ja = 8.566
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
				arg_65_0:Play322221017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10131ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10131ui_story == nil then
				arg_65_1.var_.characterEffect10131ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect10131ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10131ui_story then
				arg_65_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1111ui_story"]
			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1111ui_story == nil then
				arg_65_1.var_.characterEffect1111ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.200000002980232

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 and not isNil(var_68_4) then
				local var_68_7 = (arg_65_1.time_ - var_68_5) / var_68_6

				if arg_65_1.var_.characterEffect1111ui_story and not isNil(var_68_4) then
					local var_68_8 = Mathf.Lerp(0, 0.5, var_68_7)

					arg_65_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1111ui_story.fillRatio = var_68_8
				end
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1111ui_story then
				local var_68_9 = 0.5

				arg_65_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1111ui_story.fillRatio = var_68_9
			end

			local var_68_10 = 0
			local var_68_11 = 0.725

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_12 = arg_65_1:FormatText(StoryNameCfg[1366].name)

				arg_65_1.leftNameTxt_.text = var_68_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_13 = arg_65_1:GetWordFromCfg(322221016)
				local var_68_14 = arg_65_1:FormatText(var_68_13.content)

				arg_65_1.text_.text = var_68_14

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_15 = 29
				local var_68_16 = utf8.len(var_68_14)
				local var_68_17 = var_68_15 <= 0 and var_68_11 or var_68_11 * (var_68_16 / var_68_15)

				if var_68_17 > 0 and var_68_11 < var_68_17 then
					arg_65_1.talkMaxDuration = var_68_17

					if var_68_17 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_10
					end
				end

				arg_65_1.text_.text = var_68_14
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221016", "story_v_out_322221.awb") ~= 0 then
					local var_68_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221016", "story_v_out_322221.awb") / 1000

					if var_68_18 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_10
					end

					if var_68_13.prefab_name ~= "" and arg_65_1.actors_[var_68_13.prefab_name] ~= nil then
						local var_68_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_13.prefab_name].transform, "story_v_out_322221", "322221016", "story_v_out_322221.awb")

						arg_65_1:RecordAudio("322221016", var_68_19)
						arg_65_1:RecordAudio("322221016", var_68_19)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322221", "322221016", "story_v_out_322221.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322221", "322221016", "story_v_out_322221.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_20 = math.max(var_68_11, arg_65_1.talkMaxDuration)

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_20 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_10) / var_68_20

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_10 + var_68_20 and arg_65_1.time_ < var_68_10 + var_68_20 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play322221017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322221017
		arg_69_1.duration_ = 6.67

		local var_69_0 = {
			zh = 4.866,
			ja = 6.666
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
				arg_69_0:Play322221018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_1")
			end

			local var_72_1 = 0
			local var_72_2 = 0.45

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_3 = arg_69_1:FormatText(StoryNameCfg[1366].name)

				arg_69_1.leftNameTxt_.text = var_72_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(322221017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221017", "story_v_out_322221.awb") ~= 0 then
					local var_72_9 = manager.audio:GetVoiceLength("story_v_out_322221", "322221017", "story_v_out_322221.awb") / 1000

					if var_72_9 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_1
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_322221", "322221017", "story_v_out_322221.awb")

						arg_69_1:RecordAudio("322221017", var_72_10)
						arg_69_1:RecordAudio("322221017", var_72_10)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322221", "322221017", "story_v_out_322221.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322221", "322221017", "story_v_out_322221.awb")
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
	Play322221018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322221018
		arg_73_1.duration_ = 4.13

		local var_73_0 = {
			zh = 3.533,
			ja = 4.133
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
				arg_73_0:Play322221019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1111ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1111ui_story == nil then
				arg_73_1.var_.characterEffect1111ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1111ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1111ui_story then
				arg_73_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_76_4 = arg_73_1.actors_["10131ui_story"]
			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10131ui_story == nil then
				arg_73_1.var_.characterEffect10131ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_6 = 0.200000002980232

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_6 and not isNil(var_76_4) then
				local var_76_7 = (arg_73_1.time_ - var_76_5) / var_76_6

				if arg_73_1.var_.characterEffect10131ui_story and not isNil(var_76_4) then
					local var_76_8 = Mathf.Lerp(0, 0.5, var_76_7)

					arg_73_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10131ui_story.fillRatio = var_76_8
				end
			end

			if arg_73_1.time_ >= var_76_5 + var_76_6 and arg_73_1.time_ < var_76_5 + var_76_6 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect10131ui_story then
				local var_76_9 = 0.5

				arg_73_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10131ui_story.fillRatio = var_76_9
			end

			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_76_11 = 0
			local var_76_12 = 0.375

			if var_76_11 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_13 = arg_73_1:FormatText(StoryNameCfg[67].name)

				arg_73_1.leftNameTxt_.text = var_76_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:GetWordFromCfg(322221018)
				local var_76_15 = arg_73_1:FormatText(var_76_14.content)

				arg_73_1.text_.text = var_76_15

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 15
				local var_76_17 = utf8.len(var_76_15)
				local var_76_18 = var_76_16 <= 0 and var_76_12 or var_76_12 * (var_76_17 / var_76_16)

				if var_76_18 > 0 and var_76_12 < var_76_18 then
					arg_73_1.talkMaxDuration = var_76_18

					if var_76_18 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_18 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_15
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221018", "story_v_out_322221.awb") ~= 0 then
					local var_76_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221018", "story_v_out_322221.awb") / 1000

					if var_76_19 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_11
					end

					if var_76_14.prefab_name ~= "" and arg_73_1.actors_[var_76_14.prefab_name] ~= nil then
						local var_76_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_14.prefab_name].transform, "story_v_out_322221", "322221018", "story_v_out_322221.awb")

						arg_73_1:RecordAudio("322221018", var_76_20)
						arg_73_1:RecordAudio("322221018", var_76_20)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_322221", "322221018", "story_v_out_322221.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_322221", "322221018", "story_v_out_322221.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_21 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_21 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_21

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_21 and arg_73_1.time_ < var_76_11 + var_76_21 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play322221019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322221019
		arg_77_1.duration_ = 10.6

		local var_77_0 = {
			zh = 5.2,
			ja = 10.6
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
				arg_77_0:Play322221020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10131ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10131ui_story == nil then
				arg_77_1.var_.characterEffect10131ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect10131ui_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect10131ui_story then
				arg_77_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_80_4 = arg_77_1.actors_["1111ui_story"]
			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1111ui_story == nil then
				arg_77_1.var_.characterEffect1111ui_story = var_80_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_6 = 0.200000002980232

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 and not isNil(var_80_4) then
				local var_80_7 = (arg_77_1.time_ - var_80_5) / var_80_6

				if arg_77_1.var_.characterEffect1111ui_story and not isNil(var_80_4) then
					local var_80_8 = Mathf.Lerp(0, 0.5, var_80_7)

					arg_77_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1111ui_story.fillRatio = var_80_8
				end
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1111ui_story then
				local var_80_9 = 0.5

				arg_77_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1111ui_story.fillRatio = var_80_9
			end

			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_2")
			end

			local var_80_11 = 0

			if var_80_11 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_80_12 = 0
			local var_80_13 = 0.6

			if var_80_12 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_14 = arg_77_1:FormatText(StoryNameCfg[1366].name)

				arg_77_1.leftNameTxt_.text = var_80_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_15 = arg_77_1:GetWordFromCfg(322221019)
				local var_80_16 = arg_77_1:FormatText(var_80_15.content)

				arg_77_1.text_.text = var_80_16

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_17 = 24
				local var_80_18 = utf8.len(var_80_16)
				local var_80_19 = var_80_17 <= 0 and var_80_13 or var_80_13 * (var_80_18 / var_80_17)

				if var_80_19 > 0 and var_80_13 < var_80_19 then
					arg_77_1.talkMaxDuration = var_80_19

					if var_80_19 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_19 + var_80_12
					end
				end

				arg_77_1.text_.text = var_80_16
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221019", "story_v_out_322221.awb") ~= 0 then
					local var_80_20 = manager.audio:GetVoiceLength("story_v_out_322221", "322221019", "story_v_out_322221.awb") / 1000

					if var_80_20 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_20 + var_80_12
					end

					if var_80_15.prefab_name ~= "" and arg_77_1.actors_[var_80_15.prefab_name] ~= nil then
						local var_80_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_15.prefab_name].transform, "story_v_out_322221", "322221019", "story_v_out_322221.awb")

						arg_77_1:RecordAudio("322221019", var_80_21)
						arg_77_1:RecordAudio("322221019", var_80_21)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322221", "322221019", "story_v_out_322221.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322221", "322221019", "story_v_out_322221.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_22 = math.max(var_80_13, arg_77_1.talkMaxDuration)

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_22 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_12) / var_80_22

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_12 + var_80_22 and arg_77_1.time_ < var_80_12 + var_80_22 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play322221020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 322221020
		arg_81_1.duration_ = 14.03

		local var_81_0 = {
			zh = 10.166,
			ja = 14.033
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
				arg_81_0:Play322221021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1111ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1111ui_story == nil then
				arg_81_1.var_.characterEffect1111ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1111ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1111ui_story then
				arg_81_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["10131ui_story"]
			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10131ui_story == nil then
				arg_81_1.var_.characterEffect10131ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 and not isNil(var_84_4) then
				local var_84_7 = (arg_81_1.time_ - var_84_5) / var_84_6

				if arg_81_1.var_.characterEffect10131ui_story and not isNil(var_84_4) then
					local var_84_8 = Mathf.Lerp(0, 0.5, var_84_7)

					arg_81_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10131ui_story.fillRatio = var_84_8
				end
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10131ui_story then
				local var_84_9 = 0.5

				arg_81_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10131ui_story.fillRatio = var_84_9
			end

			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_84_11 = 0
			local var_84_12 = 1.125

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_13 = arg_81_1:FormatText(StoryNameCfg[67].name)

				arg_81_1.leftNameTxt_.text = var_84_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:GetWordFromCfg(322221020)
				local var_84_15 = arg_81_1:FormatText(var_84_14.content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221020", "story_v_out_322221.awb") ~= 0 then
					local var_84_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221020", "story_v_out_322221.awb") / 1000

					if var_84_19 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_11
					end

					if var_84_14.prefab_name ~= "" and arg_81_1.actors_[var_84_14.prefab_name] ~= nil then
						local var_84_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_14.prefab_name].transform, "story_v_out_322221", "322221020", "story_v_out_322221.awb")

						arg_81_1:RecordAudio("322221020", var_84_20)
						arg_81_1:RecordAudio("322221020", var_84_20)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_322221", "322221020", "story_v_out_322221.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_322221", "322221020", "story_v_out_322221.awb")
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
	Play322221021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 322221021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play322221022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1111ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1111ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, 100, 0)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1111ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, 100, 0)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["10131ui_story"].transform
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.var_.moveOldPos10131ui_story = var_88_9.localPosition
			end

			local var_88_11 = 0.001

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11
				local var_88_13 = Vector3.New(0, 100, 0)

				var_88_9.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10131ui_story, var_88_13, var_88_12)

				local var_88_14 = manager.ui.mainCamera.transform.position - var_88_9.position

				var_88_9.forward = Vector3.New(var_88_14.x, var_88_14.y, var_88_14.z)

				local var_88_15 = var_88_9.localEulerAngles

				var_88_15.z = 0
				var_88_15.x = 0
				var_88_9.localEulerAngles = var_88_15
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 then
				var_88_9.localPosition = Vector3.New(0, 100, 0)

				local var_88_16 = manager.ui.mainCamera.transform.position - var_88_9.position

				var_88_9.forward = Vector3.New(var_88_16.x, var_88_16.y, var_88_16.z)

				local var_88_17 = var_88_9.localEulerAngles

				var_88_17.z = 0
				var_88_17.x = 0
				var_88_9.localEulerAngles = var_88_17
			end

			local var_88_18 = 0
			local var_88_19 = 0.9

			if var_88_18 < arg_85_1.time_ and arg_85_1.time_ <= var_88_18 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_20 = arg_85_1:GetWordFromCfg(322221021)
				local var_88_21 = arg_85_1:FormatText(var_88_20.content)

				arg_85_1.text_.text = var_88_21

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_22 = 36
				local var_88_23 = utf8.len(var_88_21)
				local var_88_24 = var_88_22 <= 0 and var_88_19 or var_88_19 * (var_88_23 / var_88_22)

				if var_88_24 > 0 and var_88_19 < var_88_24 then
					arg_85_1.talkMaxDuration = var_88_24

					if var_88_24 + var_88_18 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_18
					end
				end

				arg_85_1.text_.text = var_88_21
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_19, arg_85_1.talkMaxDuration)

			if var_88_18 <= arg_85_1.time_ and arg_85_1.time_ < var_88_18 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_18) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_18 + var_88_25 and arg_85_1.time_ < var_88_18 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play322221022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 322221022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play322221023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.2

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

				local var_92_2 = arg_89_1:GetWordFromCfg(322221022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 48
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
	Play322221023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322221023
		arg_93_1.duration_ = 3.53

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play322221024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = "STblack"

			if arg_93_1.bgs_[var_96_0] == nil then
				local var_96_1 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_96_0)
				var_96_1.name = var_96_0
				var_96_1.transform.parent = arg_93_1.stage_.transform
				var_96_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_[var_96_0] = var_96_1
			end

			local var_96_2 = 1

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				local var_96_3 = manager.ui.mainCamera.transform.localPosition
				local var_96_4 = Vector3.New(0, 0, 10) + Vector3.New(var_96_3.x, var_96_3.y, 0)
				local var_96_5 = arg_93_1.bgs_.STblack

				var_96_5.transform.localPosition = var_96_4
				var_96_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_6 = var_96_5:GetComponent("SpriteRenderer")

				if var_96_6 and var_96_6.sprite then
					local var_96_7 = (var_96_5.transform.localPosition - var_96_3).z
					local var_96_8 = manager.ui.mainCameraCom_
					local var_96_9 = 2 * var_96_7 * Mathf.Tan(var_96_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_96_10 = var_96_9 * var_96_8.aspect
					local var_96_11 = var_96_6.sprite.bounds.size.x
					local var_96_12 = var_96_6.sprite.bounds.size.y
					local var_96_13 = var_96_10 / var_96_11
					local var_96_14 = var_96_9 / var_96_12
					local var_96_15 = var_96_14 < var_96_13 and var_96_13 or var_96_14

					var_96_5.transform.localScale = Vector3.New(var_96_15, var_96_15, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "STblack" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_17 = 1

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17
				local var_96_19 = Color.New(0, 0, 0)

				var_96_19.a = Mathf.Lerp(0, 1, var_96_18)
				arg_93_1.mask_.color = var_96_19
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				local var_96_20 = Color.New(0, 0, 0)

				var_96_20.a = 1
				arg_93_1.mask_.color = var_96_20
			end

			local var_96_21 = 1

			if var_96_21 < arg_93_1.time_ and arg_93_1.time_ <= var_96_21 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_22 = 1

			if var_96_21 <= arg_93_1.time_ and arg_93_1.time_ < var_96_21 + var_96_22 then
				local var_96_23 = (arg_93_1.time_ - var_96_21) / var_96_22
				local var_96_24 = Color.New(0, 0, 0)

				var_96_24.a = Mathf.Lerp(1, 0, var_96_23)
				arg_93_1.mask_.color = var_96_24
			end

			if arg_93_1.time_ >= var_96_21 + var_96_22 and arg_93_1.time_ < var_96_21 + var_96_22 + arg_96_0 then
				local var_96_25 = Color.New(0, 0, 0)
				local var_96_26 = 0

				arg_93_1.mask_.enabled = false
				var_96_25.a = var_96_26
				arg_93_1.mask_.color = var_96_25
			end

			local var_96_27 = manager.ui.mainCamera.transform
			local var_96_28 = 1

			if var_96_28 < arg_93_1.time_ and arg_93_1.time_ <= var_96_28 + arg_96_0 then
				local var_96_29 = arg_93_1.var_.effect1023
				local var_96_30
				local var_96_31 = var_96_27

				if not var_96_29 then
					var_96_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_soundonly_keep"), var_96_31)
					var_96_29.name = "1023"
					arg_93_1.var_.effect1023 = var_96_29
				else
					var_96_29.transform:SetParent(var_96_31)
				end

				var_96_29.transform.localPosition = Vector3.New(0, 0, 8.15)
				var_96_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 102,
				charCount = 0,
				enableLayoutChange = true,
				duration = 0,
				groupID = "10233",
				startTime = 1,
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
				contentID = 322221023,
				charCount = 2,
				enableLayoutChange = true,
				duration = 0.233333333333334,
				groupID = "1023",
				startTime = 1.76666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
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

		arg_93_1:InitPlayNodeList()
	end,
	Play322221024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322221024
		arg_97_1.duration_ = 2.53

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322221025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			return
		end

		arg_97_1.nodeConfigList_ = {
			{
				groupID = "1023",
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
				contentID = 322221024,
				charCount = 38,
				enableLayoutChange = true,
				duration = 2.53333333333333,
				groupID = "1024",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
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

		arg_97_1:InitPlayNodeList()
	end,
	Play322221025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322221025
		arg_101_1.duration_ = 3.45

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play322221026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			return
		end

		arg_101_1.nodeConfigList_ = {
			{
				groupID = "1024",
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
				contentID = 322221025,
				charCount = 51,
				enableLayoutChange = true,
				duration = 3.4,
				groupID = "1025",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
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

		arg_101_1:InitPlayNodeList()
	end,
	Play322221026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322221026
		arg_105_1.duration_ = 18.03

		local var_105_0 = {
			zh = 18.0326666666667,
			ja = 17.0326666666667
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
				arg_105_0:Play322221027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.966666666666667

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				local var_108_1 = manager.ui.mainCamera.transform.localPosition
				local var_108_2 = Vector3.New(0, 0, 10) + Vector3.New(var_108_1.x, var_108_1.y, 0)
				local var_108_3 = arg_105_1.bgs_.L09f

				var_108_3.transform.localPosition = var_108_2
				var_108_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_4 = var_108_3:GetComponent("SpriteRenderer")

				if var_108_4 and var_108_4.sprite then
					local var_108_5 = (var_108_3.transform.localPosition - var_108_1).z
					local var_108_6 = manager.ui.mainCameraCom_
					local var_108_7 = 2 * var_108_5 * Mathf.Tan(var_108_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_108_8 = var_108_7 * var_108_6.aspect
					local var_108_9 = var_108_4.sprite.bounds.size.x
					local var_108_10 = var_108_4.sprite.bounds.size.y
					local var_108_11 = var_108_8 / var_108_9
					local var_108_12 = var_108_7 / var_108_10
					local var_108_13 = var_108_12 < var_108_11 and var_108_11 or var_108_12

					var_108_3.transform.localScale = Vector3.New(var_108_13, var_108_13, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "L09f" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_14 = 2.96666666666667

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			local var_108_15 = 0.3

			if arg_105_1.time_ >= var_108_14 + var_108_15 and arg_105_1.time_ < var_108_14 + var_108_15 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_17 = 0.966666666666668

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17
				local var_108_19 = Color.New(0, 0, 0)

				var_108_19.a = Mathf.Lerp(0, 1, var_108_18)
				arg_105_1.mask_.color = var_108_19
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 then
				local var_108_20 = Color.New(0, 0, 0)

				var_108_20.a = 1
				arg_105_1.mask_.color = var_108_20
			end

			local var_108_21 = 0.966666666666667

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_22 = 2

			if var_108_21 <= arg_105_1.time_ and arg_105_1.time_ < var_108_21 + var_108_22 then
				local var_108_23 = (arg_105_1.time_ - var_108_21) / var_108_22
				local var_108_24 = Color.New(0, 0, 0)

				var_108_24.a = Mathf.Lerp(1, 0, var_108_23)
				arg_105_1.mask_.color = var_108_24
			end

			if arg_105_1.time_ >= var_108_21 + var_108_22 and arg_105_1.time_ < var_108_21 + var_108_22 + arg_108_0 then
				local var_108_25 = Color.New(0, 0, 0)
				local var_108_26 = 0

				arg_105_1.mask_.enabled = false
				var_108_25.a = var_108_26
				arg_105_1.mask_.color = var_108_25
			end

			local var_108_27 = arg_105_1.actors_["1111ui_story"].transform
			local var_108_28 = 2.96666666666667

			if var_108_28 < arg_105_1.time_ and arg_105_1.time_ <= var_108_28 + arg_108_0 then
				arg_105_1.var_.moveOldPos1111ui_story = var_108_27.localPosition
			end

			local var_108_29 = 0.001

			if var_108_28 <= arg_105_1.time_ and arg_105_1.time_ < var_108_28 + var_108_29 then
				local var_108_30 = (arg_105_1.time_ - var_108_28) / var_108_29
				local var_108_31 = Vector3.New(0, -0.87, -5.7)

				var_108_27.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1111ui_story, var_108_31, var_108_30)

				local var_108_32 = manager.ui.mainCamera.transform.position - var_108_27.position

				var_108_27.forward = Vector3.New(var_108_32.x, var_108_32.y, var_108_32.z)

				local var_108_33 = var_108_27.localEulerAngles

				var_108_33.z = 0
				var_108_33.x = 0
				var_108_27.localEulerAngles = var_108_33
			end

			if arg_105_1.time_ >= var_108_28 + var_108_29 and arg_105_1.time_ < var_108_28 + var_108_29 + arg_108_0 then
				var_108_27.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_108_34 = manager.ui.mainCamera.transform.position - var_108_27.position

				var_108_27.forward = Vector3.New(var_108_34.x, var_108_34.y, var_108_34.z)

				local var_108_35 = var_108_27.localEulerAngles

				var_108_35.z = 0
				var_108_35.x = 0
				var_108_27.localEulerAngles = var_108_35
			end

			local var_108_36 = arg_105_1.actors_["1111ui_story"]
			local var_108_37 = 2.96666666666667

			if var_108_37 < arg_105_1.time_ and arg_105_1.time_ <= var_108_37 + arg_108_0 and not isNil(var_108_36) and arg_105_1.var_.characterEffect1111ui_story == nil then
				arg_105_1.var_.characterEffect1111ui_story = var_108_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_38 = 0.200000002980232

			if var_108_37 <= arg_105_1.time_ and arg_105_1.time_ < var_108_37 + var_108_38 and not isNil(var_108_36) then
				local var_108_39 = (arg_105_1.time_ - var_108_37) / var_108_38

				if arg_105_1.var_.characterEffect1111ui_story and not isNil(var_108_36) then
					arg_105_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_37 + var_108_38 and arg_105_1.time_ < var_108_37 + var_108_38 + arg_108_0 and not isNil(var_108_36) and arg_105_1.var_.characterEffect1111ui_story then
				arg_105_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_108_40 = 2.96666666666667

			if var_108_40 < arg_105_1.time_ and arg_105_1.time_ <= var_108_40 + arg_108_0 then
				arg_105_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_108_41 = 2.96666666666667

			if var_108_41 < arg_105_1.time_ and arg_105_1.time_ <= var_108_41 + arg_108_0 then
				arg_105_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_108_42 = manager.ui.mainCamera.transform
			local var_108_43 = 0.966666666666667

			if var_108_43 < arg_105_1.time_ and arg_105_1.time_ <= var_108_43 + arg_108_0 then
				local var_108_44 = arg_105_1.var_.effect1023

				if var_108_44 then
					Object.Destroy(var_108_44)

					arg_105_1.var_.effect1023 = nil
				end
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_45 = 2.96666666666667
			local var_108_46 = 1.525

			if var_108_45 < arg_105_1.time_ and arg_105_1.time_ <= var_108_45 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_47 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_47:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_48 = arg_105_1:FormatText(StoryNameCfg[67].name)

				arg_105_1.leftNameTxt_.text = var_108_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_49 = arg_105_1:GetWordFromCfg(322221026)
				local var_108_50 = arg_105_1:FormatText(var_108_49.content)

				arg_105_1.text_.text = var_108_50

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_51 = 61
				local var_108_52 = utf8.len(var_108_50)
				local var_108_53 = var_108_51 <= 0 and var_108_46 or var_108_46 * (var_108_52 / var_108_51)

				if var_108_53 > 0 and var_108_46 < var_108_53 then
					arg_105_1.talkMaxDuration = var_108_53
					var_108_45 = var_108_45 + 0.3

					if var_108_53 + var_108_45 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_53 + var_108_45
					end
				end

				arg_105_1.text_.text = var_108_50
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221026", "story_v_out_322221.awb") ~= 0 then
					local var_108_54 = manager.audio:GetVoiceLength("story_v_out_322221", "322221026", "story_v_out_322221.awb") / 1000

					if var_108_54 + var_108_45 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_54 + var_108_45
					end

					if var_108_49.prefab_name ~= "" and arg_105_1.actors_[var_108_49.prefab_name] ~= nil then
						local var_108_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_49.prefab_name].transform, "story_v_out_322221", "322221026", "story_v_out_322221.awb")

						arg_105_1:RecordAudio("322221026", var_108_55)
						arg_105_1:RecordAudio("322221026", var_108_55)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_322221", "322221026", "story_v_out_322221.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_322221", "322221026", "story_v_out_322221.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_56 = var_108_45 + 0.3
			local var_108_57 = math.max(var_108_46, arg_105_1.talkMaxDuration)

			if var_108_56 <= arg_105_1.time_ and arg_105_1.time_ < var_108_56 + var_108_57 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_56) / var_108_57

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_56 + var_108_57 and arg_105_1.time_ < var_108_56 + var_108_57 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "1025",
				duration = 0.0166666666666666,
				className = "StoryTextGroupNode",
				startTime = 0.950000000000001,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play322221027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 322221027
		arg_111_1.duration_ = 6.43

		local var_111_0 = {
			zh = 6.433,
			ja = 5.466
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
				arg_111_0:Play322221028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.825

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[67].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:GetWordFromCfg(322221027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 33
				local var_114_6 = utf8.len(var_114_4)
				local var_114_7 = var_114_5 <= 0 and var_114_1 or var_114_1 * (var_114_6 / var_114_5)

				if var_114_7 > 0 and var_114_1 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221027", "story_v_out_322221.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221027", "story_v_out_322221.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_322221", "322221027", "story_v_out_322221.awb")

						arg_111_1:RecordAudio("322221027", var_114_9)
						arg_111_1:RecordAudio("322221027", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_322221", "322221027", "story_v_out_322221.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_322221", "322221027", "story_v_out_322221.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_10 and arg_111_1.time_ < var_114_0 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play322221028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 322221028
		arg_115_1.duration_ = 4.4

		local var_115_0 = {
			zh = 2,
			ja = 4.4
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
				arg_115_0:Play322221029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1111ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1111ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1111ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["10131ui_story"].transform
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 then
				arg_115_1.var_.moveOldPos10131ui_story = var_118_9.localPosition
			end

			local var_118_11 = 0.001

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11
				local var_118_13 = Vector3.New(0.83, -0.96, -5.8)

				var_118_9.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10131ui_story, var_118_13, var_118_12)

				local var_118_14 = manager.ui.mainCamera.transform.position - var_118_9.position

				var_118_9.forward = Vector3.New(var_118_14.x, var_118_14.y, var_118_14.z)

				local var_118_15 = var_118_9.localEulerAngles

				var_118_15.z = 0
				var_118_15.x = 0
				var_118_9.localEulerAngles = var_118_15
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 then
				var_118_9.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_118_16 = manager.ui.mainCamera.transform.position - var_118_9.position

				var_118_9.forward = Vector3.New(var_118_16.x, var_118_16.y, var_118_16.z)

				local var_118_17 = var_118_9.localEulerAngles

				var_118_17.z = 0
				var_118_17.x = 0
				var_118_9.localEulerAngles = var_118_17
			end

			local var_118_18 = arg_115_1.actors_["10131ui_story"]
			local var_118_19 = 0

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 and not isNil(var_118_18) and arg_115_1.var_.characterEffect10131ui_story == nil then
				arg_115_1.var_.characterEffect10131ui_story = var_118_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_20 = 0.200000002980232

			if var_118_19 <= arg_115_1.time_ and arg_115_1.time_ < var_118_19 + var_118_20 and not isNil(var_118_18) then
				local var_118_21 = (arg_115_1.time_ - var_118_19) / var_118_20

				if arg_115_1.var_.characterEffect10131ui_story and not isNil(var_118_18) then
					arg_115_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_19 + var_118_20 and arg_115_1.time_ < var_118_19 + var_118_20 + arg_118_0 and not isNil(var_118_18) and arg_115_1.var_.characterEffect10131ui_story then
				arg_115_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_118_22 = arg_115_1.actors_["1111ui_story"]
			local var_118_23 = 0

			if var_118_23 < arg_115_1.time_ and arg_115_1.time_ <= var_118_23 + arg_118_0 and not isNil(var_118_22) and arg_115_1.var_.characterEffect1111ui_story == nil then
				arg_115_1.var_.characterEffect1111ui_story = var_118_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_24 = 0.200000002980232

			if var_118_23 <= arg_115_1.time_ and arg_115_1.time_ < var_118_23 + var_118_24 and not isNil(var_118_22) then
				local var_118_25 = (arg_115_1.time_ - var_118_23) / var_118_24

				if arg_115_1.var_.characterEffect1111ui_story and not isNil(var_118_22) then
					local var_118_26 = Mathf.Lerp(0, 0.5, var_118_25)

					arg_115_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1111ui_story.fillRatio = var_118_26
				end
			end

			if arg_115_1.time_ >= var_118_23 + var_118_24 and arg_115_1.time_ < var_118_23 + var_118_24 + arg_118_0 and not isNil(var_118_22) and arg_115_1.var_.characterEffect1111ui_story then
				local var_118_27 = 0.5

				arg_115_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1111ui_story.fillRatio = var_118_27
			end

			local var_118_28 = 0

			if var_118_28 < arg_115_1.time_ and arg_115_1.time_ <= var_118_28 + arg_118_0 then
				arg_115_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_1")
			end

			local var_118_29 = 0

			if var_118_29 < arg_115_1.time_ and arg_115_1.time_ <= var_118_29 + arg_118_0 then
				arg_115_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_118_30 = 0
			local var_118_31 = 0.25

			if var_118_30 < arg_115_1.time_ and arg_115_1.time_ <= var_118_30 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_32 = arg_115_1:FormatText(StoryNameCfg[1366].name)

				arg_115_1.leftNameTxt_.text = var_118_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_33 = arg_115_1:GetWordFromCfg(322221028)
				local var_118_34 = arg_115_1:FormatText(var_118_33.content)

				arg_115_1.text_.text = var_118_34

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_35 = 10
				local var_118_36 = utf8.len(var_118_34)
				local var_118_37 = var_118_35 <= 0 and var_118_31 or var_118_31 * (var_118_36 / var_118_35)

				if var_118_37 > 0 and var_118_31 < var_118_37 then
					arg_115_1.talkMaxDuration = var_118_37

					if var_118_37 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_37 + var_118_30
					end
				end

				arg_115_1.text_.text = var_118_34
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221028", "story_v_out_322221.awb") ~= 0 then
					local var_118_38 = manager.audio:GetVoiceLength("story_v_out_322221", "322221028", "story_v_out_322221.awb") / 1000

					if var_118_38 + var_118_30 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_38 + var_118_30
					end

					if var_118_33.prefab_name ~= "" and arg_115_1.actors_[var_118_33.prefab_name] ~= nil then
						local var_118_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_33.prefab_name].transform, "story_v_out_322221", "322221028", "story_v_out_322221.awb")

						arg_115_1:RecordAudio("322221028", var_118_39)
						arg_115_1:RecordAudio("322221028", var_118_39)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_322221", "322221028", "story_v_out_322221.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_322221", "322221028", "story_v_out_322221.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_40 = math.max(var_118_31, arg_115_1.talkMaxDuration)

			if var_118_30 <= arg_115_1.time_ and arg_115_1.time_ < var_118_30 + var_118_40 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_30) / var_118_40

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_30 + var_118_40 and arg_115_1.time_ < var_118_30 + var_118_40 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play322221029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322221029
		arg_119_1.duration_ = 12.5

		local var_119_0 = {
			zh = 9.366,
			ja = 12.5
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play322221030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1111ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1111ui_story == nil then
				arg_119_1.var_.characterEffect1111ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1111ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1111ui_story then
				arg_119_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_122_4 = arg_119_1.actors_["10131ui_story"]
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect10131ui_story == nil then
				arg_119_1.var_.characterEffect10131ui_story = var_122_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 and not isNil(var_122_4) then
				local var_122_7 = (arg_119_1.time_ - var_122_5) / var_122_6

				if arg_119_1.var_.characterEffect10131ui_story and not isNil(var_122_4) then
					local var_122_8 = Mathf.Lerp(0, 0.5, var_122_7)

					arg_119_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10131ui_story.fillRatio = var_122_8
				end
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 and not isNil(var_122_4) and arg_119_1.var_.characterEffect10131ui_story then
				local var_122_9 = 0.5

				arg_119_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10131ui_story.fillRatio = var_122_9
			end

			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_122_11 = 0
			local var_122_12 = 1

			if var_122_11 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_13 = arg_119_1:FormatText(StoryNameCfg[67].name)

				arg_119_1.leftNameTxt_.text = var_122_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_14 = arg_119_1:GetWordFromCfg(322221029)
				local var_122_15 = arg_119_1:FormatText(var_122_14.content)

				arg_119_1.text_.text = var_122_15

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_16 = 40
				local var_122_17 = utf8.len(var_122_15)
				local var_122_18 = var_122_16 <= 0 and var_122_12 or var_122_12 * (var_122_17 / var_122_16)

				if var_122_18 > 0 and var_122_12 < var_122_18 then
					arg_119_1.talkMaxDuration = var_122_18

					if var_122_18 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_18 + var_122_11
					end
				end

				arg_119_1.text_.text = var_122_15
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221029", "story_v_out_322221.awb") ~= 0 then
					local var_122_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221029", "story_v_out_322221.awb") / 1000

					if var_122_19 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_19 + var_122_11
					end

					if var_122_14.prefab_name ~= "" and arg_119_1.actors_[var_122_14.prefab_name] ~= nil then
						local var_122_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_14.prefab_name].transform, "story_v_out_322221", "322221029", "story_v_out_322221.awb")

						arg_119_1:RecordAudio("322221029", var_122_20)
						arg_119_1:RecordAudio("322221029", var_122_20)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_322221", "322221029", "story_v_out_322221.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_322221", "322221029", "story_v_out_322221.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_21 = math.max(var_122_12, arg_119_1.talkMaxDuration)

			if var_122_11 <= arg_119_1.time_ and arg_119_1.time_ < var_122_11 + var_122_21 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_11) / var_122_21

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_11 + var_122_21 and arg_119_1.time_ < var_122_11 + var_122_21 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play322221030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322221030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play322221031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1111ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos1111ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, 100, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1111ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, 100, 0)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["10131ui_story"].transform
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.var_.moveOldPos10131ui_story = var_126_9.localPosition
			end

			local var_126_11 = 0.001

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11
				local var_126_13 = Vector3.New(0, 100, 0)

				var_126_9.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10131ui_story, var_126_13, var_126_12)

				local var_126_14 = manager.ui.mainCamera.transform.position - var_126_9.position

				var_126_9.forward = Vector3.New(var_126_14.x, var_126_14.y, var_126_14.z)

				local var_126_15 = var_126_9.localEulerAngles

				var_126_15.z = 0
				var_126_15.x = 0
				var_126_9.localEulerAngles = var_126_15
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 then
				var_126_9.localPosition = Vector3.New(0, 100, 0)

				local var_126_16 = manager.ui.mainCamera.transform.position - var_126_9.position

				var_126_9.forward = Vector3.New(var_126_16.x, var_126_16.y, var_126_16.z)

				local var_126_17 = var_126_9.localEulerAngles

				var_126_17.z = 0
				var_126_17.x = 0
				var_126_9.localEulerAngles = var_126_17
			end

			local var_126_18 = 0
			local var_126_19 = 1.45

			if var_126_18 < arg_123_1.time_ and arg_123_1.time_ <= var_126_18 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_20 = arg_123_1:GetWordFromCfg(322221030)
				local var_126_21 = arg_123_1:FormatText(var_126_20.content)

				arg_123_1.text_.text = var_126_21

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_22 = 58
				local var_126_23 = utf8.len(var_126_21)
				local var_126_24 = var_126_22 <= 0 and var_126_19 or var_126_19 * (var_126_23 / var_126_22)

				if var_126_24 > 0 and var_126_19 < var_126_24 then
					arg_123_1.talkMaxDuration = var_126_24

					if var_126_24 + var_126_18 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_24 + var_126_18
					end
				end

				arg_123_1.text_.text = var_126_21
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_25 = math.max(var_126_19, arg_123_1.talkMaxDuration)

			if var_126_18 <= arg_123_1.time_ and arg_123_1.time_ < var_126_18 + var_126_25 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_18) / var_126_25

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_18 + var_126_25 and arg_123_1.time_ < var_126_18 + var_126_25 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play322221031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322221031
		arg_127_1.duration_ = 4.53

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play322221032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 1

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				local var_130_1 = manager.ui.mainCamera.transform.localPosition
				local var_130_2 = Vector3.New(0, 0, 10) + Vector3.New(var_130_1.x, var_130_1.y, 0)
				local var_130_3 = arg_127_1.bgs_.STblack

				var_130_3.transform.localPosition = var_130_2
				var_130_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_4 = var_130_3:GetComponent("SpriteRenderer")

				if var_130_4 and var_130_4.sprite then
					local var_130_5 = (var_130_3.transform.localPosition - var_130_1).z
					local var_130_6 = manager.ui.mainCameraCom_
					local var_130_7 = 2 * var_130_5 * Mathf.Tan(var_130_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_130_8 = var_130_7 * var_130_6.aspect
					local var_130_9 = var_130_4.sprite.bounds.size.x
					local var_130_10 = var_130_4.sprite.bounds.size.y
					local var_130_11 = var_130_8 / var_130_9
					local var_130_12 = var_130_7 / var_130_10
					local var_130_13 = var_130_12 < var_130_11 and var_130_11 or var_130_12

					var_130_3.transform.localScale = Vector3.New(var_130_13, var_130_13, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "STblack" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_14 = 2

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			local var_130_15 = 1.2

			if arg_127_1.time_ >= var_130_14 + var_130_15 and arg_127_1.time_ < var_130_14 + var_130_15 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_17 = 1

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_17 then
				local var_130_18 = (arg_127_1.time_ - var_130_16) / var_130_17
				local var_130_19 = Color.New(0, 0, 0)

				var_130_19.a = Mathf.Lerp(0, 1, var_130_18)
				arg_127_1.mask_.color = var_130_19
			end

			if arg_127_1.time_ >= var_130_16 + var_130_17 and arg_127_1.time_ < var_130_16 + var_130_17 + arg_130_0 then
				local var_130_20 = Color.New(0, 0, 0)

				var_130_20.a = 1
				arg_127_1.mask_.color = var_130_20
			end

			local var_130_21 = 1

			if var_130_21 < arg_127_1.time_ and arg_127_1.time_ <= var_130_21 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_22 = 1

			if var_130_21 <= arg_127_1.time_ and arg_127_1.time_ < var_130_21 + var_130_22 then
				local var_130_23 = (arg_127_1.time_ - var_130_21) / var_130_22
				local var_130_24 = Color.New(0, 0, 0)

				var_130_24.a = Mathf.Lerp(1, 0, var_130_23)
				arg_127_1.mask_.color = var_130_24
			end

			if arg_127_1.time_ >= var_130_21 + var_130_22 and arg_127_1.time_ < var_130_21 + var_130_22 + arg_130_0 then
				local var_130_25 = Color.New(0, 0, 0)
				local var_130_26 = 0

				arg_127_1.mask_.enabled = false
				var_130_25.a = var_130_26
				arg_127_1.mask_.color = var_130_25
			end

			local var_130_27 = manager.ui.mainCamera.transform
			local var_130_28 = 1

			if var_130_28 < arg_127_1.time_ and arg_127_1.time_ <= var_130_28 + arg_130_0 then
				local var_130_29 = arg_127_1.var_.effect1031
				local var_130_30
				local var_130_31 = var_130_27

				if not var_130_29 then
					var_130_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_soundonly_keep"), var_130_31)
					var_130_29.name = "1031"
					arg_127_1.var_.effect1031 = var_130_29
				else
					var_130_29.transform:SetParent(var_130_31)
				end

				var_130_29.transform.localPosition = Vector3.New(0, 0, 8.15)
				var_130_29.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 102,
				charCount = 0,
				enableLayoutChange = true,
				duration = 0.333333333333333,
				groupID = "103111",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 90,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
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
				contentID = 322221031,
				charCount = 48,
				enableLayoutChange = true,
				duration = 3.2,
				groupID = "10311",
				startTime = 1.33333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 90,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play322221032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322221032
		arg_131_1.duration_ = 2.8

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play322221033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			return
		end

		arg_131_1.nodeConfigList_ = {
			{
				groupID = "10311",
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
				contentID = 322221032,
				charCount = 42,
				enableLayoutChange = true,
				duration = 2.8,
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play322221033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322221033
		arg_135_1.duration_ = 4

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play322221034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			return
		end

		arg_135_1.nodeConfigList_ = {
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
				contentID = 322221033,
				charCount = 60,
				enableLayoutChange = true,
				duration = 4,
				groupID = "1033",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 348,
					leftPadding = 287,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play322221034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322221034
		arg_139_1.duration_ = 3.47

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play322221035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			return
		end

		arg_139_1.nodeConfigList_ = {
			{
				groupID = "1033",
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
				contentID = 322221034,
				charCount = 52,
				enableLayoutChange = true,
				duration = 3.46666666666667,
				groupID = "1034",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play322221035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322221035
		arg_143_1.duration_ = 3.73

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play322221036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			return
		end

		arg_143_1.nodeConfigList_ = {
			{
				groupID = "1034",
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
				contentID = 322221035,
				charCount = 56,
				enableLayoutChange = true,
				duration = 3.73333333333333,
				groupID = "1035",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play322221036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 322221036
		arg_147_1.duration_ = 2.27

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play322221037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			return
		end

		arg_147_1.nodeConfigList_ = {
			{
				groupID = "1035",
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
				contentID = 322221036,
				charCount = 34,
				enableLayoutChange = true,
				duration = 2.26666666666667,
				groupID = "1036",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play322221037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 322221037
		arg_151_1.duration_ = 3.73

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play322221038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			return
		end

		arg_151_1.nodeConfigList_ = {
			{
				groupID = "1036",
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
				contentID = 322221037,
				charCount = 56,
				enableLayoutChange = true,
				duration = 3.73333333333333,
				groupID = "1037",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play322221038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322221038
		arg_155_1.duration_ = 3.53

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play322221039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			return
		end

		arg_155_1.nodeConfigList_ = {
			{
				groupID = "1037",
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
				contentID = 322221038,
				charCount = 53,
				enableLayoutChange = true,
				duration = 3.53333333333333,
				groupID = "1038",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play322221039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322221039
		arg_159_1.duration_ = 3.6

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play322221040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			return
		end

		arg_159_1.nodeConfigList_ = {
			{
				groupID = "1038",
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
				contentID = 322221039,
				charCount = 54,
				enableLayoutChange = true,
				duration = 3.6,
				groupID = "1039",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play322221040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 322221040
		arg_163_1.duration_ = 3.2

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play322221041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			return
		end

		arg_163_1.nodeConfigList_ = {
			{
				groupID = "1039",
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
				contentID = 322221040,
				charCount = 48,
				enableLayoutChange = true,
				duration = 3.2,
				groupID = "1040",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play322221041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322221041
		arg_167_1.duration_ = 3.2

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play322221042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			return
		end

		arg_167_1.nodeConfigList_ = {
			{
				groupID = "1040",
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
				contentID = 322221041,
				charCount = 48,
				enableLayoutChange = true,
				duration = 3.2,
				groupID = "1041",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play322221042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322221042
		arg_171_1.duration_ = 1

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play322221043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			return
		end

		arg_171_1.nodeConfigList_ = {
			{
				groupID = "1041",
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
				contentID = 322221042,
				charCount = 15,
				enableLayoutChange = true,
				duration = 1,
				groupID = "1042",
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
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play322221043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322221043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play322221044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 1

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				local var_178_1 = manager.ui.mainCamera.transform.localPosition
				local var_178_2 = Vector3.New(0, 0, 10) + Vector3.New(var_178_1.x, var_178_1.y, 0)
				local var_178_3 = arg_175_1.bgs_.L09f

				var_178_3.transform.localPosition = var_178_2
				var_178_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_4 = var_178_3:GetComponent("SpriteRenderer")

				if var_178_4 and var_178_4.sprite then
					local var_178_5 = (var_178_3.transform.localPosition - var_178_1).z
					local var_178_6 = manager.ui.mainCameraCom_
					local var_178_7 = 2 * var_178_5 * Mathf.Tan(var_178_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_8 = var_178_7 * var_178_6.aspect
					local var_178_9 = var_178_4.sprite.bounds.size.x
					local var_178_10 = var_178_4.sprite.bounds.size.y
					local var_178_11 = var_178_8 / var_178_9
					local var_178_12 = var_178_7 / var_178_10
					local var_178_13 = var_178_12 < var_178_11 and var_178_11 or var_178_12

					var_178_3.transform.localScale = Vector3.New(var_178_13, var_178_13, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "L09f" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_14 = 3

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_15 = 0.3

			if arg_175_1.time_ >= var_178_14 + var_178_15 and arg_175_1.time_ < var_178_14 + var_178_15 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_17 = 1

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 then
				local var_178_18 = (arg_175_1.time_ - var_178_16) / var_178_17
				local var_178_19 = Color.New(0, 0, 0)

				var_178_19.a = Mathf.Lerp(0, 1, var_178_18)
				arg_175_1.mask_.color = var_178_19
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				local var_178_20 = Color.New(0, 0, 0)

				var_178_20.a = 1
				arg_175_1.mask_.color = var_178_20
			end

			local var_178_21 = 1

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_22 = 2.03400000184774

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_22 then
				local var_178_23 = (arg_175_1.time_ - var_178_21) / var_178_22
				local var_178_24 = Color.New(0, 0, 0)

				var_178_24.a = Mathf.Lerp(1, 0, var_178_23)
				arg_175_1.mask_.color = var_178_24
			end

			if arg_175_1.time_ >= var_178_21 + var_178_22 and arg_175_1.time_ < var_178_21 + var_178_22 + arg_178_0 then
				local var_178_25 = Color.New(0, 0, 0)
				local var_178_26 = 0

				arg_175_1.mask_.enabled = false
				var_178_25.a = var_178_26
				arg_175_1.mask_.color = var_178_25
			end

			local var_178_27 = arg_175_1.actors_["1111ui_story"].transform
			local var_178_28 = 3

			if var_178_28 < arg_175_1.time_ and arg_175_1.time_ <= var_178_28 + arg_178_0 then
				arg_175_1.var_.moveOldPos1111ui_story = var_178_27.localPosition
			end

			local var_178_29 = 0.001

			if var_178_28 <= arg_175_1.time_ and arg_175_1.time_ < var_178_28 + var_178_29 then
				local var_178_30 = (arg_175_1.time_ - var_178_28) / var_178_29
				local var_178_31 = Vector3.New(0, -0.87, -5.7)

				var_178_27.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1111ui_story, var_178_31, var_178_30)

				local var_178_32 = manager.ui.mainCamera.transform.position - var_178_27.position

				var_178_27.forward = Vector3.New(var_178_32.x, var_178_32.y, var_178_32.z)

				local var_178_33 = var_178_27.localEulerAngles

				var_178_33.z = 0
				var_178_33.x = 0
				var_178_27.localEulerAngles = var_178_33
			end

			if arg_175_1.time_ >= var_178_28 + var_178_29 and arg_175_1.time_ < var_178_28 + var_178_29 + arg_178_0 then
				var_178_27.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_178_34 = manager.ui.mainCamera.transform.position - var_178_27.position

				var_178_27.forward = Vector3.New(var_178_34.x, var_178_34.y, var_178_34.z)

				local var_178_35 = var_178_27.localEulerAngles

				var_178_35.z = 0
				var_178_35.x = 0
				var_178_27.localEulerAngles = var_178_35
			end

			local var_178_36 = arg_175_1.actors_["1111ui_story"]
			local var_178_37 = 3

			if var_178_37 < arg_175_1.time_ and arg_175_1.time_ <= var_178_37 + arg_178_0 and not isNil(var_178_36) and arg_175_1.var_.characterEffect1111ui_story == nil then
				arg_175_1.var_.characterEffect1111ui_story = var_178_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_38 = 0.200000002980232

			if var_178_37 <= arg_175_1.time_ and arg_175_1.time_ < var_178_37 + var_178_38 and not isNil(var_178_36) then
				local var_178_39 = (arg_175_1.time_ - var_178_37) / var_178_38

				if arg_175_1.var_.characterEffect1111ui_story and not isNil(var_178_36) then
					arg_175_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_37 + var_178_38 and arg_175_1.time_ < var_178_37 + var_178_38 + arg_178_0 and not isNil(var_178_36) and arg_175_1.var_.characterEffect1111ui_story then
				arg_175_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_178_40 = 3

			if var_178_40 < arg_175_1.time_ and arg_175_1.time_ <= var_178_40 + arg_178_0 then
				arg_175_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_178_41 = 3

			if var_178_41 < arg_175_1.time_ and arg_175_1.time_ <= var_178_41 + arg_178_0 then
				arg_175_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_178_42 = manager.ui.mainCamera.transform
			local var_178_43 = 0.983333333333333

			if var_178_43 < arg_175_1.time_ and arg_175_1.time_ <= var_178_43 + arg_178_0 then
				local var_178_44 = arg_175_1.var_.effect1031

				if var_178_44 then
					Object.Destroy(var_178_44)

					arg_175_1.var_.effect1031 = nil
				end
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_45 = 3
			local var_178_46 = 0.05

			if var_178_45 < arg_175_1.time_ and arg_175_1.time_ <= var_178_45 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_47 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_47:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_48 = arg_175_1:FormatText(StoryNameCfg[67].name)

				arg_175_1.leftNameTxt_.text = var_178_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_49 = arg_175_1:GetWordFromCfg(322221043)
				local var_178_50 = arg_175_1:FormatText(var_178_49.content)

				arg_175_1.text_.text = var_178_50

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_51 = 2
				local var_178_52 = utf8.len(var_178_50)
				local var_178_53 = var_178_51 <= 0 and var_178_46 or var_178_46 * (var_178_52 / var_178_51)

				if var_178_53 > 0 and var_178_46 < var_178_53 then
					arg_175_1.talkMaxDuration = var_178_53
					var_178_45 = var_178_45 + 0.3

					if var_178_53 + var_178_45 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_53 + var_178_45
					end
				end

				arg_175_1.text_.text = var_178_50
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221043", "story_v_out_322221.awb") ~= 0 then
					local var_178_54 = manager.audio:GetVoiceLength("story_v_out_322221", "322221043", "story_v_out_322221.awb") / 1000

					if var_178_54 + var_178_45 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_54 + var_178_45
					end

					if var_178_49.prefab_name ~= "" and arg_175_1.actors_[var_178_49.prefab_name] ~= nil then
						local var_178_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_49.prefab_name].transform, "story_v_out_322221", "322221043", "story_v_out_322221.awb")

						arg_175_1:RecordAudio("322221043", var_178_55)
						arg_175_1:RecordAudio("322221043", var_178_55)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_322221", "322221043", "story_v_out_322221.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_322221", "322221043", "story_v_out_322221.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_56 = var_178_45 + 0.3
			local var_178_57 = math.max(var_178_46, arg_175_1.talkMaxDuration)

			if var_178_56 <= arg_175_1.time_ and arg_175_1.time_ < var_178_56 + var_178_57 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_56) / var_178_57

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_56 + var_178_57 and arg_175_1.time_ < var_178_56 + var_178_57 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "1042",
				duration = 0.0166666666666668,
				className = "StoryTextGroupNode",
				startTime = 0.983333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play322221044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 322221044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play322221045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1111ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1111ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, 100, 0)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1111ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, 100, 0)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = 0
			local var_184_10 = 0.825

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_11 = arg_181_1:GetWordFromCfg(322221044)
				local var_184_12 = arg_181_1:FormatText(var_184_11.content)

				arg_181_1.text_.text = var_184_12

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 33
				local var_184_14 = utf8.len(var_184_12)
				local var_184_15 = var_184_13 <= 0 and var_184_10 or var_184_10 * (var_184_14 / var_184_13)

				if var_184_15 > 0 and var_184_10 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_9 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_9
					end
				end

				arg_181_1.text_.text = var_184_12
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_10, arg_181_1.talkMaxDuration)

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_9) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_9 + var_184_16 and arg_181_1.time_ < var_184_9 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play322221045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 322221045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play322221046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.1
			local var_188_1 = 1

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				local var_188_2 = "play"
				local var_188_3 = "effect"

				arg_185_1:AudioAction(var_188_2, var_188_3, "se_story_120_00", "se_story_120_00_rock", "")
			end

			local var_188_4 = 0
			local var_188_5 = 1.35

			if var_188_4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(322221045)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_8 = 54
				local var_188_9 = utf8.len(var_188_7)
				local var_188_10 = var_188_8 <= 0 and var_188_5 or var_188_5 * (var_188_9 / var_188_8)

				if var_188_10 > 0 and var_188_5 < var_188_10 then
					arg_185_1.talkMaxDuration = var_188_10

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_11 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_11 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_11

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_11 and arg_185_1.time_ < var_188_4 + var_188_11 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play322221046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 322221046
		arg_189_1.duration_ = 3.7

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play322221047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10131ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10131ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0.05, -0.96, -5.8)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10131ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["10131ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect10131ui_story == nil then
				arg_189_1.var_.characterEffect10131ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect10131ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect10131ui_story then
				arg_189_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_192_13 = 0

			if var_192_13 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_192_15 = 0
			local var_192_16 = 0.425

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[1366].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(322221046)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 17
				local var_192_21 = utf8.len(var_192_19)
				local var_192_22 = var_192_20 <= 0 and var_192_16 or var_192_16 * (var_192_21 / var_192_20)

				if var_192_22 > 0 and var_192_16 < var_192_22 then
					arg_189_1.talkMaxDuration = var_192_22

					if var_192_22 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221046", "story_v_out_322221.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_322221", "322221046", "story_v_out_322221.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_322221", "322221046", "story_v_out_322221.awb")

						arg_189_1:RecordAudio("322221046", var_192_24)
						arg_189_1:RecordAudio("322221046", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_322221", "322221046", "story_v_out_322221.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_322221", "322221046", "story_v_out_322221.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_25 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_25 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_25

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_25 and arg_189_1.time_ < var_192_15 + var_192_25 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play322221047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 322221047
		arg_193_1.duration_ = 4.17

		local var_193_0 = {
			zh = 3.8,
			ja = 4.166
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
				arg_193_0:Play322221048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1111ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1111ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, -0.87, -5.7)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1111ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["1111ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1111ui_story == nil then
				arg_193_1.var_.characterEffect1111ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect1111ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1111ui_story then
				arg_193_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_196_13 = arg_193_1.actors_["10131ui_story"]
			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 and not isNil(var_196_13) and arg_193_1.var_.characterEffect10131ui_story == nil then
				arg_193_1.var_.characterEffect10131ui_story = var_196_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_15 = 0.200000002980232

			if var_196_14 <= arg_193_1.time_ and arg_193_1.time_ < var_196_14 + var_196_15 and not isNil(var_196_13) then
				local var_196_16 = (arg_193_1.time_ - var_196_14) / var_196_15

				if arg_193_1.var_.characterEffect10131ui_story and not isNil(var_196_13) then
					local var_196_17 = Mathf.Lerp(0, 0.5, var_196_16)

					arg_193_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10131ui_story.fillRatio = var_196_17
				end
			end

			if arg_193_1.time_ >= var_196_14 + var_196_15 and arg_193_1.time_ < var_196_14 + var_196_15 + arg_196_0 and not isNil(var_196_13) and arg_193_1.var_.characterEffect10131ui_story then
				local var_196_18 = 0.5

				arg_193_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10131ui_story.fillRatio = var_196_18
			end

			local var_196_19 = 0

			if var_196_19 < arg_193_1.time_ and arg_193_1.time_ <= var_196_19 + arg_196_0 then
				arg_193_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_196_20 = 0

			if var_196_20 < arg_193_1.time_ and arg_193_1.time_ <= var_196_20 + arg_196_0 then
				arg_193_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_196_21 = arg_193_1.actors_["10131ui_story"].transform
			local var_196_22 = 0

			if var_196_22 < arg_193_1.time_ and arg_193_1.time_ <= var_196_22 + arg_196_0 then
				arg_193_1.var_.moveOldPos10131ui_story = var_196_21.localPosition
			end

			local var_196_23 = 0.001

			if var_196_22 <= arg_193_1.time_ and arg_193_1.time_ < var_196_22 + var_196_23 then
				local var_196_24 = (arg_193_1.time_ - var_196_22) / var_196_23
				local var_196_25 = Vector3.New(0, 100, 0)

				var_196_21.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10131ui_story, var_196_25, var_196_24)

				local var_196_26 = manager.ui.mainCamera.transform.position - var_196_21.position

				var_196_21.forward = Vector3.New(var_196_26.x, var_196_26.y, var_196_26.z)

				local var_196_27 = var_196_21.localEulerAngles

				var_196_27.z = 0
				var_196_27.x = 0
				var_196_21.localEulerAngles = var_196_27
			end

			if arg_193_1.time_ >= var_196_22 + var_196_23 and arg_193_1.time_ < var_196_22 + var_196_23 + arg_196_0 then
				var_196_21.localPosition = Vector3.New(0, 100, 0)

				local var_196_28 = manager.ui.mainCamera.transform.position - var_196_21.position

				var_196_21.forward = Vector3.New(var_196_28.x, var_196_28.y, var_196_28.z)

				local var_196_29 = var_196_21.localEulerAngles

				var_196_29.z = 0
				var_196_29.x = 0
				var_196_21.localEulerAngles = var_196_29
			end

			local var_196_30 = 0
			local var_196_31 = 0.35

			if var_196_30 < arg_193_1.time_ and arg_193_1.time_ <= var_196_30 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_32 = arg_193_1:FormatText(StoryNameCfg[67].name)

				arg_193_1.leftNameTxt_.text = var_196_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_33 = arg_193_1:GetWordFromCfg(322221047)
				local var_196_34 = arg_193_1:FormatText(var_196_33.content)

				arg_193_1.text_.text = var_196_34

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_35 = 14
				local var_196_36 = utf8.len(var_196_34)
				local var_196_37 = var_196_35 <= 0 and var_196_31 or var_196_31 * (var_196_36 / var_196_35)

				if var_196_37 > 0 and var_196_31 < var_196_37 then
					arg_193_1.talkMaxDuration = var_196_37

					if var_196_37 + var_196_30 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_37 + var_196_30
					end
				end

				arg_193_1.text_.text = var_196_34
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221047", "story_v_out_322221.awb") ~= 0 then
					local var_196_38 = manager.audio:GetVoiceLength("story_v_out_322221", "322221047", "story_v_out_322221.awb") / 1000

					if var_196_38 + var_196_30 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_38 + var_196_30
					end

					if var_196_33.prefab_name ~= "" and arg_193_1.actors_[var_196_33.prefab_name] ~= nil then
						local var_196_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_33.prefab_name].transform, "story_v_out_322221", "322221047", "story_v_out_322221.awb")

						arg_193_1:RecordAudio("322221047", var_196_39)
						arg_193_1:RecordAudio("322221047", var_196_39)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_322221", "322221047", "story_v_out_322221.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_322221", "322221047", "story_v_out_322221.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_40 = math.max(var_196_31, arg_193_1.talkMaxDuration)

			if var_196_30 <= arg_193_1.time_ and arg_193_1.time_ < var_196_30 + var_196_40 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_30) / var_196_40

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_30 + var_196_40 and arg_193_1.time_ < var_196_30 + var_196_40 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play322221048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 322221048
		arg_197_1.duration_ = 9.27

		local var_197_0 = {
			zh = 5.366,
			ja = 9.266
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
				arg_197_0:Play322221049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1111ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1111ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1111ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["10131ui_story"].transform
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 then
				arg_197_1.var_.moveOldPos10131ui_story = var_200_9.localPosition
			end

			local var_200_11 = 0.001

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11
				local var_200_13 = Vector3.New(0.83, -0.96, -5.8)

				var_200_9.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10131ui_story, var_200_13, var_200_12)

				local var_200_14 = manager.ui.mainCamera.transform.position - var_200_9.position

				var_200_9.forward = Vector3.New(var_200_14.x, var_200_14.y, var_200_14.z)

				local var_200_15 = var_200_9.localEulerAngles

				var_200_15.z = 0
				var_200_15.x = 0
				var_200_9.localEulerAngles = var_200_15
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 then
				var_200_9.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_200_16 = manager.ui.mainCamera.transform.position - var_200_9.position

				var_200_9.forward = Vector3.New(var_200_16.x, var_200_16.y, var_200_16.z)

				local var_200_17 = var_200_9.localEulerAngles

				var_200_17.z = 0
				var_200_17.x = 0
				var_200_9.localEulerAngles = var_200_17
			end

			local var_200_18 = arg_197_1.actors_["10131ui_story"]
			local var_200_19 = 0

			if var_200_19 < arg_197_1.time_ and arg_197_1.time_ <= var_200_19 + arg_200_0 and not isNil(var_200_18) and arg_197_1.var_.characterEffect10131ui_story == nil then
				arg_197_1.var_.characterEffect10131ui_story = var_200_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_20 = 0.200000002980232

			if var_200_19 <= arg_197_1.time_ and arg_197_1.time_ < var_200_19 + var_200_20 and not isNil(var_200_18) then
				local var_200_21 = (arg_197_1.time_ - var_200_19) / var_200_20

				if arg_197_1.var_.characterEffect10131ui_story and not isNil(var_200_18) then
					arg_197_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_19 + var_200_20 and arg_197_1.time_ < var_200_19 + var_200_20 + arg_200_0 and not isNil(var_200_18) and arg_197_1.var_.characterEffect10131ui_story then
				arg_197_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_200_22 = arg_197_1.actors_["1111ui_story"]
			local var_200_23 = 0

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 and not isNil(var_200_22) and arg_197_1.var_.characterEffect1111ui_story == nil then
				arg_197_1.var_.characterEffect1111ui_story = var_200_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_24 = 0.200000002980232

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_24 and not isNil(var_200_22) then
				local var_200_25 = (arg_197_1.time_ - var_200_23) / var_200_24

				if arg_197_1.var_.characterEffect1111ui_story and not isNil(var_200_22) then
					local var_200_26 = Mathf.Lerp(0, 0.5, var_200_25)

					arg_197_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1111ui_story.fillRatio = var_200_26
				end
			end

			if arg_197_1.time_ >= var_200_23 + var_200_24 and arg_197_1.time_ < var_200_23 + var_200_24 + arg_200_0 and not isNil(var_200_22) and arg_197_1.var_.characterEffect1111ui_story then
				local var_200_27 = 0.5

				arg_197_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1111ui_story.fillRatio = var_200_27
			end

			local var_200_28 = 0

			if var_200_28 < arg_197_1.time_ and arg_197_1.time_ <= var_200_28 + arg_200_0 then
				arg_197_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_1")
			end

			local var_200_29 = 0
			local var_200_30 = 0.55

			if var_200_29 < arg_197_1.time_ and arg_197_1.time_ <= var_200_29 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_31 = arg_197_1:FormatText(StoryNameCfg[1366].name)

				arg_197_1.leftNameTxt_.text = var_200_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_32 = arg_197_1:GetWordFromCfg(322221048)
				local var_200_33 = arg_197_1:FormatText(var_200_32.content)

				arg_197_1.text_.text = var_200_33

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_34 = 22
				local var_200_35 = utf8.len(var_200_33)
				local var_200_36 = var_200_34 <= 0 and var_200_30 or var_200_30 * (var_200_35 / var_200_34)

				if var_200_36 > 0 and var_200_30 < var_200_36 then
					arg_197_1.talkMaxDuration = var_200_36

					if var_200_36 + var_200_29 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_36 + var_200_29
					end
				end

				arg_197_1.text_.text = var_200_33
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221048", "story_v_out_322221.awb") ~= 0 then
					local var_200_37 = manager.audio:GetVoiceLength("story_v_out_322221", "322221048", "story_v_out_322221.awb") / 1000

					if var_200_37 + var_200_29 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_37 + var_200_29
					end

					if var_200_32.prefab_name ~= "" and arg_197_1.actors_[var_200_32.prefab_name] ~= nil then
						local var_200_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_32.prefab_name].transform, "story_v_out_322221", "322221048", "story_v_out_322221.awb")

						arg_197_1:RecordAudio("322221048", var_200_38)
						arg_197_1:RecordAudio("322221048", var_200_38)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_322221", "322221048", "story_v_out_322221.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_322221", "322221048", "story_v_out_322221.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_39 = math.max(var_200_30, arg_197_1.talkMaxDuration)

			if var_200_29 <= arg_197_1.time_ and arg_197_1.time_ < var_200_29 + var_200_39 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_29) / var_200_39

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_29 + var_200_39 and arg_197_1.time_ < var_200_29 + var_200_39 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play322221049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 322221049
		arg_201_1.duration_ = 10.87

		local var_201_0 = {
			zh = 5.033,
			ja = 10.866
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
				arg_201_0:Play322221050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1111ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1111ui_story == nil then
				arg_201_1.var_.characterEffect1111ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1111ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1111ui_story then
				arg_201_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["10131ui_story"]
			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect10131ui_story == nil then
				arg_201_1.var_.characterEffect10131ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_6 = 0.200000002980232

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 and not isNil(var_204_4) then
				local var_204_7 = (arg_201_1.time_ - var_204_5) / var_204_6

				if arg_201_1.var_.characterEffect10131ui_story and not isNil(var_204_4) then
					local var_204_8 = Mathf.Lerp(0, 0.5, var_204_7)

					arg_201_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10131ui_story.fillRatio = var_204_8
				end
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect10131ui_story then
				local var_204_9 = 0.5

				arg_201_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10131ui_story.fillRatio = var_204_9
			end

			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_204_11 = 0
			local var_204_12 = 0.525

			if var_204_11 < arg_201_1.time_ and arg_201_1.time_ <= var_204_11 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_13 = arg_201_1:FormatText(StoryNameCfg[67].name)

				arg_201_1.leftNameTxt_.text = var_204_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_14 = arg_201_1:GetWordFromCfg(322221049)
				local var_204_15 = arg_201_1:FormatText(var_204_14.content)

				arg_201_1.text_.text = var_204_15

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_16 = 21
				local var_204_17 = utf8.len(var_204_15)
				local var_204_18 = var_204_16 <= 0 and var_204_12 or var_204_12 * (var_204_17 / var_204_16)

				if var_204_18 > 0 and var_204_12 < var_204_18 then
					arg_201_1.talkMaxDuration = var_204_18

					if var_204_18 + var_204_11 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_18 + var_204_11
					end
				end

				arg_201_1.text_.text = var_204_15
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221049", "story_v_out_322221.awb") ~= 0 then
					local var_204_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221049", "story_v_out_322221.awb") / 1000

					if var_204_19 + var_204_11 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_19 + var_204_11
					end

					if var_204_14.prefab_name ~= "" and arg_201_1.actors_[var_204_14.prefab_name] ~= nil then
						local var_204_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_14.prefab_name].transform, "story_v_out_322221", "322221049", "story_v_out_322221.awb")

						arg_201_1:RecordAudio("322221049", var_204_20)
						arg_201_1:RecordAudio("322221049", var_204_20)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_322221", "322221049", "story_v_out_322221.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_322221", "322221049", "story_v_out_322221.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_21 = math.max(var_204_12, arg_201_1.talkMaxDuration)

			if var_204_11 <= arg_201_1.time_ and arg_201_1.time_ < var_204_11 + var_204_21 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_11) / var_204_21

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_11 + var_204_21 and arg_201_1.time_ < var_204_11 + var_204_21 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play322221050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 322221050
		arg_205_1.duration_ = 8.97

		local var_205_0 = {
			zh = 8.733,
			ja = 8.966
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
				arg_205_0:Play322221051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.975

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[67].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(322221050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 39
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221050", "story_v_out_322221.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221050", "story_v_out_322221.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_322221", "322221050", "story_v_out_322221.awb")

						arg_205_1:RecordAudio("322221050", var_208_9)
						arg_205_1:RecordAudio("322221050", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_322221", "322221050", "story_v_out_322221.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_322221", "322221050", "story_v_out_322221.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play322221051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322221051
		arg_209_1.duration_ = 5.57

		local var_209_0 = {
			zh = 4.933,
			ja = 5.566
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
				arg_209_0:Play322221052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10131ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect10131ui_story == nil then
				arg_209_1.var_.characterEffect10131ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect10131ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect10131ui_story then
				arg_209_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.actors_["1111ui_story"]
			local var_212_5 = 0

			if var_212_5 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1111ui_story == nil then
				arg_209_1.var_.characterEffect1111ui_story = var_212_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_6 = 0.200000002980232

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_6 and not isNil(var_212_4) then
				local var_212_7 = (arg_209_1.time_ - var_212_5) / var_212_6

				if arg_209_1.var_.characterEffect1111ui_story and not isNil(var_212_4) then
					local var_212_8 = Mathf.Lerp(0, 0.5, var_212_7)

					arg_209_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1111ui_story.fillRatio = var_212_8
				end
			end

			if arg_209_1.time_ >= var_212_5 + var_212_6 and arg_209_1.time_ < var_212_5 + var_212_6 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1111ui_story then
				local var_212_9 = 0.5

				arg_209_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1111ui_story.fillRatio = var_212_9
			end

			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 then
				arg_209_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_2")
			end

			local var_212_11 = 0
			local var_212_12 = 0.375

			if var_212_11 < arg_209_1.time_ and arg_209_1.time_ <= var_212_11 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_13 = arg_209_1:FormatText(StoryNameCfg[1366].name)

				arg_209_1.leftNameTxt_.text = var_212_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_14 = arg_209_1:GetWordFromCfg(322221051)
				local var_212_15 = arg_209_1:FormatText(var_212_14.content)

				arg_209_1.text_.text = var_212_15

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_16 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221051", "story_v_out_322221.awb") ~= 0 then
					local var_212_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221051", "story_v_out_322221.awb") / 1000

					if var_212_19 + var_212_11 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_19 + var_212_11
					end

					if var_212_14.prefab_name ~= "" and arg_209_1.actors_[var_212_14.prefab_name] ~= nil then
						local var_212_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_14.prefab_name].transform, "story_v_out_322221", "322221051", "story_v_out_322221.awb")

						arg_209_1:RecordAudio("322221051", var_212_20)
						arg_209_1:RecordAudio("322221051", var_212_20)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_322221", "322221051", "story_v_out_322221.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_322221", "322221051", "story_v_out_322221.awb")
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
	Play322221052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322221052
		arg_213_1.duration_ = 4.23

		local var_213_0 = {
			zh = 2.466,
			ja = 4.233
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
				arg_213_0:Play322221053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1111ui_story"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1111ui_story == nil then
				arg_213_1.var_.characterEffect1111ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.characterEffect1111ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1111ui_story then
				arg_213_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_216_4 = arg_213_1.actors_["10131ui_story"]
			local var_216_5 = 0

			if var_216_5 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect10131ui_story == nil then
				arg_213_1.var_.characterEffect10131ui_story = var_216_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_6 = 0.200000002980232

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_6 and not isNil(var_216_4) then
				local var_216_7 = (arg_213_1.time_ - var_216_5) / var_216_6

				if arg_213_1.var_.characterEffect10131ui_story and not isNil(var_216_4) then
					local var_216_8 = Mathf.Lerp(0, 0.5, var_216_7)

					arg_213_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10131ui_story.fillRatio = var_216_8
				end
			end

			if arg_213_1.time_ >= var_216_5 + var_216_6 and arg_213_1.time_ < var_216_5 + var_216_6 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect10131ui_story then
				local var_216_9 = 0.5

				arg_213_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10131ui_story.fillRatio = var_216_9
			end

			local var_216_10 = 0
			local var_216_11 = 0.2

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_12 = arg_213_1:FormatText(StoryNameCfg[67].name)

				arg_213_1.leftNameTxt_.text = var_216_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_13 = arg_213_1:GetWordFromCfg(322221052)
				local var_216_14 = arg_213_1:FormatText(var_216_13.content)

				arg_213_1.text_.text = var_216_14

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_15 = 8
				local var_216_16 = utf8.len(var_216_14)
				local var_216_17 = var_216_15 <= 0 and var_216_11 or var_216_11 * (var_216_16 / var_216_15)

				if var_216_17 > 0 and var_216_11 < var_216_17 then
					arg_213_1.talkMaxDuration = var_216_17

					if var_216_17 + var_216_10 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_17 + var_216_10
					end
				end

				arg_213_1.text_.text = var_216_14
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221052", "story_v_out_322221.awb") ~= 0 then
					local var_216_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221052", "story_v_out_322221.awb") / 1000

					if var_216_18 + var_216_10 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_18 + var_216_10
					end

					if var_216_13.prefab_name ~= "" and arg_213_1.actors_[var_216_13.prefab_name] ~= nil then
						local var_216_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_13.prefab_name].transform, "story_v_out_322221", "322221052", "story_v_out_322221.awb")

						arg_213_1:RecordAudio("322221052", var_216_19)
						arg_213_1:RecordAudio("322221052", var_216_19)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_322221", "322221052", "story_v_out_322221.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_322221", "322221052", "story_v_out_322221.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_20 = math.max(var_216_11, arg_213_1.talkMaxDuration)

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_20 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_10) / var_216_20

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_10 + var_216_20 and arg_213_1.time_ < var_216_10 + var_216_20 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play322221053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322221053
		arg_217_1.duration_ = 14.3

		local var_217_0 = {
			zh = 9.633,
			ja = 14.3
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
				arg_217_0:Play322221054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10131ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10131ui_story == nil then
				arg_217_1.var_.characterEffect10131ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect10131ui_story and not isNil(var_220_0) then
					arg_217_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10131ui_story then
				arg_217_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_220_4 = arg_217_1.actors_["1111ui_story"]
			local var_220_5 = 0

			if var_220_5 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 and not isNil(var_220_4) and arg_217_1.var_.characterEffect1111ui_story == nil then
				arg_217_1.var_.characterEffect1111ui_story = var_220_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_6 = 0.200000002980232

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_6 and not isNil(var_220_4) then
				local var_220_7 = (arg_217_1.time_ - var_220_5) / var_220_6

				if arg_217_1.var_.characterEffect1111ui_story and not isNil(var_220_4) then
					local var_220_8 = Mathf.Lerp(0, 0.5, var_220_7)

					arg_217_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1111ui_story.fillRatio = var_220_8
				end
			end

			if arg_217_1.time_ >= var_220_5 + var_220_6 and arg_217_1.time_ < var_220_5 + var_220_6 + arg_220_0 and not isNil(var_220_4) and arg_217_1.var_.characterEffect1111ui_story then
				local var_220_9 = 0.5

				arg_217_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1111ui_story.fillRatio = var_220_9
			end

			local var_220_10 = 0
			local var_220_11 = 1.125

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_12 = arg_217_1:FormatText(StoryNameCfg[1366].name)

				arg_217_1.leftNameTxt_.text = var_220_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_13 = arg_217_1:GetWordFromCfg(322221053)
				local var_220_14 = arg_217_1:FormatText(var_220_13.content)

				arg_217_1.text_.text = var_220_14

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_15 = 45
				local var_220_16 = utf8.len(var_220_14)
				local var_220_17 = var_220_15 <= 0 and var_220_11 or var_220_11 * (var_220_16 / var_220_15)

				if var_220_17 > 0 and var_220_11 < var_220_17 then
					arg_217_1.talkMaxDuration = var_220_17

					if var_220_17 + var_220_10 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_17 + var_220_10
					end
				end

				arg_217_1.text_.text = var_220_14
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221053", "story_v_out_322221.awb") ~= 0 then
					local var_220_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221053", "story_v_out_322221.awb") / 1000

					if var_220_18 + var_220_10 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_18 + var_220_10
					end

					if var_220_13.prefab_name ~= "" and arg_217_1.actors_[var_220_13.prefab_name] ~= nil then
						local var_220_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_13.prefab_name].transform, "story_v_out_322221", "322221053", "story_v_out_322221.awb")

						arg_217_1:RecordAudio("322221053", var_220_19)
						arg_217_1:RecordAudio("322221053", var_220_19)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322221", "322221053", "story_v_out_322221.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322221", "322221053", "story_v_out_322221.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_20 = math.max(var_220_11, arg_217_1.talkMaxDuration)

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_20 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_10) / var_220_20

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_10 + var_220_20 and arg_217_1.time_ < var_220_10 + var_220_20 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play322221054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322221054
		arg_221_1.duration_ = 2.57

		local var_221_0 = {
			zh = 2.433,
			ja = 2.566
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
				arg_221_0:Play322221055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1111ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1111ui_story == nil then
				arg_221_1.var_.characterEffect1111ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1111ui_story and not isNil(var_224_0) then
					arg_221_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1111ui_story then
				arg_221_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_224_4 = arg_221_1.actors_["10131ui_story"]
			local var_224_5 = 0

			if var_224_5 < arg_221_1.time_ and arg_221_1.time_ <= var_224_5 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect10131ui_story == nil then
				arg_221_1.var_.characterEffect10131ui_story = var_224_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_6 = 0.200000002980232

			if var_224_5 <= arg_221_1.time_ and arg_221_1.time_ < var_224_5 + var_224_6 and not isNil(var_224_4) then
				local var_224_7 = (arg_221_1.time_ - var_224_5) / var_224_6

				if arg_221_1.var_.characterEffect10131ui_story and not isNil(var_224_4) then
					local var_224_8 = Mathf.Lerp(0, 0.5, var_224_7)

					arg_221_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10131ui_story.fillRatio = var_224_8
				end
			end

			if arg_221_1.time_ >= var_224_5 + var_224_6 and arg_221_1.time_ < var_224_5 + var_224_6 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect10131ui_story then
				local var_224_9 = 0.5

				arg_221_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10131ui_story.fillRatio = var_224_9
			end

			local var_224_10 = 0
			local var_224_11 = 0.275

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_12 = arg_221_1:FormatText(StoryNameCfg[67].name)

				arg_221_1.leftNameTxt_.text = var_224_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_13 = arg_221_1:GetWordFromCfg(322221054)
				local var_224_14 = arg_221_1:FormatText(var_224_13.content)

				arg_221_1.text_.text = var_224_14

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_15 = 11
				local var_224_16 = utf8.len(var_224_14)
				local var_224_17 = var_224_15 <= 0 and var_224_11 or var_224_11 * (var_224_16 / var_224_15)

				if var_224_17 > 0 and var_224_11 < var_224_17 then
					arg_221_1.talkMaxDuration = var_224_17

					if var_224_17 + var_224_10 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_17 + var_224_10
					end
				end

				arg_221_1.text_.text = var_224_14
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221054", "story_v_out_322221.awb") ~= 0 then
					local var_224_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221054", "story_v_out_322221.awb") / 1000

					if var_224_18 + var_224_10 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_18 + var_224_10
					end

					if var_224_13.prefab_name ~= "" and arg_221_1.actors_[var_224_13.prefab_name] ~= nil then
						local var_224_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_13.prefab_name].transform, "story_v_out_322221", "322221054", "story_v_out_322221.awb")

						arg_221_1:RecordAudio("322221054", var_224_19)
						arg_221_1:RecordAudio("322221054", var_224_19)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_322221", "322221054", "story_v_out_322221.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_322221", "322221054", "story_v_out_322221.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_20 = math.max(var_224_11, arg_221_1.talkMaxDuration)

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_20 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_10) / var_224_20

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_10 + var_224_20 and arg_221_1.time_ < var_224_10 + var_224_20 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play322221055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 322221055
		arg_225_1.duration_ = 13.7

		local var_225_0 = {
			zh = 5.366,
			ja = 13.7
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
				arg_225_0:Play322221056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_228_1 = 0
			local var_228_2 = 0.75

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_3 = arg_225_1:FormatText(StoryNameCfg[67].name)

				arg_225_1.leftNameTxt_.text = var_228_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_4 = arg_225_1:GetWordFromCfg(322221055)
				local var_228_5 = arg_225_1:FormatText(var_228_4.content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_6 = 30
				local var_228_7 = utf8.len(var_228_5)
				local var_228_8 = var_228_6 <= 0 and var_228_2 or var_228_2 * (var_228_7 / var_228_6)

				if var_228_8 > 0 and var_228_2 < var_228_8 then
					arg_225_1.talkMaxDuration = var_228_8

					if var_228_8 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221055", "story_v_out_322221.awb") ~= 0 then
					local var_228_9 = manager.audio:GetVoiceLength("story_v_out_322221", "322221055", "story_v_out_322221.awb") / 1000

					if var_228_9 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_1
					end

					if var_228_4.prefab_name ~= "" and arg_225_1.actors_[var_228_4.prefab_name] ~= nil then
						local var_228_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_4.prefab_name].transform, "story_v_out_322221", "322221055", "story_v_out_322221.awb")

						arg_225_1:RecordAudio("322221055", var_228_10)
						arg_225_1:RecordAudio("322221055", var_228_10)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_322221", "322221055", "story_v_out_322221.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_322221", "322221055", "story_v_out_322221.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_11 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_11 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_11

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_11 and arg_225_1.time_ < var_228_1 + var_228_11 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play322221056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 322221056
		arg_229_1.duration_ = 7.5

		local var_229_0 = {
			zh = 5.066,
			ja = 7.5
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
				arg_229_0:Play322221057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["10131ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10131ui_story == nil then
				arg_229_1.var_.characterEffect10131ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect10131ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect10131ui_story then
				arg_229_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_232_4 = arg_229_1.actors_["1111ui_story"]
			local var_232_5 = 0

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect1111ui_story == nil then
				arg_229_1.var_.characterEffect1111ui_story = var_232_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_6 = 0.200000002980232

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_6 and not isNil(var_232_4) then
				local var_232_7 = (arg_229_1.time_ - var_232_5) / var_232_6

				if arg_229_1.var_.characterEffect1111ui_story and not isNil(var_232_4) then
					local var_232_8 = Mathf.Lerp(0, 0.5, var_232_7)

					arg_229_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1111ui_story.fillRatio = var_232_8
				end
			end

			if arg_229_1.time_ >= var_232_5 + var_232_6 and arg_229_1.time_ < var_232_5 + var_232_6 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect1111ui_story then
				local var_232_9 = 0.5

				arg_229_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1111ui_story.fillRatio = var_232_9
			end

			local var_232_10 = 0
			local var_232_11 = 0.6

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_12 = arg_229_1:FormatText(StoryNameCfg[1366].name)

				arg_229_1.leftNameTxt_.text = var_232_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_13 = arg_229_1:GetWordFromCfg(322221056)
				local var_232_14 = arg_229_1:FormatText(var_232_13.content)

				arg_229_1.text_.text = var_232_14

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_15 = 24
				local var_232_16 = utf8.len(var_232_14)
				local var_232_17 = var_232_15 <= 0 and var_232_11 or var_232_11 * (var_232_16 / var_232_15)

				if var_232_17 > 0 and var_232_11 < var_232_17 then
					arg_229_1.talkMaxDuration = var_232_17

					if var_232_17 + var_232_10 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_17 + var_232_10
					end
				end

				arg_229_1.text_.text = var_232_14
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221056", "story_v_out_322221.awb") ~= 0 then
					local var_232_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221056", "story_v_out_322221.awb") / 1000

					if var_232_18 + var_232_10 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_18 + var_232_10
					end

					if var_232_13.prefab_name ~= "" and arg_229_1.actors_[var_232_13.prefab_name] ~= nil then
						local var_232_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_13.prefab_name].transform, "story_v_out_322221", "322221056", "story_v_out_322221.awb")

						arg_229_1:RecordAudio("322221056", var_232_19)
						arg_229_1:RecordAudio("322221056", var_232_19)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_322221", "322221056", "story_v_out_322221.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_322221", "322221056", "story_v_out_322221.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_20 = math.max(var_232_11, arg_229_1.talkMaxDuration)

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_20 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_10) / var_232_20

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_10 + var_232_20 and arg_229_1.time_ < var_232_10 + var_232_20 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play322221057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 322221057
		arg_233_1.duration_ = 4.63

		local var_233_0 = {
			zh = 3.866,
			ja = 4.633
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
				arg_233_0:Play322221058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1111ui_story"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1111ui_story == nil then
				arg_233_1.var_.characterEffect1111ui_story = var_236_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.characterEffect1111ui_story and not isNil(var_236_0) then
					arg_233_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.characterEffect1111ui_story then
				arg_233_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_236_4 = arg_233_1.actors_["10131ui_story"]
			local var_236_5 = 0

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect10131ui_story == nil then
				arg_233_1.var_.characterEffect10131ui_story = var_236_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.200000002980232

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 and not isNil(var_236_4) then
				local var_236_7 = (arg_233_1.time_ - var_236_5) / var_236_6

				if arg_233_1.var_.characterEffect10131ui_story and not isNil(var_236_4) then
					local var_236_8 = Mathf.Lerp(0, 0.5, var_236_7)

					arg_233_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_233_1.var_.characterEffect10131ui_story.fillRatio = var_236_8
				end
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect10131ui_story then
				local var_236_9 = 0.5

				arg_233_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_233_1.var_.characterEffect10131ui_story.fillRatio = var_236_9
			end

			local var_236_10 = 0
			local var_236_11 = 0.525

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_12 = arg_233_1:FormatText(StoryNameCfg[67].name)

				arg_233_1.leftNameTxt_.text = var_236_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_13 = arg_233_1:GetWordFromCfg(322221057)
				local var_236_14 = arg_233_1:FormatText(var_236_13.content)

				arg_233_1.text_.text = var_236_14

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_15 = 21
				local var_236_16 = utf8.len(var_236_14)
				local var_236_17 = var_236_15 <= 0 and var_236_11 or var_236_11 * (var_236_16 / var_236_15)

				if var_236_17 > 0 and var_236_11 < var_236_17 then
					arg_233_1.talkMaxDuration = var_236_17

					if var_236_17 + var_236_10 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_17 + var_236_10
					end
				end

				arg_233_1.text_.text = var_236_14
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221057", "story_v_out_322221.awb") ~= 0 then
					local var_236_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221057", "story_v_out_322221.awb") / 1000

					if var_236_18 + var_236_10 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_18 + var_236_10
					end

					if var_236_13.prefab_name ~= "" and arg_233_1.actors_[var_236_13.prefab_name] ~= nil then
						local var_236_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_13.prefab_name].transform, "story_v_out_322221", "322221057", "story_v_out_322221.awb")

						arg_233_1:RecordAudio("322221057", var_236_19)
						arg_233_1:RecordAudio("322221057", var_236_19)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_322221", "322221057", "story_v_out_322221.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_322221", "322221057", "story_v_out_322221.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_20 = math.max(var_236_11, arg_233_1.talkMaxDuration)

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_20 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_10) / var_236_20

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_10 + var_236_20 and arg_233_1.time_ < var_236_10 + var_236_20 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play322221058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 322221058
		arg_237_1.duration_ = 6.2

		local var_237_0 = {
			zh = 4.233,
			ja = 6.2
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
				arg_237_0:Play322221059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_240_1 = 0
			local var_240_2 = 0.4

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_3 = arg_237_1:FormatText(StoryNameCfg[67].name)

				arg_237_1.leftNameTxt_.text = var_240_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_4 = arg_237_1:GetWordFromCfg(322221058)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 16
				local var_240_7 = utf8.len(var_240_5)
				local var_240_8 = var_240_6 <= 0 and var_240_2 or var_240_2 * (var_240_7 / var_240_6)

				if var_240_8 > 0 and var_240_2 < var_240_8 then
					arg_237_1.talkMaxDuration = var_240_8

					if var_240_8 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221058", "story_v_out_322221.awb") ~= 0 then
					local var_240_9 = manager.audio:GetVoiceLength("story_v_out_322221", "322221058", "story_v_out_322221.awb") / 1000

					if var_240_9 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_1
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_out_322221", "322221058", "story_v_out_322221.awb")

						arg_237_1:RecordAudio("322221058", var_240_10)
						arg_237_1:RecordAudio("322221058", var_240_10)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_322221", "322221058", "story_v_out_322221.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_322221", "322221058", "story_v_out_322221.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_11 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_11 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_11

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_11 and arg_237_1.time_ < var_240_1 + var_240_11 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play322221059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 322221059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play322221060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1111ui_story"].transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.moveOldPos1111ui_story = var_244_0.localPosition
			end

			local var_244_2 = 0.001

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2
				local var_244_4 = Vector3.New(0, 100, 0)

				var_244_0.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1111ui_story, var_244_4, var_244_3)

				local var_244_5 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_5.x, var_244_5.y, var_244_5.z)

				local var_244_6 = var_244_0.localEulerAngles

				var_244_6.z = 0
				var_244_6.x = 0
				var_244_0.localEulerAngles = var_244_6
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = Vector3.New(0, 100, 0)

				local var_244_7 = manager.ui.mainCamera.transform.position - var_244_0.position

				var_244_0.forward = Vector3.New(var_244_7.x, var_244_7.y, var_244_7.z)

				local var_244_8 = var_244_0.localEulerAngles

				var_244_8.z = 0
				var_244_8.x = 0
				var_244_0.localEulerAngles = var_244_8
			end

			local var_244_9 = arg_241_1.actors_["10131ui_story"].transform
			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1.var_.moveOldPos10131ui_story = var_244_9.localPosition
			end

			local var_244_11 = 0.001

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_11 then
				local var_244_12 = (arg_241_1.time_ - var_244_10) / var_244_11
				local var_244_13 = Vector3.New(0, 100, 0)

				var_244_9.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10131ui_story, var_244_13, var_244_12)

				local var_244_14 = manager.ui.mainCamera.transform.position - var_244_9.position

				var_244_9.forward = Vector3.New(var_244_14.x, var_244_14.y, var_244_14.z)

				local var_244_15 = var_244_9.localEulerAngles

				var_244_15.z = 0
				var_244_15.x = 0
				var_244_9.localEulerAngles = var_244_15
			end

			if arg_241_1.time_ >= var_244_10 + var_244_11 and arg_241_1.time_ < var_244_10 + var_244_11 + arg_244_0 then
				var_244_9.localPosition = Vector3.New(0, 100, 0)

				local var_244_16 = manager.ui.mainCamera.transform.position - var_244_9.position

				var_244_9.forward = Vector3.New(var_244_16.x, var_244_16.y, var_244_16.z)

				local var_244_17 = var_244_9.localEulerAngles

				var_244_17.z = 0
				var_244_17.x = 0
				var_244_9.localEulerAngles = var_244_17
			end

			local var_244_18 = 0
			local var_244_19 = 1.45

			if var_244_18 < arg_241_1.time_ and arg_241_1.time_ <= var_244_18 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_20 = arg_241_1:GetWordFromCfg(322221059)
				local var_244_21 = arg_241_1:FormatText(var_244_20.content)

				arg_241_1.text_.text = var_244_21

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_22 = 58
				local var_244_23 = utf8.len(var_244_21)
				local var_244_24 = var_244_22 <= 0 and var_244_19 or var_244_19 * (var_244_23 / var_244_22)

				if var_244_24 > 0 and var_244_19 < var_244_24 then
					arg_241_1.talkMaxDuration = var_244_24

					if var_244_24 + var_244_18 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_24 + var_244_18
					end
				end

				arg_241_1.text_.text = var_244_21
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_25 = math.max(var_244_19, arg_241_1.talkMaxDuration)

			if var_244_18 <= arg_241_1.time_ and arg_241_1.time_ < var_244_18 + var_244_25 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_18) / var_244_25

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_18 + var_244_25 and arg_241_1.time_ < var_244_18 + var_244_25 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play322221060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 322221060
		arg_245_1.duration_ = 7.3

		local var_245_0 = {
			zh = 4.6,
			ja = 7.3
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
				arg_245_0:Play322221061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1111ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1111ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1111ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = arg_245_1.actors_["1111ui_story"]
			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1111ui_story == nil then
				arg_245_1.var_.characterEffect1111ui_story = var_248_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_11 = 0.200000002980232

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_11 and not isNil(var_248_9) then
				local var_248_12 = (arg_245_1.time_ - var_248_10) / var_248_11

				if arg_245_1.var_.characterEffect1111ui_story and not isNil(var_248_9) then
					arg_245_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_10 + var_248_11 and arg_245_1.time_ < var_248_10 + var_248_11 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1111ui_story then
				arg_245_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_248_13 = 0
			local var_248_14 = 0.45

			if var_248_13 < arg_245_1.time_ and arg_245_1.time_ <= var_248_13 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_15 = arg_245_1:FormatText(StoryNameCfg[67].name)

				arg_245_1.leftNameTxt_.text = var_248_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_16 = arg_245_1:GetWordFromCfg(322221060)
				local var_248_17 = arg_245_1:FormatText(var_248_16.content)

				arg_245_1.text_.text = var_248_17

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_18 = 18
				local var_248_19 = utf8.len(var_248_17)
				local var_248_20 = var_248_18 <= 0 and var_248_14 or var_248_14 * (var_248_19 / var_248_18)

				if var_248_20 > 0 and var_248_14 < var_248_20 then
					arg_245_1.talkMaxDuration = var_248_20

					if var_248_20 + var_248_13 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_20 + var_248_13
					end
				end

				arg_245_1.text_.text = var_248_17
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221060", "story_v_out_322221.awb") ~= 0 then
					local var_248_21 = manager.audio:GetVoiceLength("story_v_out_322221", "322221060", "story_v_out_322221.awb") / 1000

					if var_248_21 + var_248_13 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_21 + var_248_13
					end

					if var_248_16.prefab_name ~= "" and arg_245_1.actors_[var_248_16.prefab_name] ~= nil then
						local var_248_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_16.prefab_name].transform, "story_v_out_322221", "322221060", "story_v_out_322221.awb")

						arg_245_1:RecordAudio("322221060", var_248_22)
						arg_245_1:RecordAudio("322221060", var_248_22)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_322221", "322221060", "story_v_out_322221.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_322221", "322221060", "story_v_out_322221.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_23 = math.max(var_248_14, arg_245_1.talkMaxDuration)

			if var_248_13 <= arg_245_1.time_ and arg_245_1.time_ < var_248_13 + var_248_23 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_13) / var_248_23

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_13 + var_248_23 and arg_245_1.time_ < var_248_13 + var_248_23 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play322221061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322221061
		arg_249_1.duration_ = 1.77

		local var_249_0 = {
			zh = 1.333,
			ja = 1.766
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
				arg_249_0:Play322221062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10131ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos10131ui_story = var_252_0.localPosition
			end

			local var_252_2 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2
				local var_252_4 = Vector3.New(0.83, -0.96, -5.8)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10131ui_story, var_252_4, var_252_3)

				local var_252_5 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_5.x, var_252_5.y, var_252_5.z)

				local var_252_6 = var_252_0.localEulerAngles

				var_252_6.z = 0
				var_252_6.x = 0
				var_252_0.localEulerAngles = var_252_6
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_252_7 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_7.x, var_252_7.y, var_252_7.z)

				local var_252_8 = var_252_0.localEulerAngles

				var_252_8.z = 0
				var_252_8.x = 0
				var_252_0.localEulerAngles = var_252_8
			end

			local var_252_9 = arg_249_1.actors_["10131ui_story"]
			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect10131ui_story == nil then
				arg_249_1.var_.characterEffect10131ui_story = var_252_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_11 = 0.200000002980232

			if var_252_10 <= arg_249_1.time_ and arg_249_1.time_ < var_252_10 + var_252_11 and not isNil(var_252_9) then
				local var_252_12 = (arg_249_1.time_ - var_252_10) / var_252_11

				if arg_249_1.var_.characterEffect10131ui_story and not isNil(var_252_9) then
					arg_249_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_10 + var_252_11 and arg_249_1.time_ < var_252_10 + var_252_11 + arg_252_0 and not isNil(var_252_9) and arg_249_1.var_.characterEffect10131ui_story then
				arg_249_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_252_13 = arg_249_1.actors_["1111ui_story"]
			local var_252_14 = 0

			if var_252_14 < arg_249_1.time_ and arg_249_1.time_ <= var_252_14 + arg_252_0 and not isNil(var_252_13) and arg_249_1.var_.characterEffect1111ui_story == nil then
				arg_249_1.var_.characterEffect1111ui_story = var_252_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_15 = 0.200000002980232

			if var_252_14 <= arg_249_1.time_ and arg_249_1.time_ < var_252_14 + var_252_15 and not isNil(var_252_13) then
				local var_252_16 = (arg_249_1.time_ - var_252_14) / var_252_15

				if arg_249_1.var_.characterEffect1111ui_story and not isNil(var_252_13) then
					local var_252_17 = Mathf.Lerp(0, 0.5, var_252_16)

					arg_249_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1111ui_story.fillRatio = var_252_17
				end
			end

			if arg_249_1.time_ >= var_252_14 + var_252_15 and arg_249_1.time_ < var_252_14 + var_252_15 + arg_252_0 and not isNil(var_252_13) and arg_249_1.var_.characterEffect1111ui_story then
				local var_252_18 = 0.5

				arg_249_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1111ui_story.fillRatio = var_252_18
			end

			local var_252_19 = 0
			local var_252_20 = 0.125

			if var_252_19 < arg_249_1.time_ and arg_249_1.time_ <= var_252_19 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_21 = arg_249_1:FormatText(StoryNameCfg[1366].name)

				arg_249_1.leftNameTxt_.text = var_252_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_22 = arg_249_1:GetWordFromCfg(322221061)
				local var_252_23 = arg_249_1:FormatText(var_252_22.content)

				arg_249_1.text_.text = var_252_23

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_24 = 5
				local var_252_25 = utf8.len(var_252_23)
				local var_252_26 = var_252_24 <= 0 and var_252_20 or var_252_20 * (var_252_25 / var_252_24)

				if var_252_26 > 0 and var_252_20 < var_252_26 then
					arg_249_1.talkMaxDuration = var_252_26

					if var_252_26 + var_252_19 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_26 + var_252_19
					end
				end

				arg_249_1.text_.text = var_252_23
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221061", "story_v_out_322221.awb") ~= 0 then
					local var_252_27 = manager.audio:GetVoiceLength("story_v_out_322221", "322221061", "story_v_out_322221.awb") / 1000

					if var_252_27 + var_252_19 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_27 + var_252_19
					end

					if var_252_22.prefab_name ~= "" and arg_249_1.actors_[var_252_22.prefab_name] ~= nil then
						local var_252_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_22.prefab_name].transform, "story_v_out_322221", "322221061", "story_v_out_322221.awb")

						arg_249_1:RecordAudio("322221061", var_252_28)
						arg_249_1:RecordAudio("322221061", var_252_28)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_322221", "322221061", "story_v_out_322221.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_322221", "322221061", "story_v_out_322221.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_29 = math.max(var_252_20, arg_249_1.talkMaxDuration)

			if var_252_19 <= arg_249_1.time_ and arg_249_1.time_ < var_252_19 + var_252_29 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_19) / var_252_29

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_19 + var_252_29 and arg_249_1.time_ < var_252_19 + var_252_29 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play322221062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322221062
		arg_253_1.duration_ = 2.37

		local var_253_0 = {
			zh = 1.766,
			ja = 2.366
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play322221063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1111ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1111ui_story == nil then
				arg_253_1.var_.characterEffect1111ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect1111ui_story and not isNil(var_256_0) then
					arg_253_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1111ui_story then
				arg_253_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_256_4 = arg_253_1.actors_["10131ui_story"]
			local var_256_5 = 0

			if var_256_5 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect10131ui_story == nil then
				arg_253_1.var_.characterEffect10131ui_story = var_256_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_6 = 0.200000002980232

			if var_256_5 <= arg_253_1.time_ and arg_253_1.time_ < var_256_5 + var_256_6 and not isNil(var_256_4) then
				local var_256_7 = (arg_253_1.time_ - var_256_5) / var_256_6

				if arg_253_1.var_.characterEffect10131ui_story and not isNil(var_256_4) then
					local var_256_8 = Mathf.Lerp(0, 0.5, var_256_7)

					arg_253_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10131ui_story.fillRatio = var_256_8
				end
			end

			if arg_253_1.time_ >= var_256_5 + var_256_6 and arg_253_1.time_ < var_256_5 + var_256_6 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect10131ui_story then
				local var_256_9 = 0.5

				arg_253_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10131ui_story.fillRatio = var_256_9
			end

			local var_256_10 = 0
			local var_256_11 = 0.15

			if var_256_10 < arg_253_1.time_ and arg_253_1.time_ <= var_256_10 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_12 = arg_253_1:FormatText(StoryNameCfg[67].name)

				arg_253_1.leftNameTxt_.text = var_256_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_13 = arg_253_1:GetWordFromCfg(322221062)
				local var_256_14 = arg_253_1:FormatText(var_256_13.content)

				arg_253_1.text_.text = var_256_14

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_15 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221062", "story_v_out_322221.awb") ~= 0 then
					local var_256_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221062", "story_v_out_322221.awb") / 1000

					if var_256_18 + var_256_10 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_18 + var_256_10
					end

					if var_256_13.prefab_name ~= "" and arg_253_1.actors_[var_256_13.prefab_name] ~= nil then
						local var_256_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_13.prefab_name].transform, "story_v_out_322221", "322221062", "story_v_out_322221.awb")

						arg_253_1:RecordAudio("322221062", var_256_19)
						arg_253_1:RecordAudio("322221062", var_256_19)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_322221", "322221062", "story_v_out_322221.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_322221", "322221062", "story_v_out_322221.awb")
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
	Play322221063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322221063
		arg_257_1.duration_ = 2

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play322221064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10131ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect10131ui_story == nil then
				arg_257_1.var_.characterEffect10131ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect10131ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect10131ui_story then
				arg_257_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_260_4 = arg_257_1.actors_["1111ui_story"]
			local var_260_5 = 0

			if var_260_5 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect1111ui_story == nil then
				arg_257_1.var_.characterEffect1111ui_story = var_260_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_6 = 0.200000002980232

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_6 and not isNil(var_260_4) then
				local var_260_7 = (arg_257_1.time_ - var_260_5) / var_260_6

				if arg_257_1.var_.characterEffect1111ui_story and not isNil(var_260_4) then
					local var_260_8 = Mathf.Lerp(0, 0.5, var_260_7)

					arg_257_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1111ui_story.fillRatio = var_260_8
				end
			end

			if arg_257_1.time_ >= var_260_5 + var_260_6 and arg_257_1.time_ < var_260_5 + var_260_6 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect1111ui_story then
				local var_260_9 = 0.5

				arg_257_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1111ui_story.fillRatio = var_260_9
			end

			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_260_11 = 0

			if var_260_11 < arg_257_1.time_ and arg_257_1.time_ <= var_260_11 + arg_260_0 then
				arg_257_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_260_12 = 0
			local var_260_13 = 0.15

			if var_260_12 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_14 = arg_257_1:FormatText(StoryNameCfg[1366].name)

				arg_257_1.leftNameTxt_.text = var_260_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_15 = arg_257_1:GetWordFromCfg(322221063)
				local var_260_16 = arg_257_1:FormatText(var_260_15.content)

				arg_257_1.text_.text = var_260_16

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_17 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221063", "story_v_out_322221.awb") ~= 0 then
					local var_260_20 = manager.audio:GetVoiceLength("story_v_out_322221", "322221063", "story_v_out_322221.awb") / 1000

					if var_260_20 + var_260_12 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_20 + var_260_12
					end

					if var_260_15.prefab_name ~= "" and arg_257_1.actors_[var_260_15.prefab_name] ~= nil then
						local var_260_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_15.prefab_name].transform, "story_v_out_322221", "322221063", "story_v_out_322221.awb")

						arg_257_1:RecordAudio("322221063", var_260_21)
						arg_257_1:RecordAudio("322221063", var_260_21)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322221", "322221063", "story_v_out_322221.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322221", "322221063", "story_v_out_322221.awb")
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
	Play322221064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322221064
		arg_261_1.duration_ = 9.47

		local var_261_0 = {
			zh = 6.7,
			ja = 9.466
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322221065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1111ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1111ui_story == nil then
				arg_261_1.var_.characterEffect1111ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1111ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1111ui_story then
				arg_261_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_264_4 = arg_261_1.actors_["10131ui_story"]
			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect10131ui_story == nil then
				arg_261_1.var_.characterEffect10131ui_story = var_264_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_6 and not isNil(var_264_4) then
				local var_264_7 = (arg_261_1.time_ - var_264_5) / var_264_6

				if arg_261_1.var_.characterEffect10131ui_story and not isNil(var_264_4) then
					local var_264_8 = Mathf.Lerp(0, 0.5, var_264_7)

					arg_261_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10131ui_story.fillRatio = var_264_8
				end
			end

			if arg_261_1.time_ >= var_264_5 + var_264_6 and arg_261_1.time_ < var_264_5 + var_264_6 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect10131ui_story then
				local var_264_9 = 0.5

				arg_261_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10131ui_story.fillRatio = var_264_9
			end

			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_264_11 = 0
			local var_264_12 = 0.625

			if var_264_11 < arg_261_1.time_ and arg_261_1.time_ <= var_264_11 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_13 = arg_261_1:FormatText(StoryNameCfg[67].name)

				arg_261_1.leftNameTxt_.text = var_264_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_14 = arg_261_1:GetWordFromCfg(322221064)
				local var_264_15 = arg_261_1:FormatText(var_264_14.content)

				arg_261_1.text_.text = var_264_15

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_16 = 25
				local var_264_17 = utf8.len(var_264_15)
				local var_264_18 = var_264_16 <= 0 and var_264_12 or var_264_12 * (var_264_17 / var_264_16)

				if var_264_18 > 0 and var_264_12 < var_264_18 then
					arg_261_1.talkMaxDuration = var_264_18

					if var_264_18 + var_264_11 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_18 + var_264_11
					end
				end

				arg_261_1.text_.text = var_264_15
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221064", "story_v_out_322221.awb") ~= 0 then
					local var_264_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221064", "story_v_out_322221.awb") / 1000

					if var_264_19 + var_264_11 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_19 + var_264_11
					end

					if var_264_14.prefab_name ~= "" and arg_261_1.actors_[var_264_14.prefab_name] ~= nil then
						local var_264_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_14.prefab_name].transform, "story_v_out_322221", "322221064", "story_v_out_322221.awb")

						arg_261_1:RecordAudio("322221064", var_264_20)
						arg_261_1:RecordAudio("322221064", var_264_20)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_322221", "322221064", "story_v_out_322221.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_322221", "322221064", "story_v_out_322221.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_21 = math.max(var_264_12, arg_261_1.talkMaxDuration)

			if var_264_11 <= arg_261_1.time_ and arg_261_1.time_ < var_264_11 + var_264_21 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_11) / var_264_21

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_11 + var_264_21 and arg_261_1.time_ < var_264_11 + var_264_21 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play322221065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322221065
		arg_265_1.duration_ = 4.2

		local var_265_0 = {
			zh = 3.266,
			ja = 4.2
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
				arg_265_0:Play322221066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10131ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect10131ui_story == nil then
				arg_265_1.var_.characterEffect10131ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect10131ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect10131ui_story then
				arg_265_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_268_4 = arg_265_1.actors_["1111ui_story"]
			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect1111ui_story == nil then
				arg_265_1.var_.characterEffect1111ui_story = var_268_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_6 = 0.200000002980232

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_6 and not isNil(var_268_4) then
				local var_268_7 = (arg_265_1.time_ - var_268_5) / var_268_6

				if arg_265_1.var_.characterEffect1111ui_story and not isNil(var_268_4) then
					local var_268_8 = Mathf.Lerp(0, 0.5, var_268_7)

					arg_265_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1111ui_story.fillRatio = var_268_8
				end
			end

			if arg_265_1.time_ >= var_268_5 + var_268_6 and arg_265_1.time_ < var_268_5 + var_268_6 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect1111ui_story then
				local var_268_9 = 0.5

				arg_265_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1111ui_story.fillRatio = var_268_9
			end

			local var_268_10 = 0
			local var_268_11 = 0.325

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_12 = arg_265_1:FormatText(StoryNameCfg[1366].name)

				arg_265_1.leftNameTxt_.text = var_268_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_13 = arg_265_1:GetWordFromCfg(322221065)
				local var_268_14 = arg_265_1:FormatText(var_268_13.content)

				arg_265_1.text_.text = var_268_14

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_15 = 13
				local var_268_16 = utf8.len(var_268_14)
				local var_268_17 = var_268_15 <= 0 and var_268_11 or var_268_11 * (var_268_16 / var_268_15)

				if var_268_17 > 0 and var_268_11 < var_268_17 then
					arg_265_1.talkMaxDuration = var_268_17

					if var_268_17 + var_268_10 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_17 + var_268_10
					end
				end

				arg_265_1.text_.text = var_268_14
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221065", "story_v_out_322221.awb") ~= 0 then
					local var_268_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221065", "story_v_out_322221.awb") / 1000

					if var_268_18 + var_268_10 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_18 + var_268_10
					end

					if var_268_13.prefab_name ~= "" and arg_265_1.actors_[var_268_13.prefab_name] ~= nil then
						local var_268_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_13.prefab_name].transform, "story_v_out_322221", "322221065", "story_v_out_322221.awb")

						arg_265_1:RecordAudio("322221065", var_268_19)
						arg_265_1:RecordAudio("322221065", var_268_19)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322221", "322221065", "story_v_out_322221.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322221", "322221065", "story_v_out_322221.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_20 = math.max(var_268_11, arg_265_1.talkMaxDuration)

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_20 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_10) / var_268_20

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_10 + var_268_20 and arg_265_1.time_ < var_268_10 + var_268_20 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play322221066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322221066
		arg_269_1.duration_ = 6.5

		local var_269_0 = {
			zh = 2.133,
			ja = 6.5
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play322221067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1111ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1111ui_story == nil then
				arg_269_1.var_.characterEffect1111ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1111ui_story and not isNil(var_272_0) then
					arg_269_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1111ui_story then
				arg_269_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_272_4 = arg_269_1.actors_["10131ui_story"]
			local var_272_5 = 0

			if var_272_5 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 and not isNil(var_272_4) and arg_269_1.var_.characterEffect10131ui_story == nil then
				arg_269_1.var_.characterEffect10131ui_story = var_272_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_6 = 0.200000002980232

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_6 and not isNil(var_272_4) then
				local var_272_7 = (arg_269_1.time_ - var_272_5) / var_272_6

				if arg_269_1.var_.characterEffect10131ui_story and not isNil(var_272_4) then
					local var_272_8 = Mathf.Lerp(0, 0.5, var_272_7)

					arg_269_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10131ui_story.fillRatio = var_272_8
				end
			end

			if arg_269_1.time_ >= var_272_5 + var_272_6 and arg_269_1.time_ < var_272_5 + var_272_6 + arg_272_0 and not isNil(var_272_4) and arg_269_1.var_.characterEffect10131ui_story then
				local var_272_9 = 0.5

				arg_269_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10131ui_story.fillRatio = var_272_9
			end

			local var_272_10 = 0
			local var_272_11 = 0.225

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_12 = arg_269_1:FormatText(StoryNameCfg[67].name)

				arg_269_1.leftNameTxt_.text = var_272_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_13 = arg_269_1:GetWordFromCfg(322221066)
				local var_272_14 = arg_269_1:FormatText(var_272_13.content)

				arg_269_1.text_.text = var_272_14

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_15 = 9
				local var_272_16 = utf8.len(var_272_14)
				local var_272_17 = var_272_15 <= 0 and var_272_11 or var_272_11 * (var_272_16 / var_272_15)

				if var_272_17 > 0 and var_272_11 < var_272_17 then
					arg_269_1.talkMaxDuration = var_272_17

					if var_272_17 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_17 + var_272_10
					end
				end

				arg_269_1.text_.text = var_272_14
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221066", "story_v_out_322221.awb") ~= 0 then
					local var_272_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221066", "story_v_out_322221.awb") / 1000

					if var_272_18 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_18 + var_272_10
					end

					if var_272_13.prefab_name ~= "" and arg_269_1.actors_[var_272_13.prefab_name] ~= nil then
						local var_272_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_13.prefab_name].transform, "story_v_out_322221", "322221066", "story_v_out_322221.awb")

						arg_269_1:RecordAudio("322221066", var_272_19)
						arg_269_1:RecordAudio("322221066", var_272_19)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322221", "322221066", "story_v_out_322221.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322221", "322221066", "story_v_out_322221.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_20 = math.max(var_272_11, arg_269_1.talkMaxDuration)

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_20 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_10) / var_272_20

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_10 + var_272_20 and arg_269_1.time_ < var_272_10 + var_272_20 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play322221067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322221067
		arg_273_1.duration_ = 4.23

		local var_273_0 = {
			zh = 1.999999999999,
			ja = 4.233
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
				arg_273_0:Play322221068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10131ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect10131ui_story == nil then
				arg_273_1.var_.characterEffect10131ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect10131ui_story and not isNil(var_276_0) then
					arg_273_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect10131ui_story then
				arg_273_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_276_4 = arg_273_1.actors_["1111ui_story"]
			local var_276_5 = 0

			if var_276_5 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect1111ui_story == nil then
				arg_273_1.var_.characterEffect1111ui_story = var_276_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_6 = 0.200000002980232

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_6 and not isNil(var_276_4) then
				local var_276_7 = (arg_273_1.time_ - var_276_5) / var_276_6

				if arg_273_1.var_.characterEffect1111ui_story and not isNil(var_276_4) then
					local var_276_8 = Mathf.Lerp(0, 0.5, var_276_7)

					arg_273_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1111ui_story.fillRatio = var_276_8
				end
			end

			if arg_273_1.time_ >= var_276_5 + var_276_6 and arg_273_1.time_ < var_276_5 + var_276_6 + arg_276_0 and not isNil(var_276_4) and arg_273_1.var_.characterEffect1111ui_story then
				local var_276_9 = 0.5

				arg_273_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1111ui_story.fillRatio = var_276_9
			end

			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 then
				arg_273_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_2")
			end

			local var_276_11 = 0
			local var_276_12 = 0.225

			if var_276_11 < arg_273_1.time_ and arg_273_1.time_ <= var_276_11 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_13 = arg_273_1:FormatText(StoryNameCfg[1366].name)

				arg_273_1.leftNameTxt_.text = var_276_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_14 = arg_273_1:GetWordFromCfg(322221067)
				local var_276_15 = arg_273_1:FormatText(var_276_14.content)

				arg_273_1.text_.text = var_276_15

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_16 = 9
				local var_276_17 = utf8.len(var_276_15)
				local var_276_18 = var_276_16 <= 0 and var_276_12 or var_276_12 * (var_276_17 / var_276_16)

				if var_276_18 > 0 and var_276_12 < var_276_18 then
					arg_273_1.talkMaxDuration = var_276_18

					if var_276_18 + var_276_11 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_18 + var_276_11
					end
				end

				arg_273_1.text_.text = var_276_15
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221067", "story_v_out_322221.awb") ~= 0 then
					local var_276_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221067", "story_v_out_322221.awb") / 1000

					if var_276_19 + var_276_11 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_19 + var_276_11
					end

					if var_276_14.prefab_name ~= "" and arg_273_1.actors_[var_276_14.prefab_name] ~= nil then
						local var_276_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_14.prefab_name].transform, "story_v_out_322221", "322221067", "story_v_out_322221.awb")

						arg_273_1:RecordAudio("322221067", var_276_20)
						arg_273_1:RecordAudio("322221067", var_276_20)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322221", "322221067", "story_v_out_322221.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322221", "322221067", "story_v_out_322221.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_21 = math.max(var_276_12, arg_273_1.talkMaxDuration)

			if var_276_11 <= arg_273_1.time_ and arg_273_1.time_ < var_276_11 + var_276_21 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_11) / var_276_21

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_11 + var_276_21 and arg_273_1.time_ < var_276_11 + var_276_21 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322221068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322221068
		arg_277_1.duration_ = 4.9

		local var_277_0 = {
			zh = 2.766,
			ja = 4.9
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
				arg_277_0:Play322221069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1111ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1111ui_story == nil then
				arg_277_1.var_.characterEffect1111ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1111ui_story and not isNil(var_280_0) then
					arg_277_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1111ui_story then
				arg_277_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_280_4 = arg_277_1.actors_["10131ui_story"]
			local var_280_5 = 0

			if var_280_5 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect10131ui_story == nil then
				arg_277_1.var_.characterEffect10131ui_story = var_280_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_6 = 0.200000002980232

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_6 and not isNil(var_280_4) then
				local var_280_7 = (arg_277_1.time_ - var_280_5) / var_280_6

				if arg_277_1.var_.characterEffect10131ui_story and not isNil(var_280_4) then
					local var_280_8 = Mathf.Lerp(0, 0.5, var_280_7)

					arg_277_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10131ui_story.fillRatio = var_280_8
				end
			end

			if arg_277_1.time_ >= var_280_5 + var_280_6 and arg_277_1.time_ < var_280_5 + var_280_6 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect10131ui_story then
				local var_280_9 = 0.5

				arg_277_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10131ui_story.fillRatio = var_280_9
			end

			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 then
				arg_277_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_280_11 = 0
			local var_280_12 = 0.275

			if var_280_11 < arg_277_1.time_ and arg_277_1.time_ <= var_280_11 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_13 = arg_277_1:FormatText(StoryNameCfg[67].name)

				arg_277_1.leftNameTxt_.text = var_280_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_14 = arg_277_1:GetWordFromCfg(322221068)
				local var_280_15 = arg_277_1:FormatText(var_280_14.content)

				arg_277_1.text_.text = var_280_15

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_16 = 11
				local var_280_17 = utf8.len(var_280_15)
				local var_280_18 = var_280_16 <= 0 and var_280_12 or var_280_12 * (var_280_17 / var_280_16)

				if var_280_18 > 0 and var_280_12 < var_280_18 then
					arg_277_1.talkMaxDuration = var_280_18

					if var_280_18 + var_280_11 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_18 + var_280_11
					end
				end

				arg_277_1.text_.text = var_280_15
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221068", "story_v_out_322221.awb") ~= 0 then
					local var_280_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221068", "story_v_out_322221.awb") / 1000

					if var_280_19 + var_280_11 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_19 + var_280_11
					end

					if var_280_14.prefab_name ~= "" and arg_277_1.actors_[var_280_14.prefab_name] ~= nil then
						local var_280_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_14.prefab_name].transform, "story_v_out_322221", "322221068", "story_v_out_322221.awb")

						arg_277_1:RecordAudio("322221068", var_280_20)
						arg_277_1:RecordAudio("322221068", var_280_20)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322221", "322221068", "story_v_out_322221.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322221", "322221068", "story_v_out_322221.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_21 = math.max(var_280_12, arg_277_1.talkMaxDuration)

			if var_280_11 <= arg_277_1.time_ and arg_277_1.time_ < var_280_11 + var_280_21 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_11) / var_280_21

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_11 + var_280_21 and arg_277_1.time_ < var_280_11 + var_280_21 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322221069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322221069
		arg_281_1.duration_ = 6.33

		local var_281_0 = {
			zh = 6.333,
			ja = 6.3
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
				arg_281_0:Play322221070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.775

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[67].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:GetWordFromCfg(322221069)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 31
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221069", "story_v_out_322221.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221069", "story_v_out_322221.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_322221", "322221069", "story_v_out_322221.awb")

						arg_281_1:RecordAudio("322221069", var_284_9)
						arg_281_1:RecordAudio("322221069", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322221", "322221069", "story_v_out_322221.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322221", "322221069", "story_v_out_322221.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322221070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322221070
		arg_285_1.duration_ = 14

		local var_285_0 = {
			zh = 11.666,
			ja = 14
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
				arg_285_0:Play322221071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				arg_285_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			local var_288_1 = 0
			local var_288_2 = 1.35

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_3 = arg_285_1:FormatText(StoryNameCfg[67].name)

				arg_285_1.leftNameTxt_.text = var_288_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_4 = arg_285_1:GetWordFromCfg(322221070)
				local var_288_5 = arg_285_1:FormatText(var_288_4.content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_6 = 54
				local var_288_7 = utf8.len(var_288_5)
				local var_288_8 = var_288_6 <= 0 and var_288_2 or var_288_2 * (var_288_7 / var_288_6)

				if var_288_8 > 0 and var_288_2 < var_288_8 then
					arg_285_1.talkMaxDuration = var_288_8

					if var_288_8 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221070", "story_v_out_322221.awb") ~= 0 then
					local var_288_9 = manager.audio:GetVoiceLength("story_v_out_322221", "322221070", "story_v_out_322221.awb") / 1000

					if var_288_9 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_1
					end

					if var_288_4.prefab_name ~= "" and arg_285_1.actors_[var_288_4.prefab_name] ~= nil then
						local var_288_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_4.prefab_name].transform, "story_v_out_322221", "322221070", "story_v_out_322221.awb")

						arg_285_1:RecordAudio("322221070", var_288_10)
						arg_285_1:RecordAudio("322221070", var_288_10)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322221", "322221070", "story_v_out_322221.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322221", "322221070", "story_v_out_322221.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_11 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_11 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_11

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_11 and arg_285_1.time_ < var_288_1 + var_288_11 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play322221071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322221071
		arg_289_1.duration_ = 10.13

		local var_289_0 = {
			zh = 10.133,
			ja = 9.933
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
				arg_289_0:Play322221072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 1.1

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[67].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_3 = arg_289_1:GetWordFromCfg(322221071)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221071", "story_v_out_322221.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221071", "story_v_out_322221.awb") / 1000

					if var_292_8 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_0
					end

					if var_292_3.prefab_name ~= "" and arg_289_1.actors_[var_292_3.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_3.prefab_name].transform, "story_v_out_322221", "322221071", "story_v_out_322221.awb")

						arg_289_1:RecordAudio("322221071", var_292_9)
						arg_289_1:RecordAudio("322221071", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_322221", "322221071", "story_v_out_322221.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_322221", "322221071", "story_v_out_322221.awb")
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
	Play322221072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322221072
		arg_293_1.duration_ = 4.77

		local var_293_0 = {
			zh = 2.433,
			ja = 4.766
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322221073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.225

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_2 = arg_293_1:FormatText(StoryNameCfg[67].name)

				arg_293_1.leftNameTxt_.text = var_296_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:GetWordFromCfg(322221072)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 9
				local var_296_6 = utf8.len(var_296_4)
				local var_296_7 = var_296_5 <= 0 and var_296_1 or var_296_1 * (var_296_6 / var_296_5)

				if var_296_7 > 0 and var_296_1 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221072", "story_v_out_322221.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221072", "story_v_out_322221.awb") / 1000

					if var_296_8 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_0
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_out_322221", "322221072", "story_v_out_322221.awb")

						arg_293_1:RecordAudio("322221072", var_296_9)
						arg_293_1:RecordAudio("322221072", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322221", "322221072", "story_v_out_322221.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322221", "322221072", "story_v_out_322221.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_10 and arg_293_1.time_ < var_296_0 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play322221073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322221073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play322221074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1111ui_story"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos1111ui_story = var_300_0.localPosition
			end

			local var_300_2 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2
				local var_300_4 = Vector3.New(0, 100, 0)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1111ui_story, var_300_4, var_300_3)

				local var_300_5 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_5.x, var_300_5.y, var_300_5.z)

				local var_300_6 = var_300_0.localEulerAngles

				var_300_6.z = 0
				var_300_6.x = 0
				var_300_0.localEulerAngles = var_300_6
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, 100, 0)

				local var_300_7 = manager.ui.mainCamera.transform.position - var_300_0.position

				var_300_0.forward = Vector3.New(var_300_7.x, var_300_7.y, var_300_7.z)

				local var_300_8 = var_300_0.localEulerAngles

				var_300_8.z = 0
				var_300_8.x = 0
				var_300_0.localEulerAngles = var_300_8
			end

			local var_300_9 = arg_297_1.actors_["10131ui_story"].transform
			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1.var_.moveOldPos10131ui_story = var_300_9.localPosition
			end

			local var_300_11 = 0.001

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 then
				local var_300_12 = (arg_297_1.time_ - var_300_10) / var_300_11
				local var_300_13 = Vector3.New(0, 100, 0)

				var_300_9.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10131ui_story, var_300_13, var_300_12)

				local var_300_14 = manager.ui.mainCamera.transform.position - var_300_9.position

				var_300_9.forward = Vector3.New(var_300_14.x, var_300_14.y, var_300_14.z)

				local var_300_15 = var_300_9.localEulerAngles

				var_300_15.z = 0
				var_300_15.x = 0
				var_300_9.localEulerAngles = var_300_15
			end

			if arg_297_1.time_ >= var_300_10 + var_300_11 and arg_297_1.time_ < var_300_10 + var_300_11 + arg_300_0 then
				var_300_9.localPosition = Vector3.New(0, 100, 0)

				local var_300_16 = manager.ui.mainCamera.transform.position - var_300_9.position

				var_300_9.forward = Vector3.New(var_300_16.x, var_300_16.y, var_300_16.z)

				local var_300_17 = var_300_9.localEulerAngles

				var_300_17.z = 0
				var_300_17.x = 0
				var_300_9.localEulerAngles = var_300_17
			end

			local var_300_18 = 0
			local var_300_19 = 0.825

			if var_300_18 < arg_297_1.time_ and arg_297_1.time_ <= var_300_18 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_20 = arg_297_1:GetWordFromCfg(322221073)
				local var_300_21 = arg_297_1:FormatText(var_300_20.content)

				arg_297_1.text_.text = var_300_21

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_22 = 33
				local var_300_23 = utf8.len(var_300_21)
				local var_300_24 = var_300_22 <= 0 and var_300_19 or var_300_19 * (var_300_23 / var_300_22)

				if var_300_24 > 0 and var_300_19 < var_300_24 then
					arg_297_1.talkMaxDuration = var_300_24

					if var_300_24 + var_300_18 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_24 + var_300_18
					end
				end

				arg_297_1.text_.text = var_300_21
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_25 = math.max(var_300_19, arg_297_1.talkMaxDuration)

			if var_300_18 <= arg_297_1.time_ and arg_297_1.time_ < var_300_18 + var_300_25 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_18) / var_300_25

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_18 + var_300_25 and arg_297_1.time_ < var_300_18 + var_300_25 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play322221074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322221074
		arg_301_1.duration_ = 1.4

		local var_301_0 = {
			zh = 1.4,
			ja = 1.233
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
				arg_301_0:Play322221075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["10131ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos10131ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0.83, -0.96, -5.8)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10131ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["10131ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect10131ui_story == nil then
				arg_301_1.var_.characterEffect10131ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect10131ui_story and not isNil(var_304_9) then
					arg_301_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect10131ui_story then
				arg_301_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_304_13 = 0
			local var_304_14 = 0.1

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_15 = arg_301_1:FormatText(StoryNameCfg[1366].name)

				arg_301_1.leftNameTxt_.text = var_304_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_16 = arg_301_1:GetWordFromCfg(322221074)
				local var_304_17 = arg_301_1:FormatText(var_304_16.content)

				arg_301_1.text_.text = var_304_17

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_18 = 4
				local var_304_19 = utf8.len(var_304_17)
				local var_304_20 = var_304_18 <= 0 and var_304_14 or var_304_14 * (var_304_19 / var_304_18)

				if var_304_20 > 0 and var_304_14 < var_304_20 then
					arg_301_1.talkMaxDuration = var_304_20

					if var_304_20 + var_304_13 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_20 + var_304_13
					end
				end

				arg_301_1.text_.text = var_304_17
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221074", "story_v_out_322221.awb") ~= 0 then
					local var_304_21 = manager.audio:GetVoiceLength("story_v_out_322221", "322221074", "story_v_out_322221.awb") / 1000

					if var_304_21 + var_304_13 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_21 + var_304_13
					end

					if var_304_16.prefab_name ~= "" and arg_301_1.actors_[var_304_16.prefab_name] ~= nil then
						local var_304_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_16.prefab_name].transform, "story_v_out_322221", "322221074", "story_v_out_322221.awb")

						arg_301_1:RecordAudio("322221074", var_304_22)
						arg_301_1:RecordAudio("322221074", var_304_22)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_322221", "322221074", "story_v_out_322221.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_322221", "322221074", "story_v_out_322221.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_23 = math.max(var_304_14, arg_301_1.talkMaxDuration)

			if var_304_13 <= arg_301_1.time_ and arg_301_1.time_ < var_304_13 + var_304_23 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_13) / var_304_23

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_13 + var_304_23 and arg_301_1.time_ < var_304_13 + var_304_23 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play322221075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 322221075
		arg_305_1.duration_ = 7.67

		local var_305_0 = {
			zh = 7.166,
			ja = 7.666
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play322221076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1111ui_story"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos1111ui_story = var_308_0.localPosition
			end

			local var_308_2 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2
				local var_308_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1111ui_story, var_308_4, var_308_3)

				local var_308_5 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_5.x, var_308_5.y, var_308_5.z)

				local var_308_6 = var_308_0.localEulerAngles

				var_308_6.z = 0
				var_308_6.x = 0
				var_308_0.localEulerAngles = var_308_6
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_308_7 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_7.x, var_308_7.y, var_308_7.z)

				local var_308_8 = var_308_0.localEulerAngles

				var_308_8.z = 0
				var_308_8.x = 0
				var_308_0.localEulerAngles = var_308_8
			end

			local var_308_9 = arg_305_1.actors_["1111ui_story"]
			local var_308_10 = 0

			if var_308_10 < arg_305_1.time_ and arg_305_1.time_ <= var_308_10 + arg_308_0 and not isNil(var_308_9) and arg_305_1.var_.characterEffect1111ui_story == nil then
				arg_305_1.var_.characterEffect1111ui_story = var_308_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_11 = 0.200000002980232

			if var_308_10 <= arg_305_1.time_ and arg_305_1.time_ < var_308_10 + var_308_11 and not isNil(var_308_9) then
				local var_308_12 = (arg_305_1.time_ - var_308_10) / var_308_11

				if arg_305_1.var_.characterEffect1111ui_story and not isNil(var_308_9) then
					arg_305_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_10 + var_308_11 and arg_305_1.time_ < var_308_10 + var_308_11 + arg_308_0 and not isNil(var_308_9) and arg_305_1.var_.characterEffect1111ui_story then
				arg_305_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_308_13 = arg_305_1.actors_["10131ui_story"]
			local var_308_14 = 0

			if var_308_14 < arg_305_1.time_ and arg_305_1.time_ <= var_308_14 + arg_308_0 and not isNil(var_308_13) and arg_305_1.var_.characterEffect10131ui_story == nil then
				arg_305_1.var_.characterEffect10131ui_story = var_308_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_15 = 0.200000002980232

			if var_308_14 <= arg_305_1.time_ and arg_305_1.time_ < var_308_14 + var_308_15 and not isNil(var_308_13) then
				local var_308_16 = (arg_305_1.time_ - var_308_14) / var_308_15

				if arg_305_1.var_.characterEffect10131ui_story and not isNil(var_308_13) then
					local var_308_17 = Mathf.Lerp(0, 0.5, var_308_16)

					arg_305_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_305_1.var_.characterEffect10131ui_story.fillRatio = var_308_17
				end
			end

			if arg_305_1.time_ >= var_308_14 + var_308_15 and arg_305_1.time_ < var_308_14 + var_308_15 + arg_308_0 and not isNil(var_308_13) and arg_305_1.var_.characterEffect10131ui_story then
				local var_308_18 = 0.5

				arg_305_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_305_1.var_.characterEffect10131ui_story.fillRatio = var_308_18
			end

			local var_308_19 = 0

			if var_308_19 < arg_305_1.time_ and arg_305_1.time_ <= var_308_19 + arg_308_0 then
				arg_305_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_308_20 = 0
			local var_308_21 = 0.725

			if var_308_20 < arg_305_1.time_ and arg_305_1.time_ <= var_308_20 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_22 = arg_305_1:FormatText(StoryNameCfg[67].name)

				arg_305_1.leftNameTxt_.text = var_308_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_23 = arg_305_1:GetWordFromCfg(322221075)
				local var_308_24 = arg_305_1:FormatText(var_308_23.content)

				arg_305_1.text_.text = var_308_24

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_25 = 29
				local var_308_26 = utf8.len(var_308_24)
				local var_308_27 = var_308_25 <= 0 and var_308_21 or var_308_21 * (var_308_26 / var_308_25)

				if var_308_27 > 0 and var_308_21 < var_308_27 then
					arg_305_1.talkMaxDuration = var_308_27

					if var_308_27 + var_308_20 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_27 + var_308_20
					end
				end

				arg_305_1.text_.text = var_308_24
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221075", "story_v_out_322221.awb") ~= 0 then
					local var_308_28 = manager.audio:GetVoiceLength("story_v_out_322221", "322221075", "story_v_out_322221.awb") / 1000

					if var_308_28 + var_308_20 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_28 + var_308_20
					end

					if var_308_23.prefab_name ~= "" and arg_305_1.actors_[var_308_23.prefab_name] ~= nil then
						local var_308_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_23.prefab_name].transform, "story_v_out_322221", "322221075", "story_v_out_322221.awb")

						arg_305_1:RecordAudio("322221075", var_308_29)
						arg_305_1:RecordAudio("322221075", var_308_29)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_322221", "322221075", "story_v_out_322221.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_322221", "322221075", "story_v_out_322221.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_30 = math.max(var_308_21, arg_305_1.talkMaxDuration)

			if var_308_20 <= arg_305_1.time_ and arg_305_1.time_ < var_308_20 + var_308_30 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_20) / var_308_30

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_20 + var_308_30 and arg_305_1.time_ < var_308_20 + var_308_30 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play322221076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 322221076
		arg_309_1.duration_ = 4.07

		local var_309_0 = {
			zh = 1.666,
			ja = 4.066
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
				arg_309_0:Play322221077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["10131ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect10131ui_story == nil then
				arg_309_1.var_.characterEffect10131ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect10131ui_story and not isNil(var_312_0) then
					arg_309_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect10131ui_story then
				arg_309_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_312_4 = arg_309_1.actors_["1111ui_story"]
			local var_312_5 = 0

			if var_312_5 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 and not isNil(var_312_4) and arg_309_1.var_.characterEffect1111ui_story == nil then
				arg_309_1.var_.characterEffect1111ui_story = var_312_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_6 = 0.200000002980232

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_6 and not isNil(var_312_4) then
				local var_312_7 = (arg_309_1.time_ - var_312_5) / var_312_6

				if arg_309_1.var_.characterEffect1111ui_story and not isNil(var_312_4) then
					local var_312_8 = Mathf.Lerp(0, 0.5, var_312_7)

					arg_309_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1111ui_story.fillRatio = var_312_8
				end
			end

			if arg_309_1.time_ >= var_312_5 + var_312_6 and arg_309_1.time_ < var_312_5 + var_312_6 + arg_312_0 and not isNil(var_312_4) and arg_309_1.var_.characterEffect1111ui_story then
				local var_312_9 = 0.5

				arg_309_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1111ui_story.fillRatio = var_312_9
			end

			local var_312_10 = 0
			local var_312_11 = 0.175

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_12 = arg_309_1:FormatText(StoryNameCfg[1366].name)

				arg_309_1.leftNameTxt_.text = var_312_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_13 = arg_309_1:GetWordFromCfg(322221076)
				local var_312_14 = arg_309_1:FormatText(var_312_13.content)

				arg_309_1.text_.text = var_312_14

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_15 = 7
				local var_312_16 = utf8.len(var_312_14)
				local var_312_17 = var_312_15 <= 0 and var_312_11 or var_312_11 * (var_312_16 / var_312_15)

				if var_312_17 > 0 and var_312_11 < var_312_17 then
					arg_309_1.talkMaxDuration = var_312_17

					if var_312_17 + var_312_10 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_17 + var_312_10
					end
				end

				arg_309_1.text_.text = var_312_14
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221076", "story_v_out_322221.awb") ~= 0 then
					local var_312_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221076", "story_v_out_322221.awb") / 1000

					if var_312_18 + var_312_10 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_18 + var_312_10
					end

					if var_312_13.prefab_name ~= "" and arg_309_1.actors_[var_312_13.prefab_name] ~= nil then
						local var_312_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_13.prefab_name].transform, "story_v_out_322221", "322221076", "story_v_out_322221.awb")

						arg_309_1:RecordAudio("322221076", var_312_19)
						arg_309_1:RecordAudio("322221076", var_312_19)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_322221", "322221076", "story_v_out_322221.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_322221", "322221076", "story_v_out_322221.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_20 = math.max(var_312_11, arg_309_1.talkMaxDuration)

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_20 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_10) / var_312_20

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_10 + var_312_20 and arg_309_1.time_ < var_312_10 + var_312_20 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play322221077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 322221077
		arg_313_1.duration_ = 2.3

		local var_313_0 = {
			zh = 2.3,
			ja = 1.866
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
				arg_313_0:Play322221078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1111ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1111ui_story == nil then
				arg_313_1.var_.characterEffect1111ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1111ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1111ui_story then
				arg_313_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_316_4 = arg_313_1.actors_["10131ui_story"]
			local var_316_5 = 0

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 and not isNil(var_316_4) and arg_313_1.var_.characterEffect10131ui_story == nil then
				arg_313_1.var_.characterEffect10131ui_story = var_316_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_6 = 0.200000002980232

			if var_316_5 <= arg_313_1.time_ and arg_313_1.time_ < var_316_5 + var_316_6 and not isNil(var_316_4) then
				local var_316_7 = (arg_313_1.time_ - var_316_5) / var_316_6

				if arg_313_1.var_.characterEffect10131ui_story and not isNil(var_316_4) then
					local var_316_8 = Mathf.Lerp(0, 0.5, var_316_7)

					arg_313_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_313_1.var_.characterEffect10131ui_story.fillRatio = var_316_8
				end
			end

			if arg_313_1.time_ >= var_316_5 + var_316_6 and arg_313_1.time_ < var_316_5 + var_316_6 + arg_316_0 and not isNil(var_316_4) and arg_313_1.var_.characterEffect10131ui_story then
				local var_316_9 = 0.5

				arg_313_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_313_1.var_.characterEffect10131ui_story.fillRatio = var_316_9
			end

			local var_316_10 = 0
			local var_316_11 = 0.225

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_12 = arg_313_1:FormatText(StoryNameCfg[67].name)

				arg_313_1.leftNameTxt_.text = var_316_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_13 = arg_313_1:GetWordFromCfg(322221077)
				local var_316_14 = arg_313_1:FormatText(var_316_13.content)

				arg_313_1.text_.text = var_316_14

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_15 = 9
				local var_316_16 = utf8.len(var_316_14)
				local var_316_17 = var_316_15 <= 0 and var_316_11 or var_316_11 * (var_316_16 / var_316_15)

				if var_316_17 > 0 and var_316_11 < var_316_17 then
					arg_313_1.talkMaxDuration = var_316_17

					if var_316_17 + var_316_10 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_17 + var_316_10
					end
				end

				arg_313_1.text_.text = var_316_14
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221077", "story_v_out_322221.awb") ~= 0 then
					local var_316_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221077", "story_v_out_322221.awb") / 1000

					if var_316_18 + var_316_10 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_18 + var_316_10
					end

					if var_316_13.prefab_name ~= "" and arg_313_1.actors_[var_316_13.prefab_name] ~= nil then
						local var_316_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_13.prefab_name].transform, "story_v_out_322221", "322221077", "story_v_out_322221.awb")

						arg_313_1:RecordAudio("322221077", var_316_19)
						arg_313_1:RecordAudio("322221077", var_316_19)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322221", "322221077", "story_v_out_322221.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322221", "322221077", "story_v_out_322221.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_20 = math.max(var_316_11, arg_313_1.talkMaxDuration)

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_20 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_10) / var_316_20

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_10 + var_316_20 and arg_313_1.time_ < var_316_10 + var_316_20 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play322221078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 322221078
		arg_317_1.duration_ = 8.77

		local var_317_0 = {
			zh = 7.266,
			ja = 8.766
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
				arg_317_0:Play322221079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.8

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_2 = arg_317_1:FormatText(StoryNameCfg[67].name)

				arg_317_1.leftNameTxt_.text = var_320_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:GetWordFromCfg(322221078)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 32
				local var_320_6 = utf8.len(var_320_4)
				local var_320_7 = var_320_5 <= 0 and var_320_1 or var_320_1 * (var_320_6 / var_320_5)

				if var_320_7 > 0 and var_320_1 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221078", "story_v_out_322221.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221078", "story_v_out_322221.awb") / 1000

					if var_320_8 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_0
					end

					if var_320_3.prefab_name ~= "" and arg_317_1.actors_[var_320_3.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_3.prefab_name].transform, "story_v_out_322221", "322221078", "story_v_out_322221.awb")

						arg_317_1:RecordAudio("322221078", var_320_9)
						arg_317_1:RecordAudio("322221078", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_322221", "322221078", "story_v_out_322221.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_322221", "322221078", "story_v_out_322221.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_10 and arg_317_1.time_ < var_320_0 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play322221079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 322221079
		arg_321_1.duration_ = 9.77

		local var_321_0 = {
			zh = 7.733,
			ja = 9.766
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play322221080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10131ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect10131ui_story == nil then
				arg_321_1.var_.characterEffect10131ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect10131ui_story and not isNil(var_324_0) then
					arg_321_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect10131ui_story then
				arg_321_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_324_4 = arg_321_1.actors_["1111ui_story"]
			local var_324_5 = 0

			if var_324_5 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 and not isNil(var_324_4) and arg_321_1.var_.characterEffect1111ui_story == nil then
				arg_321_1.var_.characterEffect1111ui_story = var_324_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_6 = 0.200000002980232

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_6 and not isNil(var_324_4) then
				local var_324_7 = (arg_321_1.time_ - var_324_5) / var_324_6

				if arg_321_1.var_.characterEffect1111ui_story and not isNil(var_324_4) then
					local var_324_8 = Mathf.Lerp(0, 0.5, var_324_7)

					arg_321_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1111ui_story.fillRatio = var_324_8
				end
			end

			if arg_321_1.time_ >= var_324_5 + var_324_6 and arg_321_1.time_ < var_324_5 + var_324_6 + arg_324_0 and not isNil(var_324_4) and arg_321_1.var_.characterEffect1111ui_story then
				local var_324_9 = 0.5

				arg_321_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1111ui_story.fillRatio = var_324_9
			end

			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 then
				arg_321_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_324_11 = 0
			local var_324_12 = 0.825

			if var_324_11 < arg_321_1.time_ and arg_321_1.time_ <= var_324_11 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_13 = arg_321_1:FormatText(StoryNameCfg[1366].name)

				arg_321_1.leftNameTxt_.text = var_324_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_14 = arg_321_1:GetWordFromCfg(322221079)
				local var_324_15 = arg_321_1:FormatText(var_324_14.content)

				arg_321_1.text_.text = var_324_15

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_16 = 33
				local var_324_17 = utf8.len(var_324_15)
				local var_324_18 = var_324_16 <= 0 and var_324_12 or var_324_12 * (var_324_17 / var_324_16)

				if var_324_18 > 0 and var_324_12 < var_324_18 then
					arg_321_1.talkMaxDuration = var_324_18

					if var_324_18 + var_324_11 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_18 + var_324_11
					end
				end

				arg_321_1.text_.text = var_324_15
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221079", "story_v_out_322221.awb") ~= 0 then
					local var_324_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221079", "story_v_out_322221.awb") / 1000

					if var_324_19 + var_324_11 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_19 + var_324_11
					end

					if var_324_14.prefab_name ~= "" and arg_321_1.actors_[var_324_14.prefab_name] ~= nil then
						local var_324_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_14.prefab_name].transform, "story_v_out_322221", "322221079", "story_v_out_322221.awb")

						arg_321_1:RecordAudio("322221079", var_324_20)
						arg_321_1:RecordAudio("322221079", var_324_20)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_322221", "322221079", "story_v_out_322221.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_322221", "322221079", "story_v_out_322221.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_21 = math.max(var_324_12, arg_321_1.talkMaxDuration)

			if var_324_11 <= arg_321_1.time_ and arg_321_1.time_ < var_324_11 + var_324_21 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_11) / var_324_21

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_11 + var_324_21 and arg_321_1.time_ < var_324_11 + var_324_21 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play322221080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 322221080
		arg_325_1.duration_ = 2

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play322221081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1111ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1111ui_story == nil then
				arg_325_1.var_.characterEffect1111ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect1111ui_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1111ui_story then
				arg_325_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_328_4 = arg_325_1.actors_["10131ui_story"]
			local var_328_5 = 0

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect10131ui_story == nil then
				arg_325_1.var_.characterEffect10131ui_story = var_328_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_6 = 0.200000002980232

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_6 and not isNil(var_328_4) then
				local var_328_7 = (arg_325_1.time_ - var_328_5) / var_328_6

				if arg_325_1.var_.characterEffect10131ui_story and not isNil(var_328_4) then
					local var_328_8 = Mathf.Lerp(0, 0.5, var_328_7)

					arg_325_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10131ui_story.fillRatio = var_328_8
				end
			end

			if arg_325_1.time_ >= var_328_5 + var_328_6 and arg_325_1.time_ < var_328_5 + var_328_6 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect10131ui_story then
				local var_328_9 = 0.5

				arg_325_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10131ui_story.fillRatio = var_328_9
			end

			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 then
				arg_325_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_328_11 = 0
			local var_328_12 = 0.125

			if var_328_11 < arg_325_1.time_ and arg_325_1.time_ <= var_328_11 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_13 = arg_325_1:FormatText(StoryNameCfg[67].name)

				arg_325_1.leftNameTxt_.text = var_328_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_14 = arg_325_1:GetWordFromCfg(322221080)
				local var_328_15 = arg_325_1:FormatText(var_328_14.content)

				arg_325_1.text_.text = var_328_15

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_16 = 5
				local var_328_17 = utf8.len(var_328_15)
				local var_328_18 = var_328_16 <= 0 and var_328_12 or var_328_12 * (var_328_17 / var_328_16)

				if var_328_18 > 0 and var_328_12 < var_328_18 then
					arg_325_1.talkMaxDuration = var_328_18

					if var_328_18 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_18 + var_328_11
					end
				end

				arg_325_1.text_.text = var_328_15
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221080", "story_v_out_322221.awb") ~= 0 then
					local var_328_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221080", "story_v_out_322221.awb") / 1000

					if var_328_19 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_19 + var_328_11
					end

					if var_328_14.prefab_name ~= "" and arg_325_1.actors_[var_328_14.prefab_name] ~= nil then
						local var_328_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_14.prefab_name].transform, "story_v_out_322221", "322221080", "story_v_out_322221.awb")

						arg_325_1:RecordAudio("322221080", var_328_20)
						arg_325_1:RecordAudio("322221080", var_328_20)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_322221", "322221080", "story_v_out_322221.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_322221", "322221080", "story_v_out_322221.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_21 = math.max(var_328_12, arg_325_1.talkMaxDuration)

			if var_328_11 <= arg_325_1.time_ and arg_325_1.time_ < var_328_11 + var_328_21 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_11) / var_328_21

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_11 + var_328_21 and arg_325_1.time_ < var_328_11 + var_328_21 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play322221081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 322221081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play322221082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1111ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1111ui_story == nil then
				arg_329_1.var_.characterEffect1111ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1111ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1111ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1111ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1111ui_story.fillRatio = var_332_5
			end

			local var_332_6 = 0
			local var_332_7 = 0.75

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_8 = arg_329_1:GetWordFromCfg(322221081)
				local var_332_9 = arg_329_1:FormatText(var_332_8.content)

				arg_329_1.text_.text = var_332_9

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_10 = 30
				local var_332_11 = utf8.len(var_332_9)
				local var_332_12 = var_332_10 <= 0 and var_332_7 or var_332_7 * (var_332_11 / var_332_10)

				if var_332_12 > 0 and var_332_7 < var_332_12 then
					arg_329_1.talkMaxDuration = var_332_12

					if var_332_12 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_12 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_9
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_13 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_13 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_6) / var_332_13

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_6 + var_332_13 and arg_329_1.time_ < var_332_6 + var_332_13 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play322221082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 322221082
		arg_333_1.duration_ = 4.87

		local var_333_0 = {
			zh = 4.866,
			ja = 4.466
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play322221083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1111ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1111ui_story == nil then
				arg_333_1.var_.characterEffect1111ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1111ui_story and not isNil(var_336_0) then
					arg_333_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1111ui_story then
				arg_333_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_336_4 = 0

			if var_336_4 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_336_5 = 0
			local var_336_6 = 0.425

			if var_336_5 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_7 = arg_333_1:FormatText(StoryNameCfg[67].name)

				arg_333_1.leftNameTxt_.text = var_336_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_8 = arg_333_1:GetWordFromCfg(322221082)
				local var_336_9 = arg_333_1:FormatText(var_336_8.content)

				arg_333_1.text_.text = var_336_9

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 17
				local var_336_11 = utf8.len(var_336_9)
				local var_336_12 = var_336_10 <= 0 and var_336_6 or var_336_6 * (var_336_11 / var_336_10)

				if var_336_12 > 0 and var_336_6 < var_336_12 then
					arg_333_1.talkMaxDuration = var_336_12

					if var_336_12 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_12 + var_336_5
					end
				end

				arg_333_1.text_.text = var_336_9
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221082", "story_v_out_322221.awb") ~= 0 then
					local var_336_13 = manager.audio:GetVoiceLength("story_v_out_322221", "322221082", "story_v_out_322221.awb") / 1000

					if var_336_13 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_5
					end

					if var_336_8.prefab_name ~= "" and arg_333_1.actors_[var_336_8.prefab_name] ~= nil then
						local var_336_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_8.prefab_name].transform, "story_v_out_322221", "322221082", "story_v_out_322221.awb")

						arg_333_1:RecordAudio("322221082", var_336_14)
						arg_333_1:RecordAudio("322221082", var_336_14)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_322221", "322221082", "story_v_out_322221.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_322221", "322221082", "story_v_out_322221.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_15 = math.max(var_336_6, arg_333_1.talkMaxDuration)

			if var_336_5 <= arg_333_1.time_ and arg_333_1.time_ < var_336_5 + var_336_15 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_5) / var_336_15

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_5 + var_336_15 and arg_333_1.time_ < var_336_5 + var_336_15 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play322221083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 322221083
		arg_337_1.duration_ = 4.43

		local var_337_0 = {
			zh = 4.433,
			ja = 3.933
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play322221084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["10131ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect10131ui_story == nil then
				arg_337_1.var_.characterEffect10131ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect10131ui_story and not isNil(var_340_0) then
					arg_337_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect10131ui_story then
				arg_337_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_340_4 = arg_337_1.actors_["1111ui_story"]
			local var_340_5 = 0

			if var_340_5 < arg_337_1.time_ and arg_337_1.time_ <= var_340_5 + arg_340_0 and not isNil(var_340_4) and arg_337_1.var_.characterEffect1111ui_story == nil then
				arg_337_1.var_.characterEffect1111ui_story = var_340_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_6 = 0.200000002980232

			if var_340_5 <= arg_337_1.time_ and arg_337_1.time_ < var_340_5 + var_340_6 and not isNil(var_340_4) then
				local var_340_7 = (arg_337_1.time_ - var_340_5) / var_340_6

				if arg_337_1.var_.characterEffect1111ui_story and not isNil(var_340_4) then
					local var_340_8 = Mathf.Lerp(0, 0.5, var_340_7)

					arg_337_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1111ui_story.fillRatio = var_340_8
				end
			end

			if arg_337_1.time_ >= var_340_5 + var_340_6 and arg_337_1.time_ < var_340_5 + var_340_6 + arg_340_0 and not isNil(var_340_4) and arg_337_1.var_.characterEffect1111ui_story then
				local var_340_9 = 0.5

				arg_337_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1111ui_story.fillRatio = var_340_9
			end

			local var_340_10 = 0

			if var_340_10 < arg_337_1.time_ and arg_337_1.time_ <= var_340_10 + arg_340_0 then
				arg_337_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_340_11 = 0
			local var_340_12 = 0.375

			if var_340_11 < arg_337_1.time_ and arg_337_1.time_ <= var_340_11 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_13 = arg_337_1:FormatText(StoryNameCfg[1366].name)

				arg_337_1.leftNameTxt_.text = var_340_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_14 = arg_337_1:GetWordFromCfg(322221083)
				local var_340_15 = arg_337_1:FormatText(var_340_14.content)

				arg_337_1.text_.text = var_340_15

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_16 = 15
				local var_340_17 = utf8.len(var_340_15)
				local var_340_18 = var_340_16 <= 0 and var_340_12 or var_340_12 * (var_340_17 / var_340_16)

				if var_340_18 > 0 and var_340_12 < var_340_18 then
					arg_337_1.talkMaxDuration = var_340_18

					if var_340_18 + var_340_11 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_18 + var_340_11
					end
				end

				arg_337_1.text_.text = var_340_15
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221083", "story_v_out_322221.awb") ~= 0 then
					local var_340_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221083", "story_v_out_322221.awb") / 1000

					if var_340_19 + var_340_11 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_19 + var_340_11
					end

					if var_340_14.prefab_name ~= "" and arg_337_1.actors_[var_340_14.prefab_name] ~= nil then
						local var_340_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_14.prefab_name].transform, "story_v_out_322221", "322221083", "story_v_out_322221.awb")

						arg_337_1:RecordAudio("322221083", var_340_20)
						arg_337_1:RecordAudio("322221083", var_340_20)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_322221", "322221083", "story_v_out_322221.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_322221", "322221083", "story_v_out_322221.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_21 = math.max(var_340_12, arg_337_1.talkMaxDuration)

			if var_340_11 <= arg_337_1.time_ and arg_337_1.time_ < var_340_11 + var_340_21 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_11) / var_340_21

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_11 + var_340_21 and arg_337_1.time_ < var_340_11 + var_340_21 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play322221084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 322221084
		arg_341_1.duration_ = 3.37

		local var_341_0 = {
			zh = 1.733,
			ja = 3.366
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play322221085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1111ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1111ui_story == nil then
				arg_341_1.var_.characterEffect1111ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect1111ui_story and not isNil(var_344_0) then
					arg_341_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1111ui_story then
				arg_341_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_344_4 = arg_341_1.actors_["10131ui_story"]
			local var_344_5 = 0

			if var_344_5 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 and not isNil(var_344_4) and arg_341_1.var_.characterEffect10131ui_story == nil then
				arg_341_1.var_.characterEffect10131ui_story = var_344_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_6 = 0.200000002980232

			if var_344_5 <= arg_341_1.time_ and arg_341_1.time_ < var_344_5 + var_344_6 and not isNil(var_344_4) then
				local var_344_7 = (arg_341_1.time_ - var_344_5) / var_344_6

				if arg_341_1.var_.characterEffect10131ui_story and not isNil(var_344_4) then
					local var_344_8 = Mathf.Lerp(0, 0.5, var_344_7)

					arg_341_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_341_1.var_.characterEffect10131ui_story.fillRatio = var_344_8
				end
			end

			if arg_341_1.time_ >= var_344_5 + var_344_6 and arg_341_1.time_ < var_344_5 + var_344_6 + arg_344_0 and not isNil(var_344_4) and arg_341_1.var_.characterEffect10131ui_story then
				local var_344_9 = 0.5

				arg_341_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_341_1.var_.characterEffect10131ui_story.fillRatio = var_344_9
			end

			local var_344_10 = 0
			local var_344_11 = 0.175

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_12 = arg_341_1:FormatText(StoryNameCfg[67].name)

				arg_341_1.leftNameTxt_.text = var_344_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_13 = arg_341_1:GetWordFromCfg(322221084)
				local var_344_14 = arg_341_1:FormatText(var_344_13.content)

				arg_341_1.text_.text = var_344_14

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_15 = 7
				local var_344_16 = utf8.len(var_344_14)
				local var_344_17 = var_344_15 <= 0 and var_344_11 or var_344_11 * (var_344_16 / var_344_15)

				if var_344_17 > 0 and var_344_11 < var_344_17 then
					arg_341_1.talkMaxDuration = var_344_17

					if var_344_17 + var_344_10 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_17 + var_344_10
					end
				end

				arg_341_1.text_.text = var_344_14
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221084", "story_v_out_322221.awb") ~= 0 then
					local var_344_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221084", "story_v_out_322221.awb") / 1000

					if var_344_18 + var_344_10 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_18 + var_344_10
					end

					if var_344_13.prefab_name ~= "" and arg_341_1.actors_[var_344_13.prefab_name] ~= nil then
						local var_344_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_13.prefab_name].transform, "story_v_out_322221", "322221084", "story_v_out_322221.awb")

						arg_341_1:RecordAudio("322221084", var_344_19)
						arg_341_1:RecordAudio("322221084", var_344_19)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_322221", "322221084", "story_v_out_322221.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_322221", "322221084", "story_v_out_322221.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_20 = math.max(var_344_11, arg_341_1.talkMaxDuration)

			if var_344_10 <= arg_341_1.time_ and arg_341_1.time_ < var_344_10 + var_344_20 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_10) / var_344_20

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_10 + var_344_20 and arg_341_1.time_ < var_344_10 + var_344_20 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play322221085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 322221085
		arg_345_1.duration_ = 7.9

		local var_345_0 = {
			zh = 5.133,
			ja = 7.9
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play322221086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0
			local var_348_1 = 0.675

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_2 = arg_345_1:FormatText(StoryNameCfg[67].name)

				arg_345_1.leftNameTxt_.text = var_348_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_3 = arg_345_1:GetWordFromCfg(322221085)
				local var_348_4 = arg_345_1:FormatText(var_348_3.content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 27
				local var_348_6 = utf8.len(var_348_4)
				local var_348_7 = var_348_5 <= 0 and var_348_1 or var_348_1 * (var_348_6 / var_348_5)

				if var_348_7 > 0 and var_348_1 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221085", "story_v_out_322221.awb") ~= 0 then
					local var_348_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221085", "story_v_out_322221.awb") / 1000

					if var_348_8 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_8 + var_348_0
					end

					if var_348_3.prefab_name ~= "" and arg_345_1.actors_[var_348_3.prefab_name] ~= nil then
						local var_348_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_3.prefab_name].transform, "story_v_out_322221", "322221085", "story_v_out_322221.awb")

						arg_345_1:RecordAudio("322221085", var_348_9)
						arg_345_1:RecordAudio("322221085", var_348_9)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_322221", "322221085", "story_v_out_322221.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_322221", "322221085", "story_v_out_322221.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_10 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_10 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_10

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_10 and arg_345_1.time_ < var_348_0 + var_348_10 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play322221086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 322221086
		arg_349_1.duration_ = 4.53

		local var_349_0 = {
			zh = 3.433,
			ja = 4.533
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play322221087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["10131ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect10131ui_story == nil then
				arg_349_1.var_.characterEffect10131ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect10131ui_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect10131ui_story then
				arg_349_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_352_4 = arg_349_1.actors_["1111ui_story"]
			local var_352_5 = 0

			if var_352_5 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 and not isNil(var_352_4) and arg_349_1.var_.characterEffect1111ui_story == nil then
				arg_349_1.var_.characterEffect1111ui_story = var_352_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_6 = 0.200000002980232

			if var_352_5 <= arg_349_1.time_ and arg_349_1.time_ < var_352_5 + var_352_6 and not isNil(var_352_4) then
				local var_352_7 = (arg_349_1.time_ - var_352_5) / var_352_6

				if arg_349_1.var_.characterEffect1111ui_story and not isNil(var_352_4) then
					local var_352_8 = Mathf.Lerp(0, 0.5, var_352_7)

					arg_349_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1111ui_story.fillRatio = var_352_8
				end
			end

			if arg_349_1.time_ >= var_352_5 + var_352_6 and arg_349_1.time_ < var_352_5 + var_352_6 + arg_352_0 and not isNil(var_352_4) and arg_349_1.var_.characterEffect1111ui_story then
				local var_352_9 = 0.5

				arg_349_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1111ui_story.fillRatio = var_352_9
			end

			local var_352_10 = 0

			if var_352_10 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 then
				arg_349_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_1")
			end

			local var_352_11 = 0
			local var_352_12 = 0.475

			if var_352_11 < arg_349_1.time_ and arg_349_1.time_ <= var_352_11 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_13 = arg_349_1:FormatText(StoryNameCfg[1366].name)

				arg_349_1.leftNameTxt_.text = var_352_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_14 = arg_349_1:GetWordFromCfg(322221086)
				local var_352_15 = arg_349_1:FormatText(var_352_14.content)

				arg_349_1.text_.text = var_352_15

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_16 = 19
				local var_352_17 = utf8.len(var_352_15)
				local var_352_18 = var_352_16 <= 0 and var_352_12 or var_352_12 * (var_352_17 / var_352_16)

				if var_352_18 > 0 and var_352_12 < var_352_18 then
					arg_349_1.talkMaxDuration = var_352_18

					if var_352_18 + var_352_11 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_18 + var_352_11
					end
				end

				arg_349_1.text_.text = var_352_15
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221086", "story_v_out_322221.awb") ~= 0 then
					local var_352_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221086", "story_v_out_322221.awb") / 1000

					if var_352_19 + var_352_11 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_19 + var_352_11
					end

					if var_352_14.prefab_name ~= "" and arg_349_1.actors_[var_352_14.prefab_name] ~= nil then
						local var_352_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_14.prefab_name].transform, "story_v_out_322221", "322221086", "story_v_out_322221.awb")

						arg_349_1:RecordAudio("322221086", var_352_20)
						arg_349_1:RecordAudio("322221086", var_352_20)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_322221", "322221086", "story_v_out_322221.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_322221", "322221086", "story_v_out_322221.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_21 = math.max(var_352_12, arg_349_1.talkMaxDuration)

			if var_352_11 <= arg_349_1.time_ and arg_349_1.time_ < var_352_11 + var_352_21 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_11) / var_352_21

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_11 + var_352_21 and arg_349_1.time_ < var_352_11 + var_352_21 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play322221087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 322221087
		arg_353_1.duration_ = 8

		local var_353_0 = {
			zh = 7.5,
			ja = 8
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play322221088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1111ui_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1111ui_story == nil then
				arg_353_1.var_.characterEffect1111ui_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect1111ui_story and not isNil(var_356_0) then
					arg_353_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect1111ui_story then
				arg_353_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_356_4 = arg_353_1.actors_["10131ui_story"]
			local var_356_5 = 0

			if var_356_5 < arg_353_1.time_ and arg_353_1.time_ <= var_356_5 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect10131ui_story == nil then
				arg_353_1.var_.characterEffect10131ui_story = var_356_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_6 = 0.200000002980232

			if var_356_5 <= arg_353_1.time_ and arg_353_1.time_ < var_356_5 + var_356_6 and not isNil(var_356_4) then
				local var_356_7 = (arg_353_1.time_ - var_356_5) / var_356_6

				if arg_353_1.var_.characterEffect10131ui_story and not isNil(var_356_4) then
					local var_356_8 = Mathf.Lerp(0, 0.5, var_356_7)

					arg_353_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_353_1.var_.characterEffect10131ui_story.fillRatio = var_356_8
				end
			end

			if arg_353_1.time_ >= var_356_5 + var_356_6 and arg_353_1.time_ < var_356_5 + var_356_6 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect10131ui_story then
				local var_356_9 = 0.5

				arg_353_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_353_1.var_.characterEffect10131ui_story.fillRatio = var_356_9
			end

			local var_356_10 = 0
			local var_356_11 = 0.825

			if var_356_10 < arg_353_1.time_ and arg_353_1.time_ <= var_356_10 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_12 = arg_353_1:FormatText(StoryNameCfg[67].name)

				arg_353_1.leftNameTxt_.text = var_356_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_13 = arg_353_1:GetWordFromCfg(322221087)
				local var_356_14 = arg_353_1:FormatText(var_356_13.content)

				arg_353_1.text_.text = var_356_14

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_15 = 33
				local var_356_16 = utf8.len(var_356_14)
				local var_356_17 = var_356_15 <= 0 and var_356_11 or var_356_11 * (var_356_16 / var_356_15)

				if var_356_17 > 0 and var_356_11 < var_356_17 then
					arg_353_1.talkMaxDuration = var_356_17

					if var_356_17 + var_356_10 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_17 + var_356_10
					end
				end

				arg_353_1.text_.text = var_356_14
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221087", "story_v_out_322221.awb") ~= 0 then
					local var_356_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221087", "story_v_out_322221.awb") / 1000

					if var_356_18 + var_356_10 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_18 + var_356_10
					end

					if var_356_13.prefab_name ~= "" and arg_353_1.actors_[var_356_13.prefab_name] ~= nil then
						local var_356_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_13.prefab_name].transform, "story_v_out_322221", "322221087", "story_v_out_322221.awb")

						arg_353_1:RecordAudio("322221087", var_356_19)
						arg_353_1:RecordAudio("322221087", var_356_19)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_322221", "322221087", "story_v_out_322221.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_322221", "322221087", "story_v_out_322221.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_20 = math.max(var_356_11, arg_353_1.talkMaxDuration)

			if var_356_10 <= arg_353_1.time_ and arg_353_1.time_ < var_356_10 + var_356_20 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_10) / var_356_20

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_10 + var_356_20 and arg_353_1.time_ < var_356_10 + var_356_20 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play322221088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 322221088
		arg_357_1.duration_ = 9.77

		local var_357_0 = {
			zh = 5.666,
			ja = 9.766
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play322221089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["10131ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect10131ui_story == nil then
				arg_357_1.var_.characterEffect10131ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect10131ui_story and not isNil(var_360_0) then
					arg_357_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect10131ui_story then
				arg_357_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_360_4 = arg_357_1.actors_["1111ui_story"]
			local var_360_5 = 0

			if var_360_5 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 and not isNil(var_360_4) and arg_357_1.var_.characterEffect1111ui_story == nil then
				arg_357_1.var_.characterEffect1111ui_story = var_360_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_6 = 0.200000002980232

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_6 and not isNil(var_360_4) then
				local var_360_7 = (arg_357_1.time_ - var_360_5) / var_360_6

				if arg_357_1.var_.characterEffect1111ui_story and not isNil(var_360_4) then
					local var_360_8 = Mathf.Lerp(0, 0.5, var_360_7)

					arg_357_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1111ui_story.fillRatio = var_360_8
				end
			end

			if arg_357_1.time_ >= var_360_5 + var_360_6 and arg_357_1.time_ < var_360_5 + var_360_6 + arg_360_0 and not isNil(var_360_4) and arg_357_1.var_.characterEffect1111ui_story then
				local var_360_9 = 0.5

				arg_357_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1111ui_story.fillRatio = var_360_9
			end

			local var_360_10 = 0
			local var_360_11 = 0.625

			if var_360_10 < arg_357_1.time_ and arg_357_1.time_ <= var_360_10 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_12 = arg_357_1:FormatText(StoryNameCfg[1366].name)

				arg_357_1.leftNameTxt_.text = var_360_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_13 = arg_357_1:GetWordFromCfg(322221088)
				local var_360_14 = arg_357_1:FormatText(var_360_13.content)

				arg_357_1.text_.text = var_360_14

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_15 = 25
				local var_360_16 = utf8.len(var_360_14)
				local var_360_17 = var_360_15 <= 0 and var_360_11 or var_360_11 * (var_360_16 / var_360_15)

				if var_360_17 > 0 and var_360_11 < var_360_17 then
					arg_357_1.talkMaxDuration = var_360_17

					if var_360_17 + var_360_10 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_17 + var_360_10
					end
				end

				arg_357_1.text_.text = var_360_14
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221088", "story_v_out_322221.awb") ~= 0 then
					local var_360_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221088", "story_v_out_322221.awb") / 1000

					if var_360_18 + var_360_10 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_18 + var_360_10
					end

					if var_360_13.prefab_name ~= "" and arg_357_1.actors_[var_360_13.prefab_name] ~= nil then
						local var_360_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_13.prefab_name].transform, "story_v_out_322221", "322221088", "story_v_out_322221.awb")

						arg_357_1:RecordAudio("322221088", var_360_19)
						arg_357_1:RecordAudio("322221088", var_360_19)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_322221", "322221088", "story_v_out_322221.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_322221", "322221088", "story_v_out_322221.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_20 = math.max(var_360_11, arg_357_1.talkMaxDuration)

			if var_360_10 <= arg_357_1.time_ and arg_357_1.time_ < var_360_10 + var_360_20 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_10) / var_360_20

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_10 + var_360_20 and arg_357_1.time_ < var_360_10 + var_360_20 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play322221089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 322221089
		arg_361_1.duration_ = 12.5

		local var_361_0 = {
			zh = 9.266,
			ja = 12.5
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play322221090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			local var_364_1 = 0
			local var_364_2 = 1

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_3 = arg_361_1:FormatText(StoryNameCfg[1366].name)

				arg_361_1.leftNameTxt_.text = var_364_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_4 = arg_361_1:GetWordFromCfg(322221089)
				local var_364_5 = arg_361_1:FormatText(var_364_4.content)

				arg_361_1.text_.text = var_364_5

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_6 = 40
				local var_364_7 = utf8.len(var_364_5)
				local var_364_8 = var_364_6 <= 0 and var_364_2 or var_364_2 * (var_364_7 / var_364_6)

				if var_364_8 > 0 and var_364_2 < var_364_8 then
					arg_361_1.talkMaxDuration = var_364_8

					if var_364_8 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_8 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_5
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221089", "story_v_out_322221.awb") ~= 0 then
					local var_364_9 = manager.audio:GetVoiceLength("story_v_out_322221", "322221089", "story_v_out_322221.awb") / 1000

					if var_364_9 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_9 + var_364_1
					end

					if var_364_4.prefab_name ~= "" and arg_361_1.actors_[var_364_4.prefab_name] ~= nil then
						local var_364_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_4.prefab_name].transform, "story_v_out_322221", "322221089", "story_v_out_322221.awb")

						arg_361_1:RecordAudio("322221089", var_364_10)
						arg_361_1:RecordAudio("322221089", var_364_10)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_322221", "322221089", "story_v_out_322221.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_322221", "322221089", "story_v_out_322221.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_11 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_11 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_11

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_11 and arg_361_1.time_ < var_364_1 + var_364_11 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play322221090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 322221090
		arg_365_1.duration_ = 4.5

		local var_365_0 = {
			zh = 3.033,
			ja = 4.5
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play322221091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1111ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1111ui_story == nil then
				arg_365_1.var_.characterEffect1111ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect1111ui_story and not isNil(var_368_0) then
					arg_365_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1111ui_story then
				arg_365_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_368_4 = arg_365_1.actors_["10131ui_story"]
			local var_368_5 = 0

			if var_368_5 < arg_365_1.time_ and arg_365_1.time_ <= var_368_5 + arg_368_0 and not isNil(var_368_4) and arg_365_1.var_.characterEffect10131ui_story == nil then
				arg_365_1.var_.characterEffect10131ui_story = var_368_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_6 = 0.200000002980232

			if var_368_5 <= arg_365_1.time_ and arg_365_1.time_ < var_368_5 + var_368_6 and not isNil(var_368_4) then
				local var_368_7 = (arg_365_1.time_ - var_368_5) / var_368_6

				if arg_365_1.var_.characterEffect10131ui_story and not isNil(var_368_4) then
					local var_368_8 = Mathf.Lerp(0, 0.5, var_368_7)

					arg_365_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_365_1.var_.characterEffect10131ui_story.fillRatio = var_368_8
				end
			end

			if arg_365_1.time_ >= var_368_5 + var_368_6 and arg_365_1.time_ < var_368_5 + var_368_6 + arg_368_0 and not isNil(var_368_4) and arg_365_1.var_.characterEffect10131ui_story then
				local var_368_9 = 0.5

				arg_365_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_365_1.var_.characterEffect10131ui_story.fillRatio = var_368_9
			end

			local var_368_10 = 0

			if var_368_10 < arg_365_1.time_ and arg_365_1.time_ <= var_368_10 + arg_368_0 then
				arg_365_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_368_11 = 0
			local var_368_12 = 0.225

			if var_368_11 < arg_365_1.time_ and arg_365_1.time_ <= var_368_11 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_13 = arg_365_1:FormatText(StoryNameCfg[67].name)

				arg_365_1.leftNameTxt_.text = var_368_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_14 = arg_365_1:GetWordFromCfg(322221090)
				local var_368_15 = arg_365_1:FormatText(var_368_14.content)

				arg_365_1.text_.text = var_368_15

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_16 = 9
				local var_368_17 = utf8.len(var_368_15)
				local var_368_18 = var_368_16 <= 0 and var_368_12 or var_368_12 * (var_368_17 / var_368_16)

				if var_368_18 > 0 and var_368_12 < var_368_18 then
					arg_365_1.talkMaxDuration = var_368_18

					if var_368_18 + var_368_11 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_18 + var_368_11
					end
				end

				arg_365_1.text_.text = var_368_15
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221090", "story_v_out_322221.awb") ~= 0 then
					local var_368_19 = manager.audio:GetVoiceLength("story_v_out_322221", "322221090", "story_v_out_322221.awb") / 1000

					if var_368_19 + var_368_11 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_19 + var_368_11
					end

					if var_368_14.prefab_name ~= "" and arg_365_1.actors_[var_368_14.prefab_name] ~= nil then
						local var_368_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_14.prefab_name].transform, "story_v_out_322221", "322221090", "story_v_out_322221.awb")

						arg_365_1:RecordAudio("322221090", var_368_20)
						arg_365_1:RecordAudio("322221090", var_368_20)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_322221", "322221090", "story_v_out_322221.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_322221", "322221090", "story_v_out_322221.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_21 = math.max(var_368_12, arg_365_1.talkMaxDuration)

			if var_368_11 <= arg_365_1.time_ and arg_365_1.time_ < var_368_11 + var_368_21 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_11) / var_368_21

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_11 + var_368_21 and arg_365_1.time_ < var_368_11 + var_368_21 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play322221091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 322221091
		arg_369_1.duration_ = 4.53

		local var_369_0 = {
			zh = 3.566,
			ja = 4.533
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play322221092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0
			local var_372_1 = 0.45

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_2 = arg_369_1:FormatText(StoryNameCfg[67].name)

				arg_369_1.leftNameTxt_.text = var_372_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_3 = arg_369_1:GetWordFromCfg(322221091)
				local var_372_4 = arg_369_1:FormatText(var_372_3.content)

				arg_369_1.text_.text = var_372_4

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 18
				local var_372_6 = utf8.len(var_372_4)
				local var_372_7 = var_372_5 <= 0 and var_372_1 or var_372_1 * (var_372_6 / var_372_5)

				if var_372_7 > 0 and var_372_1 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_0
					end
				end

				arg_369_1.text_.text = var_372_4
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221091", "story_v_out_322221.awb") ~= 0 then
					local var_372_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221091", "story_v_out_322221.awb") / 1000

					if var_372_8 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_0
					end

					if var_372_3.prefab_name ~= "" and arg_369_1.actors_[var_372_3.prefab_name] ~= nil then
						local var_372_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_3.prefab_name].transform, "story_v_out_322221", "322221091", "story_v_out_322221.awb")

						arg_369_1:RecordAudio("322221091", var_372_9)
						arg_369_1:RecordAudio("322221091", var_372_9)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_322221", "322221091", "story_v_out_322221.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_322221", "322221091", "story_v_out_322221.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_1, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_0) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_10 and arg_369_1.time_ < var_372_0 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play322221092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 322221092
		arg_373_1.duration_ = 10.73

		local var_373_0 = {
			zh = 6.666,
			ja = 10.733
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play322221093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_376_1 = 0
			local var_376_2 = 0.7

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_3 = arg_373_1:FormatText(StoryNameCfg[67].name)

				arg_373_1.leftNameTxt_.text = var_376_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(322221092)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_6 = 29
				local var_376_7 = utf8.len(var_376_5)
				local var_376_8 = var_376_6 <= 0 and var_376_2 or var_376_2 * (var_376_7 / var_376_6)

				if var_376_8 > 0 and var_376_2 < var_376_8 then
					arg_373_1.talkMaxDuration = var_376_8

					if var_376_8 + var_376_1 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_1
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221092", "story_v_out_322221.awb") ~= 0 then
					local var_376_9 = manager.audio:GetVoiceLength("story_v_out_322221", "322221092", "story_v_out_322221.awb") / 1000

					if var_376_9 + var_376_1 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_9 + var_376_1
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_out_322221", "322221092", "story_v_out_322221.awb")

						arg_373_1:RecordAudio("322221092", var_376_10)
						arg_373_1:RecordAudio("322221092", var_376_10)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_322221", "322221092", "story_v_out_322221.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_322221", "322221092", "story_v_out_322221.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_11 = math.max(var_376_2, arg_373_1.talkMaxDuration)

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_11 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_1) / var_376_11

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_1 + var_376_11 and arg_373_1.time_ < var_376_1 + var_376_11 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play322221093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 322221093
		arg_377_1.duration_ = 2.97

		local var_377_0 = {
			zh = 2.233,
			ja = 2.966
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play322221094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["10131ui_story"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect10131ui_story == nil then
				arg_377_1.var_.characterEffect10131ui_story = var_380_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.200000002980232

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.characterEffect10131ui_story and not isNil(var_380_0) then
					arg_377_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.characterEffect10131ui_story then
				arg_377_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_380_4 = arg_377_1.actors_["1111ui_story"]
			local var_380_5 = 0

			if var_380_5 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 and not isNil(var_380_4) and arg_377_1.var_.characterEffect1111ui_story == nil then
				arg_377_1.var_.characterEffect1111ui_story = var_380_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_6 = 0.200000002980232

			if var_380_5 <= arg_377_1.time_ and arg_377_1.time_ < var_380_5 + var_380_6 and not isNil(var_380_4) then
				local var_380_7 = (arg_377_1.time_ - var_380_5) / var_380_6

				if arg_377_1.var_.characterEffect1111ui_story and not isNil(var_380_4) then
					local var_380_8 = Mathf.Lerp(0, 0.5, var_380_7)

					arg_377_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1111ui_story.fillRatio = var_380_8
				end
			end

			if arg_377_1.time_ >= var_380_5 + var_380_6 and arg_377_1.time_ < var_380_5 + var_380_6 + arg_380_0 and not isNil(var_380_4) and arg_377_1.var_.characterEffect1111ui_story then
				local var_380_9 = 0.5

				arg_377_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1111ui_story.fillRatio = var_380_9
			end

			local var_380_10 = 0
			local var_380_11 = 0.175

			if var_380_10 < arg_377_1.time_ and arg_377_1.time_ <= var_380_10 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_12 = arg_377_1:FormatText(StoryNameCfg[1366].name)

				arg_377_1.leftNameTxt_.text = var_380_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_13 = arg_377_1:GetWordFromCfg(322221093)
				local var_380_14 = arg_377_1:FormatText(var_380_13.content)

				arg_377_1.text_.text = var_380_14

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_15 = 7
				local var_380_16 = utf8.len(var_380_14)
				local var_380_17 = var_380_15 <= 0 and var_380_11 or var_380_11 * (var_380_16 / var_380_15)

				if var_380_17 > 0 and var_380_11 < var_380_17 then
					arg_377_1.talkMaxDuration = var_380_17

					if var_380_17 + var_380_10 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_17 + var_380_10
					end
				end

				arg_377_1.text_.text = var_380_14
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221093", "story_v_out_322221.awb") ~= 0 then
					local var_380_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221093", "story_v_out_322221.awb") / 1000

					if var_380_18 + var_380_10 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_18 + var_380_10
					end

					if var_380_13.prefab_name ~= "" and arg_377_1.actors_[var_380_13.prefab_name] ~= nil then
						local var_380_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_13.prefab_name].transform, "story_v_out_322221", "322221093", "story_v_out_322221.awb")

						arg_377_1:RecordAudio("322221093", var_380_19)
						arg_377_1:RecordAudio("322221093", var_380_19)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_322221", "322221093", "story_v_out_322221.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_322221", "322221093", "story_v_out_322221.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_20 = math.max(var_380_11, arg_377_1.talkMaxDuration)

			if var_380_10 <= arg_377_1.time_ and arg_377_1.time_ < var_380_10 + var_380_20 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_10) / var_380_20

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_10 + var_380_20 and arg_377_1.time_ < var_380_10 + var_380_20 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play322221094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 322221094
		arg_381_1.duration_ = 1.7

		local var_381_0 = {
			zh = 1.233,
			ja = 1.7
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play322221095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1111ui_story"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1111ui_story == nil then
				arg_381_1.var_.characterEffect1111ui_story = var_384_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.characterEffect1111ui_story and not isNil(var_384_0) then
					arg_381_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.characterEffect1111ui_story then
				arg_381_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_384_4 = arg_381_1.actors_["10131ui_story"]
			local var_384_5 = 0

			if var_384_5 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 and not isNil(var_384_4) and arg_381_1.var_.characterEffect10131ui_story == nil then
				arg_381_1.var_.characterEffect10131ui_story = var_384_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_6 = 0.200000002980232

			if var_384_5 <= arg_381_1.time_ and arg_381_1.time_ < var_384_5 + var_384_6 and not isNil(var_384_4) then
				local var_384_7 = (arg_381_1.time_ - var_384_5) / var_384_6

				if arg_381_1.var_.characterEffect10131ui_story and not isNil(var_384_4) then
					local var_384_8 = Mathf.Lerp(0, 0.5, var_384_7)

					arg_381_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_381_1.var_.characterEffect10131ui_story.fillRatio = var_384_8
				end
			end

			if arg_381_1.time_ >= var_384_5 + var_384_6 and arg_381_1.time_ < var_384_5 + var_384_6 + arg_384_0 and not isNil(var_384_4) and arg_381_1.var_.characterEffect10131ui_story then
				local var_384_9 = 0.5

				arg_381_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_381_1.var_.characterEffect10131ui_story.fillRatio = var_384_9
			end

			local var_384_10 = 0
			local var_384_11 = 0.1

			if var_384_10 < arg_381_1.time_ and arg_381_1.time_ <= var_384_10 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_12 = arg_381_1:FormatText(StoryNameCfg[67].name)

				arg_381_1.leftNameTxt_.text = var_384_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_13 = arg_381_1:GetWordFromCfg(322221094)
				local var_384_14 = arg_381_1:FormatText(var_384_13.content)

				arg_381_1.text_.text = var_384_14

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_15 = 4
				local var_384_16 = utf8.len(var_384_14)
				local var_384_17 = var_384_15 <= 0 and var_384_11 or var_384_11 * (var_384_16 / var_384_15)

				if var_384_17 > 0 and var_384_11 < var_384_17 then
					arg_381_1.talkMaxDuration = var_384_17

					if var_384_17 + var_384_10 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_17 + var_384_10
					end
				end

				arg_381_1.text_.text = var_384_14
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221094", "story_v_out_322221.awb") ~= 0 then
					local var_384_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221094", "story_v_out_322221.awb") / 1000

					if var_384_18 + var_384_10 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_18 + var_384_10
					end

					if var_384_13.prefab_name ~= "" and arg_381_1.actors_[var_384_13.prefab_name] ~= nil then
						local var_384_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_13.prefab_name].transform, "story_v_out_322221", "322221094", "story_v_out_322221.awb")

						arg_381_1:RecordAudio("322221094", var_384_19)
						arg_381_1:RecordAudio("322221094", var_384_19)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_322221", "322221094", "story_v_out_322221.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_322221", "322221094", "story_v_out_322221.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_20 = math.max(var_384_11, arg_381_1.talkMaxDuration)

			if var_384_10 <= arg_381_1.time_ and arg_381_1.time_ < var_384_10 + var_384_20 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_10) / var_384_20

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_10 + var_384_20 and arg_381_1.time_ < var_384_10 + var_384_20 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play322221095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 322221095
		arg_385_1.duration_ = 1.43

		local var_385_0 = {
			zh = 1.166,
			ja = 1.433
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play322221096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["10131ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect10131ui_story == nil then
				arg_385_1.var_.characterEffect10131ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect10131ui_story and not isNil(var_388_0) then
					arg_385_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect10131ui_story then
				arg_385_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_388_4 = arg_385_1.actors_["1111ui_story"]
			local var_388_5 = 0

			if var_388_5 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 and not isNil(var_388_4) and arg_385_1.var_.characterEffect1111ui_story == nil then
				arg_385_1.var_.characterEffect1111ui_story = var_388_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_6 = 0.200000002980232

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_6 and not isNil(var_388_4) then
				local var_388_7 = (arg_385_1.time_ - var_388_5) / var_388_6

				if arg_385_1.var_.characterEffect1111ui_story and not isNil(var_388_4) then
					local var_388_8 = Mathf.Lerp(0, 0.5, var_388_7)

					arg_385_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1111ui_story.fillRatio = var_388_8
				end
			end

			if arg_385_1.time_ >= var_388_5 + var_388_6 and arg_385_1.time_ < var_388_5 + var_388_6 + arg_388_0 and not isNil(var_388_4) and arg_385_1.var_.characterEffect1111ui_story then
				local var_388_9 = 0.5

				arg_385_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1111ui_story.fillRatio = var_388_9
			end

			local var_388_10 = 0
			local var_388_11 = 0.1

			if var_388_10 < arg_385_1.time_ and arg_385_1.time_ <= var_388_10 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_12 = arg_385_1:FormatText(StoryNameCfg[1366].name)

				arg_385_1.leftNameTxt_.text = var_388_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_13 = arg_385_1:GetWordFromCfg(322221095)
				local var_388_14 = arg_385_1:FormatText(var_388_13.content)

				arg_385_1.text_.text = var_388_14

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_15 = 4
				local var_388_16 = utf8.len(var_388_14)
				local var_388_17 = var_388_15 <= 0 and var_388_11 or var_388_11 * (var_388_16 / var_388_15)

				if var_388_17 > 0 and var_388_11 < var_388_17 then
					arg_385_1.talkMaxDuration = var_388_17

					if var_388_17 + var_388_10 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_17 + var_388_10
					end
				end

				arg_385_1.text_.text = var_388_14
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221095", "story_v_out_322221.awb") ~= 0 then
					local var_388_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221095", "story_v_out_322221.awb") / 1000

					if var_388_18 + var_388_10 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_18 + var_388_10
					end

					if var_388_13.prefab_name ~= "" and arg_385_1.actors_[var_388_13.prefab_name] ~= nil then
						local var_388_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_13.prefab_name].transform, "story_v_out_322221", "322221095", "story_v_out_322221.awb")

						arg_385_1:RecordAudio("322221095", var_388_19)
						arg_385_1:RecordAudio("322221095", var_388_19)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_322221", "322221095", "story_v_out_322221.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_322221", "322221095", "story_v_out_322221.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_20 = math.max(var_388_11, arg_385_1.talkMaxDuration)

			if var_388_10 <= arg_385_1.time_ and arg_385_1.time_ < var_388_10 + var_388_20 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_10) / var_388_20

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_10 + var_388_20 and arg_385_1.time_ < var_388_10 + var_388_20 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play322221096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 322221096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play322221097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["10131ui_story"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect10131ui_story == nil then
				arg_389_1.var_.characterEffect10131ui_story = var_392_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.characterEffect10131ui_story and not isNil(var_392_0) then
					local var_392_4 = Mathf.Lerp(0, 0.5, var_392_3)

					arg_389_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_389_1.var_.characterEffect10131ui_story.fillRatio = var_392_4
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect10131ui_story then
				local var_392_5 = 0.5

				arg_389_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_389_1.var_.characterEffect10131ui_story.fillRatio = var_392_5
			end

			local var_392_6 = 0
			local var_392_7 = 1.3

			if var_392_6 < arg_389_1.time_ and arg_389_1.time_ <= var_392_6 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_8 = arg_389_1:GetWordFromCfg(322221096)
				local var_392_9 = arg_389_1:FormatText(var_392_8.content)

				arg_389_1.text_.text = var_392_9

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_10 = 52
				local var_392_11 = utf8.len(var_392_9)
				local var_392_12 = var_392_10 <= 0 and var_392_7 or var_392_7 * (var_392_11 / var_392_10)

				if var_392_12 > 0 and var_392_7 < var_392_12 then
					arg_389_1.talkMaxDuration = var_392_12

					if var_392_12 + var_392_6 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_12 + var_392_6
					end
				end

				arg_389_1.text_.text = var_392_9
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_13 = math.max(var_392_7, arg_389_1.talkMaxDuration)

			if var_392_6 <= arg_389_1.time_ and arg_389_1.time_ < var_392_6 + var_392_13 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_6) / var_392_13

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_6 + var_392_13 and arg_389_1.time_ < var_392_6 + var_392_13 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play322221097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 322221097
		arg_393_1.duration_ = 5.23

		local var_393_0 = {
			zh = 3.6,
			ja = 5.233
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play322221098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1111ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1111ui_story == nil then
				arg_393_1.var_.characterEffect1111ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect1111ui_story and not isNil(var_396_0) then
					arg_393_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1111ui_story then
				arg_393_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_396_4 = 0

			if var_396_4 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_396_5 = 0
			local var_396_6 = 0.475

			if var_396_5 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_7 = arg_393_1:FormatText(StoryNameCfg[67].name)

				arg_393_1.leftNameTxt_.text = var_396_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_8 = arg_393_1:GetWordFromCfg(322221097)
				local var_396_9 = arg_393_1:FormatText(var_396_8.content)

				arg_393_1.text_.text = var_396_9

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_10 = 19
				local var_396_11 = utf8.len(var_396_9)
				local var_396_12 = var_396_10 <= 0 and var_396_6 or var_396_6 * (var_396_11 / var_396_10)

				if var_396_12 > 0 and var_396_6 < var_396_12 then
					arg_393_1.talkMaxDuration = var_396_12

					if var_396_12 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_12 + var_396_5
					end
				end

				arg_393_1.text_.text = var_396_9
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221097", "story_v_out_322221.awb") ~= 0 then
					local var_396_13 = manager.audio:GetVoiceLength("story_v_out_322221", "322221097", "story_v_out_322221.awb") / 1000

					if var_396_13 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_5
					end

					if var_396_8.prefab_name ~= "" and arg_393_1.actors_[var_396_8.prefab_name] ~= nil then
						local var_396_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_8.prefab_name].transform, "story_v_out_322221", "322221097", "story_v_out_322221.awb")

						arg_393_1:RecordAudio("322221097", var_396_14)
						arg_393_1:RecordAudio("322221097", var_396_14)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_322221", "322221097", "story_v_out_322221.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_322221", "322221097", "story_v_out_322221.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_15 = math.max(var_396_6, arg_393_1.talkMaxDuration)

			if var_396_5 <= arg_393_1.time_ and arg_393_1.time_ < var_396_5 + var_396_15 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_5) / var_396_15

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_5 + var_396_15 and arg_393_1.time_ < var_396_5 + var_396_15 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play322221098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 322221098
		arg_397_1.duration_ = 9.2

		local var_397_0 = {
			zh = 5.566,
			ja = 9.2
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play322221099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_400_1 = 0
			local var_400_2 = 0.6

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_3 = arg_397_1:FormatText(StoryNameCfg[67].name)

				arg_397_1.leftNameTxt_.text = var_400_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:GetWordFromCfg(322221098)
				local var_400_5 = arg_397_1:FormatText(var_400_4.content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_6 = 24
				local var_400_7 = utf8.len(var_400_5)
				local var_400_8 = var_400_6 <= 0 and var_400_2 or var_400_2 * (var_400_7 / var_400_6)

				if var_400_8 > 0 and var_400_2 < var_400_8 then
					arg_397_1.talkMaxDuration = var_400_8

					if var_400_8 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_1
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221098", "story_v_out_322221.awb") ~= 0 then
					local var_400_9 = manager.audio:GetVoiceLength("story_v_out_322221", "322221098", "story_v_out_322221.awb") / 1000

					if var_400_9 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_9 + var_400_1
					end

					if var_400_4.prefab_name ~= "" and arg_397_1.actors_[var_400_4.prefab_name] ~= nil then
						local var_400_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_4.prefab_name].transform, "story_v_out_322221", "322221098", "story_v_out_322221.awb")

						arg_397_1:RecordAudio("322221098", var_400_10)
						arg_397_1:RecordAudio("322221098", var_400_10)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_322221", "322221098", "story_v_out_322221.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_322221", "322221098", "story_v_out_322221.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_11 = math.max(var_400_2, arg_397_1.talkMaxDuration)

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_11 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_1) / var_400_11

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_1 + var_400_11 and arg_397_1.time_ < var_400_1 + var_400_11 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play322221099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 322221099
		arg_401_1.duration_ = 3.63

		local var_401_0 = {
			zh = 2.633,
			ja = 3.633
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play322221100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10131ui_story"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect10131ui_story == nil then
				arg_401_1.var_.characterEffect10131ui_story = var_404_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.characterEffect10131ui_story and not isNil(var_404_0) then
					arg_401_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect10131ui_story then
				arg_401_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_404_4 = arg_401_1.actors_["1111ui_story"]
			local var_404_5 = 0

			if var_404_5 < arg_401_1.time_ and arg_401_1.time_ <= var_404_5 + arg_404_0 and not isNil(var_404_4) and arg_401_1.var_.characterEffect1111ui_story == nil then
				arg_401_1.var_.characterEffect1111ui_story = var_404_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_6 = 0.200000002980232

			if var_404_5 <= arg_401_1.time_ and arg_401_1.time_ < var_404_5 + var_404_6 and not isNil(var_404_4) then
				local var_404_7 = (arg_401_1.time_ - var_404_5) / var_404_6

				if arg_401_1.var_.characterEffect1111ui_story and not isNil(var_404_4) then
					local var_404_8 = Mathf.Lerp(0, 0.5, var_404_7)

					arg_401_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1111ui_story.fillRatio = var_404_8
				end
			end

			if arg_401_1.time_ >= var_404_5 + var_404_6 and arg_401_1.time_ < var_404_5 + var_404_6 + arg_404_0 and not isNil(var_404_4) and arg_401_1.var_.characterEffect1111ui_story then
				local var_404_9 = 0.5

				arg_401_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1111ui_story.fillRatio = var_404_9
			end

			local var_404_10 = 0
			local var_404_11 = 0.275

			if var_404_10 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_12 = arg_401_1:FormatText(StoryNameCfg[1366].name)

				arg_401_1.leftNameTxt_.text = var_404_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_13 = arg_401_1:GetWordFromCfg(322221099)
				local var_404_14 = arg_401_1:FormatText(var_404_13.content)

				arg_401_1.text_.text = var_404_14

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_15 = 11
				local var_404_16 = utf8.len(var_404_14)
				local var_404_17 = var_404_15 <= 0 and var_404_11 or var_404_11 * (var_404_16 / var_404_15)

				if var_404_17 > 0 and var_404_11 < var_404_17 then
					arg_401_1.talkMaxDuration = var_404_17

					if var_404_17 + var_404_10 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_17 + var_404_10
					end
				end

				arg_401_1.text_.text = var_404_14
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221099", "story_v_out_322221.awb") ~= 0 then
					local var_404_18 = manager.audio:GetVoiceLength("story_v_out_322221", "322221099", "story_v_out_322221.awb") / 1000

					if var_404_18 + var_404_10 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_18 + var_404_10
					end

					if var_404_13.prefab_name ~= "" and arg_401_1.actors_[var_404_13.prefab_name] ~= nil then
						local var_404_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_13.prefab_name].transform, "story_v_out_322221", "322221099", "story_v_out_322221.awb")

						arg_401_1:RecordAudio("322221099", var_404_19)
						arg_401_1:RecordAudio("322221099", var_404_19)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_322221", "322221099", "story_v_out_322221.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_322221", "322221099", "story_v_out_322221.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_20 = math.max(var_404_11, arg_401_1.talkMaxDuration)

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_20 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_10) / var_404_20

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_10 + var_404_20 and arg_401_1.time_ < var_404_10 + var_404_20 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play322221100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 322221100
		arg_405_1.duration_ = 8.33

		local var_405_0 = {
			zh = 7.366,
			ja = 8.333
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
			arg_405_1.auto_ = false
		end

		function arg_405_1.playNext_(arg_407_0)
			arg_405_1.onStoryFinished_()
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 0.725

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_2 = arg_405_1:FormatText(StoryNameCfg[1366].name)

				arg_405_1.leftNameTxt_.text = var_408_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_3 = arg_405_1:GetWordFromCfg(322221100)
				local var_408_4 = arg_405_1:FormatText(var_408_3.content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 29
				local var_408_6 = utf8.len(var_408_4)
				local var_408_7 = var_408_5 <= 0 and var_408_1 or var_408_1 * (var_408_6 / var_408_5)

				if var_408_7 > 0 and var_408_1 < var_408_7 then
					arg_405_1.talkMaxDuration = var_408_7

					if var_408_7 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_7 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322221", "322221100", "story_v_out_322221.awb") ~= 0 then
					local var_408_8 = manager.audio:GetVoiceLength("story_v_out_322221", "322221100", "story_v_out_322221.awb") / 1000

					if var_408_8 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_8 + var_408_0
					end

					if var_408_3.prefab_name ~= "" and arg_405_1.actors_[var_408_3.prefab_name] ~= nil then
						local var_408_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_3.prefab_name].transform, "story_v_out_322221", "322221100", "story_v_out_322221.awb")

						arg_405_1:RecordAudio("322221100", var_408_9)
						arg_405_1:RecordAudio("322221100", var_408_9)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_322221", "322221100", "story_v_out_322221.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_322221", "322221100", "story_v_out_322221.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_10 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_10 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_10

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_10 and arg_405_1.time_ < var_408_0 + var_408_10 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L09f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_322221.awb"
	}
}
