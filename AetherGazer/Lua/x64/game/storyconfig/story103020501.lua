return {
	Play302051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 302051001
		arg_1_1.duration_ = 4.73

		local var_1_0 = {
			zh = 3.833333333332,
			ja = 4.733
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
				arg_1_0:Play302051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I28f"

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
				local var_4_5 = arg_1_1.bgs_.I28f

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
					if iter_4_0 ~= "I28f" then
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

			local var_4_24 = "10141ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10141ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10141ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10141ui_story"].transform
			local var_4_30 = 1.83333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10141ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(-0.7, -1.16, -6.15)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10141ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.7, -1.16, -6.15)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38

				local var_4_39 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_39 then
					var_4_39:EnableDynamicBone(true)
				end
			end

			local var_4_40 = arg_1_1.actors_["10141ui_story"]
			local var_4_41 = 1.83333333333333

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10141ui_story == nil then
				arg_1_1.var_.characterEffect10141ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect10141ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10141ui_story then
				arg_1_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_4_44 = 1.83333333333333

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action1_1")
			end

			local var_4_45 = 1.83333333333333

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0
			local var_4_47 = 1.26666666666667

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "effect"

				arg_1_1:AudioAction(var_4_48, var_4_49, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_4_50 = 1.26666666666667
			local var_4_51 = 1.26666666666667

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

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

			local var_4_56 = 0
			local var_4_57 = 0.833333333333333

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_58 = "play"
				local var_4_59 = "effect"

				arg_1_1:AudioAction(var_4_58, var_4_59, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_60 = 2
			local var_4_61 = 0.175

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_62 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[1553].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(302051001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051001", "story_v_out_302051.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_302051", "302051001", "story_v_out_302051.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_302051", "302051001", "story_v_out_302051.awb")

						arg_1_1:RecordAudio("302051001", var_4_70)
						arg_1_1:RecordAudio("302051001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_302051", "302051001", "story_v_out_302051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_302051", "302051001", "story_v_out_302051.awb")
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
				actorName = "10141ui_story",
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
	Play302051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 302051002
		arg_8_1.duration_ = 7.43

		local var_8_0 = {
			zh = 5.633,
			ja = 7.433
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play302051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "2079ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "2079ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_8_1.stage_.transform)

					var_11_2.name = var_11_0
					var_11_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_0] = var_11_2

					local var_11_3 = var_11_2:GetComponentInChildren(typeof(CharacterEffect))

					var_11_3.enabled = true

					local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_2, typeof(DynamicBoneHelper))

					if var_11_4 then
						var_11_4:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_3.transform, false)

					arg_8_1.var_[var_11_0 .. "Animator"] = var_11_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_0 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_0 .. "LipSync"] = var_11_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_5 = arg_8_1.actors_["2079ui_story"].transform
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.var_.moveOldPos2079ui_story = var_11_5.localPosition
			end

			local var_11_7 = 0.001

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7
				local var_11_9 = Vector3.New(0.7, -1.28, -5.6)

				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2079ui_story, var_11_9, var_11_8)

				local var_11_10 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_10.x, var_11_10.y, var_11_10.z)

				local var_11_11 = var_11_5.localEulerAngles

				var_11_11.z = 0
				var_11_11.x = 0
				var_11_5.localEulerAngles = var_11_11
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_11_12 = manager.ui.mainCamera.transform.position - var_11_5.position

				var_11_5.forward = Vector3.New(var_11_12.x, var_11_12.y, var_11_12.z)

				local var_11_13 = var_11_5.localEulerAngles

				var_11_13.z = 0
				var_11_13.x = 0
				var_11_5.localEulerAngles = var_11_13
			end

			local var_11_14 = arg_8_1.actors_["2079ui_story"]
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect2079ui_story == nil then
				arg_8_1.var_.characterEffect2079ui_story = var_11_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_16 = 0.200000002980232

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_16 and not isNil(var_11_14) then
				local var_11_17 = (arg_8_1.time_ - var_11_15) / var_11_16

				if arg_8_1.var_.characterEffect2079ui_story and not isNil(var_11_14) then
					arg_8_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_15 + var_11_16 and arg_8_1.time_ < var_11_15 + var_11_16 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect2079ui_story then
				arg_8_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_11_18 = arg_8_1.actors_["10141ui_story"]
			local var_11_19 = 0

			if var_11_19 < arg_8_1.time_ and arg_8_1.time_ <= var_11_19 + arg_11_0 and not isNil(var_11_18) and arg_8_1.var_.characterEffect10141ui_story == nil then
				arg_8_1.var_.characterEffect10141ui_story = var_11_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_20 = 0.200000002980232

			if var_11_19 <= arg_8_1.time_ and arg_8_1.time_ < var_11_19 + var_11_20 and not isNil(var_11_18) then
				local var_11_21 = (arg_8_1.time_ - var_11_19) / var_11_20

				if arg_8_1.var_.characterEffect10141ui_story and not isNil(var_11_18) then
					local var_11_22 = Mathf.Lerp(0, 0.5, var_11_21)

					arg_8_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10141ui_story.fillRatio = var_11_22
				end
			end

			if arg_8_1.time_ >= var_11_19 + var_11_20 and arg_8_1.time_ < var_11_19 + var_11_20 + arg_11_0 and not isNil(var_11_18) and arg_8_1.var_.characterEffect10141ui_story then
				local var_11_23 = 0.5

				arg_8_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10141ui_story.fillRatio = var_11_23
			end

			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_11_25 = 0

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				arg_8_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_26 = 0
			local var_11_27 = 0.825

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_28 = arg_8_1:FormatText(StoryNameCfg[688].name)

				arg_8_1.leftNameTxt_.text = var_11_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(302051002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 33
				local var_11_32 = utf8.len(var_11_30)
				local var_11_33 = var_11_31 <= 0 and var_11_27 or var_11_27 * (var_11_32 / var_11_31)

				if var_11_33 > 0 and var_11_27 < var_11_33 then
					arg_8_1.talkMaxDuration = var_11_33

					if var_11_33 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_33 + var_11_26
					end
				end

				arg_8_1.text_.text = var_11_30
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051002", "story_v_out_302051.awb") ~= 0 then
					local var_11_34 = manager.audio:GetVoiceLength("story_v_out_302051", "302051002", "story_v_out_302051.awb") / 1000

					if var_11_34 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_26
					end

					if var_11_29.prefab_name ~= "" and arg_8_1.actors_[var_11_29.prefab_name] ~= nil then
						local var_11_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_29.prefab_name].transform, "story_v_out_302051", "302051002", "story_v_out_302051.awb")

						arg_8_1:RecordAudio("302051002", var_11_35)
						arg_8_1:RecordAudio("302051002", var_11_35)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_302051", "302051002", "story_v_out_302051.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_302051", "302051002", "story_v_out_302051.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_36 = math.max(var_11_27, arg_8_1.talkMaxDuration)

			if var_11_26 <= arg_8_1.time_ and arg_8_1.time_ < var_11_26 + var_11_36 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_26) / var_11_36

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_26 + var_11_36 and arg_8_1.time_ < var_11_26 + var_11_36 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play302051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 302051003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play302051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["2079ui_story"].transform
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.var_.moveOldPos2079ui_story = var_15_0.localPosition
			end

			local var_15_2 = 0.001

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2
				local var_15_4 = Vector3.New(0, 100, 0)

				var_15_0.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2079ui_story, var_15_4, var_15_3)

				local var_15_5 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_5.x, var_15_5.y, var_15_5.z)

				local var_15_6 = var_15_0.localEulerAngles

				var_15_6.z = 0
				var_15_6.x = 0
				var_15_0.localEulerAngles = var_15_6
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 then
				var_15_0.localPosition = Vector3.New(0, 100, 0)

				local var_15_7 = manager.ui.mainCamera.transform.position - var_15_0.position

				var_15_0.forward = Vector3.New(var_15_7.x, var_15_7.y, var_15_7.z)

				local var_15_8 = var_15_0.localEulerAngles

				var_15_8.z = 0
				var_15_8.x = 0
				var_15_0.localEulerAngles = var_15_8
			end

			local var_15_9 = arg_12_1.actors_["10141ui_story"].transform
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.var_.moveOldPos10141ui_story = var_15_9.localPosition

				local var_15_11 = GameObjectTools.GetOrAddComponent(var_15_9.gameObject, typeof(DynamicBoneHelper))

				if var_15_11 then
					var_15_11:EnableDynamicBone(false)
				end
			end

			local var_15_12 = 0.001

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_12 then
				local var_15_13 = (arg_12_1.time_ - var_15_10) / var_15_12
				local var_15_14 = Vector3.New(0, 100, 0)

				var_15_9.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10141ui_story, var_15_14, var_15_13)

				local var_15_15 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_15.x, var_15_15.y, var_15_15.z)

				local var_15_16 = var_15_9.localEulerAngles

				var_15_16.z = 0
				var_15_16.x = 0
				var_15_9.localEulerAngles = var_15_16
			end

			if arg_12_1.time_ >= var_15_10 + var_15_12 and arg_12_1.time_ < var_15_10 + var_15_12 + arg_15_0 then
				var_15_9.localPosition = Vector3.New(0, 100, 0)

				local var_15_17 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_17.x, var_15_17.y, var_15_17.z)

				local var_15_18 = var_15_9.localEulerAngles

				var_15_18.z = 0
				var_15_18.x = 0
				var_15_9.localEulerAngles = var_15_18

				local var_15_19 = GameObjectTools.GetOrAddComponent(var_15_9.gameObject, typeof(DynamicBoneHelper))

				if var_15_19 then
					var_15_19:EnableDynamicBone(true)
				end
			end

			local var_15_20 = arg_12_1.actors_["2079ui_story"]
			local var_15_21 = 0

			if var_15_21 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 and not isNil(var_15_20) and arg_12_1.var_.characterEffect2079ui_story == nil then
				arg_12_1.var_.characterEffect2079ui_story = var_15_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_22 = 0.200000002980232

			if var_15_21 <= arg_12_1.time_ and arg_12_1.time_ < var_15_21 + var_15_22 and not isNil(var_15_20) then
				local var_15_23 = (arg_12_1.time_ - var_15_21) / var_15_22

				if arg_12_1.var_.characterEffect2079ui_story and not isNil(var_15_20) then
					local var_15_24 = Mathf.Lerp(0, 0.5, var_15_23)

					arg_12_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_12_1.var_.characterEffect2079ui_story.fillRatio = var_15_24
				end
			end

			if arg_12_1.time_ >= var_15_21 + var_15_22 and arg_12_1.time_ < var_15_21 + var_15_22 + arg_15_0 and not isNil(var_15_20) and arg_12_1.var_.characterEffect2079ui_story then
				local var_15_25 = 0.5

				arg_12_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_12_1.var_.characterEffect2079ui_story.fillRatio = var_15_25
			end

			local var_15_26 = 0
			local var_15_27 = 1.325

			if var_15_26 < arg_12_1.time_ and arg_12_1.time_ <= var_15_26 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_28 = arg_12_1:GetWordFromCfg(302051003)
				local var_15_29 = arg_12_1:FormatText(var_15_28.content)

				arg_12_1.text_.text = var_15_29

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_30 = 53
				local var_15_31 = utf8.len(var_15_29)
				local var_15_32 = var_15_30 <= 0 and var_15_27 or var_15_27 * (var_15_31 / var_15_30)

				if var_15_32 > 0 and var_15_27 < var_15_32 then
					arg_12_1.talkMaxDuration = var_15_32

					if var_15_32 + var_15_26 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_32 + var_15_26
					end
				end

				arg_12_1.text_.text = var_15_29
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_33 = math.max(var_15_27, arg_12_1.talkMaxDuration)

			if var_15_26 <= arg_12_1.time_ and arg_12_1.time_ < var_15_26 + var_15_33 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_26) / var_15_33

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_26 + var_15_33 and arg_12_1.time_ < var_15_26 + var_15_33 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play302051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 302051004
		arg_16_1.duration_ = 5.2

		local var_16_0 = {
			zh = 4.766,
			ja = 5.2
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play302051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10141ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos10141ui_story = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(-0.7, -1.16, -6.15)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10141ui_story, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(-0.7, -1.16, -6.15)

				local var_19_8 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_8.x, var_19_8.y, var_19_8.z)

				local var_19_9 = var_19_0.localEulerAngles

				var_19_9.z = 0
				var_19_9.x = 0
				var_19_0.localEulerAngles = var_19_9

				local var_19_10 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_10 then
					var_19_10:EnableDynamicBone(true)
				end
			end

			local var_19_11 = arg_16_1.actors_["10141ui_story"]
			local var_19_12 = 0

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect10141ui_story == nil then
				arg_16_1.var_.characterEffect10141ui_story = var_19_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_13 = 0.200000002980232

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_13 and not isNil(var_19_11) then
				local var_19_14 = (arg_16_1.time_ - var_19_12) / var_19_13

				if arg_16_1.var_.characterEffect10141ui_story and not isNil(var_19_11) then
					arg_16_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_12 + var_19_13 and arg_16_1.time_ < var_19_12 + var_19_13 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect10141ui_story then
				arg_16_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action18_1")
			end

			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_19_17 = 0
			local var_19_18 = 0.4

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_19 = arg_16_1:FormatText(StoryNameCfg[1553].name)

				arg_16_1.leftNameTxt_.text = var_19_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_20 = arg_16_1:GetWordFromCfg(302051004)
				local var_19_21 = arg_16_1:FormatText(var_19_20.content)

				arg_16_1.text_.text = var_19_21

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_22 = 16
				local var_19_23 = utf8.len(var_19_21)
				local var_19_24 = var_19_22 <= 0 and var_19_18 or var_19_18 * (var_19_23 / var_19_22)

				if var_19_24 > 0 and var_19_18 < var_19_24 then
					arg_16_1.talkMaxDuration = var_19_24

					if var_19_24 + var_19_17 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_24 + var_19_17
					end
				end

				arg_16_1.text_.text = var_19_21
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051004", "story_v_out_302051.awb") ~= 0 then
					local var_19_25 = manager.audio:GetVoiceLength("story_v_out_302051", "302051004", "story_v_out_302051.awb") / 1000

					if var_19_25 + var_19_17 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_25 + var_19_17
					end

					if var_19_20.prefab_name ~= "" and arg_16_1.actors_[var_19_20.prefab_name] ~= nil then
						local var_19_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_20.prefab_name].transform, "story_v_out_302051", "302051004", "story_v_out_302051.awb")

						arg_16_1:RecordAudio("302051004", var_19_26)
						arg_16_1:RecordAudio("302051004", var_19_26)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_302051", "302051004", "story_v_out_302051.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_302051", "302051004", "story_v_out_302051.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_27 = math.max(var_19_18, arg_16_1.talkMaxDuration)

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_27 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_17) / var_19_27

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_17 + var_19_27 and arg_16_1.time_ < var_19_17 + var_19_27 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play302051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 302051005
		arg_20_1.duration_ = 2.87

		local var_20_0 = {
			zh = 2.2,
			ja = 2.866
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play302051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["2079ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos2079ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0.7, -1.28, -5.6)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos2079ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = arg_20_1.actors_["2079ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect2079ui_story == nil then
				arg_20_1.var_.characterEffect2079ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect2079ui_story and not isNil(var_23_9) then
					arg_20_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect2079ui_story then
				arg_20_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_23_13 = arg_20_1.actors_["10141ui_story"]
			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 and not isNil(var_23_13) and arg_20_1.var_.characterEffect10141ui_story == nil then
				arg_20_1.var_.characterEffect10141ui_story = var_23_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_15 = 0.200000002980232

			if var_23_14 <= arg_20_1.time_ and arg_20_1.time_ < var_23_14 + var_23_15 and not isNil(var_23_13) then
				local var_23_16 = (arg_20_1.time_ - var_23_14) / var_23_15

				if arg_20_1.var_.characterEffect10141ui_story and not isNil(var_23_13) then
					local var_23_17 = Mathf.Lerp(0, 0.5, var_23_16)

					arg_20_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10141ui_story.fillRatio = var_23_17
				end
			end

			if arg_20_1.time_ >= var_23_14 + var_23_15 and arg_20_1.time_ < var_23_14 + var_23_15 + arg_23_0 and not isNil(var_23_13) and arg_20_1.var_.characterEffect10141ui_story then
				local var_23_18 = 0.5

				arg_20_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10141ui_story.fillRatio = var_23_18
			end

			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_23_20 = 0

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_21 = 0
			local var_23_22 = 0.275

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_23 = arg_20_1:FormatText(StoryNameCfg[688].name)

				arg_20_1.leftNameTxt_.text = var_23_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_24 = arg_20_1:GetWordFromCfg(302051005)
				local var_23_25 = arg_20_1:FormatText(var_23_24.content)

				arg_20_1.text_.text = var_23_25

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_26 = 11
				local var_23_27 = utf8.len(var_23_25)
				local var_23_28 = var_23_26 <= 0 and var_23_22 or var_23_22 * (var_23_27 / var_23_26)

				if var_23_28 > 0 and var_23_22 < var_23_28 then
					arg_20_1.talkMaxDuration = var_23_28

					if var_23_28 + var_23_21 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_21
					end
				end

				arg_20_1.text_.text = var_23_25
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051005", "story_v_out_302051.awb") ~= 0 then
					local var_23_29 = manager.audio:GetVoiceLength("story_v_out_302051", "302051005", "story_v_out_302051.awb") / 1000

					if var_23_29 + var_23_21 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_29 + var_23_21
					end

					if var_23_24.prefab_name ~= "" and arg_20_1.actors_[var_23_24.prefab_name] ~= nil then
						local var_23_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_24.prefab_name].transform, "story_v_out_302051", "302051005", "story_v_out_302051.awb")

						arg_20_1:RecordAudio("302051005", var_23_30)
						arg_20_1:RecordAudio("302051005", var_23_30)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_302051", "302051005", "story_v_out_302051.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_302051", "302051005", "story_v_out_302051.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_31 = math.max(var_23_22, arg_20_1.talkMaxDuration)

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_31 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_21) / var_23_31

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_21 + var_23_31 and arg_20_1.time_ < var_23_21 + var_23_31 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play302051006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 302051006
		arg_24_1.duration_ = 6.03

		local var_24_0 = {
			zh = 4.1,
			ja = 6.033
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play302051007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10141ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10141ui_story == nil then
				arg_24_1.var_.characterEffect10141ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect10141ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10141ui_story then
				arg_24_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["2079ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect2079ui_story == nil then
				arg_24_1.var_.characterEffect2079ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.200000002980232

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect2079ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_24_1.var_.characterEffect2079ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect2079ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_24_1.var_.characterEffect2079ui_story.fillRatio = var_27_9
			end

			local var_27_10 = 0

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action18_2")
			end

			local var_27_11 = 0

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				arg_24_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_27_12 = 0
			local var_27_13 = 0.5

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_14 = arg_24_1:FormatText(StoryNameCfg[1553].name)

				arg_24_1.leftNameTxt_.text = var_27_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_15 = arg_24_1:GetWordFromCfg(302051006)
				local var_27_16 = arg_24_1:FormatText(var_27_15.content)

				arg_24_1.text_.text = var_27_16

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 20
				local var_27_18 = utf8.len(var_27_16)
				local var_27_19 = var_27_17 <= 0 and var_27_13 or var_27_13 * (var_27_18 / var_27_17)

				if var_27_19 > 0 and var_27_13 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_12
					end
				end

				arg_24_1.text_.text = var_27_16
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051006", "story_v_out_302051.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051006", "story_v_out_302051.awb") / 1000

					if var_27_20 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_12
					end

					if var_27_15.prefab_name ~= "" and arg_24_1.actors_[var_27_15.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_15.prefab_name].transform, "story_v_out_302051", "302051006", "story_v_out_302051.awb")

						arg_24_1:RecordAudio("302051006", var_27_21)
						arg_24_1:RecordAudio("302051006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_302051", "302051006", "story_v_out_302051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_302051", "302051006", "story_v_out_302051.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_13, arg_24_1.talkMaxDuration)

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_12) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_12 + var_27_22 and arg_24_1.time_ < var_27_12 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play302051007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 302051007
		arg_28_1.duration_ = 4.6

		local var_28_0 = {
			zh = 3.966,
			ja = 4.6
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play302051008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["2079ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect2079ui_story == nil then
				arg_28_1.var_.characterEffect2079ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect2079ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect2079ui_story then
				arg_28_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["10141ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect10141ui_story == nil then
				arg_28_1.var_.characterEffect10141ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect10141ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10141ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect10141ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10141ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_12 = 0
			local var_31_13 = 0.5

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_14 = arg_28_1:FormatText(StoryNameCfg[688].name)

				arg_28_1.leftNameTxt_.text = var_31_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_15 = arg_28_1:GetWordFromCfg(302051007)
				local var_31_16 = arg_28_1:FormatText(var_31_15.content)

				arg_28_1.text_.text = var_31_16

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 20
				local var_31_18 = utf8.len(var_31_16)
				local var_31_19 = var_31_17 <= 0 and var_31_13 or var_31_13 * (var_31_18 / var_31_17)

				if var_31_19 > 0 and var_31_13 < var_31_19 then
					arg_28_1.talkMaxDuration = var_31_19

					if var_31_19 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_19 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_16
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051007", "story_v_out_302051.awb") ~= 0 then
					local var_31_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051007", "story_v_out_302051.awb") / 1000

					if var_31_20 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_12
					end

					if var_31_15.prefab_name ~= "" and arg_28_1.actors_[var_31_15.prefab_name] ~= nil then
						local var_31_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_15.prefab_name].transform, "story_v_out_302051", "302051007", "story_v_out_302051.awb")

						arg_28_1:RecordAudio("302051007", var_31_21)
						arg_28_1:RecordAudio("302051007", var_31_21)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_302051", "302051007", "story_v_out_302051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_302051", "302051007", "story_v_out_302051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_22 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_22

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_22 and arg_28_1.time_ < var_31_12 + var_31_22 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play302051008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 302051008
		arg_32_1.duration_ = 10.57

		local var_32_0 = {
			zh = 10.566,
			ja = 7.133
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play302051009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10141ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10141ui_story == nil then
				arg_32_1.var_.characterEffect10141ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect10141ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10141ui_story then
				arg_32_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["2079ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect2079ui_story == nil then
				arg_32_1.var_.characterEffect2079ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect2079ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_32_1.var_.characterEffect2079ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect2079ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_32_1.var_.characterEffect2079ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action23_1")
			end

			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_35_12 = 0
			local var_35_13 = 1.225

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_14 = arg_32_1:FormatText(StoryNameCfg[1553].name)

				arg_32_1.leftNameTxt_.text = var_35_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_15 = arg_32_1:GetWordFromCfg(302051008)
				local var_35_16 = arg_32_1:FormatText(var_35_15.content)

				arg_32_1.text_.text = var_35_16

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 49
				local var_35_18 = utf8.len(var_35_16)
				local var_35_19 = var_35_17 <= 0 and var_35_13 or var_35_13 * (var_35_18 / var_35_17)

				if var_35_19 > 0 and var_35_13 < var_35_19 then
					arg_32_1.talkMaxDuration = var_35_19

					if var_35_19 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_16
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051008", "story_v_out_302051.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051008", "story_v_out_302051.awb") / 1000

					if var_35_20 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_12
					end

					if var_35_15.prefab_name ~= "" and arg_32_1.actors_[var_35_15.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_15.prefab_name].transform, "story_v_out_302051", "302051008", "story_v_out_302051.awb")

						arg_32_1:RecordAudio("302051008", var_35_21)
						arg_32_1:RecordAudio("302051008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_302051", "302051008", "story_v_out_302051.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_302051", "302051008", "story_v_out_302051.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_22 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_22 and arg_32_1.time_ < var_35_12 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play302051009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 302051009
		arg_36_1.duration_ = 8.8

		local var_36_0 = {
			zh = 5.633,
			ja = 8.8
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play302051010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.725

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[1553].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:GetWordFromCfg(302051009)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 29
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051009", "story_v_out_302051.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_302051", "302051009", "story_v_out_302051.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_302051", "302051009", "story_v_out_302051.awb")

						arg_36_1:RecordAudio("302051009", var_39_9)
						arg_36_1:RecordAudio("302051009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_302051", "302051009", "story_v_out_302051.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_302051", "302051009", "story_v_out_302051.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play302051010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 302051010
		arg_40_1.duration_ = 6.13

		local var_40_0 = {
			zh = 5.4,
			ja = 6.133
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play302051011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["2079ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect2079ui_story == nil then
				arg_40_1.var_.characterEffect2079ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect2079ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect2079ui_story then
				arg_40_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["10141ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect10141ui_story == nil then
				arg_40_1.var_.characterEffect10141ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.200000002980232

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect10141ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10141ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect10141ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10141ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_12 = 0
			local var_43_13 = 0.625

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[688].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(302051010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 25
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051010", "story_v_out_302051.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051010", "story_v_out_302051.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_302051", "302051010", "story_v_out_302051.awb")

						arg_40_1:RecordAudio("302051010", var_43_21)
						arg_40_1:RecordAudio("302051010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_302051", "302051010", "story_v_out_302051.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_302051", "302051010", "story_v_out_302051.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play302051011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 302051011
		arg_44_1.duration_ = 8.13

		local var_44_0 = {
			zh = 6.2,
			ja = 8.133
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play302051012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10141ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10141ui_story == nil then
				arg_44_1.var_.characterEffect10141ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect10141ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10141ui_story then
				arg_44_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["2079ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect2079ui_story == nil then
				arg_44_1.var_.characterEffect2079ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.200000002980232

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect2079ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_44_1.var_.characterEffect2079ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect2079ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_44_1.var_.characterEffect2079ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141actionlink/10141action42318")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_47_12 = 0
			local var_47_13 = 0.65

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[1553].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(302051011)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 26
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051011", "story_v_out_302051.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051011", "story_v_out_302051.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_302051", "302051011", "story_v_out_302051.awb")

						arg_44_1:RecordAudio("302051011", var_47_21)
						arg_44_1:RecordAudio("302051011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_302051", "302051011", "story_v_out_302051.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_302051", "302051011", "story_v_out_302051.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play302051012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 302051012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play302051013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["2079ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos2079ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, 100, 0)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos2079ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, 100, 0)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = arg_48_1.actors_["10141ui_story"].transform
			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.var_.moveOldPos10141ui_story = var_51_9.localPosition

				local var_51_11 = GameObjectTools.GetOrAddComponent(var_51_9.gameObject, typeof(DynamicBoneHelper))

				if var_51_11 then
					var_51_11:EnableDynamicBone(false)
				end
			end

			local var_51_12 = 0.001

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_10) / var_51_12
				local var_51_14 = Vector3.New(0, 100, 0)

				var_51_9.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10141ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_9.position

				var_51_9.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_9.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_9.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_10 + var_51_12 and arg_48_1.time_ < var_51_10 + var_51_12 + arg_51_0 then
				var_51_9.localPosition = Vector3.New(0, 100, 0)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_9.position

				var_51_9.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_9.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_9.localEulerAngles = var_51_18

				local var_51_19 = GameObjectTools.GetOrAddComponent(var_51_9.gameObject, typeof(DynamicBoneHelper))

				if var_51_19 then
					var_51_19:EnableDynamicBone(true)
				end
			end

			local var_51_20 = arg_48_1.actors_["10141ui_story"]
			local var_51_21 = 0

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 and not isNil(var_51_20) and arg_48_1.var_.characterEffect10141ui_story == nil then
				arg_48_1.var_.characterEffect10141ui_story = var_51_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_22 = 0.200000002980232

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_22 and not isNil(var_51_20) then
				local var_51_23 = (arg_48_1.time_ - var_51_21) / var_51_22

				if arg_48_1.var_.characterEffect10141ui_story and not isNil(var_51_20) then
					local var_51_24 = Mathf.Lerp(0, 0.5, var_51_23)

					arg_48_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10141ui_story.fillRatio = var_51_24
				end
			end

			if arg_48_1.time_ >= var_51_21 + var_51_22 and arg_48_1.time_ < var_51_21 + var_51_22 + arg_51_0 and not isNil(var_51_20) and arg_48_1.var_.characterEffect10141ui_story then
				local var_51_25 = 0.5

				arg_48_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10141ui_story.fillRatio = var_51_25
			end

			local var_51_26 = 0
			local var_51_27 = 1.05

			if var_51_26 < arg_48_1.time_ and arg_48_1.time_ <= var_51_26 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_28 = arg_48_1:GetWordFromCfg(302051012)
				local var_51_29 = arg_48_1:FormatText(var_51_28.content)

				arg_48_1.text_.text = var_51_29

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_30 = 42
				local var_51_31 = utf8.len(var_51_29)
				local var_51_32 = var_51_30 <= 0 and var_51_27 or var_51_27 * (var_51_31 / var_51_30)

				if var_51_32 > 0 and var_51_27 < var_51_32 then
					arg_48_1.talkMaxDuration = var_51_32

					if var_51_32 + var_51_26 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_32 + var_51_26
					end
				end

				arg_48_1.text_.text = var_51_29
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_33 = math.max(var_51_27, arg_48_1.talkMaxDuration)

			if var_51_26 <= arg_48_1.time_ and arg_48_1.time_ < var_51_26 + var_51_33 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_26) / var_51_33

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_26 + var_51_33 and arg_48_1.time_ < var_51_26 + var_51_33 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play302051013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 302051013
		arg_52_1.duration_ = 4.33

		local var_52_0 = {
			zh = 4.333,
			ja = 2.466
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play302051014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10141ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos10141ui_story = var_55_0.localPosition

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end
			end

			local var_55_3 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_3 then
				local var_55_4 = (arg_52_1.time_ - var_55_1) / var_55_3
				local var_55_5 = Vector3.New(-0.7, -1.16, -6.15)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10141ui_story, var_55_5, var_55_4)

				local var_55_6 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_6.x, var_55_6.y, var_55_6.z)

				local var_55_7 = var_55_0.localEulerAngles

				var_55_7.z = 0
				var_55_7.x = 0
				var_55_0.localEulerAngles = var_55_7
			end

			if arg_52_1.time_ >= var_55_1 + var_55_3 and arg_52_1.time_ < var_55_1 + var_55_3 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(-0.7, -1.16, -6.15)

				local var_55_8 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_8.x, var_55_8.y, var_55_8.z)

				local var_55_9 = var_55_0.localEulerAngles

				var_55_9.z = 0
				var_55_9.x = 0
				var_55_0.localEulerAngles = var_55_9

				local var_55_10 = GameObjectTools.GetOrAddComponent(var_55_0.gameObject, typeof(DynamicBoneHelper))

				if var_55_10 then
					var_55_10:EnableDynamicBone(true)
				end
			end

			local var_55_11 = arg_52_1.actors_["10141ui_story"]
			local var_55_12 = 0

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 and not isNil(var_55_11) and arg_52_1.var_.characterEffect10141ui_story == nil then
				arg_52_1.var_.characterEffect10141ui_story = var_55_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_13 = 0.200000002980232

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_13 and not isNil(var_55_11) then
				local var_55_14 = (arg_52_1.time_ - var_55_12) / var_55_13

				if arg_52_1.var_.characterEffect10141ui_story and not isNil(var_55_11) then
					arg_52_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_12 + var_55_13 and arg_52_1.time_ < var_55_12 + var_55_13 + arg_55_0 and not isNil(var_55_11) and arg_52_1.var_.characterEffect10141ui_story then
				arg_52_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141actionlink/10141action41825")
			end

			local var_55_16 = 0

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_55_17 = 0
			local var_55_18 = 0.525

			if var_55_17 < arg_52_1.time_ and arg_52_1.time_ <= var_55_17 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_19 = arg_52_1:FormatText(StoryNameCfg[1553].name)

				arg_52_1.leftNameTxt_.text = var_55_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_20 = arg_52_1:GetWordFromCfg(302051013)
				local var_55_21 = arg_52_1:FormatText(var_55_20.content)

				arg_52_1.text_.text = var_55_21

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_22 = 21
				local var_55_23 = utf8.len(var_55_21)
				local var_55_24 = var_55_22 <= 0 and var_55_18 or var_55_18 * (var_55_23 / var_55_22)

				if var_55_24 > 0 and var_55_18 < var_55_24 then
					arg_52_1.talkMaxDuration = var_55_24

					if var_55_24 + var_55_17 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_17
					end
				end

				arg_52_1.text_.text = var_55_21
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051013", "story_v_out_302051.awb") ~= 0 then
					local var_55_25 = manager.audio:GetVoiceLength("story_v_out_302051", "302051013", "story_v_out_302051.awb") / 1000

					if var_55_25 + var_55_17 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_25 + var_55_17
					end

					if var_55_20.prefab_name ~= "" and arg_52_1.actors_[var_55_20.prefab_name] ~= nil then
						local var_55_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_20.prefab_name].transform, "story_v_out_302051", "302051013", "story_v_out_302051.awb")

						arg_52_1:RecordAudio("302051013", var_55_26)
						arg_52_1:RecordAudio("302051013", var_55_26)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_302051", "302051013", "story_v_out_302051.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_302051", "302051013", "story_v_out_302051.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_27 = math.max(var_55_18, arg_52_1.talkMaxDuration)

			if var_55_17 <= arg_52_1.time_ and arg_52_1.time_ < var_55_17 + var_55_27 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_17) / var_55_27

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_17 + var_55_27 and arg_52_1.time_ < var_55_17 + var_55_27 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play302051014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 302051014
		arg_56_1.duration_ = 2

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play302051015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["2079ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos2079ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0.7, -1.28, -5.6)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos2079ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["2079ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect2079ui_story == nil then
				arg_56_1.var_.characterEffect2079ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect2079ui_story and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect2079ui_story then
				arg_56_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_59_13 = arg_56_1.actors_["10141ui_story"]
			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 and not isNil(var_59_13) and arg_56_1.var_.characterEffect10141ui_story == nil then
				arg_56_1.var_.characterEffect10141ui_story = var_59_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_15 = 0.200000002980232

			if var_59_14 <= arg_56_1.time_ and arg_56_1.time_ < var_59_14 + var_59_15 and not isNil(var_59_13) then
				local var_59_16 = (arg_56_1.time_ - var_59_14) / var_59_15

				if arg_56_1.var_.characterEffect10141ui_story and not isNil(var_59_13) then
					local var_59_17 = Mathf.Lerp(0, 0.5, var_59_16)

					arg_56_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10141ui_story.fillRatio = var_59_17
				end
			end

			if arg_56_1.time_ >= var_59_14 + var_59_15 and arg_56_1.time_ < var_59_14 + var_59_15 + arg_59_0 and not isNil(var_59_13) and arg_56_1.var_.characterEffect10141ui_story then
				local var_59_18 = 0.5

				arg_56_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10141ui_story.fillRatio = var_59_18
			end

			local var_59_19 = 0

			if var_59_19 < arg_56_1.time_ and arg_56_1.time_ <= var_59_19 + arg_59_0 then
				arg_56_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_21 = 0
			local var_59_22 = 0.175

			if var_59_21 < arg_56_1.time_ and arg_56_1.time_ <= var_59_21 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_23 = arg_56_1:FormatText(StoryNameCfg[688].name)

				arg_56_1.leftNameTxt_.text = var_59_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_24 = arg_56_1:GetWordFromCfg(302051014)
				local var_59_25 = arg_56_1:FormatText(var_59_24.content)

				arg_56_1.text_.text = var_59_25

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_26 = 7
				local var_59_27 = utf8.len(var_59_25)
				local var_59_28 = var_59_26 <= 0 and var_59_22 or var_59_22 * (var_59_27 / var_59_26)

				if var_59_28 > 0 and var_59_22 < var_59_28 then
					arg_56_1.talkMaxDuration = var_59_28

					if var_59_28 + var_59_21 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_28 + var_59_21
					end
				end

				arg_56_1.text_.text = var_59_25
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051014", "story_v_out_302051.awb") ~= 0 then
					local var_59_29 = manager.audio:GetVoiceLength("story_v_out_302051", "302051014", "story_v_out_302051.awb") / 1000

					if var_59_29 + var_59_21 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_29 + var_59_21
					end

					if var_59_24.prefab_name ~= "" and arg_56_1.actors_[var_59_24.prefab_name] ~= nil then
						local var_59_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_24.prefab_name].transform, "story_v_out_302051", "302051014", "story_v_out_302051.awb")

						arg_56_1:RecordAudio("302051014", var_59_30)
						arg_56_1:RecordAudio("302051014", var_59_30)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_302051", "302051014", "story_v_out_302051.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_302051", "302051014", "story_v_out_302051.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_31 = math.max(var_59_22, arg_56_1.talkMaxDuration)

			if var_59_21 <= arg_56_1.time_ and arg_56_1.time_ < var_59_21 + var_59_31 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_21) / var_59_31

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_21 + var_59_31 and arg_56_1.time_ < var_59_21 + var_59_31 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play302051015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 302051015
		arg_60_1.duration_ = 11.17

		local var_60_0 = {
			zh = 6.333,
			ja = 11.166
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play302051016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10141ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10141ui_story == nil then
				arg_60_1.var_.characterEffect10141ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect10141ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10141ui_story then
				arg_60_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["2079ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect2079ui_story == nil then
				arg_60_1.var_.characterEffect2079ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect2079ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_60_1.var_.characterEffect2079ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect2079ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_60_1.var_.characterEffect2079ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141actionlink/10141action42518")
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_63_12 = 0
			local var_63_13 = 0.725

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[1553].name)

				arg_60_1.leftNameTxt_.text = var_63_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(302051015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 29
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051015", "story_v_out_302051.awb") ~= 0 then
					local var_63_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051015", "story_v_out_302051.awb") / 1000

					if var_63_20 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_302051", "302051015", "story_v_out_302051.awb")

						arg_60_1:RecordAudio("302051015", var_63_21)
						arg_60_1:RecordAudio("302051015", var_63_21)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_302051", "302051015", "story_v_out_302051.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_302051", "302051015", "story_v_out_302051.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_22 and arg_60_1.time_ < var_63_12 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play302051016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 302051016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play302051017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["2079ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos2079ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2079ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["10141ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos10141ui_story = var_67_9.localPosition

				local var_67_11 = GameObjectTools.GetOrAddComponent(var_67_9.gameObject, typeof(DynamicBoneHelper))

				if var_67_11 then
					var_67_11:EnableDynamicBone(false)
				end
			end

			local var_67_12 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_10) / var_67_12
				local var_67_14 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10141ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_9.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_9.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_10 + var_67_12 and arg_64_1.time_ < var_67_10 + var_67_12 + arg_67_0 then
				var_67_9.localPosition = Vector3.New(0, 100, 0)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_9.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_9.localEulerAngles = var_67_18

				local var_67_19 = GameObjectTools.GetOrAddComponent(var_67_9.gameObject, typeof(DynamicBoneHelper))

				if var_67_19 then
					var_67_19:EnableDynamicBone(true)
				end
			end

			local var_67_20 = arg_64_1.actors_["10141ui_story"]
			local var_67_21 = 0

			if var_67_21 < arg_64_1.time_ and arg_64_1.time_ <= var_67_21 + arg_67_0 and not isNil(var_67_20) and arg_64_1.var_.characterEffect10141ui_story == nil then
				arg_64_1.var_.characterEffect10141ui_story = var_67_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_22 = 0.200000002980232

			if var_67_21 <= arg_64_1.time_ and arg_64_1.time_ < var_67_21 + var_67_22 and not isNil(var_67_20) then
				local var_67_23 = (arg_64_1.time_ - var_67_21) / var_67_22

				if arg_64_1.var_.characterEffect10141ui_story and not isNil(var_67_20) then
					local var_67_24 = Mathf.Lerp(0, 0.5, var_67_23)

					arg_64_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10141ui_story.fillRatio = var_67_24
				end
			end

			if arg_64_1.time_ >= var_67_21 + var_67_22 and arg_64_1.time_ < var_67_21 + var_67_22 + arg_67_0 and not isNil(var_67_20) and arg_64_1.var_.characterEffect10141ui_story then
				local var_67_25 = 0.5

				arg_64_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10141ui_story.fillRatio = var_67_25
			end

			local var_67_26 = 0
			local var_67_27 = 1.15

			if var_67_26 < arg_64_1.time_ and arg_64_1.time_ <= var_67_26 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_28 = arg_64_1:GetWordFromCfg(302051016)
				local var_67_29 = arg_64_1:FormatText(var_67_28.content)

				arg_64_1.text_.text = var_67_29

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_30 = 46
				local var_67_31 = utf8.len(var_67_29)
				local var_67_32 = var_67_30 <= 0 and var_67_27 or var_67_27 * (var_67_31 / var_67_30)

				if var_67_32 > 0 and var_67_27 < var_67_32 then
					arg_64_1.talkMaxDuration = var_67_32

					if var_67_32 + var_67_26 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_32 + var_67_26
					end
				end

				arg_64_1.text_.text = var_67_29
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_33 = math.max(var_67_27, arg_64_1.talkMaxDuration)

			if var_67_26 <= arg_64_1.time_ and arg_64_1.time_ < var_67_26 + var_67_33 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_26) / var_67_33

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_26 + var_67_33 and arg_64_1.time_ < var_67_26 + var_67_33 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play302051017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 302051017
		arg_68_1.duration_ = 6.47

		local var_68_0 = {
			zh = 5.233,
			ja = 6.466
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play302051018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["2079ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos2079ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0.7, -1.28, -5.6)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos2079ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0.7, -1.28, -5.6)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["2079ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect2079ui_story == nil then
				arg_68_1.var_.characterEffect2079ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.200000002980232

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect2079ui_story and not isNil(var_71_9) then
					arg_68_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect2079ui_story then
				arg_68_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_71_13 = 0

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_71_14 = 0

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_71_15 = 0
			local var_71_16 = 0.625

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[688].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(302051017)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 25
				local var_71_21 = utf8.len(var_71_19)
				local var_71_22 = var_71_20 <= 0 and var_71_16 or var_71_16 * (var_71_21 / var_71_20)

				if var_71_22 > 0 and var_71_16 < var_71_22 then
					arg_68_1.talkMaxDuration = var_71_22

					if var_71_22 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051017", "story_v_out_302051.awb") ~= 0 then
					local var_71_23 = manager.audio:GetVoiceLength("story_v_out_302051", "302051017", "story_v_out_302051.awb") / 1000

					if var_71_23 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_15
					end

					if var_71_18.prefab_name ~= "" and arg_68_1.actors_[var_71_18.prefab_name] ~= nil then
						local var_71_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_18.prefab_name].transform, "story_v_out_302051", "302051017", "story_v_out_302051.awb")

						arg_68_1:RecordAudio("302051017", var_71_24)
						arg_68_1:RecordAudio("302051017", var_71_24)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_302051", "302051017", "story_v_out_302051.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_302051", "302051017", "story_v_out_302051.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_25 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_25 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_25

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_25 and arg_68_1.time_ < var_71_15 + var_71_25 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play302051018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 302051018
		arg_72_1.duration_ = 3.13

		local var_72_0 = {
			zh = 2.166,
			ja = 3.133
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play302051019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10141ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos10141ui_story = var_75_0.localPosition

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end
			end

			local var_75_3 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_3 then
				local var_75_4 = (arg_72_1.time_ - var_75_1) / var_75_3
				local var_75_5 = Vector3.New(-0.7, -1.16, -6.15)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10141ui_story, var_75_5, var_75_4)

				local var_75_6 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_6.x, var_75_6.y, var_75_6.z)

				local var_75_7 = var_75_0.localEulerAngles

				var_75_7.z = 0
				var_75_7.x = 0
				var_75_0.localEulerAngles = var_75_7
			end

			if arg_72_1.time_ >= var_75_1 + var_75_3 and arg_72_1.time_ < var_75_1 + var_75_3 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(-0.7, -1.16, -6.15)

				local var_75_8 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_8.x, var_75_8.y, var_75_8.z)

				local var_75_9 = var_75_0.localEulerAngles

				var_75_9.z = 0
				var_75_9.x = 0
				var_75_0.localEulerAngles = var_75_9

				local var_75_10 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_10 then
					var_75_10:EnableDynamicBone(true)
				end
			end

			local var_75_11 = arg_72_1.actors_["10141ui_story"]
			local var_75_12 = 0

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 and not isNil(var_75_11) and arg_72_1.var_.characterEffect10141ui_story == nil then
				arg_72_1.var_.characterEffect10141ui_story = var_75_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_13 = 0.200000002980232

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_13 and not isNil(var_75_11) then
				local var_75_14 = (arg_72_1.time_ - var_75_12) / var_75_13

				if arg_72_1.var_.characterEffect10141ui_story and not isNil(var_75_11) then
					arg_72_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_12 + var_75_13 and arg_72_1.time_ < var_75_12 + var_75_13 + arg_75_0 and not isNil(var_75_11) and arg_72_1.var_.characterEffect10141ui_story then
				arg_72_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_75_15 = arg_72_1.actors_["2079ui_story"]
			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 and not isNil(var_75_15) and arg_72_1.var_.characterEffect2079ui_story == nil then
				arg_72_1.var_.characterEffect2079ui_story = var_75_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_17 = 0.200000002980232

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_17 and not isNil(var_75_15) then
				local var_75_18 = (arg_72_1.time_ - var_75_16) / var_75_17

				if arg_72_1.var_.characterEffect2079ui_story and not isNil(var_75_15) then
					local var_75_19 = Mathf.Lerp(0, 0.5, var_75_18)

					arg_72_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_72_1.var_.characterEffect2079ui_story.fillRatio = var_75_19
				end
			end

			if arg_72_1.time_ >= var_75_16 + var_75_17 and arg_72_1.time_ < var_75_16 + var_75_17 + arg_75_0 and not isNil(var_75_15) and arg_72_1.var_.characterEffect2079ui_story then
				local var_75_20 = 0.5

				arg_72_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_72_1.var_.characterEffect2079ui_story.fillRatio = var_75_20
			end

			local var_75_21 = 0

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 then
				arg_72_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action18_2")
			end

			local var_75_22 = 0

			if var_75_22 < arg_72_1.time_ and arg_72_1.time_ <= var_75_22 + arg_75_0 then
				arg_72_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_75_23 = 0
			local var_75_24 = 0.2

			if var_75_23 < arg_72_1.time_ and arg_72_1.time_ <= var_75_23 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_25 = arg_72_1:FormatText(StoryNameCfg[1553].name)

				arg_72_1.leftNameTxt_.text = var_75_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_26 = arg_72_1:GetWordFromCfg(302051018)
				local var_75_27 = arg_72_1:FormatText(var_75_26.content)

				arg_72_1.text_.text = var_75_27

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_28 = 8
				local var_75_29 = utf8.len(var_75_27)
				local var_75_30 = var_75_28 <= 0 and var_75_24 or var_75_24 * (var_75_29 / var_75_28)

				if var_75_30 > 0 and var_75_24 < var_75_30 then
					arg_72_1.talkMaxDuration = var_75_30

					if var_75_30 + var_75_23 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_30 + var_75_23
					end
				end

				arg_72_1.text_.text = var_75_27
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051018", "story_v_out_302051.awb") ~= 0 then
					local var_75_31 = manager.audio:GetVoiceLength("story_v_out_302051", "302051018", "story_v_out_302051.awb") / 1000

					if var_75_31 + var_75_23 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_31 + var_75_23
					end

					if var_75_26.prefab_name ~= "" and arg_72_1.actors_[var_75_26.prefab_name] ~= nil then
						local var_75_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_26.prefab_name].transform, "story_v_out_302051", "302051018", "story_v_out_302051.awb")

						arg_72_1:RecordAudio("302051018", var_75_32)
						arg_72_1:RecordAudio("302051018", var_75_32)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_302051", "302051018", "story_v_out_302051.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_302051", "302051018", "story_v_out_302051.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_33 = math.max(var_75_24, arg_72_1.talkMaxDuration)

			if var_75_23 <= arg_72_1.time_ and arg_72_1.time_ < var_75_23 + var_75_33 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_23) / var_75_33

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_23 + var_75_33 and arg_72_1.time_ < var_75_23 + var_75_33 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play302051019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 302051019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play302051020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["2079ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos2079ui_story = var_79_0.localPosition
			end

			local var_79_2 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2
				local var_79_4 = Vector3.New(0, 100, 0)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos2079ui_story, var_79_4, var_79_3)

				local var_79_5 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_5.x, var_79_5.y, var_79_5.z)

				local var_79_6 = var_79_0.localEulerAngles

				var_79_6.z = 0
				var_79_6.x = 0
				var_79_0.localEulerAngles = var_79_6
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, 100, 0)

				local var_79_7 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_7.x, var_79_7.y, var_79_7.z)

				local var_79_8 = var_79_0.localEulerAngles

				var_79_8.z = 0
				var_79_8.x = 0
				var_79_0.localEulerAngles = var_79_8
			end

			local var_79_9 = arg_76_1.actors_["10141ui_story"].transform
			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.var_.moveOldPos10141ui_story = var_79_9.localPosition

				local var_79_11 = GameObjectTools.GetOrAddComponent(var_79_9.gameObject, typeof(DynamicBoneHelper))

				if var_79_11 then
					var_79_11:EnableDynamicBone(false)
				end
			end

			local var_79_12 = 0.001

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_12 then
				local var_79_13 = (arg_76_1.time_ - var_79_10) / var_79_12
				local var_79_14 = Vector3.New(0, 100, 0)

				var_79_9.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10141ui_story, var_79_14, var_79_13)

				local var_79_15 = manager.ui.mainCamera.transform.position - var_79_9.position

				var_79_9.forward = Vector3.New(var_79_15.x, var_79_15.y, var_79_15.z)

				local var_79_16 = var_79_9.localEulerAngles

				var_79_16.z = 0
				var_79_16.x = 0
				var_79_9.localEulerAngles = var_79_16
			end

			if arg_76_1.time_ >= var_79_10 + var_79_12 and arg_76_1.time_ < var_79_10 + var_79_12 + arg_79_0 then
				var_79_9.localPosition = Vector3.New(0, 100, 0)

				local var_79_17 = manager.ui.mainCamera.transform.position - var_79_9.position

				var_79_9.forward = Vector3.New(var_79_17.x, var_79_17.y, var_79_17.z)

				local var_79_18 = var_79_9.localEulerAngles

				var_79_18.z = 0
				var_79_18.x = 0
				var_79_9.localEulerAngles = var_79_18

				local var_79_19 = GameObjectTools.GetOrAddComponent(var_79_9.gameObject, typeof(DynamicBoneHelper))

				if var_79_19 then
					var_79_19:EnableDynamicBone(true)
				end
			end

			local var_79_20 = arg_76_1.actors_["10141ui_story"]
			local var_79_21 = 0

			if var_79_21 < arg_76_1.time_ and arg_76_1.time_ <= var_79_21 + arg_79_0 and not isNil(var_79_20) and arg_76_1.var_.characterEffect10141ui_story == nil then
				arg_76_1.var_.characterEffect10141ui_story = var_79_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_22 = 0.200000002980232

			if var_79_21 <= arg_76_1.time_ and arg_76_1.time_ < var_79_21 + var_79_22 and not isNil(var_79_20) then
				local var_79_23 = (arg_76_1.time_ - var_79_21) / var_79_22

				if arg_76_1.var_.characterEffect10141ui_story and not isNil(var_79_20) then
					local var_79_24 = Mathf.Lerp(0, 0.5, var_79_23)

					arg_76_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_76_1.var_.characterEffect10141ui_story.fillRatio = var_79_24
				end
			end

			if arg_76_1.time_ >= var_79_21 + var_79_22 and arg_76_1.time_ < var_79_21 + var_79_22 + arg_79_0 and not isNil(var_79_20) and arg_76_1.var_.characterEffect10141ui_story then
				local var_79_25 = 0.5

				arg_76_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_76_1.var_.characterEffect10141ui_story.fillRatio = var_79_25
			end

			local var_79_26 = 0
			local var_79_27 = 1.675

			if var_79_26 < arg_76_1.time_ and arg_76_1.time_ <= var_79_26 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_28 = arg_76_1:GetWordFromCfg(302051019)
				local var_79_29 = arg_76_1:FormatText(var_79_28.content)

				arg_76_1.text_.text = var_79_29

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_30 = 67
				local var_79_31 = utf8.len(var_79_29)
				local var_79_32 = var_79_30 <= 0 and var_79_27 or var_79_27 * (var_79_31 / var_79_30)

				if var_79_32 > 0 and var_79_27 < var_79_32 then
					arg_76_1.talkMaxDuration = var_79_32

					if var_79_32 + var_79_26 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_32 + var_79_26
					end
				end

				arg_76_1.text_.text = var_79_29
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_33 = math.max(var_79_27, arg_76_1.talkMaxDuration)

			if var_79_26 <= arg_76_1.time_ and arg_76_1.time_ < var_79_26 + var_79_33 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_26) / var_79_33

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_26 + var_79_33 and arg_76_1.time_ < var_79_26 + var_79_33 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play302051020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 302051020
		arg_80_1.duration_ = 3.6

		local var_80_0 = {
			zh = 3.433,
			ja = 3.6
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play302051021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10141ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos10141ui_story = var_83_0.localPosition

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end
			end

			local var_83_3 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_3 then
				local var_83_4 = (arg_80_1.time_ - var_83_1) / var_83_3
				local var_83_5 = Vector3.New(-0.7, -1.16, -6.15)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10141ui_story, var_83_5, var_83_4)

				local var_83_6 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_6.x, var_83_6.y, var_83_6.z)

				local var_83_7 = var_83_0.localEulerAngles

				var_83_7.z = 0
				var_83_7.x = 0
				var_83_0.localEulerAngles = var_83_7
			end

			if arg_80_1.time_ >= var_83_1 + var_83_3 and arg_80_1.time_ < var_83_1 + var_83_3 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(-0.7, -1.16, -6.15)

				local var_83_8 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_8.x, var_83_8.y, var_83_8.z)

				local var_83_9 = var_83_0.localEulerAngles

				var_83_9.z = 0
				var_83_9.x = 0
				var_83_0.localEulerAngles = var_83_9

				local var_83_10 = GameObjectTools.GetOrAddComponent(var_83_0.gameObject, typeof(DynamicBoneHelper))

				if var_83_10 then
					var_83_10:EnableDynamicBone(true)
				end
			end

			local var_83_11 = arg_80_1.actors_["10141ui_story"]
			local var_83_12 = 0

			if var_83_12 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 and not isNil(var_83_11) and arg_80_1.var_.characterEffect10141ui_story == nil then
				arg_80_1.var_.characterEffect10141ui_story = var_83_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_13 = 0.200000002980232

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_13 and not isNil(var_83_11) then
				local var_83_14 = (arg_80_1.time_ - var_83_12) / var_83_13

				if arg_80_1.var_.characterEffect10141ui_story and not isNil(var_83_11) then
					arg_80_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_12 + var_83_13 and arg_80_1.time_ < var_83_12 + var_83_13 + arg_83_0 and not isNil(var_83_11) and arg_80_1.var_.characterEffect10141ui_story then
				arg_80_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_83_15 = 0

			if var_83_15 < arg_80_1.time_ and arg_80_1.time_ <= var_83_15 + arg_83_0 then
				arg_80_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action7_1")
			end

			local var_83_16 = 0

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_83_17 = 0
			local var_83_18 = 0.3

			if var_83_17 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_19 = arg_80_1:FormatText(StoryNameCfg[1553].name)

				arg_80_1.leftNameTxt_.text = var_83_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_20 = arg_80_1:GetWordFromCfg(302051020)
				local var_83_21 = arg_80_1:FormatText(var_83_20.content)

				arg_80_1.text_.text = var_83_21

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_22 = 12
				local var_83_23 = utf8.len(var_83_21)
				local var_83_24 = var_83_22 <= 0 and var_83_18 or var_83_18 * (var_83_23 / var_83_22)

				if var_83_24 > 0 and var_83_18 < var_83_24 then
					arg_80_1.talkMaxDuration = var_83_24

					if var_83_24 + var_83_17 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_24 + var_83_17
					end
				end

				arg_80_1.text_.text = var_83_21
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051020", "story_v_out_302051.awb") ~= 0 then
					local var_83_25 = manager.audio:GetVoiceLength("story_v_out_302051", "302051020", "story_v_out_302051.awb") / 1000

					if var_83_25 + var_83_17 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_25 + var_83_17
					end

					if var_83_20.prefab_name ~= "" and arg_80_1.actors_[var_83_20.prefab_name] ~= nil then
						local var_83_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_20.prefab_name].transform, "story_v_out_302051", "302051020", "story_v_out_302051.awb")

						arg_80_1:RecordAudio("302051020", var_83_26)
						arg_80_1:RecordAudio("302051020", var_83_26)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_302051", "302051020", "story_v_out_302051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_302051", "302051020", "story_v_out_302051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_27 = math.max(var_83_18, arg_80_1.talkMaxDuration)

			if var_83_17 <= arg_80_1.time_ and arg_80_1.time_ < var_83_17 + var_83_27 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_17) / var_83_27

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_17 + var_83_27 and arg_80_1.time_ < var_83_17 + var_83_27 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play302051021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 302051021
		arg_84_1.duration_ = 7.37

		local var_84_0 = {
			zh = 6.9,
			ja = 7.366
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play302051022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = "10140ui_story"

			if arg_84_1.actors_[var_87_0] == nil then
				local var_87_1 = Asset.Load("Char/" .. "10140ui_story")

				if not isNil(var_87_1) then
					local var_87_2 = Object.Instantiate(Asset.Load("Char/" .. "10140ui_story"), arg_84_1.stage_.transform)

					var_87_2.name = var_87_0
					var_87_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_84_1.actors_[var_87_0] = var_87_2

					local var_87_3 = var_87_2:GetComponentInChildren(typeof(CharacterEffect))

					var_87_3.enabled = true

					local var_87_4 = GameObjectTools.GetOrAddComponent(var_87_2, typeof(DynamicBoneHelper))

					if var_87_4 then
						var_87_4:EnableDynamicBone(false)
					end

					arg_84_1:ShowWeapon(var_87_3.transform, false)

					arg_84_1.var_[var_87_0 .. "Animator"] = var_87_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_84_1.var_[var_87_0 .. "Animator"].applyRootMotion = true
					arg_84_1.var_[var_87_0 .. "LipSync"] = var_87_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_87_5 = arg_84_1.actors_["10140ui_story"].transform
			local var_87_6 = 0

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.var_.moveOldPos10140ui_story = var_87_5.localPosition

				local var_87_7 = GameObjectTools.GetOrAddComponent(var_87_5.gameObject, typeof(DynamicBoneHelper))

				if var_87_7 then
					var_87_7:EnableDynamicBone(false)
				end
			end

			local var_87_8 = 0.001

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_8 then
				local var_87_9 = (arg_84_1.time_ - var_87_6) / var_87_8
				local var_87_10 = Vector3.New(0.7, -0.96, -6.29)

				var_87_5.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10140ui_story, var_87_10, var_87_9)

				local var_87_11 = manager.ui.mainCamera.transform.position - var_87_5.position

				var_87_5.forward = Vector3.New(var_87_11.x, var_87_11.y, var_87_11.z)

				local var_87_12 = var_87_5.localEulerAngles

				var_87_12.z = 0
				var_87_12.x = 0
				var_87_5.localEulerAngles = var_87_12
			end

			if arg_84_1.time_ >= var_87_6 + var_87_8 and arg_84_1.time_ < var_87_6 + var_87_8 + arg_87_0 then
				var_87_5.localPosition = Vector3.New(0.7, -0.96, -6.29)

				local var_87_13 = manager.ui.mainCamera.transform.position - var_87_5.position

				var_87_5.forward = Vector3.New(var_87_13.x, var_87_13.y, var_87_13.z)

				local var_87_14 = var_87_5.localEulerAngles

				var_87_14.z = 0
				var_87_14.x = 0
				var_87_5.localEulerAngles = var_87_14

				local var_87_15 = GameObjectTools.GetOrAddComponent(var_87_5.gameObject, typeof(DynamicBoneHelper))

				if var_87_15 then
					var_87_15:EnableDynamicBone(true)
				end
			end

			local var_87_16 = arg_84_1.actors_["10140ui_story"]
			local var_87_17 = 0

			if var_87_17 < arg_84_1.time_ and arg_84_1.time_ <= var_87_17 + arg_87_0 and not isNil(var_87_16) and arg_84_1.var_.characterEffect10140ui_story == nil then
				arg_84_1.var_.characterEffect10140ui_story = var_87_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_18 = 0.200000002980232

			if var_87_17 <= arg_84_1.time_ and arg_84_1.time_ < var_87_17 + var_87_18 and not isNil(var_87_16) then
				local var_87_19 = (arg_84_1.time_ - var_87_17) / var_87_18

				if arg_84_1.var_.characterEffect10140ui_story and not isNil(var_87_16) then
					arg_84_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_17 + var_87_18 and arg_84_1.time_ < var_87_17 + var_87_18 + arg_87_0 and not isNil(var_87_16) and arg_84_1.var_.characterEffect10140ui_story then
				arg_84_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			local var_87_20 = arg_84_1.actors_["10141ui_story"]
			local var_87_21 = 0

			if var_87_21 < arg_84_1.time_ and arg_84_1.time_ <= var_87_21 + arg_87_0 and not isNil(var_87_20) and arg_84_1.var_.characterEffect10141ui_story == nil then
				arg_84_1.var_.characterEffect10141ui_story = var_87_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_22 = 0.200000002980232

			if var_87_21 <= arg_84_1.time_ and arg_84_1.time_ < var_87_21 + var_87_22 and not isNil(var_87_20) then
				local var_87_23 = (arg_84_1.time_ - var_87_21) / var_87_22

				if arg_84_1.var_.characterEffect10141ui_story and not isNil(var_87_20) then
					local var_87_24 = Mathf.Lerp(0, 0.5, var_87_23)

					arg_84_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10141ui_story.fillRatio = var_87_24
				end
			end

			if arg_84_1.time_ >= var_87_21 + var_87_22 and arg_84_1.time_ < var_87_21 + var_87_22 + arg_87_0 and not isNil(var_87_20) and arg_84_1.var_.characterEffect10141ui_story then
				local var_87_25 = 0.5

				arg_84_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10141ui_story.fillRatio = var_87_25
			end

			local var_87_26 = 0

			if var_87_26 < arg_84_1.time_ and arg_84_1.time_ <= var_87_26 + arg_87_0 then
				arg_84_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action4_1")
			end

			local var_87_27 = 0

			if var_87_27 < arg_84_1.time_ and arg_84_1.time_ <= var_87_27 + arg_87_0 then
				arg_84_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_87_28 = 0
			local var_87_29 = 0.8

			if var_87_28 < arg_84_1.time_ and arg_84_1.time_ <= var_87_28 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_30 = arg_84_1:FormatText(StoryNameCfg[606].name)

				arg_84_1.leftNameTxt_.text = var_87_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_31 = arg_84_1:GetWordFromCfg(302051021)
				local var_87_32 = arg_84_1:FormatText(var_87_31.content)

				arg_84_1.text_.text = var_87_32

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_33 = 32
				local var_87_34 = utf8.len(var_87_32)
				local var_87_35 = var_87_33 <= 0 and var_87_29 or var_87_29 * (var_87_34 / var_87_33)

				if var_87_35 > 0 and var_87_29 < var_87_35 then
					arg_84_1.talkMaxDuration = var_87_35

					if var_87_35 + var_87_28 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_35 + var_87_28
					end
				end

				arg_84_1.text_.text = var_87_32
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051021", "story_v_out_302051.awb") ~= 0 then
					local var_87_36 = manager.audio:GetVoiceLength("story_v_out_302051", "302051021", "story_v_out_302051.awb") / 1000

					if var_87_36 + var_87_28 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_36 + var_87_28
					end

					if var_87_31.prefab_name ~= "" and arg_84_1.actors_[var_87_31.prefab_name] ~= nil then
						local var_87_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_31.prefab_name].transform, "story_v_out_302051", "302051021", "story_v_out_302051.awb")

						arg_84_1:RecordAudio("302051021", var_87_37)
						arg_84_1:RecordAudio("302051021", var_87_37)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_302051", "302051021", "story_v_out_302051.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_302051", "302051021", "story_v_out_302051.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_38 = math.max(var_87_29, arg_84_1.talkMaxDuration)

			if var_87_28 <= arg_84_1.time_ and arg_84_1.time_ < var_87_28 + var_87_38 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_28) / var_87_38

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_28 + var_87_38 and arg_84_1.time_ < var_87_28 + var_87_38 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10140ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play302051022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 302051022
		arg_88_1.duration_ = 11.17

		local var_88_0 = {
			zh = 5.133,
			ja = 11.166
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play302051023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140actionlink/10140action448")
			end

			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_91_2 = 0
			local var_91_3 = 0.725

			if var_91_2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_4 = arg_88_1:FormatText(StoryNameCfg[606].name)

				arg_88_1.leftNameTxt_.text = var_91_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_5 = arg_88_1:GetWordFromCfg(302051022)
				local var_91_6 = arg_88_1:FormatText(var_91_5.content)

				arg_88_1.text_.text = var_91_6

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 29
				local var_91_8 = utf8.len(var_91_6)
				local var_91_9 = var_91_7 <= 0 and var_91_3 or var_91_3 * (var_91_8 / var_91_7)

				if var_91_9 > 0 and var_91_3 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_6
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051022", "story_v_out_302051.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_302051", "302051022", "story_v_out_302051.awb") / 1000

					if var_91_10 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_2
					end

					if var_91_5.prefab_name ~= "" and arg_88_1.actors_[var_91_5.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_5.prefab_name].transform, "story_v_out_302051", "302051022", "story_v_out_302051.awb")

						arg_88_1:RecordAudio("302051022", var_91_11)
						arg_88_1:RecordAudio("302051022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_302051", "302051022", "story_v_out_302051.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_302051", "302051022", "story_v_out_302051.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_12 and arg_88_1.time_ < var_91_2 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play302051023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 302051023
		arg_92_1.duration_ = 6.33

		local var_92_0 = {
			zh = 6.333,
			ja = 6.2
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play302051024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10141ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10141ui_story == nil then
				arg_92_1.var_.characterEffect10141ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect10141ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10141ui_story then
				arg_92_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["10140ui_story"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect10140ui_story == nil then
				arg_92_1.var_.characterEffect10140ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.200000002980232

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect10140ui_story and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10140ui_story.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect10140ui_story then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10140ui_story.fillRatio = var_95_9
			end

			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141actionlink/10141action4716")
			end

			local var_95_11 = 0

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_95_12 = 0
			local var_95_13 = 0.65

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_14 = arg_92_1:FormatText(StoryNameCfg[1553].name)

				arg_92_1.leftNameTxt_.text = var_95_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_15 = arg_92_1:GetWordFromCfg(302051023)
				local var_95_16 = arg_92_1:FormatText(var_95_15.content)

				arg_92_1.text_.text = var_95_16

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_17 = 26
				local var_95_18 = utf8.len(var_95_16)
				local var_95_19 = var_95_17 <= 0 and var_95_13 or var_95_13 * (var_95_18 / var_95_17)

				if var_95_19 > 0 and var_95_13 < var_95_19 then
					arg_92_1.talkMaxDuration = var_95_19

					if var_95_19 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_19 + var_95_12
					end
				end

				arg_92_1.text_.text = var_95_16
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051023", "story_v_out_302051.awb") ~= 0 then
					local var_95_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051023", "story_v_out_302051.awb") / 1000

					if var_95_20 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_20 + var_95_12
					end

					if var_95_15.prefab_name ~= "" and arg_92_1.actors_[var_95_15.prefab_name] ~= nil then
						local var_95_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_15.prefab_name].transform, "story_v_out_302051", "302051023", "story_v_out_302051.awb")

						arg_92_1:RecordAudio("302051023", var_95_21)
						arg_92_1:RecordAudio("302051023", var_95_21)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_302051", "302051023", "story_v_out_302051.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_302051", "302051023", "story_v_out_302051.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_22 = math.max(var_95_13, arg_92_1.talkMaxDuration)

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_22 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_12) / var_95_22

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_12 + var_95_22 and arg_92_1.time_ < var_95_12 + var_95_22 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play302051024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 302051024
		arg_96_1.duration_ = 6.47

		local var_96_0 = {
			zh = 6.466,
			ja = 5.533
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play302051025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10140ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10140ui_story == nil then
				arg_96_1.var_.characterEffect10140ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect10140ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10140ui_story then
				arg_96_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["10141ui_story"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect10141ui_story == nil then
				arg_96_1.var_.characterEffect10141ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.200000002980232

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect10141ui_story and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10141ui_story.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect10141ui_story then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10141ui_story.fillRatio = var_99_9
			end

			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action8_2")
			end

			local var_99_11 = 0

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_99_12 = 0
			local var_99_13 = 0.85

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_14 = arg_96_1:FormatText(StoryNameCfg[606].name)

				arg_96_1.leftNameTxt_.text = var_99_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_15 = arg_96_1:GetWordFromCfg(302051024)
				local var_99_16 = arg_96_1:FormatText(var_99_15.content)

				arg_96_1.text_.text = var_99_16

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_17 = 34
				local var_99_18 = utf8.len(var_99_16)
				local var_99_19 = var_99_17 <= 0 and var_99_13 or var_99_13 * (var_99_18 / var_99_17)

				if var_99_19 > 0 and var_99_13 < var_99_19 then
					arg_96_1.talkMaxDuration = var_99_19

					if var_99_19 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_12
					end
				end

				arg_96_1.text_.text = var_99_16
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051024", "story_v_out_302051.awb") ~= 0 then
					local var_99_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051024", "story_v_out_302051.awb") / 1000

					if var_99_20 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_20 + var_99_12
					end

					if var_99_15.prefab_name ~= "" and arg_96_1.actors_[var_99_15.prefab_name] ~= nil then
						local var_99_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_15.prefab_name].transform, "story_v_out_302051", "302051024", "story_v_out_302051.awb")

						arg_96_1:RecordAudio("302051024", var_99_21)
						arg_96_1:RecordAudio("302051024", var_99_21)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_302051", "302051024", "story_v_out_302051.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_302051", "302051024", "story_v_out_302051.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_22 = math.max(var_99_13, arg_96_1.talkMaxDuration)

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_22 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_12) / var_99_22

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_12 + var_99_22 and arg_96_1.time_ < var_99_12 + var_99_22 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play302051025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 302051025
		arg_100_1.duration_ = 6.93

		local var_100_0 = {
			zh = 4.3,
			ja = 6.933
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play302051026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10141ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect10141ui_story == nil then
				arg_100_1.var_.characterEffect10141ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect10141ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect10141ui_story then
				arg_100_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["10140ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect10140ui_story == nil then
				arg_100_1.var_.characterEffect10140ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.200000002980232

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect10140ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10140ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect10140ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10140ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action16_2")
			end

			local var_103_11 = 0

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_103_12 = 0
			local var_103_13 = 0.35

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_14 = arg_100_1:FormatText(StoryNameCfg[1553].name)

				arg_100_1.leftNameTxt_.text = var_103_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_15 = arg_100_1:GetWordFromCfg(302051025)
				local var_103_16 = arg_100_1:FormatText(var_103_15.content)

				arg_100_1.text_.text = var_103_16

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_17 = 14
				local var_103_18 = utf8.len(var_103_16)
				local var_103_19 = var_103_17 <= 0 and var_103_13 or var_103_13 * (var_103_18 / var_103_17)

				if var_103_19 > 0 and var_103_13 < var_103_19 then
					arg_100_1.talkMaxDuration = var_103_19

					if var_103_19 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_19 + var_103_12
					end
				end

				arg_100_1.text_.text = var_103_16
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051025", "story_v_out_302051.awb") ~= 0 then
					local var_103_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051025", "story_v_out_302051.awb") / 1000

					if var_103_20 + var_103_12 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_20 + var_103_12
					end

					if var_103_15.prefab_name ~= "" and arg_100_1.actors_[var_103_15.prefab_name] ~= nil then
						local var_103_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_15.prefab_name].transform, "story_v_out_302051", "302051025", "story_v_out_302051.awb")

						arg_100_1:RecordAudio("302051025", var_103_21)
						arg_100_1:RecordAudio("302051025", var_103_21)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_302051", "302051025", "story_v_out_302051.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_302051", "302051025", "story_v_out_302051.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_22 = math.max(var_103_13, arg_100_1.talkMaxDuration)

			if var_103_12 <= arg_100_1.time_ and arg_100_1.time_ < var_103_12 + var_103_22 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_12) / var_103_22

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_12 + var_103_22 and arg_100_1.time_ < var_103_12 + var_103_22 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play302051026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 302051026
		arg_104_1.duration_ = 8.03

		local var_104_0 = {
			zh = 4.2,
			ja = 8.033
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play302051027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10140ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10140ui_story == nil then
				arg_104_1.var_.characterEffect10140ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect10140ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10140ui_story then
				arg_104_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			local var_107_4 = arg_104_1.actors_["10141ui_story"]
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect10141ui_story == nil then
				arg_104_1.var_.characterEffect10141ui_story = var_107_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_6 = 0.200000002980232

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 and not isNil(var_107_4) then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6

				if arg_104_1.var_.characterEffect10141ui_story and not isNil(var_107_4) then
					local var_107_8 = Mathf.Lerp(0, 0.5, var_107_7)

					arg_104_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_104_1.var_.characterEffect10141ui_story.fillRatio = var_107_8
				end
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect10141ui_story then
				local var_107_9 = 0.5

				arg_104_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_104_1.var_.characterEffect10141ui_story.fillRatio = var_107_9
			end

			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action8_1")
			end

			local var_107_11 = 0

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_107_12 = 0
			local var_107_13 = 0.5

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_14 = arg_104_1:FormatText(StoryNameCfg[606].name)

				arg_104_1.leftNameTxt_.text = var_107_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_15 = arg_104_1:GetWordFromCfg(302051026)
				local var_107_16 = arg_104_1:FormatText(var_107_15.content)

				arg_104_1.text_.text = var_107_16

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_17 = 20
				local var_107_18 = utf8.len(var_107_16)
				local var_107_19 = var_107_17 <= 0 and var_107_13 or var_107_13 * (var_107_18 / var_107_17)

				if var_107_19 > 0 and var_107_13 < var_107_19 then
					arg_104_1.talkMaxDuration = var_107_19

					if var_107_19 + var_107_12 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_12
					end
				end

				arg_104_1.text_.text = var_107_16
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051026", "story_v_out_302051.awb") ~= 0 then
					local var_107_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051026", "story_v_out_302051.awb") / 1000

					if var_107_20 + var_107_12 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_20 + var_107_12
					end

					if var_107_15.prefab_name ~= "" and arg_104_1.actors_[var_107_15.prefab_name] ~= nil then
						local var_107_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_15.prefab_name].transform, "story_v_out_302051", "302051026", "story_v_out_302051.awb")

						arg_104_1:RecordAudio("302051026", var_107_21)
						arg_104_1:RecordAudio("302051026", var_107_21)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_302051", "302051026", "story_v_out_302051.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_302051", "302051026", "story_v_out_302051.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_22 = math.max(var_107_13, arg_104_1.talkMaxDuration)

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_22 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_12) / var_107_22

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_12 + var_107_22 and arg_104_1.time_ < var_107_12 + var_107_22 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play302051027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 302051027
		arg_108_1.duration_ = 8

		local var_108_0 = {
			zh = 6.8,
			ja = 8
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play302051028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.875

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[606].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(302051027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 35
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051027", "story_v_out_302051.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_302051", "302051027", "story_v_out_302051.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_302051", "302051027", "story_v_out_302051.awb")

						arg_108_1:RecordAudio("302051027", var_111_9)
						arg_108_1:RecordAudio("302051027", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_302051", "302051027", "story_v_out_302051.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_302051", "302051027", "story_v_out_302051.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play302051028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 302051028
		arg_112_1.duration_ = 6.5

		local var_112_0 = {
			zh = 4.7,
			ja = 6.5
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play302051029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10141ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10141ui_story == nil then
				arg_112_1.var_.characterEffect10141ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect10141ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10141ui_story then
				arg_112_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_115_4 = arg_112_1.actors_["10140ui_story"]
			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect10140ui_story == nil then
				arg_112_1.var_.characterEffect10140ui_story = var_115_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_6 = 0.200000002980232

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_6 and not isNil(var_115_4) then
				local var_115_7 = (arg_112_1.time_ - var_115_5) / var_115_6

				if arg_112_1.var_.characterEffect10140ui_story and not isNil(var_115_4) then
					local var_115_8 = Mathf.Lerp(0, 0.5, var_115_7)

					arg_112_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10140ui_story.fillRatio = var_115_8
				end
			end

			if arg_112_1.time_ >= var_115_5 + var_115_6 and arg_112_1.time_ < var_115_5 + var_115_6 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect10140ui_story then
				local var_115_9 = 0.5

				arg_112_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10140ui_story.fillRatio = var_115_9
			end

			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action7_1")
			end

			local var_115_11 = 0

			if var_115_11 < arg_112_1.time_ and arg_112_1.time_ <= var_115_11 + arg_115_0 then
				arg_112_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_115_12 = 0
			local var_115_13 = 0.525

			if var_115_12 < arg_112_1.time_ and arg_112_1.time_ <= var_115_12 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_14 = arg_112_1:FormatText(StoryNameCfg[1553].name)

				arg_112_1.leftNameTxt_.text = var_115_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_15 = arg_112_1:GetWordFromCfg(302051028)
				local var_115_16 = arg_112_1:FormatText(var_115_15.content)

				arg_112_1.text_.text = var_115_16

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_17 = 21
				local var_115_18 = utf8.len(var_115_16)
				local var_115_19 = var_115_17 <= 0 and var_115_13 or var_115_13 * (var_115_18 / var_115_17)

				if var_115_19 > 0 and var_115_13 < var_115_19 then
					arg_112_1.talkMaxDuration = var_115_19

					if var_115_19 + var_115_12 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_19 + var_115_12
					end
				end

				arg_112_1.text_.text = var_115_16
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051028", "story_v_out_302051.awb") ~= 0 then
					local var_115_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051028", "story_v_out_302051.awb") / 1000

					if var_115_20 + var_115_12 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_20 + var_115_12
					end

					if var_115_15.prefab_name ~= "" and arg_112_1.actors_[var_115_15.prefab_name] ~= nil then
						local var_115_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_15.prefab_name].transform, "story_v_out_302051", "302051028", "story_v_out_302051.awb")

						arg_112_1:RecordAudio("302051028", var_115_21)
						arg_112_1:RecordAudio("302051028", var_115_21)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_302051", "302051028", "story_v_out_302051.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_302051", "302051028", "story_v_out_302051.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_22 = math.max(var_115_13, arg_112_1.talkMaxDuration)

			if var_115_12 <= arg_112_1.time_ and arg_112_1.time_ < var_115_12 + var_115_22 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_12) / var_115_22

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_12 + var_115_22 and arg_112_1.time_ < var_115_12 + var_115_22 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play302051029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 302051029
		arg_116_1.duration_ = 8.97

		local var_116_0 = {
			zh = 6.033,
			ja = 8.966
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play302051030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10140ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10140ui_story == nil then
				arg_116_1.var_.characterEffect10140ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect10140ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10140ui_story then
				arg_116_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["10141ui_story"]
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect10141ui_story == nil then
				arg_116_1.var_.characterEffect10141ui_story = var_119_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.200000002980232

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 and not isNil(var_119_4) then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6

				if arg_116_1.var_.characterEffect10141ui_story and not isNil(var_119_4) then
					local var_119_8 = Mathf.Lerp(0, 0.5, var_119_7)

					arg_116_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_116_1.var_.characterEffect10141ui_story.fillRatio = var_119_8
				end
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect10141ui_story then
				local var_119_9 = 0.5

				arg_116_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_116_1.var_.characterEffect10141ui_story.fillRatio = var_119_9
			end

			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140actionlink/10140action482")
			end

			local var_119_11 = 0

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_119_12 = 0
			local var_119_13 = 0.85

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_14 = arg_116_1:FormatText(StoryNameCfg[606].name)

				arg_116_1.leftNameTxt_.text = var_119_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_15 = arg_116_1:GetWordFromCfg(302051029)
				local var_119_16 = arg_116_1:FormatText(var_119_15.content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_17 = 34
				local var_119_18 = utf8.len(var_119_16)
				local var_119_19 = var_119_17 <= 0 and var_119_13 or var_119_13 * (var_119_18 / var_119_17)

				if var_119_19 > 0 and var_119_13 < var_119_19 then
					arg_116_1.talkMaxDuration = var_119_19

					if var_119_19 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_19 + var_119_12
					end
				end

				arg_116_1.text_.text = var_119_16
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051029", "story_v_out_302051.awb") ~= 0 then
					local var_119_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051029", "story_v_out_302051.awb") / 1000

					if var_119_20 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_20 + var_119_12
					end

					if var_119_15.prefab_name ~= "" and arg_116_1.actors_[var_119_15.prefab_name] ~= nil then
						local var_119_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_15.prefab_name].transform, "story_v_out_302051", "302051029", "story_v_out_302051.awb")

						arg_116_1:RecordAudio("302051029", var_119_21)
						arg_116_1:RecordAudio("302051029", var_119_21)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_302051", "302051029", "story_v_out_302051.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_302051", "302051029", "story_v_out_302051.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_22 = math.max(var_119_13, arg_116_1.talkMaxDuration)

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_12) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_12 + var_119_22 and arg_116_1.time_ < var_119_12 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play302051030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 302051030
		arg_120_1.duration_ = 6.77

		local var_120_0 = {
			zh = 6.766,
			ja = 6.7
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play302051031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["10141ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect10141ui_story == nil then
				arg_120_1.var_.characterEffect10141ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect10141ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect10141ui_story then
				arg_120_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_123_4 = arg_120_1.actors_["10140ui_story"]
			local var_123_5 = 0

			if var_123_5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect10140ui_story == nil then
				arg_120_1.var_.characterEffect10140ui_story = var_123_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_6 = 0.200000002980232

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 and not isNil(var_123_4) then
				local var_123_7 = (arg_120_1.time_ - var_123_5) / var_123_6

				if arg_120_1.var_.characterEffect10140ui_story and not isNil(var_123_4) then
					local var_123_8 = Mathf.Lerp(0, 0.5, var_123_7)

					arg_120_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_120_1.var_.characterEffect10140ui_story.fillRatio = var_123_8
				end
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect10140ui_story then
				local var_123_9 = 0.5

				arg_120_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_120_1.var_.characterEffect10140ui_story.fillRatio = var_123_9
			end

			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141actionlink/10141action4716")
			end

			local var_123_11 = 0

			if var_123_11 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_123_12 = 0
			local var_123_13 = 0.6

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_14 = arg_120_1:FormatText(StoryNameCfg[1553].name)

				arg_120_1.leftNameTxt_.text = var_123_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_15 = arg_120_1:GetWordFromCfg(302051030)
				local var_123_16 = arg_120_1:FormatText(var_123_15.content)

				arg_120_1.text_.text = var_123_16

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_17 = 24
				local var_123_18 = utf8.len(var_123_16)
				local var_123_19 = var_123_17 <= 0 and var_123_13 or var_123_13 * (var_123_18 / var_123_17)

				if var_123_19 > 0 and var_123_13 < var_123_19 then
					arg_120_1.talkMaxDuration = var_123_19

					if var_123_19 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_12
					end
				end

				arg_120_1.text_.text = var_123_16
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051030", "story_v_out_302051.awb") ~= 0 then
					local var_123_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051030", "story_v_out_302051.awb") / 1000

					if var_123_20 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_20 + var_123_12
					end

					if var_123_15.prefab_name ~= "" and arg_120_1.actors_[var_123_15.prefab_name] ~= nil then
						local var_123_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_15.prefab_name].transform, "story_v_out_302051", "302051030", "story_v_out_302051.awb")

						arg_120_1:RecordAudio("302051030", var_123_21)
						arg_120_1:RecordAudio("302051030", var_123_21)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_302051", "302051030", "story_v_out_302051.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_302051", "302051030", "story_v_out_302051.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_22 = math.max(var_123_13, arg_120_1.talkMaxDuration)

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_22 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_12) / var_123_22

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_12 + var_123_22 and arg_120_1.time_ < var_123_12 + var_123_22 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play302051031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 302051031
		arg_124_1.duration_ = 6.27

		local var_124_0 = {
			zh = 6.266,
			ja = 5.366
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play302051032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.625

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[1553].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(302051031)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 25
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051031", "story_v_out_302051.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_302051", "302051031", "story_v_out_302051.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_302051", "302051031", "story_v_out_302051.awb")

						arg_124_1:RecordAudio("302051031", var_127_9)
						arg_124_1:RecordAudio("302051031", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_302051", "302051031", "story_v_out_302051.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_302051", "302051031", "story_v_out_302051.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_10 and arg_124_1.time_ < var_127_0 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play302051032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 302051032
		arg_128_1.duration_ = 9

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play302051033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = "I05d"

			if arg_128_1.bgs_[var_131_0] == nil then
				local var_131_1 = Object.Instantiate(arg_128_1.paintGo_)

				var_131_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_131_0)
				var_131_1.name = var_131_0
				var_131_1.transform.parent = arg_128_1.stage_.transform
				var_131_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.bgs_[var_131_0] = var_131_1
			end

			local var_131_2 = 2

			if var_131_2 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				local var_131_3 = manager.ui.mainCamera.transform.localPosition
				local var_131_4 = Vector3.New(0, 0, 10) + Vector3.New(var_131_3.x, var_131_3.y, 0)
				local var_131_5 = arg_128_1.bgs_.I05d

				var_131_5.transform.localPosition = var_131_4
				var_131_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_6 = var_131_5:GetComponent("SpriteRenderer")

				if var_131_6 and var_131_6.sprite then
					local var_131_7 = (var_131_5.transform.localPosition - var_131_3).z
					local var_131_8 = manager.ui.mainCameraCom_
					local var_131_9 = 2 * var_131_7 * Mathf.Tan(var_131_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_131_10 = var_131_9 * var_131_8.aspect
					local var_131_11 = var_131_6.sprite.bounds.size.x
					local var_131_12 = var_131_6.sprite.bounds.size.y
					local var_131_13 = var_131_10 / var_131_11
					local var_131_14 = var_131_9 / var_131_12
					local var_131_15 = var_131_14 < var_131_13 and var_131_13 or var_131_14

					var_131_5.transform.localScale = Vector3.New(var_131_15, var_131_15, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "I05d" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_131_16 = 3.999999999999

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1.allBtn_.enabled = false
			end

			local var_131_17 = 0.3

			if arg_128_1.time_ >= var_131_16 + var_131_17 and arg_128_1.time_ < var_131_16 + var_131_17 + arg_131_0 then
				arg_128_1.allBtn_.enabled = true
			end

			local var_131_18 = 0

			if var_131_18 < arg_128_1.time_ and arg_128_1.time_ <= var_131_18 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_19 = 2

			if var_131_18 <= arg_128_1.time_ and arg_128_1.time_ < var_131_18 + var_131_19 then
				local var_131_20 = (arg_128_1.time_ - var_131_18) / var_131_19
				local var_131_21 = Color.New(0, 0, 0)

				var_131_21.a = Mathf.Lerp(0, 1, var_131_20)
				arg_128_1.mask_.color = var_131_21
			end

			if arg_128_1.time_ >= var_131_18 + var_131_19 and arg_128_1.time_ < var_131_18 + var_131_19 + arg_131_0 then
				local var_131_22 = Color.New(0, 0, 0)

				var_131_22.a = 1
				arg_128_1.mask_.color = var_131_22
			end

			local var_131_23 = 2

			if var_131_23 < arg_128_1.time_ and arg_128_1.time_ <= var_131_23 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_24 = 2

			if var_131_23 <= arg_128_1.time_ and arg_128_1.time_ < var_131_23 + var_131_24 then
				local var_131_25 = (arg_128_1.time_ - var_131_23) / var_131_24
				local var_131_26 = Color.New(0, 0, 0)

				var_131_26.a = Mathf.Lerp(1, 0, var_131_25)
				arg_128_1.mask_.color = var_131_26
			end

			if arg_128_1.time_ >= var_131_23 + var_131_24 and arg_128_1.time_ < var_131_23 + var_131_24 + arg_131_0 then
				local var_131_27 = Color.New(0, 0, 0)
				local var_131_28 = 0

				arg_128_1.mask_.enabled = false
				var_131_27.a = var_131_28
				arg_128_1.mask_.color = var_131_27
			end

			local var_131_29 = arg_128_1.actors_["10141ui_story"].transform
			local var_131_30 = 1.96599999815226

			if var_131_30 < arg_128_1.time_ and arg_128_1.time_ <= var_131_30 + arg_131_0 then
				arg_128_1.var_.moveOldPos10141ui_story = var_131_29.localPosition

				local var_131_31 = GameObjectTools.GetOrAddComponent(var_131_29.gameObject, typeof(DynamicBoneHelper))

				if var_131_31 then
					var_131_31:EnableDynamicBone(false)
				end
			end

			local var_131_32 = 0.001

			if var_131_30 <= arg_128_1.time_ and arg_128_1.time_ < var_131_30 + var_131_32 then
				local var_131_33 = (arg_128_1.time_ - var_131_30) / var_131_32
				local var_131_34 = Vector3.New(0, 100, 0)

				var_131_29.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10141ui_story, var_131_34, var_131_33)

				local var_131_35 = manager.ui.mainCamera.transform.position - var_131_29.position

				var_131_29.forward = Vector3.New(var_131_35.x, var_131_35.y, var_131_35.z)

				local var_131_36 = var_131_29.localEulerAngles

				var_131_36.z = 0
				var_131_36.x = 0
				var_131_29.localEulerAngles = var_131_36
			end

			if arg_128_1.time_ >= var_131_30 + var_131_32 and arg_128_1.time_ < var_131_30 + var_131_32 + arg_131_0 then
				var_131_29.localPosition = Vector3.New(0, 100, 0)

				local var_131_37 = manager.ui.mainCamera.transform.position - var_131_29.position

				var_131_29.forward = Vector3.New(var_131_37.x, var_131_37.y, var_131_37.z)

				local var_131_38 = var_131_29.localEulerAngles

				var_131_38.z = 0
				var_131_38.x = 0
				var_131_29.localEulerAngles = var_131_38

				local var_131_39 = GameObjectTools.GetOrAddComponent(var_131_29.gameObject, typeof(DynamicBoneHelper))

				if var_131_39 then
					var_131_39:EnableDynamicBone(true)
				end
			end

			local var_131_40 = arg_128_1.actors_["10140ui_story"].transform
			local var_131_41 = 1.96599999815226

			if var_131_41 < arg_128_1.time_ and arg_128_1.time_ <= var_131_41 + arg_131_0 then
				arg_128_1.var_.moveOldPos10140ui_story = var_131_40.localPosition

				local var_131_42 = GameObjectTools.GetOrAddComponent(var_131_40.gameObject, typeof(DynamicBoneHelper))

				if var_131_42 then
					var_131_42:EnableDynamicBone(false)
				end
			end

			local var_131_43 = 0.001

			if var_131_41 <= arg_128_1.time_ and arg_128_1.time_ < var_131_41 + var_131_43 then
				local var_131_44 = (arg_128_1.time_ - var_131_41) / var_131_43
				local var_131_45 = Vector3.New(0, 100, 0)

				var_131_40.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10140ui_story, var_131_45, var_131_44)

				local var_131_46 = manager.ui.mainCamera.transform.position - var_131_40.position

				var_131_40.forward = Vector3.New(var_131_46.x, var_131_46.y, var_131_46.z)

				local var_131_47 = var_131_40.localEulerAngles

				var_131_47.z = 0
				var_131_47.x = 0
				var_131_40.localEulerAngles = var_131_47
			end

			if arg_128_1.time_ >= var_131_41 + var_131_43 and arg_128_1.time_ < var_131_41 + var_131_43 + arg_131_0 then
				var_131_40.localPosition = Vector3.New(0, 100, 0)

				local var_131_48 = manager.ui.mainCamera.transform.position - var_131_40.position

				var_131_40.forward = Vector3.New(var_131_48.x, var_131_48.y, var_131_48.z)

				local var_131_49 = var_131_40.localEulerAngles

				var_131_49.z = 0
				var_131_49.x = 0
				var_131_40.localEulerAngles = var_131_49

				local var_131_50 = GameObjectTools.GetOrAddComponent(var_131_40.gameObject, typeof(DynamicBoneHelper))

				if var_131_50 then
					var_131_50:EnableDynamicBone(true)
				end
			end

			local var_131_51 = arg_128_1.actors_["10141ui_story"]
			local var_131_52 = 1.96599999815226

			if var_131_52 < arg_128_1.time_ and arg_128_1.time_ <= var_131_52 + arg_131_0 and not isNil(var_131_51) and arg_128_1.var_.characterEffect10141ui_story == nil then
				arg_128_1.var_.characterEffect10141ui_story = var_131_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_53 = 0.034000001847744

			if var_131_52 <= arg_128_1.time_ and arg_128_1.time_ < var_131_52 + var_131_53 and not isNil(var_131_51) then
				local var_131_54 = (arg_128_1.time_ - var_131_52) / var_131_53

				if arg_128_1.var_.characterEffect10141ui_story and not isNil(var_131_51) then
					local var_131_55 = Mathf.Lerp(0, 0.5, var_131_54)

					arg_128_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10141ui_story.fillRatio = var_131_55
				end
			end

			if arg_128_1.time_ >= var_131_52 + var_131_53 and arg_128_1.time_ < var_131_52 + var_131_53 + arg_131_0 and not isNil(var_131_51) and arg_128_1.var_.characterEffect10141ui_story then
				local var_131_56 = 0.5

				arg_128_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10141ui_story.fillRatio = var_131_56
			end

			local var_131_57 = 0
			local var_131_58 = 1.26666666666667

			if var_131_57 < arg_128_1.time_ and arg_128_1.time_ <= var_131_57 + arg_131_0 then
				local var_131_59 = "play"
				local var_131_60 = "music"

				arg_128_1:AudioAction(var_131_59, var_131_60, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_131_61 = ""
				local var_131_62 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_131_62 ~= "" then
					if arg_128_1.bgmTxt_.text ~= var_131_62 and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = var_131_62

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = var_131_62
						arg_128_1.bgmTxt2_.text = var_131_62
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_131_63 = 0
			local var_131_64 = 1.26666666666667

			if var_131_63 < arg_128_1.time_ and arg_128_1.time_ <= var_131_63 + arg_131_0 then
				local var_131_65 = "play"
				local var_131_66 = "effect"

				arg_128_1:AudioAction(var_131_65, var_131_66, "se_story_16", "se_story_16_street_loop", "")
			end

			local var_131_67 = 0
			local var_131_68 = 1.26666666666667

			if var_131_67 < arg_128_1.time_ and arg_128_1.time_ <= var_131_67 + arg_131_0 then
				local var_131_69 = "play"
				local var_131_70 = "effect"

				arg_128_1:AudioAction(var_131_69, var_131_70, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_128_1.frameCnt_ <= 1 then
				arg_128_1.dialog_:SetActive(false)
			end

			local var_131_71 = 4
			local var_131_72 = 0.95

			if var_131_71 < arg_128_1.time_ and arg_128_1.time_ <= var_131_71 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				arg_128_1.dialog_:SetActive(true)

				arg_128_1.dialogCg_.alpha = 0

				local var_131_73 = LeanTween.value(arg_128_1.dialog_, 0, 1, 0.3)

				var_131_73:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_128_1.dialogCg_.alpha = arg_133_0
				end))
				var_131_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_128_1.dialog_)
					var_131_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_128_1.duration_ = arg_128_1.duration_ + 0.3

				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_74 = arg_128_1:GetWordFromCfg(302051032)
				local var_131_75 = arg_128_1:FormatText(var_131_74.content)

				arg_128_1.text_.text = var_131_75

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_76 = 38
				local var_131_77 = utf8.len(var_131_75)
				local var_131_78 = var_131_76 <= 0 and var_131_72 or var_131_72 * (var_131_77 / var_131_76)

				if var_131_78 > 0 and var_131_72 < var_131_78 then
					arg_128_1.talkMaxDuration = var_131_78
					var_131_71 = var_131_71 + 0.3

					if var_131_78 + var_131_71 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_78 + var_131_71
					end
				end

				arg_128_1.text_.text = var_131_75
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_79 = var_131_71 + 0.3
			local var_131_80 = math.max(var_131_72, arg_128_1.talkMaxDuration)

			if var_131_79 <= arg_128_1.time_ and arg_128_1.time_ < var_131_79 + var_131_80 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_79) / var_131_80

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_79 + var_131_80 and arg_128_1.time_ < var_131_79 + var_131_80 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10140ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play302051033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 302051033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play302051034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.475

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(302051033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 19
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play302051034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 302051034
		arg_139_1.duration_ = 7.67

		local var_139_0 = {
			zh = 7.666,
			ja = 4.6
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
				arg_139_0:Play302051035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10141ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10141ui_story = var_142_0.localPosition

				local var_142_2 = GameObjectTools.GetOrAddComponent(var_142_0.gameObject, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(false)
				end
			end

			local var_142_3 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_3 then
				local var_142_4 = (arg_139_1.time_ - var_142_1) / var_142_3
				local var_142_5 = Vector3.New(0, -1.16, -6.15)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10141ui_story, var_142_5, var_142_4)

				local var_142_6 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_6.x, var_142_6.y, var_142_6.z)

				local var_142_7 = var_142_0.localEulerAngles

				var_142_7.z = 0
				var_142_7.x = 0
				var_142_0.localEulerAngles = var_142_7
			end

			if arg_139_1.time_ >= var_142_1 + var_142_3 and arg_139_1.time_ < var_142_1 + var_142_3 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -1.16, -6.15)

				local var_142_8 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_8.x, var_142_8.y, var_142_8.z)

				local var_142_9 = var_142_0.localEulerAngles

				var_142_9.z = 0
				var_142_9.x = 0
				var_142_0.localEulerAngles = var_142_9

				local var_142_10 = GameObjectTools.GetOrAddComponent(var_142_0.gameObject, typeof(DynamicBoneHelper))

				if var_142_10 then
					var_142_10:EnableDynamicBone(true)
				end
			end

			local var_142_11 = arg_139_1.actors_["10141ui_story"]
			local var_142_12 = 0

			if var_142_12 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 and not isNil(var_142_11) and arg_139_1.var_.characterEffect10141ui_story == nil then
				arg_139_1.var_.characterEffect10141ui_story = var_142_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_13 = 0.200000002980232

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_13 and not isNil(var_142_11) then
				local var_142_14 = (arg_139_1.time_ - var_142_12) / var_142_13

				if arg_139_1.var_.characterEffect10141ui_story and not isNil(var_142_11) then
					arg_139_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_12 + var_142_13 and arg_139_1.time_ < var_142_12 + var_142_13 + arg_142_0 and not isNil(var_142_11) and arg_139_1.var_.characterEffect10141ui_story then
				arg_139_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_142_15 = 0

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action1_1")
			end

			local var_142_16 = 0

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_142_17 = 0
			local var_142_18 = 0.7

			if var_142_17 < arg_139_1.time_ and arg_139_1.time_ <= var_142_17 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_19 = arg_139_1:FormatText(StoryNameCfg[1553].name)

				arg_139_1.leftNameTxt_.text = var_142_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_20 = arg_139_1:GetWordFromCfg(302051034)
				local var_142_21 = arg_139_1:FormatText(var_142_20.content)

				arg_139_1.text_.text = var_142_21

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_22 = 28
				local var_142_23 = utf8.len(var_142_21)
				local var_142_24 = var_142_22 <= 0 and var_142_18 or var_142_18 * (var_142_23 / var_142_22)

				if var_142_24 > 0 and var_142_18 < var_142_24 then
					arg_139_1.talkMaxDuration = var_142_24

					if var_142_24 + var_142_17 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_24 + var_142_17
					end
				end

				arg_139_1.text_.text = var_142_21
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051034", "story_v_out_302051.awb") ~= 0 then
					local var_142_25 = manager.audio:GetVoiceLength("story_v_out_302051", "302051034", "story_v_out_302051.awb") / 1000

					if var_142_25 + var_142_17 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_25 + var_142_17
					end

					if var_142_20.prefab_name ~= "" and arg_139_1.actors_[var_142_20.prefab_name] ~= nil then
						local var_142_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_20.prefab_name].transform, "story_v_out_302051", "302051034", "story_v_out_302051.awb")

						arg_139_1:RecordAudio("302051034", var_142_26)
						arg_139_1:RecordAudio("302051034", var_142_26)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_302051", "302051034", "story_v_out_302051.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_302051", "302051034", "story_v_out_302051.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_27 = math.max(var_142_18, arg_139_1.talkMaxDuration)

			if var_142_17 <= arg_139_1.time_ and arg_139_1.time_ < var_142_17 + var_142_27 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_17) / var_142_27

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_17 + var_142_27 and arg_139_1.time_ < var_142_17 + var_142_27 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play302051035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 302051035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play302051036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10141ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10141ui_story == nil then
				arg_143_1.var_.characterEffect10141ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect10141ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10141ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect10141ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10141ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 0.525

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_9 = arg_143_1:GetWordFromCfg(302051035)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 21
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
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play302051036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 302051036
		arg_147_1.duration_ = 2.97

		local var_147_0 = {
			zh = 2.966,
			ja = 2.7
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
				arg_147_0:Play302051037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10141ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10141ui_story == nil then
				arg_147_1.var_.characterEffect10141ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10141ui_story and not isNil(var_150_0) then
					arg_147_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10141ui_story then
				arg_147_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_150_4 = 0

			if var_150_4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action16_1")
			end

			local var_150_5 = 0
			local var_150_6 = 0.25

			if var_150_5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_7 = arg_147_1:FormatText(StoryNameCfg[1553].name)

				arg_147_1.leftNameTxt_.text = var_150_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(302051036)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 10
				local var_150_11 = utf8.len(var_150_9)
				local var_150_12 = var_150_10 <= 0 and var_150_6 or var_150_6 * (var_150_11 / var_150_10)

				if var_150_12 > 0 and var_150_6 < var_150_12 then
					arg_147_1.talkMaxDuration = var_150_12

					if var_150_12 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051036", "story_v_out_302051.awb") ~= 0 then
					local var_150_13 = manager.audio:GetVoiceLength("story_v_out_302051", "302051036", "story_v_out_302051.awb") / 1000

					if var_150_13 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_5
					end

					if var_150_8.prefab_name ~= "" and arg_147_1.actors_[var_150_8.prefab_name] ~= nil then
						local var_150_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_8.prefab_name].transform, "story_v_out_302051", "302051036", "story_v_out_302051.awb")

						arg_147_1:RecordAudio("302051036", var_150_14)
						arg_147_1:RecordAudio("302051036", var_150_14)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_302051", "302051036", "story_v_out_302051.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_302051", "302051036", "story_v_out_302051.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_15 = math.max(var_150_6, arg_147_1.talkMaxDuration)

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_15 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_5) / var_150_15

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_5 + var_150_15 and arg_147_1.time_ < var_150_5 + var_150_15 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play302051037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 302051037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play302051038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10141ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10141ui_story == nil then
				arg_151_1.var_.characterEffect10141ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10141ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10141ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect10141ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10141ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.775

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[7].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(302051037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 31
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
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play302051038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 302051038
		arg_155_1.duration_ = 4.43

		local var_155_0 = {
			zh = 4.433,
			ja = 4.133
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
				arg_155_0:Play302051039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10141ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10141ui_story == nil then
				arg_155_1.var_.characterEffect10141ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect10141ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10141ui_story then
				arg_155_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_158_4 = 0

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141actionlink/10141action41618")
			end

			local var_158_6 = 0
			local var_158_7 = 0.575

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[1553].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(302051038)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051038", "story_v_out_302051.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_302051", "302051038", "story_v_out_302051.awb") / 1000

					if var_158_14 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_6
					end

					if var_158_9.prefab_name ~= "" and arg_155_1.actors_[var_158_9.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_9.prefab_name].transform, "story_v_out_302051", "302051038", "story_v_out_302051.awb")

						arg_155_1:RecordAudio("302051038", var_158_15)
						arg_155_1:RecordAudio("302051038", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_302051", "302051038", "story_v_out_302051.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_302051", "302051038", "story_v_out_302051.awb")
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
	Play302051039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 302051039
		arg_159_1.duration_ = 13.2

		local var_159_0 = {
			zh = 7.166,
			ja = 13.2
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
				arg_159_0:Play302051040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141actionlink/10141action41825")
			end

			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_162_2 = 0
			local var_162_3 = 0.725

			if var_162_2 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_4 = arg_159_1:FormatText(StoryNameCfg[1553].name)

				arg_159_1.leftNameTxt_.text = var_162_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_5 = arg_159_1:GetWordFromCfg(302051039)
				local var_162_6 = arg_159_1:FormatText(var_162_5.content)

				arg_159_1.text_.text = var_162_6

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 29
				local var_162_8 = utf8.len(var_162_6)
				local var_162_9 = var_162_7 <= 0 and var_162_3 or var_162_3 * (var_162_8 / var_162_7)

				if var_162_9 > 0 and var_162_3 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_6
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051039", "story_v_out_302051.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_302051", "302051039", "story_v_out_302051.awb") / 1000

					if var_162_10 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_2
					end

					if var_162_5.prefab_name ~= "" and arg_159_1.actors_[var_162_5.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_5.prefab_name].transform, "story_v_out_302051", "302051039", "story_v_out_302051.awb")

						arg_159_1:RecordAudio("302051039", var_162_11)
						arg_159_1:RecordAudio("302051039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_302051", "302051039", "story_v_out_302051.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_302051", "302051039", "story_v_out_302051.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_12 and arg_159_1.time_ < var_162_2 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play302051040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 302051040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play302051041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10141ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10141ui_story = var_166_0.localPosition

				local var_166_2 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(false)
				end
			end

			local var_166_3 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_3 then
				local var_166_4 = (arg_163_1.time_ - var_166_1) / var_166_3
				local var_166_5 = Vector3.New(0, 100, 0)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10141ui_story, var_166_5, var_166_4)

				local var_166_6 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_6.x, var_166_6.y, var_166_6.z)

				local var_166_7 = var_166_0.localEulerAngles

				var_166_7.z = 0
				var_166_7.x = 0
				var_166_0.localEulerAngles = var_166_7
			end

			if arg_163_1.time_ >= var_166_1 + var_166_3 and arg_163_1.time_ < var_166_1 + var_166_3 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, 100, 0)

				local var_166_8 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_8.x, var_166_8.y, var_166_8.z)

				local var_166_9 = var_166_0.localEulerAngles

				var_166_9.z = 0
				var_166_9.x = 0
				var_166_0.localEulerAngles = var_166_9

				local var_166_10 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_10 then
					var_166_10:EnableDynamicBone(true)
				end
			end

			local var_166_11 = arg_163_1.actors_["10141ui_story"]
			local var_166_12 = 0

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect10141ui_story == nil then
				arg_163_1.var_.characterEffect10141ui_story = var_166_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_13 = 0.200000002980232

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_13 and not isNil(var_166_11) then
				local var_166_14 = (arg_163_1.time_ - var_166_12) / var_166_13

				if arg_163_1.var_.characterEffect10141ui_story and not isNil(var_166_11) then
					local var_166_15 = Mathf.Lerp(0, 0.5, var_166_14)

					arg_163_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_163_1.var_.characterEffect10141ui_story.fillRatio = var_166_15
				end
			end

			if arg_163_1.time_ >= var_166_12 + var_166_13 and arg_163_1.time_ < var_166_12 + var_166_13 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect10141ui_story then
				local var_166_16 = 0.5

				arg_163_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_163_1.var_.characterEffect10141ui_story.fillRatio = var_166_16
			end

			local var_166_17 = 0
			local var_166_18 = 0.6

			if var_166_17 < arg_163_1.time_ and arg_163_1.time_ <= var_166_17 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_19 = arg_163_1:GetWordFromCfg(302051040)
				local var_166_20 = arg_163_1:FormatText(var_166_19.content)

				arg_163_1.text_.text = var_166_20

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_21 = 24
				local var_166_22 = utf8.len(var_166_20)
				local var_166_23 = var_166_21 <= 0 and var_166_18 or var_166_18 * (var_166_22 / var_166_21)

				if var_166_23 > 0 and var_166_18 < var_166_23 then
					arg_163_1.talkMaxDuration = var_166_23

					if var_166_23 + var_166_17 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_17
					end
				end

				arg_163_1.text_.text = var_166_20
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_24 = math.max(var_166_18, arg_163_1.talkMaxDuration)

			if var_166_17 <= arg_163_1.time_ and arg_163_1.time_ < var_166_17 + var_166_24 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_17) / var_166_24

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_17 + var_166_24 and arg_163_1.time_ < var_166_17 + var_166_24 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play302051041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 302051041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play302051042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.9

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(302051041)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 36
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_8 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_8 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_8

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_8 and arg_167_1.time_ < var_170_0 + var_170_8 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play302051042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 302051042
		arg_171_1.duration_ = 3.97

		local var_171_0 = {
			zh = 2.766,
			ja = 3.966
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play302051043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10141ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10141ui_story = var_174_0.localPosition

				local var_174_2 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(false)
				end
			end

			local var_174_3 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_3 then
				local var_174_4 = (arg_171_1.time_ - var_174_1) / var_174_3
				local var_174_5 = Vector3.New(0, -1.16, -6.15)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10141ui_story, var_174_5, var_174_4)

				local var_174_6 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_6.x, var_174_6.y, var_174_6.z)

				local var_174_7 = var_174_0.localEulerAngles

				var_174_7.z = 0
				var_174_7.x = 0
				var_174_0.localEulerAngles = var_174_7
			end

			if arg_171_1.time_ >= var_174_1 + var_174_3 and arg_171_1.time_ < var_174_1 + var_174_3 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, -1.16, -6.15)

				local var_174_8 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_8.x, var_174_8.y, var_174_8.z)

				local var_174_9 = var_174_0.localEulerAngles

				var_174_9.z = 0
				var_174_9.x = 0
				var_174_0.localEulerAngles = var_174_9

				local var_174_10 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_10 then
					var_174_10:EnableDynamicBone(true)
				end
			end

			local var_174_11 = arg_171_1.actors_["10141ui_story"]
			local var_174_12 = 0

			if var_174_12 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 and not isNil(var_174_11) and arg_171_1.var_.characterEffect10141ui_story == nil then
				arg_171_1.var_.characterEffect10141ui_story = var_174_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_13 = 0.200000002980232

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_13 and not isNil(var_174_11) then
				local var_174_14 = (arg_171_1.time_ - var_174_12) / var_174_13

				if arg_171_1.var_.characterEffect10141ui_story and not isNil(var_174_11) then
					arg_171_1.var_.characterEffect10141ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_12 + var_174_13 and arg_171_1.time_ < var_174_12 + var_174_13 + arg_174_0 and not isNil(var_174_11) and arg_171_1.var_.characterEffect10141ui_story then
				arg_171_1.var_.characterEffect10141ui_story.fillFlat = false
			end

			local var_174_15 = 0

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_174_16 = 0

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1:PlayTimeline("10141ui_story", "StoryTimeline/CharAction/story10141/story10141action/10141action25_2")
			end

			local var_174_17 = 0
			local var_174_18 = 0.275

			if var_174_17 < arg_171_1.time_ and arg_171_1.time_ <= var_174_17 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_19 = arg_171_1:FormatText(StoryNameCfg[1553].name)

				arg_171_1.leftNameTxt_.text = var_174_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_20 = arg_171_1:GetWordFromCfg(302051042)
				local var_174_21 = arg_171_1:FormatText(var_174_20.content)

				arg_171_1.text_.text = var_174_21

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_22 = 11
				local var_174_23 = utf8.len(var_174_21)
				local var_174_24 = var_174_22 <= 0 and var_174_18 or var_174_18 * (var_174_23 / var_174_22)

				if var_174_24 > 0 and var_174_18 < var_174_24 then
					arg_171_1.talkMaxDuration = var_174_24

					if var_174_24 + var_174_17 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_24 + var_174_17
					end
				end

				arg_171_1.text_.text = var_174_21
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051042", "story_v_out_302051.awb") ~= 0 then
					local var_174_25 = manager.audio:GetVoiceLength("story_v_out_302051", "302051042", "story_v_out_302051.awb") / 1000

					if var_174_25 + var_174_17 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_25 + var_174_17
					end

					if var_174_20.prefab_name ~= "" and arg_171_1.actors_[var_174_20.prefab_name] ~= nil then
						local var_174_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_20.prefab_name].transform, "story_v_out_302051", "302051042", "story_v_out_302051.awb")

						arg_171_1:RecordAudio("302051042", var_174_26)
						arg_171_1:RecordAudio("302051042", var_174_26)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_302051", "302051042", "story_v_out_302051.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_302051", "302051042", "story_v_out_302051.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_27 = math.max(var_174_18, arg_171_1.talkMaxDuration)

			if var_174_17 <= arg_171_1.time_ and arg_171_1.time_ < var_174_17 + var_174_27 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_17) / var_174_27

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_17 + var_174_27 and arg_171_1.time_ < var_174_17 + var_174_27 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play302051043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 302051043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play302051044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10141ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos10141ui_story = var_178_0.localPosition

				local var_178_2 = GameObjectTools.GetOrAddComponent(var_178_0.gameObject, typeof(DynamicBoneHelper))

				if var_178_2 then
					var_178_2:EnableDynamicBone(false)
				end
			end

			local var_178_3 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_3 then
				local var_178_4 = (arg_175_1.time_ - var_178_1) / var_178_3
				local var_178_5 = Vector3.New(0, 100, 0)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10141ui_story, var_178_5, var_178_4)

				local var_178_6 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_6.x, var_178_6.y, var_178_6.z)

				local var_178_7 = var_178_0.localEulerAngles

				var_178_7.z = 0
				var_178_7.x = 0
				var_178_0.localEulerAngles = var_178_7
			end

			if arg_175_1.time_ >= var_178_1 + var_178_3 and arg_175_1.time_ < var_178_1 + var_178_3 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, 100, 0)

				local var_178_8 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_8.x, var_178_8.y, var_178_8.z)

				local var_178_9 = var_178_0.localEulerAngles

				var_178_9.z = 0
				var_178_9.x = 0
				var_178_0.localEulerAngles = var_178_9

				local var_178_10 = GameObjectTools.GetOrAddComponent(var_178_0.gameObject, typeof(DynamicBoneHelper))

				if var_178_10 then
					var_178_10:EnableDynamicBone(true)
				end
			end

			local var_178_11 = arg_175_1.actors_["10141ui_story"]
			local var_178_12 = 0

			if var_178_12 < arg_175_1.time_ and arg_175_1.time_ <= var_178_12 + arg_178_0 and not isNil(var_178_11) and arg_175_1.var_.characterEffect10141ui_story == nil then
				arg_175_1.var_.characterEffect10141ui_story = var_178_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_13 = 0.200000002980232

			if var_178_12 <= arg_175_1.time_ and arg_175_1.time_ < var_178_12 + var_178_13 and not isNil(var_178_11) then
				local var_178_14 = (arg_175_1.time_ - var_178_12) / var_178_13

				if arg_175_1.var_.characterEffect10141ui_story and not isNil(var_178_11) then
					local var_178_15 = Mathf.Lerp(0, 0.5, var_178_14)

					arg_175_1.var_.characterEffect10141ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10141ui_story.fillRatio = var_178_15
				end
			end

			if arg_175_1.time_ >= var_178_12 + var_178_13 and arg_175_1.time_ < var_178_12 + var_178_13 + arg_178_0 and not isNil(var_178_11) and arg_175_1.var_.characterEffect10141ui_story then
				local var_178_16 = 0.5

				arg_175_1.var_.characterEffect10141ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10141ui_story.fillRatio = var_178_16
			end

			local var_178_17 = 0
			local var_178_18 = 1.225

			if var_178_17 < arg_175_1.time_ and arg_175_1.time_ <= var_178_17 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_19 = arg_175_1:GetWordFromCfg(302051043)
				local var_178_20 = arg_175_1:FormatText(var_178_19.content)

				arg_175_1.text_.text = var_178_20

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_21 = 49
				local var_178_22 = utf8.len(var_178_20)
				local var_178_23 = var_178_21 <= 0 and var_178_18 or var_178_18 * (var_178_22 / var_178_21)

				if var_178_23 > 0 and var_178_18 < var_178_23 then
					arg_175_1.talkMaxDuration = var_178_23

					if var_178_23 + var_178_17 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_17
					end
				end

				arg_175_1.text_.text = var_178_20
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_24 = math.max(var_178_18, arg_175_1.talkMaxDuration)

			if var_178_17 <= arg_175_1.time_ and arg_175_1.time_ < var_178_17 + var_178_24 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_17) / var_178_24

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_17 + var_178_24 and arg_175_1.time_ < var_178_17 + var_178_24 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10141ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play302051044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 302051044
		arg_179_1.duration_ = 7.4

		local var_179_0 = {
			zh = 7.4,
			ja = 7.033
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play302051045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = "1084ui_story"

			if arg_179_1.actors_[var_182_0] == nil then
				local var_182_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_182_1) then
					local var_182_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_179_1.stage_.transform)

					var_182_2.name = var_182_0
					var_182_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_179_1.actors_[var_182_0] = var_182_2

					local var_182_3 = var_182_2:GetComponentInChildren(typeof(CharacterEffect))

					var_182_3.enabled = true

					local var_182_4 = GameObjectTools.GetOrAddComponent(var_182_2, typeof(DynamicBoneHelper))

					if var_182_4 then
						var_182_4:EnableDynamicBone(false)
					end

					arg_179_1:ShowWeapon(var_182_3.transform, false)

					arg_179_1.var_[var_182_0 .. "Animator"] = var_182_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_179_1.var_[var_182_0 .. "Animator"].applyRootMotion = true
					arg_179_1.var_[var_182_0 .. "LipSync"] = var_182_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_182_5 = arg_179_1.actors_["1084ui_story"].transform
			local var_182_6 = 0

			if var_182_6 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.var_.moveOldPos1084ui_story = var_182_5.localPosition
			end

			local var_182_7 = 0.001

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_7 then
				local var_182_8 = (arg_179_1.time_ - var_182_6) / var_182_7
				local var_182_9 = Vector3.New(0, -0.97, -6)

				var_182_5.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1084ui_story, var_182_9, var_182_8)

				local var_182_10 = manager.ui.mainCamera.transform.position - var_182_5.position

				var_182_5.forward = Vector3.New(var_182_10.x, var_182_10.y, var_182_10.z)

				local var_182_11 = var_182_5.localEulerAngles

				var_182_11.z = 0
				var_182_11.x = 0
				var_182_5.localEulerAngles = var_182_11
			end

			if arg_179_1.time_ >= var_182_6 + var_182_7 and arg_179_1.time_ < var_182_6 + var_182_7 + arg_182_0 then
				var_182_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_182_12 = manager.ui.mainCamera.transform.position - var_182_5.position

				var_182_5.forward = Vector3.New(var_182_12.x, var_182_12.y, var_182_12.z)

				local var_182_13 = var_182_5.localEulerAngles

				var_182_13.z = 0
				var_182_13.x = 0
				var_182_5.localEulerAngles = var_182_13
			end

			local var_182_14 = arg_179_1.actors_["1084ui_story"]
			local var_182_15 = 0

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 and not isNil(var_182_14) and arg_179_1.var_.characterEffect1084ui_story == nil then
				arg_179_1.var_.characterEffect1084ui_story = var_182_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_16 = 0.200000002980232

			if var_182_15 <= arg_179_1.time_ and arg_179_1.time_ < var_182_15 + var_182_16 and not isNil(var_182_14) then
				local var_182_17 = (arg_179_1.time_ - var_182_15) / var_182_16

				if arg_179_1.var_.characterEffect1084ui_story and not isNil(var_182_14) then
					arg_179_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_15 + var_182_16 and arg_179_1.time_ < var_182_15 + var_182_16 + arg_182_0 and not isNil(var_182_14) and arg_179_1.var_.characterEffect1084ui_story then
				arg_179_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_182_18 = 0

			if var_182_18 < arg_179_1.time_ and arg_179_1.time_ <= var_182_18 + arg_182_0 then
				arg_179_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_182_19 = 0

			if var_182_19 < arg_179_1.time_ and arg_179_1.time_ <= var_182_19 + arg_182_0 then
				arg_179_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_182_20 = 0
			local var_182_21 = 0.6

			if var_182_20 < arg_179_1.time_ and arg_179_1.time_ <= var_182_20 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_22 = arg_179_1:FormatText(StoryNameCfg[6].name)

				arg_179_1.leftNameTxt_.text = var_182_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_23 = arg_179_1:GetWordFromCfg(302051044)
				local var_182_24 = arg_179_1:FormatText(var_182_23.content)

				arg_179_1.text_.text = var_182_24

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_25 = 24
				local var_182_26 = utf8.len(var_182_24)
				local var_182_27 = var_182_25 <= 0 and var_182_21 or var_182_21 * (var_182_26 / var_182_25)

				if var_182_27 > 0 and var_182_21 < var_182_27 then
					arg_179_1.talkMaxDuration = var_182_27

					if var_182_27 + var_182_20 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_27 + var_182_20
					end
				end

				arg_179_1.text_.text = var_182_24
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051044", "story_v_out_302051.awb") ~= 0 then
					local var_182_28 = manager.audio:GetVoiceLength("story_v_out_302051", "302051044", "story_v_out_302051.awb") / 1000

					if var_182_28 + var_182_20 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_28 + var_182_20
					end

					if var_182_23.prefab_name ~= "" and arg_179_1.actors_[var_182_23.prefab_name] ~= nil then
						local var_182_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_23.prefab_name].transform, "story_v_out_302051", "302051044", "story_v_out_302051.awb")

						arg_179_1:RecordAudio("302051044", var_182_29)
						arg_179_1:RecordAudio("302051044", var_182_29)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_302051", "302051044", "story_v_out_302051.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_302051", "302051044", "story_v_out_302051.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_30 = math.max(var_182_21, arg_179_1.talkMaxDuration)

			if var_182_20 <= arg_179_1.time_ and arg_179_1.time_ < var_182_20 + var_182_30 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_20) / var_182_30

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_20 + var_182_30 and arg_179_1.time_ < var_182_20 + var_182_30 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play302051045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 302051045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play302051046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1084ui_story"]
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1084ui_story == nil then
				arg_183_1.var_.characterEffect1084ui_story = var_186_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 and not isNil(var_186_0) then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2

				if arg_183_1.var_.characterEffect1084ui_story and not isNil(var_186_0) then
					local var_186_4 = Mathf.Lerp(0, 0.5, var_186_3)

					arg_183_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1084ui_story.fillRatio = var_186_4
				end
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 and not isNil(var_186_0) and arg_183_1.var_.characterEffect1084ui_story then
				local var_186_5 = 0.5

				arg_183_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1084ui_story.fillRatio = var_186_5
			end

			local var_186_6 = 0
			local var_186_7 = 1.025

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_8 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_9 = arg_183_1:GetWordFromCfg(302051045)
				local var_186_10 = arg_183_1:FormatText(var_186_9.content)

				arg_183_1.text_.text = var_186_10

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 41
				local var_186_12 = utf8.len(var_186_10)
				local var_186_13 = var_186_11 <= 0 and var_186_7 or var_186_7 * (var_186_12 / var_186_11)

				if var_186_13 > 0 and var_186_7 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_10
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play302051046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 302051046
		arg_187_1.duration_ = 2.67

		local var_187_0 = {
			zh = 1.9,
			ja = 2.666
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play302051047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1084ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1084ui_story == nil then
				arg_187_1.var_.characterEffect1084ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1084ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1084ui_story then
				arg_187_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_190_4 = 0

			if var_190_4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_190_5 = 0

			if var_190_5 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				arg_187_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_190_6 = 0
			local var_190_7 = 0.2

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[6].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_9 = arg_187_1:GetWordFromCfg(302051046)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051046", "story_v_out_302051.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_302051", "302051046", "story_v_out_302051.awb") / 1000

					if var_190_14 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_6
					end

					if var_190_9.prefab_name ~= "" and arg_187_1.actors_[var_190_9.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_9.prefab_name].transform, "story_v_out_302051", "302051046", "story_v_out_302051.awb")

						arg_187_1:RecordAudio("302051046", var_190_15)
						arg_187_1:RecordAudio("302051046", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_302051", "302051046", "story_v_out_302051.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_302051", "302051046", "story_v_out_302051.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_16 and arg_187_1.time_ < var_190_6 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play302051047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 302051047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play302051048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1084ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1084ui_story == nil then
				arg_191_1.var_.characterEffect1084ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect1084ui_story and not isNil(var_194_0) then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1084ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect1084ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1084ui_story.fillRatio = var_194_5
			end

			local var_194_6 = 0
			local var_194_7 = 0.85

			if var_194_6 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_8 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_9 = arg_191_1:GetWordFromCfg(302051047)
				local var_194_10 = arg_191_1:FormatText(var_194_9.content)

				arg_191_1.text_.text = var_194_10

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 34
				local var_194_12 = utf8.len(var_194_10)
				local var_194_13 = var_194_11 <= 0 and var_194_7 or var_194_7 * (var_194_12 / var_194_11)

				if var_194_13 > 0 and var_194_7 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_10
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play302051048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 302051048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play302051049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.7

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[7].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(302051048)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 28
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_8 and arg_195_1.time_ < var_198_0 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play302051049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 302051049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play302051050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1084ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos1084ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, 100, 0)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1084ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, 100, 0)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = 0
			local var_202_10 = 0.65

			if var_202_9 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_11 = arg_199_1:GetWordFromCfg(302051049)
				local var_202_12 = arg_199_1:FormatText(var_202_11.content)

				arg_199_1.text_.text = var_202_12

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 26
				local var_202_14 = utf8.len(var_202_12)
				local var_202_15 = var_202_13 <= 0 and var_202_10 or var_202_10 * (var_202_14 / var_202_13)

				if var_202_15 > 0 and var_202_10 < var_202_15 then
					arg_199_1.talkMaxDuration = var_202_15

					if var_202_15 + var_202_9 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_15 + var_202_9
					end
				end

				arg_199_1.text_.text = var_202_12
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_10, arg_199_1.talkMaxDuration)

			if var_202_9 <= arg_199_1.time_ and arg_199_1.time_ < var_202_9 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_9) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_9 + var_202_16 and arg_199_1.time_ < var_202_9 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play302051050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 302051050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play302051051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.45

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:GetWordFromCfg(302051050)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 18
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_8 and arg_203_1.time_ < var_206_0 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play302051051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 302051051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play302051052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.825

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:GetWordFromCfg(302051051)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 33
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play302051052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 302051052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play302051053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.65

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[7].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:GetWordFromCfg(302051052)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 26
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_8 and arg_211_1.time_ < var_214_0 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play302051053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 302051053
		arg_215_1.duration_ = 5.33

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play302051054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = "I05"

			if arg_215_1.bgs_[var_218_0] == nil then
				local var_218_1 = Object.Instantiate(arg_215_1.paintGo_)

				var_218_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_218_0)
				var_218_1.name = var_218_0
				var_218_1.transform.parent = arg_215_1.stage_.transform
				var_218_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.bgs_[var_218_0] = var_218_1
			end

			local var_218_2 = 1.999999999999

			if var_218_2 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				local var_218_3 = manager.ui.mainCamera.transform.localPosition
				local var_218_4 = Vector3.New(0, 0, 10) + Vector3.New(var_218_3.x, var_218_3.y, 0)
				local var_218_5 = arg_215_1.bgs_.I05

				var_218_5.transform.localPosition = var_218_4
				var_218_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_6 = var_218_5:GetComponent("SpriteRenderer")

				if var_218_6 and var_218_6.sprite then
					local var_218_7 = (var_218_5.transform.localPosition - var_218_3).z
					local var_218_8 = manager.ui.mainCameraCom_
					local var_218_9 = 2 * var_218_7 * Mathf.Tan(var_218_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_218_10 = var_218_9 * var_218_8.aspect
					local var_218_11 = var_218_6.sprite.bounds.size.x
					local var_218_12 = var_218_6.sprite.bounds.size.y
					local var_218_13 = var_218_10 / var_218_11
					local var_218_14 = var_218_9 / var_218_12
					local var_218_15 = var_218_14 < var_218_13 and var_218_13 or var_218_14

					var_218_5.transform.localScale = Vector3.New(var_218_15, var_218_15, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "I05" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_16 = 3.999999999999

			if var_218_16 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			local var_218_17 = 0.3

			if arg_215_1.time_ >= var_218_16 + var_218_17 and arg_215_1.time_ < var_218_16 + var_218_17 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_18 = 0

			if var_218_18 < arg_215_1.time_ and arg_215_1.time_ <= var_218_18 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_19 = 2

			if var_218_18 <= arg_215_1.time_ and arg_215_1.time_ < var_218_18 + var_218_19 then
				local var_218_20 = (arg_215_1.time_ - var_218_18) / var_218_19
				local var_218_21 = Color.New(0, 0, 0)

				var_218_21.a = Mathf.Lerp(0, 1, var_218_20)
				arg_215_1.mask_.color = var_218_21
			end

			if arg_215_1.time_ >= var_218_18 + var_218_19 and arg_215_1.time_ < var_218_18 + var_218_19 + arg_218_0 then
				local var_218_22 = Color.New(0, 0, 0)

				var_218_22.a = 1
				arg_215_1.mask_.color = var_218_22
			end

			local var_218_23 = 2

			if var_218_23 < arg_215_1.time_ and arg_215_1.time_ <= var_218_23 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_24 = 2

			if var_218_23 <= arg_215_1.time_ and arg_215_1.time_ < var_218_23 + var_218_24 then
				local var_218_25 = (arg_215_1.time_ - var_218_23) / var_218_24
				local var_218_26 = Color.New(0, 0, 0)

				var_218_26.a = Mathf.Lerp(1, 0, var_218_25)
				arg_215_1.mask_.color = var_218_26
			end

			if arg_215_1.time_ >= var_218_23 + var_218_24 and arg_215_1.time_ < var_218_23 + var_218_24 + arg_218_0 then
				local var_218_27 = Color.New(0, 0, 0)
				local var_218_28 = 0

				arg_215_1.mask_.enabled = false
				var_218_27.a = var_218_28
				arg_215_1.mask_.color = var_218_27
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_29 = 4
			local var_218_30 = 0.1

			if var_218_29 < arg_215_1.time_ and arg_215_1.time_ <= var_218_29 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_31 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_31:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_32 = arg_215_1:FormatText(StoryNameCfg[113].name)

				arg_215_1.leftNameTxt_.text = var_218_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080_1")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_33 = arg_215_1:GetWordFromCfg(302051053)
				local var_218_34 = arg_215_1:FormatText(var_218_33.content)

				arg_215_1.text_.text = var_218_34

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_35 = 4
				local var_218_36 = utf8.len(var_218_34)
				local var_218_37 = var_218_35 <= 0 and var_218_30 or var_218_30 * (var_218_36 / var_218_35)

				if var_218_37 > 0 and var_218_30 < var_218_37 then
					arg_215_1.talkMaxDuration = var_218_37
					var_218_29 = var_218_29 + 0.3

					if var_218_37 + var_218_29 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_37 + var_218_29
					end
				end

				arg_215_1.text_.text = var_218_34
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051053", "story_v_out_302051.awb") ~= 0 then
					local var_218_38 = manager.audio:GetVoiceLength("story_v_out_302051", "302051053", "story_v_out_302051.awb") / 1000

					if var_218_38 + var_218_29 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_38 + var_218_29
					end

					if var_218_33.prefab_name ~= "" and arg_215_1.actors_[var_218_33.prefab_name] ~= nil then
						local var_218_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_33.prefab_name].transform, "story_v_out_302051", "302051053", "story_v_out_302051.awb")

						arg_215_1:RecordAudio("302051053", var_218_39)
						arg_215_1:RecordAudio("302051053", var_218_39)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_302051", "302051053", "story_v_out_302051.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_302051", "302051053", "story_v_out_302051.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_40 = var_218_29 + 0.3
			local var_218_41 = math.max(var_218_30, arg_215_1.talkMaxDuration)

			if var_218_40 <= arg_215_1.time_ and arg_215_1.time_ < var_218_40 + var_218_41 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_40) / var_218_41

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_40 + var_218_41 and arg_215_1.time_ < var_218_40 + var_218_41 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play302051054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 302051054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play302051055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 1.325

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_2 = arg_221_1:GetWordFromCfg(302051054)
				local var_224_3 = arg_221_1:FormatText(var_224_2.content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 53
				local var_224_5 = utf8.len(var_224_3)
				local var_224_6 = var_224_4 <= 0 and var_224_1 or var_224_1 * (var_224_5 / var_224_4)

				if var_224_6 > 0 and var_224_1 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_7 and arg_221_1.time_ < var_224_0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play302051055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 302051055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play302051056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 1.475

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(302051055)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 59
				local var_228_5 = utf8.len(var_228_3)
				local var_228_6 = var_228_4 <= 0 and var_228_1 or var_228_1 * (var_228_5 / var_228_4)

				if var_228_6 > 0 and var_228_1 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_7 and arg_225_1.time_ < var_228_0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play302051056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 302051056
		arg_229_1.duration_ = 10.03

		local var_229_0 = {
			zh = 7.433,
			ja = 10.033
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
				arg_229_0:Play302051057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = "1027ui_story"

			if arg_229_1.actors_[var_232_0] == nil then
				local var_232_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_232_1) then
					local var_232_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_229_1.stage_.transform)

					var_232_2.name = var_232_0
					var_232_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_229_1.actors_[var_232_0] = var_232_2

					local var_232_3 = var_232_2:GetComponentInChildren(typeof(CharacterEffect))

					var_232_3.enabled = true

					local var_232_4 = GameObjectTools.GetOrAddComponent(var_232_2, typeof(DynamicBoneHelper))

					if var_232_4 then
						var_232_4:EnableDynamicBone(false)
					end

					arg_229_1:ShowWeapon(var_232_3.transform, false)

					arg_229_1.var_[var_232_0 .. "Animator"] = var_232_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_229_1.var_[var_232_0 .. "Animator"].applyRootMotion = true
					arg_229_1.var_[var_232_0 .. "LipSync"] = var_232_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_232_5 = arg_229_1.actors_["1027ui_story"].transform
			local var_232_6 = 0

			if var_232_6 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.var_.moveOldPos1027ui_story = var_232_5.localPosition
			end

			local var_232_7 = 0.001

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_7 then
				local var_232_8 = (arg_229_1.time_ - var_232_6) / var_232_7
				local var_232_9 = Vector3.New(0, -0.81, -5.8)

				var_232_5.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1027ui_story, var_232_9, var_232_8)

				local var_232_10 = manager.ui.mainCamera.transform.position - var_232_5.position

				var_232_5.forward = Vector3.New(var_232_10.x, var_232_10.y, var_232_10.z)

				local var_232_11 = var_232_5.localEulerAngles

				var_232_11.z = 0
				var_232_11.x = 0
				var_232_5.localEulerAngles = var_232_11
			end

			if arg_229_1.time_ >= var_232_6 + var_232_7 and arg_229_1.time_ < var_232_6 + var_232_7 + arg_232_0 then
				var_232_5.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_232_12 = manager.ui.mainCamera.transform.position - var_232_5.position

				var_232_5.forward = Vector3.New(var_232_12.x, var_232_12.y, var_232_12.z)

				local var_232_13 = var_232_5.localEulerAngles

				var_232_13.z = 0
				var_232_13.x = 0
				var_232_5.localEulerAngles = var_232_13
			end

			local var_232_14 = arg_229_1.actors_["1027ui_story"]
			local var_232_15 = 0

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 and not isNil(var_232_14) and arg_229_1.var_.characterEffect1027ui_story == nil then
				arg_229_1.var_.characterEffect1027ui_story = var_232_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_16 = 0.200000002980232

			if var_232_15 <= arg_229_1.time_ and arg_229_1.time_ < var_232_15 + var_232_16 and not isNil(var_232_14) then
				local var_232_17 = (arg_229_1.time_ - var_232_15) / var_232_16

				if arg_229_1.var_.characterEffect1027ui_story and not isNil(var_232_14) then
					arg_229_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_15 + var_232_16 and arg_229_1.time_ < var_232_15 + var_232_16 + arg_232_0 and not isNil(var_232_14) and arg_229_1.var_.characterEffect1027ui_story then
				arg_229_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_232_18 = 0

			if var_232_18 < arg_229_1.time_ and arg_229_1.time_ <= var_232_18 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action5_1")
			end

			local var_232_19 = 0

			if var_232_19 < arg_229_1.time_ and arg_229_1.time_ <= var_232_19 + arg_232_0 then
				arg_229_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_232_20 = 0
			local var_232_21 = 0.875

			if var_232_20 < arg_229_1.time_ and arg_229_1.time_ <= var_232_20 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_22 = arg_229_1:FormatText(StoryNameCfg[56].name)

				arg_229_1.leftNameTxt_.text = var_232_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_23 = arg_229_1:GetWordFromCfg(302051056)
				local var_232_24 = arg_229_1:FormatText(var_232_23.content)

				arg_229_1.text_.text = var_232_24

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_25 = 35
				local var_232_26 = utf8.len(var_232_24)
				local var_232_27 = var_232_25 <= 0 and var_232_21 or var_232_21 * (var_232_26 / var_232_25)

				if var_232_27 > 0 and var_232_21 < var_232_27 then
					arg_229_1.talkMaxDuration = var_232_27

					if var_232_27 + var_232_20 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_27 + var_232_20
					end
				end

				arg_229_1.text_.text = var_232_24
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051056", "story_v_out_302051.awb") ~= 0 then
					local var_232_28 = manager.audio:GetVoiceLength("story_v_out_302051", "302051056", "story_v_out_302051.awb") / 1000

					if var_232_28 + var_232_20 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_28 + var_232_20
					end

					if var_232_23.prefab_name ~= "" and arg_229_1.actors_[var_232_23.prefab_name] ~= nil then
						local var_232_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_23.prefab_name].transform, "story_v_out_302051", "302051056", "story_v_out_302051.awb")

						arg_229_1:RecordAudio("302051056", var_232_29)
						arg_229_1:RecordAudio("302051056", var_232_29)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_302051", "302051056", "story_v_out_302051.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_302051", "302051056", "story_v_out_302051.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_30 = math.max(var_232_21, arg_229_1.talkMaxDuration)

			if var_232_20 <= arg_229_1.time_ and arg_229_1.time_ < var_232_20 + var_232_30 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_20) / var_232_30

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_20 + var_232_30 and arg_229_1.time_ < var_232_20 + var_232_30 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play302051057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 302051057
		arg_233_1.duration_ = 6.23

		local var_233_0 = {
			zh = 4.766,
			ja = 6.233
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
				arg_233_0:Play302051058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.5

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[56].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:GetWordFromCfg(302051057)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 20
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051057", "story_v_out_302051.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_302051", "302051057", "story_v_out_302051.awb") / 1000

					if var_236_8 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_0
					end

					if var_236_3.prefab_name ~= "" and arg_233_1.actors_[var_236_3.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_3.prefab_name].transform, "story_v_out_302051", "302051057", "story_v_out_302051.awb")

						arg_233_1:RecordAudio("302051057", var_236_9)
						arg_233_1:RecordAudio("302051057", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_302051", "302051057", "story_v_out_302051.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_302051", "302051057", "story_v_out_302051.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_10 and arg_233_1.time_ < var_236_0 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play302051058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 302051058
		arg_237_1.duration_ = 3.97

		local var_237_0 = {
			zh = 2.3,
			ja = 3.966
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
				arg_237_0:Play302051059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = "1080ui_story"

			if arg_237_1.actors_[var_240_0] == nil then
				local var_240_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_240_1) then
					local var_240_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_237_1.stage_.transform)

					var_240_2.name = var_240_0
					var_240_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_237_1.actors_[var_240_0] = var_240_2

					local var_240_3 = var_240_2:GetComponentInChildren(typeof(CharacterEffect))

					var_240_3.enabled = true

					local var_240_4 = GameObjectTools.GetOrAddComponent(var_240_2, typeof(DynamicBoneHelper))

					if var_240_4 then
						var_240_4:EnableDynamicBone(false)
					end

					arg_237_1:ShowWeapon(var_240_3.transform, false)

					arg_237_1.var_[var_240_0 .. "Animator"] = var_240_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_237_1.var_[var_240_0 .. "Animator"].applyRootMotion = true
					arg_237_1.var_[var_240_0 .. "LipSync"] = var_240_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_240_5 = arg_237_1.actors_["1080ui_story"].transform
			local var_240_6 = 0

			if var_240_6 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.var_.moveOldPos1080ui_story = var_240_5.localPosition
			end

			local var_240_7 = 0.001

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_7 then
				local var_240_8 = (arg_237_1.time_ - var_240_6) / var_240_7
				local var_240_9 = Vector3.New(0.7, -1.01, -6.05)

				var_240_5.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1080ui_story, var_240_9, var_240_8)

				local var_240_10 = manager.ui.mainCamera.transform.position - var_240_5.position

				var_240_5.forward = Vector3.New(var_240_10.x, var_240_10.y, var_240_10.z)

				local var_240_11 = var_240_5.localEulerAngles

				var_240_11.z = 0
				var_240_11.x = 0
				var_240_5.localEulerAngles = var_240_11
			end

			if arg_237_1.time_ >= var_240_6 + var_240_7 and arg_237_1.time_ < var_240_6 + var_240_7 + arg_240_0 then
				var_240_5.localPosition = Vector3.New(0.7, -1.01, -6.05)

				local var_240_12 = manager.ui.mainCamera.transform.position - var_240_5.position

				var_240_5.forward = Vector3.New(var_240_12.x, var_240_12.y, var_240_12.z)

				local var_240_13 = var_240_5.localEulerAngles

				var_240_13.z = 0
				var_240_13.x = 0
				var_240_5.localEulerAngles = var_240_13
			end

			local var_240_14 = arg_237_1.actors_["1027ui_story"].transform
			local var_240_15 = 0

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.var_.moveOldPos1027ui_story = var_240_14.localPosition
			end

			local var_240_16 = 0.001

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_16 then
				local var_240_17 = (arg_237_1.time_ - var_240_15) / var_240_16
				local var_240_18 = Vector3.New(-0.7, -0.81, -5.8)

				var_240_14.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1027ui_story, var_240_18, var_240_17)

				local var_240_19 = manager.ui.mainCamera.transform.position - var_240_14.position

				var_240_14.forward = Vector3.New(var_240_19.x, var_240_19.y, var_240_19.z)

				local var_240_20 = var_240_14.localEulerAngles

				var_240_20.z = 0
				var_240_20.x = 0
				var_240_14.localEulerAngles = var_240_20
			end

			if arg_237_1.time_ >= var_240_15 + var_240_16 and arg_237_1.time_ < var_240_15 + var_240_16 + arg_240_0 then
				var_240_14.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_240_21 = manager.ui.mainCamera.transform.position - var_240_14.position

				var_240_14.forward = Vector3.New(var_240_21.x, var_240_21.y, var_240_21.z)

				local var_240_22 = var_240_14.localEulerAngles

				var_240_22.z = 0
				var_240_22.x = 0
				var_240_14.localEulerAngles = var_240_22
			end

			local var_240_23 = arg_237_1.actors_["1080ui_story"]
			local var_240_24 = 0

			if var_240_24 < arg_237_1.time_ and arg_237_1.time_ <= var_240_24 + arg_240_0 and not isNil(var_240_23) and arg_237_1.var_.characterEffect1080ui_story == nil then
				arg_237_1.var_.characterEffect1080ui_story = var_240_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_25 = 0.200000002980232

			if var_240_24 <= arg_237_1.time_ and arg_237_1.time_ < var_240_24 + var_240_25 and not isNil(var_240_23) then
				local var_240_26 = (arg_237_1.time_ - var_240_24) / var_240_25

				if arg_237_1.var_.characterEffect1080ui_story and not isNil(var_240_23) then
					arg_237_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_24 + var_240_25 and arg_237_1.time_ < var_240_24 + var_240_25 + arg_240_0 and not isNil(var_240_23) and arg_237_1.var_.characterEffect1080ui_story then
				arg_237_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_240_27 = arg_237_1.actors_["1027ui_story"]
			local var_240_28 = 0

			if var_240_28 < arg_237_1.time_ and arg_237_1.time_ <= var_240_28 + arg_240_0 and not isNil(var_240_27) and arg_237_1.var_.characterEffect1027ui_story == nil then
				arg_237_1.var_.characterEffect1027ui_story = var_240_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_29 = 0.200000002980232

			if var_240_28 <= arg_237_1.time_ and arg_237_1.time_ < var_240_28 + var_240_29 and not isNil(var_240_27) then
				local var_240_30 = (arg_237_1.time_ - var_240_28) / var_240_29

				if arg_237_1.var_.characterEffect1027ui_story and not isNil(var_240_27) then
					local var_240_31 = Mathf.Lerp(0, 0.5, var_240_30)

					arg_237_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1027ui_story.fillRatio = var_240_31
				end
			end

			if arg_237_1.time_ >= var_240_28 + var_240_29 and arg_237_1.time_ < var_240_28 + var_240_29 + arg_240_0 and not isNil(var_240_27) and arg_237_1.var_.characterEffect1027ui_story then
				local var_240_32 = 0.5

				arg_237_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1027ui_story.fillRatio = var_240_32
			end

			local var_240_33 = 0

			if var_240_33 < arg_237_1.time_ and arg_237_1.time_ <= var_240_33 + arg_240_0 then
				arg_237_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_240_34 = 0

			if var_240_34 < arg_237_1.time_ and arg_237_1.time_ <= var_240_34 + arg_240_0 then
				arg_237_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_240_35 = 0
			local var_240_36 = 0.25

			if var_240_35 < arg_237_1.time_ and arg_237_1.time_ <= var_240_35 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_37 = arg_237_1:FormatText(StoryNameCfg[55].name)

				arg_237_1.leftNameTxt_.text = var_240_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_38 = arg_237_1:GetWordFromCfg(302051058)
				local var_240_39 = arg_237_1:FormatText(var_240_38.content)

				arg_237_1.text_.text = var_240_39

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_40 = 10
				local var_240_41 = utf8.len(var_240_39)
				local var_240_42 = var_240_40 <= 0 and var_240_36 or var_240_36 * (var_240_41 / var_240_40)

				if var_240_42 > 0 and var_240_36 < var_240_42 then
					arg_237_1.talkMaxDuration = var_240_42

					if var_240_42 + var_240_35 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_42 + var_240_35
					end
				end

				arg_237_1.text_.text = var_240_39
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051058", "story_v_out_302051.awb") ~= 0 then
					local var_240_43 = manager.audio:GetVoiceLength("story_v_out_302051", "302051058", "story_v_out_302051.awb") / 1000

					if var_240_43 + var_240_35 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_43 + var_240_35
					end

					if var_240_38.prefab_name ~= "" and arg_237_1.actors_[var_240_38.prefab_name] ~= nil then
						local var_240_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_38.prefab_name].transform, "story_v_out_302051", "302051058", "story_v_out_302051.awb")

						arg_237_1:RecordAudio("302051058", var_240_44)
						arg_237_1:RecordAudio("302051058", var_240_44)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_302051", "302051058", "story_v_out_302051.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_302051", "302051058", "story_v_out_302051.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_45 = math.max(var_240_36, arg_237_1.talkMaxDuration)

			if var_240_35 <= arg_237_1.time_ and arg_237_1.time_ < var_240_35 + var_240_45 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_35) / var_240_45

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_35 + var_240_45 and arg_237_1.time_ < var_240_35 + var_240_45 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play302051059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 302051059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play302051060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1080ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1080ui_story == nil then
				arg_241_1.var_.characterEffect1080ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1080ui_story and not isNil(var_244_0) then
					local var_244_4 = Mathf.Lerp(0, 0.5, var_244_3)

					arg_241_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1080ui_story.fillRatio = var_244_4
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1080ui_story then
				local var_244_5 = 0.5

				arg_241_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1080ui_story.fillRatio = var_244_5
			end

			local var_244_6 = 0
			local var_244_7 = 1.675

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_8 = arg_241_1:GetWordFromCfg(302051059)
				local var_244_9 = arg_241_1:FormatText(var_244_8.content)

				arg_241_1.text_.text = var_244_9

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 67
				local var_244_11 = utf8.len(var_244_9)
				local var_244_12 = var_244_10 <= 0 and var_244_7 or var_244_7 * (var_244_11 / var_244_10)

				if var_244_12 > 0 and var_244_7 < var_244_12 then
					arg_241_1.talkMaxDuration = var_244_12

					if var_244_12 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_12 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_9
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_13 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_13 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_13

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_13 and arg_241_1.time_ < var_244_6 + var_244_13 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play302051060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 302051060
		arg_245_1.duration_ = 4.07

		local var_245_0 = {
			zh = 3.966,
			ja = 4.066
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
				arg_245_0:Play302051061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1027ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1027ui_story == nil then
				arg_245_1.var_.characterEffect1027ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1027ui_story and not isNil(var_248_0) then
					arg_245_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1027ui_story then
				arg_245_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_248_4 = 0

			if var_248_4 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action5_2")
			end

			local var_248_5 = 0

			if var_248_5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_248_6 = 0
			local var_248_7 = 0.8

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_8 = arg_245_1:FormatText(StoryNameCfg[56].name)

				arg_245_1.leftNameTxt_.text = var_248_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_9 = arg_245_1:GetWordFromCfg(302051060)
				local var_248_10 = arg_245_1:FormatText(var_248_9.content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 32
				local var_248_12 = utf8.len(var_248_10)
				local var_248_13 = var_248_11 <= 0 and var_248_7 or var_248_7 * (var_248_12 / var_248_11)

				if var_248_13 > 0 and var_248_7 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_6
					end
				end

				arg_245_1.text_.text = var_248_10
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051060", "story_v_out_302051.awb") ~= 0 then
					local var_248_14 = manager.audio:GetVoiceLength("story_v_out_302051", "302051060", "story_v_out_302051.awb") / 1000

					if var_248_14 + var_248_6 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_14 + var_248_6
					end

					if var_248_9.prefab_name ~= "" and arg_245_1.actors_[var_248_9.prefab_name] ~= nil then
						local var_248_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_9.prefab_name].transform, "story_v_out_302051", "302051060", "story_v_out_302051.awb")

						arg_245_1:RecordAudio("302051060", var_248_15)
						arg_245_1:RecordAudio("302051060", var_248_15)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_302051", "302051060", "story_v_out_302051.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_302051", "302051060", "story_v_out_302051.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = math.max(var_248_7, arg_245_1.talkMaxDuration)

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_16 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_6) / var_248_16

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_6 + var_248_16 and arg_245_1.time_ < var_248_6 + var_248_16 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play302051061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 302051061
		arg_249_1.duration_ = 2

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play302051062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1080ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1080ui_story == nil then
				arg_249_1.var_.characterEffect1080ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1080ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1080ui_story then
				arg_249_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_252_4 = arg_249_1.actors_["1027ui_story"]
			local var_252_5 = 0

			if var_252_5 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect1027ui_story == nil then
				arg_249_1.var_.characterEffect1027ui_story = var_252_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_6 = 0.200000002980232

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_6 and not isNil(var_252_4) then
				local var_252_7 = (arg_249_1.time_ - var_252_5) / var_252_6

				if arg_249_1.var_.characterEffect1027ui_story and not isNil(var_252_4) then
					local var_252_8 = Mathf.Lerp(0, 0.5, var_252_7)

					arg_249_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1027ui_story.fillRatio = var_252_8
				end
			end

			if arg_249_1.time_ >= var_252_5 + var_252_6 and arg_249_1.time_ < var_252_5 + var_252_6 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect1027ui_story then
				local var_252_9 = 0.5

				arg_249_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1027ui_story.fillRatio = var_252_9
			end

			local var_252_10 = 0

			if var_252_10 < arg_249_1.time_ and arg_249_1.time_ <= var_252_10 + arg_252_0 then
				arg_249_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_252_11 = 0

			if var_252_11 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_252_12 = 0
			local var_252_13 = 0.05

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_14 = arg_249_1:FormatText(StoryNameCfg[55].name)

				arg_249_1.leftNameTxt_.text = var_252_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_15 = arg_249_1:GetWordFromCfg(302051061)
				local var_252_16 = arg_249_1:FormatText(var_252_15.content)

				arg_249_1.text_.text = var_252_16

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_17 = 2
				local var_252_18 = utf8.len(var_252_16)
				local var_252_19 = var_252_17 <= 0 and var_252_13 or var_252_13 * (var_252_18 / var_252_17)

				if var_252_19 > 0 and var_252_13 < var_252_19 then
					arg_249_1.talkMaxDuration = var_252_19

					if var_252_19 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_19 + var_252_12
					end
				end

				arg_249_1.text_.text = var_252_16
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051061", "story_v_out_302051.awb") ~= 0 then
					local var_252_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051061", "story_v_out_302051.awb") / 1000

					if var_252_20 + var_252_12 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_20 + var_252_12
					end

					if var_252_15.prefab_name ~= "" and arg_249_1.actors_[var_252_15.prefab_name] ~= nil then
						local var_252_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_15.prefab_name].transform, "story_v_out_302051", "302051061", "story_v_out_302051.awb")

						arg_249_1:RecordAudio("302051061", var_252_21)
						arg_249_1:RecordAudio("302051061", var_252_21)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_302051", "302051061", "story_v_out_302051.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_302051", "302051061", "story_v_out_302051.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_22 = math.max(var_252_13, arg_249_1.talkMaxDuration)

			if var_252_12 <= arg_249_1.time_ and arg_249_1.time_ < var_252_12 + var_252_22 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_12) / var_252_22

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_12 + var_252_22 and arg_249_1.time_ < var_252_12 + var_252_22 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play302051062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 302051062
		arg_253_1.duration_ = 4.57

		local var_253_0 = {
			zh = 4.5,
			ja = 4.566
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
				arg_253_0:Play302051063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				local var_256_2 = "play"
				local var_256_3 = "effect"

				arg_253_1:AudioAction(var_256_2, var_256_3, "se_story_side_1067", "se_story_1067_ring", "")
			end

			local var_256_4 = 0
			local var_256_5 = 0.3

			if var_256_4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_6 = arg_253_1:FormatText(StoryNameCfg[55].name)

				arg_253_1.leftNameTxt_.text = var_256_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_7 = arg_253_1:GetWordFromCfg(302051062)
				local var_256_8 = arg_253_1:FormatText(var_256_7.content)

				arg_253_1.text_.text = var_256_8

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 12
				local var_256_10 = utf8.len(var_256_8)
				local var_256_11 = var_256_9 <= 0 and var_256_5 or var_256_5 * (var_256_10 / var_256_9)

				if var_256_11 > 0 and var_256_5 < var_256_11 then
					arg_253_1.talkMaxDuration = var_256_11

					if var_256_11 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_11 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_8
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051062", "story_v_out_302051.awb") ~= 0 then
					local var_256_12 = manager.audio:GetVoiceLength("story_v_out_302051", "302051062", "story_v_out_302051.awb") / 1000

					if var_256_12 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_4
					end

					if var_256_7.prefab_name ~= "" and arg_253_1.actors_[var_256_7.prefab_name] ~= nil then
						local var_256_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_7.prefab_name].transform, "story_v_out_302051", "302051062", "story_v_out_302051.awb")

						arg_253_1:RecordAudio("302051062", var_256_13)
						arg_253_1:RecordAudio("302051062", var_256_13)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_302051", "302051062", "story_v_out_302051.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_302051", "302051062", "story_v_out_302051.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_14 and arg_253_1.time_ < var_256_4 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play302051063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 302051063
		arg_257_1.duration_ = 3.9

		local var_257_0 = {
			zh = 3.9,
			ja = 3.7
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
				arg_257_0:Play302051064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_260_2 = 0
			local var_260_3 = 0.3

			if var_260_2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_4 = arg_257_1:FormatText(StoryNameCfg[55].name)

				arg_257_1.leftNameTxt_.text = var_260_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_5 = arg_257_1:GetWordFromCfg(302051063)
				local var_260_6 = arg_257_1:FormatText(var_260_5.content)

				arg_257_1.text_.text = var_260_6

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 12
				local var_260_8 = utf8.len(var_260_6)
				local var_260_9 = var_260_7 <= 0 and var_260_3 or var_260_3 * (var_260_8 / var_260_7)

				if var_260_9 > 0 and var_260_3 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_6
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051063", "story_v_out_302051.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_302051", "302051063", "story_v_out_302051.awb") / 1000

					if var_260_10 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_2
					end

					if var_260_5.prefab_name ~= "" and arg_257_1.actors_[var_260_5.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_5.prefab_name].transform, "story_v_out_302051", "302051063", "story_v_out_302051.awb")

						arg_257_1:RecordAudio("302051063", var_260_11)
						arg_257_1:RecordAudio("302051063", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_302051", "302051063", "story_v_out_302051.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_302051", "302051063", "story_v_out_302051.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_12 and arg_257_1.time_ < var_260_2 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play302051064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 302051064
		arg_261_1.duration_ = 3.8

		local var_261_0 = {
			zh = 3.466,
			ja = 3.8
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
				arg_261_0:Play302051065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1027ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1027ui_story == nil then
				arg_261_1.var_.characterEffect1027ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1027ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1027ui_story then
				arg_261_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_264_4 = arg_261_1.actors_["1080ui_story"]
			local var_264_5 = 0

			if var_264_5 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect1080ui_story == nil then
				arg_261_1.var_.characterEffect1080ui_story = var_264_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_6 = 0.200000002980232

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_6 and not isNil(var_264_4) then
				local var_264_7 = (arg_261_1.time_ - var_264_5) / var_264_6

				if arg_261_1.var_.characterEffect1080ui_story and not isNil(var_264_4) then
					local var_264_8 = Mathf.Lerp(0, 0.5, var_264_7)

					arg_261_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1080ui_story.fillRatio = var_264_8
				end
			end

			if arg_261_1.time_ >= var_264_5 + var_264_6 and arg_261_1.time_ < var_264_5 + var_264_6 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect1080ui_story then
				local var_264_9 = 0.5

				arg_261_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1080ui_story.fillRatio = var_264_9
			end

			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_264_11 = 0

			if var_264_11 < arg_261_1.time_ and arg_261_1.time_ <= var_264_11 + arg_264_0 then
				arg_261_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_264_12 = 0
			local var_264_13 = 0.45

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_14 = arg_261_1:FormatText(StoryNameCfg[56].name)

				arg_261_1.leftNameTxt_.text = var_264_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_15 = arg_261_1:GetWordFromCfg(302051064)
				local var_264_16 = arg_261_1:FormatText(var_264_15.content)

				arg_261_1.text_.text = var_264_16

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_17 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051064", "story_v_out_302051.awb") ~= 0 then
					local var_264_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051064", "story_v_out_302051.awb") / 1000

					if var_264_20 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_20 + var_264_12
					end

					if var_264_15.prefab_name ~= "" and arg_261_1.actors_[var_264_15.prefab_name] ~= nil then
						local var_264_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_15.prefab_name].transform, "story_v_out_302051", "302051064", "story_v_out_302051.awb")

						arg_261_1:RecordAudio("302051064", var_264_21)
						arg_261_1:RecordAudio("302051064", var_264_21)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_302051", "302051064", "story_v_out_302051.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_302051", "302051064", "story_v_out_302051.awb")
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
	Play302051065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 302051065
		arg_265_1.duration_ = 3.03

		local var_265_0 = {
			zh = 3.033,
			ja = 1.8
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
				arg_265_0:Play302051066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1080ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1080ui_story == nil then
				arg_265_1.var_.characterEffect1080ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1080ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1080ui_story then
				arg_265_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_268_4 = arg_265_1.actors_["1027ui_story"]
			local var_268_5 = 0

			if var_268_5 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect1027ui_story == nil then
				arg_265_1.var_.characterEffect1027ui_story = var_268_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_6 = 0.200000002980232

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_6 and not isNil(var_268_4) then
				local var_268_7 = (arg_265_1.time_ - var_268_5) / var_268_6

				if arg_265_1.var_.characterEffect1027ui_story and not isNil(var_268_4) then
					local var_268_8 = Mathf.Lerp(0, 0.5, var_268_7)

					arg_265_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1027ui_story.fillRatio = var_268_8
				end
			end

			if arg_265_1.time_ >= var_268_5 + var_268_6 and arg_265_1.time_ < var_268_5 + var_268_6 + arg_268_0 and not isNil(var_268_4) and arg_265_1.var_.characterEffect1027ui_story then
				local var_268_9 = 0.5

				arg_265_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1027ui_story.fillRatio = var_268_9
			end

			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 then
				arg_265_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_268_11 = 0

			if var_268_11 < arg_265_1.time_ and arg_265_1.time_ <= var_268_11 + arg_268_0 then
				arg_265_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_268_12 = 0
			local var_268_13 = 0.325

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_14 = arg_265_1:FormatText(StoryNameCfg[55].name)

				arg_265_1.leftNameTxt_.text = var_268_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_15 = arg_265_1:GetWordFromCfg(302051065)
				local var_268_16 = arg_265_1:FormatText(var_268_15.content)

				arg_265_1.text_.text = var_268_16

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_17 = 13
				local var_268_18 = utf8.len(var_268_16)
				local var_268_19 = var_268_17 <= 0 and var_268_13 or var_268_13 * (var_268_18 / var_268_17)

				if var_268_19 > 0 and var_268_13 < var_268_19 then
					arg_265_1.talkMaxDuration = var_268_19

					if var_268_19 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_19 + var_268_12
					end
				end

				arg_265_1.text_.text = var_268_16
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051065", "story_v_out_302051.awb") ~= 0 then
					local var_268_20 = manager.audio:GetVoiceLength("story_v_out_302051", "302051065", "story_v_out_302051.awb") / 1000

					if var_268_20 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_20 + var_268_12
					end

					if var_268_15.prefab_name ~= "" and arg_265_1.actors_[var_268_15.prefab_name] ~= nil then
						local var_268_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_15.prefab_name].transform, "story_v_out_302051", "302051065", "story_v_out_302051.awb")

						arg_265_1:RecordAudio("302051065", var_268_21)
						arg_265_1:RecordAudio("302051065", var_268_21)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_302051", "302051065", "story_v_out_302051.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_302051", "302051065", "story_v_out_302051.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_22 = math.max(var_268_13, arg_265_1.talkMaxDuration)

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_22 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_12) / var_268_22

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_12 + var_268_22 and arg_265_1.time_ < var_268_12 + var_268_22 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play302051066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 302051066
		arg_269_1.duration_ = 2.23

		local var_269_0 = {
			zh = 2.2,
			ja = 2.233
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
				arg_269_0:Play302051067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_2 = 0
			local var_272_3 = 0.2

			if var_272_2 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_4 = arg_269_1:FormatText(StoryNameCfg[55].name)

				arg_269_1.leftNameTxt_.text = var_272_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_5 = arg_269_1:GetWordFromCfg(302051066)
				local var_272_6 = arg_269_1:FormatText(var_272_5.content)

				arg_269_1.text_.text = var_272_6

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 8
				local var_272_8 = utf8.len(var_272_6)
				local var_272_9 = var_272_7 <= 0 and var_272_3 or var_272_3 * (var_272_8 / var_272_7)

				if var_272_9 > 0 and var_272_3 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_2
					end
				end

				arg_269_1.text_.text = var_272_6
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051066", "story_v_out_302051.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_302051", "302051066", "story_v_out_302051.awb") / 1000

					if var_272_10 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_2
					end

					if var_272_5.prefab_name ~= "" and arg_269_1.actors_[var_272_5.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_5.prefab_name].transform, "story_v_out_302051", "302051066", "story_v_out_302051.awb")

						arg_269_1:RecordAudio("302051066", var_272_11)
						arg_269_1:RecordAudio("302051066", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_302051", "302051066", "story_v_out_302051.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_302051", "302051066", "story_v_out_302051.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_3, arg_269_1.talkMaxDuration)

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_2) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_2 + var_272_12 and arg_269_1.time_ < var_272_2 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play302051067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 302051067
		arg_273_1.duration_ = 8.67

		local var_273_0 = {
			zh = 8.66600000298023,
			ja = 6.90000000298023
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
				arg_273_0:Play302051068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 2

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				local var_276_1 = manager.ui.mainCamera.transform.localPosition
				local var_276_2 = Vector3.New(0, 0, 10) + Vector3.New(var_276_1.x, var_276_1.y, 0)
				local var_276_3 = arg_273_1.bgs_.I05d

				var_276_3.transform.localPosition = var_276_2
				var_276_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_4 = var_276_3:GetComponent("SpriteRenderer")

				if var_276_4 and var_276_4.sprite then
					local var_276_5 = (var_276_3.transform.localPosition - var_276_1).z
					local var_276_6 = manager.ui.mainCameraCom_
					local var_276_7 = 2 * var_276_5 * Mathf.Tan(var_276_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_276_8 = var_276_7 * var_276_6.aspect
					local var_276_9 = var_276_4.sprite.bounds.size.x
					local var_276_10 = var_276_4.sprite.bounds.size.y
					local var_276_11 = var_276_8 / var_276_9
					local var_276_12 = var_276_7 / var_276_10
					local var_276_13 = var_276_12 < var_276_11 and var_276_11 or var_276_12

					var_276_3.transform.localScale = Vector3.New(var_276_13, var_276_13, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "I05d" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_276_14 = 4

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 then
				arg_273_1.allBtn_.enabled = false
			end

			local var_276_15 = 0.3

			if arg_273_1.time_ >= var_276_14 + var_276_15 and arg_273_1.time_ < var_276_14 + var_276_15 + arg_276_0 then
				arg_273_1.allBtn_.enabled = true
			end

			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_17 = 2

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_17 then
				local var_276_18 = (arg_273_1.time_ - var_276_16) / var_276_17
				local var_276_19 = Color.New(0, 0, 0)

				var_276_19.a = Mathf.Lerp(0, 1, var_276_18)
				arg_273_1.mask_.color = var_276_19
			end

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 then
				local var_276_20 = Color.New(0, 0, 0)

				var_276_20.a = 1
				arg_273_1.mask_.color = var_276_20
			end

			local var_276_21 = 2

			if var_276_21 < arg_273_1.time_ and arg_273_1.time_ <= var_276_21 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_22 = 2

			if var_276_21 <= arg_273_1.time_ and arg_273_1.time_ < var_276_21 + var_276_22 then
				local var_276_23 = (arg_273_1.time_ - var_276_21) / var_276_22
				local var_276_24 = Color.New(0, 0, 0)

				var_276_24.a = Mathf.Lerp(1, 0, var_276_23)
				arg_273_1.mask_.color = var_276_24
			end

			if arg_273_1.time_ >= var_276_21 + var_276_22 and arg_273_1.time_ < var_276_21 + var_276_22 + arg_276_0 then
				local var_276_25 = Color.New(0, 0, 0)
				local var_276_26 = 0

				arg_273_1.mask_.enabled = false
				var_276_25.a = var_276_26
				arg_273_1.mask_.color = var_276_25
			end

			local var_276_27 = arg_273_1.actors_["1080ui_story"].transform
			local var_276_28 = 1.96599999815226

			if var_276_28 < arg_273_1.time_ and arg_273_1.time_ <= var_276_28 + arg_276_0 then
				arg_273_1.var_.moveOldPos1080ui_story = var_276_27.localPosition
			end

			local var_276_29 = 0.001

			if var_276_28 <= arg_273_1.time_ and arg_273_1.time_ < var_276_28 + var_276_29 then
				local var_276_30 = (arg_273_1.time_ - var_276_28) / var_276_29
				local var_276_31 = Vector3.New(0, 100, 0)

				var_276_27.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1080ui_story, var_276_31, var_276_30)

				local var_276_32 = manager.ui.mainCamera.transform.position - var_276_27.position

				var_276_27.forward = Vector3.New(var_276_32.x, var_276_32.y, var_276_32.z)

				local var_276_33 = var_276_27.localEulerAngles

				var_276_33.z = 0
				var_276_33.x = 0
				var_276_27.localEulerAngles = var_276_33
			end

			if arg_273_1.time_ >= var_276_28 + var_276_29 and arg_273_1.time_ < var_276_28 + var_276_29 + arg_276_0 then
				var_276_27.localPosition = Vector3.New(0, 100, 0)

				local var_276_34 = manager.ui.mainCamera.transform.position - var_276_27.position

				var_276_27.forward = Vector3.New(var_276_34.x, var_276_34.y, var_276_34.z)

				local var_276_35 = var_276_27.localEulerAngles

				var_276_35.z = 0
				var_276_35.x = 0
				var_276_27.localEulerAngles = var_276_35
			end

			local var_276_36 = arg_273_1.actors_["1027ui_story"].transform
			local var_276_37 = 1.96599999815226

			if var_276_37 < arg_273_1.time_ and arg_273_1.time_ <= var_276_37 + arg_276_0 then
				arg_273_1.var_.moveOldPos1027ui_story = var_276_36.localPosition
			end

			local var_276_38 = 0.001

			if var_276_37 <= arg_273_1.time_ and arg_273_1.time_ < var_276_37 + var_276_38 then
				local var_276_39 = (arg_273_1.time_ - var_276_37) / var_276_38
				local var_276_40 = Vector3.New(0, 100, 0)

				var_276_36.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1027ui_story, var_276_40, var_276_39)

				local var_276_41 = manager.ui.mainCamera.transform.position - var_276_36.position

				var_276_36.forward = Vector3.New(var_276_41.x, var_276_41.y, var_276_41.z)

				local var_276_42 = var_276_36.localEulerAngles

				var_276_42.z = 0
				var_276_42.x = 0
				var_276_36.localEulerAngles = var_276_42
			end

			if arg_273_1.time_ >= var_276_37 + var_276_38 and arg_273_1.time_ < var_276_37 + var_276_38 + arg_276_0 then
				var_276_36.localPosition = Vector3.New(0, 100, 0)

				local var_276_43 = manager.ui.mainCamera.transform.position - var_276_36.position

				var_276_36.forward = Vector3.New(var_276_43.x, var_276_43.y, var_276_43.z)

				local var_276_44 = var_276_36.localEulerAngles

				var_276_44.z = 0
				var_276_44.x = 0
				var_276_36.localEulerAngles = var_276_44
			end

			local var_276_45 = arg_273_1.actors_["1027ui_story"]
			local var_276_46 = 3.8

			if var_276_46 < arg_273_1.time_ and arg_273_1.time_ <= var_276_46 + arg_276_0 and not isNil(var_276_45) and arg_273_1.var_.characterEffect1027ui_story == nil then
				arg_273_1.var_.characterEffect1027ui_story = var_276_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_47 = 0.200000002980232

			if var_276_46 <= arg_273_1.time_ and arg_273_1.time_ < var_276_46 + var_276_47 and not isNil(var_276_45) then
				local var_276_48 = (arg_273_1.time_ - var_276_46) / var_276_47

				if arg_273_1.var_.characterEffect1027ui_story and not isNil(var_276_45) then
					arg_273_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_46 + var_276_47 and arg_273_1.time_ < var_276_46 + var_276_47 + arg_276_0 and not isNil(var_276_45) and arg_273_1.var_.characterEffect1027ui_story then
				arg_273_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_276_49 = 3.8

			if var_276_49 < arg_273_1.time_ and arg_273_1.time_ <= var_276_49 + arg_276_0 then
				arg_273_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			local var_276_50 = 3.8

			if var_276_50 < arg_273_1.time_ and arg_273_1.time_ <= var_276_50 + arg_276_0 then
				arg_273_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_276_51 = arg_273_1.actors_["1027ui_story"].transform
			local var_276_52 = 3.8

			if var_276_52 < arg_273_1.time_ and arg_273_1.time_ <= var_276_52 + arg_276_0 then
				arg_273_1.var_.moveOldPos1027ui_story = var_276_51.localPosition
			end

			local var_276_53 = 0.001

			if var_276_52 <= arg_273_1.time_ and arg_273_1.time_ < var_276_52 + var_276_53 then
				local var_276_54 = (arg_273_1.time_ - var_276_52) / var_276_53
				local var_276_55 = Vector3.New(0, -0.81, -5.8)

				var_276_51.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1027ui_story, var_276_55, var_276_54)

				local var_276_56 = manager.ui.mainCamera.transform.position - var_276_51.position

				var_276_51.forward = Vector3.New(var_276_56.x, var_276_56.y, var_276_56.z)

				local var_276_57 = var_276_51.localEulerAngles

				var_276_57.z = 0
				var_276_57.x = 0
				var_276_51.localEulerAngles = var_276_57
			end

			if arg_273_1.time_ >= var_276_52 + var_276_53 and arg_273_1.time_ < var_276_52 + var_276_53 + arg_276_0 then
				var_276_51.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_276_58 = manager.ui.mainCamera.transform.position - var_276_51.position

				var_276_51.forward = Vector3.New(var_276_58.x, var_276_58.y, var_276_58.z)

				local var_276_59 = var_276_51.localEulerAngles

				var_276_59.z = 0
				var_276_59.x = 0
				var_276_51.localEulerAngles = var_276_59
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_60 = 4.00000000298023
			local var_276_61 = 0.525

			if var_276_60 < arg_273_1.time_ and arg_273_1.time_ <= var_276_60 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_62 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_62:setOnUpdate(LuaHelper.FloatAction(function(arg_277_0)
					arg_273_1.dialogCg_.alpha = arg_277_0
				end))
				var_276_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_63 = arg_273_1:FormatText(StoryNameCfg[56].name)

				arg_273_1.leftNameTxt_.text = var_276_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_64 = arg_273_1:GetWordFromCfg(302051067)
				local var_276_65 = arg_273_1:FormatText(var_276_64.content)

				arg_273_1.text_.text = var_276_65

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_66 = 21
				local var_276_67 = utf8.len(var_276_65)
				local var_276_68 = var_276_66 <= 0 and var_276_61 or var_276_61 * (var_276_67 / var_276_66)

				if var_276_68 > 0 and var_276_61 < var_276_68 then
					arg_273_1.talkMaxDuration = var_276_68
					var_276_60 = var_276_60 + 0.3

					if var_276_68 + var_276_60 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_68 + var_276_60
					end
				end

				arg_273_1.text_.text = var_276_65
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051067", "story_v_out_302051.awb") ~= 0 then
					local var_276_69 = manager.audio:GetVoiceLength("story_v_out_302051", "302051067", "story_v_out_302051.awb") / 1000

					if var_276_69 + var_276_60 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_69 + var_276_60
					end

					if var_276_64.prefab_name ~= "" and arg_273_1.actors_[var_276_64.prefab_name] ~= nil then
						local var_276_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_64.prefab_name].transform, "story_v_out_302051", "302051067", "story_v_out_302051.awb")

						arg_273_1:RecordAudio("302051067", var_276_70)
						arg_273_1:RecordAudio("302051067", var_276_70)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_302051", "302051067", "story_v_out_302051.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_302051", "302051067", "story_v_out_302051.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_71 = var_276_60 + 0.3
			local var_276_72 = math.max(var_276_61, arg_273_1.talkMaxDuration)

			if var_276_71 <= arg_273_1.time_ and arg_273_1.time_ < var_276_71 + var_276_72 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_71) / var_276_72

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_71 + var_276_72 and arg_273_1.time_ < var_276_71 + var_276_72 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play302051068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 302051068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play302051069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1027ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1027ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(0, 100, 0)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1027ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(0, 100, 0)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["1027ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1027ui_story == nil then
				arg_279_1.var_.characterEffect1027ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.200000002980232

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect1027ui_story and not isNil(var_282_9) then
					local var_282_13 = Mathf.Lerp(0, 0.5, var_282_12)

					arg_279_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1027ui_story.fillRatio = var_282_13
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1027ui_story then
				local var_282_14 = 0.5

				arg_279_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1027ui_story.fillRatio = var_282_14
			end

			local var_282_15 = 0
			local var_282_16 = 1.225

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_17 = arg_279_1:GetWordFromCfg(302051068)
				local var_282_18 = arg_279_1:FormatText(var_282_17.content)

				arg_279_1.text_.text = var_282_18

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_19 = 49
				local var_282_20 = utf8.len(var_282_18)
				local var_282_21 = var_282_19 <= 0 and var_282_16 or var_282_16 * (var_282_20 / var_282_19)

				if var_282_21 > 0 and var_282_16 < var_282_21 then
					arg_279_1.talkMaxDuration = var_282_21

					if var_282_21 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_21 + var_282_15
					end
				end

				arg_279_1.text_.text = var_282_18
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_22 = math.max(var_282_16, arg_279_1.talkMaxDuration)

			if var_282_15 <= arg_279_1.time_ and arg_279_1.time_ < var_282_15 + var_282_22 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_15) / var_282_22

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_15 + var_282_22 and arg_279_1.time_ < var_282_15 + var_282_22 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play302051069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 302051069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play302051070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.875

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[7].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:GetWordFromCfg(302051069)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 35
				local var_286_6 = utf8.len(var_286_4)
				local var_286_7 = var_286_5 <= 0 and var_286_1 or var_286_1 * (var_286_6 / var_286_5)

				if var_286_7 > 0 and var_286_1 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_8 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_8 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_8

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_8 and arg_283_1.time_ < var_286_0 + var_286_8 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play302051070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 302051070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play302051071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 0.8

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_2 = arg_287_1:GetWordFromCfg(302051070)
				local var_290_3 = arg_287_1:FormatText(var_290_2.content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 32
				local var_290_5 = utf8.len(var_290_3)
				local var_290_6 = var_290_4 <= 0 and var_290_1 or var_290_1 * (var_290_5 / var_290_4)

				if var_290_6 > 0 and var_290_1 < var_290_6 then
					arg_287_1.talkMaxDuration = var_290_6

					if var_290_6 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_6 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_7 and arg_287_1.time_ < var_290_0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play302051071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 302051071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play302051072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 0.9

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[7].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:GetWordFromCfg(302051071)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 36
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_8 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_8 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_8

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_8 and arg_291_1.time_ < var_294_0 + var_294_8 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play302051072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 302051072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play302051073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.275

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[7].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(302051072)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 11
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_8 and arg_295_1.time_ < var_298_0 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play302051073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 302051073
		arg_299_1.duration_ = 2.37

		local var_299_0 = {
			zh = 2.266,
			ja = 2.366
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
				arg_299_0:Play302051074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1080ui_story"].transform
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.var_.moveOldPos1080ui_story = var_302_0.localPosition
			end

			local var_302_2 = 0.001

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2
				local var_302_4 = Vector3.New(0, -1.01, -6.05)

				var_302_0.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1080ui_story, var_302_4, var_302_3)

				local var_302_5 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_5.x, var_302_5.y, var_302_5.z)

				local var_302_6 = var_302_0.localEulerAngles

				var_302_6.z = 0
				var_302_6.x = 0
				var_302_0.localEulerAngles = var_302_6
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 then
				var_302_0.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_302_7 = manager.ui.mainCamera.transform.position - var_302_0.position

				var_302_0.forward = Vector3.New(var_302_7.x, var_302_7.y, var_302_7.z)

				local var_302_8 = var_302_0.localEulerAngles

				var_302_8.z = 0
				var_302_8.x = 0
				var_302_0.localEulerAngles = var_302_8
			end

			local var_302_9 = arg_299_1.actors_["1080ui_story"]
			local var_302_10 = 0

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1080ui_story == nil then
				arg_299_1.var_.characterEffect1080ui_story = var_302_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_11 = 0.200000002980232

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_11 and not isNil(var_302_9) then
				local var_302_12 = (arg_299_1.time_ - var_302_10) / var_302_11

				if arg_299_1.var_.characterEffect1080ui_story and not isNil(var_302_9) then
					arg_299_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_10 + var_302_11 and arg_299_1.time_ < var_302_10 + var_302_11 + arg_302_0 and not isNil(var_302_9) and arg_299_1.var_.characterEffect1080ui_story then
				arg_299_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_302_13 = 0

			if var_302_13 < arg_299_1.time_ and arg_299_1.time_ <= var_302_13 + arg_302_0 then
				arg_299_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_302_14 = 0

			if var_302_14 < arg_299_1.time_ and arg_299_1.time_ <= var_302_14 + arg_302_0 then
				arg_299_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_302_15 = 0
			local var_302_16 = 0.15

			if var_302_15 < arg_299_1.time_ and arg_299_1.time_ <= var_302_15 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_17 = arg_299_1:FormatText(StoryNameCfg[55].name)

				arg_299_1.leftNameTxt_.text = var_302_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_18 = arg_299_1:GetWordFromCfg(302051073)
				local var_302_19 = arg_299_1:FormatText(var_302_18.content)

				arg_299_1.text_.text = var_302_19

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_20 = 6
				local var_302_21 = utf8.len(var_302_19)
				local var_302_22 = var_302_20 <= 0 and var_302_16 or var_302_16 * (var_302_21 / var_302_20)

				if var_302_22 > 0 and var_302_16 < var_302_22 then
					arg_299_1.talkMaxDuration = var_302_22

					if var_302_22 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_22 + var_302_15
					end
				end

				arg_299_1.text_.text = var_302_19
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051073", "story_v_out_302051.awb") ~= 0 then
					local var_302_23 = manager.audio:GetVoiceLength("story_v_out_302051", "302051073", "story_v_out_302051.awb") / 1000

					if var_302_23 + var_302_15 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_23 + var_302_15
					end

					if var_302_18.prefab_name ~= "" and arg_299_1.actors_[var_302_18.prefab_name] ~= nil then
						local var_302_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_18.prefab_name].transform, "story_v_out_302051", "302051073", "story_v_out_302051.awb")

						arg_299_1:RecordAudio("302051073", var_302_24)
						arg_299_1:RecordAudio("302051073", var_302_24)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_302051", "302051073", "story_v_out_302051.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_302051", "302051073", "story_v_out_302051.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_25 = math.max(var_302_16, arg_299_1.talkMaxDuration)

			if var_302_15 <= arg_299_1.time_ and arg_299_1.time_ < var_302_15 + var_302_25 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_15) / var_302_25

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_15 + var_302_25 and arg_299_1.time_ < var_302_15 + var_302_25 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
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
	Play302051074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 302051074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play302051075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1080ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1080ui_story == nil then
				arg_303_1.var_.characterEffect1080ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect1080ui_story and not isNil(var_306_0) then
					local var_306_4 = Mathf.Lerp(0, 0.5, var_306_3)

					arg_303_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1080ui_story.fillRatio = var_306_4
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect1080ui_story then
				local var_306_5 = 0.5

				arg_303_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1080ui_story.fillRatio = var_306_5
			end

			local var_306_6 = 0
			local var_306_7 = 0.3

			if var_306_6 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_8 = arg_303_1:FormatText(StoryNameCfg[7].name)

				arg_303_1.leftNameTxt_.text = var_306_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_9 = arg_303_1:GetWordFromCfg(302051074)
				local var_306_10 = arg_303_1:FormatText(var_306_9.content)

				arg_303_1.text_.text = var_306_10

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 12
				local var_306_12 = utf8.len(var_306_10)
				local var_306_13 = var_306_11 <= 0 and var_306_7 or var_306_7 * (var_306_12 / var_306_11)

				if var_306_13 > 0 and var_306_7 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_6
					end
				end

				arg_303_1.text_.text = var_306_10
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_14 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_14 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_14

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_14 and arg_303_1.time_ < var_306_6 + var_306_14 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play302051075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 302051075
		arg_307_1.duration_ = 12.43

		local var_307_0 = {
			zh = 10.633,
			ja = 12.433
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play302051076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1080ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1080ui_story == nil then
				arg_307_1.var_.characterEffect1080ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect1080ui_story and not isNil(var_310_0) then
					arg_307_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1080ui_story then
				arg_307_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_310_4 = 0

			if var_310_4 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_310_5 = 0

			if var_310_5 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_310_6 = 0
			local var_310_7 = 1.025

			if var_310_6 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_8 = arg_307_1:FormatText(StoryNameCfg[55].name)

				arg_307_1.leftNameTxt_.text = var_310_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_9 = arg_307_1:GetWordFromCfg(302051075)
				local var_310_10 = arg_307_1:FormatText(var_310_9.content)

				arg_307_1.text_.text = var_310_10

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 41
				local var_310_12 = utf8.len(var_310_10)
				local var_310_13 = var_310_11 <= 0 and var_310_7 or var_310_7 * (var_310_12 / var_310_11)

				if var_310_13 > 0 and var_310_7 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_10
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051075", "story_v_out_302051.awb") ~= 0 then
					local var_310_14 = manager.audio:GetVoiceLength("story_v_out_302051", "302051075", "story_v_out_302051.awb") / 1000

					if var_310_14 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_14 + var_310_6
					end

					if var_310_9.prefab_name ~= "" and arg_307_1.actors_[var_310_9.prefab_name] ~= nil then
						local var_310_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_9.prefab_name].transform, "story_v_out_302051", "302051075", "story_v_out_302051.awb")

						arg_307_1:RecordAudio("302051075", var_310_15)
						arg_307_1:RecordAudio("302051075", var_310_15)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_302051", "302051075", "story_v_out_302051.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_302051", "302051075", "story_v_out_302051.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_16 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_16 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_16

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_16 and arg_307_1.time_ < var_310_6 + var_310_16 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play302051076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 302051076
		arg_311_1.duration_ = 4.17

		local var_311_0 = {
			zh = 3,
			ja = 4.166
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play302051077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_314_2 = 0
			local var_314_3 = 0.3

			if var_314_2 < arg_311_1.time_ and arg_311_1.time_ <= var_314_2 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_4 = arg_311_1:FormatText(StoryNameCfg[55].name)

				arg_311_1.leftNameTxt_.text = var_314_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_5 = arg_311_1:GetWordFromCfg(302051076)
				local var_314_6 = arg_311_1:FormatText(var_314_5.content)

				arg_311_1.text_.text = var_314_6

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_7 = 12
				local var_314_8 = utf8.len(var_314_6)
				local var_314_9 = var_314_7 <= 0 and var_314_3 or var_314_3 * (var_314_8 / var_314_7)

				if var_314_9 > 0 and var_314_3 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_2
					end
				end

				arg_311_1.text_.text = var_314_6
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051076", "story_v_out_302051.awb") ~= 0 then
					local var_314_10 = manager.audio:GetVoiceLength("story_v_out_302051", "302051076", "story_v_out_302051.awb") / 1000

					if var_314_10 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_2
					end

					if var_314_5.prefab_name ~= "" and arg_311_1.actors_[var_314_5.prefab_name] ~= nil then
						local var_314_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_5.prefab_name].transform, "story_v_out_302051", "302051076", "story_v_out_302051.awb")

						arg_311_1:RecordAudio("302051076", var_314_11)
						arg_311_1:RecordAudio("302051076", var_314_11)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_302051", "302051076", "story_v_out_302051.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_302051", "302051076", "story_v_out_302051.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_12 = math.max(var_314_3, arg_311_1.talkMaxDuration)

			if var_314_2 <= arg_311_1.time_ and arg_311_1.time_ < var_314_2 + var_314_12 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_2) / var_314_12

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_2 + var_314_12 and arg_311_1.time_ < var_314_2 + var_314_12 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play302051077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 302051077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play302051078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1080ui_story"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1080ui_story == nil then
				arg_315_1.var_.characterEffect1080ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect1080ui_story and not isNil(var_318_0) then
					local var_318_4 = Mathf.Lerp(0, 0.5, var_318_3)

					arg_315_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1080ui_story.fillRatio = var_318_4
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect1080ui_story then
				local var_318_5 = 0.5

				arg_315_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1080ui_story.fillRatio = var_318_5
			end

			local var_318_6 = 0
			local var_318_7 = 0.75

			if var_318_6 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_8 = arg_315_1:FormatText(StoryNameCfg[7].name)

				arg_315_1.leftNameTxt_.text = var_318_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_9 = arg_315_1:GetWordFromCfg(302051077)
				local var_318_10 = arg_315_1:FormatText(var_318_9.content)

				arg_315_1.text_.text = var_318_10

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_11 = 30
				local var_318_12 = utf8.len(var_318_10)
				local var_318_13 = var_318_11 <= 0 and var_318_7 or var_318_7 * (var_318_12 / var_318_11)

				if var_318_13 > 0 and var_318_7 < var_318_13 then
					arg_315_1.talkMaxDuration = var_318_13

					if var_318_13 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_13 + var_318_6
					end
				end

				arg_315_1.text_.text = var_318_10
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_14 = math.max(var_318_7, arg_315_1.talkMaxDuration)

			if var_318_6 <= arg_315_1.time_ and arg_315_1.time_ < var_318_6 + var_318_14 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_6) / var_318_14

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_6 + var_318_14 and arg_315_1.time_ < var_318_6 + var_318_14 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play302051078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 302051078
		arg_319_1.duration_ = 6.17

		local var_319_0 = {
			zh = 6.166,
			ja = 5.666
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play302051079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1080ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1080ui_story == nil then
				arg_319_1.var_.characterEffect1080ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect1080ui_story and not isNil(var_322_0) then
					arg_319_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect1080ui_story then
				arg_319_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_322_4 = 0

			if var_322_4 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			local var_322_5 = 0

			if var_322_5 < arg_319_1.time_ and arg_319_1.time_ <= var_322_5 + arg_322_0 then
				arg_319_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_322_6 = 0
			local var_322_7 = 0.625

			if var_322_6 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_8 = arg_319_1:FormatText(StoryNameCfg[55].name)

				arg_319_1.leftNameTxt_.text = var_322_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_9 = arg_319_1:GetWordFromCfg(302051078)
				local var_322_10 = arg_319_1:FormatText(var_322_9.content)

				arg_319_1.text_.text = var_322_10

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_11 = 25
				local var_322_12 = utf8.len(var_322_10)
				local var_322_13 = var_322_11 <= 0 and var_322_7 or var_322_7 * (var_322_12 / var_322_11)

				if var_322_13 > 0 and var_322_7 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_6
					end
				end

				arg_319_1.text_.text = var_322_10
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051078", "story_v_out_302051.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_out_302051", "302051078", "story_v_out_302051.awb") / 1000

					if var_322_14 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_6
					end

					if var_322_9.prefab_name ~= "" and arg_319_1.actors_[var_322_9.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_9.prefab_name].transform, "story_v_out_302051", "302051078", "story_v_out_302051.awb")

						arg_319_1:RecordAudio("302051078", var_322_15)
						arg_319_1:RecordAudio("302051078", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_302051", "302051078", "story_v_out_302051.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_302051", "302051078", "story_v_out_302051.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_7, arg_319_1.talkMaxDuration)

			if var_322_6 <= arg_319_1.time_ and arg_319_1.time_ < var_322_6 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_6) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_6 + var_322_16 and arg_319_1.time_ < var_322_6 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play302051079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 302051079
		arg_323_1.duration_ = 8.9

		local var_323_0 = {
			zh = 6.5,
			ja = 8.9
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play302051080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0

			if var_326_0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_0 + arg_326_0 then
				arg_323_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_326_2 = 0
			local var_326_3 = 0.55

			if var_326_2 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_4 = arg_323_1:FormatText(StoryNameCfg[55].name)

				arg_323_1.leftNameTxt_.text = var_326_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_5 = arg_323_1:GetWordFromCfg(302051079)
				local var_326_6 = arg_323_1:FormatText(var_326_5.content)

				arg_323_1.text_.text = var_326_6

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_7 = 22
				local var_326_8 = utf8.len(var_326_6)
				local var_326_9 = var_326_7 <= 0 and var_326_3 or var_326_3 * (var_326_8 / var_326_7)

				if var_326_9 > 0 and var_326_3 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_6
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051079", "story_v_out_302051.awb") ~= 0 then
					local var_326_10 = manager.audio:GetVoiceLength("story_v_out_302051", "302051079", "story_v_out_302051.awb") / 1000

					if var_326_10 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_2
					end

					if var_326_5.prefab_name ~= "" and arg_323_1.actors_[var_326_5.prefab_name] ~= nil then
						local var_326_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_5.prefab_name].transform, "story_v_out_302051", "302051079", "story_v_out_302051.awb")

						arg_323_1:RecordAudio("302051079", var_326_11)
						arg_323_1:RecordAudio("302051079", var_326_11)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_302051", "302051079", "story_v_out_302051.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_302051", "302051079", "story_v_out_302051.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_3, arg_323_1.talkMaxDuration)

			if var_326_2 <= arg_323_1.time_ and arg_323_1.time_ < var_326_2 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_2) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_2 + var_326_12 and arg_323_1.time_ < var_326_2 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play302051080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 302051080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play302051081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1080ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1080ui_story == nil then
				arg_327_1.var_.characterEffect1080ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect1080ui_story and not isNil(var_330_0) then
					local var_330_4 = Mathf.Lerp(0, 0.5, var_330_3)

					arg_327_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1080ui_story.fillRatio = var_330_4
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1080ui_story then
				local var_330_5 = 0.5

				arg_327_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1080ui_story.fillRatio = var_330_5
			end

			local var_330_6 = 0
			local var_330_7 = 0.3

			if var_330_6 < arg_327_1.time_ and arg_327_1.time_ <= var_330_6 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_8 = arg_327_1:FormatText(StoryNameCfg[7].name)

				arg_327_1.leftNameTxt_.text = var_330_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_9 = arg_327_1:GetWordFromCfg(302051080)
				local var_330_10 = arg_327_1:FormatText(var_330_9.content)

				arg_327_1.text_.text = var_330_10

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_11 = 12
				local var_330_12 = utf8.len(var_330_10)
				local var_330_13 = var_330_11 <= 0 and var_330_7 or var_330_7 * (var_330_12 / var_330_11)

				if var_330_13 > 0 and var_330_7 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_6 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_6
					end
				end

				arg_327_1.text_.text = var_330_10
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_14 = math.max(var_330_7, arg_327_1.talkMaxDuration)

			if var_330_6 <= arg_327_1.time_ and arg_327_1.time_ < var_330_6 + var_330_14 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_6) / var_330_14

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_6 + var_330_14 and arg_327_1.time_ < var_330_6 + var_330_14 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play302051081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 302051081
		arg_331_1.duration_ = 2.7

		local var_331_0 = {
			zh = 2.7,
			ja = 1.999999999999
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
			arg_331_1.auto_ = false
		end

		function arg_331_1.playNext_(arg_333_0)
			arg_331_1.onStoryFinished_()
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1080ui_story"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1080ui_story == nil then
				arg_331_1.var_.characterEffect1080ui_story = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect1080ui_story and not isNil(var_334_0) then
					arg_331_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1080ui_story then
				arg_331_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_334_4 = 0

			if var_334_4 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			local var_334_5 = 0

			if var_334_5 < arg_331_1.time_ and arg_331_1.time_ <= var_334_5 + arg_334_0 then
				arg_331_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_334_6 = 0
			local var_334_7 = 0.2

			if var_334_6 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_8 = arg_331_1:FormatText(StoryNameCfg[55].name)

				arg_331_1.leftNameTxt_.text = var_334_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_9 = arg_331_1:GetWordFromCfg(302051081)
				local var_334_10 = arg_331_1:FormatText(var_334_9.content)

				arg_331_1.text_.text = var_334_10

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 8
				local var_334_12 = utf8.len(var_334_10)
				local var_334_13 = var_334_11 <= 0 and var_334_7 or var_334_7 * (var_334_12 / var_334_11)

				if var_334_13 > 0 and var_334_7 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_10
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302051", "302051081", "story_v_out_302051.awb") ~= 0 then
					local var_334_14 = manager.audio:GetVoiceLength("story_v_out_302051", "302051081", "story_v_out_302051.awb") / 1000

					if var_334_14 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_6
					end

					if var_334_9.prefab_name ~= "" and arg_331_1.actors_[var_334_9.prefab_name] ~= nil then
						local var_334_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_9.prefab_name].transform, "story_v_out_302051", "302051081", "story_v_out_302051.awb")

						arg_331_1:RecordAudio("302051081", var_334_15)
						arg_331_1:RecordAudio("302051081", var_334_15)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_302051", "302051081", "story_v_out_302051.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_302051", "302051081", "story_v_out_302051.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_16 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_16 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_16

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_16 and arg_331_1.time_ < var_334_6 + var_334_16 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I28f",
		"TextureConfig/Background/I05d",
		"TextureConfig/Background/I05"
	},
	voices = {
		"story_v_out_302051.awb"
	}
}
