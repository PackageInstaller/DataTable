return {
	Play421041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421041001
		arg_1_1.duration_ = 3.83

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play421041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D12a"

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
				local var_4_5 = arg_1_1.bgs_.D12a

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
					if iter_4_0 ~= "D12a" then
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

			local var_4_22 = "1047ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1047ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1047ui_story"].transform
			local var_4_28 = 1.83333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1047ui_story = var_4_27.localPosition

				local var_4_29 = "1047ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_29 .. "Animator"].transform, false)
			end

			local var_4_30 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_28) / var_4_30
				local var_4_32 = Vector3.New(0, -1.13, -6.2)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1047ui_story, var_4_32, var_4_31)

				local var_4_33 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_33.x, var_4_33.y, var_4_33.z)

				local var_4_34 = var_4_27.localEulerAngles

				var_4_34.z = 0
				var_4_34.x = 0
				var_4_27.localEulerAngles = var_4_34
			end

			if arg_1_1.time_ >= var_4_28 + var_4_30 and arg_1_1.time_ < var_4_28 + var_4_30 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_27.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_27.localEulerAngles = var_4_36
			end

			local var_4_37 = arg_1_1.actors_["1047ui_story"]
			local var_4_38 = 1.83333333333333

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 and not isNil(var_4_37) and arg_1_1.var_.characterEffect1047ui_story == nil then
				arg_1_1.var_.characterEffect1047ui_story = var_4_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_39 = 0.200000002980232

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 and not isNil(var_4_37) then
				local var_4_40 = (arg_1_1.time_ - var_4_38) / var_4_39

				if arg_1_1.var_.characterEffect1047ui_story and not isNil(var_4_37) then
					arg_1_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 and not isNil(var_4_37) and arg_1_1.var_.characterEffect1047ui_story then
				arg_1_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_4_41 = 1.83333333333333

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_4_42 = 1.83333333333333

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_4_43 = 0.1
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "effect"

				arg_1_1:AudioAction(var_4_45, var_4_46, "se_story_140", "se_story_140_amb_dream01", "")
			end

			local var_4_47 = 0
			local var_4_48 = 0.3

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 0.433333333333333
			local var_4_54 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city.awb")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city")

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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

			local var_4_59 = 2
			local var_4_60 = 0.15

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_61 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_61:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[1296].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(421041001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 6
				local var_4_66 = utf8.len(var_4_64)
				local var_4_67 = var_4_65 <= 0 and var_4_60 or var_4_60 * (var_4_66 / var_4_65)

				if var_4_67 > 0 and var_4_60 < var_4_67 then
					arg_1_1.talkMaxDuration = var_4_67
					var_4_59 = var_4_59 + 0.3

					if var_4_67 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_59
					end
				end

				arg_1_1.text_.text = var_4_64
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041001", "story_v_out_421041.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_421041", "421041001", "story_v_out_421041.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_421041", "421041001", "story_v_out_421041.awb")

						arg_1_1:RecordAudio("421041001", var_4_69)
						arg_1_1:RecordAudio("421041001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_421041", "421041001", "story_v_out_421041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_421041", "421041001", "story_v_out_421041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_70 = var_4_59 + 0.3
			local var_4_71 = math.max(var_4_60, arg_1_1.talkMaxDuration)

			if var_4_70 <= arg_1_1.time_ and arg_1_1.time_ < var_4_70 + var_4_71 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_70) / var_4_71

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_70 + var_4_71 and arg_1_1.time_ < var_4_70 + var_4_71 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421041002
		arg_9_1.duration_ = 8.87

		local var_9_0 = {
			zh = 6.5,
			ja = 8.866
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10145ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "10145ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["10145ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos10145ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0.78, -1, -6.2)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10145ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1047ui_story"].transform
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.var_.moveOldPos1047ui_story = var_12_14.localPosition
			end

			local var_12_16 = 0.001

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16
				local var_12_18 = Vector3.New(-0.6, -1.13, -6.2)

				var_12_14.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1047ui_story, var_12_18, var_12_17)

				local var_12_19 = manager.ui.mainCamera.transform.position - var_12_14.position

				var_12_14.forward = Vector3.New(var_12_19.x, var_12_19.y, var_12_19.z)

				local var_12_20 = var_12_14.localEulerAngles

				var_12_20.z = 0
				var_12_20.x = 0
				var_12_14.localEulerAngles = var_12_20
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 then
				var_12_14.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_12_21 = manager.ui.mainCamera.transform.position - var_12_14.position

				var_12_14.forward = Vector3.New(var_12_21.x, var_12_21.y, var_12_21.z)

				local var_12_22 = var_12_14.localEulerAngles

				var_12_22.z = 0
				var_12_22.x = 0
				var_12_14.localEulerAngles = var_12_22
			end

			local var_12_23 = arg_9_1.actors_["10145ui_story"]
			local var_12_24 = 0

			if var_12_24 < arg_9_1.time_ and arg_9_1.time_ <= var_12_24 + arg_12_0 and not isNil(var_12_23) and arg_9_1.var_.characterEffect10145ui_story == nil then
				arg_9_1.var_.characterEffect10145ui_story = var_12_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_25 = 0.200000002980232

			if var_12_24 <= arg_9_1.time_ and arg_9_1.time_ < var_12_24 + var_12_25 and not isNil(var_12_23) then
				local var_12_26 = (arg_9_1.time_ - var_12_24) / var_12_25

				if arg_9_1.var_.characterEffect10145ui_story and not isNil(var_12_23) then
					arg_9_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_24 + var_12_25 and arg_9_1.time_ < var_12_24 + var_12_25 + arg_12_0 and not isNil(var_12_23) and arg_9_1.var_.characterEffect10145ui_story then
				arg_9_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_12_27 = arg_9_1.actors_["1047ui_story"]
			local var_12_28 = 0

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 and not isNil(var_12_27) and arg_9_1.var_.characterEffect1047ui_story == nil then
				arg_9_1.var_.characterEffect1047ui_story = var_12_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_29 = 0.200000002980232

			if var_12_28 <= arg_9_1.time_ and arg_9_1.time_ < var_12_28 + var_12_29 and not isNil(var_12_27) then
				local var_12_30 = (arg_9_1.time_ - var_12_28) / var_12_29

				if arg_9_1.var_.characterEffect1047ui_story and not isNil(var_12_27) then
					local var_12_31 = Mathf.Lerp(0, 0.5, var_12_30)

					arg_9_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1047ui_story.fillRatio = var_12_31
				end
			end

			if arg_9_1.time_ >= var_12_28 + var_12_29 and arg_9_1.time_ < var_12_28 + var_12_29 + arg_12_0 and not isNil(var_12_27) and arg_9_1.var_.characterEffect1047ui_story then
				local var_12_32 = 0.5

				arg_9_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1047ui_story.fillRatio = var_12_32
			end

			local var_12_33 = 0

			if var_12_33 < arg_9_1.time_ and arg_9_1.time_ <= var_12_33 + arg_12_0 then
				arg_9_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			local var_12_34 = 0

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_12_35 = 0

			if var_12_35 < arg_9_1.time_ and arg_9_1.time_ <= var_12_35 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			local var_12_36 = 1

			if arg_9_1.time_ >= var_12_35 + var_12_36 and arg_9_1.time_ < var_12_35 + var_12_36 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_37 = 0
			local var_12_38 = 0.6

			if var_12_37 < arg_9_1.time_ and arg_9_1.time_ <= var_12_37 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_39 = arg_9_1:FormatText(StoryNameCfg[1308].name)

				arg_9_1.leftNameTxt_.text = var_12_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_40 = arg_9_1:GetWordFromCfg(421041002)
				local var_12_41 = arg_9_1:FormatText(var_12_40.content)

				arg_9_1.text_.text = var_12_41

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_42 = 24
				local var_12_43 = utf8.len(var_12_41)
				local var_12_44 = var_12_42 <= 0 and var_12_38 or var_12_38 * (var_12_43 / var_12_42)

				if var_12_44 > 0 and var_12_38 < var_12_44 then
					arg_9_1.talkMaxDuration = var_12_44

					if var_12_44 + var_12_37 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_44 + var_12_37
					end
				end

				arg_9_1.text_.text = var_12_41
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041002", "story_v_out_421041.awb") ~= 0 then
					local var_12_45 = manager.audio:GetVoiceLength("story_v_out_421041", "421041002", "story_v_out_421041.awb") / 1000

					if var_12_45 + var_12_37 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_45 + var_12_37
					end

					if var_12_40.prefab_name ~= "" and arg_9_1.actors_[var_12_40.prefab_name] ~= nil then
						local var_12_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_40.prefab_name].transform, "story_v_out_421041", "421041002", "story_v_out_421041.awb")

						arg_9_1:RecordAudio("421041002", var_12_46)
						arg_9_1:RecordAudio("421041002", var_12_46)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_421041", "421041002", "story_v_out_421041.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_421041", "421041002", "story_v_out_421041.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_47 = math.max(var_12_38, arg_9_1.talkMaxDuration)

			if var_12_37 <= arg_9_1.time_ and arg_9_1.time_ < var_12_37 + var_12_47 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_37) / var_12_47

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_37 + var_12_47 and arg_9_1.time_ < var_12_37 + var_12_47 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421041003
		arg_13_1.duration_ = 4.27

		local var_13_0 = {
			zh = 3.066,
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
				arg_13_0:Play421041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10145ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10145ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(0.78, -1, -6.2)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10145ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145actionlink/10145action434")
			end

			local var_16_10 = 0
			local var_16_11 = 0.325

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_12 = arg_13_1:FormatText(StoryNameCfg[1308].name)

				arg_13_1.leftNameTxt_.text = var_16_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(421041003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 13
				local var_16_16 = utf8.len(var_16_14)
				local var_16_17 = var_16_15 <= 0 and var_16_11 or var_16_11 * (var_16_16 / var_16_15)

				if var_16_17 > 0 and var_16_11 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041003", "story_v_out_421041.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_421041", "421041003", "story_v_out_421041.awb") / 1000

					if var_16_18 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_10
					end

					if var_16_13.prefab_name ~= "" and arg_13_1.actors_[var_16_13.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_13.prefab_name].transform, "story_v_out_421041", "421041003", "story_v_out_421041.awb")

						arg_13_1:RecordAudio("421041003", var_16_19)
						arg_13_1:RecordAudio("421041003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421041", "421041003", "story_v_out_421041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421041", "421041003", "story_v_out_421041.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_20 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_20 and arg_13_1.time_ < var_16_10 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421041004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play421041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1047ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1047ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1047ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["10145ui_story"].transform
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.var_.moveOldPos10145ui_story = var_20_9.localPosition
			end

			local var_20_11 = 0.001

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11
				local var_20_13 = Vector3.New(0, 100, 0)

				var_20_9.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10145ui_story, var_20_13, var_20_12)

				local var_20_14 = manager.ui.mainCamera.transform.position - var_20_9.position

				var_20_9.forward = Vector3.New(var_20_14.x, var_20_14.y, var_20_14.z)

				local var_20_15 = var_20_9.localEulerAngles

				var_20_15.z = 0
				var_20_15.x = 0
				var_20_9.localEulerAngles = var_20_15
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 then
				var_20_9.localPosition = Vector3.New(0, 100, 0)

				local var_20_16 = manager.ui.mainCamera.transform.position - var_20_9.position

				var_20_9.forward = Vector3.New(var_20_16.x, var_20_16.y, var_20_16.z)

				local var_20_17 = var_20_9.localEulerAngles

				var_20_17.z = 0
				var_20_17.x = 0
				var_20_9.localEulerAngles = var_20_17
			end

			local var_20_18 = 0
			local var_20_19 = 0.75

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_20 = arg_17_1:GetWordFromCfg(421041004)
				local var_20_21 = arg_17_1:FormatText(var_20_20.content)

				arg_17_1.text_.text = var_20_21

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_22 = 30
				local var_20_23 = utf8.len(var_20_21)
				local var_20_24 = var_20_22 <= 0 and var_20_19 or var_20_19 * (var_20_23 / var_20_22)

				if var_20_24 > 0 and var_20_19 < var_20_24 then
					arg_17_1.talkMaxDuration = var_20_24

					if var_20_24 + var_20_18 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_24 + var_20_18
					end
				end

				arg_17_1.text_.text = var_20_21
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_25 = math.max(var_20_19, arg_17_1.talkMaxDuration)

			if var_20_18 <= arg_17_1.time_ and arg_17_1.time_ < var_20_18 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_18) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_18 + var_20_25 and arg_17_1.time_ < var_20_18 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421041005
		arg_21_1.duration_ = 2.97

		local var_21_0 = {
			zh = 2.5,
			ja = 2.966
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
				arg_21_0:Play421041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1047ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1047ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -1.13, -6.2)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1047ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1047ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1047ui_story == nil then
				arg_21_1.var_.characterEffect1047ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1047ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1047ui_story then
				arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_24_15 = 0
			local var_24_16 = 0.3

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[1296].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(421041005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041005", "story_v_out_421041.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041005", "story_v_out_421041.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_421041", "421041005", "story_v_out_421041.awb")

						arg_21_1:RecordAudio("421041005", var_24_24)
						arg_21_1:RecordAudio("421041005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421041", "421041005", "story_v_out_421041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421041", "421041005", "story_v_out_421041.awb")
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
				actorName = "1047ui_story",
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
	Play421041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421041006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play421041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1047ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1047ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, 100, 0)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1047ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, 100, 0)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = 0
			local var_28_10 = 0.575

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_11 = arg_25_1:GetWordFromCfg(421041006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 23
				local var_28_14 = utf8.len(var_28_12)
				local var_28_15 = var_28_13 <= 0 and var_28_10 or var_28_10 * (var_28_14 / var_28_13)

				if var_28_15 > 0 and var_28_10 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_9 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_9
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_10, arg_25_1.talkMaxDuration)

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_9) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_9 + var_28_16 and arg_25_1.time_ < var_28_9 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play421041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421041007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play421041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "10102ui_story"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_29_1.stage_.transform)

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

			local var_32_5 = arg_29_1.actors_["10102ui_story"].transform
			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.var_.moveOldPos10102ui_story = var_32_5.localPosition
			end

			local var_32_7 = 0.001

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_7 then
				local var_32_8 = (arg_29_1.time_ - var_32_6) / var_32_7
				local var_32_9 = Vector3.New(0, -0.985, -6.275)

				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10102ui_story, var_32_9, var_32_8)

				local var_32_10 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_10.x, var_32_10.y, var_32_10.z)

				local var_32_11 = var_32_5.localEulerAngles

				var_32_11.z = 0
				var_32_11.x = 0
				var_32_5.localEulerAngles = var_32_11
			end

			if arg_29_1.time_ >= var_32_6 + var_32_7 and arg_29_1.time_ < var_32_6 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_32_12 = manager.ui.mainCamera.transform.position - var_32_5.position

				var_32_5.forward = Vector3.New(var_32_12.x, var_32_12.y, var_32_12.z)

				local var_32_13 = var_32_5.localEulerAngles

				var_32_13.z = 0
				var_32_13.x = 0
				var_32_5.localEulerAngles = var_32_13
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_32_15 = 0

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_16 = arg_29_1.actors_["10102ui_story"]
			local var_32_17 = 0

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 and not isNil(var_32_16) and arg_29_1.var_.characterEffect10102ui_story == nil then
				arg_29_1.var_.characterEffect10102ui_story = var_32_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_18 = 0.200000002980232

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_18 and not isNil(var_32_16) then
				local var_32_19 = (arg_29_1.time_ - var_32_17) / var_32_18

				if arg_29_1.var_.characterEffect10102ui_story and not isNil(var_32_16) then
					arg_29_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_17 + var_32_18 and arg_29_1.time_ < var_32_17 + var_32_18 + arg_32_0 and not isNil(var_32_16) and arg_29_1.var_.characterEffect10102ui_story then
				arg_29_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_32_20 = 0
			local var_32_21 = 0.15

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_22 = arg_29_1:FormatText(StoryNameCfg[401].name)

				arg_29_1.leftNameTxt_.text = var_32_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_23 = arg_29_1:GetWordFromCfg(421041007)
				local var_32_24 = arg_29_1:FormatText(var_32_23.content)

				arg_29_1.text_.text = var_32_24

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_25 = 6
				local var_32_26 = utf8.len(var_32_24)
				local var_32_27 = var_32_25 <= 0 and var_32_21 or var_32_21 * (var_32_26 / var_32_25)

				if var_32_27 > 0 and var_32_21 < var_32_27 then
					arg_29_1.talkMaxDuration = var_32_27

					if var_32_27 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_27 + var_32_20
					end
				end

				arg_29_1.text_.text = var_32_24
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041007", "story_v_out_421041.awb") ~= 0 then
					local var_32_28 = manager.audio:GetVoiceLength("story_v_out_421041", "421041007", "story_v_out_421041.awb") / 1000

					if var_32_28 + var_32_20 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_20
					end

					if var_32_23.prefab_name ~= "" and arg_29_1.actors_[var_32_23.prefab_name] ~= nil then
						local var_32_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_23.prefab_name].transform, "story_v_out_421041", "421041007", "story_v_out_421041.awb")

						arg_29_1:RecordAudio("421041007", var_32_29)
						arg_29_1:RecordAudio("421041007", var_32_29)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_421041", "421041007", "story_v_out_421041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_421041", "421041007", "story_v_out_421041.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_30 = math.max(var_32_21, arg_29_1.talkMaxDuration)

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_30 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_20) / var_32_30

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_20 + var_32_30 and arg_29_1.time_ < var_32_20 + var_32_30 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421041008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play421041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10102ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10102ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0, 100, 0)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10102ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0, 100, 0)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = 0
			local var_36_10 = 0.375

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_11 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_12 = arg_33_1:GetWordFromCfg(421041008)
				local var_36_13 = arg_33_1:FormatText(var_36_12.content)

				arg_33_1.text_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_14 = 15
				local var_36_15 = utf8.len(var_36_13)
				local var_36_16 = var_36_14 <= 0 and var_36_10 or var_36_10 * (var_36_15 / var_36_14)

				if var_36_16 > 0 and var_36_10 < var_36_16 then
					arg_33_1.talkMaxDuration = var_36_16

					if var_36_16 + var_36_9 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_9
					end
				end

				arg_33_1.text_.text = var_36_13
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_17 = math.max(var_36_10, arg_33_1.talkMaxDuration)

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_17 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_9) / var_36_17

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_9 + var_36_17 and arg_33_1.time_ < var_36_9 + var_36_17 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play421041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421041009
		arg_37_1.duration_ = 15

		local var_37_0 = {
			zh = 13.766,
			ja = 15
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
				arg_37_0:Play421041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10145ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10145ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, -1, -6.2)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10145ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["10145ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10145ui_story == nil then
				arg_37_1.var_.characterEffect10145ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect10145ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect10145ui_story then
				arg_37_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_40_15 = 0
			local var_40_16 = 1.4

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[1308].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(421041009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 56
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041009", "story_v_out_421041.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041009", "story_v_out_421041.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_421041", "421041009", "story_v_out_421041.awb")

						arg_37_1:RecordAudio("421041009", var_40_24)
						arg_37_1:RecordAudio("421041009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_421041", "421041009", "story_v_out_421041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_421041", "421041009", "story_v_out_421041.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 421041010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play421041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10145ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10145ui_story == nil then
				arg_41_1.var_.characterEffect10145ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10145ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10145ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10145ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10145ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.45

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

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(421041010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 18
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
	Play421041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 421041011
		arg_45_1.duration_ = 9.6

		local var_45_0 = {
			zh = 6.6,
			ja = 9.6
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
				arg_45_0:Play421041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "10143ui_story"

			if arg_45_1.actors_[var_48_0] == nil then
				local var_48_1 = Asset.Load("Char/" .. "10143ui_story")

				if not isNil(var_48_1) then
					local var_48_2 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_45_1.stage_.transform)

					var_48_2.name = var_48_0
					var_48_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_45_1.actors_[var_48_0] = var_48_2

					local var_48_3 = var_48_2:GetComponentInChildren(typeof(CharacterEffect))

					var_48_3.enabled = true

					local var_48_4 = GameObjectTools.GetOrAddComponent(var_48_2, typeof(DynamicBoneHelper))

					if var_48_4 then
						var_48_4:EnableDynamicBone(false)
					end

					arg_45_1:ShowWeapon(var_48_3.transform, false)

					arg_45_1.var_[var_48_0 .. "Animator"] = var_48_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_45_1.var_[var_48_0 .. "Animator"].applyRootMotion = true
					arg_45_1.var_[var_48_0 .. "LipSync"] = var_48_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_48_5 = arg_45_1.actors_["10143ui_story"].transform
			local var_48_6 = 0

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.var_.moveOldPos10143ui_story = var_48_5.localPosition
			end

			local var_48_7 = 0.001

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_7 then
				local var_48_8 = (arg_45_1.time_ - var_48_6) / var_48_7
				local var_48_9 = Vector3.New(0, -1.06, -6)

				var_48_5.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10143ui_story, var_48_9, var_48_8)

				local var_48_10 = manager.ui.mainCamera.transform.position - var_48_5.position

				var_48_5.forward = Vector3.New(var_48_10.x, var_48_10.y, var_48_10.z)

				local var_48_11 = var_48_5.localEulerAngles

				var_48_11.z = 0
				var_48_11.x = 0
				var_48_5.localEulerAngles = var_48_11
			end

			if arg_45_1.time_ >= var_48_6 + var_48_7 and arg_45_1.time_ < var_48_6 + var_48_7 + arg_48_0 then
				var_48_5.localPosition = Vector3.New(0, -1.06, -6)

				local var_48_12 = manager.ui.mainCamera.transform.position - var_48_5.position

				var_48_5.forward = Vector3.New(var_48_12.x, var_48_12.y, var_48_12.z)

				local var_48_13 = var_48_5.localEulerAngles

				var_48_13.z = 0
				var_48_13.x = 0
				var_48_5.localEulerAngles = var_48_13
			end

			local var_48_14 = arg_45_1.actors_["10145ui_story"].transform
			local var_48_15 = 0

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.var_.moveOldPos10145ui_story = var_48_14.localPosition
			end

			local var_48_16 = 0.001

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_16 then
				local var_48_17 = (arg_45_1.time_ - var_48_15) / var_48_16
				local var_48_18 = Vector3.New(0, 100, 0)

				var_48_14.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10145ui_story, var_48_18, var_48_17)

				local var_48_19 = manager.ui.mainCamera.transform.position - var_48_14.position

				var_48_14.forward = Vector3.New(var_48_19.x, var_48_19.y, var_48_19.z)

				local var_48_20 = var_48_14.localEulerAngles

				var_48_20.z = 0
				var_48_20.x = 0
				var_48_14.localEulerAngles = var_48_20
			end

			if arg_45_1.time_ >= var_48_15 + var_48_16 and arg_45_1.time_ < var_48_15 + var_48_16 + arg_48_0 then
				var_48_14.localPosition = Vector3.New(0, 100, 0)

				local var_48_21 = manager.ui.mainCamera.transform.position - var_48_14.position

				var_48_14.forward = Vector3.New(var_48_21.x, var_48_21.y, var_48_21.z)

				local var_48_22 = var_48_14.localEulerAngles

				var_48_22.z = 0
				var_48_22.x = 0
				var_48_14.localEulerAngles = var_48_22
			end

			local var_48_23 = arg_45_1.actors_["10143ui_story"]
			local var_48_24 = 0

			if var_48_24 < arg_45_1.time_ and arg_45_1.time_ <= var_48_24 + arg_48_0 and not isNil(var_48_23) and arg_45_1.var_.characterEffect10143ui_story == nil then
				arg_45_1.var_.characterEffect10143ui_story = var_48_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_25 = 0.200000002980232

			if var_48_24 <= arg_45_1.time_ and arg_45_1.time_ < var_48_24 + var_48_25 and not isNil(var_48_23) then
				local var_48_26 = (arg_45_1.time_ - var_48_24) / var_48_25

				if arg_45_1.var_.characterEffect10143ui_story and not isNil(var_48_23) then
					arg_45_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_24 + var_48_25 and arg_45_1.time_ < var_48_24 + var_48_25 + arg_48_0 and not isNil(var_48_23) and arg_45_1.var_.characterEffect10143ui_story then
				arg_45_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_48_27 = 0

			if var_48_27 < arg_45_1.time_ and arg_45_1.time_ <= var_48_27 + arg_48_0 then
				arg_45_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_48_28 = 0

			if var_48_28 < arg_45_1.time_ and arg_45_1.time_ <= var_48_28 + arg_48_0 then
				arg_45_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_48_29 = 0
			local var_48_30 = 0.8

			if var_48_29 < arg_45_1.time_ and arg_45_1.time_ <= var_48_29 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_31 = arg_45_1:FormatText(StoryNameCfg[1307].name)

				arg_45_1.leftNameTxt_.text = var_48_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_32 = arg_45_1:GetWordFromCfg(421041011)
				local var_48_33 = arg_45_1:FormatText(var_48_32.content)

				arg_45_1.text_.text = var_48_33

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_34 = 32
				local var_48_35 = utf8.len(var_48_33)
				local var_48_36 = var_48_34 <= 0 and var_48_30 or var_48_30 * (var_48_35 / var_48_34)

				if var_48_36 > 0 and var_48_30 < var_48_36 then
					arg_45_1.talkMaxDuration = var_48_36

					if var_48_36 + var_48_29 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_36 + var_48_29
					end
				end

				arg_45_1.text_.text = var_48_33
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041011", "story_v_out_421041.awb") ~= 0 then
					local var_48_37 = manager.audio:GetVoiceLength("story_v_out_421041", "421041011", "story_v_out_421041.awb") / 1000

					if var_48_37 + var_48_29 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_37 + var_48_29
					end

					if var_48_32.prefab_name ~= "" and arg_45_1.actors_[var_48_32.prefab_name] ~= nil then
						local var_48_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_32.prefab_name].transform, "story_v_out_421041", "421041011", "story_v_out_421041.awb")

						arg_45_1:RecordAudio("421041011", var_48_38)
						arg_45_1:RecordAudio("421041011", var_48_38)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_421041", "421041011", "story_v_out_421041.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_421041", "421041011", "story_v_out_421041.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_39 = math.max(var_48_30, arg_45_1.talkMaxDuration)

			if var_48_29 <= arg_45_1.time_ and arg_45_1.time_ < var_48_29 + var_48_39 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_29) / var_48_39

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_29 + var_48_39 and arg_45_1.time_ < var_48_29 + var_48_39 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 421041012
		arg_49_1.duration_ = 12

		local var_49_0 = {
			zh = 12,
			ja = 9.966
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
				arg_49_0:Play421041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10145ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10145ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, -1, -6.2)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10145ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["10145ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10145ui_story == nil then
				arg_49_1.var_.characterEffect10145ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect10145ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10145ui_story then
				arg_49_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action7_1")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_52_15 = arg_49_1.actors_["10143ui_story"].transform
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.var_.moveOldPos10143ui_story = var_52_15.localPosition
			end

			local var_52_17 = 0.001

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17
				local var_52_19 = Vector3.New(0, 100, 0)

				var_52_15.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10143ui_story, var_52_19, var_52_18)

				local var_52_20 = manager.ui.mainCamera.transform.position - var_52_15.position

				var_52_15.forward = Vector3.New(var_52_20.x, var_52_20.y, var_52_20.z)

				local var_52_21 = var_52_15.localEulerAngles

				var_52_21.z = 0
				var_52_21.x = 0
				var_52_15.localEulerAngles = var_52_21
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				var_52_15.localPosition = Vector3.New(0, 100, 0)

				local var_52_22 = manager.ui.mainCamera.transform.position - var_52_15.position

				var_52_15.forward = Vector3.New(var_52_22.x, var_52_22.y, var_52_22.z)

				local var_52_23 = var_52_15.localEulerAngles

				var_52_23.z = 0
				var_52_23.x = 0
				var_52_15.localEulerAngles = var_52_23
			end

			local var_52_24 = 0
			local var_52_25 = 1.025

			if var_52_24 < arg_49_1.time_ and arg_49_1.time_ <= var_52_24 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_26 = arg_49_1:FormatText(StoryNameCfg[1308].name)

				arg_49_1.leftNameTxt_.text = var_52_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_27 = arg_49_1:GetWordFromCfg(421041012)
				local var_52_28 = arg_49_1:FormatText(var_52_27.content)

				arg_49_1.text_.text = var_52_28

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_29 = 41
				local var_52_30 = utf8.len(var_52_28)
				local var_52_31 = var_52_29 <= 0 and var_52_25 or var_52_25 * (var_52_30 / var_52_29)

				if var_52_31 > 0 and var_52_25 < var_52_31 then
					arg_49_1.talkMaxDuration = var_52_31

					if var_52_31 + var_52_24 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_24
					end
				end

				arg_49_1.text_.text = var_52_28
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041012", "story_v_out_421041.awb") ~= 0 then
					local var_52_32 = manager.audio:GetVoiceLength("story_v_out_421041", "421041012", "story_v_out_421041.awb") / 1000

					if var_52_32 + var_52_24 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_32 + var_52_24
					end

					if var_52_27.prefab_name ~= "" and arg_49_1.actors_[var_52_27.prefab_name] ~= nil then
						local var_52_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_27.prefab_name].transform, "story_v_out_421041", "421041012", "story_v_out_421041.awb")

						arg_49_1:RecordAudio("421041012", var_52_33)
						arg_49_1:RecordAudio("421041012", var_52_33)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_421041", "421041012", "story_v_out_421041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_421041", "421041012", "story_v_out_421041.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_34 = math.max(var_52_25, arg_49_1.talkMaxDuration)

			if var_52_24 <= arg_49_1.time_ and arg_49_1.time_ < var_52_24 + var_52_34 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_24) / var_52_34

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_24 + var_52_34 and arg_49_1.time_ < var_52_24 + var_52_34 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 421041013
		arg_53_1.duration_ = 15.33

		local var_53_0 = {
			zh = 10.433,
			ja = 15.333
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
				arg_53_0:Play421041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1047ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1047ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0.74, -1.13, -6.2)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1047ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["10145ui_story"].transform
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.var_.moveOldPos10145ui_story = var_56_9.localPosition
			end

			local var_56_11 = 0.001

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11
				local var_56_13 = Vector3.New(-0.65, -1, -6.2)

				var_56_9.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10145ui_story, var_56_13, var_56_12)

				local var_56_14 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_14.x, var_56_14.y, var_56_14.z)

				local var_56_15 = var_56_9.localEulerAngles

				var_56_15.z = 0
				var_56_15.x = 0
				var_56_9.localEulerAngles = var_56_15
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 then
				var_56_9.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_56_16 = manager.ui.mainCamera.transform.position - var_56_9.position

				var_56_9.forward = Vector3.New(var_56_16.x, var_56_16.y, var_56_16.z)

				local var_56_17 = var_56_9.localEulerAngles

				var_56_17.z = 0
				var_56_17.x = 0
				var_56_9.localEulerAngles = var_56_17
			end

			local var_56_18 = arg_53_1.actors_["1047ui_story"]
			local var_56_19 = 0

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 and not isNil(var_56_18) and arg_53_1.var_.characterEffect1047ui_story == nil then
				arg_53_1.var_.characterEffect1047ui_story = var_56_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_20 = 0.200000002980232

			if var_56_19 <= arg_53_1.time_ and arg_53_1.time_ < var_56_19 + var_56_20 and not isNil(var_56_18) then
				local var_56_21 = (arg_53_1.time_ - var_56_19) / var_56_20

				if arg_53_1.var_.characterEffect1047ui_story and not isNil(var_56_18) then
					arg_53_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_19 + var_56_20 and arg_53_1.time_ < var_56_19 + var_56_20 + arg_56_0 and not isNil(var_56_18) and arg_53_1.var_.characterEffect1047ui_story then
				arg_53_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_56_22 = arg_53_1.actors_["10145ui_story"]
			local var_56_23 = 0

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 and not isNil(var_56_22) and arg_53_1.var_.characterEffect10145ui_story == nil then
				arg_53_1.var_.characterEffect10145ui_story = var_56_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_24 = 0.200000002980232

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_24 and not isNil(var_56_22) then
				local var_56_25 = (arg_53_1.time_ - var_56_23) / var_56_24

				if arg_53_1.var_.characterEffect10145ui_story and not isNil(var_56_22) then
					local var_56_26 = Mathf.Lerp(0, 0.5, var_56_25)

					arg_53_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10145ui_story.fillRatio = var_56_26
				end
			end

			if arg_53_1.time_ >= var_56_23 + var_56_24 and arg_53_1.time_ < var_56_23 + var_56_24 + arg_56_0 and not isNil(var_56_22) and arg_53_1.var_.characterEffect10145ui_story then
				local var_56_27 = 0.5

				arg_53_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10145ui_story.fillRatio = var_56_27
			end

			local var_56_28 = 0

			if var_56_28 < arg_53_1.time_ and arg_53_1.time_ <= var_56_28 + arg_56_0 then
				arg_53_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_56_29 = 0

			if var_56_29 < arg_53_1.time_ and arg_53_1.time_ <= var_56_29 + arg_56_0 then
				arg_53_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_56_30 = 0
			local var_56_31 = 1.2

			if var_56_30 < arg_53_1.time_ and arg_53_1.time_ <= var_56_30 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_32 = arg_53_1:FormatText(StoryNameCfg[1296].name)

				arg_53_1.leftNameTxt_.text = var_56_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_33 = arg_53_1:GetWordFromCfg(421041013)
				local var_56_34 = arg_53_1:FormatText(var_56_33.content)

				arg_53_1.text_.text = var_56_34

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_35 = 48
				local var_56_36 = utf8.len(var_56_34)
				local var_56_37 = var_56_35 <= 0 and var_56_31 or var_56_31 * (var_56_36 / var_56_35)

				if var_56_37 > 0 and var_56_31 < var_56_37 then
					arg_53_1.talkMaxDuration = var_56_37

					if var_56_37 + var_56_30 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_37 + var_56_30
					end
				end

				arg_53_1.text_.text = var_56_34
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041013", "story_v_out_421041.awb") ~= 0 then
					local var_56_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041013", "story_v_out_421041.awb") / 1000

					if var_56_38 + var_56_30 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_38 + var_56_30
					end

					if var_56_33.prefab_name ~= "" and arg_53_1.actors_[var_56_33.prefab_name] ~= nil then
						local var_56_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_33.prefab_name].transform, "story_v_out_421041", "421041013", "story_v_out_421041.awb")

						arg_53_1:RecordAudio("421041013", var_56_39)
						arg_53_1:RecordAudio("421041013", var_56_39)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_421041", "421041013", "story_v_out_421041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_421041", "421041013", "story_v_out_421041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_40 = math.max(var_56_31, arg_53_1.talkMaxDuration)

			if var_56_30 <= arg_53_1.time_ and arg_53_1.time_ < var_56_30 + var_56_40 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_30) / var_56_40

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_30 + var_56_40 and arg_53_1.time_ < var_56_30 + var_56_40 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 421041014
		arg_57_1.duration_ = 9.13

		local var_57_0 = {
			zh = 6.5,
			ja = 9.133
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
				arg_57_0:Play421041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10143ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10143ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0.78, -1.06, -6)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10143ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["1047ui_story"].transform
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1.var_.moveOldPos1047ui_story = var_60_9.localPosition
			end

			local var_60_11 = 0.001

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11
				local var_60_13 = Vector3.New(0, 100, 0)

				var_60_9.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1047ui_story, var_60_13, var_60_12)

				local var_60_14 = manager.ui.mainCamera.transform.position - var_60_9.position

				var_60_9.forward = Vector3.New(var_60_14.x, var_60_14.y, var_60_14.z)

				local var_60_15 = var_60_9.localEulerAngles

				var_60_15.z = 0
				var_60_15.x = 0
				var_60_9.localEulerAngles = var_60_15
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 then
				var_60_9.localPosition = Vector3.New(0, 100, 0)

				local var_60_16 = manager.ui.mainCamera.transform.position - var_60_9.position

				var_60_9.forward = Vector3.New(var_60_16.x, var_60_16.y, var_60_16.z)

				local var_60_17 = var_60_9.localEulerAngles

				var_60_17.z = 0
				var_60_17.x = 0
				var_60_9.localEulerAngles = var_60_17
			end

			local var_60_18 = arg_57_1.actors_["10143ui_story"]
			local var_60_19 = 0

			if var_60_19 < arg_57_1.time_ and arg_57_1.time_ <= var_60_19 + arg_60_0 and not isNil(var_60_18) and arg_57_1.var_.characterEffect10143ui_story == nil then
				arg_57_1.var_.characterEffect10143ui_story = var_60_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_20 = 0.200000002980232

			if var_60_19 <= arg_57_1.time_ and arg_57_1.time_ < var_60_19 + var_60_20 and not isNil(var_60_18) then
				local var_60_21 = (arg_57_1.time_ - var_60_19) / var_60_20

				if arg_57_1.var_.characterEffect10143ui_story and not isNil(var_60_18) then
					arg_57_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_19 + var_60_20 and arg_57_1.time_ < var_60_19 + var_60_20 + arg_60_0 and not isNil(var_60_18) and arg_57_1.var_.characterEffect10143ui_story then
				arg_57_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_60_22 = arg_57_1.actors_["1047ui_story"]
			local var_60_23 = 0

			if var_60_23 < arg_57_1.time_ and arg_57_1.time_ <= var_60_23 + arg_60_0 and not isNil(var_60_22) and arg_57_1.var_.characterEffect1047ui_story == nil then
				arg_57_1.var_.characterEffect1047ui_story = var_60_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_24 = 0.200000002980232

			if var_60_23 <= arg_57_1.time_ and arg_57_1.time_ < var_60_23 + var_60_24 and not isNil(var_60_22) then
				local var_60_25 = (arg_57_1.time_ - var_60_23) / var_60_24

				if arg_57_1.var_.characterEffect1047ui_story and not isNil(var_60_22) then
					local var_60_26 = Mathf.Lerp(0, 0.5, var_60_25)

					arg_57_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1047ui_story.fillRatio = var_60_26
				end
			end

			if arg_57_1.time_ >= var_60_23 + var_60_24 and arg_57_1.time_ < var_60_23 + var_60_24 + arg_60_0 and not isNil(var_60_22) and arg_57_1.var_.characterEffect1047ui_story then
				local var_60_27 = 0.5

				arg_57_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1047ui_story.fillRatio = var_60_27
			end

			local var_60_28 = 0

			if var_60_28 < arg_57_1.time_ and arg_57_1.time_ <= var_60_28 + arg_60_0 then
				arg_57_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_60_29 = 0

			if var_60_29 < arg_57_1.time_ and arg_57_1.time_ <= var_60_29 + arg_60_0 then
				arg_57_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_60_30 = 0
			local var_60_31 = 0.725

			if var_60_30 < arg_57_1.time_ and arg_57_1.time_ <= var_60_30 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_32 = arg_57_1:FormatText(StoryNameCfg[1307].name)

				arg_57_1.leftNameTxt_.text = var_60_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_33 = arg_57_1:GetWordFromCfg(421041014)
				local var_60_34 = arg_57_1:FormatText(var_60_33.content)

				arg_57_1.text_.text = var_60_34

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_35 = 28
				local var_60_36 = utf8.len(var_60_34)
				local var_60_37 = var_60_35 <= 0 and var_60_31 or var_60_31 * (var_60_36 / var_60_35)

				if var_60_37 > 0 and var_60_31 < var_60_37 then
					arg_57_1.talkMaxDuration = var_60_37

					if var_60_37 + var_60_30 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_37 + var_60_30
					end
				end

				arg_57_1.text_.text = var_60_34
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041014", "story_v_out_421041.awb") ~= 0 then
					local var_60_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041014", "story_v_out_421041.awb") / 1000

					if var_60_38 + var_60_30 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_38 + var_60_30
					end

					if var_60_33.prefab_name ~= "" and arg_57_1.actors_[var_60_33.prefab_name] ~= nil then
						local var_60_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_33.prefab_name].transform, "story_v_out_421041", "421041014", "story_v_out_421041.awb")

						arg_57_1:RecordAudio("421041014", var_60_39)
						arg_57_1:RecordAudio("421041014", var_60_39)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_421041", "421041014", "story_v_out_421041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_421041", "421041014", "story_v_out_421041.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_40 = math.max(var_60_31, arg_57_1.talkMaxDuration)

			if var_60_30 <= arg_57_1.time_ and arg_57_1.time_ < var_60_30 + var_60_40 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_30) / var_60_40

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_30 + var_60_40 and arg_57_1.time_ < var_60_30 + var_60_40 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 421041015
		arg_61_1.duration_ = 4.23

		local var_61_0 = {
			zh = 2.3,
			ja = 4.233
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
				arg_61_0:Play421041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10145ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10145ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(-0.65, -1, -6.2)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10145ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["10145ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10145ui_story == nil then
				arg_61_1.var_.characterEffect10145ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect10145ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10145ui_story then
				arg_61_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_64_13 = arg_61_1.actors_["10143ui_story"]
			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 and not isNil(var_64_13) and arg_61_1.var_.characterEffect10143ui_story == nil then
				arg_61_1.var_.characterEffect10143ui_story = var_64_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_15 = 0.200000002980232

			if var_64_14 <= arg_61_1.time_ and arg_61_1.time_ < var_64_14 + var_64_15 and not isNil(var_64_13) then
				local var_64_16 = (arg_61_1.time_ - var_64_14) / var_64_15

				if arg_61_1.var_.characterEffect10143ui_story and not isNil(var_64_13) then
					local var_64_17 = Mathf.Lerp(0, 0.5, var_64_16)

					arg_61_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10143ui_story.fillRatio = var_64_17
				end
			end

			if arg_61_1.time_ >= var_64_14 + var_64_15 and arg_61_1.time_ < var_64_14 + var_64_15 + arg_64_0 and not isNil(var_64_13) and arg_61_1.var_.characterEffect10143ui_story then
				local var_64_18 = 0.5

				arg_61_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10143ui_story.fillRatio = var_64_18
			end

			local var_64_19 = 0

			if var_64_19 < arg_61_1.time_ and arg_61_1.time_ <= var_64_19 + arg_64_0 then
				arg_61_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action7_2")
			end

			local var_64_20 = 0

			if var_64_20 < arg_61_1.time_ and arg_61_1.time_ <= var_64_20 + arg_64_0 then
				arg_61_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_64_21 = 0
			local var_64_22 = 0.25

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_23 = arg_61_1:FormatText(StoryNameCfg[1308].name)

				arg_61_1.leftNameTxt_.text = var_64_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_24 = arg_61_1:GetWordFromCfg(421041015)
				local var_64_25 = arg_61_1:FormatText(var_64_24.content)

				arg_61_1.text_.text = var_64_25

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_26 = 10
				local var_64_27 = utf8.len(var_64_25)
				local var_64_28 = var_64_26 <= 0 and var_64_22 or var_64_22 * (var_64_27 / var_64_26)

				if var_64_28 > 0 and var_64_22 < var_64_28 then
					arg_61_1.talkMaxDuration = var_64_28

					if var_64_28 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_28 + var_64_21
					end
				end

				arg_61_1.text_.text = var_64_25
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041015", "story_v_out_421041.awb") ~= 0 then
					local var_64_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041015", "story_v_out_421041.awb") / 1000

					if var_64_29 + var_64_21 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_29 + var_64_21
					end

					if var_64_24.prefab_name ~= "" and arg_61_1.actors_[var_64_24.prefab_name] ~= nil then
						local var_64_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_24.prefab_name].transform, "story_v_out_421041", "421041015", "story_v_out_421041.awb")

						arg_61_1:RecordAudio("421041015", var_64_30)
						arg_61_1:RecordAudio("421041015", var_64_30)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_421041", "421041015", "story_v_out_421041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_421041", "421041015", "story_v_out_421041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_31 = math.max(var_64_22, arg_61_1.talkMaxDuration)

			if var_64_21 <= arg_61_1.time_ and arg_61_1.time_ < var_64_21 + var_64_31 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_21) / var_64_31

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_21 + var_64_31 and arg_61_1.time_ < var_64_21 + var_64_31 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 421041016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play421041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10145ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10145ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10145ui_story, var_68_4, var_68_3)

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

			local var_68_9 = arg_65_1.actors_["10143ui_story"].transform
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.var_.moveOldPos10143ui_story = var_68_9.localPosition
			end

			local var_68_11 = 0.001

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11
				local var_68_13 = Vector3.New(0, 100, 0)

				var_68_9.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10143ui_story, var_68_13, var_68_12)

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

			local var_68_18 = 0.6
			local var_68_19 = 1

			if var_68_18 < arg_65_1.time_ and arg_65_1.time_ <= var_68_18 + arg_68_0 then
				local var_68_20 = "play"
				local var_68_21 = "effect"

				arg_65_1:AudioAction(var_68_20, var_68_21, "se_story_140", "se_story_140_electric01", "")
			end

			local var_68_22 = 0
			local var_68_23 = 1.6

			if var_68_22 < arg_65_1.time_ and arg_65_1.time_ <= var_68_22 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_24 = arg_65_1:GetWordFromCfg(421041016)
				local var_68_25 = arg_65_1:FormatText(var_68_24.content)

				arg_65_1.text_.text = var_68_25

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_26 = 64
				local var_68_27 = utf8.len(var_68_25)
				local var_68_28 = var_68_26 <= 0 and var_68_23 or var_68_23 * (var_68_27 / var_68_26)

				if var_68_28 > 0 and var_68_23 < var_68_28 then
					arg_65_1.talkMaxDuration = var_68_28

					if var_68_28 + var_68_22 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_28 + var_68_22
					end
				end

				arg_65_1.text_.text = var_68_25
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_29 = math.max(var_68_23, arg_65_1.talkMaxDuration)

			if var_68_22 <= arg_65_1.time_ and arg_65_1.time_ < var_68_22 + var_68_29 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_22) / var_68_29

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_22 + var_68_29 and arg_65_1.time_ < var_68_22 + var_68_29 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421041017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 421041017
		arg_69_1.duration_ = 6.03

		local var_69_0 = {
			zh = 5,
			ja = 6.033
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
				arg_69_0:Play421041018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10143ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10143ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0.78, -1.06, -6)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10143ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["10143ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10143ui_story == nil then
				arg_69_1.var_.characterEffect10143ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect10143ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10143ui_story then
				arg_69_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_72_13 = 0

			if var_72_13 < arg_69_1.time_ and arg_69_1.time_ <= var_72_13 + arg_72_0 then
				arg_69_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_72_14 = 0

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 then
				arg_69_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_72_15 = 0
			local var_72_16 = 0.6

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[1307].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(421041017)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 24
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041017", "story_v_out_421041.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041017", "story_v_out_421041.awb") / 1000

					if var_72_23 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_421041", "421041017", "story_v_out_421041.awb")

						arg_69_1:RecordAudio("421041017", var_72_24)
						arg_69_1:RecordAudio("421041017", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_421041", "421041017", "story_v_out_421041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_421041", "421041017", "story_v_out_421041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_25 and arg_69_1.time_ < var_72_15 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play421041018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 421041018
		arg_73_1.duration_ = 4.2

		local var_73_0 = {
			zh = 2.166,
			ja = 4.2
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
				arg_73_0:Play421041019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10102ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10102ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(-0.7, -0.985, -6.275)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10102ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["10102ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10102ui_story == nil then
				arg_73_1.var_.characterEffect10102ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect10102ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10102ui_story then
				arg_73_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_76_13 = arg_73_1.actors_["10143ui_story"]
			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 and not isNil(var_76_13) and arg_73_1.var_.characterEffect10143ui_story == nil then
				arg_73_1.var_.characterEffect10143ui_story = var_76_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_15 = 0.200000002980232

			if var_76_14 <= arg_73_1.time_ and arg_73_1.time_ < var_76_14 + var_76_15 and not isNil(var_76_13) then
				local var_76_16 = (arg_73_1.time_ - var_76_14) / var_76_15

				if arg_73_1.var_.characterEffect10143ui_story and not isNil(var_76_13) then
					local var_76_17 = Mathf.Lerp(0, 0.5, var_76_16)

					arg_73_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10143ui_story.fillRatio = var_76_17
				end
			end

			if arg_73_1.time_ >= var_76_14 + var_76_15 and arg_73_1.time_ < var_76_14 + var_76_15 + arg_76_0 and not isNil(var_76_13) and arg_73_1.var_.characterEffect10143ui_story then
				local var_76_18 = 0.5

				arg_73_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10143ui_story.fillRatio = var_76_18
			end

			local var_76_19 = 0

			if var_76_19 < arg_73_1.time_ and arg_73_1.time_ <= var_76_19 + arg_76_0 then
				arg_73_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_76_20 = 0

			if var_76_20 < arg_73_1.time_ and arg_73_1.time_ <= var_76_20 + arg_76_0 then
				arg_73_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_76_21 = 0
			local var_76_22 = 0.2

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_23 = arg_73_1:FormatText(StoryNameCfg[6].name)

				arg_73_1.leftNameTxt_.text = var_76_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_24 = arg_73_1:GetWordFromCfg(421041018)
				local var_76_25 = arg_73_1:FormatText(var_76_24.content)

				arg_73_1.text_.text = var_76_25

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_26 = 8
				local var_76_27 = utf8.len(var_76_25)
				local var_76_28 = var_76_26 <= 0 and var_76_22 or var_76_22 * (var_76_27 / var_76_26)

				if var_76_28 > 0 and var_76_22 < var_76_28 then
					arg_73_1.talkMaxDuration = var_76_28

					if var_76_28 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_28 + var_76_21
					end
				end

				arg_73_1.text_.text = var_76_25
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041018", "story_v_out_421041.awb") ~= 0 then
					local var_76_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041018", "story_v_out_421041.awb") / 1000

					if var_76_29 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_29 + var_76_21
					end

					if var_76_24.prefab_name ~= "" and arg_73_1.actors_[var_76_24.prefab_name] ~= nil then
						local var_76_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_24.prefab_name].transform, "story_v_out_421041", "421041018", "story_v_out_421041.awb")

						arg_73_1:RecordAudio("421041018", var_76_30)
						arg_73_1:RecordAudio("421041018", var_76_30)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_421041", "421041018", "story_v_out_421041.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_421041", "421041018", "story_v_out_421041.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_31 = math.max(var_76_22, arg_73_1.talkMaxDuration)

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_31 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_21) / var_76_31

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_21 + var_76_31 and arg_73_1.time_ < var_76_21 + var_76_31 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421041019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 421041019
		arg_77_1.duration_ = 9.03

		local var_77_0 = {
			zh = 5.733,
			ja = 9.033
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
				arg_77_0:Play421041020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10143ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10143ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0.78, -1.06, -6)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10143ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["10143ui_story"]
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10143ui_story == nil then
				arg_77_1.var_.characterEffect10143ui_story = var_80_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_11 = 0.200000002980232

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 and not isNil(var_80_9) then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11

				if arg_77_1.var_.characterEffect10143ui_story and not isNil(var_80_9) then
					arg_77_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 and not isNil(var_80_9) and arg_77_1.var_.characterEffect10143ui_story then
				arg_77_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_80_13 = arg_77_1.actors_["10102ui_story"]
			local var_80_14 = 0

			if var_80_14 < arg_77_1.time_ and arg_77_1.time_ <= var_80_14 + arg_80_0 and not isNil(var_80_13) and arg_77_1.var_.characterEffect10102ui_story == nil then
				arg_77_1.var_.characterEffect10102ui_story = var_80_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_15 = 0.200000002980232

			if var_80_14 <= arg_77_1.time_ and arg_77_1.time_ < var_80_14 + var_80_15 and not isNil(var_80_13) then
				local var_80_16 = (arg_77_1.time_ - var_80_14) / var_80_15

				if arg_77_1.var_.characterEffect10102ui_story and not isNil(var_80_13) then
					local var_80_17 = Mathf.Lerp(0, 0.5, var_80_16)

					arg_77_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10102ui_story.fillRatio = var_80_17
				end
			end

			if arg_77_1.time_ >= var_80_14 + var_80_15 and arg_77_1.time_ < var_80_14 + var_80_15 + arg_80_0 and not isNil(var_80_13) and arg_77_1.var_.characterEffect10102ui_story then
				local var_80_18 = 0.5

				arg_77_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10102ui_story.fillRatio = var_80_18
			end

			local var_80_19 = 0

			if var_80_19 < arg_77_1.time_ and arg_77_1.time_ <= var_80_19 + arg_80_0 then
				arg_77_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_80_20 = 0

			if var_80_20 < arg_77_1.time_ and arg_77_1.time_ <= var_80_20 + arg_80_0 then
				arg_77_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_80_21 = 0
			local var_80_22 = 0.775

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_23 = arg_77_1:FormatText(StoryNameCfg[1307].name)

				arg_77_1.leftNameTxt_.text = var_80_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_24 = arg_77_1:GetWordFromCfg(421041019)
				local var_80_25 = arg_77_1:FormatText(var_80_24.content)

				arg_77_1.text_.text = var_80_25

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_26 = 31
				local var_80_27 = utf8.len(var_80_25)
				local var_80_28 = var_80_26 <= 0 and var_80_22 or var_80_22 * (var_80_27 / var_80_26)

				if var_80_28 > 0 and var_80_22 < var_80_28 then
					arg_77_1.talkMaxDuration = var_80_28

					if var_80_28 + var_80_21 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_28 + var_80_21
					end
				end

				arg_77_1.text_.text = var_80_25
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041019", "story_v_out_421041.awb") ~= 0 then
					local var_80_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041019", "story_v_out_421041.awb") / 1000

					if var_80_29 + var_80_21 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_29 + var_80_21
					end

					if var_80_24.prefab_name ~= "" and arg_77_1.actors_[var_80_24.prefab_name] ~= nil then
						local var_80_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_24.prefab_name].transform, "story_v_out_421041", "421041019", "story_v_out_421041.awb")

						arg_77_1:RecordAudio("421041019", var_80_30)
						arg_77_1:RecordAudio("421041019", var_80_30)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_421041", "421041019", "story_v_out_421041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_421041", "421041019", "story_v_out_421041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_31 = math.max(var_80_22, arg_77_1.talkMaxDuration)

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_31 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_21) / var_80_31

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_21 + var_80_31 and arg_77_1.time_ < var_80_21 + var_80_31 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421041020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 421041020
		arg_81_1.duration_ = 4.27

		local var_81_0 = {
			zh = 3.666,
			ja = 4.266
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
				arg_81_0:Play421041021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10102ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10102ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(-0.7, -0.985, -6.275)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10102ui_story, var_84_4, var_84_3)

				local var_84_5 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_5.x, var_84_5.y, var_84_5.z)

				local var_84_6 = var_84_0.localEulerAngles

				var_84_6.z = 0
				var_84_6.x = 0
				var_84_0.localEulerAngles = var_84_6
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_84_7 = manager.ui.mainCamera.transform.position - var_84_0.position

				var_84_0.forward = Vector3.New(var_84_7.x, var_84_7.y, var_84_7.z)

				local var_84_8 = var_84_0.localEulerAngles

				var_84_8.z = 0
				var_84_8.x = 0
				var_84_0.localEulerAngles = var_84_8
			end

			local var_84_9 = arg_81_1.actors_["10102ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10102ui_story == nil then
				arg_81_1.var_.characterEffect10102ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect10102ui_story and not isNil(var_84_9) then
					arg_81_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10102ui_story then
				arg_81_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_84_13 = arg_81_1.actors_["10143ui_story"]
			local var_84_14 = 0

			if var_84_14 < arg_81_1.time_ and arg_81_1.time_ <= var_84_14 + arg_84_0 and not isNil(var_84_13) and arg_81_1.var_.characterEffect10143ui_story == nil then
				arg_81_1.var_.characterEffect10143ui_story = var_84_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_15 = 0.200000002980232

			if var_84_14 <= arg_81_1.time_ and arg_81_1.time_ < var_84_14 + var_84_15 and not isNil(var_84_13) then
				local var_84_16 = (arg_81_1.time_ - var_84_14) / var_84_15

				if arg_81_1.var_.characterEffect10143ui_story and not isNil(var_84_13) then
					local var_84_17 = Mathf.Lerp(0, 0.5, var_84_16)

					arg_81_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10143ui_story.fillRatio = var_84_17
				end
			end

			if arg_81_1.time_ >= var_84_14 + var_84_15 and arg_81_1.time_ < var_84_14 + var_84_15 + arg_84_0 and not isNil(var_84_13) and arg_81_1.var_.characterEffect10143ui_story then
				local var_84_18 = 0.5

				arg_81_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10143ui_story.fillRatio = var_84_18
			end

			local var_84_19 = 0

			if var_84_19 < arg_81_1.time_ and arg_81_1.time_ <= var_84_19 + arg_84_0 then
				arg_81_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_84_20 = 0

			if var_84_20 < arg_81_1.time_ and arg_81_1.time_ <= var_84_20 + arg_84_0 then
				arg_81_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_21 = 0
			local var_84_22 = 0.375

			if var_84_21 < arg_81_1.time_ and arg_81_1.time_ <= var_84_21 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_23 = arg_81_1:FormatText(StoryNameCfg[6].name)

				arg_81_1.leftNameTxt_.text = var_84_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_24 = arg_81_1:GetWordFromCfg(421041020)
				local var_84_25 = arg_81_1:FormatText(var_84_24.content)

				arg_81_1.text_.text = var_84_25

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_26 = 15
				local var_84_27 = utf8.len(var_84_25)
				local var_84_28 = var_84_26 <= 0 and var_84_22 or var_84_22 * (var_84_27 / var_84_26)

				if var_84_28 > 0 and var_84_22 < var_84_28 then
					arg_81_1.talkMaxDuration = var_84_28

					if var_84_28 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_21
					end
				end

				arg_81_1.text_.text = var_84_25
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041020", "story_v_out_421041.awb") ~= 0 then
					local var_84_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041020", "story_v_out_421041.awb") / 1000

					if var_84_29 + var_84_21 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_29 + var_84_21
					end

					if var_84_24.prefab_name ~= "" and arg_81_1.actors_[var_84_24.prefab_name] ~= nil then
						local var_84_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_24.prefab_name].transform, "story_v_out_421041", "421041020", "story_v_out_421041.awb")

						arg_81_1:RecordAudio("421041020", var_84_30)
						arg_81_1:RecordAudio("421041020", var_84_30)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_421041", "421041020", "story_v_out_421041.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_421041", "421041020", "story_v_out_421041.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_31 = math.max(var_84_22, arg_81_1.talkMaxDuration)

			if var_84_21 <= arg_81_1.time_ and arg_81_1.time_ < var_84_21 + var_84_31 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_21) / var_84_31

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_21 + var_84_31 and arg_81_1.time_ < var_84_21 + var_84_31 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421041021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 421041021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play421041022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10102ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10102ui_story == nil then
				arg_85_1.var_.characterEffect10102ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10102ui_story and not isNil(var_88_0) then
					local var_88_4 = Mathf.Lerp(0, 0.5, var_88_3)

					arg_85_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10102ui_story.fillRatio = var_88_4
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10102ui_story then
				local var_88_5 = 0.5

				arg_85_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10102ui_story.fillRatio = var_88_5
			end

			local var_88_6 = 0
			local var_88_7 = 0.525

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_9 = arg_85_1:GetWordFromCfg(421041021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 21
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play421041022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 421041022
		arg_89_1.duration_ = 3.27

		local var_89_0 = {
			zh = 2.933,
			ja = 3.266
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
				arg_89_0:Play421041023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10102ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10102ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(-0.7, -0.985, -6.275)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10102ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["10102ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect10102ui_story == nil then
				arg_89_1.var_.characterEffect10102ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect10102ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect10102ui_story then
				arg_89_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_92_15 = 0
			local var_92_16 = 0.225

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[6].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(421041022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 9
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041022", "story_v_out_421041.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041022", "story_v_out_421041.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_421041", "421041022", "story_v_out_421041.awb")

						arg_89_1:RecordAudio("421041022", var_92_24)
						arg_89_1:RecordAudio("421041022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_421041", "421041022", "story_v_out_421041.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_421041", "421041022", "story_v_out_421041.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play421041023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 421041023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play421041024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10143ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10143ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10143ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, 100, 0)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["10102ui_story"].transform
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.var_.moveOldPos10102ui_story = var_96_9.localPosition
			end

			local var_96_11 = 0.001

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11
				local var_96_13 = Vector3.New(0, 100, 0)

				var_96_9.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10102ui_story, var_96_13, var_96_12)

				local var_96_14 = manager.ui.mainCamera.transform.position - var_96_9.position

				var_96_9.forward = Vector3.New(var_96_14.x, var_96_14.y, var_96_14.z)

				local var_96_15 = var_96_9.localEulerAngles

				var_96_15.z = 0
				var_96_15.x = 0
				var_96_9.localEulerAngles = var_96_15
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 then
				var_96_9.localPosition = Vector3.New(0, 100, 0)

				local var_96_16 = manager.ui.mainCamera.transform.position - var_96_9.position

				var_96_9.forward = Vector3.New(var_96_16.x, var_96_16.y, var_96_16.z)

				local var_96_17 = var_96_9.localEulerAngles

				var_96_17.z = 0
				var_96_17.x = 0
				var_96_9.localEulerAngles = var_96_17
			end

			local var_96_18 = 0
			local var_96_19 = 1.275

			if var_96_18 < arg_93_1.time_ and arg_93_1.time_ <= var_96_18 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_20 = arg_93_1:FormatText(StoryNameCfg[7].name)

				arg_93_1.leftNameTxt_.text = var_96_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_21 = arg_93_1:GetWordFromCfg(421041023)
				local var_96_22 = arg_93_1:FormatText(var_96_21.content)

				arg_93_1.text_.text = var_96_22

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_23 = 51
				local var_96_24 = utf8.len(var_96_22)
				local var_96_25 = var_96_23 <= 0 and var_96_19 or var_96_19 * (var_96_24 / var_96_23)

				if var_96_25 > 0 and var_96_19 < var_96_25 then
					arg_93_1.talkMaxDuration = var_96_25

					if var_96_25 + var_96_18 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_25 + var_96_18
					end
				end

				arg_93_1.text_.text = var_96_22
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_26 = math.max(var_96_19, arg_93_1.talkMaxDuration)

			if var_96_18 <= arg_93_1.time_ and arg_93_1.time_ < var_96_18 + var_96_26 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_18) / var_96_26

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_18 + var_96_26 and arg_93_1.time_ < var_96_18 + var_96_26 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play421041024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 421041024
		arg_97_1.duration_ = 11.57

		local var_97_0 = {
			zh = 11.1,
			ja = 11.566
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
				arg_97_0:Play421041025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10145ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10145ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -1, -6.2)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10145ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10145ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10145ui_story == nil then
				arg_97_1.var_.characterEffect10145ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect10145ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10145ui_story then
				arg_97_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_100_15 = 0
			local var_100_16 = 1.125

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[1308].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(421041024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 45
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041024", "story_v_out_421041.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041024", "story_v_out_421041.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_421041", "421041024", "story_v_out_421041.awb")

						arg_97_1:RecordAudio("421041024", var_100_24)
						arg_97_1:RecordAudio("421041024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_421041", "421041024", "story_v_out_421041.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_421041", "421041024", "story_v_out_421041.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_25 and arg_97_1.time_ < var_100_15 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play421041025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 421041025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play421041026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10145ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10145ui_story == nil then
				arg_101_1.var_.characterEffect10145ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10145ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10145ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10145ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10145ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0
			local var_104_7 = 1.35

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_8 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_9 = arg_101_1:GetWordFromCfg(421041025)
				local var_104_10 = arg_101_1:FormatText(var_104_9.content)

				arg_101_1.text_.text = var_104_10

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 54
				local var_104_12 = utf8.len(var_104_10)
				local var_104_13 = var_104_11 <= 0 and var_104_7 or var_104_7 * (var_104_12 / var_104_11)

				if var_104_13 > 0 and var_104_7 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_10
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play421041026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 421041026
		arg_105_1.duration_ = 2.67

		local var_105_0 = {
			zh = 2.666,
			ja = 1.999999999999
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
				arg_105_0:Play421041027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10102ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10102ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0.7, -0.985, -6.275)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10102ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["10145ui_story"].transform
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1.var_.moveOldPos10145ui_story = var_108_9.localPosition
			end

			local var_108_11 = 0.001

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11
				local var_108_13 = Vector3.New(-0.65, -1, -6.2)

				var_108_9.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10145ui_story, var_108_13, var_108_12)

				local var_108_14 = manager.ui.mainCamera.transform.position - var_108_9.position

				var_108_9.forward = Vector3.New(var_108_14.x, var_108_14.y, var_108_14.z)

				local var_108_15 = var_108_9.localEulerAngles

				var_108_15.z = 0
				var_108_15.x = 0
				var_108_9.localEulerAngles = var_108_15
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 then
				var_108_9.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_108_16 = manager.ui.mainCamera.transform.position - var_108_9.position

				var_108_9.forward = Vector3.New(var_108_16.x, var_108_16.y, var_108_16.z)

				local var_108_17 = var_108_9.localEulerAngles

				var_108_17.z = 0
				var_108_17.x = 0
				var_108_9.localEulerAngles = var_108_17
			end

			local var_108_18 = arg_105_1.actors_["10102ui_story"]
			local var_108_19 = 0

			if var_108_19 < arg_105_1.time_ and arg_105_1.time_ <= var_108_19 + arg_108_0 and not isNil(var_108_18) and arg_105_1.var_.characterEffect10102ui_story == nil then
				arg_105_1.var_.characterEffect10102ui_story = var_108_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_20 = 0.200000002980232

			if var_108_19 <= arg_105_1.time_ and arg_105_1.time_ < var_108_19 + var_108_20 and not isNil(var_108_18) then
				local var_108_21 = (arg_105_1.time_ - var_108_19) / var_108_20

				if arg_105_1.var_.characterEffect10102ui_story and not isNil(var_108_18) then
					arg_105_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_19 + var_108_20 and arg_105_1.time_ < var_108_19 + var_108_20 + arg_108_0 and not isNil(var_108_18) and arg_105_1.var_.characterEffect10102ui_story then
				arg_105_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_108_22 = 0

			if var_108_22 < arg_105_1.time_ and arg_105_1.time_ <= var_108_22 + arg_108_0 then
				arg_105_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_108_23 = 0

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_24 = 0
			local var_108_25 = 0.175

			if var_108_24 < arg_105_1.time_ and arg_105_1.time_ <= var_108_24 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_26 = arg_105_1:FormatText(StoryNameCfg[6].name)

				arg_105_1.leftNameTxt_.text = var_108_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_27 = arg_105_1:GetWordFromCfg(421041026)
				local var_108_28 = arg_105_1:FormatText(var_108_27.content)

				arg_105_1.text_.text = var_108_28

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_29 = 7
				local var_108_30 = utf8.len(var_108_28)
				local var_108_31 = var_108_29 <= 0 and var_108_25 or var_108_25 * (var_108_30 / var_108_29)

				if var_108_31 > 0 and var_108_25 < var_108_31 then
					arg_105_1.talkMaxDuration = var_108_31

					if var_108_31 + var_108_24 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_31 + var_108_24
					end
				end

				arg_105_1.text_.text = var_108_28
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041026", "story_v_out_421041.awb") ~= 0 then
					local var_108_32 = manager.audio:GetVoiceLength("story_v_out_421041", "421041026", "story_v_out_421041.awb") / 1000

					if var_108_32 + var_108_24 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_32 + var_108_24
					end

					if var_108_27.prefab_name ~= "" and arg_105_1.actors_[var_108_27.prefab_name] ~= nil then
						local var_108_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_27.prefab_name].transform, "story_v_out_421041", "421041026", "story_v_out_421041.awb")

						arg_105_1:RecordAudio("421041026", var_108_33)
						arg_105_1:RecordAudio("421041026", var_108_33)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_421041", "421041026", "story_v_out_421041.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_421041", "421041026", "story_v_out_421041.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_34 = math.max(var_108_25, arg_105_1.talkMaxDuration)

			if var_108_24 <= arg_105_1.time_ and arg_105_1.time_ < var_108_24 + var_108_34 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_24) / var_108_34

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_24 + var_108_34 and arg_105_1.time_ < var_108_24 + var_108_34 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play421041027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 421041027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play421041028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10102ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10102ui_story == nil then
				arg_109_1.var_.characterEffect10102ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect10102ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10102ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10102ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10102ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.5

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

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(421041027)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 20
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
	Play421041028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 421041028
		arg_113_1.duration_ = 19.6

		local var_113_0 = {
			zh = 13.6,
			ja = 19.6
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
				arg_113_0:Play421041029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10145ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10145ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, -1, -6.2)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10145ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["10102ui_story"].transform
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 then
				arg_113_1.var_.moveOldPos10102ui_story = var_116_9.localPosition
			end

			local var_116_11 = 0.001

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11
				local var_116_13 = Vector3.New(0, 100, 0)

				var_116_9.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10102ui_story, var_116_13, var_116_12)

				local var_116_14 = manager.ui.mainCamera.transform.position - var_116_9.position

				var_116_9.forward = Vector3.New(var_116_14.x, var_116_14.y, var_116_14.z)

				local var_116_15 = var_116_9.localEulerAngles

				var_116_15.z = 0
				var_116_15.x = 0
				var_116_9.localEulerAngles = var_116_15
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 then
				var_116_9.localPosition = Vector3.New(0, 100, 0)

				local var_116_16 = manager.ui.mainCamera.transform.position - var_116_9.position

				var_116_9.forward = Vector3.New(var_116_16.x, var_116_16.y, var_116_16.z)

				local var_116_17 = var_116_9.localEulerAngles

				var_116_17.z = 0
				var_116_17.x = 0
				var_116_9.localEulerAngles = var_116_17
			end

			local var_116_18 = arg_113_1.actors_["10145ui_story"]
			local var_116_19 = 0

			if var_116_19 < arg_113_1.time_ and arg_113_1.time_ <= var_116_19 + arg_116_0 and not isNil(var_116_18) and arg_113_1.var_.characterEffect10145ui_story == nil then
				arg_113_1.var_.characterEffect10145ui_story = var_116_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_20 = 0.200000002980232

			if var_116_19 <= arg_113_1.time_ and arg_113_1.time_ < var_116_19 + var_116_20 and not isNil(var_116_18) then
				local var_116_21 = (arg_113_1.time_ - var_116_19) / var_116_20

				if arg_113_1.var_.characterEffect10145ui_story and not isNil(var_116_18) then
					arg_113_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_19 + var_116_20 and arg_113_1.time_ < var_116_19 + var_116_20 + arg_116_0 and not isNil(var_116_18) and arg_113_1.var_.characterEffect10145ui_story then
				arg_113_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_116_22 = 0

			if var_116_22 < arg_113_1.time_ and arg_113_1.time_ <= var_116_22 + arg_116_0 then
				arg_113_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_116_23 = 0

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_116_24 = 0
			local var_116_25 = 1.55

			if var_116_24 < arg_113_1.time_ and arg_113_1.time_ <= var_116_24 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_26 = arg_113_1:FormatText(StoryNameCfg[1308].name)

				arg_113_1.leftNameTxt_.text = var_116_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_27 = arg_113_1:GetWordFromCfg(421041028)
				local var_116_28 = arg_113_1:FormatText(var_116_27.content)

				arg_113_1.text_.text = var_116_28

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_29 = 62
				local var_116_30 = utf8.len(var_116_28)
				local var_116_31 = var_116_29 <= 0 and var_116_25 or var_116_25 * (var_116_30 / var_116_29)

				if var_116_31 > 0 and var_116_25 < var_116_31 then
					arg_113_1.talkMaxDuration = var_116_31

					if var_116_31 + var_116_24 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_24
					end
				end

				arg_113_1.text_.text = var_116_28
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041028", "story_v_out_421041.awb") ~= 0 then
					local var_116_32 = manager.audio:GetVoiceLength("story_v_out_421041", "421041028", "story_v_out_421041.awb") / 1000

					if var_116_32 + var_116_24 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_32 + var_116_24
					end

					if var_116_27.prefab_name ~= "" and arg_113_1.actors_[var_116_27.prefab_name] ~= nil then
						local var_116_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_27.prefab_name].transform, "story_v_out_421041", "421041028", "story_v_out_421041.awb")

						arg_113_1:RecordAudio("421041028", var_116_33)
						arg_113_1:RecordAudio("421041028", var_116_33)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_421041", "421041028", "story_v_out_421041.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_421041", "421041028", "story_v_out_421041.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_34 = math.max(var_116_25, arg_113_1.talkMaxDuration)

			if var_116_24 <= arg_113_1.time_ and arg_113_1.time_ < var_116_24 + var_116_34 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_24) / var_116_34

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_24 + var_116_34 and arg_113_1.time_ < var_116_24 + var_116_34 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421041029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 421041029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play421041030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10145ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10145ui_story == nil then
				arg_117_1.var_.characterEffect10145ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect10145ui_story and not isNil(var_120_0) then
					local var_120_4 = Mathf.Lerp(0, 0.5, var_120_3)

					arg_117_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10145ui_story.fillRatio = var_120_4
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect10145ui_story then
				local var_120_5 = 0.5

				arg_117_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10145ui_story.fillRatio = var_120_5
			end

			local var_120_6 = 0
			local var_120_7 = 0.35

			if var_120_6 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_8 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_9 = arg_117_1:GetWordFromCfg(421041029)
				local var_120_10 = arg_117_1:FormatText(var_120_9.content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 14
				local var_120_12 = utf8.len(var_120_10)
				local var_120_13 = var_120_11 <= 0 and var_120_7 or var_120_7 * (var_120_12 / var_120_11)

				if var_120_13 > 0 and var_120_7 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play421041030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 421041030
		arg_121_1.duration_ = 21.3

		local var_121_0 = {
			zh = 17.8,
			ja = 21.3
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
				arg_121_0:Play421041031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10145ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10145ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, -1, -6.2)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10145ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["10145ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10145ui_story == nil then
				arg_121_1.var_.characterEffect10145ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect10145ui_story and not isNil(var_124_9) then
					arg_121_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10145ui_story then
				arg_121_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_124_13 = 0

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_1")
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_124_15 = 0
			local var_124_16 = 1.7

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[1308].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(421041030)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 68
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041030", "story_v_out_421041.awb") ~= 0 then
					local var_124_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041030", "story_v_out_421041.awb") / 1000

					if var_124_23 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_15
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_421041", "421041030", "story_v_out_421041.awb")

						arg_121_1:RecordAudio("421041030", var_124_24)
						arg_121_1:RecordAudio("421041030", var_124_24)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_421041", "421041030", "story_v_out_421041.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_421041", "421041030", "story_v_out_421041.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_25 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_25 and arg_121_1.time_ < var_124_15 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 421041031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play421041032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10145ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10145ui_story == nil then
				arg_125_1.var_.characterEffect10145ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect10145ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10145ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10145ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10145ui_story.fillRatio = var_128_5
			end

			local var_128_6 = 0
			local var_128_7 = 0.375

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_8 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_9 = arg_125_1:GetWordFromCfg(421041031)
				local var_128_10 = arg_125_1:FormatText(var_128_9.content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 15
				local var_128_12 = utf8.len(var_128_10)
				local var_128_13 = var_128_11 <= 0 and var_128_7 or var_128_7 * (var_128_12 / var_128_11)

				if var_128_13 > 0 and var_128_7 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play421041032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 421041032
		arg_129_1.duration_ = 3.3

		local var_129_0 = {
			zh = 2.233,
			ja = 3.3
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
				arg_129_0:Play421041033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10145ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10145ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, -1, -6.2)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10145ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["10145ui_story"]
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect10145ui_story == nil then
				arg_129_1.var_.characterEffect10145ui_story = var_132_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 and not isNil(var_132_9) then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11

				if arg_129_1.var_.characterEffect10145ui_story and not isNil(var_132_9) then
					arg_129_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect10145ui_story then
				arg_129_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_132_13 = 0

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				arg_129_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_2")
			end

			local var_132_14 = 0

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 then
				arg_129_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_132_15 = 0
			local var_132_16 = 0.125

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[1308].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(421041032)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 5
				local var_132_21 = utf8.len(var_132_19)
				local var_132_22 = var_132_20 <= 0 and var_132_16 or var_132_16 * (var_132_21 / var_132_20)

				if var_132_22 > 0 and var_132_16 < var_132_22 then
					arg_129_1.talkMaxDuration = var_132_22

					if var_132_22 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_22 + var_132_15
					end
				end

				arg_129_1.text_.text = var_132_19
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041032", "story_v_out_421041.awb") ~= 0 then
					local var_132_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041032", "story_v_out_421041.awb") / 1000

					if var_132_23 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_15
					end

					if var_132_18.prefab_name ~= "" and arg_129_1.actors_[var_132_18.prefab_name] ~= nil then
						local var_132_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_18.prefab_name].transform, "story_v_out_421041", "421041032", "story_v_out_421041.awb")

						arg_129_1:RecordAudio("421041032", var_132_24)
						arg_129_1:RecordAudio("421041032", var_132_24)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_421041", "421041032", "story_v_out_421041.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_421041", "421041032", "story_v_out_421041.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_25 = math.max(var_132_16, arg_129_1.talkMaxDuration)

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_25 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_15) / var_132_25

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_15 + var_132_25 and arg_129_1.time_ < var_132_15 + var_132_25 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 421041033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play421041034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10145ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10145ui_story == nil then
				arg_133_1.var_.characterEffect10145ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect10145ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10145ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10145ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10145ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0
			local var_136_7 = 0.725

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[7].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_9 = arg_133_1:GetWordFromCfg(421041033)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 29
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_7 or var_136_7 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_7 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play421041034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 421041034
		arg_137_1.duration_ = 11.07

		local var_137_0 = {
			zh = 11.066,
			ja = 8.3
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
				arg_137_0:Play421041035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10145ui_story"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10145ui_story = var_140_0.localPosition
			end

			local var_140_2 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2
				local var_140_4 = Vector3.New(0, -1, -6.2)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10145ui_story, var_140_4, var_140_3)

				local var_140_5 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_5.x, var_140_5.y, var_140_5.z)

				local var_140_6 = var_140_0.localEulerAngles

				var_140_6.z = 0
				var_140_6.x = 0
				var_140_0.localEulerAngles = var_140_6
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_140_7 = manager.ui.mainCamera.transform.position - var_140_0.position

				var_140_0.forward = Vector3.New(var_140_7.x, var_140_7.y, var_140_7.z)

				local var_140_8 = var_140_0.localEulerAngles

				var_140_8.z = 0
				var_140_8.x = 0
				var_140_0.localEulerAngles = var_140_8
			end

			local var_140_9 = arg_137_1.actors_["10145ui_story"]
			local var_140_10 = 0

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect10145ui_story == nil then
				arg_137_1.var_.characterEffect10145ui_story = var_140_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_11 = 0.200000002980232

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_11 and not isNil(var_140_9) then
				local var_140_12 = (arg_137_1.time_ - var_140_10) / var_140_11

				if arg_137_1.var_.characterEffect10145ui_story and not isNil(var_140_9) then
					arg_137_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_10 + var_140_11 and arg_137_1.time_ < var_140_10 + var_140_11 + arg_140_0 and not isNil(var_140_9) and arg_137_1.var_.characterEffect10145ui_story then
				arg_137_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_140_13 = 0

			if var_140_13 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_140_14 = 0

			if var_140_14 < arg_137_1.time_ and arg_137_1.time_ <= var_140_14 + arg_140_0 then
				arg_137_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_140_15 = 0
			local var_140_16 = 0.825

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[1308].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(421041034)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 33
				local var_140_21 = utf8.len(var_140_19)
				local var_140_22 = var_140_20 <= 0 and var_140_16 or var_140_16 * (var_140_21 / var_140_20)

				if var_140_22 > 0 and var_140_16 < var_140_22 then
					arg_137_1.talkMaxDuration = var_140_22

					if var_140_22 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_19
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041034", "story_v_out_421041.awb") ~= 0 then
					local var_140_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041034", "story_v_out_421041.awb") / 1000

					if var_140_23 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_15
					end

					if var_140_18.prefab_name ~= "" and arg_137_1.actors_[var_140_18.prefab_name] ~= nil then
						local var_140_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_18.prefab_name].transform, "story_v_out_421041", "421041034", "story_v_out_421041.awb")

						arg_137_1:RecordAudio("421041034", var_140_24)
						arg_137_1:RecordAudio("421041034", var_140_24)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_421041", "421041034", "story_v_out_421041.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_421041", "421041034", "story_v_out_421041.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_25 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_25 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_25

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_25 and arg_137_1.time_ < var_140_15 + var_140_25 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play421041035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 421041035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play421041036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10145ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10145ui_story == nil then
				arg_141_1.var_.characterEffect10145ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10145ui_story and not isNil(var_144_0) then
					local var_144_4 = Mathf.Lerp(0, 0.5, var_144_3)

					arg_141_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10145ui_story.fillRatio = var_144_4
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10145ui_story then
				local var_144_5 = 0.5

				arg_141_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10145ui_story.fillRatio = var_144_5
			end

			local var_144_6 = 0
			local var_144_7 = 0.075

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[7].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_9 = arg_141_1:GetWordFromCfg(421041035)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 3
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
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play421041036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 421041036
		arg_145_1.duration_ = 6.37

		local var_145_0 = {
			zh = 6.366,
			ja = 6.233
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
				arg_145_0:Play421041037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10145ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10145ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, -1, -6.2)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10145ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["10145ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect10145ui_story == nil then
				arg_145_1.var_.characterEffect10145ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect10145ui_story and not isNil(var_148_9) then
					arg_145_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect10145ui_story then
				arg_145_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_148_13 = 0

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 then
				arg_145_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_148_14 = 0

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_148_15 = 0
			local var_148_16 = 0.65

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[1308].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(421041036)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041036", "story_v_out_421041.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041036", "story_v_out_421041.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_421041", "421041036", "story_v_out_421041.awb")

						arg_145_1:RecordAudio("421041036", var_148_24)
						arg_145_1:RecordAudio("421041036", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_421041", "421041036", "story_v_out_421041.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_421041", "421041036", "story_v_out_421041.awb")
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
				actorName = "10145ui_story",
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
	Play421041037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 421041037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play421041038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10145ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10145ui_story == nil then
				arg_149_1.var_.characterEffect10145ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect10145ui_story and not isNil(var_152_0) then
					local var_152_4 = Mathf.Lerp(0, 0.5, var_152_3)

					arg_149_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10145ui_story.fillRatio = var_152_4
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10145ui_story then
				local var_152_5 = 0.5

				arg_149_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10145ui_story.fillRatio = var_152_5
			end

			local var_152_6 = 0
			local var_152_7 = 0.05

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_8 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_9 = arg_149_1:GetWordFromCfg(421041037)
				local var_152_10 = arg_149_1:FormatText(var_152_9.content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 2
				local var_152_12 = utf8.len(var_152_10)
				local var_152_13 = var_152_11 <= 0 and var_152_7 or var_152_7 * (var_152_12 / var_152_11)

				if var_152_13 > 0 and var_152_7 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play421041038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 421041038
		arg_153_1.duration_ = 7.03

		local var_153_0 = {
			zh = 5,
			ja = 7.033
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
				arg_153_0:Play421041039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10143ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos10143ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(0.78, -1.06, -6)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10143ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["10145ui_story"].transform
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1.var_.moveOldPos10145ui_story = var_156_9.localPosition
			end

			local var_156_11 = 0.001

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11
				local var_156_13 = Vector3.New(-0.65, -1, -6.2)

				var_156_9.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10145ui_story, var_156_13, var_156_12)

				local var_156_14 = manager.ui.mainCamera.transform.position - var_156_9.position

				var_156_9.forward = Vector3.New(var_156_14.x, var_156_14.y, var_156_14.z)

				local var_156_15 = var_156_9.localEulerAngles

				var_156_15.z = 0
				var_156_15.x = 0
				var_156_9.localEulerAngles = var_156_15
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 then
				var_156_9.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_156_16 = manager.ui.mainCamera.transform.position - var_156_9.position

				var_156_9.forward = Vector3.New(var_156_16.x, var_156_16.y, var_156_16.z)

				local var_156_17 = var_156_9.localEulerAngles

				var_156_17.z = 0
				var_156_17.x = 0
				var_156_9.localEulerAngles = var_156_17
			end

			local var_156_18 = arg_153_1.actors_["10143ui_story"]
			local var_156_19 = 0

			if var_156_19 < arg_153_1.time_ and arg_153_1.time_ <= var_156_19 + arg_156_0 and not isNil(var_156_18) and arg_153_1.var_.characterEffect10143ui_story == nil then
				arg_153_1.var_.characterEffect10143ui_story = var_156_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_20 = 0.200000002980232

			if var_156_19 <= arg_153_1.time_ and arg_153_1.time_ < var_156_19 + var_156_20 and not isNil(var_156_18) then
				local var_156_21 = (arg_153_1.time_ - var_156_19) / var_156_20

				if arg_153_1.var_.characterEffect10143ui_story and not isNil(var_156_18) then
					arg_153_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_19 + var_156_20 and arg_153_1.time_ < var_156_19 + var_156_20 + arg_156_0 and not isNil(var_156_18) and arg_153_1.var_.characterEffect10143ui_story then
				arg_153_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_156_22 = 0

			if var_156_22 < arg_153_1.time_ and arg_153_1.time_ <= var_156_22 + arg_156_0 then
				arg_153_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_156_23 = 0

			if var_156_23 < arg_153_1.time_ and arg_153_1.time_ <= var_156_23 + arg_156_0 then
				arg_153_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_156_24 = 0
			local var_156_25 = 0.675

			if var_156_24 < arg_153_1.time_ and arg_153_1.time_ <= var_156_24 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_26 = arg_153_1:FormatText(StoryNameCfg[1307].name)

				arg_153_1.leftNameTxt_.text = var_156_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_27 = arg_153_1:GetWordFromCfg(421041038)
				local var_156_28 = arg_153_1:FormatText(var_156_27.content)

				arg_153_1.text_.text = var_156_28

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_29 = 27
				local var_156_30 = utf8.len(var_156_28)
				local var_156_31 = var_156_29 <= 0 and var_156_25 or var_156_25 * (var_156_30 / var_156_29)

				if var_156_31 > 0 and var_156_25 < var_156_31 then
					arg_153_1.talkMaxDuration = var_156_31

					if var_156_31 + var_156_24 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_31 + var_156_24
					end
				end

				arg_153_1.text_.text = var_156_28
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041038", "story_v_out_421041.awb") ~= 0 then
					local var_156_32 = manager.audio:GetVoiceLength("story_v_out_421041", "421041038", "story_v_out_421041.awb") / 1000

					if var_156_32 + var_156_24 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_32 + var_156_24
					end

					if var_156_27.prefab_name ~= "" and arg_153_1.actors_[var_156_27.prefab_name] ~= nil then
						local var_156_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_27.prefab_name].transform, "story_v_out_421041", "421041038", "story_v_out_421041.awb")

						arg_153_1:RecordAudio("421041038", var_156_33)
						arg_153_1:RecordAudio("421041038", var_156_33)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_421041", "421041038", "story_v_out_421041.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_421041", "421041038", "story_v_out_421041.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_34 = math.max(var_156_25, arg_153_1.talkMaxDuration)

			if var_156_24 <= arg_153_1.time_ and arg_153_1.time_ < var_156_24 + var_156_34 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_24) / var_156_34

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_24 + var_156_34 and arg_153_1.time_ < var_156_24 + var_156_34 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play421041039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 421041039
		arg_157_1.duration_ = 9.13

		local var_157_0 = {
			zh = 6.966,
			ja = 9.133
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
				arg_157_0:Play421041040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10145ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10145ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(-0.65, -1, -6.2)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10145ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["10145ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect10145ui_story == nil then
				arg_157_1.var_.characterEffect10145ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect10145ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect10145ui_story then
				arg_157_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_160_13 = arg_157_1.actors_["10143ui_story"]
			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 and not isNil(var_160_13) and arg_157_1.var_.characterEffect10143ui_story == nil then
				arg_157_1.var_.characterEffect10143ui_story = var_160_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_15 = 0.200000002980232

			if var_160_14 <= arg_157_1.time_ and arg_157_1.time_ < var_160_14 + var_160_15 and not isNil(var_160_13) then
				local var_160_16 = (arg_157_1.time_ - var_160_14) / var_160_15

				if arg_157_1.var_.characterEffect10143ui_story and not isNil(var_160_13) then
					local var_160_17 = Mathf.Lerp(0, 0.5, var_160_16)

					arg_157_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10143ui_story.fillRatio = var_160_17
				end
			end

			if arg_157_1.time_ >= var_160_14 + var_160_15 and arg_157_1.time_ < var_160_14 + var_160_15 + arg_160_0 and not isNil(var_160_13) and arg_157_1.var_.characterEffect10143ui_story then
				local var_160_18 = 0.5

				arg_157_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10143ui_story.fillRatio = var_160_18
			end

			local var_160_19 = 0

			if var_160_19 < arg_157_1.time_ and arg_157_1.time_ <= var_160_19 + arg_160_0 then
				arg_157_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			local var_160_20 = 0

			if var_160_20 < arg_157_1.time_ and arg_157_1.time_ <= var_160_20 + arg_160_0 then
				arg_157_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_160_21 = 0
			local var_160_22 = 0.775

			if var_160_21 < arg_157_1.time_ and arg_157_1.time_ <= var_160_21 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_23 = arg_157_1:FormatText(StoryNameCfg[1308].name)

				arg_157_1.leftNameTxt_.text = var_160_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_24 = arg_157_1:GetWordFromCfg(421041039)
				local var_160_25 = arg_157_1:FormatText(var_160_24.content)

				arg_157_1.text_.text = var_160_25

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_26 = 31
				local var_160_27 = utf8.len(var_160_25)
				local var_160_28 = var_160_26 <= 0 and var_160_22 or var_160_22 * (var_160_27 / var_160_26)

				if var_160_28 > 0 and var_160_22 < var_160_28 then
					arg_157_1.talkMaxDuration = var_160_28

					if var_160_28 + var_160_21 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_28 + var_160_21
					end
				end

				arg_157_1.text_.text = var_160_25
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041039", "story_v_out_421041.awb") ~= 0 then
					local var_160_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041039", "story_v_out_421041.awb") / 1000

					if var_160_29 + var_160_21 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_29 + var_160_21
					end

					if var_160_24.prefab_name ~= "" and arg_157_1.actors_[var_160_24.prefab_name] ~= nil then
						local var_160_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_24.prefab_name].transform, "story_v_out_421041", "421041039", "story_v_out_421041.awb")

						arg_157_1:RecordAudio("421041039", var_160_30)
						arg_157_1:RecordAudio("421041039", var_160_30)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_421041", "421041039", "story_v_out_421041.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_421041", "421041039", "story_v_out_421041.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_31 = math.max(var_160_22, arg_157_1.talkMaxDuration)

			if var_160_21 <= arg_157_1.time_ and arg_157_1.time_ < var_160_21 + var_160_31 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_21) / var_160_31

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_21 + var_160_31 and arg_157_1.time_ < var_160_21 + var_160_31 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 421041040
		arg_161_1.duration_ = 13.4

		local var_161_0 = {
			zh = 10.066,
			ja = 13.4
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
				arg_161_0:Play421041041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1047ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1047ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1047ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = arg_161_1.actors_["10145ui_story"].transform
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.var_.moveOldPos10145ui_story = var_164_9.localPosition
			end

			local var_164_11 = 0.001

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11
				local var_164_13 = Vector3.New(0, 100, 0)

				var_164_9.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10145ui_story, var_164_13, var_164_12)

				local var_164_14 = manager.ui.mainCamera.transform.position - var_164_9.position

				var_164_9.forward = Vector3.New(var_164_14.x, var_164_14.y, var_164_14.z)

				local var_164_15 = var_164_9.localEulerAngles

				var_164_15.z = 0
				var_164_15.x = 0
				var_164_9.localEulerAngles = var_164_15
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 then
				var_164_9.localPosition = Vector3.New(0, 100, 0)

				local var_164_16 = manager.ui.mainCamera.transform.position - var_164_9.position

				var_164_9.forward = Vector3.New(var_164_16.x, var_164_16.y, var_164_16.z)

				local var_164_17 = var_164_9.localEulerAngles

				var_164_17.z = 0
				var_164_17.x = 0
				var_164_9.localEulerAngles = var_164_17
			end

			local var_164_18 = arg_161_1.actors_["1047ui_story"]
			local var_164_19 = 0

			if var_164_19 < arg_161_1.time_ and arg_161_1.time_ <= var_164_19 + arg_164_0 and not isNil(var_164_18) and arg_161_1.var_.characterEffect1047ui_story == nil then
				arg_161_1.var_.characterEffect1047ui_story = var_164_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_20 = 0.200000002980232

			if var_164_19 <= arg_161_1.time_ and arg_161_1.time_ < var_164_19 + var_164_20 and not isNil(var_164_18) then
				local var_164_21 = (arg_161_1.time_ - var_164_19) / var_164_20

				if arg_161_1.var_.characterEffect1047ui_story and not isNil(var_164_18) then
					arg_161_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_19 + var_164_20 and arg_161_1.time_ < var_164_19 + var_164_20 + arg_164_0 and not isNil(var_164_18) and arg_161_1.var_.characterEffect1047ui_story then
				arg_161_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_164_22 = arg_161_1.actors_["10145ui_story"]
			local var_164_23 = 0

			if var_164_23 < arg_161_1.time_ and arg_161_1.time_ <= var_164_23 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.characterEffect10145ui_story == nil then
				arg_161_1.var_.characterEffect10145ui_story = var_164_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_24 = 0.200000002980232

			if var_164_23 <= arg_161_1.time_ and arg_161_1.time_ < var_164_23 + var_164_24 and not isNil(var_164_22) then
				local var_164_25 = (arg_161_1.time_ - var_164_23) / var_164_24

				if arg_161_1.var_.characterEffect10145ui_story and not isNil(var_164_22) then
					local var_164_26 = Mathf.Lerp(0, 0.5, var_164_25)

					arg_161_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10145ui_story.fillRatio = var_164_26
				end
			end

			if arg_161_1.time_ >= var_164_23 + var_164_24 and arg_161_1.time_ < var_164_23 + var_164_24 + arg_164_0 and not isNil(var_164_22) and arg_161_1.var_.characterEffect10145ui_story then
				local var_164_27 = 0.5

				arg_161_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10145ui_story.fillRatio = var_164_27
			end

			local var_164_28 = 0

			if var_164_28 < arg_161_1.time_ and arg_161_1.time_ <= var_164_28 + arg_164_0 then
				arg_161_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_164_29 = 0

			if var_164_29 < arg_161_1.time_ and arg_161_1.time_ <= var_164_29 + arg_164_0 then
				arg_161_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_164_30 = 0
			local var_164_31 = 1.125

			if var_164_30 < arg_161_1.time_ and arg_161_1.time_ <= var_164_30 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_32 = arg_161_1:FormatText(StoryNameCfg[1296].name)

				arg_161_1.leftNameTxt_.text = var_164_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_33 = arg_161_1:GetWordFromCfg(421041040)
				local var_164_34 = arg_161_1:FormatText(var_164_33.content)

				arg_161_1.text_.text = var_164_34

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_35 = 45
				local var_164_36 = utf8.len(var_164_34)
				local var_164_37 = var_164_35 <= 0 and var_164_31 or var_164_31 * (var_164_36 / var_164_35)

				if var_164_37 > 0 and var_164_31 < var_164_37 then
					arg_161_1.talkMaxDuration = var_164_37

					if var_164_37 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_37 + var_164_30
					end
				end

				arg_161_1.text_.text = var_164_34
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041040", "story_v_out_421041.awb") ~= 0 then
					local var_164_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041040", "story_v_out_421041.awb") / 1000

					if var_164_38 + var_164_30 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_38 + var_164_30
					end

					if var_164_33.prefab_name ~= "" and arg_161_1.actors_[var_164_33.prefab_name] ~= nil then
						local var_164_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_33.prefab_name].transform, "story_v_out_421041", "421041040", "story_v_out_421041.awb")

						arg_161_1:RecordAudio("421041040", var_164_39)
						arg_161_1:RecordAudio("421041040", var_164_39)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_421041", "421041040", "story_v_out_421041.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_421041", "421041040", "story_v_out_421041.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_40 = math.max(var_164_31, arg_161_1.talkMaxDuration)

			if var_164_30 <= arg_161_1.time_ and arg_161_1.time_ < var_164_30 + var_164_40 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_30) / var_164_40

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_30 + var_164_40 and arg_161_1.time_ < var_164_30 + var_164_40 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play421041041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 421041041
		arg_165_1.duration_ = 12

		local var_165_0 = {
			zh = 8.733,
			ja = 12
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
				arg_165_0:Play421041042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10143ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos10143ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0.78, -1.06, -6)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10143ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["10143ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect10143ui_story == nil then
				arg_165_1.var_.characterEffect10143ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect10143ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect10143ui_story then
				arg_165_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_168_13 = arg_165_1.actors_["1047ui_story"]
			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 and not isNil(var_168_13) and arg_165_1.var_.characterEffect1047ui_story == nil then
				arg_165_1.var_.characterEffect1047ui_story = var_168_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_15 = 0.200000002980232

			if var_168_14 <= arg_165_1.time_ and arg_165_1.time_ < var_168_14 + var_168_15 and not isNil(var_168_13) then
				local var_168_16 = (arg_165_1.time_ - var_168_14) / var_168_15

				if arg_165_1.var_.characterEffect1047ui_story and not isNil(var_168_13) then
					local var_168_17 = Mathf.Lerp(0, 0.5, var_168_16)

					arg_165_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1047ui_story.fillRatio = var_168_17
				end
			end

			if arg_165_1.time_ >= var_168_14 + var_168_15 and arg_165_1.time_ < var_168_14 + var_168_15 + arg_168_0 and not isNil(var_168_13) and arg_165_1.var_.characterEffect1047ui_story then
				local var_168_18 = 0.5

				arg_165_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1047ui_story.fillRatio = var_168_18
			end

			local var_168_19 = 0

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_168_20 = 0

			if var_168_20 < arg_165_1.time_ and arg_165_1.time_ <= var_168_20 + arg_168_0 then
				arg_165_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_168_21 = 0
			local var_168_22 = 0.9

			if var_168_21 < arg_165_1.time_ and arg_165_1.time_ <= var_168_21 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_23 = arg_165_1:FormatText(StoryNameCfg[1307].name)

				arg_165_1.leftNameTxt_.text = var_168_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_24 = arg_165_1:GetWordFromCfg(421041041)
				local var_168_25 = arg_165_1:FormatText(var_168_24.content)

				arg_165_1.text_.text = var_168_25

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_26 = 36
				local var_168_27 = utf8.len(var_168_25)
				local var_168_28 = var_168_26 <= 0 and var_168_22 or var_168_22 * (var_168_27 / var_168_26)

				if var_168_28 > 0 and var_168_22 < var_168_28 then
					arg_165_1.talkMaxDuration = var_168_28

					if var_168_28 + var_168_21 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_28 + var_168_21
					end
				end

				arg_165_1.text_.text = var_168_25
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041041", "story_v_out_421041.awb") ~= 0 then
					local var_168_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041041", "story_v_out_421041.awb") / 1000

					if var_168_29 + var_168_21 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_29 + var_168_21
					end

					if var_168_24.prefab_name ~= "" and arg_165_1.actors_[var_168_24.prefab_name] ~= nil then
						local var_168_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_24.prefab_name].transform, "story_v_out_421041", "421041041", "story_v_out_421041.awb")

						arg_165_1:RecordAudio("421041041", var_168_30)
						arg_165_1:RecordAudio("421041041", var_168_30)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_421041", "421041041", "story_v_out_421041.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_421041", "421041041", "story_v_out_421041.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_31 = math.max(var_168_22, arg_165_1.talkMaxDuration)

			if var_168_21 <= arg_165_1.time_ and arg_165_1.time_ < var_168_21 + var_168_31 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_21) / var_168_31

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_21 + var_168_31 and arg_165_1.time_ < var_168_21 + var_168_31 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play421041042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 421041042
		arg_169_1.duration_ = 10.13

		local var_169_0 = {
			zh = 5.933,
			ja = 10.133
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
				arg_169_0:Play421041043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1047ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1047ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1047ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1047ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1047ui_story == nil then
				arg_169_1.var_.characterEffect1047ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1047ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1047ui_story then
				arg_169_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_172_13 = arg_169_1.actors_["10143ui_story"]
			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 and not isNil(var_172_13) and arg_169_1.var_.characterEffect10143ui_story == nil then
				arg_169_1.var_.characterEffect10143ui_story = var_172_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_15 = 0.200000002980232

			if var_172_14 <= arg_169_1.time_ and arg_169_1.time_ < var_172_14 + var_172_15 and not isNil(var_172_13) then
				local var_172_16 = (arg_169_1.time_ - var_172_14) / var_172_15

				if arg_169_1.var_.characterEffect10143ui_story and not isNil(var_172_13) then
					local var_172_17 = Mathf.Lerp(0, 0.5, var_172_16)

					arg_169_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10143ui_story.fillRatio = var_172_17
				end
			end

			if arg_169_1.time_ >= var_172_14 + var_172_15 and arg_169_1.time_ < var_172_14 + var_172_15 + arg_172_0 and not isNil(var_172_13) and arg_169_1.var_.characterEffect10143ui_story then
				local var_172_18 = 0.5

				arg_169_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10143ui_story.fillRatio = var_172_18
			end

			local var_172_19 = 0

			if var_172_19 < arg_169_1.time_ and arg_169_1.time_ <= var_172_19 + arg_172_0 then
				arg_169_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_172_20 = 0

			if var_172_20 < arg_169_1.time_ and arg_169_1.time_ <= var_172_20 + arg_172_0 then
				arg_169_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_172_21 = 0
			local var_172_22 = 0.6

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_23 = arg_169_1:FormatText(StoryNameCfg[1296].name)

				arg_169_1.leftNameTxt_.text = var_172_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_24 = arg_169_1:GetWordFromCfg(421041042)
				local var_172_25 = arg_169_1:FormatText(var_172_24.content)

				arg_169_1.text_.text = var_172_25

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_26 = 24
				local var_172_27 = utf8.len(var_172_25)
				local var_172_28 = var_172_26 <= 0 and var_172_22 or var_172_22 * (var_172_27 / var_172_26)

				if var_172_28 > 0 and var_172_22 < var_172_28 then
					arg_169_1.talkMaxDuration = var_172_28

					if var_172_28 + var_172_21 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_28 + var_172_21
					end
				end

				arg_169_1.text_.text = var_172_25
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041042", "story_v_out_421041.awb") ~= 0 then
					local var_172_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041042", "story_v_out_421041.awb") / 1000

					if var_172_29 + var_172_21 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_29 + var_172_21
					end

					if var_172_24.prefab_name ~= "" and arg_169_1.actors_[var_172_24.prefab_name] ~= nil then
						local var_172_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_24.prefab_name].transform, "story_v_out_421041", "421041042", "story_v_out_421041.awb")

						arg_169_1:RecordAudio("421041042", var_172_30)
						arg_169_1:RecordAudio("421041042", var_172_30)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_421041", "421041042", "story_v_out_421041.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_421041", "421041042", "story_v_out_421041.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_31 = math.max(var_172_22, arg_169_1.talkMaxDuration)

			if var_172_21 <= arg_169_1.time_ and arg_169_1.time_ < var_172_21 + var_172_31 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_21) / var_172_31

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_21 + var_172_31 and arg_169_1.time_ < var_172_21 + var_172_31 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play421041043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 421041043
		arg_173_1.duration_ = 2.37

		local var_173_0 = {
			zh = 2.366,
			ja = 2.233
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
				arg_173_0:Play421041044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10102ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10102ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0.7, -0.985, -6.275)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10102ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["10143ui_story"].transform
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.var_.moveOldPos10143ui_story = var_176_9.localPosition
			end

			local var_176_11 = 0.001

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11
				local var_176_13 = Vector3.New(0, 100, 0)

				var_176_9.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10143ui_story, var_176_13, var_176_12)

				local var_176_14 = manager.ui.mainCamera.transform.position - var_176_9.position

				var_176_9.forward = Vector3.New(var_176_14.x, var_176_14.y, var_176_14.z)

				local var_176_15 = var_176_9.localEulerAngles

				var_176_15.z = 0
				var_176_15.x = 0
				var_176_9.localEulerAngles = var_176_15
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 then
				var_176_9.localPosition = Vector3.New(0, 100, 0)

				local var_176_16 = manager.ui.mainCamera.transform.position - var_176_9.position

				var_176_9.forward = Vector3.New(var_176_16.x, var_176_16.y, var_176_16.z)

				local var_176_17 = var_176_9.localEulerAngles

				var_176_17.z = 0
				var_176_17.x = 0
				var_176_9.localEulerAngles = var_176_17
			end

			local var_176_18 = arg_173_1.actors_["10102ui_story"]
			local var_176_19 = 0

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 and not isNil(var_176_18) and arg_173_1.var_.characterEffect10102ui_story == nil then
				arg_173_1.var_.characterEffect10102ui_story = var_176_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_20 = 0.200000002980232

			if var_176_19 <= arg_173_1.time_ and arg_173_1.time_ < var_176_19 + var_176_20 and not isNil(var_176_18) then
				local var_176_21 = (arg_173_1.time_ - var_176_19) / var_176_20

				if arg_173_1.var_.characterEffect10102ui_story and not isNil(var_176_18) then
					arg_173_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_19 + var_176_20 and arg_173_1.time_ < var_176_19 + var_176_20 + arg_176_0 and not isNil(var_176_18) and arg_173_1.var_.characterEffect10102ui_story then
				arg_173_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_176_22 = arg_173_1.actors_["1047ui_story"]
			local var_176_23 = 0

			if var_176_23 < arg_173_1.time_ and arg_173_1.time_ <= var_176_23 + arg_176_0 and not isNil(var_176_22) and arg_173_1.var_.characterEffect1047ui_story == nil then
				arg_173_1.var_.characterEffect1047ui_story = var_176_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_24 = 0.200000002980232

			if var_176_23 <= arg_173_1.time_ and arg_173_1.time_ < var_176_23 + var_176_24 and not isNil(var_176_22) then
				local var_176_25 = (arg_173_1.time_ - var_176_23) / var_176_24

				if arg_173_1.var_.characterEffect1047ui_story and not isNil(var_176_22) then
					local var_176_26 = Mathf.Lerp(0, 0.5, var_176_25)

					arg_173_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1047ui_story.fillRatio = var_176_26
				end
			end

			if arg_173_1.time_ >= var_176_23 + var_176_24 and arg_173_1.time_ < var_176_23 + var_176_24 + arg_176_0 and not isNil(var_176_22) and arg_173_1.var_.characterEffect1047ui_story then
				local var_176_27 = 0.5

				arg_173_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1047ui_story.fillRatio = var_176_27
			end

			local var_176_28 = 0

			if var_176_28 < arg_173_1.time_ and arg_173_1.time_ <= var_176_28 + arg_176_0 then
				arg_173_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			local var_176_29 = 0

			if var_176_29 < arg_173_1.time_ and arg_173_1.time_ <= var_176_29 + arg_176_0 then
				arg_173_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_176_30 = 0
			local var_176_31 = 0.225

			if var_176_30 < arg_173_1.time_ and arg_173_1.time_ <= var_176_30 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_32 = arg_173_1:FormatText(StoryNameCfg[6].name)

				arg_173_1.leftNameTxt_.text = var_176_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_33 = arg_173_1:GetWordFromCfg(421041043)
				local var_176_34 = arg_173_1:FormatText(var_176_33.content)

				arg_173_1.text_.text = var_176_34

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_35 = 9
				local var_176_36 = utf8.len(var_176_34)
				local var_176_37 = var_176_35 <= 0 and var_176_31 or var_176_31 * (var_176_36 / var_176_35)

				if var_176_37 > 0 and var_176_31 < var_176_37 then
					arg_173_1.talkMaxDuration = var_176_37

					if var_176_37 + var_176_30 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_37 + var_176_30
					end
				end

				arg_173_1.text_.text = var_176_34
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041043", "story_v_out_421041.awb") ~= 0 then
					local var_176_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041043", "story_v_out_421041.awb") / 1000

					if var_176_38 + var_176_30 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_38 + var_176_30
					end

					if var_176_33.prefab_name ~= "" and arg_173_1.actors_[var_176_33.prefab_name] ~= nil then
						local var_176_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_33.prefab_name].transform, "story_v_out_421041", "421041043", "story_v_out_421041.awb")

						arg_173_1:RecordAudio("421041043", var_176_39)
						arg_173_1:RecordAudio("421041043", var_176_39)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_421041", "421041043", "story_v_out_421041.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_421041", "421041043", "story_v_out_421041.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_40 = math.max(var_176_31, arg_173_1.talkMaxDuration)

			if var_176_30 <= arg_173_1.time_ and arg_173_1.time_ < var_176_30 + var_176_40 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_30) / var_176_40

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_30 + var_176_40 and arg_173_1.time_ < var_176_30 + var_176_40 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play421041044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 421041044
		arg_177_1.duration_ = 16.27

		local var_177_0 = {
			zh = 9.533,
			ja = 16.266
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play421041045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1047ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1047ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1047ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1047ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1047ui_story == nil then
				arg_177_1.var_.characterEffect1047ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1047ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1047ui_story then
				arg_177_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_180_13 = arg_177_1.actors_["10102ui_story"]
			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 and not isNil(var_180_13) and arg_177_1.var_.characterEffect10102ui_story == nil then
				arg_177_1.var_.characterEffect10102ui_story = var_180_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_15 = 0.200000002980232

			if var_180_14 <= arg_177_1.time_ and arg_177_1.time_ < var_180_14 + var_180_15 and not isNil(var_180_13) then
				local var_180_16 = (arg_177_1.time_ - var_180_14) / var_180_15

				if arg_177_1.var_.characterEffect10102ui_story and not isNil(var_180_13) then
					local var_180_17 = Mathf.Lerp(0, 0.5, var_180_16)

					arg_177_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10102ui_story.fillRatio = var_180_17
				end
			end

			if arg_177_1.time_ >= var_180_14 + var_180_15 and arg_177_1.time_ < var_180_14 + var_180_15 + arg_180_0 and not isNil(var_180_13) and arg_177_1.var_.characterEffect10102ui_story then
				local var_180_18 = 0.5

				arg_177_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10102ui_story.fillRatio = var_180_18
			end

			local var_180_19 = 0

			if var_180_19 < arg_177_1.time_ and arg_177_1.time_ <= var_180_19 + arg_180_0 then
				arg_177_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_180_20 = 0

			if var_180_20 < arg_177_1.time_ and arg_177_1.time_ <= var_180_20 + arg_180_0 then
				arg_177_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_180_21 = 0
			local var_180_22 = 1.175

			if var_180_21 < arg_177_1.time_ and arg_177_1.time_ <= var_180_21 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_23 = arg_177_1:FormatText(StoryNameCfg[1296].name)

				arg_177_1.leftNameTxt_.text = var_180_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_24 = arg_177_1:GetWordFromCfg(421041044)
				local var_180_25 = arg_177_1:FormatText(var_180_24.content)

				arg_177_1.text_.text = var_180_25

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_26 = 48
				local var_180_27 = utf8.len(var_180_25)
				local var_180_28 = var_180_26 <= 0 and var_180_22 or var_180_22 * (var_180_27 / var_180_26)

				if var_180_28 > 0 and var_180_22 < var_180_28 then
					arg_177_1.talkMaxDuration = var_180_28

					if var_180_28 + var_180_21 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_28 + var_180_21
					end
				end

				arg_177_1.text_.text = var_180_25
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041044", "story_v_out_421041.awb") ~= 0 then
					local var_180_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041044", "story_v_out_421041.awb") / 1000

					if var_180_29 + var_180_21 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_29 + var_180_21
					end

					if var_180_24.prefab_name ~= "" and arg_177_1.actors_[var_180_24.prefab_name] ~= nil then
						local var_180_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_24.prefab_name].transform, "story_v_out_421041", "421041044", "story_v_out_421041.awb")

						arg_177_1:RecordAudio("421041044", var_180_30)
						arg_177_1:RecordAudio("421041044", var_180_30)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_421041", "421041044", "story_v_out_421041.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_421041", "421041044", "story_v_out_421041.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_31 = math.max(var_180_22, arg_177_1.talkMaxDuration)

			if var_180_21 <= arg_177_1.time_ and arg_177_1.time_ < var_180_21 + var_180_31 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_21) / var_180_31

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_21 + var_180_31 and arg_177_1.time_ < var_180_21 + var_180_31 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421041045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 421041045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play421041046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1047ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1047ui_story == nil then
				arg_181_1.var_.characterEffect1047ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1047ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1047ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1047ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1047ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.4

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(421041045)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 16
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play421041046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 421041046
		arg_185_1.duration_ = 11.3

		local var_185_0 = {
			zh = 10.7,
			ja = 11.3
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
				arg_185_0:Play421041047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1047ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1047ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(0, 100, 0)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1047ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, 100, 0)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["10102ui_story"].transform
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1.var_.moveOldPos10102ui_story = var_188_9.localPosition
			end

			local var_188_11 = 0.001

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11
				local var_188_13 = Vector3.New(0, 100, 0)

				var_188_9.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10102ui_story, var_188_13, var_188_12)

				local var_188_14 = manager.ui.mainCamera.transform.position - var_188_9.position

				var_188_9.forward = Vector3.New(var_188_14.x, var_188_14.y, var_188_14.z)

				local var_188_15 = var_188_9.localEulerAngles

				var_188_15.z = 0
				var_188_15.x = 0
				var_188_9.localEulerAngles = var_188_15
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 then
				var_188_9.localPosition = Vector3.New(0, 100, 0)

				local var_188_16 = manager.ui.mainCamera.transform.position - var_188_9.position

				var_188_9.forward = Vector3.New(var_188_16.x, var_188_16.y, var_188_16.z)

				local var_188_17 = var_188_9.localEulerAngles

				var_188_17.z = 0
				var_188_17.x = 0
				var_188_9.localEulerAngles = var_188_17
			end

			local var_188_18 = arg_185_1.actors_["10145ui_story"].transform
			local var_188_19 = 0

			if var_188_19 < arg_185_1.time_ and arg_185_1.time_ <= var_188_19 + arg_188_0 then
				arg_185_1.var_.moveOldPos10145ui_story = var_188_18.localPosition
			end

			local var_188_20 = 0.001

			if var_188_19 <= arg_185_1.time_ and arg_185_1.time_ < var_188_19 + var_188_20 then
				local var_188_21 = (arg_185_1.time_ - var_188_19) / var_188_20
				local var_188_22 = Vector3.New(0, -1, -6.2)

				var_188_18.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10145ui_story, var_188_22, var_188_21)

				local var_188_23 = manager.ui.mainCamera.transform.position - var_188_18.position

				var_188_18.forward = Vector3.New(var_188_23.x, var_188_23.y, var_188_23.z)

				local var_188_24 = var_188_18.localEulerAngles

				var_188_24.z = 0
				var_188_24.x = 0
				var_188_18.localEulerAngles = var_188_24
			end

			if arg_185_1.time_ >= var_188_19 + var_188_20 and arg_185_1.time_ < var_188_19 + var_188_20 + arg_188_0 then
				var_188_18.localPosition = Vector3.New(0, -1, -6.2)

				local var_188_25 = manager.ui.mainCamera.transform.position - var_188_18.position

				var_188_18.forward = Vector3.New(var_188_25.x, var_188_25.y, var_188_25.z)

				local var_188_26 = var_188_18.localEulerAngles

				var_188_26.z = 0
				var_188_26.x = 0
				var_188_18.localEulerAngles = var_188_26
			end

			local var_188_27 = arg_185_1.actors_["10145ui_story"]
			local var_188_28 = 0

			if var_188_28 < arg_185_1.time_ and arg_185_1.time_ <= var_188_28 + arg_188_0 and not isNil(var_188_27) and arg_185_1.var_.characterEffect10145ui_story == nil then
				arg_185_1.var_.characterEffect10145ui_story = var_188_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_29 = 0.200000002980232

			if var_188_28 <= arg_185_1.time_ and arg_185_1.time_ < var_188_28 + var_188_29 and not isNil(var_188_27) then
				local var_188_30 = (arg_185_1.time_ - var_188_28) / var_188_29

				if arg_185_1.var_.characterEffect10145ui_story and not isNil(var_188_27) then
					arg_185_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_28 + var_188_29 and arg_185_1.time_ < var_188_28 + var_188_29 + arg_188_0 and not isNil(var_188_27) and arg_185_1.var_.characterEffect10145ui_story then
				arg_185_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_188_31 = 0

			if var_188_31 < arg_185_1.time_ and arg_185_1.time_ <= var_188_31 + arg_188_0 then
				arg_185_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_188_32 = 0

			if var_188_32 < arg_185_1.time_ and arg_185_1.time_ <= var_188_32 + arg_188_0 then
				arg_185_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_188_33 = 0
			local var_188_34 = 1.3

			if var_188_33 < arg_185_1.time_ and arg_185_1.time_ <= var_188_33 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_35 = arg_185_1:FormatText(StoryNameCfg[1308].name)

				arg_185_1.leftNameTxt_.text = var_188_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_36 = arg_185_1:GetWordFromCfg(421041046)
				local var_188_37 = arg_185_1:FormatText(var_188_36.content)

				arg_185_1.text_.text = var_188_37

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_38 = 52
				local var_188_39 = utf8.len(var_188_37)
				local var_188_40 = var_188_38 <= 0 and var_188_34 or var_188_34 * (var_188_39 / var_188_38)

				if var_188_40 > 0 and var_188_34 < var_188_40 then
					arg_185_1.talkMaxDuration = var_188_40

					if var_188_40 + var_188_33 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_40 + var_188_33
					end
				end

				arg_185_1.text_.text = var_188_37
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041046", "story_v_out_421041.awb") ~= 0 then
					local var_188_41 = manager.audio:GetVoiceLength("story_v_out_421041", "421041046", "story_v_out_421041.awb") / 1000

					if var_188_41 + var_188_33 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_41 + var_188_33
					end

					if var_188_36.prefab_name ~= "" and arg_185_1.actors_[var_188_36.prefab_name] ~= nil then
						local var_188_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_36.prefab_name].transform, "story_v_out_421041", "421041046", "story_v_out_421041.awb")

						arg_185_1:RecordAudio("421041046", var_188_42)
						arg_185_1:RecordAudio("421041046", var_188_42)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_421041", "421041046", "story_v_out_421041.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_421041", "421041046", "story_v_out_421041.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_43 = math.max(var_188_34, arg_185_1.talkMaxDuration)

			if var_188_33 <= arg_185_1.time_ and arg_185_1.time_ < var_188_33 + var_188_43 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_33) / var_188_43

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_33 + var_188_43 and arg_185_1.time_ < var_188_33 + var_188_43 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play421041047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 421041047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play421041048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10145ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10145ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0, 100, 0)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10145ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, 100, 0)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = 0
			local var_192_10 = 0.95

			if var_192_9 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_11 = arg_189_1:GetWordFromCfg(421041047)
				local var_192_12 = arg_189_1:FormatText(var_192_11.content)

				arg_189_1.text_.text = var_192_12

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 38
				local var_192_14 = utf8.len(var_192_12)
				local var_192_15 = var_192_13 <= 0 and var_192_10 or var_192_10 * (var_192_14 / var_192_13)

				if var_192_15 > 0 and var_192_10 < var_192_15 then
					arg_189_1.talkMaxDuration = var_192_15

					if var_192_15 + var_192_9 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_9
					end
				end

				arg_189_1.text_.text = var_192_12
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_10, arg_189_1.talkMaxDuration)

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_9) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_9 + var_192_16 and arg_189_1.time_ < var_192_9 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 421041048
		arg_193_1.duration_ = 1

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"

			SetActive(arg_193_1.choicesGo_, true)

			for iter_194_0, iter_194_1 in ipairs(arg_193_1.choices_) do
				local var_194_0 = iter_194_0 <= 2

				SetActive(iter_194_1.go, var_194_0)
			end

			arg_193_1.choices_[1].txt.text = arg_193_1:FormatText(StoryChoiceCfg[1350].name)
			arg_193_1.choices_[2].txt.text = arg_193_1:FormatText(StoryChoiceCfg[1351].name)
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play421041049(arg_193_1)
			end

			if arg_195_0 == 2 then
				arg_193_0:Play421041049(arg_193_1)
			end

			arg_193_1:RecordChoiceLog(421041048, 1350, 1351)
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			return
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play421041049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 421041049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play421041050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 1.1

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(421041049)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 44
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
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play421041050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 421041050
		arg_201_1.duration_ = 6.53

		local var_201_0 = {
			zh = 6.533,
			ja = 4.933
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
				arg_201_0:Play421041051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10145ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10145ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(0, -1, -6.2)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10145ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = arg_201_1.actors_["10145ui_story"]
			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect10145ui_story == nil then
				arg_201_1.var_.characterEffect10145ui_story = var_204_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_11 = 0.200000002980232

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 and not isNil(var_204_9) then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11

				if arg_201_1.var_.characterEffect10145ui_story and not isNil(var_204_9) then
					arg_201_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect10145ui_story then
				arg_201_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_204_13 = 0

			if var_204_13 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 then
				arg_201_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			local var_204_14 = 0

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				arg_201_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_204_15 = 0
			local var_204_16 = 0.3

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_17 = arg_201_1:FormatText(StoryNameCfg[1308].name)

				arg_201_1.leftNameTxt_.text = var_204_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_18 = arg_201_1:GetWordFromCfg(421041050)
				local var_204_19 = arg_201_1:FormatText(var_204_18.content)

				arg_201_1.text_.text = var_204_19

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_20 = 12
				local var_204_21 = utf8.len(var_204_19)
				local var_204_22 = var_204_20 <= 0 and var_204_16 or var_204_16 * (var_204_21 / var_204_20)

				if var_204_22 > 0 and var_204_16 < var_204_22 then
					arg_201_1.talkMaxDuration = var_204_22

					if var_204_22 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_22 + var_204_15
					end
				end

				arg_201_1.text_.text = var_204_19
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041050", "story_v_out_421041.awb") ~= 0 then
					local var_204_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041050", "story_v_out_421041.awb") / 1000

					if var_204_23 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_23 + var_204_15
					end

					if var_204_18.prefab_name ~= "" and arg_201_1.actors_[var_204_18.prefab_name] ~= nil then
						local var_204_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_18.prefab_name].transform, "story_v_out_421041", "421041050", "story_v_out_421041.awb")

						arg_201_1:RecordAudio("421041050", var_204_24)
						arg_201_1:RecordAudio("421041050", var_204_24)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_421041", "421041050", "story_v_out_421041.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_421041", "421041050", "story_v_out_421041.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_25 = math.max(var_204_16, arg_201_1.talkMaxDuration)

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_25 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_15) / var_204_25

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_15 + var_204_25 and arg_201_1.time_ < var_204_15 + var_204_25 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 421041051
		arg_205_1.duration_ = 2.43

		local var_205_0 = {
			zh = 1.999999999999,
			ja = 2.433
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
				arg_205_0:Play421041052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1047ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1047ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(0.74, -1.13, -6.2)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1047ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = arg_205_1.actors_["10145ui_story"].transform
			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 then
				arg_205_1.var_.moveOldPos10145ui_story = var_208_9.localPosition
			end

			local var_208_11 = 0.001

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_11 then
				local var_208_12 = (arg_205_1.time_ - var_208_10) / var_208_11
				local var_208_13 = Vector3.New(-0.65, -1, -6.2)

				var_208_9.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10145ui_story, var_208_13, var_208_12)

				local var_208_14 = manager.ui.mainCamera.transform.position - var_208_9.position

				var_208_9.forward = Vector3.New(var_208_14.x, var_208_14.y, var_208_14.z)

				local var_208_15 = var_208_9.localEulerAngles

				var_208_15.z = 0
				var_208_15.x = 0
				var_208_9.localEulerAngles = var_208_15
			end

			if arg_205_1.time_ >= var_208_10 + var_208_11 and arg_205_1.time_ < var_208_10 + var_208_11 + arg_208_0 then
				var_208_9.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_208_16 = manager.ui.mainCamera.transform.position - var_208_9.position

				var_208_9.forward = Vector3.New(var_208_16.x, var_208_16.y, var_208_16.z)

				local var_208_17 = var_208_9.localEulerAngles

				var_208_17.z = 0
				var_208_17.x = 0
				var_208_9.localEulerAngles = var_208_17
			end

			local var_208_18 = arg_205_1.actors_["1047ui_story"]
			local var_208_19 = 0

			if var_208_19 < arg_205_1.time_ and arg_205_1.time_ <= var_208_19 + arg_208_0 and not isNil(var_208_18) and arg_205_1.var_.characterEffect1047ui_story == nil then
				arg_205_1.var_.characterEffect1047ui_story = var_208_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_20 = 0.200000002980232

			if var_208_19 <= arg_205_1.time_ and arg_205_1.time_ < var_208_19 + var_208_20 and not isNil(var_208_18) then
				local var_208_21 = (arg_205_1.time_ - var_208_19) / var_208_20

				if arg_205_1.var_.characterEffect1047ui_story and not isNil(var_208_18) then
					arg_205_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_19 + var_208_20 and arg_205_1.time_ < var_208_19 + var_208_20 + arg_208_0 and not isNil(var_208_18) and arg_205_1.var_.characterEffect1047ui_story then
				arg_205_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_208_22 = arg_205_1.actors_["10145ui_story"]
			local var_208_23 = 0

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 and not isNil(var_208_22) and arg_205_1.var_.characterEffect10145ui_story == nil then
				arg_205_1.var_.characterEffect10145ui_story = var_208_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_24 = 0.200000002980232

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_24 and not isNil(var_208_22) then
				local var_208_25 = (arg_205_1.time_ - var_208_23) / var_208_24

				if arg_205_1.var_.characterEffect10145ui_story and not isNil(var_208_22) then
					local var_208_26 = Mathf.Lerp(0, 0.5, var_208_25)

					arg_205_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10145ui_story.fillRatio = var_208_26
				end
			end

			if arg_205_1.time_ >= var_208_23 + var_208_24 and arg_205_1.time_ < var_208_23 + var_208_24 + arg_208_0 and not isNil(var_208_22) and arg_205_1.var_.characterEffect10145ui_story then
				local var_208_27 = 0.5

				arg_205_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10145ui_story.fillRatio = var_208_27
			end

			local var_208_28 = 0

			if var_208_28 < arg_205_1.time_ and arg_205_1.time_ <= var_208_28 + arg_208_0 then
				arg_205_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_208_29 = 0

			if var_208_29 < arg_205_1.time_ and arg_205_1.time_ <= var_208_29 + arg_208_0 then
				arg_205_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_208_30 = 0
			local var_208_31 = 0.125

			if var_208_30 < arg_205_1.time_ and arg_205_1.time_ <= var_208_30 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_32 = arg_205_1:FormatText(StoryNameCfg[1296].name)

				arg_205_1.leftNameTxt_.text = var_208_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_33 = arg_205_1:GetWordFromCfg(421041051)
				local var_208_34 = arg_205_1:FormatText(var_208_33.content)

				arg_205_1.text_.text = var_208_34

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_35 = 5
				local var_208_36 = utf8.len(var_208_34)
				local var_208_37 = var_208_35 <= 0 and var_208_31 or var_208_31 * (var_208_36 / var_208_35)

				if var_208_37 > 0 and var_208_31 < var_208_37 then
					arg_205_1.talkMaxDuration = var_208_37

					if var_208_37 + var_208_30 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_37 + var_208_30
					end
				end

				arg_205_1.text_.text = var_208_34
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041051", "story_v_out_421041.awb") ~= 0 then
					local var_208_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041051", "story_v_out_421041.awb") / 1000

					if var_208_38 + var_208_30 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_38 + var_208_30
					end

					if var_208_33.prefab_name ~= "" and arg_205_1.actors_[var_208_33.prefab_name] ~= nil then
						local var_208_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_33.prefab_name].transform, "story_v_out_421041", "421041051", "story_v_out_421041.awb")

						arg_205_1:RecordAudio("421041051", var_208_39)
						arg_205_1:RecordAudio("421041051", var_208_39)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_421041", "421041051", "story_v_out_421041.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_421041", "421041051", "story_v_out_421041.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_40 = math.max(var_208_31, arg_205_1.talkMaxDuration)

			if var_208_30 <= arg_205_1.time_ and arg_205_1.time_ < var_208_30 + var_208_40 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_30) / var_208_40

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_30 + var_208_40 and arg_205_1.time_ < var_208_30 + var_208_40 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play421041052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 421041052
		arg_209_1.duration_ = 8.57

		local var_209_0 = {
			zh = 6.566,
			ja = 8.566
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
				arg_209_0:Play421041053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1047ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1047ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0.74, -1.13, -6.2)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1047ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0.74, -1.13, -6.2)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = 0

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_212_10 = 0
			local var_212_11 = 0.75

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_12 = arg_209_1:FormatText(StoryNameCfg[1296].name)

				arg_209_1.leftNameTxt_.text = var_212_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_13 = arg_209_1:GetWordFromCfg(421041052)
				local var_212_14 = arg_209_1:FormatText(var_212_13.content)

				arg_209_1.text_.text = var_212_14

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_15 = 30
				local var_212_16 = utf8.len(var_212_14)
				local var_212_17 = var_212_15 <= 0 and var_212_11 or var_212_11 * (var_212_16 / var_212_15)

				if var_212_17 > 0 and var_212_11 < var_212_17 then
					arg_209_1.talkMaxDuration = var_212_17

					if var_212_17 + var_212_10 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_17 + var_212_10
					end
				end

				arg_209_1.text_.text = var_212_14
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041052", "story_v_out_421041.awb") ~= 0 then
					local var_212_18 = manager.audio:GetVoiceLength("story_v_out_421041", "421041052", "story_v_out_421041.awb") / 1000

					if var_212_18 + var_212_10 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_18 + var_212_10
					end

					if var_212_13.prefab_name ~= "" and arg_209_1.actors_[var_212_13.prefab_name] ~= nil then
						local var_212_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_13.prefab_name].transform, "story_v_out_421041", "421041052", "story_v_out_421041.awb")

						arg_209_1:RecordAudio("421041052", var_212_19)
						arg_209_1:RecordAudio("421041052", var_212_19)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_421041", "421041052", "story_v_out_421041.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_421041", "421041052", "story_v_out_421041.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_20 = math.max(var_212_11, arg_209_1.talkMaxDuration)

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_20 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_10) / var_212_20

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_10 + var_212_20 and arg_209_1.time_ < var_212_10 + var_212_20 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play421041053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 421041053
		arg_213_1.duration_ = 5

		local var_213_0 = {
			zh = 3.8,
			ja = 5
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
				arg_213_0:Play421041054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10145ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos10145ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(0, -1, -6.2)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10145ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["1047ui_story"].transform
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1.var_.moveOldPos1047ui_story = var_216_9.localPosition
			end

			local var_216_11 = 0.001

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11
				local var_216_13 = Vector3.New(0, 100, 0)

				var_216_9.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1047ui_story, var_216_13, var_216_12)

				local var_216_14 = manager.ui.mainCamera.transform.position - var_216_9.position

				var_216_9.forward = Vector3.New(var_216_14.x, var_216_14.y, var_216_14.z)

				local var_216_15 = var_216_9.localEulerAngles

				var_216_15.z = 0
				var_216_15.x = 0
				var_216_9.localEulerAngles = var_216_15
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 then
				var_216_9.localPosition = Vector3.New(0, 100, 0)

				local var_216_16 = manager.ui.mainCamera.transform.position - var_216_9.position

				var_216_9.forward = Vector3.New(var_216_16.x, var_216_16.y, var_216_16.z)

				local var_216_17 = var_216_9.localEulerAngles

				var_216_17.z = 0
				var_216_17.x = 0
				var_216_9.localEulerAngles = var_216_17
			end

			local var_216_18 = arg_213_1.actors_["10145ui_story"]
			local var_216_19 = 0

			if var_216_19 < arg_213_1.time_ and arg_213_1.time_ <= var_216_19 + arg_216_0 and not isNil(var_216_18) and arg_213_1.var_.characterEffect10145ui_story == nil then
				arg_213_1.var_.characterEffect10145ui_story = var_216_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_20 = 0.200000002980232

			if var_216_19 <= arg_213_1.time_ and arg_213_1.time_ < var_216_19 + var_216_20 and not isNil(var_216_18) then
				local var_216_21 = (arg_213_1.time_ - var_216_19) / var_216_20

				if arg_213_1.var_.characterEffect10145ui_story and not isNil(var_216_18) then
					arg_213_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_19 + var_216_20 and arg_213_1.time_ < var_216_19 + var_216_20 + arg_216_0 and not isNil(var_216_18) and arg_213_1.var_.characterEffect10145ui_story then
				arg_213_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_216_22 = arg_213_1.actors_["1047ui_story"]
			local var_216_23 = 0

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 and not isNil(var_216_22) and arg_213_1.var_.characterEffect1047ui_story == nil then
				arg_213_1.var_.characterEffect1047ui_story = var_216_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_24 = 0.200000002980232

			if var_216_23 <= arg_213_1.time_ and arg_213_1.time_ < var_216_23 + var_216_24 and not isNil(var_216_22) then
				local var_216_25 = (arg_213_1.time_ - var_216_23) / var_216_24

				if arg_213_1.var_.characterEffect1047ui_story and not isNil(var_216_22) then
					local var_216_26 = Mathf.Lerp(0, 0.5, var_216_25)

					arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1047ui_story.fillRatio = var_216_26
				end
			end

			if arg_213_1.time_ >= var_216_23 + var_216_24 and arg_213_1.time_ < var_216_23 + var_216_24 + arg_216_0 and not isNil(var_216_22) and arg_213_1.var_.characterEffect1047ui_story then
				local var_216_27 = 0.5

				arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1047ui_story.fillRatio = var_216_27
			end

			local var_216_28 = 0

			if var_216_28 < arg_213_1.time_ and arg_213_1.time_ <= var_216_28 + arg_216_0 then
				arg_213_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			local var_216_29 = 0

			if var_216_29 < arg_213_1.time_ and arg_213_1.time_ <= var_216_29 + arg_216_0 then
				arg_213_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_216_30 = 0
			local var_216_31 = 0.525

			if var_216_30 < arg_213_1.time_ and arg_213_1.time_ <= var_216_30 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_32 = arg_213_1:FormatText(StoryNameCfg[1308].name)

				arg_213_1.leftNameTxt_.text = var_216_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_33 = arg_213_1:GetWordFromCfg(421041053)
				local var_216_34 = arg_213_1:FormatText(var_216_33.content)

				arg_213_1.text_.text = var_216_34

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_35 = 21
				local var_216_36 = utf8.len(var_216_34)
				local var_216_37 = var_216_35 <= 0 and var_216_31 or var_216_31 * (var_216_36 / var_216_35)

				if var_216_37 > 0 and var_216_31 < var_216_37 then
					arg_213_1.talkMaxDuration = var_216_37

					if var_216_37 + var_216_30 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_37 + var_216_30
					end
				end

				arg_213_1.text_.text = var_216_34
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041053", "story_v_out_421041.awb") ~= 0 then
					local var_216_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041053", "story_v_out_421041.awb") / 1000

					if var_216_38 + var_216_30 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_38 + var_216_30
					end

					if var_216_33.prefab_name ~= "" and arg_213_1.actors_[var_216_33.prefab_name] ~= nil then
						local var_216_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_33.prefab_name].transform, "story_v_out_421041", "421041053", "story_v_out_421041.awb")

						arg_213_1:RecordAudio("421041053", var_216_39)
						arg_213_1:RecordAudio("421041053", var_216_39)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_421041", "421041053", "story_v_out_421041.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_421041", "421041053", "story_v_out_421041.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_40 = math.max(var_216_31, arg_213_1.talkMaxDuration)

			if var_216_30 <= arg_213_1.time_ and arg_213_1.time_ < var_216_30 + var_216_40 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_30) / var_216_40

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_30 + var_216_40 and arg_213_1.time_ < var_216_30 + var_216_40 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421041054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 421041054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play421041055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10145ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10145ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0, 100, 0)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10145ui_story, var_220_4, var_220_3)

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

			local var_220_9 = 0.1
			local var_220_10 = 1

			if var_220_9 < arg_217_1.time_ and arg_217_1.time_ <= var_220_9 + arg_220_0 then
				local var_220_11 = "play"
				local var_220_12 = "effect"

				arg_217_1:AudioAction(var_220_11, var_220_12, "se_story_143", "se_story_143_cardoor", "")
			end

			local var_220_13 = 0
			local var_220_14 = 0.425

			if var_220_13 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_15 = arg_217_1:GetWordFromCfg(421041054)
				local var_220_16 = arg_217_1:FormatText(var_220_15.content)

				arg_217_1.text_.text = var_220_16

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_17 = 17
				local var_220_18 = utf8.len(var_220_16)
				local var_220_19 = var_220_17 <= 0 and var_220_14 or var_220_14 * (var_220_18 / var_220_17)

				if var_220_19 > 0 and var_220_14 < var_220_19 then
					arg_217_1.talkMaxDuration = var_220_19

					if var_220_19 + var_220_13 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_19 + var_220_13
					end
				end

				arg_217_1.text_.text = var_220_16
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_20 = math.max(var_220_14, arg_217_1.talkMaxDuration)

			if var_220_13 <= arg_217_1.time_ and arg_217_1.time_ < var_220_13 + var_220_20 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_13) / var_220_20

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_13 + var_220_20 and arg_217_1.time_ < var_220_13 + var_220_20 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421041055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 421041055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play421041056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.45

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(421041055)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 18
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_8 and arg_221_1.time_ < var_224_0 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play421041056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 421041056
		arg_225_1.duration_ = 10.53

		local var_225_0 = {
			zh = 6.2,
			ja = 10.533
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
				arg_225_0:Play421041057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1047ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1047ui_story = var_228_0.localPosition
			end

			local var_228_2 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2
				local var_228_4 = Vector3.New(0, -1.13, -6.2)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1047ui_story, var_228_4, var_228_3)

				local var_228_5 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_5.x, var_228_5.y, var_228_5.z)

				local var_228_6 = var_228_0.localEulerAngles

				var_228_6.z = 0
				var_228_6.x = 0
				var_228_0.localEulerAngles = var_228_6
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_228_7 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_7.x, var_228_7.y, var_228_7.z)

				local var_228_8 = var_228_0.localEulerAngles

				var_228_8.z = 0
				var_228_8.x = 0
				var_228_0.localEulerAngles = var_228_8
			end

			local var_228_9 = arg_225_1.actors_["1047ui_story"]
			local var_228_10 = 0

			if var_228_10 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1047ui_story == nil then
				arg_225_1.var_.characterEffect1047ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_11 = 0.200000002980232

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_11 and not isNil(var_228_9) then
				local var_228_12 = (arg_225_1.time_ - var_228_10) / var_228_11

				if arg_225_1.var_.characterEffect1047ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_10 + var_228_11 and arg_225_1.time_ < var_228_10 + var_228_11 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1047ui_story then
				arg_225_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_228_13 = 0

			if var_228_13 < arg_225_1.time_ and arg_225_1.time_ <= var_228_13 + arg_228_0 then
				arg_225_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_228_14 = 0

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_228_15 = 0
			local var_228_16 = 0.675

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_17 = arg_225_1:FormatText(StoryNameCfg[1296].name)

				arg_225_1.leftNameTxt_.text = var_228_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_18 = arg_225_1:GetWordFromCfg(421041056)
				local var_228_19 = arg_225_1:FormatText(var_228_18.content)

				arg_225_1.text_.text = var_228_19

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_20 = 27
				local var_228_21 = utf8.len(var_228_19)
				local var_228_22 = var_228_20 <= 0 and var_228_16 or var_228_16 * (var_228_21 / var_228_20)

				if var_228_22 > 0 and var_228_16 < var_228_22 then
					arg_225_1.talkMaxDuration = var_228_22

					if var_228_22 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_22 + var_228_15
					end
				end

				arg_225_1.text_.text = var_228_19
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041056", "story_v_out_421041.awb") ~= 0 then
					local var_228_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041056", "story_v_out_421041.awb") / 1000

					if var_228_23 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_15
					end

					if var_228_18.prefab_name ~= "" and arg_225_1.actors_[var_228_18.prefab_name] ~= nil then
						local var_228_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_18.prefab_name].transform, "story_v_out_421041", "421041056", "story_v_out_421041.awb")

						arg_225_1:RecordAudio("421041056", var_228_24)
						arg_225_1:RecordAudio("421041056", var_228_24)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_421041", "421041056", "story_v_out_421041.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_421041", "421041056", "story_v_out_421041.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_25 = math.max(var_228_16, arg_225_1.talkMaxDuration)

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_25 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_15) / var_228_25

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_15 + var_228_25 and arg_225_1.time_ < var_228_15 + var_228_25 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421041057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 421041057
		arg_229_1.duration_ = 9

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play421041058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = "ST2401"

			if arg_229_1.bgs_[var_232_0] == nil then
				local var_232_1 = Object.Instantiate(arg_229_1.paintGo_)

				var_232_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_232_0)
				var_232_1.name = var_232_0
				var_232_1.transform.parent = arg_229_1.stage_.transform
				var_232_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.bgs_[var_232_0] = var_232_1
			end

			local var_232_2 = 2

			if var_232_2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				local var_232_3 = manager.ui.mainCamera.transform.localPosition
				local var_232_4 = Vector3.New(0, 0, 10) + Vector3.New(var_232_3.x, var_232_3.y, 0)
				local var_232_5 = arg_229_1.bgs_.ST2401

				var_232_5.transform.localPosition = var_232_4
				var_232_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_6 = var_232_5:GetComponent("SpriteRenderer")

				if var_232_6 and var_232_6.sprite then
					local var_232_7 = (var_232_5.transform.localPosition - var_232_3).z
					local var_232_8 = manager.ui.mainCameraCom_
					local var_232_9 = 2 * var_232_7 * Mathf.Tan(var_232_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_232_10 = var_232_9 * var_232_8.aspect
					local var_232_11 = var_232_6.sprite.bounds.size.x
					local var_232_12 = var_232_6.sprite.bounds.size.y
					local var_232_13 = var_232_10 / var_232_11
					local var_232_14 = var_232_9 / var_232_12
					local var_232_15 = var_232_14 < var_232_13 and var_232_13 or var_232_14

					var_232_5.transform.localScale = Vector3.New(var_232_15, var_232_15, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "ST2401" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_16 = 4

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			local var_232_17 = 0.3

			if arg_229_1.time_ >= var_232_16 + var_232_17 and arg_229_1.time_ < var_232_16 + var_232_17 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			local var_232_18 = 0

			if var_232_18 < arg_229_1.time_ and arg_229_1.time_ <= var_232_18 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_19 = 2

			if var_232_18 <= arg_229_1.time_ and arg_229_1.time_ < var_232_18 + var_232_19 then
				local var_232_20 = (arg_229_1.time_ - var_232_18) / var_232_19
				local var_232_21 = Color.New(0, 0, 0)

				var_232_21.a = Mathf.Lerp(0, 1, var_232_20)
				arg_229_1.mask_.color = var_232_21
			end

			if arg_229_1.time_ >= var_232_18 + var_232_19 and arg_229_1.time_ < var_232_18 + var_232_19 + arg_232_0 then
				local var_232_22 = Color.New(0, 0, 0)

				var_232_22.a = 1
				arg_229_1.mask_.color = var_232_22
			end

			local var_232_23 = 2

			if var_232_23 < arg_229_1.time_ and arg_229_1.time_ <= var_232_23 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_24 = 2

			if var_232_23 <= arg_229_1.time_ and arg_229_1.time_ < var_232_23 + var_232_24 then
				local var_232_25 = (arg_229_1.time_ - var_232_23) / var_232_24
				local var_232_26 = Color.New(0, 0, 0)

				var_232_26.a = Mathf.Lerp(1, 0, var_232_25)
				arg_229_1.mask_.color = var_232_26
			end

			if arg_229_1.time_ >= var_232_23 + var_232_24 and arg_229_1.time_ < var_232_23 + var_232_24 + arg_232_0 then
				local var_232_27 = Color.New(0, 0, 0)
				local var_232_28 = 0

				arg_229_1.mask_.enabled = false
				var_232_27.a = var_232_28
				arg_229_1.mask_.color = var_232_27
			end

			local var_232_29 = arg_229_1.actors_["1047ui_story"].transform
			local var_232_30 = 2

			if var_232_30 < arg_229_1.time_ and arg_229_1.time_ <= var_232_30 + arg_232_0 then
				arg_229_1.var_.moveOldPos1047ui_story = var_232_29.localPosition
			end

			local var_232_31 = 0.001

			if var_232_30 <= arg_229_1.time_ and arg_229_1.time_ < var_232_30 + var_232_31 then
				local var_232_32 = (arg_229_1.time_ - var_232_30) / var_232_31
				local var_232_33 = Vector3.New(0, 100, 0)

				var_232_29.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1047ui_story, var_232_33, var_232_32)

				local var_232_34 = manager.ui.mainCamera.transform.position - var_232_29.position

				var_232_29.forward = Vector3.New(var_232_34.x, var_232_34.y, var_232_34.z)

				local var_232_35 = var_232_29.localEulerAngles

				var_232_35.z = 0
				var_232_35.x = 0
				var_232_29.localEulerAngles = var_232_35
			end

			if arg_229_1.time_ >= var_232_30 + var_232_31 and arg_229_1.time_ < var_232_30 + var_232_31 + arg_232_0 then
				var_232_29.localPosition = Vector3.New(0, 100, 0)

				local var_232_36 = manager.ui.mainCamera.transform.position - var_232_29.position

				var_232_29.forward = Vector3.New(var_232_36.x, var_232_36.y, var_232_36.z)

				local var_232_37 = var_232_29.localEulerAngles

				var_232_37.z = 0
				var_232_37.x = 0
				var_232_29.localEulerAngles = var_232_37
			end

			local var_232_38 = 0.2
			local var_232_39 = 1

			if var_232_38 < arg_229_1.time_ and arg_229_1.time_ <= var_232_38 + arg_232_0 then
				local var_232_40 = "stop"
				local var_232_41 = "effect"

				arg_229_1:AudioAction(var_232_40, var_232_41, "se_story_140", "se_story_140_amb_dream01", "")
			end

			local var_232_42 = 1.56666666666667
			local var_232_43 = 1

			if var_232_42 < arg_229_1.time_ and arg_229_1.time_ <= var_232_42 + arg_232_0 then
				local var_232_44 = "play"
				local var_232_45 = "effect"

				arg_229_1:AudioAction(var_232_44, var_232_45, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_46 = 4
			local var_232_47 = 0.35

			if var_232_46 < arg_229_1.time_ and arg_229_1.time_ <= var_232_46 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_48 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_48:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_49 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_50 = arg_229_1:GetWordFromCfg(421041057)
				local var_232_51 = arg_229_1:FormatText(var_232_50.content)

				arg_229_1.text_.text = var_232_51

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_52 = 14
				local var_232_53 = utf8.len(var_232_51)
				local var_232_54 = var_232_52 <= 0 and var_232_47 or var_232_47 * (var_232_53 / var_232_52)

				if var_232_54 > 0 and var_232_47 < var_232_54 then
					arg_229_1.talkMaxDuration = var_232_54
					var_232_46 = var_232_46 + 0.3

					if var_232_54 + var_232_46 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_54 + var_232_46
					end
				end

				arg_229_1.text_.text = var_232_51
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_55 = var_232_46 + 0.3
			local var_232_56 = math.max(var_232_47, arg_229_1.talkMaxDuration)

			if var_232_55 <= arg_229_1.time_ and arg_229_1.time_ < var_232_55 + var_232_56 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_55) / var_232_56

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_55 + var_232_56 and arg_229_1.time_ < var_232_55 + var_232_56 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play421041058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 421041058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play421041059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 1.15

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(421041058)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 46
				local var_238_5 = utf8.len(var_238_3)
				local var_238_6 = var_238_4 <= 0 and var_238_1 or var_238_1 * (var_238_5 / var_238_4)

				if var_238_6 > 0 and var_238_1 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_7 and arg_235_1.time_ < var_238_0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play421041059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 421041059
		arg_239_1.duration_ = 9.53

		local var_239_0 = {
			zh = 6.2,
			ja = 9.533
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play421041060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1047ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1047ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, -1.13, -6.2)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1047ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1047ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1047ui_story == nil then
				arg_239_1.var_.characterEffect1047ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect1047ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1047ui_story then
				arg_239_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_242_15 = 0
			local var_242_16 = 0.8

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_17 = arg_239_1:FormatText(StoryNameCfg[1296].name)

				arg_239_1.leftNameTxt_.text = var_242_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_18 = arg_239_1:GetWordFromCfg(421041059)
				local var_242_19 = arg_239_1:FormatText(var_242_18.content)

				arg_239_1.text_.text = var_242_19

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_20 = 32
				local var_242_21 = utf8.len(var_242_19)
				local var_242_22 = var_242_20 <= 0 and var_242_16 or var_242_16 * (var_242_21 / var_242_20)

				if var_242_22 > 0 and var_242_16 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22

					if var_242_22 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_19
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041059", "story_v_out_421041.awb") ~= 0 then
					local var_242_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041059", "story_v_out_421041.awb") / 1000

					if var_242_23 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_15
					end

					if var_242_18.prefab_name ~= "" and arg_239_1.actors_[var_242_18.prefab_name] ~= nil then
						local var_242_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_18.prefab_name].transform, "story_v_out_421041", "421041059", "story_v_out_421041.awb")

						arg_239_1:RecordAudio("421041059", var_242_24)
						arg_239_1:RecordAudio("421041059", var_242_24)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_421041", "421041059", "story_v_out_421041.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_421041", "421041059", "story_v_out_421041.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_25 and arg_239_1.time_ < var_242_15 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play421041060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 421041060
		arg_243_1.duration_ = 3.17

		local var_243_0 = {
			zh = 2.5,
			ja = 3.166
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
				arg_243_0:Play421041061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1047ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1047ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(0, 100, 0)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1047ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0, 100, 0)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["10143ui_story"].transform
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 then
				arg_243_1.var_.moveOldPos10143ui_story = var_246_9.localPosition
			end

			local var_246_11 = 0.001

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11
				local var_246_13 = Vector3.New(-0.72, -1.06, -6)

				var_246_9.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10143ui_story, var_246_13, var_246_12)

				local var_246_14 = manager.ui.mainCamera.transform.position - var_246_9.position

				var_246_9.forward = Vector3.New(var_246_14.x, var_246_14.y, var_246_14.z)

				local var_246_15 = var_246_9.localEulerAngles

				var_246_15.z = 0
				var_246_15.x = 0
				var_246_9.localEulerAngles = var_246_15
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 then
				var_246_9.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_246_16 = manager.ui.mainCamera.transform.position - var_246_9.position

				var_246_9.forward = Vector3.New(var_246_16.x, var_246_16.y, var_246_16.z)

				local var_246_17 = var_246_9.localEulerAngles

				var_246_17.z = 0
				var_246_17.x = 0
				var_246_9.localEulerAngles = var_246_17
			end

			local var_246_18 = arg_243_1.actors_["10143ui_story"]
			local var_246_19 = 0

			if var_246_19 < arg_243_1.time_ and arg_243_1.time_ <= var_246_19 + arg_246_0 and not isNil(var_246_18) and arg_243_1.var_.characterEffect10143ui_story == nil then
				arg_243_1.var_.characterEffect10143ui_story = var_246_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_20 = 0.200000002980232

			if var_246_19 <= arg_243_1.time_ and arg_243_1.time_ < var_246_19 + var_246_20 and not isNil(var_246_18) then
				local var_246_21 = (arg_243_1.time_ - var_246_19) / var_246_20

				if arg_243_1.var_.characterEffect10143ui_story and not isNil(var_246_18) then
					arg_243_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_19 + var_246_20 and arg_243_1.time_ < var_246_19 + var_246_20 + arg_246_0 and not isNil(var_246_18) and arg_243_1.var_.characterEffect10143ui_story then
				arg_243_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_246_22 = arg_243_1.actors_["1047ui_story"]
			local var_246_23 = 0

			if var_246_23 < arg_243_1.time_ and arg_243_1.time_ <= var_246_23 + arg_246_0 and not isNil(var_246_22) and arg_243_1.var_.characterEffect1047ui_story == nil then
				arg_243_1.var_.characterEffect1047ui_story = var_246_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_24 = 0.200000002980232

			if var_246_23 <= arg_243_1.time_ and arg_243_1.time_ < var_246_23 + var_246_24 and not isNil(var_246_22) then
				local var_246_25 = (arg_243_1.time_ - var_246_23) / var_246_24

				if arg_243_1.var_.characterEffect1047ui_story and not isNil(var_246_22) then
					local var_246_26 = Mathf.Lerp(0, 0.5, var_246_25)

					arg_243_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1047ui_story.fillRatio = var_246_26
				end
			end

			if arg_243_1.time_ >= var_246_23 + var_246_24 and arg_243_1.time_ < var_246_23 + var_246_24 + arg_246_0 and not isNil(var_246_22) and arg_243_1.var_.characterEffect1047ui_story then
				local var_246_27 = 0.5

				arg_243_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1047ui_story.fillRatio = var_246_27
			end

			local var_246_28 = 0

			if var_246_28 < arg_243_1.time_ and arg_243_1.time_ <= var_246_28 + arg_246_0 then
				arg_243_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_246_29 = 0

			if var_246_29 < arg_243_1.time_ and arg_243_1.time_ <= var_246_29 + arg_246_0 then
				arg_243_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_246_30 = 0
			local var_246_31 = 0.25

			if var_246_30 < arg_243_1.time_ and arg_243_1.time_ <= var_246_30 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_32 = arg_243_1:FormatText(StoryNameCfg[1307].name)

				arg_243_1.leftNameTxt_.text = var_246_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_33 = arg_243_1:GetWordFromCfg(421041060)
				local var_246_34 = arg_243_1:FormatText(var_246_33.content)

				arg_243_1.text_.text = var_246_34

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_35 = 10
				local var_246_36 = utf8.len(var_246_34)
				local var_246_37 = var_246_35 <= 0 and var_246_31 or var_246_31 * (var_246_36 / var_246_35)

				if var_246_37 > 0 and var_246_31 < var_246_37 then
					arg_243_1.talkMaxDuration = var_246_37

					if var_246_37 + var_246_30 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_37 + var_246_30
					end
				end

				arg_243_1.text_.text = var_246_34
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041060", "story_v_out_421041.awb") ~= 0 then
					local var_246_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041060", "story_v_out_421041.awb") / 1000

					if var_246_38 + var_246_30 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_38 + var_246_30
					end

					if var_246_33.prefab_name ~= "" and arg_243_1.actors_[var_246_33.prefab_name] ~= nil then
						local var_246_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_33.prefab_name].transform, "story_v_out_421041", "421041060", "story_v_out_421041.awb")

						arg_243_1:RecordAudio("421041060", var_246_39)
						arg_243_1:RecordAudio("421041060", var_246_39)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_421041", "421041060", "story_v_out_421041.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_421041", "421041060", "story_v_out_421041.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_40 = math.max(var_246_31, arg_243_1.talkMaxDuration)

			if var_246_30 <= arg_243_1.time_ and arg_243_1.time_ < var_246_30 + var_246_40 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_30) / var_246_40

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_30 + var_246_40 and arg_243_1.time_ < var_246_30 + var_246_40 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421041061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 421041061
		arg_247_1.duration_ = 2.57

		local var_247_0 = {
			zh = 1.999999999999,
			ja = 2.566
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play421041062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10102ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10102ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0.7, -0.985, -6.275)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10102ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["10102ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10102ui_story == nil then
				arg_247_1.var_.characterEffect10102ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect10102ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10102ui_story then
				arg_247_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_250_13 = arg_247_1.actors_["10143ui_story"]
			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 and not isNil(var_250_13) and arg_247_1.var_.characterEffect10143ui_story == nil then
				arg_247_1.var_.characterEffect10143ui_story = var_250_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_15 = 0.200000002980232

			if var_250_14 <= arg_247_1.time_ and arg_247_1.time_ < var_250_14 + var_250_15 and not isNil(var_250_13) then
				local var_250_16 = (arg_247_1.time_ - var_250_14) / var_250_15

				if arg_247_1.var_.characterEffect10143ui_story and not isNil(var_250_13) then
					local var_250_17 = Mathf.Lerp(0, 0.5, var_250_16)

					arg_247_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_247_1.var_.characterEffect10143ui_story.fillRatio = var_250_17
				end
			end

			if arg_247_1.time_ >= var_250_14 + var_250_15 and arg_247_1.time_ < var_250_14 + var_250_15 + arg_250_0 and not isNil(var_250_13) and arg_247_1.var_.characterEffect10143ui_story then
				local var_250_18 = 0.5

				arg_247_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_247_1.var_.characterEffect10143ui_story.fillRatio = var_250_18
			end

			local var_250_19 = 0

			if var_250_19 < arg_247_1.time_ and arg_247_1.time_ <= var_250_19 + arg_250_0 then
				arg_247_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			local var_250_20 = 0

			if var_250_20 < arg_247_1.time_ and arg_247_1.time_ <= var_250_20 + arg_250_0 then
				arg_247_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_250_21 = 0
			local var_250_22 = 0.2

			if var_250_21 < arg_247_1.time_ and arg_247_1.time_ <= var_250_21 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_23 = arg_247_1:FormatText(StoryNameCfg[6].name)

				arg_247_1.leftNameTxt_.text = var_250_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_24 = arg_247_1:GetWordFromCfg(421041061)
				local var_250_25 = arg_247_1:FormatText(var_250_24.content)

				arg_247_1.text_.text = var_250_25

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_26 = 8
				local var_250_27 = utf8.len(var_250_25)
				local var_250_28 = var_250_26 <= 0 and var_250_22 or var_250_22 * (var_250_27 / var_250_26)

				if var_250_28 > 0 and var_250_22 < var_250_28 then
					arg_247_1.talkMaxDuration = var_250_28

					if var_250_28 + var_250_21 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_28 + var_250_21
					end
				end

				arg_247_1.text_.text = var_250_25
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041061", "story_v_out_421041.awb") ~= 0 then
					local var_250_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041061", "story_v_out_421041.awb") / 1000

					if var_250_29 + var_250_21 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_29 + var_250_21
					end

					if var_250_24.prefab_name ~= "" and arg_247_1.actors_[var_250_24.prefab_name] ~= nil then
						local var_250_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_24.prefab_name].transform, "story_v_out_421041", "421041061", "story_v_out_421041.awb")

						arg_247_1:RecordAudio("421041061", var_250_30)
						arg_247_1:RecordAudio("421041061", var_250_30)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_421041", "421041061", "story_v_out_421041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_421041", "421041061", "story_v_out_421041.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_31 = math.max(var_250_22, arg_247_1.talkMaxDuration)

			if var_250_21 <= arg_247_1.time_ and arg_247_1.time_ < var_250_21 + var_250_31 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_21) / var_250_31

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_21 + var_250_31 and arg_247_1.time_ < var_250_21 + var_250_31 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play421041062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 421041062
		arg_251_1.duration_ = 2

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play421041063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10143ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos10143ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(-0.72, -1.06, -6)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10143ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["10143ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect10143ui_story == nil then
				arg_251_1.var_.characterEffect10143ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect10143ui_story and not isNil(var_254_9) then
					arg_251_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect10143ui_story then
				arg_251_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_254_13 = arg_251_1.actors_["10102ui_story"]
			local var_254_14 = 0

			if var_254_14 < arg_251_1.time_ and arg_251_1.time_ <= var_254_14 + arg_254_0 and not isNil(var_254_13) and arg_251_1.var_.characterEffect10102ui_story == nil then
				arg_251_1.var_.characterEffect10102ui_story = var_254_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_15 = 0.200000002980232

			if var_254_14 <= arg_251_1.time_ and arg_251_1.time_ < var_254_14 + var_254_15 and not isNil(var_254_13) then
				local var_254_16 = (arg_251_1.time_ - var_254_14) / var_254_15

				if arg_251_1.var_.characterEffect10102ui_story and not isNil(var_254_13) then
					local var_254_17 = Mathf.Lerp(0, 0.5, var_254_16)

					arg_251_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10102ui_story.fillRatio = var_254_17
				end
			end

			if arg_251_1.time_ >= var_254_14 + var_254_15 and arg_251_1.time_ < var_254_14 + var_254_15 + arg_254_0 and not isNil(var_254_13) and arg_251_1.var_.characterEffect10102ui_story then
				local var_254_18 = 0.5

				arg_251_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10102ui_story.fillRatio = var_254_18
			end

			local var_254_19 = 0

			if var_254_19 < arg_251_1.time_ and arg_251_1.time_ <= var_254_19 + arg_254_0 then
				arg_251_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_1")
			end

			local var_254_20 = 0

			if var_254_20 < arg_251_1.time_ and arg_251_1.time_ <= var_254_20 + arg_254_0 then
				arg_251_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_254_21 = 0
			local var_254_22 = 0.125

			if var_254_21 < arg_251_1.time_ and arg_251_1.time_ <= var_254_21 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_23 = arg_251_1:FormatText(StoryNameCfg[1307].name)

				arg_251_1.leftNameTxt_.text = var_254_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_24 = arg_251_1:GetWordFromCfg(421041062)
				local var_254_25 = arg_251_1:FormatText(var_254_24.content)

				arg_251_1.text_.text = var_254_25

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_26 = 5
				local var_254_27 = utf8.len(var_254_25)
				local var_254_28 = var_254_26 <= 0 and var_254_22 or var_254_22 * (var_254_27 / var_254_26)

				if var_254_28 > 0 and var_254_22 < var_254_28 then
					arg_251_1.talkMaxDuration = var_254_28

					if var_254_28 + var_254_21 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_28 + var_254_21
					end
				end

				arg_251_1.text_.text = var_254_25
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041062", "story_v_out_421041.awb") ~= 0 then
					local var_254_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041062", "story_v_out_421041.awb") / 1000

					if var_254_29 + var_254_21 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_29 + var_254_21
					end

					if var_254_24.prefab_name ~= "" and arg_251_1.actors_[var_254_24.prefab_name] ~= nil then
						local var_254_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_24.prefab_name].transform, "story_v_out_421041", "421041062", "story_v_out_421041.awb")

						arg_251_1:RecordAudio("421041062", var_254_30)
						arg_251_1:RecordAudio("421041062", var_254_30)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_421041", "421041062", "story_v_out_421041.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_421041", "421041062", "story_v_out_421041.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_31 = math.max(var_254_22, arg_251_1.talkMaxDuration)

			if var_254_21 <= arg_251_1.time_ and arg_251_1.time_ < var_254_21 + var_254_31 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_21) / var_254_31

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_21 + var_254_31 and arg_251_1.time_ < var_254_21 + var_254_31 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play421041063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 421041063
		arg_255_1.duration_ = 7.63

		local var_255_0 = {
			zh = 5.9,
			ja = 7.633
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
				arg_255_0:Play421041064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10102ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos10102ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0.7, -0.985, -6.275)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10102ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = arg_255_1.actors_["10102ui_story"]
			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect10102ui_story == nil then
				arg_255_1.var_.characterEffect10102ui_story = var_258_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_11 = 0.200000002980232

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_11 and not isNil(var_258_9) then
				local var_258_12 = (arg_255_1.time_ - var_258_10) / var_258_11

				if arg_255_1.var_.characterEffect10102ui_story and not isNil(var_258_9) then
					arg_255_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_10 + var_258_11 and arg_255_1.time_ < var_258_10 + var_258_11 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect10102ui_story then
				arg_255_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_258_13 = arg_255_1.actors_["10143ui_story"]
			local var_258_14 = 0

			if var_258_14 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 and not isNil(var_258_13) and arg_255_1.var_.characterEffect10143ui_story == nil then
				arg_255_1.var_.characterEffect10143ui_story = var_258_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_15 = 0.200000002980232

			if var_258_14 <= arg_255_1.time_ and arg_255_1.time_ < var_258_14 + var_258_15 and not isNil(var_258_13) then
				local var_258_16 = (arg_255_1.time_ - var_258_14) / var_258_15

				if arg_255_1.var_.characterEffect10143ui_story and not isNil(var_258_13) then
					local var_258_17 = Mathf.Lerp(0, 0.5, var_258_16)

					arg_255_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10143ui_story.fillRatio = var_258_17
				end
			end

			if arg_255_1.time_ >= var_258_14 + var_258_15 and arg_255_1.time_ < var_258_14 + var_258_15 + arg_258_0 and not isNil(var_258_13) and arg_255_1.var_.characterEffect10143ui_story then
				local var_258_18 = 0.5

				arg_255_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10143ui_story.fillRatio = var_258_18
			end

			local var_258_19 = 0

			if var_258_19 < arg_255_1.time_ and arg_255_1.time_ <= var_258_19 + arg_258_0 then
				arg_255_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_2")
			end

			local var_258_20 = 0

			if var_258_20 < arg_255_1.time_ and arg_255_1.time_ <= var_258_20 + arg_258_0 then
				arg_255_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_258_21 = 0
			local var_258_22 = 0.7

			if var_258_21 < arg_255_1.time_ and arg_255_1.time_ <= var_258_21 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_23 = arg_255_1:FormatText(StoryNameCfg[6].name)

				arg_255_1.leftNameTxt_.text = var_258_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_24 = arg_255_1:GetWordFromCfg(421041063)
				local var_258_25 = arg_255_1:FormatText(var_258_24.content)

				arg_255_1.text_.text = var_258_25

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_26 = 28
				local var_258_27 = utf8.len(var_258_25)
				local var_258_28 = var_258_26 <= 0 and var_258_22 or var_258_22 * (var_258_27 / var_258_26)

				if var_258_28 > 0 and var_258_22 < var_258_28 then
					arg_255_1.talkMaxDuration = var_258_28

					if var_258_28 + var_258_21 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_28 + var_258_21
					end
				end

				arg_255_1.text_.text = var_258_25
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041063", "story_v_out_421041.awb") ~= 0 then
					local var_258_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041063", "story_v_out_421041.awb") / 1000

					if var_258_29 + var_258_21 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_29 + var_258_21
					end

					if var_258_24.prefab_name ~= "" and arg_255_1.actors_[var_258_24.prefab_name] ~= nil then
						local var_258_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_24.prefab_name].transform, "story_v_out_421041", "421041063", "story_v_out_421041.awb")

						arg_255_1:RecordAudio("421041063", var_258_30)
						arg_255_1:RecordAudio("421041063", var_258_30)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_421041", "421041063", "story_v_out_421041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_421041", "421041063", "story_v_out_421041.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_31 = math.max(var_258_22, arg_255_1.talkMaxDuration)

			if var_258_21 <= arg_255_1.time_ and arg_255_1.time_ < var_258_21 + var_258_31 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_21) / var_258_31

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_21 + var_258_31 and arg_255_1.time_ < var_258_21 + var_258_31 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play421041064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 421041064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play421041065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10102ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect10102ui_story == nil then
				arg_259_1.var_.characterEffect10102ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect10102ui_story and not isNil(var_262_0) then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10102ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect10102ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10102ui_story.fillRatio = var_262_5
			end

			local var_262_6 = 0
			local var_262_7 = 0.25

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_9 = arg_259_1:GetWordFromCfg(421041064)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 10
				local var_262_12 = utf8.len(var_262_10)
				local var_262_13 = var_262_11 <= 0 and var_262_7 or var_262_7 * (var_262_12 / var_262_11)

				if var_262_13 > 0 and var_262_7 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play421041065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 421041065
		arg_263_1.duration_ = 3.1

		local var_263_0 = {
			zh = 1.999999999999,
			ja = 3.1
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
				arg_263_0:Play421041066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10143ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos10143ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(-0.72, -1.06, -6)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10143ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["10143ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect10143ui_story == nil then
				arg_263_1.var_.characterEffect10143ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect10143ui_story and not isNil(var_266_9) then
					arg_263_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect10143ui_story then
				arg_263_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_266_13 = 0

			if var_266_13 < arg_263_1.time_ and arg_263_1.time_ <= var_266_13 + arg_266_0 then
				arg_263_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_2")
			end

			local var_266_14 = 0

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			local var_266_15 = 0
			local var_266_16 = 0.15

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[1307].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(421041065)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 6
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041065", "story_v_out_421041.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041065", "story_v_out_421041.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_out_421041", "421041065", "story_v_out_421041.awb")

						arg_263_1:RecordAudio("421041065", var_266_24)
						arg_263_1:RecordAudio("421041065", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_421041", "421041065", "story_v_out_421041.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_421041", "421041065", "story_v_out_421041.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421041066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 421041066
		arg_267_1.duration_ = 7.9

		local var_267_0 = {
			zh = 6.7,
			ja = 7.9
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
				arg_267_0:Play421041067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10102ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos10102ui_story = var_270_0.localPosition
			end

			local var_270_2 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2
				local var_270_4 = Vector3.New(0.7, -0.985, -6.275)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10102ui_story, var_270_4, var_270_3)

				local var_270_5 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_5.x, var_270_5.y, var_270_5.z)

				local var_270_6 = var_270_0.localEulerAngles

				var_270_6.z = 0
				var_270_6.x = 0
				var_270_0.localEulerAngles = var_270_6
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_270_7 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_7.x, var_270_7.y, var_270_7.z)

				local var_270_8 = var_270_0.localEulerAngles

				var_270_8.z = 0
				var_270_8.x = 0
				var_270_0.localEulerAngles = var_270_8
			end

			local var_270_9 = arg_267_1.actors_["10102ui_story"]
			local var_270_10 = 0

			if var_270_10 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect10102ui_story == nil then
				arg_267_1.var_.characterEffect10102ui_story = var_270_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_11 = 0.200000002980232

			if var_270_10 <= arg_267_1.time_ and arg_267_1.time_ < var_270_10 + var_270_11 and not isNil(var_270_9) then
				local var_270_12 = (arg_267_1.time_ - var_270_10) / var_270_11

				if arg_267_1.var_.characterEffect10102ui_story and not isNil(var_270_9) then
					arg_267_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_10 + var_270_11 and arg_267_1.time_ < var_270_10 + var_270_11 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect10102ui_story then
				arg_267_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_270_13 = arg_267_1.actors_["10143ui_story"]
			local var_270_14 = 0

			if var_270_14 < arg_267_1.time_ and arg_267_1.time_ <= var_270_14 + arg_270_0 and not isNil(var_270_13) and arg_267_1.var_.characterEffect10143ui_story == nil then
				arg_267_1.var_.characterEffect10143ui_story = var_270_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_15 = 0.200000002980232

			if var_270_14 <= arg_267_1.time_ and arg_267_1.time_ < var_270_14 + var_270_15 and not isNil(var_270_13) then
				local var_270_16 = (arg_267_1.time_ - var_270_14) / var_270_15

				if arg_267_1.var_.characterEffect10143ui_story and not isNil(var_270_13) then
					local var_270_17 = Mathf.Lerp(0, 0.5, var_270_16)

					arg_267_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10143ui_story.fillRatio = var_270_17
				end
			end

			if arg_267_1.time_ >= var_270_14 + var_270_15 and arg_267_1.time_ < var_270_14 + var_270_15 + arg_270_0 and not isNil(var_270_13) and arg_267_1.var_.characterEffect10143ui_story then
				local var_270_18 = 0.5

				arg_267_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10143ui_story.fillRatio = var_270_18
			end

			local var_270_19 = 0

			if var_270_19 < arg_267_1.time_ and arg_267_1.time_ <= var_270_19 + arg_270_0 then
				arg_267_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			local var_270_20 = 0

			if var_270_20 < arg_267_1.time_ and arg_267_1.time_ <= var_270_20 + arg_270_0 then
				arg_267_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_270_21 = 0
			local var_270_22 = 0.75

			if var_270_21 < arg_267_1.time_ and arg_267_1.time_ <= var_270_21 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_23 = arg_267_1:FormatText(StoryNameCfg[6].name)

				arg_267_1.leftNameTxt_.text = var_270_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_24 = arg_267_1:GetWordFromCfg(421041066)
				local var_270_25 = arg_267_1:FormatText(var_270_24.content)

				arg_267_1.text_.text = var_270_25

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_26 = 30
				local var_270_27 = utf8.len(var_270_25)
				local var_270_28 = var_270_26 <= 0 and var_270_22 or var_270_22 * (var_270_27 / var_270_26)

				if var_270_28 > 0 and var_270_22 < var_270_28 then
					arg_267_1.talkMaxDuration = var_270_28

					if var_270_28 + var_270_21 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_28 + var_270_21
					end
				end

				arg_267_1.text_.text = var_270_25
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041066", "story_v_out_421041.awb") ~= 0 then
					local var_270_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041066", "story_v_out_421041.awb") / 1000

					if var_270_29 + var_270_21 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_29 + var_270_21
					end

					if var_270_24.prefab_name ~= "" and arg_267_1.actors_[var_270_24.prefab_name] ~= nil then
						local var_270_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_24.prefab_name].transform, "story_v_out_421041", "421041066", "story_v_out_421041.awb")

						arg_267_1:RecordAudio("421041066", var_270_30)
						arg_267_1:RecordAudio("421041066", var_270_30)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_421041", "421041066", "story_v_out_421041.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_421041", "421041066", "story_v_out_421041.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_31 = math.max(var_270_22, arg_267_1.talkMaxDuration)

			if var_270_21 <= arg_267_1.time_ and arg_267_1.time_ < var_270_21 + var_270_31 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_21) / var_270_31

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_21 + var_270_31 and arg_267_1.time_ < var_270_21 + var_270_31 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play421041067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 421041067
		arg_271_1.duration_ = 2.23

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play421041068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10143ui_story"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos10143ui_story = var_274_0.localPosition
			end

			local var_274_2 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2
				local var_274_4 = Vector3.New(-0.72, -1.06, -6)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10143ui_story, var_274_4, var_274_3)

				local var_274_5 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_5.x, var_274_5.y, var_274_5.z)

				local var_274_6 = var_274_0.localEulerAngles

				var_274_6.z = 0
				var_274_6.x = 0
				var_274_0.localEulerAngles = var_274_6
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_274_7 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_7.x, var_274_7.y, var_274_7.z)

				local var_274_8 = var_274_0.localEulerAngles

				var_274_8.z = 0
				var_274_8.x = 0
				var_274_0.localEulerAngles = var_274_8
			end

			local var_274_9 = arg_271_1.actors_["10143ui_story"]
			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 and not isNil(var_274_9) and arg_271_1.var_.characterEffect10143ui_story == nil then
				arg_271_1.var_.characterEffect10143ui_story = var_274_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_11 = 0.200000002980232

			if var_274_10 <= arg_271_1.time_ and arg_271_1.time_ < var_274_10 + var_274_11 and not isNil(var_274_9) then
				local var_274_12 = (arg_271_1.time_ - var_274_10) / var_274_11

				if arg_271_1.var_.characterEffect10143ui_story and not isNil(var_274_9) then
					arg_271_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_10 + var_274_11 and arg_271_1.time_ < var_274_10 + var_274_11 + arg_274_0 and not isNil(var_274_9) and arg_271_1.var_.characterEffect10143ui_story then
				arg_271_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_274_13 = arg_271_1.actors_["10102ui_story"]
			local var_274_14 = 0

			if var_274_14 < arg_271_1.time_ and arg_271_1.time_ <= var_274_14 + arg_274_0 and not isNil(var_274_13) and arg_271_1.var_.characterEffect10102ui_story == nil then
				arg_271_1.var_.characterEffect10102ui_story = var_274_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_15 = 0.200000002980232

			if var_274_14 <= arg_271_1.time_ and arg_271_1.time_ < var_274_14 + var_274_15 and not isNil(var_274_13) then
				local var_274_16 = (arg_271_1.time_ - var_274_14) / var_274_15

				if arg_271_1.var_.characterEffect10102ui_story and not isNil(var_274_13) then
					local var_274_17 = Mathf.Lerp(0, 0.5, var_274_16)

					arg_271_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10102ui_story.fillRatio = var_274_17
				end
			end

			if arg_271_1.time_ >= var_274_14 + var_274_15 and arg_271_1.time_ < var_274_14 + var_274_15 + arg_274_0 and not isNil(var_274_13) and arg_271_1.var_.characterEffect10102ui_story then
				local var_274_18 = 0.5

				arg_271_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10102ui_story.fillRatio = var_274_18
			end

			local var_274_19 = 0

			if var_274_19 < arg_271_1.time_ and arg_271_1.time_ <= var_274_19 + arg_274_0 then
				arg_271_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_274_20 = 0

			if var_274_20 < arg_271_1.time_ and arg_271_1.time_ <= var_274_20 + arg_274_0 then
				arg_271_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_274_21 = 0
			local var_274_22 = 0.2

			if var_274_21 < arg_271_1.time_ and arg_271_1.time_ <= var_274_21 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_23 = arg_271_1:FormatText(StoryNameCfg[1307].name)

				arg_271_1.leftNameTxt_.text = var_274_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_24 = arg_271_1:GetWordFromCfg(421041067)
				local var_274_25 = arg_271_1:FormatText(var_274_24.content)

				arg_271_1.text_.text = var_274_25

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_26 = 8
				local var_274_27 = utf8.len(var_274_25)
				local var_274_28 = var_274_26 <= 0 and var_274_22 or var_274_22 * (var_274_27 / var_274_26)

				if var_274_28 > 0 and var_274_22 < var_274_28 then
					arg_271_1.talkMaxDuration = var_274_28

					if var_274_28 + var_274_21 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_28 + var_274_21
					end
				end

				arg_271_1.text_.text = var_274_25
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041067", "story_v_out_421041.awb") ~= 0 then
					local var_274_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041067", "story_v_out_421041.awb") / 1000

					if var_274_29 + var_274_21 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_29 + var_274_21
					end

					if var_274_24.prefab_name ~= "" and arg_271_1.actors_[var_274_24.prefab_name] ~= nil then
						local var_274_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_24.prefab_name].transform, "story_v_out_421041", "421041067", "story_v_out_421041.awb")

						arg_271_1:RecordAudio("421041067", var_274_30)
						arg_271_1:RecordAudio("421041067", var_274_30)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_421041", "421041067", "story_v_out_421041.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_421041", "421041067", "story_v_out_421041.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_31 = math.max(var_274_22, arg_271_1.talkMaxDuration)

			if var_274_21 <= arg_271_1.time_ and arg_271_1.time_ < var_274_21 + var_274_31 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_21) / var_274_31

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_21 + var_274_31 and arg_271_1.time_ < var_274_21 + var_274_31 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play421041068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 421041068
		arg_275_1.duration_ = 7.87

		local var_275_0 = {
			zh = 7.866,
			ja = 7.466
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
				arg_275_0:Play421041069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10145ui_story"].transform
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.var_.moveOldPos10145ui_story = var_278_0.localPosition
			end

			local var_278_2 = 0.001

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2
				local var_278_4 = Vector3.New(0.78, -1, -6.2)

				var_278_0.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10145ui_story, var_278_4, var_278_3)

				local var_278_5 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_5.x, var_278_5.y, var_278_5.z)

				local var_278_6 = var_278_0.localEulerAngles

				var_278_6.z = 0
				var_278_6.x = 0
				var_278_0.localEulerAngles = var_278_6
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 then
				var_278_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_278_7 = manager.ui.mainCamera.transform.position - var_278_0.position

				var_278_0.forward = Vector3.New(var_278_7.x, var_278_7.y, var_278_7.z)

				local var_278_8 = var_278_0.localEulerAngles

				var_278_8.z = 0
				var_278_8.x = 0
				var_278_0.localEulerAngles = var_278_8
			end

			local var_278_9 = arg_275_1.actors_["10102ui_story"].transform
			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 then
				arg_275_1.var_.moveOldPos10102ui_story = var_278_9.localPosition
			end

			local var_278_11 = 0.001

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_11 then
				local var_278_12 = (arg_275_1.time_ - var_278_10) / var_278_11
				local var_278_13 = Vector3.New(0, 100, 0)

				var_278_9.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10102ui_story, var_278_13, var_278_12)

				local var_278_14 = manager.ui.mainCamera.transform.position - var_278_9.position

				var_278_9.forward = Vector3.New(var_278_14.x, var_278_14.y, var_278_14.z)

				local var_278_15 = var_278_9.localEulerAngles

				var_278_15.z = 0
				var_278_15.x = 0
				var_278_9.localEulerAngles = var_278_15
			end

			if arg_275_1.time_ >= var_278_10 + var_278_11 and arg_275_1.time_ < var_278_10 + var_278_11 + arg_278_0 then
				var_278_9.localPosition = Vector3.New(0, 100, 0)

				local var_278_16 = manager.ui.mainCamera.transform.position - var_278_9.position

				var_278_9.forward = Vector3.New(var_278_16.x, var_278_16.y, var_278_16.z)

				local var_278_17 = var_278_9.localEulerAngles

				var_278_17.z = 0
				var_278_17.x = 0
				var_278_9.localEulerAngles = var_278_17
			end

			local var_278_18 = arg_275_1.actors_["10145ui_story"]
			local var_278_19 = 0

			if var_278_19 < arg_275_1.time_ and arg_275_1.time_ <= var_278_19 + arg_278_0 and not isNil(var_278_18) and arg_275_1.var_.characterEffect10145ui_story == nil then
				arg_275_1.var_.characterEffect10145ui_story = var_278_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_20 = 0.200000002980232

			if var_278_19 <= arg_275_1.time_ and arg_275_1.time_ < var_278_19 + var_278_20 and not isNil(var_278_18) then
				local var_278_21 = (arg_275_1.time_ - var_278_19) / var_278_20

				if arg_275_1.var_.characterEffect10145ui_story and not isNil(var_278_18) then
					arg_275_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_19 + var_278_20 and arg_275_1.time_ < var_278_19 + var_278_20 + arg_278_0 and not isNil(var_278_18) and arg_275_1.var_.characterEffect10145ui_story then
				arg_275_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_278_22 = arg_275_1.actors_["10143ui_story"]
			local var_278_23 = 0

			if var_278_23 < arg_275_1.time_ and arg_275_1.time_ <= var_278_23 + arg_278_0 and not isNil(var_278_22) and arg_275_1.var_.characterEffect10143ui_story == nil then
				arg_275_1.var_.characterEffect10143ui_story = var_278_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_24 = 0.200000002980232

			if var_278_23 <= arg_275_1.time_ and arg_275_1.time_ < var_278_23 + var_278_24 and not isNil(var_278_22) then
				local var_278_25 = (arg_275_1.time_ - var_278_23) / var_278_24

				if arg_275_1.var_.characterEffect10143ui_story and not isNil(var_278_22) then
					local var_278_26 = Mathf.Lerp(0, 0.5, var_278_25)

					arg_275_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10143ui_story.fillRatio = var_278_26
				end
			end

			if arg_275_1.time_ >= var_278_23 + var_278_24 and arg_275_1.time_ < var_278_23 + var_278_24 + arg_278_0 and not isNil(var_278_22) and arg_275_1.var_.characterEffect10143ui_story then
				local var_278_27 = 0.5

				arg_275_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10143ui_story.fillRatio = var_278_27
			end

			local var_278_28 = 0

			if var_278_28 < arg_275_1.time_ and arg_275_1.time_ <= var_278_28 + arg_278_0 then
				arg_275_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_278_29 = 0

			if var_278_29 < arg_275_1.time_ and arg_275_1.time_ <= var_278_29 + arg_278_0 then
				arg_275_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_278_30 = 0
			local var_278_31 = 0.775

			if var_278_30 < arg_275_1.time_ and arg_275_1.time_ <= var_278_30 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_32 = arg_275_1:FormatText(StoryNameCfg[1308].name)

				arg_275_1.leftNameTxt_.text = var_278_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_33 = arg_275_1:GetWordFromCfg(421041068)
				local var_278_34 = arg_275_1:FormatText(var_278_33.content)

				arg_275_1.text_.text = var_278_34

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_35 = 31
				local var_278_36 = utf8.len(var_278_34)
				local var_278_37 = var_278_35 <= 0 and var_278_31 or var_278_31 * (var_278_36 / var_278_35)

				if var_278_37 > 0 and var_278_31 < var_278_37 then
					arg_275_1.talkMaxDuration = var_278_37

					if var_278_37 + var_278_30 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_37 + var_278_30
					end
				end

				arg_275_1.text_.text = var_278_34
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041068", "story_v_out_421041.awb") ~= 0 then
					local var_278_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041068", "story_v_out_421041.awb") / 1000

					if var_278_38 + var_278_30 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_38 + var_278_30
					end

					if var_278_33.prefab_name ~= "" and arg_275_1.actors_[var_278_33.prefab_name] ~= nil then
						local var_278_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_33.prefab_name].transform, "story_v_out_421041", "421041068", "story_v_out_421041.awb")

						arg_275_1:RecordAudio("421041068", var_278_39)
						arg_275_1:RecordAudio("421041068", var_278_39)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_421041", "421041068", "story_v_out_421041.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_421041", "421041068", "story_v_out_421041.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_40 = math.max(var_278_31, arg_275_1.talkMaxDuration)

			if var_278_30 <= arg_275_1.time_ and arg_275_1.time_ < var_278_30 + var_278_40 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_30) / var_278_40

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_30 + var_278_40 and arg_275_1.time_ < var_278_30 + var_278_40 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play421041069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 421041069
		arg_279_1.duration_ = 2.83

		local var_279_0 = {
			zh = 2.166,
			ja = 2.833
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
				arg_279_0:Play421041070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10143ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos10143ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(-0.72, -1.06, -6)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10143ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["10143ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect10143ui_story == nil then
				arg_279_1.var_.characterEffect10143ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.200000002980232

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect10143ui_story and not isNil(var_282_9) then
					arg_279_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect10143ui_story then
				arg_279_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_282_13 = arg_279_1.actors_["10145ui_story"]
			local var_282_14 = 0

			if var_282_14 < arg_279_1.time_ and arg_279_1.time_ <= var_282_14 + arg_282_0 and not isNil(var_282_13) and arg_279_1.var_.characterEffect10145ui_story == nil then
				arg_279_1.var_.characterEffect10145ui_story = var_282_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_15 = 0.200000002980232

			if var_282_14 <= arg_279_1.time_ and arg_279_1.time_ < var_282_14 + var_282_15 and not isNil(var_282_13) then
				local var_282_16 = (arg_279_1.time_ - var_282_14) / var_282_15

				if arg_279_1.var_.characterEffect10145ui_story and not isNil(var_282_13) then
					local var_282_17 = Mathf.Lerp(0, 0.5, var_282_16)

					arg_279_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_279_1.var_.characterEffect10145ui_story.fillRatio = var_282_17
				end
			end

			if arg_279_1.time_ >= var_282_14 + var_282_15 and arg_279_1.time_ < var_282_14 + var_282_15 + arg_282_0 and not isNil(var_282_13) and arg_279_1.var_.characterEffect10145ui_story then
				local var_282_18 = 0.5

				arg_279_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_279_1.var_.characterEffect10145ui_story.fillRatio = var_282_18
			end

			local var_282_19 = 0

			if var_282_19 < arg_279_1.time_ and arg_279_1.time_ <= var_282_19 + arg_282_0 then
				arg_279_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action5_1")
			end

			local var_282_20 = 0
			local var_282_21 = 0.325

			if var_282_20 < arg_279_1.time_ and arg_279_1.time_ <= var_282_20 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_22 = arg_279_1:FormatText(StoryNameCfg[1307].name)

				arg_279_1.leftNameTxt_.text = var_282_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_23 = arg_279_1:GetWordFromCfg(421041069)
				local var_282_24 = arg_279_1:FormatText(var_282_23.content)

				arg_279_1.text_.text = var_282_24

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_25 = 13
				local var_282_26 = utf8.len(var_282_24)
				local var_282_27 = var_282_25 <= 0 and var_282_21 or var_282_21 * (var_282_26 / var_282_25)

				if var_282_27 > 0 and var_282_21 < var_282_27 then
					arg_279_1.talkMaxDuration = var_282_27

					if var_282_27 + var_282_20 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_27 + var_282_20
					end
				end

				arg_279_1.text_.text = var_282_24
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041069", "story_v_out_421041.awb") ~= 0 then
					local var_282_28 = manager.audio:GetVoiceLength("story_v_out_421041", "421041069", "story_v_out_421041.awb") / 1000

					if var_282_28 + var_282_20 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_28 + var_282_20
					end

					if var_282_23.prefab_name ~= "" and arg_279_1.actors_[var_282_23.prefab_name] ~= nil then
						local var_282_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_23.prefab_name].transform, "story_v_out_421041", "421041069", "story_v_out_421041.awb")

						arg_279_1:RecordAudio("421041069", var_282_29)
						arg_279_1:RecordAudio("421041069", var_282_29)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_421041", "421041069", "story_v_out_421041.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_421041", "421041069", "story_v_out_421041.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_30 = math.max(var_282_21, arg_279_1.talkMaxDuration)

			if var_282_20 <= arg_279_1.time_ and arg_279_1.time_ < var_282_20 + var_282_30 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_20) / var_282_30

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_20 + var_282_30 and arg_279_1.time_ < var_282_20 + var_282_30 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play421041070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 421041070
		arg_283_1.duration_ = 4.5

		local var_283_0 = {
			zh = 3.9,
			ja = 4.5
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
				arg_283_0:Play421041071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10145ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos10145ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0.78, -1, -6.2)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10145ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = arg_283_1.actors_["10145ui_story"]
			local var_286_10 = 0

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect10145ui_story == nil then
				arg_283_1.var_.characterEffect10145ui_story = var_286_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_11 = 0.200000002980232

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_11 and not isNil(var_286_9) then
				local var_286_12 = (arg_283_1.time_ - var_286_10) / var_286_11

				if arg_283_1.var_.characterEffect10145ui_story and not isNil(var_286_9) then
					arg_283_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_10 + var_286_11 and arg_283_1.time_ < var_286_10 + var_286_11 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect10145ui_story then
				arg_283_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_286_13 = arg_283_1.actors_["10143ui_story"]
			local var_286_14 = 0

			if var_286_14 < arg_283_1.time_ and arg_283_1.time_ <= var_286_14 + arg_286_0 and not isNil(var_286_13) and arg_283_1.var_.characterEffect10143ui_story == nil then
				arg_283_1.var_.characterEffect10143ui_story = var_286_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_15 = 0.200000002980232

			if var_286_14 <= arg_283_1.time_ and arg_283_1.time_ < var_286_14 + var_286_15 and not isNil(var_286_13) then
				local var_286_16 = (arg_283_1.time_ - var_286_14) / var_286_15

				if arg_283_1.var_.characterEffect10143ui_story and not isNil(var_286_13) then
					local var_286_17 = Mathf.Lerp(0, 0.5, var_286_16)

					arg_283_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_283_1.var_.characterEffect10143ui_story.fillRatio = var_286_17
				end
			end

			if arg_283_1.time_ >= var_286_14 + var_286_15 and arg_283_1.time_ < var_286_14 + var_286_15 + arg_286_0 and not isNil(var_286_13) and arg_283_1.var_.characterEffect10143ui_story then
				local var_286_18 = 0.5

				arg_283_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_283_1.var_.characterEffect10143ui_story.fillRatio = var_286_18
			end

			local var_286_19 = 0

			if var_286_19 < arg_283_1.time_ and arg_283_1.time_ <= var_286_19 + arg_286_0 then
				arg_283_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			local var_286_20 = 0

			if var_286_20 < arg_283_1.time_ and arg_283_1.time_ <= var_286_20 + arg_286_0 then
				arg_283_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_286_21 = 0
			local var_286_22 = 0.4

			if var_286_21 < arg_283_1.time_ and arg_283_1.time_ <= var_286_21 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_23 = arg_283_1:FormatText(StoryNameCfg[1308].name)

				arg_283_1.leftNameTxt_.text = var_286_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_24 = arg_283_1:GetWordFromCfg(421041070)
				local var_286_25 = arg_283_1:FormatText(var_286_24.content)

				arg_283_1.text_.text = var_286_25

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_26 = 16
				local var_286_27 = utf8.len(var_286_25)
				local var_286_28 = var_286_26 <= 0 and var_286_22 or var_286_22 * (var_286_27 / var_286_26)

				if var_286_28 > 0 and var_286_22 < var_286_28 then
					arg_283_1.talkMaxDuration = var_286_28

					if var_286_28 + var_286_21 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_28 + var_286_21
					end
				end

				arg_283_1.text_.text = var_286_25
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041070", "story_v_out_421041.awb") ~= 0 then
					local var_286_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041070", "story_v_out_421041.awb") / 1000

					if var_286_29 + var_286_21 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_29 + var_286_21
					end

					if var_286_24.prefab_name ~= "" and arg_283_1.actors_[var_286_24.prefab_name] ~= nil then
						local var_286_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_24.prefab_name].transform, "story_v_out_421041", "421041070", "story_v_out_421041.awb")

						arg_283_1:RecordAudio("421041070", var_286_30)
						arg_283_1:RecordAudio("421041070", var_286_30)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_421041", "421041070", "story_v_out_421041.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_421041", "421041070", "story_v_out_421041.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_31 = math.max(var_286_22, arg_283_1.talkMaxDuration)

			if var_286_21 <= arg_283_1.time_ and arg_283_1.time_ < var_286_21 + var_286_31 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_21) / var_286_31

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_21 + var_286_31 and arg_283_1.time_ < var_286_21 + var_286_31 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play421041071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 421041071
		arg_287_1.duration_ = 6.77

		local var_287_0 = {
			zh = 4.733,
			ja = 6.766
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play421041072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10143ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos10143ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(-0.72, -1.06, -6)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10143ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["10143ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect10143ui_story == nil then
				arg_287_1.var_.characterEffect10143ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect10143ui_story and not isNil(var_290_9) then
					arg_287_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect10143ui_story then
				arg_287_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_290_13 = arg_287_1.actors_["10145ui_story"]
			local var_290_14 = 0

			if var_290_14 < arg_287_1.time_ and arg_287_1.time_ <= var_290_14 + arg_290_0 and not isNil(var_290_13) and arg_287_1.var_.characterEffect10145ui_story == nil then
				arg_287_1.var_.characterEffect10145ui_story = var_290_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_15 = 0.200000002980232

			if var_290_14 <= arg_287_1.time_ and arg_287_1.time_ < var_290_14 + var_290_15 and not isNil(var_290_13) then
				local var_290_16 = (arg_287_1.time_ - var_290_14) / var_290_15

				if arg_287_1.var_.characterEffect10145ui_story and not isNil(var_290_13) then
					local var_290_17 = Mathf.Lerp(0, 0.5, var_290_16)

					arg_287_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10145ui_story.fillRatio = var_290_17
				end
			end

			if arg_287_1.time_ >= var_290_14 + var_290_15 and arg_287_1.time_ < var_290_14 + var_290_15 + arg_290_0 and not isNil(var_290_13) and arg_287_1.var_.characterEffect10145ui_story then
				local var_290_18 = 0.5

				arg_287_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10145ui_story.fillRatio = var_290_18
			end

			local var_290_19 = 0

			if var_290_19 < arg_287_1.time_ and arg_287_1.time_ <= var_290_19 + arg_290_0 then
				arg_287_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action5_2")
			end

			local var_290_20 = 0

			if var_290_20 < arg_287_1.time_ and arg_287_1.time_ <= var_290_20 + arg_290_0 then
				arg_287_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_290_21 = 0
			local var_290_22 = 0.55

			if var_290_21 < arg_287_1.time_ and arg_287_1.time_ <= var_290_21 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_23 = arg_287_1:FormatText(StoryNameCfg[1307].name)

				arg_287_1.leftNameTxt_.text = var_290_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_24 = arg_287_1:GetWordFromCfg(421041071)
				local var_290_25 = arg_287_1:FormatText(var_290_24.content)

				arg_287_1.text_.text = var_290_25

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_26 = 22
				local var_290_27 = utf8.len(var_290_25)
				local var_290_28 = var_290_26 <= 0 and var_290_22 or var_290_22 * (var_290_27 / var_290_26)

				if var_290_28 > 0 and var_290_22 < var_290_28 then
					arg_287_1.talkMaxDuration = var_290_28

					if var_290_28 + var_290_21 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_28 + var_290_21
					end
				end

				arg_287_1.text_.text = var_290_25
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041071", "story_v_out_421041.awb") ~= 0 then
					local var_290_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041071", "story_v_out_421041.awb") / 1000

					if var_290_29 + var_290_21 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_29 + var_290_21
					end

					if var_290_24.prefab_name ~= "" and arg_287_1.actors_[var_290_24.prefab_name] ~= nil then
						local var_290_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_24.prefab_name].transform, "story_v_out_421041", "421041071", "story_v_out_421041.awb")

						arg_287_1:RecordAudio("421041071", var_290_30)
						arg_287_1:RecordAudio("421041071", var_290_30)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_421041", "421041071", "story_v_out_421041.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_421041", "421041071", "story_v_out_421041.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_31 = math.max(var_290_22, arg_287_1.talkMaxDuration)

			if var_290_21 <= arg_287_1.time_ and arg_287_1.time_ < var_290_21 + var_290_31 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_21) / var_290_31

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_21 + var_290_31 and arg_287_1.time_ < var_290_21 + var_290_31 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	Play421041072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 421041072
		arg_291_1.duration_ = 3.7

		local var_291_0 = {
			zh = 3.4,
			ja = 3.7
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
				arg_291_0:Play421041073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10145ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos10145ui_story = var_294_0.localPosition
			end

			local var_294_2 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2
				local var_294_4 = Vector3.New(0.78, -1, -6.2)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10145ui_story, var_294_4, var_294_3)

				local var_294_5 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_5.x, var_294_5.y, var_294_5.z)

				local var_294_6 = var_294_0.localEulerAngles

				var_294_6.z = 0
				var_294_6.x = 0
				var_294_0.localEulerAngles = var_294_6
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_294_7 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_7.x, var_294_7.y, var_294_7.z)

				local var_294_8 = var_294_0.localEulerAngles

				var_294_8.z = 0
				var_294_8.x = 0
				var_294_0.localEulerAngles = var_294_8
			end

			local var_294_9 = arg_291_1.actors_["10145ui_story"]
			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 and not isNil(var_294_9) and arg_291_1.var_.characterEffect10145ui_story == nil then
				arg_291_1.var_.characterEffect10145ui_story = var_294_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_11 = 0.200000002980232

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_11 and not isNil(var_294_9) then
				local var_294_12 = (arg_291_1.time_ - var_294_10) / var_294_11

				if arg_291_1.var_.characterEffect10145ui_story and not isNil(var_294_9) then
					arg_291_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_10 + var_294_11 and arg_291_1.time_ < var_294_10 + var_294_11 + arg_294_0 and not isNil(var_294_9) and arg_291_1.var_.characterEffect10145ui_story then
				arg_291_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_294_13 = arg_291_1.actors_["10143ui_story"]
			local var_294_14 = 0

			if var_294_14 < arg_291_1.time_ and arg_291_1.time_ <= var_294_14 + arg_294_0 and not isNil(var_294_13) and arg_291_1.var_.characterEffect10143ui_story == nil then
				arg_291_1.var_.characterEffect10143ui_story = var_294_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_15 = 0.200000002980232

			if var_294_14 <= arg_291_1.time_ and arg_291_1.time_ < var_294_14 + var_294_15 and not isNil(var_294_13) then
				local var_294_16 = (arg_291_1.time_ - var_294_14) / var_294_15

				if arg_291_1.var_.characterEffect10143ui_story and not isNil(var_294_13) then
					local var_294_17 = Mathf.Lerp(0, 0.5, var_294_16)

					arg_291_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10143ui_story.fillRatio = var_294_17
				end
			end

			if arg_291_1.time_ >= var_294_14 + var_294_15 and arg_291_1.time_ < var_294_14 + var_294_15 + arg_294_0 and not isNil(var_294_13) and arg_291_1.var_.characterEffect10143ui_story then
				local var_294_18 = 0.5

				arg_291_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10143ui_story.fillRatio = var_294_18
			end

			local var_294_19 = 0

			if var_294_19 < arg_291_1.time_ and arg_291_1.time_ <= var_294_19 + arg_294_0 then
				arg_291_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			local var_294_20 = 0
			local var_294_21 = 0.275

			if var_294_20 < arg_291_1.time_ and arg_291_1.time_ <= var_294_20 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_22 = arg_291_1:FormatText(StoryNameCfg[1308].name)

				arg_291_1.leftNameTxt_.text = var_294_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_23 = arg_291_1:GetWordFromCfg(421041072)
				local var_294_24 = arg_291_1:FormatText(var_294_23.content)

				arg_291_1.text_.text = var_294_24

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_25 = 11
				local var_294_26 = utf8.len(var_294_24)
				local var_294_27 = var_294_25 <= 0 and var_294_21 or var_294_21 * (var_294_26 / var_294_25)

				if var_294_27 > 0 and var_294_21 < var_294_27 then
					arg_291_1.talkMaxDuration = var_294_27

					if var_294_27 + var_294_20 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_27 + var_294_20
					end
				end

				arg_291_1.text_.text = var_294_24
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041072", "story_v_out_421041.awb") ~= 0 then
					local var_294_28 = manager.audio:GetVoiceLength("story_v_out_421041", "421041072", "story_v_out_421041.awb") / 1000

					if var_294_28 + var_294_20 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_28 + var_294_20
					end

					if var_294_23.prefab_name ~= "" and arg_291_1.actors_[var_294_23.prefab_name] ~= nil then
						local var_294_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_23.prefab_name].transform, "story_v_out_421041", "421041072", "story_v_out_421041.awb")

						arg_291_1:RecordAudio("421041072", var_294_29)
						arg_291_1:RecordAudio("421041072", var_294_29)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_421041", "421041072", "story_v_out_421041.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_421041", "421041072", "story_v_out_421041.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_30 = math.max(var_294_21, arg_291_1.talkMaxDuration)

			if var_294_20 <= arg_291_1.time_ and arg_291_1.time_ < var_294_20 + var_294_30 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_20) / var_294_30

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_20 + var_294_30 and arg_291_1.time_ < var_294_20 + var_294_30 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play421041073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 421041073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play421041074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10143ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos10143ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(0, 100, 0)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10143ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0, 100, 0)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = arg_295_1.actors_["10145ui_story"].transform
			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 then
				arg_295_1.var_.moveOldPos10145ui_story = var_298_9.localPosition
			end

			local var_298_11 = 0.001

			if var_298_10 <= arg_295_1.time_ and arg_295_1.time_ < var_298_10 + var_298_11 then
				local var_298_12 = (arg_295_1.time_ - var_298_10) / var_298_11
				local var_298_13 = Vector3.New(0, 100, 0)

				var_298_9.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10145ui_story, var_298_13, var_298_12)

				local var_298_14 = manager.ui.mainCamera.transform.position - var_298_9.position

				var_298_9.forward = Vector3.New(var_298_14.x, var_298_14.y, var_298_14.z)

				local var_298_15 = var_298_9.localEulerAngles

				var_298_15.z = 0
				var_298_15.x = 0
				var_298_9.localEulerAngles = var_298_15
			end

			if arg_295_1.time_ >= var_298_10 + var_298_11 and arg_295_1.time_ < var_298_10 + var_298_11 + arg_298_0 then
				var_298_9.localPosition = Vector3.New(0, 100, 0)

				local var_298_16 = manager.ui.mainCamera.transform.position - var_298_9.position

				var_298_9.forward = Vector3.New(var_298_16.x, var_298_16.y, var_298_16.z)

				local var_298_17 = var_298_9.localEulerAngles

				var_298_17.z = 0
				var_298_17.x = 0
				var_298_9.localEulerAngles = var_298_17
			end

			local var_298_18 = 0
			local var_298_19 = 1.075

			if var_298_18 < arg_295_1.time_ and arg_295_1.time_ <= var_298_18 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_20 = arg_295_1:GetWordFromCfg(421041073)
				local var_298_21 = arg_295_1:FormatText(var_298_20.content)

				arg_295_1.text_.text = var_298_21

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_22 = 43
				local var_298_23 = utf8.len(var_298_21)
				local var_298_24 = var_298_22 <= 0 and var_298_19 or var_298_19 * (var_298_23 / var_298_22)

				if var_298_24 > 0 and var_298_19 < var_298_24 then
					arg_295_1.talkMaxDuration = var_298_24

					if var_298_24 + var_298_18 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_24 + var_298_18
					end
				end

				arg_295_1.text_.text = var_298_21
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_25 = math.max(var_298_19, arg_295_1.talkMaxDuration)

			if var_298_18 <= arg_295_1.time_ and arg_295_1.time_ < var_298_18 + var_298_25 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_18) / var_298_25

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_18 + var_298_25 and arg_295_1.time_ < var_298_18 + var_298_25 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play421041074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 421041074
		arg_299_1.duration_ = 9

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play421041075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = "ST0110"

			if arg_299_1.bgs_[var_302_0] == nil then
				local var_302_1 = Object.Instantiate(arg_299_1.paintGo_)

				var_302_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_302_0)
				var_302_1.name = var_302_0
				var_302_1.transform.parent = arg_299_1.stage_.transform
				var_302_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.bgs_[var_302_0] = var_302_1
			end

			local var_302_2 = 2

			if var_302_2 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				local var_302_3 = manager.ui.mainCamera.transform.localPosition
				local var_302_4 = Vector3.New(0, 0, 10) + Vector3.New(var_302_3.x, var_302_3.y, 0)
				local var_302_5 = arg_299_1.bgs_.ST0110

				var_302_5.transform.localPosition = var_302_4
				var_302_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_6 = var_302_5:GetComponent("SpriteRenderer")

				if var_302_6 and var_302_6.sprite then
					local var_302_7 = (var_302_5.transform.localPosition - var_302_3).z
					local var_302_8 = manager.ui.mainCameraCom_
					local var_302_9 = 2 * var_302_7 * Mathf.Tan(var_302_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_302_10 = var_302_9 * var_302_8.aspect
					local var_302_11 = var_302_6.sprite.bounds.size.x
					local var_302_12 = var_302_6.sprite.bounds.size.y
					local var_302_13 = var_302_10 / var_302_11
					local var_302_14 = var_302_9 / var_302_12
					local var_302_15 = var_302_14 < var_302_13 and var_302_13 or var_302_14

					var_302_5.transform.localScale = Vector3.New(var_302_15, var_302_15, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "ST0110" then
						iter_302_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_302_16 = 4

			if var_302_16 < arg_299_1.time_ and arg_299_1.time_ <= var_302_16 + arg_302_0 then
				arg_299_1.allBtn_.enabled = false
			end

			local var_302_17 = 0.3

			if arg_299_1.time_ >= var_302_16 + var_302_17 and arg_299_1.time_ < var_302_16 + var_302_17 + arg_302_0 then
				arg_299_1.allBtn_.enabled = true
			end

			local var_302_18 = 0

			if var_302_18 < arg_299_1.time_ and arg_299_1.time_ <= var_302_18 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_19 = 2

			if var_302_18 <= arg_299_1.time_ and arg_299_1.time_ < var_302_18 + var_302_19 then
				local var_302_20 = (arg_299_1.time_ - var_302_18) / var_302_19
				local var_302_21 = Color.New(0, 0, 0)

				var_302_21.a = Mathf.Lerp(0, 1, var_302_20)
				arg_299_1.mask_.color = var_302_21
			end

			if arg_299_1.time_ >= var_302_18 + var_302_19 and arg_299_1.time_ < var_302_18 + var_302_19 + arg_302_0 then
				local var_302_22 = Color.New(0, 0, 0)

				var_302_22.a = 1
				arg_299_1.mask_.color = var_302_22
			end

			local var_302_23 = 2

			if var_302_23 < arg_299_1.time_ and arg_299_1.time_ <= var_302_23 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_24 = 2

			if var_302_23 <= arg_299_1.time_ and arg_299_1.time_ < var_302_23 + var_302_24 then
				local var_302_25 = (arg_299_1.time_ - var_302_23) / var_302_24
				local var_302_26 = Color.New(0, 0, 0)

				var_302_26.a = Mathf.Lerp(1, 0, var_302_25)
				arg_299_1.mask_.color = var_302_26
			end

			if arg_299_1.time_ >= var_302_23 + var_302_24 and arg_299_1.time_ < var_302_23 + var_302_24 + arg_302_0 then
				local var_302_27 = Color.New(0, 0, 0)
				local var_302_28 = 0

				arg_299_1.mask_.enabled = false
				var_302_27.a = var_302_28
				arg_299_1.mask_.color = var_302_27
			end

			local var_302_29 = 0.1
			local var_302_30 = 1

			if var_302_29 < arg_299_1.time_ and arg_299_1.time_ <= var_302_29 + arg_302_0 then
				local var_302_31 = "stop"
				local var_302_32 = "effect"

				arg_299_1:AudioAction(var_302_31, var_302_32, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			local var_302_33 = 1.66666666666667
			local var_302_34 = 1

			if var_302_33 < arg_299_1.time_ and arg_299_1.time_ <= var_302_33 + arg_302_0 then
				local var_302_35 = "play"
				local var_302_36 = "effect"

				arg_299_1:AudioAction(var_302_35, var_302_36, "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_299_1.frameCnt_ <= 1 then
				arg_299_1.dialog_:SetActive(false)
			end

			local var_302_37 = 4
			local var_302_38 = 2.125

			if var_302_37 < arg_299_1.time_ and arg_299_1.time_ <= var_302_37 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				arg_299_1.dialog_:SetActive(true)

				arg_299_1.dialogCg_.alpha = 0

				local var_302_39 = LeanTween.value(arg_299_1.dialog_, 0, 1, 0.3)

				var_302_39:setOnUpdate(LuaHelper.FloatAction(function(arg_303_0)
					arg_299_1.dialogCg_.alpha = arg_303_0
				end))
				var_302_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_299_1.dialog_)
					var_302_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_299_1.duration_ = arg_299_1.duration_ + 0.3

				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_40 = arg_299_1:GetWordFromCfg(421041074)
				local var_302_41 = arg_299_1:FormatText(var_302_40.content)

				arg_299_1.text_.text = var_302_41

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_42 = 85
				local var_302_43 = utf8.len(var_302_41)
				local var_302_44 = var_302_42 <= 0 and var_302_38 or var_302_38 * (var_302_43 / var_302_42)

				if var_302_44 > 0 and var_302_38 < var_302_44 then
					arg_299_1.talkMaxDuration = var_302_44
					var_302_37 = var_302_37 + 0.3

					if var_302_44 + var_302_37 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_44 + var_302_37
					end
				end

				arg_299_1.text_.text = var_302_41
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_45 = var_302_37 + 0.3
			local var_302_46 = math.max(var_302_38, arg_299_1.talkMaxDuration)

			if var_302_45 <= arg_299_1.time_ and arg_299_1.time_ < var_302_45 + var_302_46 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_45) / var_302_46

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_45 + var_302_46 and arg_299_1.time_ < var_302_45 + var_302_46 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play421041075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 421041075
		arg_305_1.duration_ = 2.97

		local var_305_0 = {
			zh = 1.999999999999,
			ja = 2.966
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
				arg_305_0:Play421041076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["10102ui_story"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos10102ui_story = var_308_0.localPosition
			end

			local var_308_2 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2
				local var_308_4 = Vector3.New(0, -0.985, -6.275)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10102ui_story, var_308_4, var_308_3)

				local var_308_5 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_5.x, var_308_5.y, var_308_5.z)

				local var_308_6 = var_308_0.localEulerAngles

				var_308_6.z = 0
				var_308_6.x = 0
				var_308_0.localEulerAngles = var_308_6
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_308_7 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_7.x, var_308_7.y, var_308_7.z)

				local var_308_8 = var_308_0.localEulerAngles

				var_308_8.z = 0
				var_308_8.x = 0
				var_308_0.localEulerAngles = var_308_8
			end

			local var_308_9 = arg_305_1.actors_["10102ui_story"]
			local var_308_10 = 0

			if var_308_10 < arg_305_1.time_ and arg_305_1.time_ <= var_308_10 + arg_308_0 and not isNil(var_308_9) and arg_305_1.var_.characterEffect10102ui_story == nil then
				arg_305_1.var_.characterEffect10102ui_story = var_308_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_11 = 0.200000002980232

			if var_308_10 <= arg_305_1.time_ and arg_305_1.time_ < var_308_10 + var_308_11 and not isNil(var_308_9) then
				local var_308_12 = (arg_305_1.time_ - var_308_10) / var_308_11

				if arg_305_1.var_.characterEffect10102ui_story and not isNil(var_308_9) then
					arg_305_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_10 + var_308_11 and arg_305_1.time_ < var_308_10 + var_308_11 + arg_308_0 and not isNil(var_308_9) and arg_305_1.var_.characterEffect10102ui_story then
				arg_305_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_308_13 = 0

			if var_308_13 < arg_305_1.time_ and arg_305_1.time_ <= var_308_13 + arg_308_0 then
				arg_305_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action7_1")
			end

			local var_308_14 = 0

			if var_308_14 < arg_305_1.time_ and arg_305_1.time_ <= var_308_14 + arg_308_0 then
				arg_305_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_308_15 = 0
			local var_308_16 = 0.175

			if var_308_15 < arg_305_1.time_ and arg_305_1.time_ <= var_308_15 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_17 = arg_305_1:FormatText(StoryNameCfg[6].name)

				arg_305_1.leftNameTxt_.text = var_308_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_18 = arg_305_1:GetWordFromCfg(421041075)
				local var_308_19 = arg_305_1:FormatText(var_308_18.content)

				arg_305_1.text_.text = var_308_19

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_20 = 7
				local var_308_21 = utf8.len(var_308_19)
				local var_308_22 = var_308_20 <= 0 and var_308_16 or var_308_16 * (var_308_21 / var_308_20)

				if var_308_22 > 0 and var_308_16 < var_308_22 then
					arg_305_1.talkMaxDuration = var_308_22

					if var_308_22 + var_308_15 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_22 + var_308_15
					end
				end

				arg_305_1.text_.text = var_308_19
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041075", "story_v_out_421041.awb") ~= 0 then
					local var_308_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041075", "story_v_out_421041.awb") / 1000

					if var_308_23 + var_308_15 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_23 + var_308_15
					end

					if var_308_18.prefab_name ~= "" and arg_305_1.actors_[var_308_18.prefab_name] ~= nil then
						local var_308_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_18.prefab_name].transform, "story_v_out_421041", "421041075", "story_v_out_421041.awb")

						arg_305_1:RecordAudio("421041075", var_308_24)
						arg_305_1:RecordAudio("421041075", var_308_24)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_421041", "421041075", "story_v_out_421041.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_421041", "421041075", "story_v_out_421041.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_25 = math.max(var_308_16, arg_305_1.talkMaxDuration)

			if var_308_15 <= arg_305_1.time_ and arg_305_1.time_ < var_308_15 + var_308_25 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_15) / var_308_25

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_15 + var_308_25 and arg_305_1.time_ < var_308_15 + var_308_25 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421041076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 421041076
		arg_309_1.duration_ = 5.43

		local var_309_0 = {
			zh = 2.933,
			ja = 5.433
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
				arg_309_0:Play421041077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["10145ui_story"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos10145ui_story = var_312_0.localPosition
			end

			local var_312_2 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2
				local var_312_4 = Vector3.New(0, -1, -6.2)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10145ui_story, var_312_4, var_312_3)

				local var_312_5 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_5.x, var_312_5.y, var_312_5.z)

				local var_312_6 = var_312_0.localEulerAngles

				var_312_6.z = 0
				var_312_6.x = 0
				var_312_0.localEulerAngles = var_312_6
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_312_7 = manager.ui.mainCamera.transform.position - var_312_0.position

				var_312_0.forward = Vector3.New(var_312_7.x, var_312_7.y, var_312_7.z)

				local var_312_8 = var_312_0.localEulerAngles

				var_312_8.z = 0
				var_312_8.x = 0
				var_312_0.localEulerAngles = var_312_8
			end

			local var_312_9 = arg_309_1.actors_["10102ui_story"].transform
			local var_312_10 = 0

			if var_312_10 < arg_309_1.time_ and arg_309_1.time_ <= var_312_10 + arg_312_0 then
				arg_309_1.var_.moveOldPos10102ui_story = var_312_9.localPosition
			end

			local var_312_11 = 0.001

			if var_312_10 <= arg_309_1.time_ and arg_309_1.time_ < var_312_10 + var_312_11 then
				local var_312_12 = (arg_309_1.time_ - var_312_10) / var_312_11
				local var_312_13 = Vector3.New(0, 100, 0)

				var_312_9.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10102ui_story, var_312_13, var_312_12)

				local var_312_14 = manager.ui.mainCamera.transform.position - var_312_9.position

				var_312_9.forward = Vector3.New(var_312_14.x, var_312_14.y, var_312_14.z)

				local var_312_15 = var_312_9.localEulerAngles

				var_312_15.z = 0
				var_312_15.x = 0
				var_312_9.localEulerAngles = var_312_15
			end

			if arg_309_1.time_ >= var_312_10 + var_312_11 and arg_309_1.time_ < var_312_10 + var_312_11 + arg_312_0 then
				var_312_9.localPosition = Vector3.New(0, 100, 0)

				local var_312_16 = manager.ui.mainCamera.transform.position - var_312_9.position

				var_312_9.forward = Vector3.New(var_312_16.x, var_312_16.y, var_312_16.z)

				local var_312_17 = var_312_9.localEulerAngles

				var_312_17.z = 0
				var_312_17.x = 0
				var_312_9.localEulerAngles = var_312_17
			end

			local var_312_18 = arg_309_1.actors_["10145ui_story"]
			local var_312_19 = 0

			if var_312_19 < arg_309_1.time_ and arg_309_1.time_ <= var_312_19 + arg_312_0 and not isNil(var_312_18) and arg_309_1.var_.characterEffect10145ui_story == nil then
				arg_309_1.var_.characterEffect10145ui_story = var_312_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_20 = 0.200000002980232

			if var_312_19 <= arg_309_1.time_ and arg_309_1.time_ < var_312_19 + var_312_20 and not isNil(var_312_18) then
				local var_312_21 = (arg_309_1.time_ - var_312_19) / var_312_20

				if arg_309_1.var_.characterEffect10145ui_story and not isNil(var_312_18) then
					arg_309_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= var_312_19 + var_312_20 and arg_309_1.time_ < var_312_19 + var_312_20 + arg_312_0 and not isNil(var_312_18) and arg_309_1.var_.characterEffect10145ui_story then
				arg_309_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_312_22 = arg_309_1.actors_["10102ui_story"]
			local var_312_23 = 0

			if var_312_23 < arg_309_1.time_ and arg_309_1.time_ <= var_312_23 + arg_312_0 and not isNil(var_312_22) and arg_309_1.var_.characterEffect10102ui_story == nil then
				arg_309_1.var_.characterEffect10102ui_story = var_312_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_24 = 0.200000002980232

			if var_312_23 <= arg_309_1.time_ and arg_309_1.time_ < var_312_23 + var_312_24 and not isNil(var_312_22) then
				local var_312_25 = (arg_309_1.time_ - var_312_23) / var_312_24

				if arg_309_1.var_.characterEffect10102ui_story and not isNil(var_312_22) then
					local var_312_26 = Mathf.Lerp(0, 0.5, var_312_25)

					arg_309_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10102ui_story.fillRatio = var_312_26
				end
			end

			if arg_309_1.time_ >= var_312_23 + var_312_24 and arg_309_1.time_ < var_312_23 + var_312_24 + arg_312_0 and not isNil(var_312_22) and arg_309_1.var_.characterEffect10102ui_story then
				local var_312_27 = 0.5

				arg_309_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10102ui_story.fillRatio = var_312_27
			end

			local var_312_28 = 0

			if var_312_28 < arg_309_1.time_ and arg_309_1.time_ <= var_312_28 + arg_312_0 then
				arg_309_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_312_29 = 0

			if var_312_29 < arg_309_1.time_ and arg_309_1.time_ <= var_312_29 + arg_312_0 then
				arg_309_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_312_30 = 0
			local var_312_31 = 0.3

			if var_312_30 < arg_309_1.time_ and arg_309_1.time_ <= var_312_30 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_32 = arg_309_1:FormatText(StoryNameCfg[1308].name)

				arg_309_1.leftNameTxt_.text = var_312_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_33 = arg_309_1:GetWordFromCfg(421041076)
				local var_312_34 = arg_309_1:FormatText(var_312_33.content)

				arg_309_1.text_.text = var_312_34

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_35 = 12
				local var_312_36 = utf8.len(var_312_34)
				local var_312_37 = var_312_35 <= 0 and var_312_31 or var_312_31 * (var_312_36 / var_312_35)

				if var_312_37 > 0 and var_312_31 < var_312_37 then
					arg_309_1.talkMaxDuration = var_312_37

					if var_312_37 + var_312_30 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_37 + var_312_30
					end
				end

				arg_309_1.text_.text = var_312_34
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041076", "story_v_out_421041.awb") ~= 0 then
					local var_312_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041076", "story_v_out_421041.awb") / 1000

					if var_312_38 + var_312_30 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_38 + var_312_30
					end

					if var_312_33.prefab_name ~= "" and arg_309_1.actors_[var_312_33.prefab_name] ~= nil then
						local var_312_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_33.prefab_name].transform, "story_v_out_421041", "421041076", "story_v_out_421041.awb")

						arg_309_1:RecordAudio("421041076", var_312_39)
						arg_309_1:RecordAudio("421041076", var_312_39)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_421041", "421041076", "story_v_out_421041.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_421041", "421041076", "story_v_out_421041.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_40 = math.max(var_312_31, arg_309_1.talkMaxDuration)

			if var_312_30 <= arg_309_1.time_ and arg_309_1.time_ < var_312_30 + var_312_40 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_30) / var_312_40

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_30 + var_312_40 and arg_309_1.time_ < var_312_30 + var_312_40 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play421041077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 421041077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play421041078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["10145ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect10145ui_story == nil then
				arg_313_1.var_.characterEffect10145ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect10145ui_story and not isNil(var_316_0) then
					local var_316_4 = Mathf.Lerp(0, 0.5, var_316_3)

					arg_313_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_313_1.var_.characterEffect10145ui_story.fillRatio = var_316_4
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect10145ui_story then
				local var_316_5 = 0.5

				arg_313_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_313_1.var_.characterEffect10145ui_story.fillRatio = var_316_5
			end

			local var_316_6 = 0
			local var_316_7 = 0.125

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_8 = arg_313_1:FormatText(StoryNameCfg[7].name)

				arg_313_1.leftNameTxt_.text = var_316_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_9 = arg_313_1:GetWordFromCfg(421041077)
				local var_316_10 = arg_313_1:FormatText(var_316_9.content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 5
				local var_316_12 = utf8.len(var_316_10)
				local var_316_13 = var_316_11 <= 0 and var_316_7 or var_316_7 * (var_316_12 / var_316_11)

				if var_316_13 > 0 and var_316_7 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_14 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_14 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_14

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_14 and arg_313_1.time_ < var_316_6 + var_316_14 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play421041078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 421041078
		arg_317_1.duration_ = 11.5

		local var_317_0 = {
			zh = 9.233,
			ja = 11.5
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
				arg_317_0:Play421041079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["10145ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect10145ui_story == nil then
				arg_317_1.var_.characterEffect10145ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect10145ui_story and not isNil(var_320_0) then
					arg_317_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect10145ui_story then
				arg_317_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_320_4 = 0

			if var_320_4 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_320_5 = 0

			if var_320_5 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 then
				arg_317_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_320_6 = 0
			local var_320_7 = 1.125

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_8 = arg_317_1:FormatText(StoryNameCfg[1308].name)

				arg_317_1.leftNameTxt_.text = var_320_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_9 = arg_317_1:GetWordFromCfg(421041078)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 45
				local var_320_12 = utf8.len(var_320_10)
				local var_320_13 = var_320_11 <= 0 and var_320_7 or var_320_7 * (var_320_12 / var_320_11)

				if var_320_13 > 0 and var_320_7 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041078", "story_v_out_421041.awb") ~= 0 then
					local var_320_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041078", "story_v_out_421041.awb") / 1000

					if var_320_14 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_6
					end

					if var_320_9.prefab_name ~= "" and arg_317_1.actors_[var_320_9.prefab_name] ~= nil then
						local var_320_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_9.prefab_name].transform, "story_v_out_421041", "421041078", "story_v_out_421041.awb")

						arg_317_1:RecordAudio("421041078", var_320_15)
						arg_317_1:RecordAudio("421041078", var_320_15)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_421041", "421041078", "story_v_out_421041.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_421041", "421041078", "story_v_out_421041.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_16 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_16 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_16

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_16 and arg_317_1.time_ < var_320_6 + var_320_16 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play421041079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 421041079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play421041080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10145ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect10145ui_story == nil then
				arg_321_1.var_.characterEffect10145ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect10145ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_321_1.var_.characterEffect10145ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect10145ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_321_1.var_.characterEffect10145ui_story.fillRatio = var_324_5
			end

			local var_324_6 = 0
			local var_324_7 = 0.525

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_8 = arg_321_1:FormatText(StoryNameCfg[7].name)

				arg_321_1.leftNameTxt_.text = var_324_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_9 = arg_321_1:GetWordFromCfg(421041079)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 21
				local var_324_12 = utf8.len(var_324_10)
				local var_324_13 = var_324_11 <= 0 and var_324_7 or var_324_7 * (var_324_12 / var_324_11)

				if var_324_13 > 0 and var_324_7 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_10
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play421041080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 421041080
		arg_325_1.duration_ = 12.23

		local var_325_0 = {
			zh = 11.666,
			ja = 12.233
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play421041081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["10145ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect10145ui_story == nil then
				arg_325_1.var_.characterEffect10145ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect10145ui_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect10145ui_story then
				arg_325_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_328_4 = 0

			if var_328_4 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_328_5 = 0

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_328_6 = 0
			local var_328_7 = 1.325

			if var_328_6 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_8 = arg_325_1:FormatText(StoryNameCfg[1308].name)

				arg_325_1.leftNameTxt_.text = var_328_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_9 = arg_325_1:GetWordFromCfg(421041080)
				local var_328_10 = arg_325_1:FormatText(var_328_9.content)

				arg_325_1.text_.text = var_328_10

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 54
				local var_328_12 = utf8.len(var_328_10)
				local var_328_13 = var_328_11 <= 0 and var_328_7 or var_328_7 * (var_328_12 / var_328_11)

				if var_328_13 > 0 and var_328_7 < var_328_13 then
					arg_325_1.talkMaxDuration = var_328_13

					if var_328_13 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_10
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041080", "story_v_out_421041.awb") ~= 0 then
					local var_328_14 = manager.audio:GetVoiceLength("story_v_out_421041", "421041080", "story_v_out_421041.awb") / 1000

					if var_328_14 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_14 + var_328_6
					end

					if var_328_9.prefab_name ~= "" and arg_325_1.actors_[var_328_9.prefab_name] ~= nil then
						local var_328_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_9.prefab_name].transform, "story_v_out_421041", "421041080", "story_v_out_421041.awb")

						arg_325_1:RecordAudio("421041080", var_328_15)
						arg_325_1:RecordAudio("421041080", var_328_15)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_421041", "421041080", "story_v_out_421041.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_421041", "421041080", "story_v_out_421041.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_16 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_16 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_16

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_16 and arg_325_1.time_ < var_328_6 + var_328_16 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play421041081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 421041081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play421041082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["10145ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect10145ui_story == nil then
				arg_329_1.var_.characterEffect10145ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect10145ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10145ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect10145ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10145ui_story.fillRatio = var_332_5
			end

			local var_332_6 = 0
			local var_332_7 = 0.3

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_8 = arg_329_1:FormatText(StoryNameCfg[7].name)

				arg_329_1.leftNameTxt_.text = var_332_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_9 = arg_329_1:GetWordFromCfg(421041081)
				local var_332_10 = arg_329_1:FormatText(var_332_9.content)

				arg_329_1.text_.text = var_332_10

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_11 = 12
				local var_332_12 = utf8.len(var_332_10)
				local var_332_13 = var_332_11 <= 0 and var_332_7 or var_332_7 * (var_332_12 / var_332_11)

				if var_332_13 > 0 and var_332_7 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_10
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_14 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_14 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_6) / var_332_14

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_6 + var_332_14 and arg_329_1.time_ < var_332_6 + var_332_14 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play421041082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 421041082
		arg_333_1.duration_ = 2.67

		local var_333_0 = {
			zh = 2.666,
			ja = 2
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
				arg_333_0:Play421041083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1047ui_story"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1047ui_story = var_336_0.localPosition
			end

			local var_336_2 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2
				local var_336_4 = Vector3.New(0, -1.13, -6.2)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1047ui_story, var_336_4, var_336_3)

				local var_336_5 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_5.x, var_336_5.y, var_336_5.z)

				local var_336_6 = var_336_0.localEulerAngles

				var_336_6.z = 0
				var_336_6.x = 0
				var_336_0.localEulerAngles = var_336_6
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_336_7 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_7.x, var_336_7.y, var_336_7.z)

				local var_336_8 = var_336_0.localEulerAngles

				var_336_8.z = 0
				var_336_8.x = 0
				var_336_0.localEulerAngles = var_336_8
			end

			local var_336_9 = arg_333_1.actors_["1047ui_story"]
			local var_336_10 = 0

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1047ui_story == nil then
				arg_333_1.var_.characterEffect1047ui_story = var_336_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_11 = 0.200000002980232

			if var_336_10 <= arg_333_1.time_ and arg_333_1.time_ < var_336_10 + var_336_11 and not isNil(var_336_9) then
				local var_336_12 = (arg_333_1.time_ - var_336_10) / var_336_11

				if arg_333_1.var_.characterEffect1047ui_story and not isNil(var_336_9) then
					arg_333_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_10 + var_336_11 and arg_333_1.time_ < var_336_10 + var_336_11 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1047ui_story then
				arg_333_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_336_13 = 0

			if var_336_13 < arg_333_1.time_ and arg_333_1.time_ <= var_336_13 + arg_336_0 then
				arg_333_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_336_14 = 0

			if var_336_14 < arg_333_1.time_ and arg_333_1.time_ <= var_336_14 + arg_336_0 then
				arg_333_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_336_15 = arg_333_1.actors_["10145ui_story"].transform
			local var_336_16 = 0

			if var_336_16 < arg_333_1.time_ and arg_333_1.time_ <= var_336_16 + arg_336_0 then
				arg_333_1.var_.moveOldPos10145ui_story = var_336_15.localPosition
			end

			local var_336_17 = 0.001

			if var_336_16 <= arg_333_1.time_ and arg_333_1.time_ < var_336_16 + var_336_17 then
				local var_336_18 = (arg_333_1.time_ - var_336_16) / var_336_17
				local var_336_19 = Vector3.New(0, 100, 0)

				var_336_15.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10145ui_story, var_336_19, var_336_18)

				local var_336_20 = manager.ui.mainCamera.transform.position - var_336_15.position

				var_336_15.forward = Vector3.New(var_336_20.x, var_336_20.y, var_336_20.z)

				local var_336_21 = var_336_15.localEulerAngles

				var_336_21.z = 0
				var_336_21.x = 0
				var_336_15.localEulerAngles = var_336_21
			end

			if arg_333_1.time_ >= var_336_16 + var_336_17 and arg_333_1.time_ < var_336_16 + var_336_17 + arg_336_0 then
				var_336_15.localPosition = Vector3.New(0, 100, 0)

				local var_336_22 = manager.ui.mainCamera.transform.position - var_336_15.position

				var_336_15.forward = Vector3.New(var_336_22.x, var_336_22.y, var_336_22.z)

				local var_336_23 = var_336_15.localEulerAngles

				var_336_23.z = 0
				var_336_23.x = 0
				var_336_15.localEulerAngles = var_336_23
			end

			local var_336_24 = 0
			local var_336_25 = 0.2

			if var_336_24 < arg_333_1.time_ and arg_333_1.time_ <= var_336_24 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_26 = arg_333_1:FormatText(StoryNameCfg[1296].name)

				arg_333_1.leftNameTxt_.text = var_336_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_27 = arg_333_1:GetWordFromCfg(421041082)
				local var_336_28 = arg_333_1:FormatText(var_336_27.content)

				arg_333_1.text_.text = var_336_28

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_29 = 8
				local var_336_30 = utf8.len(var_336_28)
				local var_336_31 = var_336_29 <= 0 and var_336_25 or var_336_25 * (var_336_30 / var_336_29)

				if var_336_31 > 0 and var_336_25 < var_336_31 then
					arg_333_1.talkMaxDuration = var_336_31

					if var_336_31 + var_336_24 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_31 + var_336_24
					end
				end

				arg_333_1.text_.text = var_336_28
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041082", "story_v_out_421041.awb") ~= 0 then
					local var_336_32 = manager.audio:GetVoiceLength("story_v_out_421041", "421041082", "story_v_out_421041.awb") / 1000

					if var_336_32 + var_336_24 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_32 + var_336_24
					end

					if var_336_27.prefab_name ~= "" and arg_333_1.actors_[var_336_27.prefab_name] ~= nil then
						local var_336_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_27.prefab_name].transform, "story_v_out_421041", "421041082", "story_v_out_421041.awb")

						arg_333_1:RecordAudio("421041082", var_336_33)
						arg_333_1:RecordAudio("421041082", var_336_33)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_421041", "421041082", "story_v_out_421041.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_421041", "421041082", "story_v_out_421041.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_34 = math.max(var_336_25, arg_333_1.talkMaxDuration)

			if var_336_24 <= arg_333_1.time_ and arg_333_1.time_ < var_336_24 + var_336_34 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_24) / var_336_34

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_24 + var_336_34 and arg_333_1.time_ < var_336_24 + var_336_34 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play421041083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 421041083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play421041084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1047ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1047ui_story == nil then
				arg_337_1.var_.characterEffect1047ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1047ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1047ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1047ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1047ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.35

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(421041083)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 14
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play421041084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 421041084
		arg_341_1.duration_ = 15.6

		local var_341_0 = {
			zh = 11.666,
			ja = 15.6
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
				arg_341_0:Play421041085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1047ui_story"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos1047ui_story = var_344_0.localPosition
			end

			local var_344_2 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2
				local var_344_4 = Vector3.New(0, -1.13, -6.2)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1047ui_story, var_344_4, var_344_3)

				local var_344_5 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_5.x, var_344_5.y, var_344_5.z)

				local var_344_6 = var_344_0.localEulerAngles

				var_344_6.z = 0
				var_344_6.x = 0
				var_344_0.localEulerAngles = var_344_6
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_344_7 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_7.x, var_344_7.y, var_344_7.z)

				local var_344_8 = var_344_0.localEulerAngles

				var_344_8.z = 0
				var_344_8.x = 0
				var_344_0.localEulerAngles = var_344_8
			end

			local var_344_9 = arg_341_1.actors_["1047ui_story"]
			local var_344_10 = 0

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1047ui_story == nil then
				arg_341_1.var_.characterEffect1047ui_story = var_344_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_11 = 0.200000002980232

			if var_344_10 <= arg_341_1.time_ and arg_341_1.time_ < var_344_10 + var_344_11 and not isNil(var_344_9) then
				local var_344_12 = (arg_341_1.time_ - var_344_10) / var_344_11

				if arg_341_1.var_.characterEffect1047ui_story and not isNil(var_344_9) then
					arg_341_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_10 + var_344_11 and arg_341_1.time_ < var_344_10 + var_344_11 + arg_344_0 and not isNil(var_344_9) and arg_341_1.var_.characterEffect1047ui_story then
				arg_341_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_344_13 = 0

			if var_344_13 < arg_341_1.time_ and arg_341_1.time_ <= var_344_13 + arg_344_0 then
				arg_341_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_344_14 = 0

			if var_344_14 < arg_341_1.time_ and arg_341_1.time_ <= var_344_14 + arg_344_0 then
				arg_341_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_344_15 = 0
			local var_344_16 = 1.5

			if var_344_15 < arg_341_1.time_ and arg_341_1.time_ <= var_344_15 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_17 = arg_341_1:FormatText(StoryNameCfg[1296].name)

				arg_341_1.leftNameTxt_.text = var_344_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_18 = arg_341_1:GetWordFromCfg(421041084)
				local var_344_19 = arg_341_1:FormatText(var_344_18.content)

				arg_341_1.text_.text = var_344_19

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_20 = 60
				local var_344_21 = utf8.len(var_344_19)
				local var_344_22 = var_344_20 <= 0 and var_344_16 or var_344_16 * (var_344_21 / var_344_20)

				if var_344_22 > 0 and var_344_16 < var_344_22 then
					arg_341_1.talkMaxDuration = var_344_22

					if var_344_22 + var_344_15 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_22 + var_344_15
					end
				end

				arg_341_1.text_.text = var_344_19
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041084", "story_v_out_421041.awb") ~= 0 then
					local var_344_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041084", "story_v_out_421041.awb") / 1000

					if var_344_23 + var_344_15 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_23 + var_344_15
					end

					if var_344_18.prefab_name ~= "" and arg_341_1.actors_[var_344_18.prefab_name] ~= nil then
						local var_344_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_18.prefab_name].transform, "story_v_out_421041", "421041084", "story_v_out_421041.awb")

						arg_341_1:RecordAudio("421041084", var_344_24)
						arg_341_1:RecordAudio("421041084", var_344_24)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_421041", "421041084", "story_v_out_421041.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_421041", "421041084", "story_v_out_421041.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_25 = math.max(var_344_16, arg_341_1.talkMaxDuration)

			if var_344_15 <= arg_341_1.time_ and arg_341_1.time_ < var_344_15 + var_344_25 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_15) / var_344_25

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_15 + var_344_25 and arg_341_1.time_ < var_344_15 + var_344_25 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play421041085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 421041085
		arg_345_1.duration_ = 7.13

		local var_345_0 = {
			zh = 6.933,
			ja = 7.133
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
				arg_345_0:Play421041086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10145ui_story"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos10145ui_story = var_348_0.localPosition
			end

			local var_348_2 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2
				local var_348_4 = Vector3.New(0.78, -1, -6.2)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10145ui_story, var_348_4, var_348_3)

				local var_348_5 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_5.x, var_348_5.y, var_348_5.z)

				local var_348_6 = var_348_0.localEulerAngles

				var_348_6.z = 0
				var_348_6.x = 0
				var_348_0.localEulerAngles = var_348_6
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_348_7 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_7.x, var_348_7.y, var_348_7.z)

				local var_348_8 = var_348_0.localEulerAngles

				var_348_8.z = 0
				var_348_8.x = 0
				var_348_0.localEulerAngles = var_348_8
			end

			local var_348_9 = arg_345_1.actors_["10145ui_story"]
			local var_348_10 = 0

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect10145ui_story == nil then
				arg_345_1.var_.characterEffect10145ui_story = var_348_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_11 = 0.200000002980232

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_11 and not isNil(var_348_9) then
				local var_348_12 = (arg_345_1.time_ - var_348_10) / var_348_11

				if arg_345_1.var_.characterEffect10145ui_story and not isNil(var_348_9) then
					arg_345_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_10 + var_348_11 and arg_345_1.time_ < var_348_10 + var_348_11 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect10145ui_story then
				arg_345_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_348_13 = arg_345_1.actors_["1047ui_story"]
			local var_348_14 = 0

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 and not isNil(var_348_13) and arg_345_1.var_.characterEffect1047ui_story == nil then
				arg_345_1.var_.characterEffect1047ui_story = var_348_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_15 = 0.200000002980232

			if var_348_14 <= arg_345_1.time_ and arg_345_1.time_ < var_348_14 + var_348_15 and not isNil(var_348_13) then
				local var_348_16 = (arg_345_1.time_ - var_348_14) / var_348_15

				if arg_345_1.var_.characterEffect1047ui_story and not isNil(var_348_13) then
					local var_348_17 = Mathf.Lerp(0, 0.5, var_348_16)

					arg_345_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1047ui_story.fillRatio = var_348_17
				end
			end

			if arg_345_1.time_ >= var_348_14 + var_348_15 and arg_345_1.time_ < var_348_14 + var_348_15 + arg_348_0 and not isNil(var_348_13) and arg_345_1.var_.characterEffect1047ui_story then
				local var_348_18 = 0.5

				arg_345_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1047ui_story.fillRatio = var_348_18
			end

			local var_348_19 = 0

			if var_348_19 < arg_345_1.time_ and arg_345_1.time_ <= var_348_19 + arg_348_0 then
				arg_345_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_1")
			end

			local var_348_20 = 0

			if var_348_20 < arg_345_1.time_ and arg_345_1.time_ <= var_348_20 + arg_348_0 then
				arg_345_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_348_21 = arg_345_1.actors_["1047ui_story"].transform
			local var_348_22 = 0

			if var_348_22 < arg_345_1.time_ and arg_345_1.time_ <= var_348_22 + arg_348_0 then
				arg_345_1.var_.moveOldPos1047ui_story = var_348_21.localPosition
			end

			local var_348_23 = 0.001

			if var_348_22 <= arg_345_1.time_ and arg_345_1.time_ < var_348_22 + var_348_23 then
				local var_348_24 = (arg_345_1.time_ - var_348_22) / var_348_23
				local var_348_25 = Vector3.New(-0.6, -1.13, -6.2)

				var_348_21.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1047ui_story, var_348_25, var_348_24)

				local var_348_26 = manager.ui.mainCamera.transform.position - var_348_21.position

				var_348_21.forward = Vector3.New(var_348_26.x, var_348_26.y, var_348_26.z)

				local var_348_27 = var_348_21.localEulerAngles

				var_348_27.z = 0
				var_348_27.x = 0
				var_348_21.localEulerAngles = var_348_27
			end

			if arg_345_1.time_ >= var_348_22 + var_348_23 and arg_345_1.time_ < var_348_22 + var_348_23 + arg_348_0 then
				var_348_21.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_348_28 = manager.ui.mainCamera.transform.position - var_348_21.position

				var_348_21.forward = Vector3.New(var_348_28.x, var_348_28.y, var_348_28.z)

				local var_348_29 = var_348_21.localEulerAngles

				var_348_29.z = 0
				var_348_29.x = 0
				var_348_21.localEulerAngles = var_348_29
			end

			local var_348_30 = 0
			local var_348_31 = 0.8

			if var_348_30 < arg_345_1.time_ and arg_345_1.time_ <= var_348_30 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_32 = arg_345_1:FormatText(StoryNameCfg[1308].name)

				arg_345_1.leftNameTxt_.text = var_348_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_33 = arg_345_1:GetWordFromCfg(421041085)
				local var_348_34 = arg_345_1:FormatText(var_348_33.content)

				arg_345_1.text_.text = var_348_34

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_35 = 32
				local var_348_36 = utf8.len(var_348_34)
				local var_348_37 = var_348_35 <= 0 and var_348_31 or var_348_31 * (var_348_36 / var_348_35)

				if var_348_37 > 0 and var_348_31 < var_348_37 then
					arg_345_1.talkMaxDuration = var_348_37

					if var_348_37 + var_348_30 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_37 + var_348_30
					end
				end

				arg_345_1.text_.text = var_348_34
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041085", "story_v_out_421041.awb") ~= 0 then
					local var_348_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041085", "story_v_out_421041.awb") / 1000

					if var_348_38 + var_348_30 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_38 + var_348_30
					end

					if var_348_33.prefab_name ~= "" and arg_345_1.actors_[var_348_33.prefab_name] ~= nil then
						local var_348_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_33.prefab_name].transform, "story_v_out_421041", "421041085", "story_v_out_421041.awb")

						arg_345_1:RecordAudio("421041085", var_348_39)
						arg_345_1:RecordAudio("421041085", var_348_39)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_421041", "421041085", "story_v_out_421041.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_421041", "421041085", "story_v_out_421041.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_40 = math.max(var_348_31, arg_345_1.talkMaxDuration)

			if var_348_30 <= arg_345_1.time_ and arg_345_1.time_ < var_348_30 + var_348_40 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_30) / var_348_40

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_30 + var_348_40 and arg_345_1.time_ < var_348_30 + var_348_40 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play421041086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 421041086
		arg_349_1.duration_ = 11.2

		local var_349_0 = {
			zh = 8.1,
			ja = 11.2
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
				arg_349_0:Play421041087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["10143ui_story"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos10143ui_story = var_352_0.localPosition
			end

			local var_352_2 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2
				local var_352_4 = Vector3.New(-0.72, -1.06, -6)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10143ui_story, var_352_4, var_352_3)

				local var_352_5 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_5.x, var_352_5.y, var_352_5.z)

				local var_352_6 = var_352_0.localEulerAngles

				var_352_6.z = 0
				var_352_6.x = 0
				var_352_0.localEulerAngles = var_352_6
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_352_7 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_7.x, var_352_7.y, var_352_7.z)

				local var_352_8 = var_352_0.localEulerAngles

				var_352_8.z = 0
				var_352_8.x = 0
				var_352_0.localEulerAngles = var_352_8
			end

			local var_352_9 = arg_349_1.actors_["1047ui_story"].transform
			local var_352_10 = 0

			if var_352_10 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 then
				arg_349_1.var_.moveOldPos1047ui_story = var_352_9.localPosition
			end

			local var_352_11 = 0.001

			if var_352_10 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_11 then
				local var_352_12 = (arg_349_1.time_ - var_352_10) / var_352_11
				local var_352_13 = Vector3.New(0, 100, 0)

				var_352_9.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1047ui_story, var_352_13, var_352_12)

				local var_352_14 = manager.ui.mainCamera.transform.position - var_352_9.position

				var_352_9.forward = Vector3.New(var_352_14.x, var_352_14.y, var_352_14.z)

				local var_352_15 = var_352_9.localEulerAngles

				var_352_15.z = 0
				var_352_15.x = 0
				var_352_9.localEulerAngles = var_352_15
			end

			if arg_349_1.time_ >= var_352_10 + var_352_11 and arg_349_1.time_ < var_352_10 + var_352_11 + arg_352_0 then
				var_352_9.localPosition = Vector3.New(0, 100, 0)

				local var_352_16 = manager.ui.mainCamera.transform.position - var_352_9.position

				var_352_9.forward = Vector3.New(var_352_16.x, var_352_16.y, var_352_16.z)

				local var_352_17 = var_352_9.localEulerAngles

				var_352_17.z = 0
				var_352_17.x = 0
				var_352_9.localEulerAngles = var_352_17
			end

			local var_352_18 = arg_349_1.actors_["10143ui_story"]
			local var_352_19 = 0

			if var_352_19 < arg_349_1.time_ and arg_349_1.time_ <= var_352_19 + arg_352_0 and not isNil(var_352_18) and arg_349_1.var_.characterEffect10143ui_story == nil then
				arg_349_1.var_.characterEffect10143ui_story = var_352_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_20 = 0.200000002980232

			if var_352_19 <= arg_349_1.time_ and arg_349_1.time_ < var_352_19 + var_352_20 and not isNil(var_352_18) then
				local var_352_21 = (arg_349_1.time_ - var_352_19) / var_352_20

				if arg_349_1.var_.characterEffect10143ui_story and not isNil(var_352_18) then
					arg_349_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_19 + var_352_20 and arg_349_1.time_ < var_352_19 + var_352_20 + arg_352_0 and not isNil(var_352_18) and arg_349_1.var_.characterEffect10143ui_story then
				arg_349_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_352_22 = arg_349_1.actors_["10145ui_story"]
			local var_352_23 = 0

			if var_352_23 < arg_349_1.time_ and arg_349_1.time_ <= var_352_23 + arg_352_0 and not isNil(var_352_22) and arg_349_1.var_.characterEffect10145ui_story == nil then
				arg_349_1.var_.characterEffect10145ui_story = var_352_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_24 = 0.200000002980232

			if var_352_23 <= arg_349_1.time_ and arg_349_1.time_ < var_352_23 + var_352_24 and not isNil(var_352_22) then
				local var_352_25 = (arg_349_1.time_ - var_352_23) / var_352_24

				if arg_349_1.var_.characterEffect10145ui_story and not isNil(var_352_22) then
					local var_352_26 = Mathf.Lerp(0, 0.5, var_352_25)

					arg_349_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_349_1.var_.characterEffect10145ui_story.fillRatio = var_352_26
				end
			end

			if arg_349_1.time_ >= var_352_23 + var_352_24 and arg_349_1.time_ < var_352_23 + var_352_24 + arg_352_0 and not isNil(var_352_22) and arg_349_1.var_.characterEffect10145ui_story then
				local var_352_27 = 0.5

				arg_349_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_349_1.var_.characterEffect10145ui_story.fillRatio = var_352_27
			end

			local var_352_28 = 0

			if var_352_28 < arg_349_1.time_ and arg_349_1.time_ <= var_352_28 + arg_352_0 then
				arg_349_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_1")
			end

			local var_352_29 = 0

			if var_352_29 < arg_349_1.time_ and arg_349_1.time_ <= var_352_29 + arg_352_0 then
				arg_349_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_352_30 = 0
			local var_352_31 = 0.975

			if var_352_30 < arg_349_1.time_ and arg_349_1.time_ <= var_352_30 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_32 = arg_349_1:FormatText(StoryNameCfg[1307].name)

				arg_349_1.leftNameTxt_.text = var_352_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_33 = arg_349_1:GetWordFromCfg(421041086)
				local var_352_34 = arg_349_1:FormatText(var_352_33.content)

				arg_349_1.text_.text = var_352_34

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_35 = 39
				local var_352_36 = utf8.len(var_352_34)
				local var_352_37 = var_352_35 <= 0 and var_352_31 or var_352_31 * (var_352_36 / var_352_35)

				if var_352_37 > 0 and var_352_31 < var_352_37 then
					arg_349_1.talkMaxDuration = var_352_37

					if var_352_37 + var_352_30 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_37 + var_352_30
					end
				end

				arg_349_1.text_.text = var_352_34
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041086", "story_v_out_421041.awb") ~= 0 then
					local var_352_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041086", "story_v_out_421041.awb") / 1000

					if var_352_38 + var_352_30 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_38 + var_352_30
					end

					if var_352_33.prefab_name ~= "" and arg_349_1.actors_[var_352_33.prefab_name] ~= nil then
						local var_352_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_33.prefab_name].transform, "story_v_out_421041", "421041086", "story_v_out_421041.awb")

						arg_349_1:RecordAudio("421041086", var_352_39)
						arg_349_1:RecordAudio("421041086", var_352_39)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_421041", "421041086", "story_v_out_421041.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_421041", "421041086", "story_v_out_421041.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_40 = math.max(var_352_31, arg_349_1.talkMaxDuration)

			if var_352_30 <= arg_349_1.time_ and arg_349_1.time_ < var_352_30 + var_352_40 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_30) / var_352_40

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_30 + var_352_40 and arg_349_1.time_ < var_352_30 + var_352_40 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play421041087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 421041087
		arg_353_1.duration_ = 19.4

		local var_353_0 = {
			zh = 15.233,
			ja = 19.4
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
				arg_353_0:Play421041088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 1.625

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_2 = arg_353_1:FormatText(StoryNameCfg[1307].name)

				arg_353_1.leftNameTxt_.text = var_356_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_3 = arg_353_1:GetWordFromCfg(421041087)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 65
				local var_356_6 = utf8.len(var_356_4)
				local var_356_7 = var_356_5 <= 0 and var_356_1 or var_356_1 * (var_356_6 / var_356_5)

				if var_356_7 > 0 and var_356_1 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041087", "story_v_out_421041.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041087", "story_v_out_421041.awb") / 1000

					if var_356_8 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_0
					end

					if var_356_3.prefab_name ~= "" and arg_353_1.actors_[var_356_3.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_3.prefab_name].transform, "story_v_out_421041", "421041087", "story_v_out_421041.awb")

						arg_353_1:RecordAudio("421041087", var_356_9)
						arg_353_1:RecordAudio("421041087", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_421041", "421041087", "story_v_out_421041.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_421041", "421041087", "story_v_out_421041.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_10 and arg_353_1.time_ < var_356_0 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play421041088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 421041088
		arg_357_1.duration_ = 3.9

		local var_357_0 = {
			zh = 3.9,
			ja = 2.866
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
				arg_357_0:Play421041089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["10102ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos10102ui_story = var_360_0.localPosition
			end

			local var_360_2 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2
				local var_360_4 = Vector3.New(0.7, -0.985, -6.275)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10102ui_story, var_360_4, var_360_3)

				local var_360_5 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_5.x, var_360_5.y, var_360_5.z)

				local var_360_6 = var_360_0.localEulerAngles

				var_360_6.z = 0
				var_360_6.x = 0
				var_360_0.localEulerAngles = var_360_6
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_360_7 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_7.x, var_360_7.y, var_360_7.z)

				local var_360_8 = var_360_0.localEulerAngles

				var_360_8.z = 0
				var_360_8.x = 0
				var_360_0.localEulerAngles = var_360_8
			end

			local var_360_9 = arg_357_1.actors_["10145ui_story"].transform
			local var_360_10 = 0

			if var_360_10 < arg_357_1.time_ and arg_357_1.time_ <= var_360_10 + arg_360_0 then
				arg_357_1.var_.moveOldPos10145ui_story = var_360_9.localPosition
			end

			local var_360_11 = 0.001

			if var_360_10 <= arg_357_1.time_ and arg_357_1.time_ < var_360_10 + var_360_11 then
				local var_360_12 = (arg_357_1.time_ - var_360_10) / var_360_11
				local var_360_13 = Vector3.New(0, 100, 0)

				var_360_9.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10145ui_story, var_360_13, var_360_12)

				local var_360_14 = manager.ui.mainCamera.transform.position - var_360_9.position

				var_360_9.forward = Vector3.New(var_360_14.x, var_360_14.y, var_360_14.z)

				local var_360_15 = var_360_9.localEulerAngles

				var_360_15.z = 0
				var_360_15.x = 0
				var_360_9.localEulerAngles = var_360_15
			end

			if arg_357_1.time_ >= var_360_10 + var_360_11 and arg_357_1.time_ < var_360_10 + var_360_11 + arg_360_0 then
				var_360_9.localPosition = Vector3.New(0, 100, 0)

				local var_360_16 = manager.ui.mainCamera.transform.position - var_360_9.position

				var_360_9.forward = Vector3.New(var_360_16.x, var_360_16.y, var_360_16.z)

				local var_360_17 = var_360_9.localEulerAngles

				var_360_17.z = 0
				var_360_17.x = 0
				var_360_9.localEulerAngles = var_360_17
			end

			local var_360_18 = arg_357_1.actors_["10102ui_story"]
			local var_360_19 = 0

			if var_360_19 < arg_357_1.time_ and arg_357_1.time_ <= var_360_19 + arg_360_0 and not isNil(var_360_18) and arg_357_1.var_.characterEffect10102ui_story == nil then
				arg_357_1.var_.characterEffect10102ui_story = var_360_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_20 = 0.200000002980232

			if var_360_19 <= arg_357_1.time_ and arg_357_1.time_ < var_360_19 + var_360_20 and not isNil(var_360_18) then
				local var_360_21 = (arg_357_1.time_ - var_360_19) / var_360_20

				if arg_357_1.var_.characterEffect10102ui_story and not isNil(var_360_18) then
					arg_357_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_19 + var_360_20 and arg_357_1.time_ < var_360_19 + var_360_20 + arg_360_0 and not isNil(var_360_18) and arg_357_1.var_.characterEffect10102ui_story then
				arg_357_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_360_22 = arg_357_1.actors_["10143ui_story"]
			local var_360_23 = 0

			if var_360_23 < arg_357_1.time_ and arg_357_1.time_ <= var_360_23 + arg_360_0 and not isNil(var_360_22) and arg_357_1.var_.characterEffect10143ui_story == nil then
				arg_357_1.var_.characterEffect10143ui_story = var_360_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_24 = 0.200000002980232

			if var_360_23 <= arg_357_1.time_ and arg_357_1.time_ < var_360_23 + var_360_24 and not isNil(var_360_22) then
				local var_360_25 = (arg_357_1.time_ - var_360_23) / var_360_24

				if arg_357_1.var_.characterEffect10143ui_story and not isNil(var_360_22) then
					local var_360_26 = Mathf.Lerp(0, 0.5, var_360_25)

					arg_357_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_357_1.var_.characterEffect10143ui_story.fillRatio = var_360_26
				end
			end

			if arg_357_1.time_ >= var_360_23 + var_360_24 and arg_357_1.time_ < var_360_23 + var_360_24 + arg_360_0 and not isNil(var_360_22) and arg_357_1.var_.characterEffect10143ui_story then
				local var_360_27 = 0.5

				arg_357_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_357_1.var_.characterEffect10143ui_story.fillRatio = var_360_27
			end

			local var_360_28 = 0

			if var_360_28 < arg_357_1.time_ and arg_357_1.time_ <= var_360_28 + arg_360_0 then
				arg_357_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			local var_360_29 = 0

			if var_360_29 < arg_357_1.time_ and arg_357_1.time_ <= var_360_29 + arg_360_0 then
				arg_357_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_360_30 = 0
			local var_360_31 = 0.3

			if var_360_30 < arg_357_1.time_ and arg_357_1.time_ <= var_360_30 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_32 = arg_357_1:FormatText(StoryNameCfg[6].name)

				arg_357_1.leftNameTxt_.text = var_360_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_33 = arg_357_1:GetWordFromCfg(421041088)
				local var_360_34 = arg_357_1:FormatText(var_360_33.content)

				arg_357_1.text_.text = var_360_34

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_35 = 12
				local var_360_36 = utf8.len(var_360_34)
				local var_360_37 = var_360_35 <= 0 and var_360_31 or var_360_31 * (var_360_36 / var_360_35)

				if var_360_37 > 0 and var_360_31 < var_360_37 then
					arg_357_1.talkMaxDuration = var_360_37

					if var_360_37 + var_360_30 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_37 + var_360_30
					end
				end

				arg_357_1.text_.text = var_360_34
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041088", "story_v_out_421041.awb") ~= 0 then
					local var_360_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041088", "story_v_out_421041.awb") / 1000

					if var_360_38 + var_360_30 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_38 + var_360_30
					end

					if var_360_33.prefab_name ~= "" and arg_357_1.actors_[var_360_33.prefab_name] ~= nil then
						local var_360_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_33.prefab_name].transform, "story_v_out_421041", "421041088", "story_v_out_421041.awb")

						arg_357_1:RecordAudio("421041088", var_360_39)
						arg_357_1:RecordAudio("421041088", var_360_39)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_421041", "421041088", "story_v_out_421041.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_421041", "421041088", "story_v_out_421041.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_40 = math.max(var_360_31, arg_357_1.talkMaxDuration)

			if var_360_30 <= arg_357_1.time_ and arg_357_1.time_ < var_360_30 + var_360_40 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_30) / var_360_40

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_30 + var_360_40 and arg_357_1.time_ < var_360_30 + var_360_40 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play421041089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 421041089
		arg_361_1.duration_ = 7.03

		local var_361_0 = {
			zh = 5.533,
			ja = 7.033
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
				arg_361_0:Play421041090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["10143ui_story"].transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.var_.moveOldPos10143ui_story = var_364_0.localPosition
			end

			local var_364_2 = 0.001

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2
				local var_364_4 = Vector3.New(-0.72, -1.06, -6)

				var_364_0.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10143ui_story, var_364_4, var_364_3)

				local var_364_5 = manager.ui.mainCamera.transform.position - var_364_0.position

				var_364_0.forward = Vector3.New(var_364_5.x, var_364_5.y, var_364_5.z)

				local var_364_6 = var_364_0.localEulerAngles

				var_364_6.z = 0
				var_364_6.x = 0
				var_364_0.localEulerAngles = var_364_6
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 then
				var_364_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_364_7 = manager.ui.mainCamera.transform.position - var_364_0.position

				var_364_0.forward = Vector3.New(var_364_7.x, var_364_7.y, var_364_7.z)

				local var_364_8 = var_364_0.localEulerAngles

				var_364_8.z = 0
				var_364_8.x = 0
				var_364_0.localEulerAngles = var_364_8
			end

			local var_364_9 = arg_361_1.actors_["10143ui_story"]
			local var_364_10 = 0

			if var_364_10 < arg_361_1.time_ and arg_361_1.time_ <= var_364_10 + arg_364_0 and not isNil(var_364_9) and arg_361_1.var_.characterEffect10143ui_story == nil then
				arg_361_1.var_.characterEffect10143ui_story = var_364_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_11 = 0.200000002980232

			if var_364_10 <= arg_361_1.time_ and arg_361_1.time_ < var_364_10 + var_364_11 and not isNil(var_364_9) then
				local var_364_12 = (arg_361_1.time_ - var_364_10) / var_364_11

				if arg_361_1.var_.characterEffect10143ui_story and not isNil(var_364_9) then
					arg_361_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= var_364_10 + var_364_11 and arg_361_1.time_ < var_364_10 + var_364_11 + arg_364_0 and not isNil(var_364_9) and arg_361_1.var_.characterEffect10143ui_story then
				arg_361_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_364_13 = arg_361_1.actors_["10102ui_story"]
			local var_364_14 = 0

			if var_364_14 < arg_361_1.time_ and arg_361_1.time_ <= var_364_14 + arg_364_0 and not isNil(var_364_13) and arg_361_1.var_.characterEffect10102ui_story == nil then
				arg_361_1.var_.characterEffect10102ui_story = var_364_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_15 = 0.200000002980232

			if var_364_14 <= arg_361_1.time_ and arg_361_1.time_ < var_364_14 + var_364_15 and not isNil(var_364_13) then
				local var_364_16 = (arg_361_1.time_ - var_364_14) / var_364_15

				if arg_361_1.var_.characterEffect10102ui_story and not isNil(var_364_13) then
					local var_364_17 = Mathf.Lerp(0, 0.5, var_364_16)

					arg_361_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_361_1.var_.characterEffect10102ui_story.fillRatio = var_364_17
				end
			end

			if arg_361_1.time_ >= var_364_14 + var_364_15 and arg_361_1.time_ < var_364_14 + var_364_15 + arg_364_0 and not isNil(var_364_13) and arg_361_1.var_.characterEffect10102ui_story then
				local var_364_18 = 0.5

				arg_361_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_361_1.var_.characterEffect10102ui_story.fillRatio = var_364_18
			end

			local var_364_19 = 0

			if var_364_19 < arg_361_1.time_ and arg_361_1.time_ <= var_364_19 + arg_364_0 then
				arg_361_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_2")
			end

			local var_364_20 = 0

			if var_364_20 < arg_361_1.time_ and arg_361_1.time_ <= var_364_20 + arg_364_0 then
				arg_361_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_364_21 = 0
			local var_364_22 = 0.725

			if var_364_21 < arg_361_1.time_ and arg_361_1.time_ <= var_364_21 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_23 = arg_361_1:FormatText(StoryNameCfg[1307].name)

				arg_361_1.leftNameTxt_.text = var_364_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_24 = arg_361_1:GetWordFromCfg(421041089)
				local var_364_25 = arg_361_1:FormatText(var_364_24.content)

				arg_361_1.text_.text = var_364_25

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_26 = 29
				local var_364_27 = utf8.len(var_364_25)
				local var_364_28 = var_364_26 <= 0 and var_364_22 or var_364_22 * (var_364_27 / var_364_26)

				if var_364_28 > 0 and var_364_22 < var_364_28 then
					arg_361_1.talkMaxDuration = var_364_28

					if var_364_28 + var_364_21 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_28 + var_364_21
					end
				end

				arg_361_1.text_.text = var_364_25
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041089", "story_v_out_421041.awb") ~= 0 then
					local var_364_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041089", "story_v_out_421041.awb") / 1000

					if var_364_29 + var_364_21 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_29 + var_364_21
					end

					if var_364_24.prefab_name ~= "" and arg_361_1.actors_[var_364_24.prefab_name] ~= nil then
						local var_364_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_24.prefab_name].transform, "story_v_out_421041", "421041089", "story_v_out_421041.awb")

						arg_361_1:RecordAudio("421041089", var_364_30)
						arg_361_1:RecordAudio("421041089", var_364_30)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_421041", "421041089", "story_v_out_421041.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_421041", "421041089", "story_v_out_421041.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_31 = math.max(var_364_22, arg_361_1.talkMaxDuration)

			if var_364_21 <= arg_361_1.time_ and arg_361_1.time_ < var_364_21 + var_364_31 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_21) / var_364_31

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_21 + var_364_31 and arg_361_1.time_ < var_364_21 + var_364_31 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play421041090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 421041090
		arg_365_1.duration_ = 16.87

		local var_365_0 = {
			zh = 9.633,
			ja = 16.866
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
				arg_365_0:Play421041091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 1.25

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[1307].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_3 = arg_365_1:GetWordFromCfg(421041090)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 50
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041090", "story_v_out_421041.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041090", "story_v_out_421041.awb") / 1000

					if var_368_8 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_0
					end

					if var_368_3.prefab_name ~= "" and arg_365_1.actors_[var_368_3.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_3.prefab_name].transform, "story_v_out_421041", "421041090", "story_v_out_421041.awb")

						arg_365_1:RecordAudio("421041090", var_368_9)
						arg_365_1:RecordAudio("421041090", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_421041", "421041090", "story_v_out_421041.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_421041", "421041090", "story_v_out_421041.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_10 and arg_365_1.time_ < var_368_0 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play421041091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 421041091
		arg_369_1.duration_ = 5.67

		local var_369_0 = {
			zh = 3.8,
			ja = 5.666
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
				arg_369_0:Play421041092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["10102ui_story"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos10102ui_story = var_372_0.localPosition
			end

			local var_372_2 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2
				local var_372_4 = Vector3.New(0.7, -0.985, -6.275)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10102ui_story, var_372_4, var_372_3)

				local var_372_5 = manager.ui.mainCamera.transform.position - var_372_0.position

				var_372_0.forward = Vector3.New(var_372_5.x, var_372_5.y, var_372_5.z)

				local var_372_6 = var_372_0.localEulerAngles

				var_372_6.z = 0
				var_372_6.x = 0
				var_372_0.localEulerAngles = var_372_6
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(0.7, -0.985, -6.275)

				local var_372_7 = manager.ui.mainCamera.transform.position - var_372_0.position

				var_372_0.forward = Vector3.New(var_372_7.x, var_372_7.y, var_372_7.z)

				local var_372_8 = var_372_0.localEulerAngles

				var_372_8.z = 0
				var_372_8.x = 0
				var_372_0.localEulerAngles = var_372_8
			end

			local var_372_9 = arg_369_1.actors_["10102ui_story"]
			local var_372_10 = 0

			if var_372_10 < arg_369_1.time_ and arg_369_1.time_ <= var_372_10 + arg_372_0 and not isNil(var_372_9) and arg_369_1.var_.characterEffect10102ui_story == nil then
				arg_369_1.var_.characterEffect10102ui_story = var_372_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_11 = 0.200000002980232

			if var_372_10 <= arg_369_1.time_ and arg_369_1.time_ < var_372_10 + var_372_11 and not isNil(var_372_9) then
				local var_372_12 = (arg_369_1.time_ - var_372_10) / var_372_11

				if arg_369_1.var_.characterEffect10102ui_story and not isNil(var_372_9) then
					arg_369_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= var_372_10 + var_372_11 and arg_369_1.time_ < var_372_10 + var_372_11 + arg_372_0 and not isNil(var_372_9) and arg_369_1.var_.characterEffect10102ui_story then
				arg_369_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_372_13 = arg_369_1.actors_["10143ui_story"]
			local var_372_14 = 0

			if var_372_14 < arg_369_1.time_ and arg_369_1.time_ <= var_372_14 + arg_372_0 and not isNil(var_372_13) and arg_369_1.var_.characterEffect10143ui_story == nil then
				arg_369_1.var_.characterEffect10143ui_story = var_372_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_15 = 0.200000002980232

			if var_372_14 <= arg_369_1.time_ and arg_369_1.time_ < var_372_14 + var_372_15 and not isNil(var_372_13) then
				local var_372_16 = (arg_369_1.time_ - var_372_14) / var_372_15

				if arg_369_1.var_.characterEffect10143ui_story and not isNil(var_372_13) then
					local var_372_17 = Mathf.Lerp(0, 0.5, var_372_16)

					arg_369_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_369_1.var_.characterEffect10143ui_story.fillRatio = var_372_17
				end
			end

			if arg_369_1.time_ >= var_372_14 + var_372_15 and arg_369_1.time_ < var_372_14 + var_372_15 + arg_372_0 and not isNil(var_372_13) and arg_369_1.var_.characterEffect10143ui_story then
				local var_372_18 = 0.5

				arg_369_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_369_1.var_.characterEffect10143ui_story.fillRatio = var_372_18
			end

			local var_372_19 = 0

			if var_372_19 < arg_369_1.time_ and arg_369_1.time_ <= var_372_19 + arg_372_0 then
				arg_369_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			local var_372_20 = 0

			if var_372_20 < arg_369_1.time_ and arg_369_1.time_ <= var_372_20 + arg_372_0 then
				arg_369_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_372_21 = 0
			local var_372_22 = 0.525

			if var_372_21 < arg_369_1.time_ and arg_369_1.time_ <= var_372_21 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_23 = arg_369_1:FormatText(StoryNameCfg[6].name)

				arg_369_1.leftNameTxt_.text = var_372_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_24 = arg_369_1:GetWordFromCfg(421041091)
				local var_372_25 = arg_369_1:FormatText(var_372_24.content)

				arg_369_1.text_.text = var_372_25

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_26 = 21
				local var_372_27 = utf8.len(var_372_25)
				local var_372_28 = var_372_26 <= 0 and var_372_22 or var_372_22 * (var_372_27 / var_372_26)

				if var_372_28 > 0 and var_372_22 < var_372_28 then
					arg_369_1.talkMaxDuration = var_372_28

					if var_372_28 + var_372_21 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_28 + var_372_21
					end
				end

				arg_369_1.text_.text = var_372_25
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041091", "story_v_out_421041.awb") ~= 0 then
					local var_372_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041091", "story_v_out_421041.awb") / 1000

					if var_372_29 + var_372_21 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_29 + var_372_21
					end

					if var_372_24.prefab_name ~= "" and arg_369_1.actors_[var_372_24.prefab_name] ~= nil then
						local var_372_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_24.prefab_name].transform, "story_v_out_421041", "421041091", "story_v_out_421041.awb")

						arg_369_1:RecordAudio("421041091", var_372_30)
						arg_369_1:RecordAudio("421041091", var_372_30)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_421041", "421041091", "story_v_out_421041.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_421041", "421041091", "story_v_out_421041.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_31 = math.max(var_372_22, arg_369_1.talkMaxDuration)

			if var_372_21 <= arg_369_1.time_ and arg_369_1.time_ < var_372_21 + var_372_31 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_21) / var_372_31

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_21 + var_372_31 and arg_369_1.time_ < var_372_21 + var_372_31 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play421041092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 421041092
		arg_373_1.duration_ = 14.9

		local var_373_0 = {
			zh = 10.333,
			ja = 14.9
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
				arg_373_0:Play421041093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["10143ui_story"].transform
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.var_.moveOldPos10143ui_story = var_376_0.localPosition
			end

			local var_376_2 = 0.001

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2
				local var_376_4 = Vector3.New(-0.72, -1.06, -6)

				var_376_0.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10143ui_story, var_376_4, var_376_3)

				local var_376_5 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_5.x, var_376_5.y, var_376_5.z)

				local var_376_6 = var_376_0.localEulerAngles

				var_376_6.z = 0
				var_376_6.x = 0
				var_376_0.localEulerAngles = var_376_6
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 then
				var_376_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_376_7 = manager.ui.mainCamera.transform.position - var_376_0.position

				var_376_0.forward = Vector3.New(var_376_7.x, var_376_7.y, var_376_7.z)

				local var_376_8 = var_376_0.localEulerAngles

				var_376_8.z = 0
				var_376_8.x = 0
				var_376_0.localEulerAngles = var_376_8
			end

			local var_376_9 = arg_373_1.actors_["10143ui_story"]
			local var_376_10 = 0

			if var_376_10 < arg_373_1.time_ and arg_373_1.time_ <= var_376_10 + arg_376_0 and not isNil(var_376_9) and arg_373_1.var_.characterEffect10143ui_story == nil then
				arg_373_1.var_.characterEffect10143ui_story = var_376_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_11 = 0.200000002980232

			if var_376_10 <= arg_373_1.time_ and arg_373_1.time_ < var_376_10 + var_376_11 and not isNil(var_376_9) then
				local var_376_12 = (arg_373_1.time_ - var_376_10) / var_376_11

				if arg_373_1.var_.characterEffect10143ui_story and not isNil(var_376_9) then
					arg_373_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= var_376_10 + var_376_11 and arg_373_1.time_ < var_376_10 + var_376_11 + arg_376_0 and not isNil(var_376_9) and arg_373_1.var_.characterEffect10143ui_story then
				arg_373_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_376_13 = arg_373_1.actors_["10102ui_story"]
			local var_376_14 = 0

			if var_376_14 < arg_373_1.time_ and arg_373_1.time_ <= var_376_14 + arg_376_0 and not isNil(var_376_13) and arg_373_1.var_.characterEffect10102ui_story == nil then
				arg_373_1.var_.characterEffect10102ui_story = var_376_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_15 = 0.200000002980232

			if var_376_14 <= arg_373_1.time_ and arg_373_1.time_ < var_376_14 + var_376_15 and not isNil(var_376_13) then
				local var_376_16 = (arg_373_1.time_ - var_376_14) / var_376_15

				if arg_373_1.var_.characterEffect10102ui_story and not isNil(var_376_13) then
					local var_376_17 = Mathf.Lerp(0, 0.5, var_376_16)

					arg_373_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_373_1.var_.characterEffect10102ui_story.fillRatio = var_376_17
				end
			end

			if arg_373_1.time_ >= var_376_14 + var_376_15 and arg_373_1.time_ < var_376_14 + var_376_15 + arg_376_0 and not isNil(var_376_13) and arg_373_1.var_.characterEffect10102ui_story then
				local var_376_18 = 0.5

				arg_373_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_373_1.var_.characterEffect10102ui_story.fillRatio = var_376_18
			end

			local var_376_19 = 0

			if var_376_19 < arg_373_1.time_ and arg_373_1.time_ <= var_376_19 + arg_376_0 then
				arg_373_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action8_1")
			end

			local var_376_20 = 0

			if var_376_20 < arg_373_1.time_ and arg_373_1.time_ <= var_376_20 + arg_376_0 then
				arg_373_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_376_21 = 0
			local var_376_22 = 1.325

			if var_376_21 < arg_373_1.time_ and arg_373_1.time_ <= var_376_21 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_23 = arg_373_1:FormatText(StoryNameCfg[1307].name)

				arg_373_1.leftNameTxt_.text = var_376_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_24 = arg_373_1:GetWordFromCfg(421041092)
				local var_376_25 = arg_373_1:FormatText(var_376_24.content)

				arg_373_1.text_.text = var_376_25

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_26 = 53
				local var_376_27 = utf8.len(var_376_25)
				local var_376_28 = var_376_26 <= 0 and var_376_22 or var_376_22 * (var_376_27 / var_376_26)

				if var_376_28 > 0 and var_376_22 < var_376_28 then
					arg_373_1.talkMaxDuration = var_376_28

					if var_376_28 + var_376_21 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_28 + var_376_21
					end
				end

				arg_373_1.text_.text = var_376_25
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041092", "story_v_out_421041.awb") ~= 0 then
					local var_376_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041092", "story_v_out_421041.awb") / 1000

					if var_376_29 + var_376_21 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_29 + var_376_21
					end

					if var_376_24.prefab_name ~= "" and arg_373_1.actors_[var_376_24.prefab_name] ~= nil then
						local var_376_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_24.prefab_name].transform, "story_v_out_421041", "421041092", "story_v_out_421041.awb")

						arg_373_1:RecordAudio("421041092", var_376_30)
						arg_373_1:RecordAudio("421041092", var_376_30)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_421041", "421041092", "story_v_out_421041.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_421041", "421041092", "story_v_out_421041.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_31 = math.max(var_376_22, arg_373_1.talkMaxDuration)

			if var_376_21 <= arg_373_1.time_ and arg_373_1.time_ < var_376_21 + var_376_31 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_21) / var_376_31

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_21 + var_376_31 and arg_373_1.time_ < var_376_21 + var_376_31 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play421041093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 421041093
		arg_377_1.duration_ = 8.7

		local var_377_0 = {
			zh = 6.866,
			ja = 8.7
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
				arg_377_0:Play421041094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["10143ui_story"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos10143ui_story = var_380_0.localPosition
			end

			local var_380_2 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2
				local var_380_4 = Vector3.New(-0.72, -1.06, -6)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10143ui_story, var_380_4, var_380_3)

				local var_380_5 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_5.x, var_380_5.y, var_380_5.z)

				local var_380_6 = var_380_0.localEulerAngles

				var_380_6.z = 0
				var_380_6.x = 0
				var_380_0.localEulerAngles = var_380_6
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_380_7 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_7.x, var_380_7.y, var_380_7.z)

				local var_380_8 = var_380_0.localEulerAngles

				var_380_8.z = 0
				var_380_8.x = 0
				var_380_0.localEulerAngles = var_380_8
			end

			local var_380_9 = 0

			if var_380_9 < arg_377_1.time_ and arg_377_1.time_ <= var_380_9 + arg_380_0 then
				arg_377_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action8_2")
			end

			local var_380_10 = 0

			if var_380_10 < arg_377_1.time_ and arg_377_1.time_ <= var_380_10 + arg_380_0 then
				arg_377_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_380_11 = 0
			local var_380_12 = 0.85

			if var_380_11 < arg_377_1.time_ and arg_377_1.time_ <= var_380_11 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_13 = arg_377_1:FormatText(StoryNameCfg[1307].name)

				arg_377_1.leftNameTxt_.text = var_380_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_14 = arg_377_1:GetWordFromCfg(421041093)
				local var_380_15 = arg_377_1:FormatText(var_380_14.content)

				arg_377_1.text_.text = var_380_15

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_16 = 34
				local var_380_17 = utf8.len(var_380_15)
				local var_380_18 = var_380_16 <= 0 and var_380_12 or var_380_12 * (var_380_17 / var_380_16)

				if var_380_18 > 0 and var_380_12 < var_380_18 then
					arg_377_1.talkMaxDuration = var_380_18

					if var_380_18 + var_380_11 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_18 + var_380_11
					end
				end

				arg_377_1.text_.text = var_380_15
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041093", "story_v_out_421041.awb") ~= 0 then
					local var_380_19 = manager.audio:GetVoiceLength("story_v_out_421041", "421041093", "story_v_out_421041.awb") / 1000

					if var_380_19 + var_380_11 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_19 + var_380_11
					end

					if var_380_14.prefab_name ~= "" and arg_377_1.actors_[var_380_14.prefab_name] ~= nil then
						local var_380_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_14.prefab_name].transform, "story_v_out_421041", "421041093", "story_v_out_421041.awb")

						arg_377_1:RecordAudio("421041093", var_380_20)
						arg_377_1:RecordAudio("421041093", var_380_20)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_421041", "421041093", "story_v_out_421041.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_421041", "421041093", "story_v_out_421041.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_21 = math.max(var_380_12, arg_377_1.talkMaxDuration)

			if var_380_11 <= arg_377_1.time_ and arg_377_1.time_ < var_380_11 + var_380_21 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_11) / var_380_21

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_11 + var_380_21 and arg_377_1.time_ < var_380_11 + var_380_21 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play421041094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 421041094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play421041095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["10102ui_story"].transform
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.var_.moveOldPos10102ui_story = var_384_0.localPosition
			end

			local var_384_2 = 0.001

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2
				local var_384_4 = Vector3.New(0, 100, 0)

				var_384_0.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10102ui_story, var_384_4, var_384_3)

				local var_384_5 = manager.ui.mainCamera.transform.position - var_384_0.position

				var_384_0.forward = Vector3.New(var_384_5.x, var_384_5.y, var_384_5.z)

				local var_384_6 = var_384_0.localEulerAngles

				var_384_6.z = 0
				var_384_6.x = 0
				var_384_0.localEulerAngles = var_384_6
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 then
				var_384_0.localPosition = Vector3.New(0, 100, 0)

				local var_384_7 = manager.ui.mainCamera.transform.position - var_384_0.position

				var_384_0.forward = Vector3.New(var_384_7.x, var_384_7.y, var_384_7.z)

				local var_384_8 = var_384_0.localEulerAngles

				var_384_8.z = 0
				var_384_8.x = 0
				var_384_0.localEulerAngles = var_384_8
			end

			local var_384_9 = arg_381_1.actors_["10143ui_story"].transform
			local var_384_10 = 0

			if var_384_10 < arg_381_1.time_ and arg_381_1.time_ <= var_384_10 + arg_384_0 then
				arg_381_1.var_.moveOldPos10143ui_story = var_384_9.localPosition
			end

			local var_384_11 = 0.001

			if var_384_10 <= arg_381_1.time_ and arg_381_1.time_ < var_384_10 + var_384_11 then
				local var_384_12 = (arg_381_1.time_ - var_384_10) / var_384_11
				local var_384_13 = Vector3.New(0, 100, 0)

				var_384_9.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10143ui_story, var_384_13, var_384_12)

				local var_384_14 = manager.ui.mainCamera.transform.position - var_384_9.position

				var_384_9.forward = Vector3.New(var_384_14.x, var_384_14.y, var_384_14.z)

				local var_384_15 = var_384_9.localEulerAngles

				var_384_15.z = 0
				var_384_15.x = 0
				var_384_9.localEulerAngles = var_384_15
			end

			if arg_381_1.time_ >= var_384_10 + var_384_11 and arg_381_1.time_ < var_384_10 + var_384_11 + arg_384_0 then
				var_384_9.localPosition = Vector3.New(0, 100, 0)

				local var_384_16 = manager.ui.mainCamera.transform.position - var_384_9.position

				var_384_9.forward = Vector3.New(var_384_16.x, var_384_16.y, var_384_16.z)

				local var_384_17 = var_384_9.localEulerAngles

				var_384_17.z = 0
				var_384_17.x = 0
				var_384_9.localEulerAngles = var_384_17
			end

			local var_384_18 = 0.1
			local var_384_19 = 1

			if var_384_18 < arg_381_1.time_ and arg_381_1.time_ <= var_384_18 + arg_384_0 then
				local var_384_20 = "play"
				local var_384_21 = "effect"

				arg_381_1:AudioAction(var_384_20, var_384_21, "se_story_1310", "se_story_1310_tea", "")
			end

			local var_384_22 = 0
			local var_384_23 = 1.625

			if var_384_22 < arg_381_1.time_ and arg_381_1.time_ <= var_384_22 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_24 = arg_381_1:GetWordFromCfg(421041094)
				local var_384_25 = arg_381_1:FormatText(var_384_24.content)

				arg_381_1.text_.text = var_384_25

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_26 = 65
				local var_384_27 = utf8.len(var_384_25)
				local var_384_28 = var_384_26 <= 0 and var_384_23 or var_384_23 * (var_384_27 / var_384_26)

				if var_384_28 > 0 and var_384_23 < var_384_28 then
					arg_381_1.talkMaxDuration = var_384_28

					if var_384_28 + var_384_22 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_28 + var_384_22
					end
				end

				arg_381_1.text_.text = var_384_25
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_29 = math.max(var_384_23, arg_381_1.talkMaxDuration)

			if var_384_22 <= arg_381_1.time_ and arg_381_1.time_ < var_384_22 + var_384_29 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_22) / var_384_29

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_22 + var_384_29 and arg_381_1.time_ < var_384_22 + var_384_29 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play421041095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 421041095
		arg_385_1.duration_ = 3.8

		local var_385_0 = {
			zh = 2.866,
			ja = 3.8
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
				arg_385_0:Play421041096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["10102ui_story"].transform
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.var_.moveOldPos10102ui_story = var_388_0.localPosition
			end

			local var_388_2 = 0.001

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2
				local var_388_4 = Vector3.New(0, -0.985, -6.275)

				var_388_0.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10102ui_story, var_388_4, var_388_3)

				local var_388_5 = manager.ui.mainCamera.transform.position - var_388_0.position

				var_388_0.forward = Vector3.New(var_388_5.x, var_388_5.y, var_388_5.z)

				local var_388_6 = var_388_0.localEulerAngles

				var_388_6.z = 0
				var_388_6.x = 0
				var_388_0.localEulerAngles = var_388_6
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 then
				var_388_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_388_7 = manager.ui.mainCamera.transform.position - var_388_0.position

				var_388_0.forward = Vector3.New(var_388_7.x, var_388_7.y, var_388_7.z)

				local var_388_8 = var_388_0.localEulerAngles

				var_388_8.z = 0
				var_388_8.x = 0
				var_388_0.localEulerAngles = var_388_8
			end

			local var_388_9 = arg_385_1.actors_["10102ui_story"]
			local var_388_10 = 0

			if var_388_10 < arg_385_1.time_ and arg_385_1.time_ <= var_388_10 + arg_388_0 and not isNil(var_388_9) and arg_385_1.var_.characterEffect10102ui_story == nil then
				arg_385_1.var_.characterEffect10102ui_story = var_388_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_11 = 0.200000002980232

			if var_388_10 <= arg_385_1.time_ and arg_385_1.time_ < var_388_10 + var_388_11 and not isNil(var_388_9) then
				local var_388_12 = (arg_385_1.time_ - var_388_10) / var_388_11

				if arg_385_1.var_.characterEffect10102ui_story and not isNil(var_388_9) then
					arg_385_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_10 + var_388_11 and arg_385_1.time_ < var_388_10 + var_388_11 + arg_388_0 and not isNil(var_388_9) and arg_385_1.var_.characterEffect10102ui_story then
				arg_385_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_388_13 = 0

			if var_388_13 < arg_385_1.time_ and arg_385_1.time_ <= var_388_13 + arg_388_0 then
				arg_385_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			local var_388_14 = 0

			if var_388_14 < arg_385_1.time_ and arg_385_1.time_ <= var_388_14 + arg_388_0 then
				arg_385_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_388_15 = 0
			local var_388_16 = 0.225

			if var_388_15 < arg_385_1.time_ and arg_385_1.time_ <= var_388_15 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_17 = arg_385_1:FormatText(StoryNameCfg[6].name)

				arg_385_1.leftNameTxt_.text = var_388_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_18 = arg_385_1:GetWordFromCfg(421041095)
				local var_388_19 = arg_385_1:FormatText(var_388_18.content)

				arg_385_1.text_.text = var_388_19

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_20 = 9
				local var_388_21 = utf8.len(var_388_19)
				local var_388_22 = var_388_20 <= 0 and var_388_16 or var_388_16 * (var_388_21 / var_388_20)

				if var_388_22 > 0 and var_388_16 < var_388_22 then
					arg_385_1.talkMaxDuration = var_388_22

					if var_388_22 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_22 + var_388_15
					end
				end

				arg_385_1.text_.text = var_388_19
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041095", "story_v_out_421041.awb") ~= 0 then
					local var_388_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041095", "story_v_out_421041.awb") / 1000

					if var_388_23 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_23 + var_388_15
					end

					if var_388_18.prefab_name ~= "" and arg_385_1.actors_[var_388_18.prefab_name] ~= nil then
						local var_388_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_18.prefab_name].transform, "story_v_out_421041", "421041095", "story_v_out_421041.awb")

						arg_385_1:RecordAudio("421041095", var_388_24)
						arg_385_1:RecordAudio("421041095", var_388_24)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_421041", "421041095", "story_v_out_421041.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_421041", "421041095", "story_v_out_421041.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_25 = math.max(var_388_16, arg_385_1.talkMaxDuration)

			if var_388_15 <= arg_385_1.time_ and arg_385_1.time_ < var_388_15 + var_388_25 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_15) / var_388_25

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_15 + var_388_25 and arg_385_1.time_ < var_388_15 + var_388_25 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play421041096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 421041096
		arg_389_1.duration_ = 15.13

		local var_389_0 = {
			zh = 10.033,
			ja = 15.133
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play421041097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["10102ui_story"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos10102ui_story = var_392_0.localPosition
			end

			local var_392_2 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2
				local var_392_4 = Vector3.New(0, 100, 0)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10102ui_story, var_392_4, var_392_3)

				local var_392_5 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_5.x, var_392_5.y, var_392_5.z)

				local var_392_6 = var_392_0.localEulerAngles

				var_392_6.z = 0
				var_392_6.x = 0
				var_392_0.localEulerAngles = var_392_6
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(0, 100, 0)

				local var_392_7 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_7.x, var_392_7.y, var_392_7.z)

				local var_392_8 = var_392_0.localEulerAngles

				var_392_8.z = 0
				var_392_8.x = 0
				var_392_0.localEulerAngles = var_392_8
			end

			local var_392_9 = arg_389_1.actors_["10143ui_story"].transform
			local var_392_10 = 0

			if var_392_10 < arg_389_1.time_ and arg_389_1.time_ <= var_392_10 + arg_392_0 then
				arg_389_1.var_.moveOldPos10143ui_story = var_392_9.localPosition
			end

			local var_392_11 = 0.001

			if var_392_10 <= arg_389_1.time_ and arg_389_1.time_ < var_392_10 + var_392_11 then
				local var_392_12 = (arg_389_1.time_ - var_392_10) / var_392_11
				local var_392_13 = Vector3.New(0, -1.06, -6)

				var_392_9.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10143ui_story, var_392_13, var_392_12)

				local var_392_14 = manager.ui.mainCamera.transform.position - var_392_9.position

				var_392_9.forward = Vector3.New(var_392_14.x, var_392_14.y, var_392_14.z)

				local var_392_15 = var_392_9.localEulerAngles

				var_392_15.z = 0
				var_392_15.x = 0
				var_392_9.localEulerAngles = var_392_15
			end

			if arg_389_1.time_ >= var_392_10 + var_392_11 and arg_389_1.time_ < var_392_10 + var_392_11 + arg_392_0 then
				var_392_9.localPosition = Vector3.New(0, -1.06, -6)

				local var_392_16 = manager.ui.mainCamera.transform.position - var_392_9.position

				var_392_9.forward = Vector3.New(var_392_16.x, var_392_16.y, var_392_16.z)

				local var_392_17 = var_392_9.localEulerAngles

				var_392_17.z = 0
				var_392_17.x = 0
				var_392_9.localEulerAngles = var_392_17
			end

			local var_392_18 = arg_389_1.actors_["10143ui_story"]
			local var_392_19 = 0

			if var_392_19 < arg_389_1.time_ and arg_389_1.time_ <= var_392_19 + arg_392_0 and not isNil(var_392_18) and arg_389_1.var_.characterEffect10143ui_story == nil then
				arg_389_1.var_.characterEffect10143ui_story = var_392_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_20 = 0.200000002980232

			if var_392_19 <= arg_389_1.time_ and arg_389_1.time_ < var_392_19 + var_392_20 and not isNil(var_392_18) then
				local var_392_21 = (arg_389_1.time_ - var_392_19) / var_392_20

				if arg_389_1.var_.characterEffect10143ui_story and not isNil(var_392_18) then
					arg_389_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= var_392_19 + var_392_20 and arg_389_1.time_ < var_392_19 + var_392_20 + arg_392_0 and not isNil(var_392_18) and arg_389_1.var_.characterEffect10143ui_story then
				arg_389_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_392_22 = arg_389_1.actors_["10102ui_story"]
			local var_392_23 = 0

			if var_392_23 < arg_389_1.time_ and arg_389_1.time_ <= var_392_23 + arg_392_0 and not isNil(var_392_22) and arg_389_1.var_.characterEffect10102ui_story == nil then
				arg_389_1.var_.characterEffect10102ui_story = var_392_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_24 = 0.200000002980232

			if var_392_23 <= arg_389_1.time_ and arg_389_1.time_ < var_392_23 + var_392_24 and not isNil(var_392_22) then
				local var_392_25 = (arg_389_1.time_ - var_392_23) / var_392_24

				if arg_389_1.var_.characterEffect10102ui_story and not isNil(var_392_22) then
					local var_392_26 = Mathf.Lerp(0, 0.5, var_392_25)

					arg_389_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_389_1.var_.characterEffect10102ui_story.fillRatio = var_392_26
				end
			end

			if arg_389_1.time_ >= var_392_23 + var_392_24 and arg_389_1.time_ < var_392_23 + var_392_24 + arg_392_0 and not isNil(var_392_22) and arg_389_1.var_.characterEffect10102ui_story then
				local var_392_27 = 0.5

				arg_389_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_389_1.var_.characterEffect10102ui_story.fillRatio = var_392_27
			end

			local var_392_28 = 0

			if var_392_28 < arg_389_1.time_ and arg_389_1.time_ <= var_392_28 + arg_392_0 then
				arg_389_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_392_29 = 0

			if var_392_29 < arg_389_1.time_ and arg_389_1.time_ <= var_392_29 + arg_392_0 then
				arg_389_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_392_30 = 0
			local var_392_31 = 1.225

			if var_392_30 < arg_389_1.time_ and arg_389_1.time_ <= var_392_30 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_32 = arg_389_1:FormatText(StoryNameCfg[1307].name)

				arg_389_1.leftNameTxt_.text = var_392_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_33 = arg_389_1:GetWordFromCfg(421041096)
				local var_392_34 = arg_389_1:FormatText(var_392_33.content)

				arg_389_1.text_.text = var_392_34

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_35 = 49
				local var_392_36 = utf8.len(var_392_34)
				local var_392_37 = var_392_35 <= 0 and var_392_31 or var_392_31 * (var_392_36 / var_392_35)

				if var_392_37 > 0 and var_392_31 < var_392_37 then
					arg_389_1.talkMaxDuration = var_392_37

					if var_392_37 + var_392_30 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_37 + var_392_30
					end
				end

				arg_389_1.text_.text = var_392_34
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041096", "story_v_out_421041.awb") ~= 0 then
					local var_392_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041096", "story_v_out_421041.awb") / 1000

					if var_392_38 + var_392_30 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_38 + var_392_30
					end

					if var_392_33.prefab_name ~= "" and arg_389_1.actors_[var_392_33.prefab_name] ~= nil then
						local var_392_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_33.prefab_name].transform, "story_v_out_421041", "421041096", "story_v_out_421041.awb")

						arg_389_1:RecordAudio("421041096", var_392_39)
						arg_389_1:RecordAudio("421041096", var_392_39)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_421041", "421041096", "story_v_out_421041.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_421041", "421041096", "story_v_out_421041.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_40 = math.max(var_392_31, arg_389_1.talkMaxDuration)

			if var_392_30 <= arg_389_1.time_ and arg_389_1.time_ < var_392_30 + var_392_40 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_30) / var_392_40

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_30 + var_392_40 and arg_389_1.time_ < var_392_30 + var_392_40 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play421041097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 421041097
		arg_393_1.duration_ = 19.83

		local var_393_0 = {
			zh = 14.766,
			ja = 19.833
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
				arg_393_0:Play421041098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["10143ui_story"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos10143ui_story = var_396_0.localPosition
			end

			local var_396_2 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2
				local var_396_4 = Vector3.New(0, -1.06, -6)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos10143ui_story, var_396_4, var_396_3)

				local var_396_5 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_5.x, var_396_5.y, var_396_5.z)

				local var_396_6 = var_396_0.localEulerAngles

				var_396_6.z = 0
				var_396_6.x = 0
				var_396_0.localEulerAngles = var_396_6
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(0, -1.06, -6)

				local var_396_7 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_7.x, var_396_7.y, var_396_7.z)

				local var_396_8 = var_396_0.localEulerAngles

				var_396_8.z = 0
				var_396_8.x = 0
				var_396_0.localEulerAngles = var_396_8
			end

			local var_396_9 = 0

			if var_396_9 < arg_393_1.time_ and arg_393_1.time_ <= var_396_9 + arg_396_0 then
				arg_393_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_396_10 = 0

			if var_396_10 < arg_393_1.time_ and arg_393_1.time_ <= var_396_10 + arg_396_0 then
				arg_393_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_396_11 = 0
			local var_396_12 = 1.85

			if var_396_11 < arg_393_1.time_ and arg_393_1.time_ <= var_396_11 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_13 = arg_393_1:FormatText(StoryNameCfg[1307].name)

				arg_393_1.leftNameTxt_.text = var_396_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_14 = arg_393_1:GetWordFromCfg(421041097)
				local var_396_15 = arg_393_1:FormatText(var_396_14.content)

				arg_393_1.text_.text = var_396_15

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_16 = 74
				local var_396_17 = utf8.len(var_396_15)
				local var_396_18 = var_396_16 <= 0 and var_396_12 or var_396_12 * (var_396_17 / var_396_16)

				if var_396_18 > 0 and var_396_12 < var_396_18 then
					arg_393_1.talkMaxDuration = var_396_18

					if var_396_18 + var_396_11 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_18 + var_396_11
					end
				end

				arg_393_1.text_.text = var_396_15
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041097", "story_v_out_421041.awb") ~= 0 then
					local var_396_19 = manager.audio:GetVoiceLength("story_v_out_421041", "421041097", "story_v_out_421041.awb") / 1000

					if var_396_19 + var_396_11 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_19 + var_396_11
					end

					if var_396_14.prefab_name ~= "" and arg_393_1.actors_[var_396_14.prefab_name] ~= nil then
						local var_396_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_14.prefab_name].transform, "story_v_out_421041", "421041097", "story_v_out_421041.awb")

						arg_393_1:RecordAudio("421041097", var_396_20)
						arg_393_1:RecordAudio("421041097", var_396_20)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_421041", "421041097", "story_v_out_421041.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_421041", "421041097", "story_v_out_421041.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_21 = math.max(var_396_12, arg_393_1.talkMaxDuration)

			if var_396_11 <= arg_393_1.time_ and arg_393_1.time_ < var_396_11 + var_396_21 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_11) / var_396_21

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_11 + var_396_21 and arg_393_1.time_ < var_396_11 + var_396_21 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play421041098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 421041098
		arg_397_1.duration_ = 2

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play421041099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["10145ui_story"].transform
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.var_.moveOldPos10145ui_story = var_400_0.localPosition
			end

			local var_400_2 = 0.001

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2
				local var_400_4 = Vector3.New(0.78, -1, -6.2)

				var_400_0.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10145ui_story, var_400_4, var_400_3)

				local var_400_5 = manager.ui.mainCamera.transform.position - var_400_0.position

				var_400_0.forward = Vector3.New(var_400_5.x, var_400_5.y, var_400_5.z)

				local var_400_6 = var_400_0.localEulerAngles

				var_400_6.z = 0
				var_400_6.x = 0
				var_400_0.localEulerAngles = var_400_6
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 then
				var_400_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_400_7 = manager.ui.mainCamera.transform.position - var_400_0.position

				var_400_0.forward = Vector3.New(var_400_7.x, var_400_7.y, var_400_7.z)

				local var_400_8 = var_400_0.localEulerAngles

				var_400_8.z = 0
				var_400_8.x = 0
				var_400_0.localEulerAngles = var_400_8
			end

			local var_400_9 = arg_397_1.actors_["10143ui_story"].transform
			local var_400_10 = 0

			if var_400_10 < arg_397_1.time_ and arg_397_1.time_ <= var_400_10 + arg_400_0 then
				arg_397_1.var_.moveOldPos10143ui_story = var_400_9.localPosition
			end

			local var_400_11 = 0.001

			if var_400_10 <= arg_397_1.time_ and arg_397_1.time_ < var_400_10 + var_400_11 then
				local var_400_12 = (arg_397_1.time_ - var_400_10) / var_400_11
				local var_400_13 = Vector3.New(-0.72, -1.06, -6)

				var_400_9.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10143ui_story, var_400_13, var_400_12)

				local var_400_14 = manager.ui.mainCamera.transform.position - var_400_9.position

				var_400_9.forward = Vector3.New(var_400_14.x, var_400_14.y, var_400_14.z)

				local var_400_15 = var_400_9.localEulerAngles

				var_400_15.z = 0
				var_400_15.x = 0
				var_400_9.localEulerAngles = var_400_15
			end

			if arg_397_1.time_ >= var_400_10 + var_400_11 and arg_397_1.time_ < var_400_10 + var_400_11 + arg_400_0 then
				var_400_9.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_400_16 = manager.ui.mainCamera.transform.position - var_400_9.position

				var_400_9.forward = Vector3.New(var_400_16.x, var_400_16.y, var_400_16.z)

				local var_400_17 = var_400_9.localEulerAngles

				var_400_17.z = 0
				var_400_17.x = 0
				var_400_9.localEulerAngles = var_400_17
			end

			local var_400_18 = arg_397_1.actors_["10145ui_story"]
			local var_400_19 = 0

			if var_400_19 < arg_397_1.time_ and arg_397_1.time_ <= var_400_19 + arg_400_0 and not isNil(var_400_18) and arg_397_1.var_.characterEffect10145ui_story == nil then
				arg_397_1.var_.characterEffect10145ui_story = var_400_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_20 = 0.200000002980232

			if var_400_19 <= arg_397_1.time_ and arg_397_1.time_ < var_400_19 + var_400_20 and not isNil(var_400_18) then
				local var_400_21 = (arg_397_1.time_ - var_400_19) / var_400_20

				if arg_397_1.var_.characterEffect10145ui_story and not isNil(var_400_18) then
					arg_397_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_19 + var_400_20 and arg_397_1.time_ < var_400_19 + var_400_20 + arg_400_0 and not isNil(var_400_18) and arg_397_1.var_.characterEffect10145ui_story then
				arg_397_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_400_22 = arg_397_1.actors_["10143ui_story"]
			local var_400_23 = 0

			if var_400_23 < arg_397_1.time_ and arg_397_1.time_ <= var_400_23 + arg_400_0 and not isNil(var_400_22) and arg_397_1.var_.characterEffect10143ui_story == nil then
				arg_397_1.var_.characterEffect10143ui_story = var_400_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_24 = 0.200000002980232

			if var_400_23 <= arg_397_1.time_ and arg_397_1.time_ < var_400_23 + var_400_24 and not isNil(var_400_22) then
				local var_400_25 = (arg_397_1.time_ - var_400_23) / var_400_24

				if arg_397_1.var_.characterEffect10143ui_story and not isNil(var_400_22) then
					local var_400_26 = Mathf.Lerp(0, 0.5, var_400_25)

					arg_397_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_397_1.var_.characterEffect10143ui_story.fillRatio = var_400_26
				end
			end

			if arg_397_1.time_ >= var_400_23 + var_400_24 and arg_397_1.time_ < var_400_23 + var_400_24 + arg_400_0 and not isNil(var_400_22) and arg_397_1.var_.characterEffect10143ui_story then
				local var_400_27 = 0.5

				arg_397_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_397_1.var_.characterEffect10143ui_story.fillRatio = var_400_27
			end

			local var_400_28 = 0

			if var_400_28 < arg_397_1.time_ and arg_397_1.time_ <= var_400_28 + arg_400_0 then
				arg_397_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_1")
			end

			local var_400_29 = 0

			if var_400_29 < arg_397_1.time_ and arg_397_1.time_ <= var_400_29 + arg_400_0 then
				arg_397_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_400_30 = 0
			local var_400_31 = 0.15

			if var_400_30 < arg_397_1.time_ and arg_397_1.time_ <= var_400_30 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_32 = arg_397_1:FormatText(StoryNameCfg[1308].name)

				arg_397_1.leftNameTxt_.text = var_400_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_33 = arg_397_1:GetWordFromCfg(421041098)
				local var_400_34 = arg_397_1:FormatText(var_400_33.content)

				arg_397_1.text_.text = var_400_34

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_35 = 6
				local var_400_36 = utf8.len(var_400_34)
				local var_400_37 = var_400_35 <= 0 and var_400_31 or var_400_31 * (var_400_36 / var_400_35)

				if var_400_37 > 0 and var_400_31 < var_400_37 then
					arg_397_1.talkMaxDuration = var_400_37

					if var_400_37 + var_400_30 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_37 + var_400_30
					end
				end

				arg_397_1.text_.text = var_400_34
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041098", "story_v_out_421041.awb") ~= 0 then
					local var_400_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041098", "story_v_out_421041.awb") / 1000

					if var_400_38 + var_400_30 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_38 + var_400_30
					end

					if var_400_33.prefab_name ~= "" and arg_397_1.actors_[var_400_33.prefab_name] ~= nil then
						local var_400_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_33.prefab_name].transform, "story_v_out_421041", "421041098", "story_v_out_421041.awb")

						arg_397_1:RecordAudio("421041098", var_400_39)
						arg_397_1:RecordAudio("421041098", var_400_39)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_421041", "421041098", "story_v_out_421041.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_421041", "421041098", "story_v_out_421041.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_40 = math.max(var_400_31, arg_397_1.talkMaxDuration)

			if var_400_30 <= arg_397_1.time_ and arg_397_1.time_ < var_400_30 + var_400_40 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_30) / var_400_40

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_30 + var_400_40 and arg_397_1.time_ < var_400_30 + var_400_40 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play421041099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 421041099
		arg_401_1.duration_ = 12.43

		local var_401_0 = {
			zh = 10,
			ja = 12.433
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
				arg_401_0:Play421041100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10143ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos10143ui_story = var_404_0.localPosition
			end

			local var_404_2 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2
				local var_404_4 = Vector3.New(-0.72, -1.06, -6)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10143ui_story, var_404_4, var_404_3)

				local var_404_5 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_5.x, var_404_5.y, var_404_5.z)

				local var_404_6 = var_404_0.localEulerAngles

				var_404_6.z = 0
				var_404_6.x = 0
				var_404_0.localEulerAngles = var_404_6
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_404_7 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_7.x, var_404_7.y, var_404_7.z)

				local var_404_8 = var_404_0.localEulerAngles

				var_404_8.z = 0
				var_404_8.x = 0
				var_404_0.localEulerAngles = var_404_8
			end

			local var_404_9 = arg_401_1.actors_["10143ui_story"]
			local var_404_10 = 0

			if var_404_10 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect10143ui_story == nil then
				arg_401_1.var_.characterEffect10143ui_story = var_404_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_11 = 0.200000002980232

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_11 and not isNil(var_404_9) then
				local var_404_12 = (arg_401_1.time_ - var_404_10) / var_404_11

				if arg_401_1.var_.characterEffect10143ui_story and not isNil(var_404_9) then
					arg_401_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_10 + var_404_11 and arg_401_1.time_ < var_404_10 + var_404_11 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect10143ui_story then
				arg_401_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_404_13 = arg_401_1.actors_["10145ui_story"]
			local var_404_14 = 0

			if var_404_14 < arg_401_1.time_ and arg_401_1.time_ <= var_404_14 + arg_404_0 and not isNil(var_404_13) and arg_401_1.var_.characterEffect10145ui_story == nil then
				arg_401_1.var_.characterEffect10145ui_story = var_404_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_15 = 0.200000002980232

			if var_404_14 <= arg_401_1.time_ and arg_401_1.time_ < var_404_14 + var_404_15 and not isNil(var_404_13) then
				local var_404_16 = (arg_401_1.time_ - var_404_14) / var_404_15

				if arg_401_1.var_.characterEffect10145ui_story and not isNil(var_404_13) then
					local var_404_17 = Mathf.Lerp(0, 0.5, var_404_16)

					arg_401_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_401_1.var_.characterEffect10145ui_story.fillRatio = var_404_17
				end
			end

			if arg_401_1.time_ >= var_404_14 + var_404_15 and arg_401_1.time_ < var_404_14 + var_404_15 + arg_404_0 and not isNil(var_404_13) and arg_401_1.var_.characterEffect10145ui_story then
				local var_404_18 = 0.5

				arg_401_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_401_1.var_.characterEffect10145ui_story.fillRatio = var_404_18
			end

			local var_404_19 = 0

			if var_404_19 < arg_401_1.time_ and arg_401_1.time_ <= var_404_19 + arg_404_0 then
				arg_401_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_404_20 = 0

			if var_404_20 < arg_401_1.time_ and arg_401_1.time_ <= var_404_20 + arg_404_0 then
				arg_401_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_404_21 = 0
			local var_404_22 = 1.15

			if var_404_21 < arg_401_1.time_ and arg_401_1.time_ <= var_404_21 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_23 = arg_401_1:FormatText(StoryNameCfg[1307].name)

				arg_401_1.leftNameTxt_.text = var_404_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_24 = arg_401_1:GetWordFromCfg(421041099)
				local var_404_25 = arg_401_1:FormatText(var_404_24.content)

				arg_401_1.text_.text = var_404_25

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_26 = 46
				local var_404_27 = utf8.len(var_404_25)
				local var_404_28 = var_404_26 <= 0 and var_404_22 or var_404_22 * (var_404_27 / var_404_26)

				if var_404_28 > 0 and var_404_22 < var_404_28 then
					arg_401_1.talkMaxDuration = var_404_28

					if var_404_28 + var_404_21 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_28 + var_404_21
					end
				end

				arg_401_1.text_.text = var_404_25
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041099", "story_v_out_421041.awb") ~= 0 then
					local var_404_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041099", "story_v_out_421041.awb") / 1000

					if var_404_29 + var_404_21 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_29 + var_404_21
					end

					if var_404_24.prefab_name ~= "" and arg_401_1.actors_[var_404_24.prefab_name] ~= nil then
						local var_404_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_24.prefab_name].transform, "story_v_out_421041", "421041099", "story_v_out_421041.awb")

						arg_401_1:RecordAudio("421041099", var_404_30)
						arg_401_1:RecordAudio("421041099", var_404_30)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_421041", "421041099", "story_v_out_421041.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_421041", "421041099", "story_v_out_421041.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_31 = math.max(var_404_22, arg_401_1.talkMaxDuration)

			if var_404_21 <= arg_401_1.time_ and arg_401_1.time_ < var_404_21 + var_404_31 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_21) / var_404_31

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_21 + var_404_31 and arg_401_1.time_ < var_404_21 + var_404_31 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play421041100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 421041100
		arg_405_1.duration_ = 9.3

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play421041101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["10145ui_story"].transform
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.var_.moveOldPos10145ui_story = var_408_0.localPosition
			end

			local var_408_2 = 0.001

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2
				local var_408_4 = Vector3.New(0.78, -1, -6.2)

				var_408_0.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10145ui_story, var_408_4, var_408_3)

				local var_408_5 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_5.x, var_408_5.y, var_408_5.z)

				local var_408_6 = var_408_0.localEulerAngles

				var_408_6.z = 0
				var_408_6.x = 0
				var_408_0.localEulerAngles = var_408_6
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 then
				var_408_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_408_7 = manager.ui.mainCamera.transform.position - var_408_0.position

				var_408_0.forward = Vector3.New(var_408_7.x, var_408_7.y, var_408_7.z)

				local var_408_8 = var_408_0.localEulerAngles

				var_408_8.z = 0
				var_408_8.x = 0
				var_408_0.localEulerAngles = var_408_8
			end

			local var_408_9 = arg_405_1.actors_["10145ui_story"]
			local var_408_10 = 0

			if var_408_10 < arg_405_1.time_ and arg_405_1.time_ <= var_408_10 + arg_408_0 and not isNil(var_408_9) and arg_405_1.var_.characterEffect10145ui_story == nil then
				arg_405_1.var_.characterEffect10145ui_story = var_408_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_11 = 0.200000002980232

			if var_408_10 <= arg_405_1.time_ and arg_405_1.time_ < var_408_10 + var_408_11 and not isNil(var_408_9) then
				local var_408_12 = (arg_405_1.time_ - var_408_10) / var_408_11

				if arg_405_1.var_.characterEffect10145ui_story and not isNil(var_408_9) then
					arg_405_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= var_408_10 + var_408_11 and arg_405_1.time_ < var_408_10 + var_408_11 + arg_408_0 and not isNil(var_408_9) and arg_405_1.var_.characterEffect10145ui_story then
				arg_405_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_408_13 = arg_405_1.actors_["10143ui_story"]
			local var_408_14 = 0

			if var_408_14 < arg_405_1.time_ and arg_405_1.time_ <= var_408_14 + arg_408_0 and not isNil(var_408_13) and arg_405_1.var_.characterEffect10143ui_story == nil then
				arg_405_1.var_.characterEffect10143ui_story = var_408_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_15 = 0.200000002980232

			if var_408_14 <= arg_405_1.time_ and arg_405_1.time_ < var_408_14 + var_408_15 and not isNil(var_408_13) then
				local var_408_16 = (arg_405_1.time_ - var_408_14) / var_408_15

				if arg_405_1.var_.characterEffect10143ui_story and not isNil(var_408_13) then
					local var_408_17 = Mathf.Lerp(0, 0.5, var_408_16)

					arg_405_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_405_1.var_.characterEffect10143ui_story.fillRatio = var_408_17
				end
			end

			if arg_405_1.time_ >= var_408_14 + var_408_15 and arg_405_1.time_ < var_408_14 + var_408_15 + arg_408_0 and not isNil(var_408_13) and arg_405_1.var_.characterEffect10143ui_story then
				local var_408_18 = 0.5

				arg_405_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_405_1.var_.characterEffect10143ui_story.fillRatio = var_408_18
			end

			local var_408_19 = 0

			if var_408_19 < arg_405_1.time_ and arg_405_1.time_ <= var_408_19 + arg_408_0 then
				arg_405_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_2")
			end

			local var_408_20 = 0

			if var_408_20 < arg_405_1.time_ and arg_405_1.time_ <= var_408_20 + arg_408_0 then
				arg_405_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_408_21 = 0
			local var_408_22 = 1.025

			if var_408_21 < arg_405_1.time_ and arg_405_1.time_ <= var_408_21 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_23 = arg_405_1:FormatText(StoryNameCfg[1308].name)

				arg_405_1.leftNameTxt_.text = var_408_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_24 = arg_405_1:GetWordFromCfg(421041100)
				local var_408_25 = arg_405_1:FormatText(var_408_24.content)

				arg_405_1.text_.text = var_408_25

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_26 = 41
				local var_408_27 = utf8.len(var_408_25)
				local var_408_28 = var_408_26 <= 0 and var_408_22 or var_408_22 * (var_408_27 / var_408_26)

				if var_408_28 > 0 and var_408_22 < var_408_28 then
					arg_405_1.talkMaxDuration = var_408_28

					if var_408_28 + var_408_21 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_28 + var_408_21
					end
				end

				arg_405_1.text_.text = var_408_25
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041100", "story_v_out_421041.awb") ~= 0 then
					local var_408_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041100", "story_v_out_421041.awb") / 1000

					if var_408_29 + var_408_21 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_29 + var_408_21
					end

					if var_408_24.prefab_name ~= "" and arg_405_1.actors_[var_408_24.prefab_name] ~= nil then
						local var_408_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_24.prefab_name].transform, "story_v_out_421041", "421041100", "story_v_out_421041.awb")

						arg_405_1:RecordAudio("421041100", var_408_30)
						arg_405_1:RecordAudio("421041100", var_408_30)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_421041", "421041100", "story_v_out_421041.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_421041", "421041100", "story_v_out_421041.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_31 = math.max(var_408_22, arg_405_1.talkMaxDuration)

			if var_408_21 <= arg_405_1.time_ and arg_405_1.time_ < var_408_21 + var_408_31 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_21) / var_408_31

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_21 + var_408_31 and arg_405_1.time_ < var_408_21 + var_408_31 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play421041101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 421041101
		arg_409_1.duration_ = 5.4

		local var_409_0 = {
			zh = 4.266,
			ja = 5.4
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play421041102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["10143ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos10143ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(-0.72, -1.06, -6)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10143ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["10143ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect10143ui_story == nil then
				arg_409_1.var_.characterEffect10143ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 and not isNil(var_412_9) then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect10143ui_story and not isNil(var_412_9) then
					arg_409_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect10143ui_story then
				arg_409_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_412_13 = arg_409_1.actors_["10145ui_story"]
			local var_412_14 = 0

			if var_412_14 < arg_409_1.time_ and arg_409_1.time_ <= var_412_14 + arg_412_0 and not isNil(var_412_13) and arg_409_1.var_.characterEffect10145ui_story == nil then
				arg_409_1.var_.characterEffect10145ui_story = var_412_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_15 = 0.200000002980232

			if var_412_14 <= arg_409_1.time_ and arg_409_1.time_ < var_412_14 + var_412_15 and not isNil(var_412_13) then
				local var_412_16 = (arg_409_1.time_ - var_412_14) / var_412_15

				if arg_409_1.var_.characterEffect10145ui_story and not isNil(var_412_13) then
					local var_412_17 = Mathf.Lerp(0, 0.5, var_412_16)

					arg_409_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_409_1.var_.characterEffect10145ui_story.fillRatio = var_412_17
				end
			end

			if arg_409_1.time_ >= var_412_14 + var_412_15 and arg_409_1.time_ < var_412_14 + var_412_15 + arg_412_0 and not isNil(var_412_13) and arg_409_1.var_.characterEffect10145ui_story then
				local var_412_18 = 0.5

				arg_409_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_409_1.var_.characterEffect10145ui_story.fillRatio = var_412_18
			end

			local var_412_19 = 0

			if var_412_19 < arg_409_1.time_ and arg_409_1.time_ <= var_412_19 + arg_412_0 then
				arg_409_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_1")
			end

			local var_412_20 = 0

			if var_412_20 < arg_409_1.time_ and arg_409_1.time_ <= var_412_20 + arg_412_0 then
				arg_409_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_412_21 = 0
			local var_412_22 = 0.4

			if var_412_21 < arg_409_1.time_ and arg_409_1.time_ <= var_412_21 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_23 = arg_409_1:FormatText(StoryNameCfg[1307].name)

				arg_409_1.leftNameTxt_.text = var_412_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_24 = arg_409_1:GetWordFromCfg(421041101)
				local var_412_25 = arg_409_1:FormatText(var_412_24.content)

				arg_409_1.text_.text = var_412_25

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_26 = 16
				local var_412_27 = utf8.len(var_412_25)
				local var_412_28 = var_412_26 <= 0 and var_412_22 or var_412_22 * (var_412_27 / var_412_26)

				if var_412_28 > 0 and var_412_22 < var_412_28 then
					arg_409_1.talkMaxDuration = var_412_28

					if var_412_28 + var_412_21 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_28 + var_412_21
					end
				end

				arg_409_1.text_.text = var_412_25
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041101", "story_v_out_421041.awb") ~= 0 then
					local var_412_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041101", "story_v_out_421041.awb") / 1000

					if var_412_29 + var_412_21 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_29 + var_412_21
					end

					if var_412_24.prefab_name ~= "" and arg_409_1.actors_[var_412_24.prefab_name] ~= nil then
						local var_412_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_24.prefab_name].transform, "story_v_out_421041", "421041101", "story_v_out_421041.awb")

						arg_409_1:RecordAudio("421041101", var_412_30)
						arg_409_1:RecordAudio("421041101", var_412_30)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_421041", "421041101", "story_v_out_421041.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_421041", "421041101", "story_v_out_421041.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_31 = math.max(var_412_22, arg_409_1.talkMaxDuration)

			if var_412_21 <= arg_409_1.time_ and arg_409_1.time_ < var_412_21 + var_412_31 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_21) / var_412_31

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_21 + var_412_31 and arg_409_1.time_ < var_412_21 + var_412_31 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play421041102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 421041102
		arg_413_1.duration_ = 7.1

		local var_413_0 = {
			zh = 4.833,
			ja = 7.1
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play421041103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["10145ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos10145ui_story = var_416_0.localPosition
			end

			local var_416_2 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2
				local var_416_4 = Vector3.New(0.78, -1, -6.2)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10145ui_story, var_416_4, var_416_3)

				local var_416_5 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_5.x, var_416_5.y, var_416_5.z)

				local var_416_6 = var_416_0.localEulerAngles

				var_416_6.z = 0
				var_416_6.x = 0
				var_416_0.localEulerAngles = var_416_6
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_416_7 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_7.x, var_416_7.y, var_416_7.z)

				local var_416_8 = var_416_0.localEulerAngles

				var_416_8.z = 0
				var_416_8.x = 0
				var_416_0.localEulerAngles = var_416_8
			end

			local var_416_9 = arg_413_1.actors_["10145ui_story"]
			local var_416_10 = 0

			if var_416_10 < arg_413_1.time_ and arg_413_1.time_ <= var_416_10 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect10145ui_story == nil then
				arg_413_1.var_.characterEffect10145ui_story = var_416_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_11 = 0.200000002980232

			if var_416_10 <= arg_413_1.time_ and arg_413_1.time_ < var_416_10 + var_416_11 and not isNil(var_416_9) then
				local var_416_12 = (arg_413_1.time_ - var_416_10) / var_416_11

				if arg_413_1.var_.characterEffect10145ui_story and not isNil(var_416_9) then
					arg_413_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_10 + var_416_11 and arg_413_1.time_ < var_416_10 + var_416_11 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect10145ui_story then
				arg_413_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_416_13 = arg_413_1.actors_["10143ui_story"]
			local var_416_14 = 0

			if var_416_14 < arg_413_1.time_ and arg_413_1.time_ <= var_416_14 + arg_416_0 and not isNil(var_416_13) and arg_413_1.var_.characterEffect10143ui_story == nil then
				arg_413_1.var_.characterEffect10143ui_story = var_416_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_15 = 0.200000002980232

			if var_416_14 <= arg_413_1.time_ and arg_413_1.time_ < var_416_14 + var_416_15 and not isNil(var_416_13) then
				local var_416_16 = (arg_413_1.time_ - var_416_14) / var_416_15

				if arg_413_1.var_.characterEffect10143ui_story and not isNil(var_416_13) then
					local var_416_17 = Mathf.Lerp(0, 0.5, var_416_16)

					arg_413_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_413_1.var_.characterEffect10143ui_story.fillRatio = var_416_17
				end
			end

			if arg_413_1.time_ >= var_416_14 + var_416_15 and arg_413_1.time_ < var_416_14 + var_416_15 + arg_416_0 and not isNil(var_416_13) and arg_413_1.var_.characterEffect10143ui_story then
				local var_416_18 = 0.5

				arg_413_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_413_1.var_.characterEffect10143ui_story.fillRatio = var_416_18
			end

			local var_416_19 = 0

			if var_416_19 < arg_413_1.time_ and arg_413_1.time_ <= var_416_19 + arg_416_0 then
				arg_413_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			local var_416_20 = 0

			if var_416_20 < arg_413_1.time_ and arg_413_1.time_ <= var_416_20 + arg_416_0 then
				arg_413_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_416_21 = 0
			local var_416_22 = 0.625

			if var_416_21 < arg_413_1.time_ and arg_413_1.time_ <= var_416_21 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_23 = arg_413_1:FormatText(StoryNameCfg[1308].name)

				arg_413_1.leftNameTxt_.text = var_416_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_24 = arg_413_1:GetWordFromCfg(421041102)
				local var_416_25 = arg_413_1:FormatText(var_416_24.content)

				arg_413_1.text_.text = var_416_25

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_26 = 25
				local var_416_27 = utf8.len(var_416_25)
				local var_416_28 = var_416_26 <= 0 and var_416_22 or var_416_22 * (var_416_27 / var_416_26)

				if var_416_28 > 0 and var_416_22 < var_416_28 then
					arg_413_1.talkMaxDuration = var_416_28

					if var_416_28 + var_416_21 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_28 + var_416_21
					end
				end

				arg_413_1.text_.text = var_416_25
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041102", "story_v_out_421041.awb") ~= 0 then
					local var_416_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041102", "story_v_out_421041.awb") / 1000

					if var_416_29 + var_416_21 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_29 + var_416_21
					end

					if var_416_24.prefab_name ~= "" and arg_413_1.actors_[var_416_24.prefab_name] ~= nil then
						local var_416_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_24.prefab_name].transform, "story_v_out_421041", "421041102", "story_v_out_421041.awb")

						arg_413_1:RecordAudio("421041102", var_416_30)
						arg_413_1:RecordAudio("421041102", var_416_30)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_421041", "421041102", "story_v_out_421041.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_421041", "421041102", "story_v_out_421041.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_31 = math.max(var_416_22, arg_413_1.talkMaxDuration)

			if var_416_21 <= arg_413_1.time_ and arg_413_1.time_ < var_416_21 + var_416_31 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_21) / var_416_31

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_21 + var_416_31 and arg_413_1.time_ < var_416_21 + var_416_31 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play421041103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 421041103
		arg_417_1.duration_ = 3.37

		local var_417_0 = {
			zh = 3.233,
			ja = 3.366
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play421041104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["10143ui_story"].transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos10143ui_story = var_420_0.localPosition
			end

			local var_420_2 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2
				local var_420_4 = Vector3.New(-0.72, -1.06, -6)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10143ui_story, var_420_4, var_420_3)

				local var_420_5 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_5.x, var_420_5.y, var_420_5.z)

				local var_420_6 = var_420_0.localEulerAngles

				var_420_6.z = 0
				var_420_6.x = 0
				var_420_0.localEulerAngles = var_420_6
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_420_7 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_7.x, var_420_7.y, var_420_7.z)

				local var_420_8 = var_420_0.localEulerAngles

				var_420_8.z = 0
				var_420_8.x = 0
				var_420_0.localEulerAngles = var_420_8
			end

			local var_420_9 = arg_417_1.actors_["10143ui_story"]
			local var_420_10 = 0

			if var_420_10 < arg_417_1.time_ and arg_417_1.time_ <= var_420_10 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect10143ui_story == nil then
				arg_417_1.var_.characterEffect10143ui_story = var_420_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_11 = 0.200000002980232

			if var_420_10 <= arg_417_1.time_ and arg_417_1.time_ < var_420_10 + var_420_11 and not isNil(var_420_9) then
				local var_420_12 = (arg_417_1.time_ - var_420_10) / var_420_11

				if arg_417_1.var_.characterEffect10143ui_story and not isNil(var_420_9) then
					arg_417_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= var_420_10 + var_420_11 and arg_417_1.time_ < var_420_10 + var_420_11 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect10143ui_story then
				arg_417_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_420_13 = arg_417_1.actors_["10145ui_story"]
			local var_420_14 = 0

			if var_420_14 < arg_417_1.time_ and arg_417_1.time_ <= var_420_14 + arg_420_0 and not isNil(var_420_13) and arg_417_1.var_.characterEffect10145ui_story == nil then
				arg_417_1.var_.characterEffect10145ui_story = var_420_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_15 = 0.200000002980232

			if var_420_14 <= arg_417_1.time_ and arg_417_1.time_ < var_420_14 + var_420_15 and not isNil(var_420_13) then
				local var_420_16 = (arg_417_1.time_ - var_420_14) / var_420_15

				if arg_417_1.var_.characterEffect10145ui_story and not isNil(var_420_13) then
					local var_420_17 = Mathf.Lerp(0, 0.5, var_420_16)

					arg_417_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_417_1.var_.characterEffect10145ui_story.fillRatio = var_420_17
				end
			end

			if arg_417_1.time_ >= var_420_14 + var_420_15 and arg_417_1.time_ < var_420_14 + var_420_15 + arg_420_0 and not isNil(var_420_13) and arg_417_1.var_.characterEffect10145ui_story then
				local var_420_18 = 0.5

				arg_417_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_417_1.var_.characterEffect10145ui_story.fillRatio = var_420_18
			end

			local var_420_19 = 0

			if var_420_19 < arg_417_1.time_ and arg_417_1.time_ <= var_420_19 + arg_420_0 then
				arg_417_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_2")
			end

			local var_420_20 = 0

			if var_420_20 < arg_417_1.time_ and arg_417_1.time_ <= var_420_20 + arg_420_0 then
				arg_417_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_420_21 = 0
			local var_420_22 = 0.35

			if var_420_21 < arg_417_1.time_ and arg_417_1.time_ <= var_420_21 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_23 = arg_417_1:FormatText(StoryNameCfg[1307].name)

				arg_417_1.leftNameTxt_.text = var_420_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_24 = arg_417_1:GetWordFromCfg(421041103)
				local var_420_25 = arg_417_1:FormatText(var_420_24.content)

				arg_417_1.text_.text = var_420_25

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_26 = 14
				local var_420_27 = utf8.len(var_420_25)
				local var_420_28 = var_420_26 <= 0 and var_420_22 or var_420_22 * (var_420_27 / var_420_26)

				if var_420_28 > 0 and var_420_22 < var_420_28 then
					arg_417_1.talkMaxDuration = var_420_28

					if var_420_28 + var_420_21 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_28 + var_420_21
					end
				end

				arg_417_1.text_.text = var_420_25
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041103", "story_v_out_421041.awb") ~= 0 then
					local var_420_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041103", "story_v_out_421041.awb") / 1000

					if var_420_29 + var_420_21 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_29 + var_420_21
					end

					if var_420_24.prefab_name ~= "" and arg_417_1.actors_[var_420_24.prefab_name] ~= nil then
						local var_420_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_24.prefab_name].transform, "story_v_out_421041", "421041103", "story_v_out_421041.awb")

						arg_417_1:RecordAudio("421041103", var_420_30)
						arg_417_1:RecordAudio("421041103", var_420_30)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_421041", "421041103", "story_v_out_421041.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_421041", "421041103", "story_v_out_421041.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_31 = math.max(var_420_22, arg_417_1.talkMaxDuration)

			if var_420_21 <= arg_417_1.time_ and arg_417_1.time_ < var_420_21 + var_420_31 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_21) / var_420_31

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_21 + var_420_31 and arg_417_1.time_ < var_420_21 + var_420_31 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play421041104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 421041104
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play421041105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["10143ui_story"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect10143ui_story == nil then
				arg_421_1.var_.characterEffect10143ui_story = var_424_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.characterEffect10143ui_story and not isNil(var_424_0) then
					local var_424_4 = Mathf.Lerp(0, 0.5, var_424_3)

					arg_421_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_421_1.var_.characterEffect10143ui_story.fillRatio = var_424_4
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect10143ui_story then
				local var_424_5 = 0.5

				arg_421_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_421_1.var_.characterEffect10143ui_story.fillRatio = var_424_5
			end

			local var_424_6 = 0
			local var_424_7 = 0.375

			if var_424_6 < arg_421_1.time_ and arg_421_1.time_ <= var_424_6 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_8 = arg_421_1:FormatText(StoryNameCfg[7].name)

				arg_421_1.leftNameTxt_.text = var_424_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_9 = arg_421_1:GetWordFromCfg(421041104)
				local var_424_10 = arg_421_1:FormatText(var_424_9.content)

				arg_421_1.text_.text = var_424_10

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_11 = 15
				local var_424_12 = utf8.len(var_424_10)
				local var_424_13 = var_424_11 <= 0 and var_424_7 or var_424_7 * (var_424_12 / var_424_11)

				if var_424_13 > 0 and var_424_7 < var_424_13 then
					arg_421_1.talkMaxDuration = var_424_13

					if var_424_13 + var_424_6 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_13 + var_424_6
					end
				end

				arg_421_1.text_.text = var_424_10
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_14 = math.max(var_424_7, arg_421_1.talkMaxDuration)

			if var_424_6 <= arg_421_1.time_ and arg_421_1.time_ < var_424_6 + var_424_14 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_6) / var_424_14

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_6 + var_424_14 and arg_421_1.time_ < var_424_6 + var_424_14 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play421041105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 421041105
		arg_425_1.duration_ = 12.33

		local var_425_0 = {
			zh = 9.3,
			ja = 12.333
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play421041106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["10145ui_story"].transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.moveOldPos10145ui_story = var_428_0.localPosition
			end

			local var_428_2 = 0.001

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2
				local var_428_4 = Vector3.New(0.78, -1, -6.2)

				var_428_0.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos10145ui_story, var_428_4, var_428_3)

				local var_428_5 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_5.x, var_428_5.y, var_428_5.z)

				local var_428_6 = var_428_0.localEulerAngles

				var_428_6.z = 0
				var_428_6.x = 0
				var_428_0.localEulerAngles = var_428_6
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 then
				var_428_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_428_7 = manager.ui.mainCamera.transform.position - var_428_0.position

				var_428_0.forward = Vector3.New(var_428_7.x, var_428_7.y, var_428_7.z)

				local var_428_8 = var_428_0.localEulerAngles

				var_428_8.z = 0
				var_428_8.x = 0
				var_428_0.localEulerAngles = var_428_8
			end

			local var_428_9 = arg_425_1.actors_["10145ui_story"]
			local var_428_10 = 0

			if var_428_10 < arg_425_1.time_ and arg_425_1.time_ <= var_428_10 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect10145ui_story == nil then
				arg_425_1.var_.characterEffect10145ui_story = var_428_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_11 = 0.200000002980232

			if var_428_10 <= arg_425_1.time_ and arg_425_1.time_ < var_428_10 + var_428_11 and not isNil(var_428_9) then
				local var_428_12 = (arg_425_1.time_ - var_428_10) / var_428_11

				if arg_425_1.var_.characterEffect10145ui_story and not isNil(var_428_9) then
					arg_425_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_10 + var_428_11 and arg_425_1.time_ < var_428_10 + var_428_11 + arg_428_0 and not isNil(var_428_9) and arg_425_1.var_.characterEffect10145ui_story then
				arg_425_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_428_13 = 0

			if var_428_13 < arg_425_1.time_ and arg_425_1.time_ <= var_428_13 + arg_428_0 then
				arg_425_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			local var_428_14 = 0

			if var_428_14 < arg_425_1.time_ and arg_425_1.time_ <= var_428_14 + arg_428_0 then
				arg_425_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_428_15 = 0
			local var_428_16 = 0.975

			if var_428_15 < arg_425_1.time_ and arg_425_1.time_ <= var_428_15 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_17 = arg_425_1:FormatText(StoryNameCfg[1308].name)

				arg_425_1.leftNameTxt_.text = var_428_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_18 = arg_425_1:GetWordFromCfg(421041105)
				local var_428_19 = arg_425_1:FormatText(var_428_18.content)

				arg_425_1.text_.text = var_428_19

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_20 = 39
				local var_428_21 = utf8.len(var_428_19)
				local var_428_22 = var_428_20 <= 0 and var_428_16 or var_428_16 * (var_428_21 / var_428_20)

				if var_428_22 > 0 and var_428_16 < var_428_22 then
					arg_425_1.talkMaxDuration = var_428_22

					if var_428_22 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_22 + var_428_15
					end
				end

				arg_425_1.text_.text = var_428_19
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041105", "story_v_out_421041.awb") ~= 0 then
					local var_428_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041105", "story_v_out_421041.awb") / 1000

					if var_428_23 + var_428_15 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_23 + var_428_15
					end

					if var_428_18.prefab_name ~= "" and arg_425_1.actors_[var_428_18.prefab_name] ~= nil then
						local var_428_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_18.prefab_name].transform, "story_v_out_421041", "421041105", "story_v_out_421041.awb")

						arg_425_1:RecordAudio("421041105", var_428_24)
						arg_425_1:RecordAudio("421041105", var_428_24)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_421041", "421041105", "story_v_out_421041.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_421041", "421041105", "story_v_out_421041.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_25 = math.max(var_428_16, arg_425_1.talkMaxDuration)

			if var_428_15 <= arg_425_1.time_ and arg_425_1.time_ < var_428_15 + var_428_25 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_15) / var_428_25

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_15 + var_428_25 and arg_425_1.time_ < var_428_15 + var_428_25 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play421041106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 421041106
		arg_429_1.duration_ = 4.13

		local var_429_0 = {
			zh = 2.966,
			ja = 4.133
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play421041107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["10102ui_story"].transform
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.var_.moveOldPos10102ui_story = var_432_0.localPosition
			end

			local var_432_2 = 0.001

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2
				local var_432_4 = Vector3.New(-0.7, -0.985, -6.275)

				var_432_0.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10102ui_story, var_432_4, var_432_3)

				local var_432_5 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_5.x, var_432_5.y, var_432_5.z)

				local var_432_6 = var_432_0.localEulerAngles

				var_432_6.z = 0
				var_432_6.x = 0
				var_432_0.localEulerAngles = var_432_6
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 then
				var_432_0.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_432_7 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_7.x, var_432_7.y, var_432_7.z)

				local var_432_8 = var_432_0.localEulerAngles

				var_432_8.z = 0
				var_432_8.x = 0
				var_432_0.localEulerAngles = var_432_8
			end

			local var_432_9 = arg_429_1.actors_["10143ui_story"].transform
			local var_432_10 = 0

			if var_432_10 < arg_429_1.time_ and arg_429_1.time_ <= var_432_10 + arg_432_0 then
				arg_429_1.var_.moveOldPos10143ui_story = var_432_9.localPosition
			end

			local var_432_11 = 0.001

			if var_432_10 <= arg_429_1.time_ and arg_429_1.time_ < var_432_10 + var_432_11 then
				local var_432_12 = (arg_429_1.time_ - var_432_10) / var_432_11
				local var_432_13 = Vector3.New(0, 100, 0)

				var_432_9.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10143ui_story, var_432_13, var_432_12)

				local var_432_14 = manager.ui.mainCamera.transform.position - var_432_9.position

				var_432_9.forward = Vector3.New(var_432_14.x, var_432_14.y, var_432_14.z)

				local var_432_15 = var_432_9.localEulerAngles

				var_432_15.z = 0
				var_432_15.x = 0
				var_432_9.localEulerAngles = var_432_15
			end

			if arg_429_1.time_ >= var_432_10 + var_432_11 and arg_429_1.time_ < var_432_10 + var_432_11 + arg_432_0 then
				var_432_9.localPosition = Vector3.New(0, 100, 0)

				local var_432_16 = manager.ui.mainCamera.transform.position - var_432_9.position

				var_432_9.forward = Vector3.New(var_432_16.x, var_432_16.y, var_432_16.z)

				local var_432_17 = var_432_9.localEulerAngles

				var_432_17.z = 0
				var_432_17.x = 0
				var_432_9.localEulerAngles = var_432_17
			end

			local var_432_18 = arg_429_1.actors_["10102ui_story"]
			local var_432_19 = 0

			if var_432_19 < arg_429_1.time_ and arg_429_1.time_ <= var_432_19 + arg_432_0 and not isNil(var_432_18) and arg_429_1.var_.characterEffect10102ui_story == nil then
				arg_429_1.var_.characterEffect10102ui_story = var_432_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_20 = 0.200000002980232

			if var_432_19 <= arg_429_1.time_ and arg_429_1.time_ < var_432_19 + var_432_20 and not isNil(var_432_18) then
				local var_432_21 = (arg_429_1.time_ - var_432_19) / var_432_20

				if arg_429_1.var_.characterEffect10102ui_story and not isNil(var_432_18) then
					arg_429_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= var_432_19 + var_432_20 and arg_429_1.time_ < var_432_19 + var_432_20 + arg_432_0 and not isNil(var_432_18) and arg_429_1.var_.characterEffect10102ui_story then
				arg_429_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_432_22 = arg_429_1.actors_["10145ui_story"]
			local var_432_23 = 0

			if var_432_23 < arg_429_1.time_ and arg_429_1.time_ <= var_432_23 + arg_432_0 and not isNil(var_432_22) and arg_429_1.var_.characterEffect10145ui_story == nil then
				arg_429_1.var_.characterEffect10145ui_story = var_432_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_24 = 0.200000002980232

			if var_432_23 <= arg_429_1.time_ and arg_429_1.time_ < var_432_23 + var_432_24 and not isNil(var_432_22) then
				local var_432_25 = (arg_429_1.time_ - var_432_23) / var_432_24

				if arg_429_1.var_.characterEffect10145ui_story and not isNil(var_432_22) then
					local var_432_26 = Mathf.Lerp(0, 0.5, var_432_25)

					arg_429_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_429_1.var_.characterEffect10145ui_story.fillRatio = var_432_26
				end
			end

			if arg_429_1.time_ >= var_432_23 + var_432_24 and arg_429_1.time_ < var_432_23 + var_432_24 + arg_432_0 and not isNil(var_432_22) and arg_429_1.var_.characterEffect10145ui_story then
				local var_432_27 = 0.5

				arg_429_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_429_1.var_.characterEffect10145ui_story.fillRatio = var_432_27
			end

			local var_432_28 = 0

			if var_432_28 < arg_429_1.time_ and arg_429_1.time_ <= var_432_28 + arg_432_0 then
				arg_429_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_432_29 = 0

			if var_432_29 < arg_429_1.time_ and arg_429_1.time_ <= var_432_29 + arg_432_0 then
				arg_429_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_432_30 = 0
			local var_432_31 = 0.325

			if var_432_30 < arg_429_1.time_ and arg_429_1.time_ <= var_432_30 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_32 = arg_429_1:FormatText(StoryNameCfg[6].name)

				arg_429_1.leftNameTxt_.text = var_432_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_33 = arg_429_1:GetWordFromCfg(421041106)
				local var_432_34 = arg_429_1:FormatText(var_432_33.content)

				arg_429_1.text_.text = var_432_34

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_35 = 13
				local var_432_36 = utf8.len(var_432_34)
				local var_432_37 = var_432_35 <= 0 and var_432_31 or var_432_31 * (var_432_36 / var_432_35)

				if var_432_37 > 0 and var_432_31 < var_432_37 then
					arg_429_1.talkMaxDuration = var_432_37

					if var_432_37 + var_432_30 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_37 + var_432_30
					end
				end

				arg_429_1.text_.text = var_432_34
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041106", "story_v_out_421041.awb") ~= 0 then
					local var_432_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041106", "story_v_out_421041.awb") / 1000

					if var_432_38 + var_432_30 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_38 + var_432_30
					end

					if var_432_33.prefab_name ~= "" and arg_429_1.actors_[var_432_33.prefab_name] ~= nil then
						local var_432_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_33.prefab_name].transform, "story_v_out_421041", "421041106", "story_v_out_421041.awb")

						arg_429_1:RecordAudio("421041106", var_432_39)
						arg_429_1:RecordAudio("421041106", var_432_39)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_421041", "421041106", "story_v_out_421041.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_421041", "421041106", "story_v_out_421041.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_40 = math.max(var_432_31, arg_429_1.talkMaxDuration)

			if var_432_30 <= arg_429_1.time_ and arg_429_1.time_ < var_432_30 + var_432_40 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_30) / var_432_40

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_30 + var_432_40 and arg_429_1.time_ < var_432_30 + var_432_40 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play421041107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 421041107
		arg_433_1.duration_ = 7.97

		local var_433_0 = {
			zh = 5.6,
			ja = 7.966
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play421041108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["10145ui_story"].transform
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.var_.moveOldPos10145ui_story = var_436_0.localPosition
			end

			local var_436_2 = 0.001

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2
				local var_436_4 = Vector3.New(0.78, -1, -6.2)

				var_436_0.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10145ui_story, var_436_4, var_436_3)

				local var_436_5 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_5.x, var_436_5.y, var_436_5.z)

				local var_436_6 = var_436_0.localEulerAngles

				var_436_6.z = 0
				var_436_6.x = 0
				var_436_0.localEulerAngles = var_436_6
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 then
				var_436_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_436_7 = manager.ui.mainCamera.transform.position - var_436_0.position

				var_436_0.forward = Vector3.New(var_436_7.x, var_436_7.y, var_436_7.z)

				local var_436_8 = var_436_0.localEulerAngles

				var_436_8.z = 0
				var_436_8.x = 0
				var_436_0.localEulerAngles = var_436_8
			end

			local var_436_9 = arg_433_1.actors_["10145ui_story"]
			local var_436_10 = 0

			if var_436_10 < arg_433_1.time_ and arg_433_1.time_ <= var_436_10 + arg_436_0 and not isNil(var_436_9) and arg_433_1.var_.characterEffect10145ui_story == nil then
				arg_433_1.var_.characterEffect10145ui_story = var_436_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_11 = 0.200000002980232

			if var_436_10 <= arg_433_1.time_ and arg_433_1.time_ < var_436_10 + var_436_11 and not isNil(var_436_9) then
				local var_436_12 = (arg_433_1.time_ - var_436_10) / var_436_11

				if arg_433_1.var_.characterEffect10145ui_story and not isNil(var_436_9) then
					arg_433_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= var_436_10 + var_436_11 and arg_433_1.time_ < var_436_10 + var_436_11 + arg_436_0 and not isNil(var_436_9) and arg_433_1.var_.characterEffect10145ui_story then
				arg_433_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_436_13 = arg_433_1.actors_["10102ui_story"]
			local var_436_14 = 0

			if var_436_14 < arg_433_1.time_ and arg_433_1.time_ <= var_436_14 + arg_436_0 and not isNil(var_436_13) and arg_433_1.var_.characterEffect10102ui_story == nil then
				arg_433_1.var_.characterEffect10102ui_story = var_436_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_15 = 0.200000002980232

			if var_436_14 <= arg_433_1.time_ and arg_433_1.time_ < var_436_14 + var_436_15 and not isNil(var_436_13) then
				local var_436_16 = (arg_433_1.time_ - var_436_14) / var_436_15

				if arg_433_1.var_.characterEffect10102ui_story and not isNil(var_436_13) then
					local var_436_17 = Mathf.Lerp(0, 0.5, var_436_16)

					arg_433_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_433_1.var_.characterEffect10102ui_story.fillRatio = var_436_17
				end
			end

			if arg_433_1.time_ >= var_436_14 + var_436_15 and arg_433_1.time_ < var_436_14 + var_436_15 + arg_436_0 and not isNil(var_436_13) and arg_433_1.var_.characterEffect10102ui_story then
				local var_436_18 = 0.5

				arg_433_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_433_1.var_.characterEffect10102ui_story.fillRatio = var_436_18
			end

			local var_436_19 = 0

			if var_436_19 < arg_433_1.time_ and arg_433_1.time_ <= var_436_19 + arg_436_0 then
				arg_433_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_436_20 = 0

			if var_436_20 < arg_433_1.time_ and arg_433_1.time_ <= var_436_20 + arg_436_0 then
				arg_433_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_436_21 = 0
			local var_436_22 = 0.6

			if var_436_21 < arg_433_1.time_ and arg_433_1.time_ <= var_436_21 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_23 = arg_433_1:FormatText(StoryNameCfg[1308].name)

				arg_433_1.leftNameTxt_.text = var_436_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_24 = arg_433_1:GetWordFromCfg(421041107)
				local var_436_25 = arg_433_1:FormatText(var_436_24.content)

				arg_433_1.text_.text = var_436_25

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_26 = 24
				local var_436_27 = utf8.len(var_436_25)
				local var_436_28 = var_436_26 <= 0 and var_436_22 or var_436_22 * (var_436_27 / var_436_26)

				if var_436_28 > 0 and var_436_22 < var_436_28 then
					arg_433_1.talkMaxDuration = var_436_28

					if var_436_28 + var_436_21 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_28 + var_436_21
					end
				end

				arg_433_1.text_.text = var_436_25
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041107", "story_v_out_421041.awb") ~= 0 then
					local var_436_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041107", "story_v_out_421041.awb") / 1000

					if var_436_29 + var_436_21 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_29 + var_436_21
					end

					if var_436_24.prefab_name ~= "" and arg_433_1.actors_[var_436_24.prefab_name] ~= nil then
						local var_436_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_24.prefab_name].transform, "story_v_out_421041", "421041107", "story_v_out_421041.awb")

						arg_433_1:RecordAudio("421041107", var_436_30)
						arg_433_1:RecordAudio("421041107", var_436_30)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_421041", "421041107", "story_v_out_421041.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_421041", "421041107", "story_v_out_421041.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_31 = math.max(var_436_22, arg_433_1.talkMaxDuration)

			if var_436_21 <= arg_433_1.time_ and arg_433_1.time_ < var_436_21 + var_436_31 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_21) / var_436_31

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_21 + var_436_31 and arg_433_1.time_ < var_436_21 + var_436_31 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play421041108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 421041108
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play421041109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["10145ui_story"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect10145ui_story == nil then
				arg_437_1.var_.characterEffect10145ui_story = var_440_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.characterEffect10145ui_story and not isNil(var_440_0) then
					local var_440_4 = Mathf.Lerp(0, 0.5, var_440_3)

					arg_437_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_437_1.var_.characterEffect10145ui_story.fillRatio = var_440_4
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect10145ui_story then
				local var_440_5 = 0.5

				arg_437_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_437_1.var_.characterEffect10145ui_story.fillRatio = var_440_5
			end

			local var_440_6 = 0
			local var_440_7 = 0.925

			if var_440_6 < arg_437_1.time_ and arg_437_1.time_ <= var_440_6 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_8 = arg_437_1:FormatText(StoryNameCfg[7].name)

				arg_437_1.leftNameTxt_.text = var_440_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_9 = arg_437_1:GetWordFromCfg(421041108)
				local var_440_10 = arg_437_1:FormatText(var_440_9.content)

				arg_437_1.text_.text = var_440_10

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_11 = 37
				local var_440_12 = utf8.len(var_440_10)
				local var_440_13 = var_440_11 <= 0 and var_440_7 or var_440_7 * (var_440_12 / var_440_11)

				if var_440_13 > 0 and var_440_7 < var_440_13 then
					arg_437_1.talkMaxDuration = var_440_13

					if var_440_13 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_13 + var_440_6
					end
				end

				arg_437_1.text_.text = var_440_10
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_14 = math.max(var_440_7, arg_437_1.talkMaxDuration)

			if var_440_6 <= arg_437_1.time_ and arg_437_1.time_ < var_440_6 + var_440_14 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_6) / var_440_14

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_6 + var_440_14 and arg_437_1.time_ < var_440_6 + var_440_14 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play421041109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 421041109
		arg_441_1.duration_ = 14.83

		local var_441_0 = {
			zh = 12.633,
			ja = 14.833
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play421041110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["10145ui_story"].transform
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.var_.moveOldPos10145ui_story = var_444_0.localPosition
			end

			local var_444_2 = 0.001

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2
				local var_444_4 = Vector3.New(0.78, -1, -6.2)

				var_444_0.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10145ui_story, var_444_4, var_444_3)

				local var_444_5 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_5.x, var_444_5.y, var_444_5.z)

				local var_444_6 = var_444_0.localEulerAngles

				var_444_6.z = 0
				var_444_6.x = 0
				var_444_0.localEulerAngles = var_444_6
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 then
				var_444_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_444_7 = manager.ui.mainCamera.transform.position - var_444_0.position

				var_444_0.forward = Vector3.New(var_444_7.x, var_444_7.y, var_444_7.z)

				local var_444_8 = var_444_0.localEulerAngles

				var_444_8.z = 0
				var_444_8.x = 0
				var_444_0.localEulerAngles = var_444_8
			end

			local var_444_9 = arg_441_1.actors_["10145ui_story"]
			local var_444_10 = 0

			if var_444_10 < arg_441_1.time_ and arg_441_1.time_ <= var_444_10 + arg_444_0 and not isNil(var_444_9) and arg_441_1.var_.characterEffect10145ui_story == nil then
				arg_441_1.var_.characterEffect10145ui_story = var_444_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_11 = 0.200000002980232

			if var_444_10 <= arg_441_1.time_ and arg_441_1.time_ < var_444_10 + var_444_11 and not isNil(var_444_9) then
				local var_444_12 = (arg_441_1.time_ - var_444_10) / var_444_11

				if arg_441_1.var_.characterEffect10145ui_story and not isNil(var_444_9) then
					arg_441_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= var_444_10 + var_444_11 and arg_441_1.time_ < var_444_10 + var_444_11 + arg_444_0 and not isNil(var_444_9) and arg_441_1.var_.characterEffect10145ui_story then
				arg_441_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_444_13 = 0

			if var_444_13 < arg_441_1.time_ and arg_441_1.time_ <= var_444_13 + arg_444_0 then
				arg_441_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action7_1")
			end

			local var_444_14 = 0

			if var_444_14 < arg_441_1.time_ and arg_441_1.time_ <= var_444_14 + arg_444_0 then
				arg_441_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_444_15 = 0
			local var_444_16 = 1.2

			if var_444_15 < arg_441_1.time_ and arg_441_1.time_ <= var_444_15 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_17 = arg_441_1:FormatText(StoryNameCfg[1308].name)

				arg_441_1.leftNameTxt_.text = var_444_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_18 = arg_441_1:GetWordFromCfg(421041109)
				local var_444_19 = arg_441_1:FormatText(var_444_18.content)

				arg_441_1.text_.text = var_444_19

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_20 = 46
				local var_444_21 = utf8.len(var_444_19)
				local var_444_22 = var_444_20 <= 0 and var_444_16 or var_444_16 * (var_444_21 / var_444_20)

				if var_444_22 > 0 and var_444_16 < var_444_22 then
					arg_441_1.talkMaxDuration = var_444_22

					if var_444_22 + var_444_15 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_22 + var_444_15
					end
				end

				arg_441_1.text_.text = var_444_19
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041109", "story_v_out_421041.awb") ~= 0 then
					local var_444_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041109", "story_v_out_421041.awb") / 1000

					if var_444_23 + var_444_15 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_23 + var_444_15
					end

					if var_444_18.prefab_name ~= "" and arg_441_1.actors_[var_444_18.prefab_name] ~= nil then
						local var_444_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_18.prefab_name].transform, "story_v_out_421041", "421041109", "story_v_out_421041.awb")

						arg_441_1:RecordAudio("421041109", var_444_24)
						arg_441_1:RecordAudio("421041109", var_444_24)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_421041", "421041109", "story_v_out_421041.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_421041", "421041109", "story_v_out_421041.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_25 = math.max(var_444_16, arg_441_1.talkMaxDuration)

			if var_444_15 <= arg_441_1.time_ and arg_441_1.time_ < var_444_15 + var_444_25 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_15) / var_444_25

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_15 + var_444_25 and arg_441_1.time_ < var_444_15 + var_444_25 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play421041110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 421041110
		arg_445_1.duration_ = 7.53

		local var_445_0 = {
			zh = 5.566,
			ja = 7.533
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play421041111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["10143ui_story"].transform
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.var_.moveOldPos10143ui_story = var_448_0.localPosition
			end

			local var_448_2 = 0.001

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2
				local var_448_4 = Vector3.New(-0.72, -1.06, -6)

				var_448_0.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10143ui_story, var_448_4, var_448_3)

				local var_448_5 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_5.x, var_448_5.y, var_448_5.z)

				local var_448_6 = var_448_0.localEulerAngles

				var_448_6.z = 0
				var_448_6.x = 0
				var_448_0.localEulerAngles = var_448_6
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 then
				var_448_0.localPosition = Vector3.New(-0.72, -1.06, -6)

				local var_448_7 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_7.x, var_448_7.y, var_448_7.z)

				local var_448_8 = var_448_0.localEulerAngles

				var_448_8.z = 0
				var_448_8.x = 0
				var_448_0.localEulerAngles = var_448_8
			end

			local var_448_9 = arg_445_1.actors_["10102ui_story"].transform
			local var_448_10 = 0

			if var_448_10 < arg_445_1.time_ and arg_445_1.time_ <= var_448_10 + arg_448_0 then
				arg_445_1.var_.moveOldPos10102ui_story = var_448_9.localPosition
			end

			local var_448_11 = 0.001

			if var_448_10 <= arg_445_1.time_ and arg_445_1.time_ < var_448_10 + var_448_11 then
				local var_448_12 = (arg_445_1.time_ - var_448_10) / var_448_11
				local var_448_13 = Vector3.New(0, 100, 0)

				var_448_9.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10102ui_story, var_448_13, var_448_12)

				local var_448_14 = manager.ui.mainCamera.transform.position - var_448_9.position

				var_448_9.forward = Vector3.New(var_448_14.x, var_448_14.y, var_448_14.z)

				local var_448_15 = var_448_9.localEulerAngles

				var_448_15.z = 0
				var_448_15.x = 0
				var_448_9.localEulerAngles = var_448_15
			end

			if arg_445_1.time_ >= var_448_10 + var_448_11 and arg_445_1.time_ < var_448_10 + var_448_11 + arg_448_0 then
				var_448_9.localPosition = Vector3.New(0, 100, 0)

				local var_448_16 = manager.ui.mainCamera.transform.position - var_448_9.position

				var_448_9.forward = Vector3.New(var_448_16.x, var_448_16.y, var_448_16.z)

				local var_448_17 = var_448_9.localEulerAngles

				var_448_17.z = 0
				var_448_17.x = 0
				var_448_9.localEulerAngles = var_448_17
			end

			local var_448_18 = arg_445_1.actors_["10143ui_story"]
			local var_448_19 = 0

			if var_448_19 < arg_445_1.time_ and arg_445_1.time_ <= var_448_19 + arg_448_0 and not isNil(var_448_18) and arg_445_1.var_.characterEffect10143ui_story == nil then
				arg_445_1.var_.characterEffect10143ui_story = var_448_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_20 = 0.200000002980232

			if var_448_19 <= arg_445_1.time_ and arg_445_1.time_ < var_448_19 + var_448_20 and not isNil(var_448_18) then
				local var_448_21 = (arg_445_1.time_ - var_448_19) / var_448_20

				if arg_445_1.var_.characterEffect10143ui_story and not isNil(var_448_18) then
					arg_445_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= var_448_19 + var_448_20 and arg_445_1.time_ < var_448_19 + var_448_20 + arg_448_0 and not isNil(var_448_18) and arg_445_1.var_.characterEffect10143ui_story then
				arg_445_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_448_22 = arg_445_1.actors_["10145ui_story"]
			local var_448_23 = 0

			if var_448_23 < arg_445_1.time_ and arg_445_1.time_ <= var_448_23 + arg_448_0 and not isNil(var_448_22) and arg_445_1.var_.characterEffect10145ui_story == nil then
				arg_445_1.var_.characterEffect10145ui_story = var_448_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_24 = 0.200000002980232

			if var_448_23 <= arg_445_1.time_ and arg_445_1.time_ < var_448_23 + var_448_24 and not isNil(var_448_22) then
				local var_448_25 = (arg_445_1.time_ - var_448_23) / var_448_24

				if arg_445_1.var_.characterEffect10145ui_story and not isNil(var_448_22) then
					local var_448_26 = Mathf.Lerp(0, 0.5, var_448_25)

					arg_445_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_445_1.var_.characterEffect10145ui_story.fillRatio = var_448_26
				end
			end

			if arg_445_1.time_ >= var_448_23 + var_448_24 and arg_445_1.time_ < var_448_23 + var_448_24 + arg_448_0 and not isNil(var_448_22) and arg_445_1.var_.characterEffect10145ui_story then
				local var_448_27 = 0.5

				arg_445_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_445_1.var_.characterEffect10145ui_story.fillRatio = var_448_27
			end

			local var_448_28 = 0

			if var_448_28 < arg_445_1.time_ and arg_445_1.time_ <= var_448_28 + arg_448_0 then
				arg_445_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_448_29 = 0

			if var_448_29 < arg_445_1.time_ and arg_445_1.time_ <= var_448_29 + arg_448_0 then
				arg_445_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_448_30 = 0
			local var_448_31 = 0.625

			if var_448_30 < arg_445_1.time_ and arg_445_1.time_ <= var_448_30 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_32 = arg_445_1:FormatText(StoryNameCfg[1307].name)

				arg_445_1.leftNameTxt_.text = var_448_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_33 = arg_445_1:GetWordFromCfg(421041110)
				local var_448_34 = arg_445_1:FormatText(var_448_33.content)

				arg_445_1.text_.text = var_448_34

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_35 = 25
				local var_448_36 = utf8.len(var_448_34)
				local var_448_37 = var_448_35 <= 0 and var_448_31 or var_448_31 * (var_448_36 / var_448_35)

				if var_448_37 > 0 and var_448_31 < var_448_37 then
					arg_445_1.talkMaxDuration = var_448_37

					if var_448_37 + var_448_30 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_37 + var_448_30
					end
				end

				arg_445_1.text_.text = var_448_34
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041110", "story_v_out_421041.awb") ~= 0 then
					local var_448_38 = manager.audio:GetVoiceLength("story_v_out_421041", "421041110", "story_v_out_421041.awb") / 1000

					if var_448_38 + var_448_30 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_38 + var_448_30
					end

					if var_448_33.prefab_name ~= "" and arg_445_1.actors_[var_448_33.prefab_name] ~= nil then
						local var_448_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_33.prefab_name].transform, "story_v_out_421041", "421041110", "story_v_out_421041.awb")

						arg_445_1:RecordAudio("421041110", var_448_39)
						arg_445_1:RecordAudio("421041110", var_448_39)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_421041", "421041110", "story_v_out_421041.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_421041", "421041110", "story_v_out_421041.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_40 = math.max(var_448_31, arg_445_1.talkMaxDuration)

			if var_448_30 <= arg_445_1.time_ and arg_445_1.time_ < var_448_30 + var_448_40 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_30) / var_448_40

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_30 + var_448_40 and arg_445_1.time_ < var_448_30 + var_448_40 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play421041111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 421041111
		arg_449_1.duration_ = 13.47

		local var_449_0 = {
			zh = 10.2,
			ja = 13.466
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play421041112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["10145ui_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos10145ui_story = var_452_0.localPosition
			end

			local var_452_2 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2
				local var_452_4 = Vector3.New(0.78, -1, -6.2)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10145ui_story, var_452_4, var_452_3)

				local var_452_5 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_5.x, var_452_5.y, var_452_5.z)

				local var_452_6 = var_452_0.localEulerAngles

				var_452_6.z = 0
				var_452_6.x = 0
				var_452_0.localEulerAngles = var_452_6
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_452_7 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_7.x, var_452_7.y, var_452_7.z)

				local var_452_8 = var_452_0.localEulerAngles

				var_452_8.z = 0
				var_452_8.x = 0
				var_452_0.localEulerAngles = var_452_8
			end

			local var_452_9 = arg_449_1.actors_["10145ui_story"]
			local var_452_10 = 0

			if var_452_10 < arg_449_1.time_ and arg_449_1.time_ <= var_452_10 + arg_452_0 and not isNil(var_452_9) and arg_449_1.var_.characterEffect10145ui_story == nil then
				arg_449_1.var_.characterEffect10145ui_story = var_452_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_11 = 0.200000002980232

			if var_452_10 <= arg_449_1.time_ and arg_449_1.time_ < var_452_10 + var_452_11 and not isNil(var_452_9) then
				local var_452_12 = (arg_449_1.time_ - var_452_10) / var_452_11

				if arg_449_1.var_.characterEffect10145ui_story and not isNil(var_452_9) then
					arg_449_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= var_452_10 + var_452_11 and arg_449_1.time_ < var_452_10 + var_452_11 + arg_452_0 and not isNil(var_452_9) and arg_449_1.var_.characterEffect10145ui_story then
				arg_449_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_452_13 = arg_449_1.actors_["10143ui_story"]
			local var_452_14 = 0

			if var_452_14 < arg_449_1.time_ and arg_449_1.time_ <= var_452_14 + arg_452_0 and not isNil(var_452_13) and arg_449_1.var_.characterEffect10143ui_story == nil then
				arg_449_1.var_.characterEffect10143ui_story = var_452_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_15 = 0.200000002980232

			if var_452_14 <= arg_449_1.time_ and arg_449_1.time_ < var_452_14 + var_452_15 and not isNil(var_452_13) then
				local var_452_16 = (arg_449_1.time_ - var_452_14) / var_452_15

				if arg_449_1.var_.characterEffect10143ui_story and not isNil(var_452_13) then
					local var_452_17 = Mathf.Lerp(0, 0.5, var_452_16)

					arg_449_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_449_1.var_.characterEffect10143ui_story.fillRatio = var_452_17
				end
			end

			if arg_449_1.time_ >= var_452_14 + var_452_15 and arg_449_1.time_ < var_452_14 + var_452_15 + arg_452_0 and not isNil(var_452_13) and arg_449_1.var_.characterEffect10143ui_story then
				local var_452_18 = 0.5

				arg_449_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_449_1.var_.characterEffect10143ui_story.fillRatio = var_452_18
			end

			local var_452_19 = 0

			if var_452_19 < arg_449_1.time_ and arg_449_1.time_ <= var_452_19 + arg_452_0 then
				arg_449_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action7_2")
			end

			local var_452_20 = 0

			if var_452_20 < arg_449_1.time_ and arg_449_1.time_ <= var_452_20 + arg_452_0 then
				arg_449_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_452_21 = 0
			local var_452_22 = 1.15

			if var_452_21 < arg_449_1.time_ and arg_449_1.time_ <= var_452_21 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_23 = arg_449_1:FormatText(StoryNameCfg[1308].name)

				arg_449_1.leftNameTxt_.text = var_452_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_24 = arg_449_1:GetWordFromCfg(421041111)
				local var_452_25 = arg_449_1:FormatText(var_452_24.content)

				arg_449_1.text_.text = var_452_25

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_26 = 46
				local var_452_27 = utf8.len(var_452_25)
				local var_452_28 = var_452_26 <= 0 and var_452_22 or var_452_22 * (var_452_27 / var_452_26)

				if var_452_28 > 0 and var_452_22 < var_452_28 then
					arg_449_1.talkMaxDuration = var_452_28

					if var_452_28 + var_452_21 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_28 + var_452_21
					end
				end

				arg_449_1.text_.text = var_452_25
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041111", "story_v_out_421041.awb") ~= 0 then
					local var_452_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041111", "story_v_out_421041.awb") / 1000

					if var_452_29 + var_452_21 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_29 + var_452_21
					end

					if var_452_24.prefab_name ~= "" and arg_449_1.actors_[var_452_24.prefab_name] ~= nil then
						local var_452_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_24.prefab_name].transform, "story_v_out_421041", "421041111", "story_v_out_421041.awb")

						arg_449_1:RecordAudio("421041111", var_452_30)
						arg_449_1:RecordAudio("421041111", var_452_30)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_421041", "421041111", "story_v_out_421041.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_421041", "421041111", "story_v_out_421041.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_31 = math.max(var_452_22, arg_449_1.talkMaxDuration)

			if var_452_21 <= arg_449_1.time_ and arg_449_1.time_ < var_452_21 + var_452_31 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_21) / var_452_31

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_21 + var_452_31 and arg_449_1.time_ < var_452_21 + var_452_31 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play421041112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 421041112
		arg_453_1.duration_ = 14.13

		local var_453_0 = {
			zh = 10.3,
			ja = 14.133
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play421041113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["1047ui_story"].transform
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.var_.moveOldPos1047ui_story = var_456_0.localPosition
			end

			local var_456_2 = 0.001

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2
				local var_456_4 = Vector3.New(0, -1.13, -6.2)

				var_456_0.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1047ui_story, var_456_4, var_456_3)

				local var_456_5 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_5.x, var_456_5.y, var_456_5.z)

				local var_456_6 = var_456_0.localEulerAngles

				var_456_6.z = 0
				var_456_6.x = 0
				var_456_0.localEulerAngles = var_456_6
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 then
				var_456_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_456_7 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_7.x, var_456_7.y, var_456_7.z)

				local var_456_8 = var_456_0.localEulerAngles

				var_456_8.z = 0
				var_456_8.x = 0
				var_456_0.localEulerAngles = var_456_8
			end

			local var_456_9 = arg_453_1.actors_["10145ui_story"].transform
			local var_456_10 = 0

			if var_456_10 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 then
				arg_453_1.var_.moveOldPos10145ui_story = var_456_9.localPosition
			end

			local var_456_11 = 0.001

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_11 then
				local var_456_12 = (arg_453_1.time_ - var_456_10) / var_456_11
				local var_456_13 = Vector3.New(0, 100, 0)

				var_456_9.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos10145ui_story, var_456_13, var_456_12)

				local var_456_14 = manager.ui.mainCamera.transform.position - var_456_9.position

				var_456_9.forward = Vector3.New(var_456_14.x, var_456_14.y, var_456_14.z)

				local var_456_15 = var_456_9.localEulerAngles

				var_456_15.z = 0
				var_456_15.x = 0
				var_456_9.localEulerAngles = var_456_15
			end

			if arg_453_1.time_ >= var_456_10 + var_456_11 and arg_453_1.time_ < var_456_10 + var_456_11 + arg_456_0 then
				var_456_9.localPosition = Vector3.New(0, 100, 0)

				local var_456_16 = manager.ui.mainCamera.transform.position - var_456_9.position

				var_456_9.forward = Vector3.New(var_456_16.x, var_456_16.y, var_456_16.z)

				local var_456_17 = var_456_9.localEulerAngles

				var_456_17.z = 0
				var_456_17.x = 0
				var_456_9.localEulerAngles = var_456_17
			end

			local var_456_18 = arg_453_1.actors_["10143ui_story"].transform
			local var_456_19 = 0

			if var_456_19 < arg_453_1.time_ and arg_453_1.time_ <= var_456_19 + arg_456_0 then
				arg_453_1.var_.moveOldPos10143ui_story = var_456_18.localPosition
			end

			local var_456_20 = 0.001

			if var_456_19 <= arg_453_1.time_ and arg_453_1.time_ < var_456_19 + var_456_20 then
				local var_456_21 = (arg_453_1.time_ - var_456_19) / var_456_20
				local var_456_22 = Vector3.New(0, 100, 0)

				var_456_18.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos10143ui_story, var_456_22, var_456_21)

				local var_456_23 = manager.ui.mainCamera.transform.position - var_456_18.position

				var_456_18.forward = Vector3.New(var_456_23.x, var_456_23.y, var_456_23.z)

				local var_456_24 = var_456_18.localEulerAngles

				var_456_24.z = 0
				var_456_24.x = 0
				var_456_18.localEulerAngles = var_456_24
			end

			if arg_453_1.time_ >= var_456_19 + var_456_20 and arg_453_1.time_ < var_456_19 + var_456_20 + arg_456_0 then
				var_456_18.localPosition = Vector3.New(0, 100, 0)

				local var_456_25 = manager.ui.mainCamera.transform.position - var_456_18.position

				var_456_18.forward = Vector3.New(var_456_25.x, var_456_25.y, var_456_25.z)

				local var_456_26 = var_456_18.localEulerAngles

				var_456_26.z = 0
				var_456_26.x = 0
				var_456_18.localEulerAngles = var_456_26
			end

			local var_456_27 = arg_453_1.actors_["1047ui_story"]
			local var_456_28 = 0

			if var_456_28 < arg_453_1.time_ and arg_453_1.time_ <= var_456_28 + arg_456_0 and not isNil(var_456_27) and arg_453_1.var_.characterEffect1047ui_story == nil then
				arg_453_1.var_.characterEffect1047ui_story = var_456_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_29 = 0.200000002980232

			if var_456_28 <= arg_453_1.time_ and arg_453_1.time_ < var_456_28 + var_456_29 and not isNil(var_456_27) then
				local var_456_30 = (arg_453_1.time_ - var_456_28) / var_456_29

				if arg_453_1.var_.characterEffect1047ui_story and not isNil(var_456_27) then
					arg_453_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= var_456_28 + var_456_29 and arg_453_1.time_ < var_456_28 + var_456_29 + arg_456_0 and not isNil(var_456_27) and arg_453_1.var_.characterEffect1047ui_story then
				arg_453_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_456_31 = arg_453_1.actors_["10145ui_story"]
			local var_456_32 = 0

			if var_456_32 < arg_453_1.time_ and arg_453_1.time_ <= var_456_32 + arg_456_0 and not isNil(var_456_31) and arg_453_1.var_.characterEffect10145ui_story == nil then
				arg_453_1.var_.characterEffect10145ui_story = var_456_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_33 = 0.200000002980232

			if var_456_32 <= arg_453_1.time_ and arg_453_1.time_ < var_456_32 + var_456_33 and not isNil(var_456_31) then
				local var_456_34 = (arg_453_1.time_ - var_456_32) / var_456_33

				if arg_453_1.var_.characterEffect10145ui_story and not isNil(var_456_31) then
					local var_456_35 = Mathf.Lerp(0, 0.5, var_456_34)

					arg_453_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_453_1.var_.characterEffect10145ui_story.fillRatio = var_456_35
				end
			end

			if arg_453_1.time_ >= var_456_32 + var_456_33 and arg_453_1.time_ < var_456_32 + var_456_33 + arg_456_0 and not isNil(var_456_31) and arg_453_1.var_.characterEffect10145ui_story then
				local var_456_36 = 0.5

				arg_453_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_453_1.var_.characterEffect10145ui_story.fillRatio = var_456_36
			end

			local var_456_37 = 0

			if var_456_37 < arg_453_1.time_ and arg_453_1.time_ <= var_456_37 + arg_456_0 then
				arg_453_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_456_38 = 0

			if var_456_38 < arg_453_1.time_ and arg_453_1.time_ <= var_456_38 + arg_456_0 then
				arg_453_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_456_39 = 0
			local var_456_40 = 1.275

			if var_456_39 < arg_453_1.time_ and arg_453_1.time_ <= var_456_39 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_41 = arg_453_1:FormatText(StoryNameCfg[1296].name)

				arg_453_1.leftNameTxt_.text = var_456_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_42 = arg_453_1:GetWordFromCfg(421041112)
				local var_456_43 = arg_453_1:FormatText(var_456_42.content)

				arg_453_1.text_.text = var_456_43

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_44 = 51
				local var_456_45 = utf8.len(var_456_43)
				local var_456_46 = var_456_44 <= 0 and var_456_40 or var_456_40 * (var_456_45 / var_456_44)

				if var_456_46 > 0 and var_456_40 < var_456_46 then
					arg_453_1.talkMaxDuration = var_456_46

					if var_456_46 + var_456_39 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_46 + var_456_39
					end
				end

				arg_453_1.text_.text = var_456_43
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041112", "story_v_out_421041.awb") ~= 0 then
					local var_456_47 = manager.audio:GetVoiceLength("story_v_out_421041", "421041112", "story_v_out_421041.awb") / 1000

					if var_456_47 + var_456_39 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_47 + var_456_39
					end

					if var_456_42.prefab_name ~= "" and arg_453_1.actors_[var_456_42.prefab_name] ~= nil then
						local var_456_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_42.prefab_name].transform, "story_v_out_421041", "421041112", "story_v_out_421041.awb")

						arg_453_1:RecordAudio("421041112", var_456_48)
						arg_453_1:RecordAudio("421041112", var_456_48)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_421041", "421041112", "story_v_out_421041.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_421041", "421041112", "story_v_out_421041.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_49 = math.max(var_456_40, arg_453_1.talkMaxDuration)

			if var_456_39 <= arg_453_1.time_ and arg_453_1.time_ < var_456_39 + var_456_49 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_39) / var_456_49

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_39 + var_456_49 and arg_453_1.time_ < var_456_39 + var_456_49 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play421041113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 421041113
		arg_457_1.duration_ = 13.17

		local var_457_0 = {
			zh = 8.933,
			ja = 13.166
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play421041114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = arg_457_1.actors_["1047ui_story"].transform
			local var_460_1 = 0

			if var_460_1 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.var_.moveOldPos1047ui_story = var_460_0.localPosition
			end

			local var_460_2 = 0.001

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_2 then
				local var_460_3 = (arg_457_1.time_ - var_460_1) / var_460_2
				local var_460_4 = Vector3.New(0, -1.13, -6.2)

				var_460_0.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1047ui_story, var_460_4, var_460_3)

				local var_460_5 = manager.ui.mainCamera.transform.position - var_460_0.position

				var_460_0.forward = Vector3.New(var_460_5.x, var_460_5.y, var_460_5.z)

				local var_460_6 = var_460_0.localEulerAngles

				var_460_6.z = 0
				var_460_6.x = 0
				var_460_0.localEulerAngles = var_460_6
			end

			if arg_457_1.time_ >= var_460_1 + var_460_2 and arg_457_1.time_ < var_460_1 + var_460_2 + arg_460_0 then
				var_460_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_460_7 = manager.ui.mainCamera.transform.position - var_460_0.position

				var_460_0.forward = Vector3.New(var_460_7.x, var_460_7.y, var_460_7.z)

				local var_460_8 = var_460_0.localEulerAngles

				var_460_8.z = 0
				var_460_8.x = 0
				var_460_0.localEulerAngles = var_460_8
			end

			local var_460_9 = 0

			if var_460_9 < arg_457_1.time_ and arg_457_1.time_ <= var_460_9 + arg_460_0 then
				arg_457_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_460_10 = 0
			local var_460_11 = 1.1

			if var_460_10 < arg_457_1.time_ and arg_457_1.time_ <= var_460_10 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_12 = arg_457_1:FormatText(StoryNameCfg[1296].name)

				arg_457_1.leftNameTxt_.text = var_460_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_13 = arg_457_1:GetWordFromCfg(421041113)
				local var_460_14 = arg_457_1:FormatText(var_460_13.content)

				arg_457_1.text_.text = var_460_14

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_15 = 44
				local var_460_16 = utf8.len(var_460_14)
				local var_460_17 = var_460_15 <= 0 and var_460_11 or var_460_11 * (var_460_16 / var_460_15)

				if var_460_17 > 0 and var_460_11 < var_460_17 then
					arg_457_1.talkMaxDuration = var_460_17

					if var_460_17 + var_460_10 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_17 + var_460_10
					end
				end

				arg_457_1.text_.text = var_460_14
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041113", "story_v_out_421041.awb") ~= 0 then
					local var_460_18 = manager.audio:GetVoiceLength("story_v_out_421041", "421041113", "story_v_out_421041.awb") / 1000

					if var_460_18 + var_460_10 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_18 + var_460_10
					end

					if var_460_13.prefab_name ~= "" and arg_457_1.actors_[var_460_13.prefab_name] ~= nil then
						local var_460_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_13.prefab_name].transform, "story_v_out_421041", "421041113", "story_v_out_421041.awb")

						arg_457_1:RecordAudio("421041113", var_460_19)
						arg_457_1:RecordAudio("421041113", var_460_19)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_421041", "421041113", "story_v_out_421041.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_421041", "421041113", "story_v_out_421041.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_20 = math.max(var_460_11, arg_457_1.talkMaxDuration)

			if var_460_10 <= arg_457_1.time_ and arg_457_1.time_ < var_460_10 + var_460_20 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_10) / var_460_20

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_10 + var_460_20 and arg_457_1.time_ < var_460_10 + var_460_20 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play421041114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 421041114
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play421041115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1047ui_story"].transform
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos1047ui_story = var_464_0.localPosition
			end

			local var_464_2 = 0.001

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2
				local var_464_4 = Vector3.New(0, 100, 0)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1047ui_story, var_464_4, var_464_3)

				local var_464_5 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_5.x, var_464_5.y, var_464_5.z)

				local var_464_6 = var_464_0.localEulerAngles

				var_464_6.z = 0
				var_464_6.x = 0
				var_464_0.localEulerAngles = var_464_6
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(0, 100, 0)

				local var_464_7 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_7.x, var_464_7.y, var_464_7.z)

				local var_464_8 = var_464_0.localEulerAngles

				var_464_8.z = 0
				var_464_8.x = 0
				var_464_0.localEulerAngles = var_464_8
			end

			local var_464_9 = 0
			local var_464_10 = 1.35

			if var_464_9 < arg_461_1.time_ and arg_461_1.time_ <= var_464_9 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_11 = arg_461_1:GetWordFromCfg(421041114)
				local var_464_12 = arg_461_1:FormatText(var_464_11.content)

				arg_461_1.text_.text = var_464_12

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_13 = 54
				local var_464_14 = utf8.len(var_464_12)
				local var_464_15 = var_464_13 <= 0 and var_464_10 or var_464_10 * (var_464_14 / var_464_13)

				if var_464_15 > 0 and var_464_10 < var_464_15 then
					arg_461_1.talkMaxDuration = var_464_15

					if var_464_15 + var_464_9 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_15 + var_464_9
					end
				end

				arg_461_1.text_.text = var_464_12
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_16 = math.max(var_464_10, arg_461_1.talkMaxDuration)

			if var_464_9 <= arg_461_1.time_ and arg_461_1.time_ < var_464_9 + var_464_16 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_9) / var_464_16

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_9 + var_464_16 and arg_461_1.time_ < var_464_9 + var_464_16 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play421041115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 421041115
		arg_465_1.duration_ = 9.7

		local var_465_0 = {
			zh = 6.7,
			ja = 9.7
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play421041116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["10145ui_story"].transform
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.var_.moveOldPos10145ui_story = var_468_0.localPosition
			end

			local var_468_2 = 0.001

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2
				local var_468_4 = Vector3.New(0, -1, -6.2)

				var_468_0.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos10145ui_story, var_468_4, var_468_3)

				local var_468_5 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_5.x, var_468_5.y, var_468_5.z)

				local var_468_6 = var_468_0.localEulerAngles

				var_468_6.z = 0
				var_468_6.x = 0
				var_468_0.localEulerAngles = var_468_6
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 then
				var_468_0.localPosition = Vector3.New(0, -1, -6.2)

				local var_468_7 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_7.x, var_468_7.y, var_468_7.z)

				local var_468_8 = var_468_0.localEulerAngles

				var_468_8.z = 0
				var_468_8.x = 0
				var_468_0.localEulerAngles = var_468_8
			end

			local var_468_9 = arg_465_1.actors_["10145ui_story"]
			local var_468_10 = 0

			if var_468_10 < arg_465_1.time_ and arg_465_1.time_ <= var_468_10 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect10145ui_story == nil then
				arg_465_1.var_.characterEffect10145ui_story = var_468_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_11 = 0.200000002980232

			if var_468_10 <= arg_465_1.time_ and arg_465_1.time_ < var_468_10 + var_468_11 and not isNil(var_468_9) then
				local var_468_12 = (arg_465_1.time_ - var_468_10) / var_468_11

				if arg_465_1.var_.characterEffect10145ui_story and not isNil(var_468_9) then
					arg_465_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= var_468_10 + var_468_11 and arg_465_1.time_ < var_468_10 + var_468_11 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect10145ui_story then
				arg_465_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_468_13 = 0

			if var_468_13 < arg_465_1.time_ and arg_465_1.time_ <= var_468_13 + arg_468_0 then
				arg_465_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_468_14 = 0

			if var_468_14 < arg_465_1.time_ and arg_465_1.time_ <= var_468_14 + arg_468_0 then
				arg_465_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_468_15 = 0
			local var_468_16 = 0.775

			if var_468_15 < arg_465_1.time_ and arg_465_1.time_ <= var_468_15 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_17 = arg_465_1:FormatText(StoryNameCfg[1308].name)

				arg_465_1.leftNameTxt_.text = var_468_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_18 = arg_465_1:GetWordFromCfg(421041115)
				local var_468_19 = arg_465_1:FormatText(var_468_18.content)

				arg_465_1.text_.text = var_468_19

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_20 = 31
				local var_468_21 = utf8.len(var_468_19)
				local var_468_22 = var_468_20 <= 0 and var_468_16 or var_468_16 * (var_468_21 / var_468_20)

				if var_468_22 > 0 and var_468_16 < var_468_22 then
					arg_465_1.talkMaxDuration = var_468_22

					if var_468_22 + var_468_15 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_22 + var_468_15
					end
				end

				arg_465_1.text_.text = var_468_19
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041115", "story_v_out_421041.awb") ~= 0 then
					local var_468_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041115", "story_v_out_421041.awb") / 1000

					if var_468_23 + var_468_15 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_23 + var_468_15
					end

					if var_468_18.prefab_name ~= "" and arg_465_1.actors_[var_468_18.prefab_name] ~= nil then
						local var_468_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_18.prefab_name].transform, "story_v_out_421041", "421041115", "story_v_out_421041.awb")

						arg_465_1:RecordAudio("421041115", var_468_24)
						arg_465_1:RecordAudio("421041115", var_468_24)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_421041", "421041115", "story_v_out_421041.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_421041", "421041115", "story_v_out_421041.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_25 = math.max(var_468_16, arg_465_1.talkMaxDuration)

			if var_468_15 <= arg_465_1.time_ and arg_465_1.time_ < var_468_15 + var_468_25 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_15) / var_468_25

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_15 + var_468_25 and arg_465_1.time_ < var_468_15 + var_468_25 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play421041116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 421041116
		arg_469_1.duration_ = 9

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play421041117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 2

			if var_472_0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				local var_472_1 = manager.ui.mainCamera.transform.localPosition
				local var_472_2 = Vector3.New(0, 0, 10) + Vector3.New(var_472_1.x, var_472_1.y, 0)
				local var_472_3 = arg_469_1.bgs_.ST2401

				var_472_3.transform.localPosition = var_472_2
				var_472_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_472_4 = var_472_3:GetComponent("SpriteRenderer")

				if var_472_4 and var_472_4.sprite then
					local var_472_5 = (var_472_3.transform.localPosition - var_472_1).z
					local var_472_6 = manager.ui.mainCameraCom_
					local var_472_7 = 2 * var_472_5 * Mathf.Tan(var_472_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_472_8 = var_472_7 * var_472_6.aspect
					local var_472_9 = var_472_4.sprite.bounds.size.x
					local var_472_10 = var_472_4.sprite.bounds.size.y
					local var_472_11 = var_472_8 / var_472_9
					local var_472_12 = var_472_7 / var_472_10
					local var_472_13 = var_472_12 < var_472_11 and var_472_11 or var_472_12

					var_472_3.transform.localScale = Vector3.New(var_472_13, var_472_13, 0)
				end

				for iter_472_0, iter_472_1 in pairs(arg_469_1.bgs_) do
					if iter_472_0 ~= "ST2401" then
						iter_472_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_472_14 = 4

			if var_472_14 < arg_469_1.time_ and arg_469_1.time_ <= var_472_14 + arg_472_0 then
				arg_469_1.allBtn_.enabled = false
			end

			local var_472_15 = 0.3

			if arg_469_1.time_ >= var_472_14 + var_472_15 and arg_469_1.time_ < var_472_14 + var_472_15 + arg_472_0 then
				arg_469_1.allBtn_.enabled = true
			end

			local var_472_16 = 0

			if var_472_16 < arg_469_1.time_ and arg_469_1.time_ <= var_472_16 + arg_472_0 then
				arg_469_1.mask_.enabled = true
				arg_469_1.mask_.raycastTarget = true

				arg_469_1:SetGaussion(false)
			end

			local var_472_17 = 2

			if var_472_16 <= arg_469_1.time_ and arg_469_1.time_ < var_472_16 + var_472_17 then
				local var_472_18 = (arg_469_1.time_ - var_472_16) / var_472_17
				local var_472_19 = Color.New(0, 0, 0)

				var_472_19.a = Mathf.Lerp(0, 1, var_472_18)
				arg_469_1.mask_.color = var_472_19
			end

			if arg_469_1.time_ >= var_472_16 + var_472_17 and arg_469_1.time_ < var_472_16 + var_472_17 + arg_472_0 then
				local var_472_20 = Color.New(0, 0, 0)

				var_472_20.a = 1
				arg_469_1.mask_.color = var_472_20
			end

			local var_472_21 = 2

			if var_472_21 < arg_469_1.time_ and arg_469_1.time_ <= var_472_21 + arg_472_0 then
				arg_469_1.mask_.enabled = true
				arg_469_1.mask_.raycastTarget = true

				arg_469_1:SetGaussion(false)
			end

			local var_472_22 = 2

			if var_472_21 <= arg_469_1.time_ and arg_469_1.time_ < var_472_21 + var_472_22 then
				local var_472_23 = (arg_469_1.time_ - var_472_21) / var_472_22
				local var_472_24 = Color.New(0, 0, 0)

				var_472_24.a = Mathf.Lerp(1, 0, var_472_23)
				arg_469_1.mask_.color = var_472_24
			end

			if arg_469_1.time_ >= var_472_21 + var_472_22 and arg_469_1.time_ < var_472_21 + var_472_22 + arg_472_0 then
				local var_472_25 = Color.New(0, 0, 0)
				local var_472_26 = 0

				arg_469_1.mask_.enabled = false
				var_472_25.a = var_472_26
				arg_469_1.mask_.color = var_472_25
			end

			local var_472_27 = arg_469_1.actors_["10145ui_story"].transform
			local var_472_28 = 1.96599999815226

			if var_472_28 < arg_469_1.time_ and arg_469_1.time_ <= var_472_28 + arg_472_0 then
				arg_469_1.var_.moveOldPos10145ui_story = var_472_27.localPosition
			end

			local var_472_29 = 0.001

			if var_472_28 <= arg_469_1.time_ and arg_469_1.time_ < var_472_28 + var_472_29 then
				local var_472_30 = (arg_469_1.time_ - var_472_28) / var_472_29
				local var_472_31 = Vector3.New(0, 100, 0)

				var_472_27.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10145ui_story, var_472_31, var_472_30)

				local var_472_32 = manager.ui.mainCamera.transform.position - var_472_27.position

				var_472_27.forward = Vector3.New(var_472_32.x, var_472_32.y, var_472_32.z)

				local var_472_33 = var_472_27.localEulerAngles

				var_472_33.z = 0
				var_472_33.x = 0
				var_472_27.localEulerAngles = var_472_33
			end

			if arg_469_1.time_ >= var_472_28 + var_472_29 and arg_469_1.time_ < var_472_28 + var_472_29 + arg_472_0 then
				var_472_27.localPosition = Vector3.New(0, 100, 0)

				local var_472_34 = manager.ui.mainCamera.transform.position - var_472_27.position

				var_472_27.forward = Vector3.New(var_472_34.x, var_472_34.y, var_472_34.z)

				local var_472_35 = var_472_27.localEulerAngles

				var_472_35.z = 0
				var_472_35.x = 0
				var_472_27.localEulerAngles = var_472_35
			end

			local var_472_36 = 0.1
			local var_472_37 = 1

			if var_472_36 < arg_469_1.time_ and arg_469_1.time_ <= var_472_36 + arg_472_0 then
				local var_472_38 = "stop"
				local var_472_39 = "effect"

				arg_469_1:AudioAction(var_472_38, var_472_39, "se_story_142", "se_story_142_amb_city_street", "")
			end

			local var_472_40 = 1.63333333333333
			local var_472_41 = 1

			if var_472_40 < arg_469_1.time_ and arg_469_1.time_ <= var_472_40 + arg_472_0 then
				local var_472_42 = "play"
				local var_472_43 = "effect"

				arg_469_1:AudioAction(var_472_42, var_472_43, "se_story_side_1095", "se_story_side_1095_amb_car", "")
			end

			if arg_469_1.frameCnt_ <= 1 then
				arg_469_1.dialog_:SetActive(false)
			end

			local var_472_44 = 4
			local var_472_45 = 1.05

			if var_472_44 < arg_469_1.time_ and arg_469_1.time_ <= var_472_44 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0

				arg_469_1.dialog_:SetActive(true)

				arg_469_1.dialogCg_.alpha = 0

				local var_472_46 = LeanTween.value(arg_469_1.dialog_, 0, 1, 0.3)

				var_472_46:setOnUpdate(LuaHelper.FloatAction(function(arg_473_0)
					arg_469_1.dialogCg_.alpha = arg_473_0
				end))
				var_472_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_469_1.dialog_)
					var_472_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_469_1.duration_ = arg_469_1.duration_ + 0.3

				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_47 = arg_469_1:GetWordFromCfg(421041116)
				local var_472_48 = arg_469_1:FormatText(var_472_47.content)

				arg_469_1.text_.text = var_472_48

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_49 = 42
				local var_472_50 = utf8.len(var_472_48)
				local var_472_51 = var_472_49 <= 0 and var_472_45 or var_472_45 * (var_472_50 / var_472_49)

				if var_472_51 > 0 and var_472_45 < var_472_51 then
					arg_469_1.talkMaxDuration = var_472_51
					var_472_44 = var_472_44 + 0.3

					if var_472_51 + var_472_44 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_51 + var_472_44
					end
				end

				arg_469_1.text_.text = var_472_48
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_52 = var_472_44 + 0.3
			local var_472_53 = math.max(var_472_45, arg_469_1.talkMaxDuration)

			if var_472_52 <= arg_469_1.time_ and arg_469_1.time_ < var_472_52 + var_472_53 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_52) / var_472_53

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_52 + var_472_53 and arg_469_1.time_ < var_472_52 + var_472_53 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play421041117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 421041117
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play421041118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 0
			local var_478_1 = 0.225

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_2 = arg_475_1:FormatText(StoryNameCfg[7].name)

				arg_475_1.leftNameTxt_.text = var_478_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, true)
				arg_475_1.iconController_:SetSelectedState("hero")

				arg_475_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_475_1.callingController_:SetSelectedState("normal")

				arg_475_1.keyicon_.color = Color.New(1, 1, 1)
				arg_475_1.icon_.color = Color.New(1, 1, 1)

				local var_478_3 = arg_475_1:GetWordFromCfg(421041117)
				local var_478_4 = arg_475_1:FormatText(var_478_3.content)

				arg_475_1.text_.text = var_478_4

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_5 = 9
				local var_478_6 = utf8.len(var_478_4)
				local var_478_7 = var_478_5 <= 0 and var_478_1 or var_478_1 * (var_478_6 / var_478_5)

				if var_478_7 > 0 and var_478_1 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_0
					end
				end

				arg_475_1.text_.text = var_478_4
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_8 = math.max(var_478_1, arg_475_1.talkMaxDuration)

			if var_478_0 <= arg_475_1.time_ and arg_475_1.time_ < var_478_0 + var_478_8 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_0) / var_478_8

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_0 + var_478_8 and arg_475_1.time_ < var_478_0 + var_478_8 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play421041118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 421041118
		arg_479_1.duration_ = 7.5

		local var_479_0 = {
			zh = 5.133,
			ja = 7.5
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play421041119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0
			local var_482_1 = 0.925

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_2 = arg_479_1:FormatText(StoryNameCfg[1302].name)

				arg_479_1.leftNameTxt_.text = var_482_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, true)
				arg_479_1.iconController_:SetSelectedState("hero")

				arg_479_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_479_1.callingController_:SetSelectedState("calling")

				arg_479_1.keyicon_.color = Color.New(1, 1, 1)
				arg_479_1.icon_.color = Color.New(1, 1, 1)

				local var_482_3 = arg_479_1:GetWordFromCfg(421041118)
				local var_482_4 = arg_479_1:FormatText(var_482_3.content)

				arg_479_1.text_.text = var_482_4

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 37
				local var_482_6 = utf8.len(var_482_4)
				local var_482_7 = var_482_5 <= 0 and var_482_1 or var_482_1 * (var_482_6 / var_482_5)

				if var_482_7 > 0 and var_482_1 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_0
					end
				end

				arg_479_1.text_.text = var_482_4
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041118", "story_v_out_421041.awb") ~= 0 then
					local var_482_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041118", "story_v_out_421041.awb") / 1000

					if var_482_8 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_8 + var_482_0
					end

					if var_482_3.prefab_name ~= "" and arg_479_1.actors_[var_482_3.prefab_name] ~= nil then
						local var_482_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_3.prefab_name].transform, "story_v_out_421041", "421041118", "story_v_out_421041.awb")

						arg_479_1:RecordAudio("421041118", var_482_9)
						arg_479_1:RecordAudio("421041118", var_482_9)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_421041", "421041118", "story_v_out_421041.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_421041", "421041118", "story_v_out_421041.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_10 = math.max(var_482_1, arg_479_1.talkMaxDuration)

			if var_482_0 <= arg_479_1.time_ and arg_479_1.time_ < var_482_0 + var_482_10 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_0) / var_482_10

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_0 + var_482_10 and arg_479_1.time_ < var_482_0 + var_482_10 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play421041119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 421041119
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play421041120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 0.525

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_2 = arg_483_1:GetWordFromCfg(421041119)
				local var_486_3 = arg_483_1:FormatText(var_486_2.content)

				arg_483_1.text_.text = var_486_3

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 21
				local var_486_5 = utf8.len(var_486_3)
				local var_486_6 = var_486_4 <= 0 and var_486_1 or var_486_1 * (var_486_5 / var_486_4)

				if var_486_6 > 0 and var_486_1 < var_486_6 then
					arg_483_1.talkMaxDuration = var_486_6

					if var_486_6 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_6 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_3
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_7 and arg_483_1.time_ < var_486_0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play421041120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 421041120
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play421041121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 0.675

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_2 = arg_487_1:FormatText(StoryNameCfg[7].name)

				arg_487_1.leftNameTxt_.text = var_490_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_3 = arg_487_1:GetWordFromCfg(421041120)
				local var_490_4 = arg_487_1:FormatText(var_490_3.content)

				arg_487_1.text_.text = var_490_4

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_5 = 27
				local var_490_6 = utf8.len(var_490_4)
				local var_490_7 = var_490_5 <= 0 and var_490_1 or var_490_1 * (var_490_6 / var_490_5)

				if var_490_7 > 0 and var_490_1 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_4
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_8 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_8 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_8

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_8 and arg_487_1.time_ < var_490_0 + var_490_8 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play421041121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 421041121
		arg_491_1.duration_ = 6.83

		local var_491_0 = {
			zh = 4.133,
			ja = 6.833
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play421041122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0
			local var_494_1 = 0.625

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_2 = arg_491_1:FormatText(StoryNameCfg[1302].name)

				arg_491_1.leftNameTxt_.text = var_494_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_491_1.callingController_:SetSelectedState("calling")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_3 = arg_491_1:GetWordFromCfg(421041121)
				local var_494_4 = arg_491_1:FormatText(var_494_3.content)

				arg_491_1.text_.text = var_494_4

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 25
				local var_494_6 = utf8.len(var_494_4)
				local var_494_7 = var_494_5 <= 0 and var_494_1 or var_494_1 * (var_494_6 / var_494_5)

				if var_494_7 > 0 and var_494_1 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_4
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041121", "story_v_out_421041.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041121", "story_v_out_421041.awb") / 1000

					if var_494_8 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_0
					end

					if var_494_3.prefab_name ~= "" and arg_491_1.actors_[var_494_3.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_3.prefab_name].transform, "story_v_out_421041", "421041121", "story_v_out_421041.awb")

						arg_491_1:RecordAudio("421041121", var_494_9)
						arg_491_1:RecordAudio("421041121", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_421041", "421041121", "story_v_out_421041.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_421041", "421041121", "story_v_out_421041.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_10 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_10 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_0) / var_494_10

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_10 and arg_491_1.time_ < var_494_0 + var_494_10 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play421041122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 421041122
		arg_495_1.duration_ = 13.27

		local var_495_0 = {
			zh = 8.7,
			ja = 13.266
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play421041123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 1.2

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[1302].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_495_1.callingController_:SetSelectedState("calling")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_3 = arg_495_1:GetWordFromCfg(421041122)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 48
				local var_498_6 = utf8.len(var_498_4)
				local var_498_7 = var_498_5 <= 0 and var_498_1 or var_498_1 * (var_498_6 / var_498_5)

				if var_498_7 > 0 and var_498_1 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041122", "story_v_out_421041.awb") ~= 0 then
					local var_498_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041122", "story_v_out_421041.awb") / 1000

					if var_498_8 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_0
					end

					if var_498_3.prefab_name ~= "" and arg_495_1.actors_[var_498_3.prefab_name] ~= nil then
						local var_498_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_3.prefab_name].transform, "story_v_out_421041", "421041122", "story_v_out_421041.awb")

						arg_495_1:RecordAudio("421041122", var_498_9)
						arg_495_1:RecordAudio("421041122", var_498_9)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_421041", "421041122", "story_v_out_421041.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_421041", "421041122", "story_v_out_421041.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_10 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_10 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_10

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_10 and arg_495_1.time_ < var_498_0 + var_498_10 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play421041123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 421041123
		arg_499_1.duration_ = 11.07

		local var_499_0 = {
			zh = 10.766,
			ja = 11.066
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play421041124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 1.275

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_2 = arg_499_1:FormatText(StoryNameCfg[1302].name)

				arg_499_1.leftNameTxt_.text = var_502_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_499_1.callingController_:SetSelectedState("calling")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_3 = arg_499_1:GetWordFromCfg(421041123)
				local var_502_4 = arg_499_1:FormatText(var_502_3.content)

				arg_499_1.text_.text = var_502_4

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_5 = 51
				local var_502_6 = utf8.len(var_502_4)
				local var_502_7 = var_502_5 <= 0 and var_502_1 or var_502_1 * (var_502_6 / var_502_5)

				if var_502_7 > 0 and var_502_1 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_4
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041123", "story_v_out_421041.awb") ~= 0 then
					local var_502_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041123", "story_v_out_421041.awb") / 1000

					if var_502_8 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_0
					end

					if var_502_3.prefab_name ~= "" and arg_499_1.actors_[var_502_3.prefab_name] ~= nil then
						local var_502_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_3.prefab_name].transform, "story_v_out_421041", "421041123", "story_v_out_421041.awb")

						arg_499_1:RecordAudio("421041123", var_502_9)
						arg_499_1:RecordAudio("421041123", var_502_9)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_421041", "421041123", "story_v_out_421041.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_421041", "421041123", "story_v_out_421041.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_10 and arg_499_1.time_ < var_502_0 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play421041124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 421041124
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play421041125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0
			local var_506_1 = 0.225

			if var_506_0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_2 = arg_503_1:FormatText(StoryNameCfg[7].name)

				arg_503_1.leftNameTxt_.text = var_506_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_3 = arg_503_1:GetWordFromCfg(421041124)
				local var_506_4 = arg_503_1:FormatText(var_506_3.content)

				arg_503_1.text_.text = var_506_4

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 9
				local var_506_6 = utf8.len(var_506_4)
				local var_506_7 = var_506_5 <= 0 and var_506_1 or var_506_1 * (var_506_6 / var_506_5)

				if var_506_7 > 0 and var_506_1 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_0
					end
				end

				arg_503_1.text_.text = var_506_4
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_8 = math.max(var_506_1, arg_503_1.talkMaxDuration)

			if var_506_0 <= arg_503_1.time_ and arg_503_1.time_ < var_506_0 + var_506_8 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_0) / var_506_8

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_0 + var_506_8 and arg_503_1.time_ < var_506_0 + var_506_8 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play421041125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 421041125
		arg_507_1.duration_ = 20.6

		local var_507_0 = {
			zh = 14.2,
			ja = 20.6
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play421041126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 1.6

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_2 = arg_507_1:FormatText(StoryNameCfg[1302].name)

				arg_507_1.leftNameTxt_.text = var_510_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_507_1.callingController_:SetSelectedState("calling")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_3 = arg_507_1:GetWordFromCfg(421041125)
				local var_510_4 = arg_507_1:FormatText(var_510_3.content)

				arg_507_1.text_.text = var_510_4

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 64
				local var_510_6 = utf8.len(var_510_4)
				local var_510_7 = var_510_5 <= 0 and var_510_1 or var_510_1 * (var_510_6 / var_510_5)

				if var_510_7 > 0 and var_510_1 < var_510_7 then
					arg_507_1.talkMaxDuration = var_510_7

					if var_510_7 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_7 + var_510_0
					end
				end

				arg_507_1.text_.text = var_510_4
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041125", "story_v_out_421041.awb") ~= 0 then
					local var_510_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041125", "story_v_out_421041.awb") / 1000

					if var_510_8 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_8 + var_510_0
					end

					if var_510_3.prefab_name ~= "" and arg_507_1.actors_[var_510_3.prefab_name] ~= nil then
						local var_510_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_3.prefab_name].transform, "story_v_out_421041", "421041125", "story_v_out_421041.awb")

						arg_507_1:RecordAudio("421041125", var_510_9)
						arg_507_1:RecordAudio("421041125", var_510_9)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_421041", "421041125", "story_v_out_421041.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_421041", "421041125", "story_v_out_421041.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_10 = math.max(var_510_1, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_10 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_0) / var_510_10

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_10 and arg_507_1.time_ < var_510_0 + var_510_10 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play421041126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 421041126
		arg_511_1.duration_ = 12

		local var_511_0 = {
			zh = 9.433,
			ja = 12
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
				arg_511_0:Play421041127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0
			local var_514_1 = 1.3

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_2 = arg_511_1:FormatText(StoryNameCfg[1302].name)

				arg_511_1.leftNameTxt_.text = var_514_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_511_1.callingController_:SetSelectedState("calling")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_3 = arg_511_1:GetWordFromCfg(421041126)
				local var_514_4 = arg_511_1:FormatText(var_514_3.content)

				arg_511_1.text_.text = var_514_4

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 52
				local var_514_6 = utf8.len(var_514_4)
				local var_514_7 = var_514_5 <= 0 and var_514_1 or var_514_1 * (var_514_6 / var_514_5)

				if var_514_7 > 0 and var_514_1 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_0
					end
				end

				arg_511_1.text_.text = var_514_4
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041126", "story_v_out_421041.awb") ~= 0 then
					local var_514_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041126", "story_v_out_421041.awb") / 1000

					if var_514_8 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_8 + var_514_0
					end

					if var_514_3.prefab_name ~= "" and arg_511_1.actors_[var_514_3.prefab_name] ~= nil then
						local var_514_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_3.prefab_name].transform, "story_v_out_421041", "421041126", "story_v_out_421041.awb")

						arg_511_1:RecordAudio("421041126", var_514_9)
						arg_511_1:RecordAudio("421041126", var_514_9)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_421041", "421041126", "story_v_out_421041.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_421041", "421041126", "story_v_out_421041.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_10 = math.max(var_514_1, arg_511_1.talkMaxDuration)

			if var_514_0 <= arg_511_1.time_ and arg_511_1.time_ < var_514_0 + var_514_10 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_0) / var_514_10

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_0 + var_514_10 and arg_511_1.time_ < var_514_0 + var_514_10 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play421041127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 421041127
		arg_515_1.duration_ = 13.47

		local var_515_0 = {
			zh = 7.8,
			ja = 13.466
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
				arg_515_0:Play421041128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0
			local var_518_1 = 1.1

			if var_518_0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_2 = arg_515_1:FormatText(StoryNameCfg[1302].name)

				arg_515_1.leftNameTxt_.text = var_518_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_515_1.callingController_:SetSelectedState("calling")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_3 = arg_515_1:GetWordFromCfg(421041127)
				local var_518_4 = arg_515_1:FormatText(var_518_3.content)

				arg_515_1.text_.text = var_518_4

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_5 = 44
				local var_518_6 = utf8.len(var_518_4)
				local var_518_7 = var_518_5 <= 0 and var_518_1 or var_518_1 * (var_518_6 / var_518_5)

				if var_518_7 > 0 and var_518_1 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_0
					end
				end

				arg_515_1.text_.text = var_518_4
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041127", "story_v_out_421041.awb") ~= 0 then
					local var_518_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041127", "story_v_out_421041.awb") / 1000

					if var_518_8 + var_518_0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_8 + var_518_0
					end

					if var_518_3.prefab_name ~= "" and arg_515_1.actors_[var_518_3.prefab_name] ~= nil then
						local var_518_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_3.prefab_name].transform, "story_v_out_421041", "421041127", "story_v_out_421041.awb")

						arg_515_1:RecordAudio("421041127", var_518_9)
						arg_515_1:RecordAudio("421041127", var_518_9)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_421041", "421041127", "story_v_out_421041.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_421041", "421041127", "story_v_out_421041.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_10 = math.max(var_518_1, arg_515_1.talkMaxDuration)

			if var_518_0 <= arg_515_1.time_ and arg_515_1.time_ < var_518_0 + var_518_10 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_0) / var_518_10

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_0 + var_518_10 and arg_515_1.time_ < var_518_0 + var_518_10 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play421041128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 421041128
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play421041129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 0.65

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_2 = arg_519_1:FormatText(StoryNameCfg[7].name)

				arg_519_1.leftNameTxt_.text = var_522_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_3 = arg_519_1:GetWordFromCfg(421041128)
				local var_522_4 = arg_519_1:FormatText(var_522_3.content)

				arg_519_1.text_.text = var_522_4

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 26
				local var_522_6 = utf8.len(var_522_4)
				local var_522_7 = var_522_5 <= 0 and var_522_1 or var_522_1 * (var_522_6 / var_522_5)

				if var_522_7 > 0 and var_522_1 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_4
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_8 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_8 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_8

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_8 and arg_519_1.time_ < var_522_0 + var_522_8 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play421041129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 421041129
		arg_523_1.duration_ = 8.2

		local var_523_0 = {
			zh = 6.3,
			ja = 8.2
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play421041130(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 0.85

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_2 = arg_523_1:FormatText(StoryNameCfg[1302].name)

				arg_523_1.leftNameTxt_.text = var_526_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_523_1.callingController_:SetSelectedState("calling")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:GetWordFromCfg(421041129)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 34
				local var_526_6 = utf8.len(var_526_4)
				local var_526_7 = var_526_5 <= 0 and var_526_1 or var_526_1 * (var_526_6 / var_526_5)

				if var_526_7 > 0 and var_526_1 < var_526_7 then
					arg_523_1.talkMaxDuration = var_526_7

					if var_526_7 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_4
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041129", "story_v_out_421041.awb") ~= 0 then
					local var_526_8 = manager.audio:GetVoiceLength("story_v_out_421041", "421041129", "story_v_out_421041.awb") / 1000

					if var_526_8 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_8 + var_526_0
					end

					if var_526_3.prefab_name ~= "" and arg_523_1.actors_[var_526_3.prefab_name] ~= nil then
						local var_526_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_3.prefab_name].transform, "story_v_out_421041", "421041129", "story_v_out_421041.awb")

						arg_523_1:RecordAudio("421041129", var_526_9)
						arg_523_1:RecordAudio("421041129", var_526_9)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_421041", "421041129", "story_v_out_421041.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_421041", "421041129", "story_v_out_421041.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_10 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_10 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_10

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_10 and arg_523_1.time_ < var_526_0 + var_526_10 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play421041130 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 421041130
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play421041131(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 0.775

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_2 = arg_527_1:GetWordFromCfg(421041130)
				local var_530_3 = arg_527_1:FormatText(var_530_2.content)

				arg_527_1.text_.text = var_530_3

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 31
				local var_530_5 = utf8.len(var_530_3)
				local var_530_6 = var_530_4 <= 0 and var_530_1 or var_530_1 * (var_530_5 / var_530_4)

				if var_530_6 > 0 and var_530_1 < var_530_6 then
					arg_527_1.talkMaxDuration = var_530_6

					if var_530_6 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_6 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_3
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_7 and arg_527_1.time_ < var_530_0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play421041131 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 421041131
		arg_531_1.duration_ = 8.27

		local var_531_0 = {
			zh = 4.9,
			ja = 8.266
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
				arg_531_0:Play421041132(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["1047ui_story"].transform
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.var_.moveOldPos1047ui_story = var_534_0.localPosition
			end

			local var_534_2 = 0.001

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2
				local var_534_4 = Vector3.New(-0.6, -1.13, -6.2)

				var_534_0.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1047ui_story, var_534_4, var_534_3)

				local var_534_5 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_5.x, var_534_5.y, var_534_5.z)

				local var_534_6 = var_534_0.localEulerAngles

				var_534_6.z = 0
				var_534_6.x = 0
				var_534_0.localEulerAngles = var_534_6
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 then
				var_534_0.localPosition = Vector3.New(-0.6, -1.13, -6.2)

				local var_534_7 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_7.x, var_534_7.y, var_534_7.z)

				local var_534_8 = var_534_0.localEulerAngles

				var_534_8.z = 0
				var_534_8.x = 0
				var_534_0.localEulerAngles = var_534_8
			end

			local var_534_9 = arg_531_1.actors_["1047ui_story"]
			local var_534_10 = 0

			if var_534_10 < arg_531_1.time_ and arg_531_1.time_ <= var_534_10 + arg_534_0 and not isNil(var_534_9) and arg_531_1.var_.characterEffect1047ui_story == nil then
				arg_531_1.var_.characterEffect1047ui_story = var_534_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_11 = 0.200000002980232

			if var_534_10 <= arg_531_1.time_ and arg_531_1.time_ < var_534_10 + var_534_11 and not isNil(var_534_9) then
				local var_534_12 = (arg_531_1.time_ - var_534_10) / var_534_11

				if arg_531_1.var_.characterEffect1047ui_story and not isNil(var_534_9) then
					arg_531_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= var_534_10 + var_534_11 and arg_531_1.time_ < var_534_10 + var_534_11 + arg_534_0 and not isNil(var_534_9) and arg_531_1.var_.characterEffect1047ui_story then
				arg_531_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_534_13 = 0

			if var_534_13 < arg_531_1.time_ and arg_531_1.time_ <= var_534_13 + arg_534_0 then
				arg_531_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_534_14 = 0

			if var_534_14 < arg_531_1.time_ and arg_531_1.time_ <= var_534_14 + arg_534_0 then
				arg_531_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_534_15 = 0
			local var_534_16 = 0.525

			if var_534_15 < arg_531_1.time_ and arg_531_1.time_ <= var_534_15 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_17 = arg_531_1:FormatText(StoryNameCfg[1296].name)

				arg_531_1.leftNameTxt_.text = var_534_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_18 = arg_531_1:GetWordFromCfg(421041131)
				local var_534_19 = arg_531_1:FormatText(var_534_18.content)

				arg_531_1.text_.text = var_534_19

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_20 = 21
				local var_534_21 = utf8.len(var_534_19)
				local var_534_22 = var_534_20 <= 0 and var_534_16 or var_534_16 * (var_534_21 / var_534_20)

				if var_534_22 > 0 and var_534_16 < var_534_22 then
					arg_531_1.talkMaxDuration = var_534_22

					if var_534_22 + var_534_15 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_22 + var_534_15
					end
				end

				arg_531_1.text_.text = var_534_19
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041131", "story_v_out_421041.awb") ~= 0 then
					local var_534_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041131", "story_v_out_421041.awb") / 1000

					if var_534_23 + var_534_15 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_23 + var_534_15
					end

					if var_534_18.prefab_name ~= "" and arg_531_1.actors_[var_534_18.prefab_name] ~= nil then
						local var_534_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_18.prefab_name].transform, "story_v_out_421041", "421041131", "story_v_out_421041.awb")

						arg_531_1:RecordAudio("421041131", var_534_24)
						arg_531_1:RecordAudio("421041131", var_534_24)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_421041", "421041131", "story_v_out_421041.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_421041", "421041131", "story_v_out_421041.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_25 = math.max(var_534_16, arg_531_1.talkMaxDuration)

			if var_534_15 <= arg_531_1.time_ and arg_531_1.time_ < var_534_15 + var_534_25 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_15) / var_534_25

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_15 + var_534_25 and arg_531_1.time_ < var_534_15 + var_534_25 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play421041132 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 421041132
		arg_535_1.duration_ = 5.77

		local var_535_0 = {
			zh = 2.5,
			ja = 5.766
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
				arg_535_0:Play421041133(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["10143ui_story"].transform
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.var_.moveOldPos10143ui_story = var_538_0.localPosition
			end

			local var_538_2 = 0.001

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2
				local var_538_4 = Vector3.New(0.78, -1.06, -6)

				var_538_0.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos10143ui_story, var_538_4, var_538_3)

				local var_538_5 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_5.x, var_538_5.y, var_538_5.z)

				local var_538_6 = var_538_0.localEulerAngles

				var_538_6.z = 0
				var_538_6.x = 0
				var_538_0.localEulerAngles = var_538_6
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 then
				var_538_0.localPosition = Vector3.New(0.78, -1.06, -6)

				local var_538_7 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_7.x, var_538_7.y, var_538_7.z)

				local var_538_8 = var_538_0.localEulerAngles

				var_538_8.z = 0
				var_538_8.x = 0
				var_538_0.localEulerAngles = var_538_8
			end

			local var_538_9 = arg_535_1.actors_["10143ui_story"]
			local var_538_10 = 0

			if var_538_10 < arg_535_1.time_ and arg_535_1.time_ <= var_538_10 + arg_538_0 and not isNil(var_538_9) and arg_535_1.var_.characterEffect10143ui_story == nil then
				arg_535_1.var_.characterEffect10143ui_story = var_538_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_11 = 0.200000002980232

			if var_538_10 <= arg_535_1.time_ and arg_535_1.time_ < var_538_10 + var_538_11 and not isNil(var_538_9) then
				local var_538_12 = (arg_535_1.time_ - var_538_10) / var_538_11

				if arg_535_1.var_.characterEffect10143ui_story and not isNil(var_538_9) then
					arg_535_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= var_538_10 + var_538_11 and arg_535_1.time_ < var_538_10 + var_538_11 + arg_538_0 and not isNil(var_538_9) and arg_535_1.var_.characterEffect10143ui_story then
				arg_535_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_538_13 = arg_535_1.actors_["1047ui_story"]
			local var_538_14 = 0

			if var_538_14 < arg_535_1.time_ and arg_535_1.time_ <= var_538_14 + arg_538_0 and not isNil(var_538_13) and arg_535_1.var_.characterEffect1047ui_story == nil then
				arg_535_1.var_.characterEffect1047ui_story = var_538_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_15 = 0.200000002980232

			if var_538_14 <= arg_535_1.time_ and arg_535_1.time_ < var_538_14 + var_538_15 and not isNil(var_538_13) then
				local var_538_16 = (arg_535_1.time_ - var_538_14) / var_538_15

				if arg_535_1.var_.characterEffect1047ui_story and not isNil(var_538_13) then
					local var_538_17 = Mathf.Lerp(0, 0.5, var_538_16)

					arg_535_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1047ui_story.fillRatio = var_538_17
				end
			end

			if arg_535_1.time_ >= var_538_14 + var_538_15 and arg_535_1.time_ < var_538_14 + var_538_15 + arg_538_0 and not isNil(var_538_13) and arg_535_1.var_.characterEffect1047ui_story then
				local var_538_18 = 0.5

				arg_535_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1047ui_story.fillRatio = var_538_18
			end

			local var_538_19 = 0

			if var_538_19 < arg_535_1.time_ and arg_535_1.time_ <= var_538_19 + arg_538_0 then
				arg_535_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			local var_538_20 = 0

			if var_538_20 < arg_535_1.time_ and arg_535_1.time_ <= var_538_20 + arg_538_0 then
				arg_535_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_538_21 = 0
			local var_538_22 = 0.325

			if var_538_21 < arg_535_1.time_ and arg_535_1.time_ <= var_538_21 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_23 = arg_535_1:FormatText(StoryNameCfg[1307].name)

				arg_535_1.leftNameTxt_.text = var_538_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_24 = arg_535_1:GetWordFromCfg(421041132)
				local var_538_25 = arg_535_1:FormatText(var_538_24.content)

				arg_535_1.text_.text = var_538_25

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_26 = 13
				local var_538_27 = utf8.len(var_538_25)
				local var_538_28 = var_538_26 <= 0 and var_538_22 or var_538_22 * (var_538_27 / var_538_26)

				if var_538_28 > 0 and var_538_22 < var_538_28 then
					arg_535_1.talkMaxDuration = var_538_28

					if var_538_28 + var_538_21 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_28 + var_538_21
					end
				end

				arg_535_1.text_.text = var_538_25
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041132", "story_v_out_421041.awb") ~= 0 then
					local var_538_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041132", "story_v_out_421041.awb") / 1000

					if var_538_29 + var_538_21 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_29 + var_538_21
					end

					if var_538_24.prefab_name ~= "" and arg_535_1.actors_[var_538_24.prefab_name] ~= nil then
						local var_538_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_24.prefab_name].transform, "story_v_out_421041", "421041132", "story_v_out_421041.awb")

						arg_535_1:RecordAudio("421041132", var_538_30)
						arg_535_1:RecordAudio("421041132", var_538_30)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_421041", "421041132", "story_v_out_421041.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_421041", "421041132", "story_v_out_421041.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_31 = math.max(var_538_22, arg_535_1.talkMaxDuration)

			if var_538_21 <= arg_535_1.time_ and arg_535_1.time_ < var_538_21 + var_538_31 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_21) / var_538_31

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_21 + var_538_31 and arg_535_1.time_ < var_538_21 + var_538_31 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play421041133 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 421041133
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play421041134(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = arg_539_1.actors_["10143ui_story"]
			local var_542_1 = 0

			if var_542_1 < arg_539_1.time_ and arg_539_1.time_ <= var_542_1 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.characterEffect10143ui_story == nil then
				arg_539_1.var_.characterEffect10143ui_story = var_542_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_2 = 0.200000002980232

			if var_542_1 <= arg_539_1.time_ and arg_539_1.time_ < var_542_1 + var_542_2 and not isNil(var_542_0) then
				local var_542_3 = (arg_539_1.time_ - var_542_1) / var_542_2

				if arg_539_1.var_.characterEffect10143ui_story and not isNil(var_542_0) then
					local var_542_4 = Mathf.Lerp(0, 0.5, var_542_3)

					arg_539_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_539_1.var_.characterEffect10143ui_story.fillRatio = var_542_4
				end
			end

			if arg_539_1.time_ >= var_542_1 + var_542_2 and arg_539_1.time_ < var_542_1 + var_542_2 + arg_542_0 and not isNil(var_542_0) and arg_539_1.var_.characterEffect10143ui_story then
				local var_542_5 = 0.5

				arg_539_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_539_1.var_.characterEffect10143ui_story.fillRatio = var_542_5
			end

			local var_542_6 = 0
			local var_542_7 = 0.475

			if var_542_6 < arg_539_1.time_ and arg_539_1.time_ <= var_542_6 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_8 = arg_539_1:FormatText(StoryNameCfg[7].name)

				arg_539_1.leftNameTxt_.text = var_542_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_9 = arg_539_1:GetWordFromCfg(421041133)
				local var_542_10 = arg_539_1:FormatText(var_542_9.content)

				arg_539_1.text_.text = var_542_10

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_11 = 19
				local var_542_12 = utf8.len(var_542_10)
				local var_542_13 = var_542_11 <= 0 and var_542_7 or var_542_7 * (var_542_12 / var_542_11)

				if var_542_13 > 0 and var_542_7 < var_542_13 then
					arg_539_1.talkMaxDuration = var_542_13

					if var_542_13 + var_542_6 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_13 + var_542_6
					end
				end

				arg_539_1.text_.text = var_542_10
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_14 = math.max(var_542_7, arg_539_1.talkMaxDuration)

			if var_542_6 <= arg_539_1.time_ and arg_539_1.time_ < var_542_6 + var_542_14 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_6) / var_542_14

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_6 + var_542_14 and arg_539_1.time_ < var_542_6 + var_542_14 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play421041134 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 421041134
		arg_543_1.duration_ = 15.97

		local var_543_0 = {
			zh = 13.9,
			ja = 15.966
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play421041135(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["1047ui_story"].transform
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.var_.moveOldPos1047ui_story = var_546_0.localPosition
			end

			local var_546_2 = 0.001

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_2 then
				local var_546_3 = (arg_543_1.time_ - var_546_1) / var_546_2
				local var_546_4 = Vector3.New(0, -1.13, -6.2)

				var_546_0.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1047ui_story, var_546_4, var_546_3)

				local var_546_5 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_5.x, var_546_5.y, var_546_5.z)

				local var_546_6 = var_546_0.localEulerAngles

				var_546_6.z = 0
				var_546_6.x = 0
				var_546_0.localEulerAngles = var_546_6
			end

			if arg_543_1.time_ >= var_546_1 + var_546_2 and arg_543_1.time_ < var_546_1 + var_546_2 + arg_546_0 then
				var_546_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_546_7 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_7.x, var_546_7.y, var_546_7.z)

				local var_546_8 = var_546_0.localEulerAngles

				var_546_8.z = 0
				var_546_8.x = 0
				var_546_0.localEulerAngles = var_546_8
			end

			local var_546_9 = arg_543_1.actors_["10143ui_story"].transform
			local var_546_10 = 0

			if var_546_10 < arg_543_1.time_ and arg_543_1.time_ <= var_546_10 + arg_546_0 then
				arg_543_1.var_.moveOldPos10143ui_story = var_546_9.localPosition
			end

			local var_546_11 = 0.001

			if var_546_10 <= arg_543_1.time_ and arg_543_1.time_ < var_546_10 + var_546_11 then
				local var_546_12 = (arg_543_1.time_ - var_546_10) / var_546_11
				local var_546_13 = Vector3.New(0, 100, 0)

				var_546_9.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos10143ui_story, var_546_13, var_546_12)

				local var_546_14 = manager.ui.mainCamera.transform.position - var_546_9.position

				var_546_9.forward = Vector3.New(var_546_14.x, var_546_14.y, var_546_14.z)

				local var_546_15 = var_546_9.localEulerAngles

				var_546_15.z = 0
				var_546_15.x = 0
				var_546_9.localEulerAngles = var_546_15
			end

			if arg_543_1.time_ >= var_546_10 + var_546_11 and arg_543_1.time_ < var_546_10 + var_546_11 + arg_546_0 then
				var_546_9.localPosition = Vector3.New(0, 100, 0)

				local var_546_16 = manager.ui.mainCamera.transform.position - var_546_9.position

				var_546_9.forward = Vector3.New(var_546_16.x, var_546_16.y, var_546_16.z)

				local var_546_17 = var_546_9.localEulerAngles

				var_546_17.z = 0
				var_546_17.x = 0
				var_546_9.localEulerAngles = var_546_17
			end

			local var_546_18 = arg_543_1.actors_["1047ui_story"]
			local var_546_19 = 0

			if var_546_19 < arg_543_1.time_ and arg_543_1.time_ <= var_546_19 + arg_546_0 and not isNil(var_546_18) and arg_543_1.var_.characterEffect1047ui_story == nil then
				arg_543_1.var_.characterEffect1047ui_story = var_546_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_20 = 0.200000002980232

			if var_546_19 <= arg_543_1.time_ and arg_543_1.time_ < var_546_19 + var_546_20 and not isNil(var_546_18) then
				local var_546_21 = (arg_543_1.time_ - var_546_19) / var_546_20

				if arg_543_1.var_.characterEffect1047ui_story and not isNil(var_546_18) then
					arg_543_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= var_546_19 + var_546_20 and arg_543_1.time_ < var_546_19 + var_546_20 + arg_546_0 and not isNil(var_546_18) and arg_543_1.var_.characterEffect1047ui_story then
				arg_543_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_546_22 = 0

			if var_546_22 < arg_543_1.time_ and arg_543_1.time_ <= var_546_22 + arg_546_0 then
				arg_543_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_546_23 = 0

			if var_546_23 < arg_543_1.time_ and arg_543_1.time_ <= var_546_23 + arg_546_0 then
				arg_543_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_546_24 = 0
			local var_546_25 = 1.55

			if var_546_24 < arg_543_1.time_ and arg_543_1.time_ <= var_546_24 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_26 = arg_543_1:FormatText(StoryNameCfg[1296].name)

				arg_543_1.leftNameTxt_.text = var_546_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_27 = arg_543_1:GetWordFromCfg(421041134)
				local var_546_28 = arg_543_1:FormatText(var_546_27.content)

				arg_543_1.text_.text = var_546_28

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_29 = 62
				local var_546_30 = utf8.len(var_546_28)
				local var_546_31 = var_546_29 <= 0 and var_546_25 or var_546_25 * (var_546_30 / var_546_29)

				if var_546_31 > 0 and var_546_25 < var_546_31 then
					arg_543_1.talkMaxDuration = var_546_31

					if var_546_31 + var_546_24 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_31 + var_546_24
					end
				end

				arg_543_1.text_.text = var_546_28
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041134", "story_v_out_421041.awb") ~= 0 then
					local var_546_32 = manager.audio:GetVoiceLength("story_v_out_421041", "421041134", "story_v_out_421041.awb") / 1000

					if var_546_32 + var_546_24 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_32 + var_546_24
					end

					if var_546_27.prefab_name ~= "" and arg_543_1.actors_[var_546_27.prefab_name] ~= nil then
						local var_546_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_27.prefab_name].transform, "story_v_out_421041", "421041134", "story_v_out_421041.awb")

						arg_543_1:RecordAudio("421041134", var_546_33)
						arg_543_1:RecordAudio("421041134", var_546_33)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_421041", "421041134", "story_v_out_421041.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_421041", "421041134", "story_v_out_421041.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_34 = math.max(var_546_25, arg_543_1.talkMaxDuration)

			if var_546_24 <= arg_543_1.time_ and arg_543_1.time_ < var_546_24 + var_546_34 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_24) / var_546_34

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_24 + var_546_34 and arg_543_1.time_ < var_546_24 + var_546_34 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play421041135 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 421041135
		arg_547_1.duration_ = 5.87

		local var_547_0 = {
			zh = 4.9,
			ja = 5.866
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play421041136(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["1047ui_story"].transform
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.var_.moveOldPos1047ui_story = var_550_0.localPosition
			end

			local var_550_2 = 0.001

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2
				local var_550_4 = Vector3.New(0, -1.13, -6.2)

				var_550_0.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos1047ui_story, var_550_4, var_550_3)

				local var_550_5 = manager.ui.mainCamera.transform.position - var_550_0.position

				var_550_0.forward = Vector3.New(var_550_5.x, var_550_5.y, var_550_5.z)

				local var_550_6 = var_550_0.localEulerAngles

				var_550_6.z = 0
				var_550_6.x = 0
				var_550_0.localEulerAngles = var_550_6
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 then
				var_550_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_550_7 = manager.ui.mainCamera.transform.position - var_550_0.position

				var_550_0.forward = Vector3.New(var_550_7.x, var_550_7.y, var_550_7.z)

				local var_550_8 = var_550_0.localEulerAngles

				var_550_8.z = 0
				var_550_8.x = 0
				var_550_0.localEulerAngles = var_550_8
			end

			local var_550_9 = 0

			if var_550_9 < arg_547_1.time_ and arg_547_1.time_ <= var_550_9 + arg_550_0 then
				arg_547_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_550_10 = 0
			local var_550_11 = 0.575

			if var_550_10 < arg_547_1.time_ and arg_547_1.time_ <= var_550_10 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_12 = arg_547_1:FormatText(StoryNameCfg[1296].name)

				arg_547_1.leftNameTxt_.text = var_550_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_13 = arg_547_1:GetWordFromCfg(421041135)
				local var_550_14 = arg_547_1:FormatText(var_550_13.content)

				arg_547_1.text_.text = var_550_14

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_15 = 23
				local var_550_16 = utf8.len(var_550_14)
				local var_550_17 = var_550_15 <= 0 and var_550_11 or var_550_11 * (var_550_16 / var_550_15)

				if var_550_17 > 0 and var_550_11 < var_550_17 then
					arg_547_1.talkMaxDuration = var_550_17

					if var_550_17 + var_550_10 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_17 + var_550_10
					end
				end

				arg_547_1.text_.text = var_550_14
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041135", "story_v_out_421041.awb") ~= 0 then
					local var_550_18 = manager.audio:GetVoiceLength("story_v_out_421041", "421041135", "story_v_out_421041.awb") / 1000

					if var_550_18 + var_550_10 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_18 + var_550_10
					end

					if var_550_13.prefab_name ~= "" and arg_547_1.actors_[var_550_13.prefab_name] ~= nil then
						local var_550_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_13.prefab_name].transform, "story_v_out_421041", "421041135", "story_v_out_421041.awb")

						arg_547_1:RecordAudio("421041135", var_550_19)
						arg_547_1:RecordAudio("421041135", var_550_19)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_421041", "421041135", "story_v_out_421041.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_421041", "421041135", "story_v_out_421041.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_20 = math.max(var_550_11, arg_547_1.talkMaxDuration)

			if var_550_10 <= arg_547_1.time_ and arg_547_1.time_ < var_550_10 + var_550_20 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_10) / var_550_20

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_10 + var_550_20 and arg_547_1.time_ < var_550_10 + var_550_20 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play421041136 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 421041136
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play421041137(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["1047ui_story"].transform
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.var_.moveOldPos1047ui_story = var_554_0.localPosition
			end

			local var_554_2 = 0.001

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_2 then
				local var_554_3 = (arg_551_1.time_ - var_554_1) / var_554_2
				local var_554_4 = Vector3.New(0, 100, 0)

				var_554_0.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos1047ui_story, var_554_4, var_554_3)

				local var_554_5 = manager.ui.mainCamera.transform.position - var_554_0.position

				var_554_0.forward = Vector3.New(var_554_5.x, var_554_5.y, var_554_5.z)

				local var_554_6 = var_554_0.localEulerAngles

				var_554_6.z = 0
				var_554_6.x = 0
				var_554_0.localEulerAngles = var_554_6
			end

			if arg_551_1.time_ >= var_554_1 + var_554_2 and arg_551_1.time_ < var_554_1 + var_554_2 + arg_554_0 then
				var_554_0.localPosition = Vector3.New(0, 100, 0)

				local var_554_7 = manager.ui.mainCamera.transform.position - var_554_0.position

				var_554_0.forward = Vector3.New(var_554_7.x, var_554_7.y, var_554_7.z)

				local var_554_8 = var_554_0.localEulerAngles

				var_554_8.z = 0
				var_554_8.x = 0
				var_554_0.localEulerAngles = var_554_8
			end

			local var_554_9 = 0
			local var_554_10 = 0.65

			if var_554_9 < arg_551_1.time_ and arg_551_1.time_ <= var_554_9 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_11 = arg_551_1:FormatText(StoryNameCfg[7].name)

				arg_551_1.leftNameTxt_.text = var_554_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_12 = arg_551_1:GetWordFromCfg(421041136)
				local var_554_13 = arg_551_1:FormatText(var_554_12.content)

				arg_551_1.text_.text = var_554_13

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_14 = 26
				local var_554_15 = utf8.len(var_554_13)
				local var_554_16 = var_554_14 <= 0 and var_554_10 or var_554_10 * (var_554_15 / var_554_14)

				if var_554_16 > 0 and var_554_10 < var_554_16 then
					arg_551_1.talkMaxDuration = var_554_16

					if var_554_16 + var_554_9 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_16 + var_554_9
					end
				end

				arg_551_1.text_.text = var_554_13
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_17 = math.max(var_554_10, arg_551_1.talkMaxDuration)

			if var_554_9 <= arg_551_1.time_ and arg_551_1.time_ < var_554_9 + var_554_17 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_9) / var_554_17

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_9 + var_554_17 and arg_551_1.time_ < var_554_9 + var_554_17 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_551_1:InitPlayNodeList()
	end,
	Play421041137 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 421041137
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play421041138(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0
			local var_558_1 = 1.275

			if var_558_0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				local var_558_2 = arg_555_1:FormatText(StoryNameCfg[7].name)

				arg_555_1.leftNameTxt_.text = var_558_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_3 = arg_555_1:GetWordFromCfg(421041137)
				local var_558_4 = arg_555_1:FormatText(var_558_3.content)

				arg_555_1.text_.text = var_558_4

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_5 = 51
				local var_558_6 = utf8.len(var_558_4)
				local var_558_7 = var_558_5 <= 0 and var_558_1 or var_558_1 * (var_558_6 / var_558_5)

				if var_558_7 > 0 and var_558_1 < var_558_7 then
					arg_555_1.talkMaxDuration = var_558_7

					if var_558_7 + var_558_0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_7 + var_558_0
					end
				end

				arg_555_1.text_.text = var_558_4
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_8 = math.max(var_558_1, arg_555_1.talkMaxDuration)

			if var_558_0 <= arg_555_1.time_ and arg_555_1.time_ < var_558_0 + var_558_8 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_0) / var_558_8

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_0 + var_558_8 and arg_555_1.time_ < var_558_0 + var_558_8 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play421041138 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 421041138
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play421041139(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0
			local var_562_1 = 1.4

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_2 = arg_559_1:FormatText(StoryNameCfg[7].name)

				arg_559_1.leftNameTxt_.text = var_562_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_3 = arg_559_1:GetWordFromCfg(421041138)
				local var_562_4 = arg_559_1:FormatText(var_562_3.content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_5 = 56
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
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_8 = math.max(var_562_1, arg_559_1.talkMaxDuration)

			if var_562_0 <= arg_559_1.time_ and arg_559_1.time_ < var_562_0 + var_562_8 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_0) / var_562_8

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_0 + var_562_8 and arg_559_1.time_ < var_562_0 + var_562_8 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play421041139 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 421041139
		arg_563_1.duration_ = 7.17

		local var_563_0 = {
			zh = 6.666,
			ja = 7.166
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play421041140(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = arg_563_1.actors_["1047ui_story"].transform
			local var_566_1 = 0

			if var_566_1 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 then
				arg_563_1.var_.moveOldPos1047ui_story = var_566_0.localPosition
			end

			local var_566_2 = 0.001

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_2 then
				local var_566_3 = (arg_563_1.time_ - var_566_1) / var_566_2
				local var_566_4 = Vector3.New(0, -1.13, -6.2)

				var_566_0.localPosition = Vector3.Lerp(arg_563_1.var_.moveOldPos1047ui_story, var_566_4, var_566_3)

				local var_566_5 = manager.ui.mainCamera.transform.position - var_566_0.position

				var_566_0.forward = Vector3.New(var_566_5.x, var_566_5.y, var_566_5.z)

				local var_566_6 = var_566_0.localEulerAngles

				var_566_6.z = 0
				var_566_6.x = 0
				var_566_0.localEulerAngles = var_566_6
			end

			if arg_563_1.time_ >= var_566_1 + var_566_2 and arg_563_1.time_ < var_566_1 + var_566_2 + arg_566_0 then
				var_566_0.localPosition = Vector3.New(0, -1.13, -6.2)

				local var_566_7 = manager.ui.mainCamera.transform.position - var_566_0.position

				var_566_0.forward = Vector3.New(var_566_7.x, var_566_7.y, var_566_7.z)

				local var_566_8 = var_566_0.localEulerAngles

				var_566_8.z = 0
				var_566_8.x = 0
				var_566_0.localEulerAngles = var_566_8
			end

			local var_566_9 = arg_563_1.actors_["1047ui_story"]
			local var_566_10 = 0

			if var_566_10 < arg_563_1.time_ and arg_563_1.time_ <= var_566_10 + arg_566_0 and not isNil(var_566_9) and arg_563_1.var_.characterEffect1047ui_story == nil then
				arg_563_1.var_.characterEffect1047ui_story = var_566_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_11 = 0.200000002980232

			if var_566_10 <= arg_563_1.time_ and arg_563_1.time_ < var_566_10 + var_566_11 and not isNil(var_566_9) then
				local var_566_12 = (arg_563_1.time_ - var_566_10) / var_566_11

				if arg_563_1.var_.characterEffect1047ui_story and not isNil(var_566_9) then
					arg_563_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_563_1.time_ >= var_566_10 + var_566_11 and arg_563_1.time_ < var_566_10 + var_566_11 + arg_566_0 and not isNil(var_566_9) and arg_563_1.var_.characterEffect1047ui_story then
				arg_563_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_566_13 = 0

			if var_566_13 < arg_563_1.time_ and arg_563_1.time_ <= var_566_13 + arg_566_0 then
				arg_563_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_566_14 = 0

			if var_566_14 < arg_563_1.time_ and arg_563_1.time_ <= var_566_14 + arg_566_0 then
				arg_563_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_566_15 = 0
			local var_566_16 = 0.725

			if var_566_15 < arg_563_1.time_ and arg_563_1.time_ <= var_566_15 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				local var_566_17 = arg_563_1:FormatText(StoryNameCfg[1296].name)

				arg_563_1.leftNameTxt_.text = var_566_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_18 = arg_563_1:GetWordFromCfg(421041139)
				local var_566_19 = arg_563_1:FormatText(var_566_18.content)

				arg_563_1.text_.text = var_566_19

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_20 = 29
				local var_566_21 = utf8.len(var_566_19)
				local var_566_22 = var_566_20 <= 0 and var_566_16 or var_566_16 * (var_566_21 / var_566_20)

				if var_566_22 > 0 and var_566_16 < var_566_22 then
					arg_563_1.talkMaxDuration = var_566_22

					if var_566_22 + var_566_15 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_22 + var_566_15
					end
				end

				arg_563_1.text_.text = var_566_19
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041139", "story_v_out_421041.awb") ~= 0 then
					local var_566_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041139", "story_v_out_421041.awb") / 1000

					if var_566_23 + var_566_15 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_23 + var_566_15
					end

					if var_566_18.prefab_name ~= "" and arg_563_1.actors_[var_566_18.prefab_name] ~= nil then
						local var_566_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_18.prefab_name].transform, "story_v_out_421041", "421041139", "story_v_out_421041.awb")

						arg_563_1:RecordAudio("421041139", var_566_24)
						arg_563_1:RecordAudio("421041139", var_566_24)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_421041", "421041139", "story_v_out_421041.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_421041", "421041139", "story_v_out_421041.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_25 = math.max(var_566_16, arg_563_1.talkMaxDuration)

			if var_566_15 <= arg_563_1.time_ and arg_563_1.time_ < var_566_15 + var_566_25 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_15) / var_566_25

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_15 + var_566_25 and arg_563_1.time_ < var_566_15 + var_566_25 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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
	Play421041140 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 421041140
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play421041141(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = arg_567_1.actors_["1047ui_story"]
			local var_570_1 = 0

			if var_570_1 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.characterEffect1047ui_story == nil then
				arg_567_1.var_.characterEffect1047ui_story = var_570_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_2 = 0.200000002980232

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_2 and not isNil(var_570_0) then
				local var_570_3 = (arg_567_1.time_ - var_570_1) / var_570_2

				if arg_567_1.var_.characterEffect1047ui_story and not isNil(var_570_0) then
					local var_570_4 = Mathf.Lerp(0, 0.5, var_570_3)

					arg_567_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_567_1.var_.characterEffect1047ui_story.fillRatio = var_570_4
				end
			end

			if arg_567_1.time_ >= var_570_1 + var_570_2 and arg_567_1.time_ < var_570_1 + var_570_2 + arg_570_0 and not isNil(var_570_0) and arg_567_1.var_.characterEffect1047ui_story then
				local var_570_5 = 0.5

				arg_567_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_567_1.var_.characterEffect1047ui_story.fillRatio = var_570_5
			end

			local var_570_6 = 0
			local var_570_7 = 0.275

			if var_570_6 < arg_567_1.time_ and arg_567_1.time_ <= var_570_6 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				local var_570_8 = arg_567_1:FormatText(StoryNameCfg[7].name)

				arg_567_1.leftNameTxt_.text = var_570_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_9 = arg_567_1:GetWordFromCfg(421041140)
				local var_570_10 = arg_567_1:FormatText(var_570_9.content)

				arg_567_1.text_.text = var_570_10

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_11 = 11
				local var_570_12 = utf8.len(var_570_10)
				local var_570_13 = var_570_11 <= 0 and var_570_7 or var_570_7 * (var_570_12 / var_570_11)

				if var_570_13 > 0 and var_570_7 < var_570_13 then
					arg_567_1.talkMaxDuration = var_570_13

					if var_570_13 + var_570_6 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_13 + var_570_6
					end
				end

				arg_567_1.text_.text = var_570_10
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_14 = math.max(var_570_7, arg_567_1.talkMaxDuration)

			if var_570_6 <= arg_567_1.time_ and arg_567_1.time_ < var_570_6 + var_570_14 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_6) / var_570_14

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_6 + var_570_14 and arg_567_1.time_ < var_570_6 + var_570_14 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play421041141 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 421041141
		arg_571_1.duration_ = 2.23

		local var_571_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_571_0:Play421041142(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = arg_571_1.actors_["10102ui_story"].transform
			local var_574_1 = 0

			if var_574_1 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 then
				arg_571_1.var_.moveOldPos10102ui_story = var_574_0.localPosition
			end

			local var_574_2 = 0.001

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_2 then
				local var_574_3 = (arg_571_1.time_ - var_574_1) / var_574_2
				local var_574_4 = Vector3.New(-0.7, -0.985, -6.275)

				var_574_0.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos10102ui_story, var_574_4, var_574_3)

				local var_574_5 = manager.ui.mainCamera.transform.position - var_574_0.position

				var_574_0.forward = Vector3.New(var_574_5.x, var_574_5.y, var_574_5.z)

				local var_574_6 = var_574_0.localEulerAngles

				var_574_6.z = 0
				var_574_6.x = 0
				var_574_0.localEulerAngles = var_574_6
			end

			if arg_571_1.time_ >= var_574_1 + var_574_2 and arg_571_1.time_ < var_574_1 + var_574_2 + arg_574_0 then
				var_574_0.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_574_7 = manager.ui.mainCamera.transform.position - var_574_0.position

				var_574_0.forward = Vector3.New(var_574_7.x, var_574_7.y, var_574_7.z)

				local var_574_8 = var_574_0.localEulerAngles

				var_574_8.z = 0
				var_574_8.x = 0
				var_574_0.localEulerAngles = var_574_8
			end

			local var_574_9 = arg_571_1.actors_["1047ui_story"].transform
			local var_574_10 = 0

			if var_574_10 < arg_571_1.time_ and arg_571_1.time_ <= var_574_10 + arg_574_0 then
				arg_571_1.var_.moveOldPos1047ui_story = var_574_9.localPosition
			end

			local var_574_11 = 0.001

			if var_574_10 <= arg_571_1.time_ and arg_571_1.time_ < var_574_10 + var_574_11 then
				local var_574_12 = (arg_571_1.time_ - var_574_10) / var_574_11
				local var_574_13 = Vector3.New(0, 100, 0)

				var_574_9.localPosition = Vector3.Lerp(arg_571_1.var_.moveOldPos1047ui_story, var_574_13, var_574_12)

				local var_574_14 = manager.ui.mainCamera.transform.position - var_574_9.position

				var_574_9.forward = Vector3.New(var_574_14.x, var_574_14.y, var_574_14.z)

				local var_574_15 = var_574_9.localEulerAngles

				var_574_15.z = 0
				var_574_15.x = 0
				var_574_9.localEulerAngles = var_574_15
			end

			if arg_571_1.time_ >= var_574_10 + var_574_11 and arg_571_1.time_ < var_574_10 + var_574_11 + arg_574_0 then
				var_574_9.localPosition = Vector3.New(0, 100, 0)

				local var_574_16 = manager.ui.mainCamera.transform.position - var_574_9.position

				var_574_9.forward = Vector3.New(var_574_16.x, var_574_16.y, var_574_16.z)

				local var_574_17 = var_574_9.localEulerAngles

				var_574_17.z = 0
				var_574_17.x = 0
				var_574_9.localEulerAngles = var_574_17
			end

			local var_574_18 = arg_571_1.actors_["10102ui_story"]
			local var_574_19 = 0

			if var_574_19 < arg_571_1.time_ and arg_571_1.time_ <= var_574_19 + arg_574_0 and not isNil(var_574_18) and arg_571_1.var_.characterEffect10102ui_story == nil then
				arg_571_1.var_.characterEffect10102ui_story = var_574_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_20 = 0.200000002980232

			if var_574_19 <= arg_571_1.time_ and arg_571_1.time_ < var_574_19 + var_574_20 and not isNil(var_574_18) then
				local var_574_21 = (arg_571_1.time_ - var_574_19) / var_574_20

				if arg_571_1.var_.characterEffect10102ui_story and not isNil(var_574_18) then
					arg_571_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= var_574_19 + var_574_20 and arg_571_1.time_ < var_574_19 + var_574_20 + arg_574_0 and not isNil(var_574_18) and arg_571_1.var_.characterEffect10102ui_story then
				arg_571_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_574_22 = 0

			if var_574_22 < arg_571_1.time_ and arg_571_1.time_ <= var_574_22 + arg_574_0 then
				arg_571_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_574_23 = 0

			if var_574_23 < arg_571_1.time_ and arg_571_1.time_ <= var_574_23 + arg_574_0 then
				arg_571_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_574_24 = 0
			local var_574_25 = 0.2

			if var_574_24 < arg_571_1.time_ and arg_571_1.time_ <= var_574_24 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				local var_574_26 = arg_571_1:FormatText(StoryNameCfg[6].name)

				arg_571_1.leftNameTxt_.text = var_574_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_27 = arg_571_1:GetWordFromCfg(421041141)
				local var_574_28 = arg_571_1:FormatText(var_574_27.content)

				arg_571_1.text_.text = var_574_28

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_29 = 8
				local var_574_30 = utf8.len(var_574_28)
				local var_574_31 = var_574_29 <= 0 and var_574_25 or var_574_25 * (var_574_30 / var_574_29)

				if var_574_31 > 0 and var_574_25 < var_574_31 then
					arg_571_1.talkMaxDuration = var_574_31

					if var_574_31 + var_574_24 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_31 + var_574_24
					end
				end

				arg_571_1.text_.text = var_574_28
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041141", "story_v_out_421041.awb") ~= 0 then
					local var_574_32 = manager.audio:GetVoiceLength("story_v_out_421041", "421041141", "story_v_out_421041.awb") / 1000

					if var_574_32 + var_574_24 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_32 + var_574_24
					end

					if var_574_27.prefab_name ~= "" and arg_571_1.actors_[var_574_27.prefab_name] ~= nil then
						local var_574_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_27.prefab_name].transform, "story_v_out_421041", "421041141", "story_v_out_421041.awb")

						arg_571_1:RecordAudio("421041141", var_574_33)
						arg_571_1:RecordAudio("421041141", var_574_33)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_421041", "421041141", "story_v_out_421041.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_421041", "421041141", "story_v_out_421041.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_34 = math.max(var_574_25, arg_571_1.talkMaxDuration)

			if var_574_24 <= arg_571_1.time_ and arg_571_1.time_ < var_574_24 + var_574_34 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_24) / var_574_34

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_24 + var_574_34 and arg_571_1.time_ < var_574_24 + var_574_34 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_571_1:InitPlayNodeList()
	end,
	Play421041142 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 421041142
		arg_575_1.duration_ = 8.57

		local var_575_0 = {
			zh = 4.833,
			ja = 8.566
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play421041143(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = arg_575_1.actors_["10145ui_story"].transform
			local var_578_1 = 0

			if var_578_1 < arg_575_1.time_ and arg_575_1.time_ <= var_578_1 + arg_578_0 then
				arg_575_1.var_.moveOldPos10145ui_story = var_578_0.localPosition
			end

			local var_578_2 = 0.001

			if var_578_1 <= arg_575_1.time_ and arg_575_1.time_ < var_578_1 + var_578_2 then
				local var_578_3 = (arg_575_1.time_ - var_578_1) / var_578_2
				local var_578_4 = Vector3.New(0.78, -1, -6.2)

				var_578_0.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos10145ui_story, var_578_4, var_578_3)

				local var_578_5 = manager.ui.mainCamera.transform.position - var_578_0.position

				var_578_0.forward = Vector3.New(var_578_5.x, var_578_5.y, var_578_5.z)

				local var_578_6 = var_578_0.localEulerAngles

				var_578_6.z = 0
				var_578_6.x = 0
				var_578_0.localEulerAngles = var_578_6
			end

			if arg_575_1.time_ >= var_578_1 + var_578_2 and arg_575_1.time_ < var_578_1 + var_578_2 + arg_578_0 then
				var_578_0.localPosition = Vector3.New(0.78, -1, -6.2)

				local var_578_7 = manager.ui.mainCamera.transform.position - var_578_0.position

				var_578_0.forward = Vector3.New(var_578_7.x, var_578_7.y, var_578_7.z)

				local var_578_8 = var_578_0.localEulerAngles

				var_578_8.z = 0
				var_578_8.x = 0
				var_578_0.localEulerAngles = var_578_8
			end

			local var_578_9 = arg_575_1.actors_["10145ui_story"]
			local var_578_10 = 0

			if var_578_10 < arg_575_1.time_ and arg_575_1.time_ <= var_578_10 + arg_578_0 and not isNil(var_578_9) and arg_575_1.var_.characterEffect10145ui_story == nil then
				arg_575_1.var_.characterEffect10145ui_story = var_578_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_11 = 0.200000002980232

			if var_578_10 <= arg_575_1.time_ and arg_575_1.time_ < var_578_10 + var_578_11 and not isNil(var_578_9) then
				local var_578_12 = (arg_575_1.time_ - var_578_10) / var_578_11

				if arg_575_1.var_.characterEffect10145ui_story and not isNil(var_578_9) then
					arg_575_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= var_578_10 + var_578_11 and arg_575_1.time_ < var_578_10 + var_578_11 + arg_578_0 and not isNil(var_578_9) and arg_575_1.var_.characterEffect10145ui_story then
				arg_575_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_578_13 = arg_575_1.actors_["10102ui_story"]
			local var_578_14 = 0

			if var_578_14 < arg_575_1.time_ and arg_575_1.time_ <= var_578_14 + arg_578_0 and not isNil(var_578_13) and arg_575_1.var_.characterEffect10102ui_story == nil then
				arg_575_1.var_.characterEffect10102ui_story = var_578_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_15 = 0.200000002980232

			if var_578_14 <= arg_575_1.time_ and arg_575_1.time_ < var_578_14 + var_578_15 and not isNil(var_578_13) then
				local var_578_16 = (arg_575_1.time_ - var_578_14) / var_578_15

				if arg_575_1.var_.characterEffect10102ui_story and not isNil(var_578_13) then
					local var_578_17 = Mathf.Lerp(0, 0.5, var_578_16)

					arg_575_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_575_1.var_.characterEffect10102ui_story.fillRatio = var_578_17
				end
			end

			if arg_575_1.time_ >= var_578_14 + var_578_15 and arg_575_1.time_ < var_578_14 + var_578_15 + arg_578_0 and not isNil(var_578_13) and arg_575_1.var_.characterEffect10102ui_story then
				local var_578_18 = 0.5

				arg_575_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_575_1.var_.characterEffect10102ui_story.fillRatio = var_578_18
			end

			local var_578_19 = 0

			if var_578_19 < arg_575_1.time_ and arg_575_1.time_ <= var_578_19 + arg_578_0 then
				arg_575_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_578_20 = 0

			if var_578_20 < arg_575_1.time_ and arg_575_1.time_ <= var_578_20 + arg_578_0 then
				arg_575_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_578_21 = 0
			local var_578_22 = 0.575

			if var_578_21 < arg_575_1.time_ and arg_575_1.time_ <= var_578_21 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				local var_578_23 = arg_575_1:FormatText(StoryNameCfg[1308].name)

				arg_575_1.leftNameTxt_.text = var_578_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_24 = arg_575_1:GetWordFromCfg(421041142)
				local var_578_25 = arg_575_1:FormatText(var_578_24.content)

				arg_575_1.text_.text = var_578_25

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_26 = 23
				local var_578_27 = utf8.len(var_578_25)
				local var_578_28 = var_578_26 <= 0 and var_578_22 or var_578_22 * (var_578_27 / var_578_26)

				if var_578_28 > 0 and var_578_22 < var_578_28 then
					arg_575_1.talkMaxDuration = var_578_28

					if var_578_28 + var_578_21 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_28 + var_578_21
					end
				end

				arg_575_1.text_.text = var_578_25
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041142", "story_v_out_421041.awb") ~= 0 then
					local var_578_29 = manager.audio:GetVoiceLength("story_v_out_421041", "421041142", "story_v_out_421041.awb") / 1000

					if var_578_29 + var_578_21 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_29 + var_578_21
					end

					if var_578_24.prefab_name ~= "" and arg_575_1.actors_[var_578_24.prefab_name] ~= nil then
						local var_578_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_24.prefab_name].transform, "story_v_out_421041", "421041142", "story_v_out_421041.awb")

						arg_575_1:RecordAudio("421041142", var_578_30)
						arg_575_1:RecordAudio("421041142", var_578_30)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_421041", "421041142", "story_v_out_421041.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_421041", "421041142", "story_v_out_421041.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_31 = math.max(var_578_22, arg_575_1.talkMaxDuration)

			if var_578_21 <= arg_575_1.time_ and arg_575_1.time_ < var_578_21 + var_578_31 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_21) / var_578_31

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_21 + var_578_31 and arg_575_1.time_ < var_578_21 + var_578_31 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play421041143 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 421041143
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play421041144(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = arg_579_1.actors_["10145ui_story"]
			local var_582_1 = 0

			if var_582_1 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 and not isNil(var_582_0) and arg_579_1.var_.characterEffect10145ui_story == nil then
				arg_579_1.var_.characterEffect10145ui_story = var_582_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_2 = 0.200000002980232

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_2 and not isNil(var_582_0) then
				local var_582_3 = (arg_579_1.time_ - var_582_1) / var_582_2

				if arg_579_1.var_.characterEffect10145ui_story and not isNil(var_582_0) then
					local var_582_4 = Mathf.Lerp(0, 0.5, var_582_3)

					arg_579_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_579_1.var_.characterEffect10145ui_story.fillRatio = var_582_4
				end
			end

			if arg_579_1.time_ >= var_582_1 + var_582_2 and arg_579_1.time_ < var_582_1 + var_582_2 + arg_582_0 and not isNil(var_582_0) and arg_579_1.var_.characterEffect10145ui_story then
				local var_582_5 = 0.5

				arg_579_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_579_1.var_.characterEffect10145ui_story.fillRatio = var_582_5
			end

			local var_582_6 = 0
			local var_582_7 = 0.75

			if var_582_6 < arg_579_1.time_ and arg_579_1.time_ <= var_582_6 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				local var_582_8 = arg_579_1:FormatText(StoryNameCfg[7].name)

				arg_579_1.leftNameTxt_.text = var_582_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_9 = arg_579_1:GetWordFromCfg(421041143)
				local var_582_10 = arg_579_1:FormatText(var_582_9.content)

				arg_579_1.text_.text = var_582_10

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_11 = 30
				local var_582_12 = utf8.len(var_582_10)
				local var_582_13 = var_582_11 <= 0 and var_582_7 or var_582_7 * (var_582_12 / var_582_11)

				if var_582_13 > 0 and var_582_7 < var_582_13 then
					arg_579_1.talkMaxDuration = var_582_13

					if var_582_13 + var_582_6 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_13 + var_582_6
					end
				end

				arg_579_1.text_.text = var_582_10
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_14 = math.max(var_582_7, arg_579_1.talkMaxDuration)

			if var_582_6 <= arg_579_1.time_ and arg_579_1.time_ < var_582_6 + var_582_14 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_6) / var_582_14

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_6 + var_582_14 and arg_579_1.time_ < var_582_6 + var_582_14 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play421041144 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 421041144
		arg_583_1.duration_ = 5.1

		local var_583_0 = {
			zh = 3.133,
			ja = 5.1
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play421041145(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = arg_583_1.actors_["10102ui_story"].transform
			local var_586_1 = 0

			if var_586_1 < arg_583_1.time_ and arg_583_1.time_ <= var_586_1 + arg_586_0 then
				arg_583_1.var_.moveOldPos10102ui_story = var_586_0.localPosition
			end

			local var_586_2 = 0.001

			if var_586_1 <= arg_583_1.time_ and arg_583_1.time_ < var_586_1 + var_586_2 then
				local var_586_3 = (arg_583_1.time_ - var_586_1) / var_586_2
				local var_586_4 = Vector3.New(-0.7, -0.985, -6.275)

				var_586_0.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos10102ui_story, var_586_4, var_586_3)

				local var_586_5 = manager.ui.mainCamera.transform.position - var_586_0.position

				var_586_0.forward = Vector3.New(var_586_5.x, var_586_5.y, var_586_5.z)

				local var_586_6 = var_586_0.localEulerAngles

				var_586_6.z = 0
				var_586_6.x = 0
				var_586_0.localEulerAngles = var_586_6
			end

			if arg_583_1.time_ >= var_586_1 + var_586_2 and arg_583_1.time_ < var_586_1 + var_586_2 + arg_586_0 then
				var_586_0.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_586_7 = manager.ui.mainCamera.transform.position - var_586_0.position

				var_586_0.forward = Vector3.New(var_586_7.x, var_586_7.y, var_586_7.z)

				local var_586_8 = var_586_0.localEulerAngles

				var_586_8.z = 0
				var_586_8.x = 0
				var_586_0.localEulerAngles = var_586_8
			end

			local var_586_9 = arg_583_1.actors_["10102ui_story"]
			local var_586_10 = 0

			if var_586_10 < arg_583_1.time_ and arg_583_1.time_ <= var_586_10 + arg_586_0 and not isNil(var_586_9) and arg_583_1.var_.characterEffect10102ui_story == nil then
				arg_583_1.var_.characterEffect10102ui_story = var_586_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_11 = 0.200000002980232

			if var_586_10 <= arg_583_1.time_ and arg_583_1.time_ < var_586_10 + var_586_11 and not isNil(var_586_9) then
				local var_586_12 = (arg_583_1.time_ - var_586_10) / var_586_11

				if arg_583_1.var_.characterEffect10102ui_story and not isNil(var_586_9) then
					arg_583_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= var_586_10 + var_586_11 and arg_583_1.time_ < var_586_10 + var_586_11 + arg_586_0 and not isNil(var_586_9) and arg_583_1.var_.characterEffect10102ui_story then
				arg_583_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_586_13 = 0

			if var_586_13 < arg_583_1.time_ and arg_583_1.time_ <= var_586_13 + arg_586_0 then
				arg_583_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_586_14 = 0

			if var_586_14 < arg_583_1.time_ and arg_583_1.time_ <= var_586_14 + arg_586_0 then
				arg_583_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_586_15 = 0
			local var_586_16 = 0.325

			if var_586_15 < arg_583_1.time_ and arg_583_1.time_ <= var_586_15 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_17 = arg_583_1:FormatText(StoryNameCfg[6].name)

				arg_583_1.leftNameTxt_.text = var_586_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_18 = arg_583_1:GetWordFromCfg(421041144)
				local var_586_19 = arg_583_1:FormatText(var_586_18.content)

				arg_583_1.text_.text = var_586_19

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_20 = 13
				local var_586_21 = utf8.len(var_586_19)
				local var_586_22 = var_586_20 <= 0 and var_586_16 or var_586_16 * (var_586_21 / var_586_20)

				if var_586_22 > 0 and var_586_16 < var_586_22 then
					arg_583_1.talkMaxDuration = var_586_22

					if var_586_22 + var_586_15 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_22 + var_586_15
					end
				end

				arg_583_1.text_.text = var_586_19
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421041", "421041144", "story_v_out_421041.awb") ~= 0 then
					local var_586_23 = manager.audio:GetVoiceLength("story_v_out_421041", "421041144", "story_v_out_421041.awb") / 1000

					if var_586_23 + var_586_15 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_23 + var_586_15
					end

					if var_586_18.prefab_name ~= "" and arg_583_1.actors_[var_586_18.prefab_name] ~= nil then
						local var_586_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_18.prefab_name].transform, "story_v_out_421041", "421041144", "story_v_out_421041.awb")

						arg_583_1:RecordAudio("421041144", var_586_24)
						arg_583_1:RecordAudio("421041144", var_586_24)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_421041", "421041144", "story_v_out_421041.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_421041", "421041144", "story_v_out_421041.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_25 = math.max(var_586_16, arg_583_1.talkMaxDuration)

			if var_586_15 <= arg_583_1.time_ and arg_583_1.time_ < var_586_15 + var_586_25 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_15) / var_586_25

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_15 + var_586_25 and arg_583_1.time_ < var_586_15 + var_586_25 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_583_1:InitPlayNodeList()
	end,
	Play421041145 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 421041145
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
			arg_587_1.auto_ = false
		end

		function arg_587_1.playNext_(arg_589_0)
			arg_587_1.onStoryFinished_()
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = arg_587_1.actors_["10102ui_story"].transform
			local var_590_1 = 0

			if var_590_1 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 then
				arg_587_1.var_.moveOldPos10102ui_story = var_590_0.localPosition
			end

			local var_590_2 = 0.001

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_2 then
				local var_590_3 = (arg_587_1.time_ - var_590_1) / var_590_2
				local var_590_4 = Vector3.New(0, 100, 0)

				var_590_0.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos10102ui_story, var_590_4, var_590_3)

				local var_590_5 = manager.ui.mainCamera.transform.position - var_590_0.position

				var_590_0.forward = Vector3.New(var_590_5.x, var_590_5.y, var_590_5.z)

				local var_590_6 = var_590_0.localEulerAngles

				var_590_6.z = 0
				var_590_6.x = 0
				var_590_0.localEulerAngles = var_590_6
			end

			if arg_587_1.time_ >= var_590_1 + var_590_2 and arg_587_1.time_ < var_590_1 + var_590_2 + arg_590_0 then
				var_590_0.localPosition = Vector3.New(0, 100, 0)

				local var_590_7 = manager.ui.mainCamera.transform.position - var_590_0.position

				var_590_0.forward = Vector3.New(var_590_7.x, var_590_7.y, var_590_7.z)

				local var_590_8 = var_590_0.localEulerAngles

				var_590_8.z = 0
				var_590_8.x = 0
				var_590_0.localEulerAngles = var_590_8
			end

			local var_590_9 = arg_587_1.actors_["10145ui_story"].transform
			local var_590_10 = 0

			if var_590_10 < arg_587_1.time_ and arg_587_1.time_ <= var_590_10 + arg_590_0 then
				arg_587_1.var_.moveOldPos10145ui_story = var_590_9.localPosition
			end

			local var_590_11 = 0.001

			if var_590_10 <= arg_587_1.time_ and arg_587_1.time_ < var_590_10 + var_590_11 then
				local var_590_12 = (arg_587_1.time_ - var_590_10) / var_590_11
				local var_590_13 = Vector3.New(0, 100, 0)

				var_590_9.localPosition = Vector3.Lerp(arg_587_1.var_.moveOldPos10145ui_story, var_590_13, var_590_12)

				local var_590_14 = manager.ui.mainCamera.transform.position - var_590_9.position

				var_590_9.forward = Vector3.New(var_590_14.x, var_590_14.y, var_590_14.z)

				local var_590_15 = var_590_9.localEulerAngles

				var_590_15.z = 0
				var_590_15.x = 0
				var_590_9.localEulerAngles = var_590_15
			end

			if arg_587_1.time_ >= var_590_10 + var_590_11 and arg_587_1.time_ < var_590_10 + var_590_11 + arg_590_0 then
				var_590_9.localPosition = Vector3.New(0, 100, 0)

				local var_590_16 = manager.ui.mainCamera.transform.position - var_590_9.position

				var_590_9.forward = Vector3.New(var_590_16.x, var_590_16.y, var_590_16.z)

				local var_590_17 = var_590_9.localEulerAngles

				var_590_17.z = 0
				var_590_17.x = 0
				var_590_9.localEulerAngles = var_590_17
			end

			local var_590_18 = 0.499999999999
			local var_590_19 = 1

			if var_590_18 < arg_587_1.time_ and arg_587_1.time_ <= var_590_18 + arg_590_0 then
				local var_590_20 = "play"
				local var_590_21 = "effect"

				arg_587_1:AudioAction(var_590_20, var_590_21, "se_story_140", "se_story_140_car_brake", "")
			end

			local var_590_22 = 0
			local var_590_23 = 1.5

			if var_590_22 < arg_587_1.time_ and arg_587_1.time_ <= var_590_22 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_24 = arg_587_1:GetWordFromCfg(421041145)
				local var_590_25 = arg_587_1:FormatText(var_590_24.content)

				arg_587_1.text_.text = var_590_25

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_26 = 60
				local var_590_27 = utf8.len(var_590_25)
				local var_590_28 = var_590_26 <= 0 and var_590_23 or var_590_23 * (var_590_27 / var_590_26)

				if var_590_28 > 0 and var_590_23 < var_590_28 then
					arg_587_1.talkMaxDuration = var_590_28

					if var_590_28 + var_590_22 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_28 + var_590_22
					end
				end

				arg_587_1.text_.text = var_590_25
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_29 = math.max(var_590_23, arg_587_1.talkMaxDuration)

			if var_590_22 <= arg_587_1.time_ and arg_587_1.time_ < var_590_22 + var_590_29 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_22) / var_590_29

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_22 + var_590_29 and arg_587_1.time_ < var_590_22 + var_590_29 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_587_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D12a",
		"TextureConfig/Background/ST2401",
		"TextureConfig/Background/ST0110"
	},
	voices = {
		"story_v_out_421041.awb"
	}
}
