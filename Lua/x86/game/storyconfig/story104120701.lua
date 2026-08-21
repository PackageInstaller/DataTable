return {
	Play412071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412071001
		arg_1_1.duration_ = 4.57

		local var_1_0 = {
			zh = 4.56600000298023,
			ja = 3.899999999999
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
				arg_1_0:Play412071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST85b"

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
				local var_4_5 = arg_1_1.bgs_.ST85b

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
					if iter_4_0 ~= "ST85b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2.00000000298023

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

			local var_4_24 = "1097ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1097ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1097ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(-0.7, -0.54, -6.3)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1097ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1097ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1097ui_story == nil then
				arg_1_1.var_.characterEffect1097ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1097ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1097ui_story then
				arg_1_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_4_44 = 0
			local var_4_45 = 0.233333333333333

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

			local var_4_50 = 0.266666666666667
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_56 = 2.00000000298023
			local var_4_57 = 0.25

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[216].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(412071001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 10
				local var_4_63 = utf8.len(var_4_61)
				local var_4_64 = var_4_62 <= 0 and var_4_57 or var_4_57 * (var_4_63 / var_4_62)

				if var_4_64 > 0 and var_4_57 < var_4_64 then
					arg_1_1.talkMaxDuration = var_4_64
					var_4_56 = var_4_56 + 0.3

					if var_4_64 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_64 + var_4_56
					end
				end

				arg_1_1.text_.text = var_4_61
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071001", "story_v_out_412071.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_412071", "412071001", "story_v_out_412071.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_412071", "412071001", "story_v_out_412071.awb")

						arg_1_1:RecordAudio("412071001", var_4_66)
						arg_1_1:RecordAudio("412071001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_412071", "412071001", "story_v_out_412071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_412071", "412071001", "story_v_out_412071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_67 = var_4_56 + 0.3
			local var_4_68 = math.max(var_4_57, arg_1_1.talkMaxDuration)

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_67) / var_4_68

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412071002
		arg_9_1.duration_ = 2.2

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_9_0:Play412071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10078ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "10078ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["10078ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos10078ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0.7, -0.5, -6.3)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10078ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["10078ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10078ui_story == nil then
				arg_9_1.var_.characterEffect10078ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect10078ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10078ui_story then
				arg_9_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = arg_9_1.actors_["1097ui_story"]
			local var_12_21 = 0

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 and not isNil(var_12_20) and arg_9_1.var_.characterEffect1097ui_story == nil then
				arg_9_1.var_.characterEffect1097ui_story = var_12_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_22 = 0.200000002980232

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_22 and not isNil(var_12_20) then
				local var_12_23 = (arg_9_1.time_ - var_12_21) / var_12_22

				if arg_9_1.var_.characterEffect1097ui_story and not isNil(var_12_20) then
					local var_12_24 = Mathf.Lerp(0, 0.5, var_12_23)

					arg_9_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1097ui_story.fillRatio = var_12_24
				end
			end

			if arg_9_1.time_ >= var_12_21 + var_12_22 and arg_9_1.time_ < var_12_21 + var_12_22 + arg_12_0 and not isNil(var_12_20) and arg_9_1.var_.characterEffect1097ui_story then
				local var_12_25 = 0.5

				arg_9_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1097ui_story.fillRatio = var_12_25
			end

			local var_12_26 = 0
			local var_12_27 = 0.05

			if var_12_26 < arg_9_1.time_ and arg_9_1.time_ <= var_12_26 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_28 = arg_9_1:FormatText(StoryNameCfg[919].name)

				arg_9_1.leftNameTxt_.text = var_12_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_29 = arg_9_1:GetWordFromCfg(412071002)
				local var_12_30 = arg_9_1:FormatText(var_12_29.content)

				arg_9_1.text_.text = var_12_30

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_31 = 2
				local var_12_32 = utf8.len(var_12_30)
				local var_12_33 = var_12_31 <= 0 and var_12_27 or var_12_27 * (var_12_32 / var_12_31)

				if var_12_33 > 0 and var_12_27 < var_12_33 then
					arg_9_1.talkMaxDuration = var_12_33

					if var_12_33 + var_12_26 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_33 + var_12_26
					end
				end

				arg_9_1.text_.text = var_12_30
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071002", "story_v_out_412071.awb") ~= 0 then
					local var_12_34 = manager.audio:GetVoiceLength("story_v_out_412071", "412071002", "story_v_out_412071.awb") / 1000

					if var_12_34 + var_12_26 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_34 + var_12_26
					end

					if var_12_29.prefab_name ~= "" and arg_9_1.actors_[var_12_29.prefab_name] ~= nil then
						local var_12_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_29.prefab_name].transform, "story_v_out_412071", "412071002", "story_v_out_412071.awb")

						arg_9_1:RecordAudio("412071002", var_12_35)
						arg_9_1:RecordAudio("412071002", var_12_35)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_412071", "412071002", "story_v_out_412071.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_412071", "412071002", "story_v_out_412071.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_36 = math.max(var_12_27, arg_9_1.talkMaxDuration)

			if var_12_26 <= arg_9_1.time_ and arg_9_1.time_ < var_12_26 + var_12_36 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_26) / var_12_36

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_26 + var_12_36 and arg_9_1.time_ < var_12_26 + var_12_36 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412071003
		arg_13_1.duration_ = 10.63

		local var_13_0 = {
			zh = 7.9,
			ja = 10.633
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
				arg_13_0:Play412071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1097ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1097ui_story == nil then
				arg_13_1.var_.characterEffect1097ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1097ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1097ui_story then
				arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_16_4 = 0

			if var_16_4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_6 = arg_13_1.actors_["10078ui_story"]
			local var_16_7 = 0

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.characterEffect10078ui_story == nil then
				arg_13_1.var_.characterEffect10078ui_story = var_16_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_8 and not isNil(var_16_6) then
				local var_16_9 = (arg_13_1.time_ - var_16_7) / var_16_8

				if arg_13_1.var_.characterEffect10078ui_story and not isNil(var_16_6) then
					local var_16_10 = Mathf.Lerp(0, 0.5, var_16_9)

					arg_13_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10078ui_story.fillRatio = var_16_10
				end
			end

			if arg_13_1.time_ >= var_16_7 + var_16_8 and arg_13_1.time_ < var_16_7 + var_16_8 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.characterEffect10078ui_story then
				local var_16_11 = 0.5

				arg_13_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10078ui_story.fillRatio = var_16_11
			end

			local var_16_12 = 0
			local var_16_13 = 0.675

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_14 = arg_13_1:FormatText(StoryNameCfg[216].name)

				arg_13_1.leftNameTxt_.text = var_16_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:GetWordFromCfg(412071003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 27
				local var_16_18 = utf8.len(var_16_16)
				local var_16_19 = var_16_17 <= 0 and var_16_13 or var_16_13 * (var_16_18 / var_16_17)

				if var_16_19 > 0 and var_16_13 < var_16_19 then
					arg_13_1.talkMaxDuration = var_16_19

					if var_16_19 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_16
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071003", "story_v_out_412071.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_412071", "412071003", "story_v_out_412071.awb") / 1000

					if var_16_20 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_12
					end

					if var_16_15.prefab_name ~= "" and arg_13_1.actors_[var_16_15.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_15.prefab_name].transform, "story_v_out_412071", "412071003", "story_v_out_412071.awb")

						arg_13_1:RecordAudio("412071003", var_16_21)
						arg_13_1:RecordAudio("412071003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412071", "412071003", "story_v_out_412071.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412071", "412071003", "story_v_out_412071.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_22 and arg_13_1.time_ < var_16_12 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play412071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412071004
		arg_17_1.duration_ = 7.17

		local var_17_0 = {
			zh = 7.1,
			ja = 7.166
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
				arg_17_0:Play412071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10078ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10078ui_story == nil then
				arg_17_1.var_.characterEffect10078ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10078ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10078ui_story then
				arg_17_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_20_4 = 0

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_6 = arg_17_1.actors_["1097ui_story"]
			local var_20_7 = 0

			if var_20_7 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1097ui_story == nil then
				arg_17_1.var_.characterEffect1097ui_story = var_20_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.200000002980232

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_8 and not isNil(var_20_6) then
				local var_20_9 = (arg_17_1.time_ - var_20_7) / var_20_8

				if arg_17_1.var_.characterEffect1097ui_story and not isNil(var_20_6) then
					local var_20_10 = Mathf.Lerp(0, 0.5, var_20_9)

					arg_17_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1097ui_story.fillRatio = var_20_10
				end
			end

			if arg_17_1.time_ >= var_20_7 + var_20_8 and arg_17_1.time_ < var_20_7 + var_20_8 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1097ui_story then
				local var_20_11 = 0.5

				arg_17_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1097ui_story.fillRatio = var_20_11
			end

			local var_20_12 = 0
			local var_20_13 = 0.55

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_14 = arg_17_1:FormatText(StoryNameCfg[919].name)

				arg_17_1.leftNameTxt_.text = var_20_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_15 = arg_17_1:GetWordFromCfg(412071004)
				local var_20_16 = arg_17_1:FormatText(var_20_15.content)

				arg_17_1.text_.text = var_20_16

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 22
				local var_20_18 = utf8.len(var_20_16)
				local var_20_19 = var_20_17 <= 0 and var_20_13 or var_20_13 * (var_20_18 / var_20_17)

				if var_20_19 > 0 and var_20_13 < var_20_19 then
					arg_17_1.talkMaxDuration = var_20_19

					if var_20_19 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_19 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_16
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071004", "story_v_out_412071.awb") ~= 0 then
					local var_20_20 = manager.audio:GetVoiceLength("story_v_out_412071", "412071004", "story_v_out_412071.awb") / 1000

					if var_20_20 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_20 + var_20_12
					end

					if var_20_15.prefab_name ~= "" and arg_17_1.actors_[var_20_15.prefab_name] ~= nil then
						local var_20_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_15.prefab_name].transform, "story_v_out_412071", "412071004", "story_v_out_412071.awb")

						arg_17_1:RecordAudio("412071004", var_20_21)
						arg_17_1:RecordAudio("412071004", var_20_21)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_412071", "412071004", "story_v_out_412071.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_412071", "412071004", "story_v_out_412071.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_22 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_22 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_22

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_22 and arg_17_1.time_ < var_20_12 + var_20_22 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play412071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412071005
		arg_21_1.duration_ = 7.3

		local var_21_0 = {
			zh = 7.3,
			ja = 5.533
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
				arg_21_0:Play412071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.5

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[919].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(412071005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 20
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071005", "story_v_out_412071.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_412071", "412071005", "story_v_out_412071.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_412071", "412071005", "story_v_out_412071.awb")

						arg_21_1:RecordAudio("412071005", var_24_9)
						arg_21_1:RecordAudio("412071005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_412071", "412071005", "story_v_out_412071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_412071", "412071005", "story_v_out_412071.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play412071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 412071006
		arg_25_1.duration_ = 8.5

		local var_25_0 = {
			zh = 6.333,
			ja = 8.5
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
				arg_25_0:Play412071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1097ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1097ui_story == nil then
				arg_25_1.var_.characterEffect1097ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1097ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1097ui_story then
				arg_25_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_6 = arg_25_1.actors_["10078ui_story"]
			local var_28_7 = 0

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10078ui_story == nil then
				arg_25_1.var_.characterEffect10078ui_story = var_28_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_8 and not isNil(var_28_6) then
				local var_28_9 = (arg_25_1.time_ - var_28_7) / var_28_8

				if arg_25_1.var_.characterEffect10078ui_story and not isNil(var_28_6) then
					local var_28_10 = Mathf.Lerp(0, 0.5, var_28_9)

					arg_25_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10078ui_story.fillRatio = var_28_10
				end
			end

			if arg_25_1.time_ >= var_28_7 + var_28_8 and arg_25_1.time_ < var_28_7 + var_28_8 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10078ui_story then
				local var_28_11 = 0.5

				arg_25_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10078ui_story.fillRatio = var_28_11
			end

			local var_28_12 = 0
			local var_28_13 = 0.575

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_14 = arg_25_1:FormatText(StoryNameCfg[216].name)

				arg_25_1.leftNameTxt_.text = var_28_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_15 = arg_25_1:GetWordFromCfg(412071006)
				local var_28_16 = arg_25_1:FormatText(var_28_15.content)

				arg_25_1.text_.text = var_28_16

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 23
				local var_28_18 = utf8.len(var_28_16)
				local var_28_19 = var_28_17 <= 0 and var_28_13 or var_28_13 * (var_28_18 / var_28_17)

				if var_28_19 > 0 and var_28_13 < var_28_19 then
					arg_25_1.talkMaxDuration = var_28_19

					if var_28_19 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_12
					end
				end

				arg_25_1.text_.text = var_28_16
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071006", "story_v_out_412071.awb") ~= 0 then
					local var_28_20 = manager.audio:GetVoiceLength("story_v_out_412071", "412071006", "story_v_out_412071.awb") / 1000

					if var_28_20 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_20 + var_28_12
					end

					if var_28_15.prefab_name ~= "" and arg_25_1.actors_[var_28_15.prefab_name] ~= nil then
						local var_28_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_15.prefab_name].transform, "story_v_out_412071", "412071006", "story_v_out_412071.awb")

						arg_25_1:RecordAudio("412071006", var_28_21)
						arg_25_1:RecordAudio("412071006", var_28_21)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_412071", "412071006", "story_v_out_412071.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_412071", "412071006", "story_v_out_412071.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_13, arg_25_1.talkMaxDuration)

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_12) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_12 + var_28_22 and arg_25_1.time_ < var_28_12 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play412071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 412071007
		arg_29_1.duration_ = 6.9

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play412071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "STwhite"

			if arg_29_1.bgs_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_0)
				var_32_1.name = var_32_0
				var_32_1.transform.parent = arg_29_1.stage_.transform
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_0] = var_32_1
			end

			local var_32_2 = 1

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.STwhite

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
					if iter_32_0 ~= "STwhite" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = arg_29_1.actors_["1097ui_story"].transform
			local var_32_17 = 0.965999998152256

			if var_32_17 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = var_32_16.localPosition
			end

			local var_32_18 = 0.001

			if var_32_17 <= arg_29_1.time_ and arg_29_1.time_ < var_32_17 + var_32_18 then
				local var_32_19 = (arg_29_1.time_ - var_32_17) / var_32_18
				local var_32_20 = Vector3.New(0, 100, 0)

				var_32_16.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, var_32_20, var_32_19)

				local var_32_21 = manager.ui.mainCamera.transform.position - var_32_16.position

				var_32_16.forward = Vector3.New(var_32_21.x, var_32_21.y, var_32_21.z)

				local var_32_22 = var_32_16.localEulerAngles

				var_32_22.z = 0
				var_32_22.x = 0
				var_32_16.localEulerAngles = var_32_22
			end

			if arg_29_1.time_ >= var_32_17 + var_32_18 and arg_29_1.time_ < var_32_17 + var_32_18 + arg_32_0 then
				var_32_16.localPosition = Vector3.New(0, 100, 0)

				local var_32_23 = manager.ui.mainCamera.transform.position - var_32_16.position

				var_32_16.forward = Vector3.New(var_32_23.x, var_32_23.y, var_32_23.z)

				local var_32_24 = var_32_16.localEulerAngles

				var_32_24.z = 0
				var_32_24.x = 0
				var_32_16.localEulerAngles = var_32_24
			end

			local var_32_25 = arg_29_1.actors_["1097ui_story"]
			local var_32_26 = 0.965999998152256

			if var_32_26 < arg_29_1.time_ and arg_29_1.time_ <= var_32_26 + arg_32_0 and not isNil(var_32_25) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_27 = 0.034000001847744

			if var_32_26 <= arg_29_1.time_ and arg_29_1.time_ < var_32_26 + var_32_27 and not isNil(var_32_25) then
				local var_32_28 = (arg_29_1.time_ - var_32_26) / var_32_27

				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_25) then
					local var_32_29 = Mathf.Lerp(0, 0.5, var_32_28)

					arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1097ui_story.fillRatio = var_32_29
				end
			end

			if arg_29_1.time_ >= var_32_26 + var_32_27 and arg_29_1.time_ < var_32_26 + var_32_27 + arg_32_0 and not isNil(var_32_25) and arg_29_1.var_.characterEffect1097ui_story then
				local var_32_30 = 0.5

				arg_29_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1097ui_story.fillRatio = var_32_30
			end

			local var_32_31 = arg_29_1.actors_["10078ui_story"].transform
			local var_32_32 = 0.965999998152256

			if var_32_32 < arg_29_1.time_ and arg_29_1.time_ <= var_32_32 + arg_32_0 then
				arg_29_1.var_.moveOldPos10078ui_story = var_32_31.localPosition
			end

			local var_32_33 = 0.001

			if var_32_32 <= arg_29_1.time_ and arg_29_1.time_ < var_32_32 + var_32_33 then
				local var_32_34 = (arg_29_1.time_ - var_32_32) / var_32_33
				local var_32_35 = Vector3.New(0, 100, 0)

				var_32_31.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10078ui_story, var_32_35, var_32_34)

				local var_32_36 = manager.ui.mainCamera.transform.position - var_32_31.position

				var_32_31.forward = Vector3.New(var_32_36.x, var_32_36.y, var_32_36.z)

				local var_32_37 = var_32_31.localEulerAngles

				var_32_37.z = 0
				var_32_37.x = 0
				var_32_31.localEulerAngles = var_32_37
			end

			if arg_29_1.time_ >= var_32_32 + var_32_33 and arg_29_1.time_ < var_32_32 + var_32_33 + arg_32_0 then
				var_32_31.localPosition = Vector3.New(0, 100, 0)

				local var_32_38 = manager.ui.mainCamera.transform.position - var_32_31.position

				var_32_31.forward = Vector3.New(var_32_38.x, var_32_38.y, var_32_38.z)

				local var_32_39 = var_32_31.localEulerAngles

				var_32_39.z = 0
				var_32_39.x = 0
				var_32_31.localEulerAngles = var_32_39
			end

			local var_32_40 = arg_29_1.actors_["10078ui_story"]
			local var_32_41 = 0.965999998152256

			if var_32_41 < arg_29_1.time_ and arg_29_1.time_ <= var_32_41 + arg_32_0 and not isNil(var_32_40) and arg_29_1.var_.characterEffect10078ui_story == nil then
				arg_29_1.var_.characterEffect10078ui_story = var_32_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_42 = 0.034000001847744

			if var_32_41 <= arg_29_1.time_ and arg_29_1.time_ < var_32_41 + var_32_42 and not isNil(var_32_40) then
				local var_32_43 = (arg_29_1.time_ - var_32_41) / var_32_42

				if arg_29_1.var_.characterEffect10078ui_story and not isNil(var_32_40) then
					local var_32_44 = Mathf.Lerp(0, 0.5, var_32_43)

					arg_29_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10078ui_story.fillRatio = var_32_44
				end
			end

			if arg_29_1.time_ >= var_32_41 + var_32_42 and arg_29_1.time_ < var_32_41 + var_32_42 + arg_32_0 and not isNil(var_32_40) and arg_29_1.var_.characterEffect10078ui_story then
				local var_32_45 = 0.5

				arg_29_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10078ui_story.fillRatio = var_32_45
			end

			local var_32_46 = 0

			if var_32_46 < arg_29_1.time_ and arg_29_1.time_ <= var_32_46 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_47 = 1

			if var_32_46 <= arg_29_1.time_ and arg_29_1.time_ < var_32_46 + var_32_47 then
				local var_32_48 = (arg_29_1.time_ - var_32_46) / var_32_47
				local var_32_49 = Color.New(1, 1, 1)

				var_32_49.a = Mathf.Lerp(0, 1, var_32_48)
				arg_29_1.mask_.color = var_32_49
			end

			if arg_29_1.time_ >= var_32_46 + var_32_47 and arg_29_1.time_ < var_32_46 + var_32_47 + arg_32_0 then
				local var_32_50 = Color.New(1, 1, 1)

				var_32_50.a = 1
				arg_29_1.mask_.color = var_32_50
			end

			local var_32_51 = 1

			if var_32_51 < arg_29_1.time_ and arg_29_1.time_ <= var_32_51 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_52 = 1

			if var_32_51 <= arg_29_1.time_ and arg_29_1.time_ < var_32_51 + var_32_52 then
				local var_32_53 = (arg_29_1.time_ - var_32_51) / var_32_52
				local var_32_54 = Color.New(1, 1, 1)

				var_32_54.a = Mathf.Lerp(1, 0, var_32_53)
				arg_29_1.mask_.color = var_32_54
			end

			if arg_29_1.time_ >= var_32_51 + var_32_52 and arg_29_1.time_ < var_32_51 + var_32_52 + arg_32_0 then
				local var_32_55 = Color.New(1, 1, 1)
				local var_32_56 = 0

				arg_29_1.mask_.enabled = false
				var_32_55.a = var_32_56
				arg_29_1.mask_.color = var_32_55
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_57 = 1.9
			local var_32_58 = 1.025

			if var_32_57 < arg_29_1.time_ and arg_29_1.time_ <= var_32_57 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_59 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_59:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_60 = arg_29_1:GetWordFromCfg(412071007)
				local var_32_61 = arg_29_1:FormatText(var_32_60.content)

				arg_29_1.text_.text = var_32_61

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_62 = 40
				local var_32_63 = utf8.len(var_32_61)
				local var_32_64 = var_32_62 <= 0 and var_32_58 or var_32_58 * (var_32_63 / var_32_62)

				if var_32_64 > 0 and var_32_58 < var_32_64 then
					arg_29_1.talkMaxDuration = var_32_64
					var_32_57 = var_32_57 + 0.3

					if var_32_64 + var_32_57 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_64 + var_32_57
					end
				end

				arg_29_1.text_.text = var_32_61
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_65 = var_32_57 + 0.3
			local var_32_66 = math.max(var_32_58, arg_29_1.talkMaxDuration)

			if var_32_65 <= arg_29_1.time_ and arg_29_1.time_ < var_32_65 + var_32_66 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_65) / var_32_66

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_65 + var_32_66 and arg_29_1.time_ < var_32_65 + var_32_66 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play412071008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 412071008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play412071009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.375

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_2 = arg_35_1:GetWordFromCfg(412071008)
				local var_38_3 = arg_35_1:FormatText(var_38_2.content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 15
				local var_38_5 = utf8.len(var_38_3)
				local var_38_6 = var_38_4 <= 0 and var_38_1 or var_38_1 * (var_38_5 / var_38_4)

				if var_38_6 > 0 and var_38_1 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_7 and arg_35_1.time_ < var_38_0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play412071009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 412071009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play412071010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.65

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_2 = arg_39_1:GetWordFromCfg(412071009)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 26
				local var_42_5 = utf8.len(var_42_3)
				local var_42_6 = var_42_4 <= 0 and var_42_1 or var_42_1 * (var_42_5 / var_42_4)

				if var_42_6 > 0 and var_42_1 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_7 and arg_39_1.time_ < var_42_0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play412071010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 412071010
		arg_43_1.duration_ = 4

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play412071011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1097ui_story"].transform
			local var_46_1 = 2

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1097ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1097ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["1097ui_story"]
			local var_46_10 = 2

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1097ui_story == nil then
				arg_43_1.var_.characterEffect1097ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 and not isNil(var_46_9) then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect1097ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1097ui_story then
				arg_43_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_46_13 = 2

			if var_46_13 < arg_43_1.time_ and arg_43_1.time_ <= var_46_13 + arg_46_0 then
				arg_43_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_46_14 = 2

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_15 = 0

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				local var_46_16 = manager.ui.mainCamera.transform.localPosition
				local var_46_17 = Vector3.New(0, 0, 10) + Vector3.New(var_46_16.x, var_46_16.y, 0)
				local var_46_18 = arg_43_1.bgs_.ST85b

				var_46_18.transform.localPosition = var_46_17
				var_46_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_19 = var_46_18:GetComponent("SpriteRenderer")

				if var_46_19 and var_46_19.sprite then
					local var_46_20 = (var_46_18.transform.localPosition - var_46_16).z
					local var_46_21 = manager.ui.mainCameraCom_
					local var_46_22 = 2 * var_46_20 * Mathf.Tan(var_46_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_46_23 = var_46_22 * var_46_21.aspect
					local var_46_24 = var_46_19.sprite.bounds.size.x
					local var_46_25 = var_46_19.sprite.bounds.size.y
					local var_46_26 = var_46_23 / var_46_24
					local var_46_27 = var_46_22 / var_46_25
					local var_46_28 = var_46_27 < var_46_26 and var_46_26 or var_46_27

					var_46_18.transform.localScale = Vector3.New(var_46_28, var_46_28, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "ST85b" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_29 = 0

			if var_46_29 < arg_43_1.time_ and arg_43_1.time_ <= var_46_29 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_30 = 2

			if var_46_29 <= arg_43_1.time_ and arg_43_1.time_ < var_46_29 + var_46_30 then
				local var_46_31 = (arg_43_1.time_ - var_46_29) / var_46_30
				local var_46_32 = Color.New(1, 1, 1)

				var_46_32.a = Mathf.Lerp(1, 0, var_46_31)
				arg_43_1.mask_.color = var_46_32
			end

			if arg_43_1.time_ >= var_46_29 + var_46_30 and arg_43_1.time_ < var_46_29 + var_46_30 + arg_46_0 then
				local var_46_33 = Color.New(1, 1, 1)
				local var_46_34 = 0

				arg_43_1.mask_.enabled = false
				var_46_33.a = var_46_34
				arg_43_1.mask_.color = var_46_33
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_35 = 2
			local var_46_36 = 0.125

			if var_46_35 < arg_43_1.time_ and arg_43_1.time_ <= var_46_35 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_37 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_37:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_38 = arg_43_1:FormatText(StoryNameCfg[216].name)

				arg_43_1.leftNameTxt_.text = var_46_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_39 = arg_43_1:GetWordFromCfg(412071010)
				local var_46_40 = arg_43_1:FormatText(var_46_39.content)

				arg_43_1.text_.text = var_46_40

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_41 = 5
				local var_46_42 = utf8.len(var_46_40)
				local var_46_43 = var_46_41 <= 0 and var_46_36 or var_46_36 * (var_46_42 / var_46_41)

				if var_46_43 > 0 and var_46_36 < var_46_43 then
					arg_43_1.talkMaxDuration = var_46_43
					var_46_35 = var_46_35 + 0.3

					if var_46_43 + var_46_35 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_43 + var_46_35
					end
				end

				arg_43_1.text_.text = var_46_40
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071010", "story_v_out_412071.awb") ~= 0 then
					local var_46_44 = manager.audio:GetVoiceLength("story_v_out_412071", "412071010", "story_v_out_412071.awb") / 1000

					if var_46_44 + var_46_35 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_44 + var_46_35
					end

					if var_46_39.prefab_name ~= "" and arg_43_1.actors_[var_46_39.prefab_name] ~= nil then
						local var_46_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_39.prefab_name].transform, "story_v_out_412071", "412071010", "story_v_out_412071.awb")

						arg_43_1:RecordAudio("412071010", var_46_45)
						arg_43_1:RecordAudio("412071010", var_46_45)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_412071", "412071010", "story_v_out_412071.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_412071", "412071010", "story_v_out_412071.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_46 = var_46_35 + 0.3
			local var_46_47 = math.max(var_46_36, arg_43_1.talkMaxDuration)

			if var_46_46 <= arg_43_1.time_ and arg_43_1.time_ < var_46_46 + var_46_47 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_46) / var_46_47

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_46 + var_46_47 and arg_43_1.time_ < var_46_46 + var_46_47 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play412071011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 412071011
		arg_49_1.duration_ = 7.77

		local var_49_0 = {
			zh = 7.766,
			ja = 6.8
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
				arg_49_0:Play412071012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10078ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10078ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0.7, -0.5, -6.3)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10078ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["10078ui_story"]
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10078ui_story == nil then
				arg_49_1.var_.characterEffect10078ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_11 = 0.200000002980232

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 and not isNil(var_52_9) then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11

				if arg_49_1.var_.characterEffect10078ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10078ui_story then
				arg_49_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_52_13 = 0

			if var_52_13 < arg_49_1.time_ and arg_49_1.time_ <= var_52_13 + arg_52_0 then
				arg_49_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_52_14 = 0

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_15 = arg_49_1.actors_["1097ui_story"]
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.characterEffect1097ui_story == nil then
				arg_49_1.var_.characterEffect1097ui_story = var_52_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_17 = 0.200000002980232

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 and not isNil(var_52_15) then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17

				if arg_49_1.var_.characterEffect1097ui_story and not isNil(var_52_15) then
					local var_52_19 = Mathf.Lerp(0, 0.5, var_52_18)

					arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1097ui_story.fillRatio = var_52_19
				end
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.characterEffect1097ui_story then
				local var_52_20 = 0.5

				arg_49_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1097ui_story.fillRatio = var_52_20
			end

			local var_52_21 = 0
			local var_52_22 = 0.6

			if var_52_21 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_23 = arg_49_1:FormatText(StoryNameCfg[919].name)

				arg_49_1.leftNameTxt_.text = var_52_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_24 = arg_49_1:GetWordFromCfg(412071011)
				local var_52_25 = arg_49_1:FormatText(var_52_24.content)

				arg_49_1.text_.text = var_52_25

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_26 = 24
				local var_52_27 = utf8.len(var_52_25)
				local var_52_28 = var_52_26 <= 0 and var_52_22 or var_52_22 * (var_52_27 / var_52_26)

				if var_52_28 > 0 and var_52_22 < var_52_28 then
					arg_49_1.talkMaxDuration = var_52_28

					if var_52_28 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_28 + var_52_21
					end
				end

				arg_49_1.text_.text = var_52_25
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071011", "story_v_out_412071.awb") ~= 0 then
					local var_52_29 = manager.audio:GetVoiceLength("story_v_out_412071", "412071011", "story_v_out_412071.awb") / 1000

					if var_52_29 + var_52_21 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_29 + var_52_21
					end

					if var_52_24.prefab_name ~= "" and arg_49_1.actors_[var_52_24.prefab_name] ~= nil then
						local var_52_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_24.prefab_name].transform, "story_v_out_412071", "412071011", "story_v_out_412071.awb")

						arg_49_1:RecordAudio("412071011", var_52_30)
						arg_49_1:RecordAudio("412071011", var_52_30)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_412071", "412071011", "story_v_out_412071.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_412071", "412071011", "story_v_out_412071.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_31 = math.max(var_52_22, arg_49_1.talkMaxDuration)

			if var_52_21 <= arg_49_1.time_ and arg_49_1.time_ < var_52_21 + var_52_31 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_21) / var_52_31

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_21 + var_52_31 and arg_49_1.time_ < var_52_21 + var_52_31 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 412071012
		arg_53_1.duration_ = 12.43

		local var_53_0 = {
			zh = 8.433,
			ja = 12.433
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
				arg_53_0:Play412071013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_56_1 = 0
			local var_56_2 = 0.575

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_3 = arg_53_1:FormatText(StoryNameCfg[919].name)

				arg_53_1.leftNameTxt_.text = var_56_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(412071012)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 23
				local var_56_7 = utf8.len(var_56_5)
				local var_56_8 = var_56_6 <= 0 and var_56_2 or var_56_2 * (var_56_7 / var_56_6)

				if var_56_8 > 0 and var_56_2 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071012", "story_v_out_412071.awb") ~= 0 then
					local var_56_9 = manager.audio:GetVoiceLength("story_v_out_412071", "412071012", "story_v_out_412071.awb") / 1000

					if var_56_9 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_1
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_412071", "412071012", "story_v_out_412071.awb")

						arg_53_1:RecordAudio("412071012", var_56_10)
						arg_53_1:RecordAudio("412071012", var_56_10)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_412071", "412071012", "story_v_out_412071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_412071", "412071012", "story_v_out_412071.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_11 and arg_53_1.time_ < var_56_1 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play412071013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 412071013
		arg_57_1.duration_ = 6.9

		local var_57_0 = {
			zh = 6.9,
			ja = 6.766
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
				arg_57_0:Play412071014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1097ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1097ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1097ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["1097ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1097ui_story == nil then
				arg_57_1.var_.characterEffect1097ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect1097ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1097ui_story then
				arg_57_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_15 = arg_57_1.actors_["10078ui_story"]
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 and not isNil(var_60_15) and arg_57_1.var_.characterEffect10078ui_story == nil then
				arg_57_1.var_.characterEffect10078ui_story = var_60_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_17 = 0.200000002980232

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_17 and not isNil(var_60_15) then
				local var_60_18 = (arg_57_1.time_ - var_60_16) / var_60_17

				if arg_57_1.var_.characterEffect10078ui_story and not isNil(var_60_15) then
					local var_60_19 = Mathf.Lerp(0, 0.5, var_60_18)

					arg_57_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10078ui_story.fillRatio = var_60_19
				end
			end

			if arg_57_1.time_ >= var_60_16 + var_60_17 and arg_57_1.time_ < var_60_16 + var_60_17 + arg_60_0 and not isNil(var_60_15) and arg_57_1.var_.characterEffect10078ui_story then
				local var_60_20 = 0.5

				arg_57_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10078ui_story.fillRatio = var_60_20
			end

			local var_60_21 = 0
			local var_60_22 = 0.675

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_23 = arg_57_1:FormatText(StoryNameCfg[216].name)

				arg_57_1.leftNameTxt_.text = var_60_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_24 = arg_57_1:GetWordFromCfg(412071013)
				local var_60_25 = arg_57_1:FormatText(var_60_24.content)

				arg_57_1.text_.text = var_60_25

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_26 = 27
				local var_60_27 = utf8.len(var_60_25)
				local var_60_28 = var_60_26 <= 0 and var_60_22 or var_60_22 * (var_60_27 / var_60_26)

				if var_60_28 > 0 and var_60_22 < var_60_28 then
					arg_57_1.talkMaxDuration = var_60_28

					if var_60_28 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_28 + var_60_21
					end
				end

				arg_57_1.text_.text = var_60_25
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071013", "story_v_out_412071.awb") ~= 0 then
					local var_60_29 = manager.audio:GetVoiceLength("story_v_out_412071", "412071013", "story_v_out_412071.awb") / 1000

					if var_60_29 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_29 + var_60_21
					end

					if var_60_24.prefab_name ~= "" and arg_57_1.actors_[var_60_24.prefab_name] ~= nil then
						local var_60_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_24.prefab_name].transform, "story_v_out_412071", "412071013", "story_v_out_412071.awb")

						arg_57_1:RecordAudio("412071013", var_60_30)
						arg_57_1:RecordAudio("412071013", var_60_30)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_412071", "412071013", "story_v_out_412071.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_412071", "412071013", "story_v_out_412071.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_31 = math.max(var_60_22, arg_57_1.talkMaxDuration)

			if var_60_21 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_31 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_21) / var_60_31

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_21 + var_60_31 and arg_57_1.time_ < var_60_21 + var_60_31 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 412071014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play412071015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1097ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1097ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0, 100, 0)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1097ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0, 100, 0)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1097ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1097ui_story == nil then
				arg_61_1.var_.characterEffect1097ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1097ui_story and not isNil(var_64_9) then
					local var_64_13 = Mathf.Lerp(0, 0.5, var_64_12)

					arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1097ui_story.fillRatio = var_64_13
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1097ui_story then
				local var_64_14 = 0.5

				arg_61_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1097ui_story.fillRatio = var_64_14
			end

			local var_64_15 = arg_61_1.actors_["10078ui_story"].transform
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.var_.moveOldPos10078ui_story = var_64_15.localPosition
			end

			local var_64_17 = 0.001

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17
				local var_64_19 = Vector3.New(0, 100, 0)

				var_64_15.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10078ui_story, var_64_19, var_64_18)

				local var_64_20 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_20.x, var_64_20.y, var_64_20.z)

				local var_64_21 = var_64_15.localEulerAngles

				var_64_21.z = 0
				var_64_21.x = 0
				var_64_15.localEulerAngles = var_64_21
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				var_64_15.localPosition = Vector3.New(0, 100, 0)

				local var_64_22 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_22.x, var_64_22.y, var_64_22.z)

				local var_64_23 = var_64_15.localEulerAngles

				var_64_23.z = 0
				var_64_23.x = 0
				var_64_15.localEulerAngles = var_64_23
			end

			local var_64_24 = arg_61_1.actors_["10078ui_story"]
			local var_64_25 = 0

			if var_64_25 < arg_61_1.time_ and arg_61_1.time_ <= var_64_25 + arg_64_0 and not isNil(var_64_24) and arg_61_1.var_.characterEffect10078ui_story == nil then
				arg_61_1.var_.characterEffect10078ui_story = var_64_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_26 = 0.200000002980232

			if var_64_25 <= arg_61_1.time_ and arg_61_1.time_ < var_64_25 + var_64_26 and not isNil(var_64_24) then
				local var_64_27 = (arg_61_1.time_ - var_64_25) / var_64_26

				if arg_61_1.var_.characterEffect10078ui_story and not isNil(var_64_24) then
					local var_64_28 = Mathf.Lerp(0, 0.5, var_64_27)

					arg_61_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10078ui_story.fillRatio = var_64_28
				end
			end

			if arg_61_1.time_ >= var_64_25 + var_64_26 and arg_61_1.time_ < var_64_25 + var_64_26 + arg_64_0 and not isNil(var_64_24) and arg_61_1.var_.characterEffect10078ui_story then
				local var_64_29 = 0.5

				arg_61_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10078ui_story.fillRatio = var_64_29
			end

			local var_64_30 = 0
			local var_64_31 = 1.025

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_32 = arg_61_1:GetWordFromCfg(412071014)
				local var_64_33 = arg_61_1:FormatText(var_64_32.content)

				arg_61_1.text_.text = var_64_33

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_34 = 41
				local var_64_35 = utf8.len(var_64_33)
				local var_64_36 = var_64_34 <= 0 and var_64_31 or var_64_31 * (var_64_35 / var_64_34)

				if var_64_36 > 0 and var_64_31 < var_64_36 then
					arg_61_1.talkMaxDuration = var_64_36

					if var_64_36 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_36 + var_64_30
					end
				end

				arg_61_1.text_.text = var_64_33
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_37 = math.max(var_64_31, arg_61_1.talkMaxDuration)

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_37 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_30) / var_64_37

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_30 + var_64_37 and arg_61_1.time_ < var_64_30 + var_64_37 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412071015
		arg_65_1.duration_ = 4.67

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 4.666
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
				arg_65_0:Play412071016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1097ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1097ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, -0.54, -6.3)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1097ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1097ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1097ui_story == nil then
				arg_65_1.var_.characterEffect1097ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1097ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1097ui_story then
				arg_65_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_68_15 = 0
			local var_68_16 = 0.2

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_17 = arg_65_1:FormatText(StoryNameCfg[216].name)

				arg_65_1.leftNameTxt_.text = var_68_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_18 = arg_65_1:GetWordFromCfg(412071015)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_20 = 8
				local var_68_21 = utf8.len(var_68_19)
				local var_68_22 = var_68_20 <= 0 and var_68_16 or var_68_16 * (var_68_21 / var_68_20)

				if var_68_22 > 0 and var_68_16 < var_68_22 then
					arg_65_1.talkMaxDuration = var_68_22

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071015", "story_v_out_412071.awb") ~= 0 then
					local var_68_23 = manager.audio:GetVoiceLength("story_v_out_412071", "412071015", "story_v_out_412071.awb") / 1000

					if var_68_23 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_412071", "412071015", "story_v_out_412071.awb")

						arg_65_1:RecordAudio("412071015", var_68_24)
						arg_65_1:RecordAudio("412071015", var_68_24)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_412071", "412071015", "story_v_out_412071.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_412071", "412071015", "story_v_out_412071.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_25 and arg_65_1.time_ < var_68_15 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 412071016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play412071017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1097ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1097ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1097ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, 100, 0)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["1097ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1097ui_story == nil then
				arg_69_1.var_.characterEffect1097ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect1097ui_story and not isNil(var_72_9) then
					local var_72_13 = Mathf.Lerp(0, 0.5, var_72_12)

					arg_69_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1097ui_story.fillRatio = var_72_13
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1097ui_story then
				local var_72_14 = 0.5

				arg_69_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1097ui_story.fillRatio = var_72_14
			end

			local var_72_15 = 0
			local var_72_16 = 1.475

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_17 = arg_69_1:GetWordFromCfg(412071016)
				local var_72_18 = arg_69_1:FormatText(var_72_17.content)

				arg_69_1.text_.text = var_72_18

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_19 = 59
				local var_72_20 = utf8.len(var_72_18)
				local var_72_21 = var_72_19 <= 0 and var_72_16 or var_72_16 * (var_72_20 / var_72_19)

				if var_72_21 > 0 and var_72_16 < var_72_21 then
					arg_69_1.talkMaxDuration = var_72_21

					if var_72_21 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_21 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_18
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_22 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_22 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_22

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_22 and arg_69_1.time_ < var_72_15 + var_72_22 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 412071017
		arg_73_1.duration_ = 4.9

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play412071018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10078ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10078ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, -0.5, -6.3)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10078ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["10078ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10078ui_story == nil then
				arg_73_1.var_.characterEffect10078ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect10078ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect10078ui_story then
				arg_73_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_15 = 0
			local var_76_16 = 0.3

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_17 = arg_73_1:FormatText(StoryNameCfg[919].name)

				arg_73_1.leftNameTxt_.text = var_76_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_18 = arg_73_1:GetWordFromCfg(412071017)
				local var_76_19 = arg_73_1:FormatText(var_76_18.content)

				arg_73_1.text_.text = var_76_19

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071017", "story_v_out_412071.awb") ~= 0 then
					local var_76_23 = manager.audio:GetVoiceLength("story_v_out_412071", "412071017", "story_v_out_412071.awb") / 1000

					if var_76_23 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_15
					end

					if var_76_18.prefab_name ~= "" and arg_73_1.actors_[var_76_18.prefab_name] ~= nil then
						local var_76_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_18.prefab_name].transform, "story_v_out_412071", "412071017", "story_v_out_412071.awb")

						arg_73_1:RecordAudio("412071017", var_76_24)
						arg_73_1:RecordAudio("412071017", var_76_24)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_412071", "412071017", "story_v_out_412071.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_412071", "412071017", "story_v_out_412071.awb")
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
				actorName = "10078ui_story",
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
	Play412071018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 412071018
		arg_77_1.duration_ = 5.57

		local var_77_0 = {
			zh = 5.566,
			ja = 3.866
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
				arg_77_0:Play412071019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "10083ui_story"

			if arg_77_1.actors_[var_80_0] == nil then
				local var_80_1 = Asset.Load("Char/" .. "10083ui_story")

				if not isNil(var_80_1) then
					local var_80_2 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_77_1.stage_.transform)

					var_80_2.name = var_80_0
					var_80_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_77_1.actors_[var_80_0] = var_80_2

					local var_80_3 = var_80_2:GetComponentInChildren(typeof(CharacterEffect))

					var_80_3.enabled = true

					local var_80_4 = GameObjectTools.GetOrAddComponent(var_80_2, typeof(DynamicBoneHelper))

					if var_80_4 then
						var_80_4:EnableDynamicBone(false)
					end

					arg_77_1:ShowWeapon(var_80_3.transform, false)

					arg_77_1.var_[var_80_0 .. "Animator"] = var_80_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_77_1.var_[var_80_0 .. "Animator"].applyRootMotion = true
					arg_77_1.var_[var_80_0 .. "LipSync"] = var_80_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_80_5 = arg_77_1.actors_["10083ui_story"].transform
			local var_80_6 = 0

			if var_80_6 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.var_.moveOldPos10083ui_story = var_80_5.localPosition
			end

			local var_80_7 = 0.001

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_7 then
				local var_80_8 = (arg_77_1.time_ - var_80_6) / var_80_7
				local var_80_9 = Vector3.New(0, -2.6, -2.8)

				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10083ui_story, var_80_9, var_80_8)

				local var_80_10 = manager.ui.mainCamera.transform.position - var_80_5.position

				var_80_5.forward = Vector3.New(var_80_10.x, var_80_10.y, var_80_10.z)

				local var_80_11 = var_80_5.localEulerAngles

				var_80_11.z = 0
				var_80_11.x = 0
				var_80_5.localEulerAngles = var_80_11
			end

			if arg_77_1.time_ >= var_80_6 + var_80_7 and arg_77_1.time_ < var_80_6 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_80_12 = manager.ui.mainCamera.transform.position - var_80_5.position

				var_80_5.forward = Vector3.New(var_80_12.x, var_80_12.y, var_80_12.z)

				local var_80_13 = var_80_5.localEulerAngles

				var_80_13.z = 0
				var_80_13.x = 0
				var_80_5.localEulerAngles = var_80_13
			end

			local var_80_14 = arg_77_1.actors_["10083ui_story"]
			local var_80_15 = 0

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect10083ui_story == nil then
				arg_77_1.var_.characterEffect10083ui_story = var_80_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_16 = 0.200000002980232

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_16 and not isNil(var_80_14) then
				local var_80_17 = (arg_77_1.time_ - var_80_15) / var_80_16

				if arg_77_1.var_.characterEffect10083ui_story and not isNil(var_80_14) then
					arg_77_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_15 + var_80_16 and arg_77_1.time_ < var_80_15 + var_80_16 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect10083ui_story then
				arg_77_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_80_18 = 0

			if var_80_18 < arg_77_1.time_ and arg_77_1.time_ <= var_80_18 + arg_80_0 then
				arg_77_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action5_1")
			end

			local var_80_19 = 0

			if var_80_19 < arg_77_1.time_ and arg_77_1.time_ <= var_80_19 + arg_80_0 then
				arg_77_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_20 = arg_77_1.actors_["10078ui_story"].transform
			local var_80_21 = 0

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1.var_.moveOldPos10078ui_story = var_80_20.localPosition
			end

			local var_80_22 = 0.001

			if var_80_21 <= arg_77_1.time_ and arg_77_1.time_ < var_80_21 + var_80_22 then
				local var_80_23 = (arg_77_1.time_ - var_80_21) / var_80_22
				local var_80_24 = Vector3.New(0, 100, 0)

				var_80_20.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10078ui_story, var_80_24, var_80_23)

				local var_80_25 = manager.ui.mainCamera.transform.position - var_80_20.position

				var_80_20.forward = Vector3.New(var_80_25.x, var_80_25.y, var_80_25.z)

				local var_80_26 = var_80_20.localEulerAngles

				var_80_26.z = 0
				var_80_26.x = 0
				var_80_20.localEulerAngles = var_80_26
			end

			if arg_77_1.time_ >= var_80_21 + var_80_22 and arg_77_1.time_ < var_80_21 + var_80_22 + arg_80_0 then
				var_80_20.localPosition = Vector3.New(0, 100, 0)

				local var_80_27 = manager.ui.mainCamera.transform.position - var_80_20.position

				var_80_20.forward = Vector3.New(var_80_27.x, var_80_27.y, var_80_27.z)

				local var_80_28 = var_80_20.localEulerAngles

				var_80_28.z = 0
				var_80_28.x = 0
				var_80_20.localEulerAngles = var_80_28
			end

			local var_80_29 = arg_77_1.actors_["10078ui_story"]
			local var_80_30 = 0

			if var_80_30 < arg_77_1.time_ and arg_77_1.time_ <= var_80_30 + arg_80_0 and not isNil(var_80_29) and arg_77_1.var_.characterEffect10078ui_story == nil then
				arg_77_1.var_.characterEffect10078ui_story = var_80_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_31 = 0.200000002980232

			if var_80_30 <= arg_77_1.time_ and arg_77_1.time_ < var_80_30 + var_80_31 and not isNil(var_80_29) then
				local var_80_32 = (arg_77_1.time_ - var_80_30) / var_80_31

				if arg_77_1.var_.characterEffect10078ui_story and not isNil(var_80_29) then
					local var_80_33 = Mathf.Lerp(0, 0.5, var_80_32)

					arg_77_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10078ui_story.fillRatio = var_80_33
				end
			end

			if arg_77_1.time_ >= var_80_30 + var_80_31 and arg_77_1.time_ < var_80_30 + var_80_31 + arg_80_0 and not isNil(var_80_29) and arg_77_1.var_.characterEffect10078ui_story then
				local var_80_34 = 0.5

				arg_77_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10078ui_story.fillRatio = var_80_34
			end

			local var_80_35 = 0
			local var_80_36 = 0.65

			if var_80_35 < arg_77_1.time_ and arg_77_1.time_ <= var_80_35 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_37 = arg_77_1:FormatText(StoryNameCfg[918].name)

				arg_77_1.leftNameTxt_.text = var_80_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_38 = arg_77_1:GetWordFromCfg(412071018)
				local var_80_39 = arg_77_1:FormatText(var_80_38.content)

				arg_77_1.text_.text = var_80_39

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_40 = 26
				local var_80_41 = utf8.len(var_80_39)
				local var_80_42 = var_80_40 <= 0 and var_80_36 or var_80_36 * (var_80_41 / var_80_40)

				if var_80_42 > 0 and var_80_36 < var_80_42 then
					arg_77_1.talkMaxDuration = var_80_42

					if var_80_42 + var_80_35 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_42 + var_80_35
					end
				end

				arg_77_1.text_.text = var_80_39
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071018", "story_v_out_412071.awb") ~= 0 then
					local var_80_43 = manager.audio:GetVoiceLength("story_v_out_412071", "412071018", "story_v_out_412071.awb") / 1000

					if var_80_43 + var_80_35 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_43 + var_80_35
					end

					if var_80_38.prefab_name ~= "" and arg_77_1.actors_[var_80_38.prefab_name] ~= nil then
						local var_80_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_38.prefab_name].transform, "story_v_out_412071", "412071018", "story_v_out_412071.awb")

						arg_77_1:RecordAudio("412071018", var_80_44)
						arg_77_1:RecordAudio("412071018", var_80_44)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_412071", "412071018", "story_v_out_412071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_412071", "412071018", "story_v_out_412071.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_45 = math.max(var_80_36, arg_77_1.talkMaxDuration)

			if var_80_35 <= arg_77_1.time_ and arg_77_1.time_ < var_80_35 + var_80_45 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_35) / var_80_45

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_35 + var_80_45 and arg_77_1.time_ < var_80_35 + var_80_45 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 412071019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play412071020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10083ui_story"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10083ui_story = var_84_0.localPosition
			end

			local var_84_2 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2
				local var_84_4 = Vector3.New(0, 100, 0)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10083ui_story, var_84_4, var_84_3)

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

			local var_84_9 = arg_81_1.actors_["10083ui_story"]
			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10083ui_story == nil then
				arg_81_1.var_.characterEffect10083ui_story = var_84_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_11 = 0.200000002980232

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_11 and not isNil(var_84_9) then
				local var_84_12 = (arg_81_1.time_ - var_84_10) / var_84_11

				if arg_81_1.var_.characterEffect10083ui_story and not isNil(var_84_9) then
					local var_84_13 = Mathf.Lerp(0, 0.5, var_84_12)

					arg_81_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10083ui_story.fillRatio = var_84_13
				end
			end

			if arg_81_1.time_ >= var_84_10 + var_84_11 and arg_81_1.time_ < var_84_10 + var_84_11 + arg_84_0 and not isNil(var_84_9) and arg_81_1.var_.characterEffect10083ui_story then
				local var_84_14 = 0.5

				arg_81_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10083ui_story.fillRatio = var_84_14
			end

			local var_84_15 = 0
			local var_84_16 = 1.15

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_17 = arg_81_1:GetWordFromCfg(412071019)
				local var_84_18 = arg_81_1:FormatText(var_84_17.content)

				arg_81_1.text_.text = var_84_18

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_19 = 46
				local var_84_20 = utf8.len(var_84_18)
				local var_84_21 = var_84_19 <= 0 and var_84_16 or var_84_16 * (var_84_20 / var_84_19)

				if var_84_21 > 0 and var_84_16 < var_84_21 then
					arg_81_1.talkMaxDuration = var_84_21

					if var_84_21 + var_84_15 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_21 + var_84_15
					end
				end

				arg_81_1.text_.text = var_84_18
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_22 = math.max(var_84_16, arg_81_1.talkMaxDuration)

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_22 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_15) / var_84_22

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_15 + var_84_22 and arg_81_1.time_ < var_84_15 + var_84_22 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412071020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 412071020
		arg_85_1.duration_ = 3

		local var_85_0 = {
			zh = 2.6,
			ja = 3
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play412071021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1097ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1097ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(0, -0.54, -6.3)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1097ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1097ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1097ui_story == nil then
				arg_85_1.var_.characterEffect1097ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1097ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1097ui_story then
				arg_85_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_15 = 0
			local var_88_16 = 0.225

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[216].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(412071020)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 9
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071020", "story_v_out_412071.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_412071", "412071020", "story_v_out_412071.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_412071", "412071020", "story_v_out_412071.awb")

						arg_85_1:RecordAudio("412071020", var_88_24)
						arg_85_1:RecordAudio("412071020", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_412071", "412071020", "story_v_out_412071.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_412071", "412071020", "story_v_out_412071.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 412071021
		arg_89_1.duration_ = 9.27

		local var_89_0 = {
			zh = 8.8,
			ja = 9.266
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
				arg_89_0:Play412071022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10083ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10083ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -2.6, -2.8)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10083ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["10083ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect10083ui_story == nil then
				arg_89_1.var_.characterEffect10083ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect10083ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect10083ui_story then
				arg_89_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_15 = arg_89_1.actors_["1097ui_story"].transform
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.var_.moveOldPos1097ui_story = var_92_15.localPosition
			end

			local var_92_17 = 0.001

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17
				local var_92_19 = Vector3.New(0, 100, 0)

				var_92_15.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1097ui_story, var_92_19, var_92_18)

				local var_92_20 = manager.ui.mainCamera.transform.position - var_92_15.position

				var_92_15.forward = Vector3.New(var_92_20.x, var_92_20.y, var_92_20.z)

				local var_92_21 = var_92_15.localEulerAngles

				var_92_21.z = 0
				var_92_21.x = 0
				var_92_15.localEulerAngles = var_92_21
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 then
				var_92_15.localPosition = Vector3.New(0, 100, 0)

				local var_92_22 = manager.ui.mainCamera.transform.position - var_92_15.position

				var_92_15.forward = Vector3.New(var_92_22.x, var_92_22.y, var_92_22.z)

				local var_92_23 = var_92_15.localEulerAngles

				var_92_23.z = 0
				var_92_23.x = 0
				var_92_15.localEulerAngles = var_92_23
			end

			local var_92_24 = arg_89_1.actors_["1097ui_story"]
			local var_92_25 = 0

			if var_92_25 < arg_89_1.time_ and arg_89_1.time_ <= var_92_25 + arg_92_0 and not isNil(var_92_24) and arg_89_1.var_.characterEffect1097ui_story == nil then
				arg_89_1.var_.characterEffect1097ui_story = var_92_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_26 = 0.200000002980232

			if var_92_25 <= arg_89_1.time_ and arg_89_1.time_ < var_92_25 + var_92_26 and not isNil(var_92_24) then
				local var_92_27 = (arg_89_1.time_ - var_92_25) / var_92_26

				if arg_89_1.var_.characterEffect1097ui_story and not isNil(var_92_24) then
					local var_92_28 = Mathf.Lerp(0, 0.5, var_92_27)

					arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1097ui_story.fillRatio = var_92_28
				end
			end

			if arg_89_1.time_ >= var_92_25 + var_92_26 and arg_89_1.time_ < var_92_25 + var_92_26 + arg_92_0 and not isNil(var_92_24) and arg_89_1.var_.characterEffect1097ui_story then
				local var_92_29 = 0.5

				arg_89_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1097ui_story.fillRatio = var_92_29
			end

			local var_92_30 = 0
			local var_92_31 = 1.075

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_32 = arg_89_1:FormatText(StoryNameCfg[918].name)

				arg_89_1.leftNameTxt_.text = var_92_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_33 = arg_89_1:GetWordFromCfg(412071021)
				local var_92_34 = arg_89_1:FormatText(var_92_33.content)

				arg_89_1.text_.text = var_92_34

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_35 = 43
				local var_92_36 = utf8.len(var_92_34)
				local var_92_37 = var_92_35 <= 0 and var_92_31 or var_92_31 * (var_92_36 / var_92_35)

				if var_92_37 > 0 and var_92_31 < var_92_37 then
					arg_89_1.talkMaxDuration = var_92_37

					if var_92_37 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_37 + var_92_30
					end
				end

				arg_89_1.text_.text = var_92_34
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071021", "story_v_out_412071.awb") ~= 0 then
					local var_92_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071021", "story_v_out_412071.awb") / 1000

					if var_92_38 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_38 + var_92_30
					end

					if var_92_33.prefab_name ~= "" and arg_89_1.actors_[var_92_33.prefab_name] ~= nil then
						local var_92_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_33.prefab_name].transform, "story_v_out_412071", "412071021", "story_v_out_412071.awb")

						arg_89_1:RecordAudio("412071021", var_92_39)
						arg_89_1:RecordAudio("412071021", var_92_39)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_412071", "412071021", "story_v_out_412071.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_412071", "412071021", "story_v_out_412071.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_40 = math.max(var_92_31, arg_89_1.talkMaxDuration)

			if var_92_30 <= arg_89_1.time_ and arg_89_1.time_ < var_92_30 + var_92_40 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_30) / var_92_40

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_30 + var_92_40 and arg_89_1.time_ < var_92_30 + var_92_40 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 412071022
		arg_93_1.duration_ = 5.83

		local var_93_0 = {
			zh = 4.1,
			ja = 5.833
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play412071023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10078ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10078ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(0, -0.5, -6.3)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10078ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["10078ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect10078ui_story == nil then
				arg_93_1.var_.characterEffect10078ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect10078ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect10078ui_story then
				arg_93_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_96_13 = 0

			if var_96_13 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_15 = arg_93_1.actors_["10083ui_story"].transform
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.var_.moveOldPos10083ui_story = var_96_15.localPosition
			end

			local var_96_17 = 0.001

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17
				local var_96_19 = Vector3.New(0, 100, 0)

				var_96_15.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10083ui_story, var_96_19, var_96_18)

				local var_96_20 = manager.ui.mainCamera.transform.position - var_96_15.position

				var_96_15.forward = Vector3.New(var_96_20.x, var_96_20.y, var_96_20.z)

				local var_96_21 = var_96_15.localEulerAngles

				var_96_21.z = 0
				var_96_21.x = 0
				var_96_15.localEulerAngles = var_96_21
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				var_96_15.localPosition = Vector3.New(0, 100, 0)

				local var_96_22 = manager.ui.mainCamera.transform.position - var_96_15.position

				var_96_15.forward = Vector3.New(var_96_22.x, var_96_22.y, var_96_22.z)

				local var_96_23 = var_96_15.localEulerAngles

				var_96_23.z = 0
				var_96_23.x = 0
				var_96_15.localEulerAngles = var_96_23
			end

			local var_96_24 = arg_93_1.actors_["10083ui_story"]
			local var_96_25 = 0

			if var_96_25 < arg_93_1.time_ and arg_93_1.time_ <= var_96_25 + arg_96_0 and not isNil(var_96_24) and arg_93_1.var_.characterEffect10083ui_story == nil then
				arg_93_1.var_.characterEffect10083ui_story = var_96_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_26 = 0.200000002980232

			if var_96_25 <= arg_93_1.time_ and arg_93_1.time_ < var_96_25 + var_96_26 and not isNil(var_96_24) then
				local var_96_27 = (arg_93_1.time_ - var_96_25) / var_96_26

				if arg_93_1.var_.characterEffect10083ui_story and not isNil(var_96_24) then
					local var_96_28 = Mathf.Lerp(0, 0.5, var_96_27)

					arg_93_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10083ui_story.fillRatio = var_96_28
				end
			end

			if arg_93_1.time_ >= var_96_25 + var_96_26 and arg_93_1.time_ < var_96_25 + var_96_26 + arg_96_0 and not isNil(var_96_24) and arg_93_1.var_.characterEffect10083ui_story then
				local var_96_29 = 0.5

				arg_93_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10083ui_story.fillRatio = var_96_29
			end

			local var_96_30 = 0
			local var_96_31 = 0.275

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[919].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_33 = arg_93_1:GetWordFromCfg(412071022)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 11
				local var_96_36 = utf8.len(var_96_34)
				local var_96_37 = var_96_35 <= 0 and var_96_31 or var_96_31 * (var_96_36 / var_96_35)

				if var_96_37 > 0 and var_96_31 < var_96_37 then
					arg_93_1.talkMaxDuration = var_96_37

					if var_96_37 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_37 + var_96_30
					end
				end

				arg_93_1.text_.text = var_96_34
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071022", "story_v_out_412071.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071022", "story_v_out_412071.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_412071", "412071022", "story_v_out_412071.awb")

						arg_93_1:RecordAudio("412071022", var_96_39)
						arg_93_1:RecordAudio("412071022", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_412071", "412071022", "story_v_out_412071.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_412071", "412071022", "story_v_out_412071.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_40 = math.max(var_96_31, arg_93_1.talkMaxDuration)

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_40 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_30) / var_96_40

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_30 + var_96_40 and arg_93_1.time_ < var_96_30 + var_96_40 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412071023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 412071023
		arg_97_1.duration_ = 10.4

		local var_97_0 = {
			zh = 7.1,
			ja = 10.4
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
				arg_97_0:Play412071024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10083ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10083ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -2.6, -2.8)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10083ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["10083ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10083ui_story == nil then
				arg_97_1.var_.characterEffect10083ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect10083ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect10083ui_story then
				arg_97_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_100_13 = 0

			if var_100_13 < arg_97_1.time_ and arg_97_1.time_ <= var_100_13 + arg_100_0 then
				arg_97_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_15 = arg_97_1.actors_["10078ui_story"].transform
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.var_.moveOldPos10078ui_story = var_100_15.localPosition
			end

			local var_100_17 = 0.001

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17
				local var_100_19 = Vector3.New(0, 100, 0)

				var_100_15.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10078ui_story, var_100_19, var_100_18)

				local var_100_20 = manager.ui.mainCamera.transform.position - var_100_15.position

				var_100_15.forward = Vector3.New(var_100_20.x, var_100_20.y, var_100_20.z)

				local var_100_21 = var_100_15.localEulerAngles

				var_100_21.z = 0
				var_100_21.x = 0
				var_100_15.localEulerAngles = var_100_21
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 then
				var_100_15.localPosition = Vector3.New(0, 100, 0)

				local var_100_22 = manager.ui.mainCamera.transform.position - var_100_15.position

				var_100_15.forward = Vector3.New(var_100_22.x, var_100_22.y, var_100_22.z)

				local var_100_23 = var_100_15.localEulerAngles

				var_100_23.z = 0
				var_100_23.x = 0
				var_100_15.localEulerAngles = var_100_23
			end

			local var_100_24 = arg_97_1.actors_["10078ui_story"]
			local var_100_25 = 0

			if var_100_25 < arg_97_1.time_ and arg_97_1.time_ <= var_100_25 + arg_100_0 and not isNil(var_100_24) and arg_97_1.var_.characterEffect10078ui_story == nil then
				arg_97_1.var_.characterEffect10078ui_story = var_100_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_26 = 0.200000002980232

			if var_100_25 <= arg_97_1.time_ and arg_97_1.time_ < var_100_25 + var_100_26 and not isNil(var_100_24) then
				local var_100_27 = (arg_97_1.time_ - var_100_25) / var_100_26

				if arg_97_1.var_.characterEffect10078ui_story and not isNil(var_100_24) then
					local var_100_28 = Mathf.Lerp(0, 0.5, var_100_27)

					arg_97_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10078ui_story.fillRatio = var_100_28
				end
			end

			if arg_97_1.time_ >= var_100_25 + var_100_26 and arg_97_1.time_ < var_100_25 + var_100_26 + arg_100_0 and not isNil(var_100_24) and arg_97_1.var_.characterEffect10078ui_story then
				local var_100_29 = 0.5

				arg_97_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10078ui_story.fillRatio = var_100_29
			end

			local var_100_30 = 0
			local var_100_31 = 0.825

			if var_100_30 < arg_97_1.time_ and arg_97_1.time_ <= var_100_30 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_32 = arg_97_1:FormatText(StoryNameCfg[918].name)

				arg_97_1.leftNameTxt_.text = var_100_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_33 = arg_97_1:GetWordFromCfg(412071023)
				local var_100_34 = arg_97_1:FormatText(var_100_33.content)

				arg_97_1.text_.text = var_100_34

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_35 = 33
				local var_100_36 = utf8.len(var_100_34)
				local var_100_37 = var_100_35 <= 0 and var_100_31 or var_100_31 * (var_100_36 / var_100_35)

				if var_100_37 > 0 and var_100_31 < var_100_37 then
					arg_97_1.talkMaxDuration = var_100_37

					if var_100_37 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_37 + var_100_30
					end
				end

				arg_97_1.text_.text = var_100_34
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071023", "story_v_out_412071.awb") ~= 0 then
					local var_100_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071023", "story_v_out_412071.awb") / 1000

					if var_100_38 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_38 + var_100_30
					end

					if var_100_33.prefab_name ~= "" and arg_97_1.actors_[var_100_33.prefab_name] ~= nil then
						local var_100_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_33.prefab_name].transform, "story_v_out_412071", "412071023", "story_v_out_412071.awb")

						arg_97_1:RecordAudio("412071023", var_100_39)
						arg_97_1:RecordAudio("412071023", var_100_39)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_412071", "412071023", "story_v_out_412071.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_412071", "412071023", "story_v_out_412071.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_40 = math.max(var_100_31, arg_97_1.talkMaxDuration)

			if var_100_30 <= arg_97_1.time_ and arg_97_1.time_ < var_100_30 + var_100_40 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_30) / var_100_40

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_30 + var_100_40 and arg_97_1.time_ < var_100_30 + var_100_40 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 412071024
		arg_101_1.duration_ = 4.87

		local var_101_0 = {
			zh = 4.866,
			ja = 3.233
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play412071025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1097ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1097ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(0, -0.54, -6.3)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1097ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1097ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1097ui_story == nil then
				arg_101_1.var_.characterEffect1097ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1097ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1097ui_story then
				arg_101_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_15 = arg_101_1.actors_["10083ui_story"].transform
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.var_.moveOldPos10083ui_story = var_104_15.localPosition
			end

			local var_104_17 = 0.001

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17
				local var_104_19 = Vector3.New(0, 100, 0)

				var_104_15.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10083ui_story, var_104_19, var_104_18)

				local var_104_20 = manager.ui.mainCamera.transform.position - var_104_15.position

				var_104_15.forward = Vector3.New(var_104_20.x, var_104_20.y, var_104_20.z)

				local var_104_21 = var_104_15.localEulerAngles

				var_104_21.z = 0
				var_104_21.x = 0
				var_104_15.localEulerAngles = var_104_21
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 then
				var_104_15.localPosition = Vector3.New(0, 100, 0)

				local var_104_22 = manager.ui.mainCamera.transform.position - var_104_15.position

				var_104_15.forward = Vector3.New(var_104_22.x, var_104_22.y, var_104_22.z)

				local var_104_23 = var_104_15.localEulerAngles

				var_104_23.z = 0
				var_104_23.x = 0
				var_104_15.localEulerAngles = var_104_23
			end

			local var_104_24 = arg_101_1.actors_["10083ui_story"]
			local var_104_25 = 0

			if var_104_25 < arg_101_1.time_ and arg_101_1.time_ <= var_104_25 + arg_104_0 and not isNil(var_104_24) and arg_101_1.var_.characterEffect10083ui_story == nil then
				arg_101_1.var_.characterEffect10083ui_story = var_104_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_26 = 0.200000002980232

			if var_104_25 <= arg_101_1.time_ and arg_101_1.time_ < var_104_25 + var_104_26 and not isNil(var_104_24) then
				local var_104_27 = (arg_101_1.time_ - var_104_25) / var_104_26

				if arg_101_1.var_.characterEffect10083ui_story and not isNil(var_104_24) then
					local var_104_28 = Mathf.Lerp(0, 0.5, var_104_27)

					arg_101_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10083ui_story.fillRatio = var_104_28
				end
			end

			if arg_101_1.time_ >= var_104_25 + var_104_26 and arg_101_1.time_ < var_104_25 + var_104_26 + arg_104_0 and not isNil(var_104_24) and arg_101_1.var_.characterEffect10083ui_story then
				local var_104_29 = 0.5

				arg_101_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10083ui_story.fillRatio = var_104_29
			end

			local var_104_30 = 0
			local var_104_31 = 0.55

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_32 = arg_101_1:FormatText(StoryNameCfg[216].name)

				arg_101_1.leftNameTxt_.text = var_104_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_33 = arg_101_1:GetWordFromCfg(412071024)
				local var_104_34 = arg_101_1:FormatText(var_104_33.content)

				arg_101_1.text_.text = var_104_34

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_35 = 22
				local var_104_36 = utf8.len(var_104_34)
				local var_104_37 = var_104_35 <= 0 and var_104_31 or var_104_31 * (var_104_36 / var_104_35)

				if var_104_37 > 0 and var_104_31 < var_104_37 then
					arg_101_1.talkMaxDuration = var_104_37

					if var_104_37 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_37 + var_104_30
					end
				end

				arg_101_1.text_.text = var_104_34
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071024", "story_v_out_412071.awb") ~= 0 then
					local var_104_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071024", "story_v_out_412071.awb") / 1000

					if var_104_38 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_38 + var_104_30
					end

					if var_104_33.prefab_name ~= "" and arg_101_1.actors_[var_104_33.prefab_name] ~= nil then
						local var_104_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_33.prefab_name].transform, "story_v_out_412071", "412071024", "story_v_out_412071.awb")

						arg_101_1:RecordAudio("412071024", var_104_39)
						arg_101_1:RecordAudio("412071024", var_104_39)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_412071", "412071024", "story_v_out_412071.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_412071", "412071024", "story_v_out_412071.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_40 = math.max(var_104_31, arg_101_1.talkMaxDuration)

			if var_104_30 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_40 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_30) / var_104_40

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_30 + var_104_40 and arg_101_1.time_ < var_104_30 + var_104_40 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play412071025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 412071025
		arg_105_1.duration_ = 7.23

		local var_105_0 = {
			zh = 5.9,
			ja = 7.233
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
				arg_105_0:Play412071026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10078ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10078ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, -0.5, -6.3)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10078ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["10078ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10078ui_story == nil then
				arg_105_1.var_.characterEffect10078ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect10078ui_story and not isNil(var_108_9) then
					arg_105_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10078ui_story then
				arg_105_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				arg_105_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_14 = arg_105_1.actors_["1097ui_story"].transform
			local var_108_15 = 0

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.var_.moveOldPos1097ui_story = var_108_14.localPosition
			end

			local var_108_16 = 0.001

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_16 then
				local var_108_17 = (arg_105_1.time_ - var_108_15) / var_108_16
				local var_108_18 = Vector3.New(0, 100, 0)

				var_108_14.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1097ui_story, var_108_18, var_108_17)

				local var_108_19 = manager.ui.mainCamera.transform.position - var_108_14.position

				var_108_14.forward = Vector3.New(var_108_19.x, var_108_19.y, var_108_19.z)

				local var_108_20 = var_108_14.localEulerAngles

				var_108_20.z = 0
				var_108_20.x = 0
				var_108_14.localEulerAngles = var_108_20
			end

			if arg_105_1.time_ >= var_108_15 + var_108_16 and arg_105_1.time_ < var_108_15 + var_108_16 + arg_108_0 then
				var_108_14.localPosition = Vector3.New(0, 100, 0)

				local var_108_21 = manager.ui.mainCamera.transform.position - var_108_14.position

				var_108_14.forward = Vector3.New(var_108_21.x, var_108_21.y, var_108_21.z)

				local var_108_22 = var_108_14.localEulerAngles

				var_108_22.z = 0
				var_108_22.x = 0
				var_108_14.localEulerAngles = var_108_22
			end

			local var_108_23 = arg_105_1.actors_["1097ui_story"]
			local var_108_24 = 0

			if var_108_24 < arg_105_1.time_ and arg_105_1.time_ <= var_108_24 + arg_108_0 and not isNil(var_108_23) and arg_105_1.var_.characterEffect1097ui_story == nil then
				arg_105_1.var_.characterEffect1097ui_story = var_108_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_25 = 0.200000002980232

			if var_108_24 <= arg_105_1.time_ and arg_105_1.time_ < var_108_24 + var_108_25 and not isNil(var_108_23) then
				local var_108_26 = (arg_105_1.time_ - var_108_24) / var_108_25

				if arg_105_1.var_.characterEffect1097ui_story and not isNil(var_108_23) then
					local var_108_27 = Mathf.Lerp(0, 0.5, var_108_26)

					arg_105_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1097ui_story.fillRatio = var_108_27
				end
			end

			if arg_105_1.time_ >= var_108_24 + var_108_25 and arg_105_1.time_ < var_108_24 + var_108_25 + arg_108_0 and not isNil(var_108_23) and arg_105_1.var_.characterEffect1097ui_story then
				local var_108_28 = 0.5

				arg_105_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1097ui_story.fillRatio = var_108_28
			end

			local var_108_29 = 0
			local var_108_30 = 0.425

			if var_108_29 < arg_105_1.time_ and arg_105_1.time_ <= var_108_29 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_31 = arg_105_1:FormatText(StoryNameCfg[919].name)

				arg_105_1.leftNameTxt_.text = var_108_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_32 = arg_105_1:GetWordFromCfg(412071025)
				local var_108_33 = arg_105_1:FormatText(var_108_32.content)

				arg_105_1.text_.text = var_108_33

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_34 = 17
				local var_108_35 = utf8.len(var_108_33)
				local var_108_36 = var_108_34 <= 0 and var_108_30 or var_108_30 * (var_108_35 / var_108_34)

				if var_108_36 > 0 and var_108_30 < var_108_36 then
					arg_105_1.talkMaxDuration = var_108_36

					if var_108_36 + var_108_29 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_36 + var_108_29
					end
				end

				arg_105_1.text_.text = var_108_33
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071025", "story_v_out_412071.awb") ~= 0 then
					local var_108_37 = manager.audio:GetVoiceLength("story_v_out_412071", "412071025", "story_v_out_412071.awb") / 1000

					if var_108_37 + var_108_29 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_37 + var_108_29
					end

					if var_108_32.prefab_name ~= "" and arg_105_1.actors_[var_108_32.prefab_name] ~= nil then
						local var_108_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_32.prefab_name].transform, "story_v_out_412071", "412071025", "story_v_out_412071.awb")

						arg_105_1:RecordAudio("412071025", var_108_38)
						arg_105_1:RecordAudio("412071025", var_108_38)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_412071", "412071025", "story_v_out_412071.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_412071", "412071025", "story_v_out_412071.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_39 = math.max(var_108_30, arg_105_1.talkMaxDuration)

			if var_108_29 <= arg_105_1.time_ and arg_105_1.time_ < var_108_29 + var_108_39 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_29) / var_108_39

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_29 + var_108_39 and arg_105_1.time_ < var_108_29 + var_108_39 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 412071026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play412071027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10078ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10078ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, 100, 0)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10078ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, 100, 0)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["10078ui_story"]
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect10078ui_story == nil then
				arg_109_1.var_.characterEffect10078ui_story = var_112_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_11 = 0.200000002980232

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 and not isNil(var_112_9) then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11

				if arg_109_1.var_.characterEffect10078ui_story and not isNil(var_112_9) then
					local var_112_13 = Mathf.Lerp(0, 0.5, var_112_12)

					arg_109_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10078ui_story.fillRatio = var_112_13
				end
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 and not isNil(var_112_9) and arg_109_1.var_.characterEffect10078ui_story then
				local var_112_14 = 0.5

				arg_109_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10078ui_story.fillRatio = var_112_14
			end

			local var_112_15 = 0
			local var_112_16 = 0.5

			if var_112_15 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_17 = arg_109_1:GetWordFromCfg(412071026)
				local var_112_18 = arg_109_1:FormatText(var_112_17.content)

				arg_109_1.text_.text = var_112_18

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_19 = 20
				local var_112_20 = utf8.len(var_112_18)
				local var_112_21 = var_112_19 <= 0 and var_112_16 or var_112_16 * (var_112_20 / var_112_19)

				if var_112_21 > 0 and var_112_16 < var_112_21 then
					arg_109_1.talkMaxDuration = var_112_21

					if var_112_21 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_21 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_18
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_22 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_22 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_15) / var_112_22

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_15 + var_112_22 and arg_109_1.time_ < var_112_15 + var_112_22 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 412071027
		arg_113_1.duration_ = 7

		local var_113_0 = {
			zh = 7,
			ja = 3.266
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
				arg_113_0:Play412071028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10078ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10078ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, -0.5, -6.3)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10078ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["10078ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect10078ui_story == nil then
				arg_113_1.var_.characterEffect10078ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect10078ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect10078ui_story then
				arg_113_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_14 = 0
			local var_116_15 = 0.6

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_16 = arg_113_1:FormatText(StoryNameCfg[919].name)

				arg_113_1.leftNameTxt_.text = var_116_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_17 = arg_113_1:GetWordFromCfg(412071027)
				local var_116_18 = arg_113_1:FormatText(var_116_17.content)

				arg_113_1.text_.text = var_116_18

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_19 = 24
				local var_116_20 = utf8.len(var_116_18)
				local var_116_21 = var_116_19 <= 0 and var_116_15 or var_116_15 * (var_116_20 / var_116_19)

				if var_116_21 > 0 and var_116_15 < var_116_21 then
					arg_113_1.talkMaxDuration = var_116_21

					if var_116_21 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_21 + var_116_14
					end
				end

				arg_113_1.text_.text = var_116_18
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071027", "story_v_out_412071.awb") ~= 0 then
					local var_116_22 = manager.audio:GetVoiceLength("story_v_out_412071", "412071027", "story_v_out_412071.awb") / 1000

					if var_116_22 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_14
					end

					if var_116_17.prefab_name ~= "" and arg_113_1.actors_[var_116_17.prefab_name] ~= nil then
						local var_116_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_17.prefab_name].transform, "story_v_out_412071", "412071027", "story_v_out_412071.awb")

						arg_113_1:RecordAudio("412071027", var_116_23)
						arg_113_1:RecordAudio("412071027", var_116_23)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_412071", "412071027", "story_v_out_412071.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_412071", "412071027", "story_v_out_412071.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_24 = math.max(var_116_15, arg_113_1.talkMaxDuration)

			if var_116_14 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_24 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_14) / var_116_24

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_14 + var_116_24 and arg_113_1.time_ < var_116_14 + var_116_24 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 412071028
		arg_117_1.duration_ = 7.5

		local var_117_0 = {
			zh = 6.533,
			ja = 7.5
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play412071029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.55

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[919].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(412071028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 22
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071028", "story_v_out_412071.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_412071", "412071028", "story_v_out_412071.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_412071", "412071028", "story_v_out_412071.awb")

						arg_117_1:RecordAudio("412071028", var_120_9)
						arg_117_1:RecordAudio("412071028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_412071", "412071028", "story_v_out_412071.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_412071", "412071028", "story_v_out_412071.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play412071029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 412071029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play412071030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10078ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10078ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, 100, 0)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10078ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, 100, 0)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = arg_121_1.actors_["10078ui_story"]
			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10078ui_story == nil then
				arg_121_1.var_.characterEffect10078ui_story = var_124_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if var_124_10 <= arg_121_1.time_ and arg_121_1.time_ < var_124_10 + var_124_11 and not isNil(var_124_9) then
				local var_124_12 = (arg_121_1.time_ - var_124_10) / var_124_11

				if arg_121_1.var_.characterEffect10078ui_story and not isNil(var_124_9) then
					local var_124_13 = Mathf.Lerp(0, 0.5, var_124_12)

					arg_121_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10078ui_story.fillRatio = var_124_13
				end
			end

			if arg_121_1.time_ >= var_124_10 + var_124_11 and arg_121_1.time_ < var_124_10 + var_124_11 + arg_124_0 and not isNil(var_124_9) and arg_121_1.var_.characterEffect10078ui_story then
				local var_124_14 = 0.5

				arg_121_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10078ui_story.fillRatio = var_124_14
			end

			local var_124_15 = manager.ui.mainCamera.transform
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.var_.shakeOldPos = var_124_15.localPosition
			end

			local var_124_17 = 0.6

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / 0.066
				local var_124_19, var_124_20 = math.modf(var_124_18)

				var_124_15.localPosition = Vector3.New(var_124_20 * 0.13, var_124_20 * 0.13, var_124_20 * 0.13) + arg_121_1.var_.shakeOldPos
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 then
				var_124_15.localPosition = arg_121_1.var_.shakeOldPos
			end

			local var_124_21 = 0

			if var_124_21 < arg_121_1.time_ and arg_121_1.time_ <= var_124_21 + arg_124_0 then
				arg_121_1.allBtn_.enabled = false
			end

			local var_124_22 = 0.6

			if arg_121_1.time_ >= var_124_21 + var_124_22 and arg_121_1.time_ < var_124_21 + var_124_22 + arg_124_0 then
				arg_121_1.allBtn_.enabled = true
			end

			local var_124_23 = 0
			local var_124_24 = 0.75

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_25 = arg_121_1:GetWordFromCfg(412071029)
				local var_124_26 = arg_121_1:FormatText(var_124_25.content)

				arg_121_1.text_.text = var_124_26

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_27 = 30
				local var_124_28 = utf8.len(var_124_26)
				local var_124_29 = var_124_27 <= 0 and var_124_24 or var_124_24 * (var_124_28 / var_124_27)

				if var_124_29 > 0 and var_124_24 < var_124_29 then
					arg_121_1.talkMaxDuration = var_124_29

					if var_124_29 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_29 + var_124_23
					end
				end

				arg_121_1.text_.text = var_124_26
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_30 = math.max(var_124_24, arg_121_1.talkMaxDuration)

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_30 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_23) / var_124_30

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_23 + var_124_30 and arg_121_1.time_ < var_124_23 + var_124_30 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 412071030
		arg_125_1.duration_ = 5.87

		local var_125_0 = {
			zh = 5.866,
			ja = 4.633
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
				arg_125_0:Play412071031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10083ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos10083ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, -2.6, -2.8)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10083ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["10083ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect10083ui_story == nil then
				arg_125_1.var_.characterEffect10083ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect10083ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect10083ui_story then
				arg_125_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_15 = 0
			local var_128_16 = 0.625

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_17 = arg_125_1:FormatText(StoryNameCfg[918].name)

				arg_125_1.leftNameTxt_.text = var_128_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:GetWordFromCfg(412071030)
				local var_128_19 = arg_125_1:FormatText(var_128_18.content)

				arg_125_1.text_.text = var_128_19

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071030", "story_v_out_412071.awb") ~= 0 then
					local var_128_23 = manager.audio:GetVoiceLength("story_v_out_412071", "412071030", "story_v_out_412071.awb") / 1000

					if var_128_23 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_15
					end

					if var_128_18.prefab_name ~= "" and arg_125_1.actors_[var_128_18.prefab_name] ~= nil then
						local var_128_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_18.prefab_name].transform, "story_v_out_412071", "412071030", "story_v_out_412071.awb")

						arg_125_1:RecordAudio("412071030", var_128_24)
						arg_125_1:RecordAudio("412071030", var_128_24)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_412071", "412071030", "story_v_out_412071.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_412071", "412071030", "story_v_out_412071.awb")
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
				actorName = "10083ui_story",
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
	Play412071031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 412071031
		arg_129_1.duration_ = 4.93

		local var_129_0 = {
			zh = 3.933,
			ja = 4.933
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
				arg_129_0:Play412071032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1097ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1097ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, -0.54, -6.3)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1097ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = arg_129_1.actors_["1097ui_story"]
			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1097ui_story == nil then
				arg_129_1.var_.characterEffect1097ui_story = var_132_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_11 = 0.200000002980232

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_11 and not isNil(var_132_9) then
				local var_132_12 = (arg_129_1.time_ - var_132_10) / var_132_11

				if arg_129_1.var_.characterEffect1097ui_story and not isNil(var_132_9) then
					arg_129_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_10 + var_132_11 and arg_129_1.time_ < var_132_10 + var_132_11 + arg_132_0 and not isNil(var_132_9) and arg_129_1.var_.characterEffect1097ui_story then
				arg_129_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_132_13 = 0

			if var_132_13 < arg_129_1.time_ and arg_129_1.time_ <= var_132_13 + arg_132_0 then
				arg_129_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_132_14 = 0

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 then
				arg_129_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_132_15 = arg_129_1.actors_["10083ui_story"].transform
			local var_132_16 = 0

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.var_.moveOldPos10083ui_story = var_132_15.localPosition
			end

			local var_132_17 = 0.001

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_17 then
				local var_132_18 = (arg_129_1.time_ - var_132_16) / var_132_17
				local var_132_19 = Vector3.New(0, 100, 0)

				var_132_15.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10083ui_story, var_132_19, var_132_18)

				local var_132_20 = manager.ui.mainCamera.transform.position - var_132_15.position

				var_132_15.forward = Vector3.New(var_132_20.x, var_132_20.y, var_132_20.z)

				local var_132_21 = var_132_15.localEulerAngles

				var_132_21.z = 0
				var_132_21.x = 0
				var_132_15.localEulerAngles = var_132_21
			end

			if arg_129_1.time_ >= var_132_16 + var_132_17 and arg_129_1.time_ < var_132_16 + var_132_17 + arg_132_0 then
				var_132_15.localPosition = Vector3.New(0, 100, 0)

				local var_132_22 = manager.ui.mainCamera.transform.position - var_132_15.position

				var_132_15.forward = Vector3.New(var_132_22.x, var_132_22.y, var_132_22.z)

				local var_132_23 = var_132_15.localEulerAngles

				var_132_23.z = 0
				var_132_23.x = 0
				var_132_15.localEulerAngles = var_132_23
			end

			local var_132_24 = arg_129_1.actors_["10083ui_story"]
			local var_132_25 = 0

			if var_132_25 < arg_129_1.time_ and arg_129_1.time_ <= var_132_25 + arg_132_0 and not isNil(var_132_24) and arg_129_1.var_.characterEffect10083ui_story == nil then
				arg_129_1.var_.characterEffect10083ui_story = var_132_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_26 = 0.200000002980232

			if var_132_25 <= arg_129_1.time_ and arg_129_1.time_ < var_132_25 + var_132_26 and not isNil(var_132_24) then
				local var_132_27 = (arg_129_1.time_ - var_132_25) / var_132_26

				if arg_129_1.var_.characterEffect10083ui_story and not isNil(var_132_24) then
					local var_132_28 = Mathf.Lerp(0, 0.5, var_132_27)

					arg_129_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10083ui_story.fillRatio = var_132_28
				end
			end

			if arg_129_1.time_ >= var_132_25 + var_132_26 and arg_129_1.time_ < var_132_25 + var_132_26 + arg_132_0 and not isNil(var_132_24) and arg_129_1.var_.characterEffect10083ui_story then
				local var_132_29 = 0.5

				arg_129_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10083ui_story.fillRatio = var_132_29
			end

			local var_132_30 = 0
			local var_132_31 = 0.45

			if var_132_30 < arg_129_1.time_ and arg_129_1.time_ <= var_132_30 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_32 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_32:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_129_1.dialogCg_.alpha = arg_133_0
				end))
				var_132_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_33 = arg_129_1:FormatText(StoryNameCfg[216].name)

				arg_129_1.leftNameTxt_.text = var_132_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_34 = arg_129_1:GetWordFromCfg(412071031)
				local var_132_35 = arg_129_1:FormatText(var_132_34.content)

				arg_129_1.text_.text = var_132_35

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_36 = 18
				local var_132_37 = utf8.len(var_132_35)
				local var_132_38 = var_132_36 <= 0 and var_132_31 or var_132_31 * (var_132_37 / var_132_36)

				if var_132_38 > 0 and var_132_31 < var_132_38 then
					arg_129_1.talkMaxDuration = var_132_38
					var_132_30 = var_132_30 + 0.3

					if var_132_38 + var_132_30 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_38 + var_132_30
					end
				end

				arg_129_1.text_.text = var_132_35
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071031", "story_v_out_412071.awb") ~= 0 then
					local var_132_39 = manager.audio:GetVoiceLength("story_v_out_412071", "412071031", "story_v_out_412071.awb") / 1000

					if var_132_39 + var_132_30 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_39 + var_132_30
					end

					if var_132_34.prefab_name ~= "" and arg_129_1.actors_[var_132_34.prefab_name] ~= nil then
						local var_132_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_34.prefab_name].transform, "story_v_out_412071", "412071031", "story_v_out_412071.awb")

						arg_129_1:RecordAudio("412071031", var_132_40)
						arg_129_1:RecordAudio("412071031", var_132_40)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_412071", "412071031", "story_v_out_412071.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_412071", "412071031", "story_v_out_412071.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_41 = var_132_30 + 0.3
			local var_132_42 = math.max(var_132_31, arg_129_1.talkMaxDuration)

			if var_132_41 <= arg_129_1.time_ and arg_129_1.time_ < var_132_41 + var_132_42 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_41) / var_132_42

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_41 + var_132_42 and arg_129_1.time_ < var_132_41 + var_132_42 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412071032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 412071032
		arg_135_1.duration_ = 12.37

		local var_135_0 = {
			zh = 10.433,
			ja = 12.366
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
				arg_135_0:Play412071033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 2.7

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				local var_138_1 = manager.ui.mainCamera.transform.localPosition
				local var_138_2 = Vector3.New(0, 0, 10) + Vector3.New(var_138_1.x, var_138_1.y, 0)
				local var_138_3 = arg_135_1.bgs_.ST85b

				var_138_3.transform.localPosition = var_138_2
				var_138_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_4 = var_138_3:GetComponent("SpriteRenderer")

				if var_138_4 and var_138_4.sprite then
					local var_138_5 = (var_138_3.transform.localPosition - var_138_1).z
					local var_138_6 = manager.ui.mainCameraCom_
					local var_138_7 = 2 * var_138_5 * Mathf.Tan(var_138_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_138_8 = var_138_7 * var_138_6.aspect
					local var_138_9 = var_138_4.sprite.bounds.size.x
					local var_138_10 = var_138_4.sprite.bounds.size.y
					local var_138_11 = var_138_8 / var_138_9
					local var_138_12 = var_138_7 / var_138_10
					local var_138_13 = var_138_12 < var_138_11 and var_138_11 or var_138_12

					var_138_3.transform.localScale = Vector3.New(var_138_13, var_138_13, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "ST85b" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_14 = 4.7

			if var_138_14 < arg_135_1.time_ and arg_135_1.time_ <= var_138_14 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			local var_138_15 = 0.3

			if arg_135_1.time_ >= var_138_14 + var_138_15 and arg_135_1.time_ < var_138_14 + var_138_15 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_16 = 0.7

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_17 = 2

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17
				local var_138_19 = Color.New(0, 0, 0)

				var_138_19.a = Mathf.Lerp(0, 1, var_138_18)
				arg_135_1.mask_.color = var_138_19
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 then
				local var_138_20 = Color.New(0, 0, 0)

				var_138_20.a = 1
				arg_135_1.mask_.color = var_138_20
			end

			local var_138_21 = 2.7

			if var_138_21 < arg_135_1.time_ and arg_135_1.time_ <= var_138_21 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_22 = 2

			if var_138_21 <= arg_135_1.time_ and arg_135_1.time_ < var_138_21 + var_138_22 then
				local var_138_23 = (arg_135_1.time_ - var_138_21) / var_138_22
				local var_138_24 = Color.New(0, 0, 0)

				var_138_24.a = Mathf.Lerp(1, 0, var_138_23)
				arg_135_1.mask_.color = var_138_24
			end

			if arg_135_1.time_ >= var_138_21 + var_138_22 and arg_135_1.time_ < var_138_21 + var_138_22 + arg_138_0 then
				local var_138_25 = Color.New(0, 0, 0)
				local var_138_26 = 0

				arg_135_1.mask_.enabled = false
				var_138_25.a = var_138_26
				arg_135_1.mask_.color = var_138_25
			end

			local var_138_27 = arg_135_1.actors_["1097ui_story"].transform
			local var_138_28 = 2.666

			if var_138_28 < arg_135_1.time_ and arg_135_1.time_ <= var_138_28 + arg_138_0 then
				arg_135_1.var_.moveOldPos1097ui_story = var_138_27.localPosition
			end

			local var_138_29 = 0.001

			if var_138_28 <= arg_135_1.time_ and arg_135_1.time_ < var_138_28 + var_138_29 then
				local var_138_30 = (arg_135_1.time_ - var_138_28) / var_138_29
				local var_138_31 = Vector3.New(0, 100, 0)

				var_138_27.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1097ui_story, var_138_31, var_138_30)

				local var_138_32 = manager.ui.mainCamera.transform.position - var_138_27.position

				var_138_27.forward = Vector3.New(var_138_32.x, var_138_32.y, var_138_32.z)

				local var_138_33 = var_138_27.localEulerAngles

				var_138_33.z = 0
				var_138_33.x = 0
				var_138_27.localEulerAngles = var_138_33
			end

			if arg_135_1.time_ >= var_138_28 + var_138_29 and arg_135_1.time_ < var_138_28 + var_138_29 + arg_138_0 then
				var_138_27.localPosition = Vector3.New(0, 100, 0)

				local var_138_34 = manager.ui.mainCamera.transform.position - var_138_27.position

				var_138_27.forward = Vector3.New(var_138_34.x, var_138_34.y, var_138_34.z)

				local var_138_35 = var_138_27.localEulerAngles

				var_138_35.z = 0
				var_138_35.x = 0
				var_138_27.localEulerAngles = var_138_35
			end

			local var_138_36 = arg_135_1.actors_["1097ui_story"].transform
			local var_138_37 = 4.5

			if var_138_37 < arg_135_1.time_ and arg_135_1.time_ <= var_138_37 + arg_138_0 then
				arg_135_1.var_.moveOldPos1097ui_story = var_138_36.localPosition
			end

			local var_138_38 = 0.001

			if var_138_37 <= arg_135_1.time_ and arg_135_1.time_ < var_138_37 + var_138_38 then
				local var_138_39 = (arg_135_1.time_ - var_138_37) / var_138_38
				local var_138_40 = Vector3.New(0, -0.54, -6.3)

				var_138_36.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1097ui_story, var_138_40, var_138_39)

				local var_138_41 = manager.ui.mainCamera.transform.position - var_138_36.position

				var_138_36.forward = Vector3.New(var_138_41.x, var_138_41.y, var_138_41.z)

				local var_138_42 = var_138_36.localEulerAngles

				var_138_42.z = 0
				var_138_42.x = 0
				var_138_36.localEulerAngles = var_138_42
			end

			if arg_135_1.time_ >= var_138_37 + var_138_38 and arg_135_1.time_ < var_138_37 + var_138_38 + arg_138_0 then
				var_138_36.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_138_43 = manager.ui.mainCamera.transform.position - var_138_36.position

				var_138_36.forward = Vector3.New(var_138_43.x, var_138_43.y, var_138_43.z)

				local var_138_44 = var_138_36.localEulerAngles

				var_138_44.z = 0
				var_138_44.x = 0
				var_138_36.localEulerAngles = var_138_44
			end

			local var_138_45 = 4.5

			if var_138_45 < arg_135_1.time_ and arg_135_1.time_ <= var_138_45 + arg_138_0 then
				arg_135_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_46 = 4.7
			local var_138_47 = 0.7

			if var_138_46 < arg_135_1.time_ and arg_135_1.time_ <= var_138_46 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_48 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_48:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_49 = arg_135_1:FormatText(StoryNameCfg[216].name)

				arg_135_1.leftNameTxt_.text = var_138_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_50 = arg_135_1:GetWordFromCfg(412071032)
				local var_138_51 = arg_135_1:FormatText(var_138_50.content)

				arg_135_1.text_.text = var_138_51

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_52 = 28
				local var_138_53 = utf8.len(var_138_51)
				local var_138_54 = var_138_52 <= 0 and var_138_47 or var_138_47 * (var_138_53 / var_138_52)

				if var_138_54 > 0 and var_138_47 < var_138_54 then
					arg_135_1.talkMaxDuration = var_138_54
					var_138_46 = var_138_46 + 0.3

					if var_138_54 + var_138_46 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_54 + var_138_46
					end
				end

				arg_135_1.text_.text = var_138_51
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071032", "story_v_out_412071.awb") ~= 0 then
					local var_138_55 = manager.audio:GetVoiceLength("story_v_out_412071", "412071032", "story_v_out_412071.awb") / 1000

					if var_138_55 + var_138_46 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_55 + var_138_46
					end

					if var_138_50.prefab_name ~= "" and arg_135_1.actors_[var_138_50.prefab_name] ~= nil then
						local var_138_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_50.prefab_name].transform, "story_v_out_412071", "412071032", "story_v_out_412071.awb")

						arg_135_1:RecordAudio("412071032", var_138_56)
						arg_135_1:RecordAudio("412071032", var_138_56)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_412071", "412071032", "story_v_out_412071.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_412071", "412071032", "story_v_out_412071.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_57 = var_138_46 + 0.3
			local var_138_58 = math.max(var_138_47, arg_135_1.talkMaxDuration)

			if var_138_57 <= arg_135_1.time_ and arg_135_1.time_ < var_138_57 + var_138_58 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_57) / var_138_58

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_57 + var_138_58 and arg_135_1.time_ < var_138_57 + var_138_58 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play412071033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 412071033
		arg_141_1.duration_ = 4.07

		local var_141_0 = {
			zh = 4.066,
			ja = 2.5
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play412071034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10078ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10078ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, -0.5, -6.3)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10078ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["10078ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect10078ui_story == nil then
				arg_141_1.var_.characterEffect10078ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect10078ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect10078ui_story then
				arg_141_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_144_13 = 0

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_15 = arg_141_1.actors_["1097ui_story"].transform
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.var_.moveOldPos1097ui_story = var_144_15.localPosition
			end

			local var_144_17 = 0.001

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_17 then
				local var_144_18 = (arg_141_1.time_ - var_144_16) / var_144_17
				local var_144_19 = Vector3.New(0, 100, 0)

				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1097ui_story, var_144_19, var_144_18)

				local var_144_20 = manager.ui.mainCamera.transform.position - var_144_15.position

				var_144_15.forward = Vector3.New(var_144_20.x, var_144_20.y, var_144_20.z)

				local var_144_21 = var_144_15.localEulerAngles

				var_144_21.z = 0
				var_144_21.x = 0
				var_144_15.localEulerAngles = var_144_21
			end

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(0, 100, 0)

				local var_144_22 = manager.ui.mainCamera.transform.position - var_144_15.position

				var_144_15.forward = Vector3.New(var_144_22.x, var_144_22.y, var_144_22.z)

				local var_144_23 = var_144_15.localEulerAngles

				var_144_23.z = 0
				var_144_23.x = 0
				var_144_15.localEulerAngles = var_144_23
			end

			local var_144_24 = arg_141_1.actors_["1097ui_story"]
			local var_144_25 = 0

			if var_144_25 < arg_141_1.time_ and arg_141_1.time_ <= var_144_25 + arg_144_0 and not isNil(var_144_24) and arg_141_1.var_.characterEffect1097ui_story == nil then
				arg_141_1.var_.characterEffect1097ui_story = var_144_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_26 = 0.200000002980232

			if var_144_25 <= arg_141_1.time_ and arg_141_1.time_ < var_144_25 + var_144_26 and not isNil(var_144_24) then
				local var_144_27 = (arg_141_1.time_ - var_144_25) / var_144_26

				if arg_141_1.var_.characterEffect1097ui_story and not isNil(var_144_24) then
					local var_144_28 = Mathf.Lerp(0, 0.5, var_144_27)

					arg_141_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1097ui_story.fillRatio = var_144_28
				end
			end

			if arg_141_1.time_ >= var_144_25 + var_144_26 and arg_141_1.time_ < var_144_25 + var_144_26 + arg_144_0 and not isNil(var_144_24) and arg_141_1.var_.characterEffect1097ui_story then
				local var_144_29 = 0.5

				arg_141_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1097ui_story.fillRatio = var_144_29
			end

			local var_144_30 = 0
			local var_144_31 = 0.25

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_32 = arg_141_1:FormatText(StoryNameCfg[919].name)

				arg_141_1.leftNameTxt_.text = var_144_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_33 = arg_141_1:GetWordFromCfg(412071033)
				local var_144_34 = arg_141_1:FormatText(var_144_33.content)

				arg_141_1.text_.text = var_144_34

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_35 = 10
				local var_144_36 = utf8.len(var_144_34)
				local var_144_37 = var_144_35 <= 0 and var_144_31 or var_144_31 * (var_144_36 / var_144_35)

				if var_144_37 > 0 and var_144_31 < var_144_37 then
					arg_141_1.talkMaxDuration = var_144_37

					if var_144_37 + var_144_30 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_37 + var_144_30
					end
				end

				arg_141_1.text_.text = var_144_34
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071033", "story_v_out_412071.awb") ~= 0 then
					local var_144_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071033", "story_v_out_412071.awb") / 1000

					if var_144_38 + var_144_30 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_38 + var_144_30
					end

					if var_144_33.prefab_name ~= "" and arg_141_1.actors_[var_144_33.prefab_name] ~= nil then
						local var_144_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_33.prefab_name].transform, "story_v_out_412071", "412071033", "story_v_out_412071.awb")

						arg_141_1:RecordAudio("412071033", var_144_39)
						arg_141_1:RecordAudio("412071033", var_144_39)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_412071", "412071033", "story_v_out_412071.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_412071", "412071033", "story_v_out_412071.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_40 = math.max(var_144_31, arg_141_1.talkMaxDuration)

			if var_144_30 <= arg_141_1.time_ and arg_141_1.time_ < var_144_30 + var_144_40 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_30) / var_144_40

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_30 + var_144_40 and arg_141_1.time_ < var_144_30 + var_144_40 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play412071034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 412071034
		arg_145_1.duration_ = 10.77

		local var_145_0 = {
			zh = 7.566,
			ja = 10.766
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
				arg_145_0:Play412071035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.525

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[919].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(412071034)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 21
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071034", "story_v_out_412071.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_412071", "412071034", "story_v_out_412071.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_412071", "412071034", "story_v_out_412071.awb")

						arg_145_1:RecordAudio("412071034", var_148_9)
						arg_145_1:RecordAudio("412071034", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_412071", "412071034", "story_v_out_412071.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_412071", "412071034", "story_v_out_412071.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play412071035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 412071035
		arg_149_1.duration_ = 7.5

		local var_149_0 = {
			zh = 5.866,
			ja = 7.5
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
				arg_149_0:Play412071036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1097ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1097ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(0.7, -0.54, -6.3)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1097ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1097ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1097ui_story == nil then
				arg_149_1.var_.characterEffect1097ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect1097ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1097ui_story then
				arg_149_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_152_13 = 0

			if var_152_13 < arg_149_1.time_ and arg_149_1.time_ <= var_152_13 + arg_152_0 then
				arg_149_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				arg_149_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_152_15 = arg_149_1.actors_["10078ui_story"].transform
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.var_.moveOldPos10078ui_story = var_152_15.localPosition
			end

			local var_152_17 = 0.001

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 then
				local var_152_18 = (arg_149_1.time_ - var_152_16) / var_152_17
				local var_152_19 = Vector3.New(-0.7, -0.5, -6.3)

				var_152_15.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10078ui_story, var_152_19, var_152_18)

				local var_152_20 = manager.ui.mainCamera.transform.position - var_152_15.position

				var_152_15.forward = Vector3.New(var_152_20.x, var_152_20.y, var_152_20.z)

				local var_152_21 = var_152_15.localEulerAngles

				var_152_21.z = 0
				var_152_21.x = 0
				var_152_15.localEulerAngles = var_152_21
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 then
				var_152_15.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_152_22 = manager.ui.mainCamera.transform.position - var_152_15.position

				var_152_15.forward = Vector3.New(var_152_22.x, var_152_22.y, var_152_22.z)

				local var_152_23 = var_152_15.localEulerAngles

				var_152_23.z = 0
				var_152_23.x = 0
				var_152_15.localEulerAngles = var_152_23
			end

			local var_152_24 = arg_149_1.actors_["10078ui_story"]
			local var_152_25 = 0

			if var_152_25 < arg_149_1.time_ and arg_149_1.time_ <= var_152_25 + arg_152_0 and not isNil(var_152_24) and arg_149_1.var_.characterEffect10078ui_story == nil then
				arg_149_1.var_.characterEffect10078ui_story = var_152_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_26 = 0.200000002980232

			if var_152_25 <= arg_149_1.time_ and arg_149_1.time_ < var_152_25 + var_152_26 and not isNil(var_152_24) then
				local var_152_27 = (arg_149_1.time_ - var_152_25) / var_152_26

				if arg_149_1.var_.characterEffect10078ui_story and not isNil(var_152_24) then
					local var_152_28 = Mathf.Lerp(0, 0.5, var_152_27)

					arg_149_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10078ui_story.fillRatio = var_152_28
				end
			end

			if arg_149_1.time_ >= var_152_25 + var_152_26 and arg_149_1.time_ < var_152_25 + var_152_26 + arg_152_0 and not isNil(var_152_24) and arg_149_1.var_.characterEffect10078ui_story then
				local var_152_29 = 0.5

				arg_149_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10078ui_story.fillRatio = var_152_29
			end

			local var_152_30 = 0
			local var_152_31 = 0.575

			if var_152_30 < arg_149_1.time_ and arg_149_1.time_ <= var_152_30 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_32 = arg_149_1:FormatText(StoryNameCfg[216].name)

				arg_149_1.leftNameTxt_.text = var_152_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_33 = arg_149_1:GetWordFromCfg(412071035)
				local var_152_34 = arg_149_1:FormatText(var_152_33.content)

				arg_149_1.text_.text = var_152_34

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_35 = 23
				local var_152_36 = utf8.len(var_152_34)
				local var_152_37 = var_152_35 <= 0 and var_152_31 or var_152_31 * (var_152_36 / var_152_35)

				if var_152_37 > 0 and var_152_31 < var_152_37 then
					arg_149_1.talkMaxDuration = var_152_37

					if var_152_37 + var_152_30 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_37 + var_152_30
					end
				end

				arg_149_1.text_.text = var_152_34
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071035", "story_v_out_412071.awb") ~= 0 then
					local var_152_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071035", "story_v_out_412071.awb") / 1000

					if var_152_38 + var_152_30 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_38 + var_152_30
					end

					if var_152_33.prefab_name ~= "" and arg_149_1.actors_[var_152_33.prefab_name] ~= nil then
						local var_152_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_33.prefab_name].transform, "story_v_out_412071", "412071035", "story_v_out_412071.awb")

						arg_149_1:RecordAudio("412071035", var_152_39)
						arg_149_1:RecordAudio("412071035", var_152_39)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_412071", "412071035", "story_v_out_412071.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_412071", "412071035", "story_v_out_412071.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_40 = math.max(var_152_31, arg_149_1.talkMaxDuration)

			if var_152_30 <= arg_149_1.time_ and arg_149_1.time_ < var_152_30 + var_152_40 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_30) / var_152_40

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_30 + var_152_40 and arg_149_1.time_ < var_152_30 + var_152_40 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 412071036
		arg_153_1.duration_ = 5.37

		local var_153_0 = {
			zh = 3.8,
			ja = 5.366
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
				arg_153_0:Play412071037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10078ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10078ui_story == nil then
				arg_153_1.var_.characterEffect10078ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect10078ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10078ui_story then
				arg_153_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_156_4 = 0

			if var_156_4 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_5 = arg_153_1.actors_["1097ui_story"]
			local var_156_6 = 0

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1097ui_story == nil then
				arg_153_1.var_.characterEffect1097ui_story = var_156_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_7 = 0.200000002980232

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_7 and not isNil(var_156_5) then
				local var_156_8 = (arg_153_1.time_ - var_156_6) / var_156_7

				if arg_153_1.var_.characterEffect1097ui_story and not isNil(var_156_5) then
					local var_156_9 = Mathf.Lerp(0, 0.5, var_156_8)

					arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1097ui_story.fillRatio = var_156_9
				end
			end

			if arg_153_1.time_ >= var_156_6 + var_156_7 and arg_153_1.time_ < var_156_6 + var_156_7 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1097ui_story then
				local var_156_10 = 0.5

				arg_153_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1097ui_story.fillRatio = var_156_10
			end

			local var_156_11 = 0
			local var_156_12 = 0.25

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_13 = arg_153_1:FormatText(StoryNameCfg[919].name)

				arg_153_1.leftNameTxt_.text = var_156_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_14 = arg_153_1:GetWordFromCfg(412071036)
				local var_156_15 = arg_153_1:FormatText(var_156_14.content)

				arg_153_1.text_.text = var_156_15

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071036", "story_v_out_412071.awb") ~= 0 then
					local var_156_19 = manager.audio:GetVoiceLength("story_v_out_412071", "412071036", "story_v_out_412071.awb") / 1000

					if var_156_19 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_11
					end

					if var_156_14.prefab_name ~= "" and arg_153_1.actors_[var_156_14.prefab_name] ~= nil then
						local var_156_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_14.prefab_name].transform, "story_v_out_412071", "412071036", "story_v_out_412071.awb")

						arg_153_1:RecordAudio("412071036", var_156_20)
						arg_153_1:RecordAudio("412071036", var_156_20)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_412071", "412071036", "story_v_out_412071.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_412071", "412071036", "story_v_out_412071.awb")
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
	Play412071037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 412071037
		arg_157_1.duration_ = 12.67

		local var_157_0 = {
			zh = 5.6,
			ja = 12.666
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
				arg_157_0:Play412071038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1097ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1097ui_story == nil then
				arg_157_1.var_.characterEffect1097ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1097ui_story and not isNil(var_160_0) then
					arg_157_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1097ui_story then
				arg_157_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_160_4 = 0

			if var_160_4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_160_5 = 0

			if var_160_5 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_160_6 = arg_157_1.actors_["10078ui_story"]
			local var_160_7 = 0

			if var_160_7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect10078ui_story == nil then
				arg_157_1.var_.characterEffect10078ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.200000002980232

			if var_160_7 <= arg_157_1.time_ and arg_157_1.time_ < var_160_7 + var_160_8 and not isNil(var_160_6) then
				local var_160_9 = (arg_157_1.time_ - var_160_7) / var_160_8

				if arg_157_1.var_.characterEffect10078ui_story and not isNil(var_160_6) then
					local var_160_10 = Mathf.Lerp(0, 0.5, var_160_9)

					arg_157_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10078ui_story.fillRatio = var_160_10
				end
			end

			if arg_157_1.time_ >= var_160_7 + var_160_8 and arg_157_1.time_ < var_160_7 + var_160_8 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect10078ui_story then
				local var_160_11 = 0.5

				arg_157_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10078ui_story.fillRatio = var_160_11
			end

			local var_160_12 = 0
			local var_160_13 = 0.6

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_14 = arg_157_1:FormatText(StoryNameCfg[216].name)

				arg_157_1.leftNameTxt_.text = var_160_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_15 = arg_157_1:GetWordFromCfg(412071037)
				local var_160_16 = arg_157_1:FormatText(var_160_15.content)

				arg_157_1.text_.text = var_160_16

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_17 = 24
				local var_160_18 = utf8.len(var_160_16)
				local var_160_19 = var_160_17 <= 0 and var_160_13 or var_160_13 * (var_160_18 / var_160_17)

				if var_160_19 > 0 and var_160_13 < var_160_19 then
					arg_157_1.talkMaxDuration = var_160_19

					if var_160_19 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_12
					end
				end

				arg_157_1.text_.text = var_160_16
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071037", "story_v_out_412071.awb") ~= 0 then
					local var_160_20 = manager.audio:GetVoiceLength("story_v_out_412071", "412071037", "story_v_out_412071.awb") / 1000

					if var_160_20 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_20 + var_160_12
					end

					if var_160_15.prefab_name ~= "" and arg_157_1.actors_[var_160_15.prefab_name] ~= nil then
						local var_160_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_15.prefab_name].transform, "story_v_out_412071", "412071037", "story_v_out_412071.awb")

						arg_157_1:RecordAudio("412071037", var_160_21)
						arg_157_1:RecordAudio("412071037", var_160_21)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_412071", "412071037", "story_v_out_412071.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_412071", "412071037", "story_v_out_412071.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_22 = math.max(var_160_13, arg_157_1.talkMaxDuration)

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_22 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_12) / var_160_22

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_12 + var_160_22 and arg_157_1.time_ < var_160_12 + var_160_22 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play412071038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 412071038
		arg_161_1.duration_ = 10

		local var_161_0 = {
			zh = 10,
			ja = 8.233
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
				arg_161_0:Play412071039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.975

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[216].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(412071038)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 39
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071038", "story_v_out_412071.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_412071", "412071038", "story_v_out_412071.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_412071", "412071038", "story_v_out_412071.awb")

						arg_161_1:RecordAudio("412071038", var_164_9)
						arg_161_1:RecordAudio("412071038", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_412071", "412071038", "story_v_out_412071.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_412071", "412071038", "story_v_out_412071.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play412071039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 412071039
		arg_165_1.duration_ = 3.1

		local var_165_0 = {
			zh = 3.1,
			ja = 2.833
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
				arg_165_0:Play412071040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10078ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10078ui_story == nil then
				arg_165_1.var_.characterEffect10078ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect10078ui_story and not isNil(var_168_0) then
					arg_165_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10078ui_story then
				arg_165_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_168_4 = 0

			if var_168_4 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			local var_168_5 = 0

			if var_168_5 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_6 = arg_165_1.actors_["10078ui_story"]
			local var_168_7 = 0

			if var_168_7 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect10078ui_story == nil then
				arg_165_1.var_.characterEffect10078ui_story = var_168_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_8 = 0.200000002980232

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_8 and not isNil(var_168_6) then
				local var_168_9 = (arg_165_1.time_ - var_168_7) / var_168_8

				if arg_165_1.var_.characterEffect10078ui_story and not isNil(var_168_6) then
					arg_165_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_7 + var_168_8 and arg_165_1.time_ < var_168_7 + var_168_8 + arg_168_0 and not isNil(var_168_6) and arg_165_1.var_.characterEffect10078ui_story then
				arg_165_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_168_10 = 0
			local var_168_11 = 0.225

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_12 = arg_165_1:FormatText(StoryNameCfg[919].name)

				arg_165_1.leftNameTxt_.text = var_168_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_13 = arg_165_1:GetWordFromCfg(412071039)
				local var_168_14 = arg_165_1:FormatText(var_168_13.content)

				arg_165_1.text_.text = var_168_14

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_15 = 9
				local var_168_16 = utf8.len(var_168_14)
				local var_168_17 = var_168_15 <= 0 and var_168_11 or var_168_11 * (var_168_16 / var_168_15)

				if var_168_17 > 0 and var_168_11 < var_168_17 then
					arg_165_1.talkMaxDuration = var_168_17

					if var_168_17 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_17 + var_168_10
					end
				end

				arg_165_1.text_.text = var_168_14
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071039", "story_v_out_412071.awb") ~= 0 then
					local var_168_18 = manager.audio:GetVoiceLength("story_v_out_412071", "412071039", "story_v_out_412071.awb") / 1000

					if var_168_18 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_18 + var_168_10
					end

					if var_168_13.prefab_name ~= "" and arg_165_1.actors_[var_168_13.prefab_name] ~= nil then
						local var_168_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_13.prefab_name].transform, "story_v_out_412071", "412071039", "story_v_out_412071.awb")

						arg_165_1:RecordAudio("412071039", var_168_19)
						arg_165_1:RecordAudio("412071039", var_168_19)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_412071", "412071039", "story_v_out_412071.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_412071", "412071039", "story_v_out_412071.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_20 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_20 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_10) / var_168_20

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_10 + var_168_20 and arg_165_1.time_ < var_168_10 + var_168_20 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play412071040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 412071040
		arg_169_1.duration_ = 17.33

		local var_169_0 = {
			zh = 6.9,
			ja = 17.333
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
				arg_169_0:Play412071041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1097ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1097ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0.7, -0.54, -6.3)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1097ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1097ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1097ui_story == nil then
				arg_169_1.var_.characterEffect1097ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1097ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1097ui_story then
				arg_169_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_172_13 = 0

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_15 = arg_169_1.actors_["10078ui_story"]
			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.characterEffect10078ui_story == nil then
				arg_169_1.var_.characterEffect10078ui_story = var_172_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_17 = 0.200000002980232

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 and not isNil(var_172_15) then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17

				if arg_169_1.var_.characterEffect10078ui_story and not isNil(var_172_15) then
					local var_172_19 = Mathf.Lerp(0, 0.5, var_172_18)

					arg_169_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10078ui_story.fillRatio = var_172_19
				end
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.characterEffect10078ui_story then
				local var_172_20 = 0.5

				arg_169_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10078ui_story.fillRatio = var_172_20
			end

			local var_172_21 = 0
			local var_172_22 = 0.75

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_23 = arg_169_1:FormatText(StoryNameCfg[216].name)

				arg_169_1.leftNameTxt_.text = var_172_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_24 = arg_169_1:GetWordFromCfg(412071040)
				local var_172_25 = arg_169_1:FormatText(var_172_24.content)

				arg_169_1.text_.text = var_172_25

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_26 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071040", "story_v_out_412071.awb") ~= 0 then
					local var_172_29 = manager.audio:GetVoiceLength("story_v_out_412071", "412071040", "story_v_out_412071.awb") / 1000

					if var_172_29 + var_172_21 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_29 + var_172_21
					end

					if var_172_24.prefab_name ~= "" and arg_169_1.actors_[var_172_24.prefab_name] ~= nil then
						local var_172_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_24.prefab_name].transform, "story_v_out_412071", "412071040", "story_v_out_412071.awb")

						arg_169_1:RecordAudio("412071040", var_172_30)
						arg_169_1:RecordAudio("412071040", var_172_30)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_412071", "412071040", "story_v_out_412071.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_412071", "412071040", "story_v_out_412071.awb")
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
				actorName = "1097ui_story",
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
	Play412071041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 412071041
		arg_173_1.duration_ = 10.3

		local var_173_0 = {
			zh = 10.3,
			ja = 10.166
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
				arg_173_0:Play412071042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10083ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10083ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, -2.6, -2.8)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10083ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["10083ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect10083ui_story == nil then
				arg_173_1.var_.characterEffect10083ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect10083ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect10083ui_story then
				arg_173_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_15 = arg_173_1.actors_["10078ui_story"].transform
			local var_176_16 = 0

			if var_176_16 < arg_173_1.time_ and arg_173_1.time_ <= var_176_16 + arg_176_0 then
				arg_173_1.var_.moveOldPos10078ui_story = var_176_15.localPosition
			end

			local var_176_17 = 0.001

			if var_176_16 <= arg_173_1.time_ and arg_173_1.time_ < var_176_16 + var_176_17 then
				local var_176_18 = (arg_173_1.time_ - var_176_16) / var_176_17
				local var_176_19 = Vector3.New(0, 100, 0)

				var_176_15.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10078ui_story, var_176_19, var_176_18)

				local var_176_20 = manager.ui.mainCamera.transform.position - var_176_15.position

				var_176_15.forward = Vector3.New(var_176_20.x, var_176_20.y, var_176_20.z)

				local var_176_21 = var_176_15.localEulerAngles

				var_176_21.z = 0
				var_176_21.x = 0
				var_176_15.localEulerAngles = var_176_21
			end

			if arg_173_1.time_ >= var_176_16 + var_176_17 and arg_173_1.time_ < var_176_16 + var_176_17 + arg_176_0 then
				var_176_15.localPosition = Vector3.New(0, 100, 0)

				local var_176_22 = manager.ui.mainCamera.transform.position - var_176_15.position

				var_176_15.forward = Vector3.New(var_176_22.x, var_176_22.y, var_176_22.z)

				local var_176_23 = var_176_15.localEulerAngles

				var_176_23.z = 0
				var_176_23.x = 0
				var_176_15.localEulerAngles = var_176_23
			end

			local var_176_24 = arg_173_1.actors_["10078ui_story"]
			local var_176_25 = 0

			if var_176_25 < arg_173_1.time_ and arg_173_1.time_ <= var_176_25 + arg_176_0 and not isNil(var_176_24) and arg_173_1.var_.characterEffect10078ui_story == nil then
				arg_173_1.var_.characterEffect10078ui_story = var_176_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_26 = 0.200000002980232

			if var_176_25 <= arg_173_1.time_ and arg_173_1.time_ < var_176_25 + var_176_26 and not isNil(var_176_24) then
				local var_176_27 = (arg_173_1.time_ - var_176_25) / var_176_26

				if arg_173_1.var_.characterEffect10078ui_story and not isNil(var_176_24) then
					local var_176_28 = Mathf.Lerp(0, 0.5, var_176_27)

					arg_173_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10078ui_story.fillRatio = var_176_28
				end
			end

			if arg_173_1.time_ >= var_176_25 + var_176_26 and arg_173_1.time_ < var_176_25 + var_176_26 + arg_176_0 and not isNil(var_176_24) and arg_173_1.var_.characterEffect10078ui_story then
				local var_176_29 = 0.5

				arg_173_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10078ui_story.fillRatio = var_176_29
			end

			local var_176_30 = arg_173_1.actors_["1097ui_story"].transform
			local var_176_31 = 0

			if var_176_31 < arg_173_1.time_ and arg_173_1.time_ <= var_176_31 + arg_176_0 then
				arg_173_1.var_.moveOldPos1097ui_story = var_176_30.localPosition
			end

			local var_176_32 = 0.001

			if var_176_31 <= arg_173_1.time_ and arg_173_1.time_ < var_176_31 + var_176_32 then
				local var_176_33 = (arg_173_1.time_ - var_176_31) / var_176_32
				local var_176_34 = Vector3.New(0, 100, 0)

				var_176_30.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1097ui_story, var_176_34, var_176_33)

				local var_176_35 = manager.ui.mainCamera.transform.position - var_176_30.position

				var_176_30.forward = Vector3.New(var_176_35.x, var_176_35.y, var_176_35.z)

				local var_176_36 = var_176_30.localEulerAngles

				var_176_36.z = 0
				var_176_36.x = 0
				var_176_30.localEulerAngles = var_176_36
			end

			if arg_173_1.time_ >= var_176_31 + var_176_32 and arg_173_1.time_ < var_176_31 + var_176_32 + arg_176_0 then
				var_176_30.localPosition = Vector3.New(0, 100, 0)

				local var_176_37 = manager.ui.mainCamera.transform.position - var_176_30.position

				var_176_30.forward = Vector3.New(var_176_37.x, var_176_37.y, var_176_37.z)

				local var_176_38 = var_176_30.localEulerAngles

				var_176_38.z = 0
				var_176_38.x = 0
				var_176_30.localEulerAngles = var_176_38
			end

			local var_176_39 = arg_173_1.actors_["1097ui_story"]
			local var_176_40 = 0

			if var_176_40 < arg_173_1.time_ and arg_173_1.time_ <= var_176_40 + arg_176_0 and not isNil(var_176_39) and arg_173_1.var_.characterEffect1097ui_story == nil then
				arg_173_1.var_.characterEffect1097ui_story = var_176_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_41 = 0.200000002980232

			if var_176_40 <= arg_173_1.time_ and arg_173_1.time_ < var_176_40 + var_176_41 and not isNil(var_176_39) then
				local var_176_42 = (arg_173_1.time_ - var_176_40) / var_176_41

				if arg_173_1.var_.characterEffect1097ui_story and not isNil(var_176_39) then
					local var_176_43 = Mathf.Lerp(0, 0.5, var_176_42)

					arg_173_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1097ui_story.fillRatio = var_176_43
				end
			end

			if arg_173_1.time_ >= var_176_40 + var_176_41 and arg_173_1.time_ < var_176_40 + var_176_41 + arg_176_0 and not isNil(var_176_39) and arg_173_1.var_.characterEffect1097ui_story then
				local var_176_44 = 0.5

				arg_173_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1097ui_story.fillRatio = var_176_44
			end

			local var_176_45 = 0
			local var_176_46 = 1.35

			if var_176_45 < arg_173_1.time_ and arg_173_1.time_ <= var_176_45 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_47 = arg_173_1:FormatText(StoryNameCfg[918].name)

				arg_173_1.leftNameTxt_.text = var_176_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_48 = arg_173_1:GetWordFromCfg(412071041)
				local var_176_49 = arg_173_1:FormatText(var_176_48.content)

				arg_173_1.text_.text = var_176_49

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_50 = 54
				local var_176_51 = utf8.len(var_176_49)
				local var_176_52 = var_176_50 <= 0 and var_176_46 or var_176_46 * (var_176_51 / var_176_50)

				if var_176_52 > 0 and var_176_46 < var_176_52 then
					arg_173_1.talkMaxDuration = var_176_52

					if var_176_52 + var_176_45 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_52 + var_176_45
					end
				end

				arg_173_1.text_.text = var_176_49
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071041", "story_v_out_412071.awb") ~= 0 then
					local var_176_53 = manager.audio:GetVoiceLength("story_v_out_412071", "412071041", "story_v_out_412071.awb") / 1000

					if var_176_53 + var_176_45 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_53 + var_176_45
					end

					if var_176_48.prefab_name ~= "" and arg_173_1.actors_[var_176_48.prefab_name] ~= nil then
						local var_176_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_48.prefab_name].transform, "story_v_out_412071", "412071041", "story_v_out_412071.awb")

						arg_173_1:RecordAudio("412071041", var_176_54)
						arg_173_1:RecordAudio("412071041", var_176_54)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_412071", "412071041", "story_v_out_412071.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_412071", "412071041", "story_v_out_412071.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_55 = math.max(var_176_46, arg_173_1.talkMaxDuration)

			if var_176_45 <= arg_173_1.time_ and arg_173_1.time_ < var_176_45 + var_176_55 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_45) / var_176_55

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_45 + var_176_55 and arg_173_1.time_ < var_176_45 + var_176_55 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 412071042
		arg_177_1.duration_ = 5.37

		local var_177_0 = {
			zh = 5.366,
			ja = 4.933
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
				arg_177_0:Play412071043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10078ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10078ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, -0.5, -6.3)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10078ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["10078ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect10078ui_story == nil then
				arg_177_1.var_.characterEffect10078ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect10078ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect10078ui_story then
				arg_177_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_180_13 = 0

			if var_180_13 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_14 = arg_177_1.actors_["10083ui_story"].transform
			local var_180_15 = 0

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.var_.moveOldPos10083ui_story = var_180_14.localPosition
			end

			local var_180_16 = 0.001

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_16 then
				local var_180_17 = (arg_177_1.time_ - var_180_15) / var_180_16
				local var_180_18 = Vector3.New(0, 100, 0)

				var_180_14.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10083ui_story, var_180_18, var_180_17)

				local var_180_19 = manager.ui.mainCamera.transform.position - var_180_14.position

				var_180_14.forward = Vector3.New(var_180_19.x, var_180_19.y, var_180_19.z)

				local var_180_20 = var_180_14.localEulerAngles

				var_180_20.z = 0
				var_180_20.x = 0
				var_180_14.localEulerAngles = var_180_20
			end

			if arg_177_1.time_ >= var_180_15 + var_180_16 and arg_177_1.time_ < var_180_15 + var_180_16 + arg_180_0 then
				var_180_14.localPosition = Vector3.New(0, 100, 0)

				local var_180_21 = manager.ui.mainCamera.transform.position - var_180_14.position

				var_180_14.forward = Vector3.New(var_180_21.x, var_180_21.y, var_180_21.z)

				local var_180_22 = var_180_14.localEulerAngles

				var_180_22.z = 0
				var_180_22.x = 0
				var_180_14.localEulerAngles = var_180_22
			end

			local var_180_23 = arg_177_1.actors_["10083ui_story"]
			local var_180_24 = 0

			if var_180_24 < arg_177_1.time_ and arg_177_1.time_ <= var_180_24 + arg_180_0 and not isNil(var_180_23) and arg_177_1.var_.characterEffect10083ui_story == nil then
				arg_177_1.var_.characterEffect10083ui_story = var_180_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_25 = 0.200000002980232

			if var_180_24 <= arg_177_1.time_ and arg_177_1.time_ < var_180_24 + var_180_25 and not isNil(var_180_23) then
				local var_180_26 = (arg_177_1.time_ - var_180_24) / var_180_25

				if arg_177_1.var_.characterEffect10083ui_story and not isNil(var_180_23) then
					local var_180_27 = Mathf.Lerp(0, 0.5, var_180_26)

					arg_177_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10083ui_story.fillRatio = var_180_27
				end
			end

			if arg_177_1.time_ >= var_180_24 + var_180_25 and arg_177_1.time_ < var_180_24 + var_180_25 + arg_180_0 and not isNil(var_180_23) and arg_177_1.var_.characterEffect10083ui_story then
				local var_180_28 = 0.5

				arg_177_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10083ui_story.fillRatio = var_180_28
			end

			local var_180_29 = 0
			local var_180_30 = 0.325

			if var_180_29 < arg_177_1.time_ and arg_177_1.time_ <= var_180_29 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_31 = arg_177_1:FormatText(StoryNameCfg[919].name)

				arg_177_1.leftNameTxt_.text = var_180_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_32 = arg_177_1:GetWordFromCfg(412071042)
				local var_180_33 = arg_177_1:FormatText(var_180_32.content)

				arg_177_1.text_.text = var_180_33

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_34 = 13
				local var_180_35 = utf8.len(var_180_33)
				local var_180_36 = var_180_34 <= 0 and var_180_30 or var_180_30 * (var_180_35 / var_180_34)

				if var_180_36 > 0 and var_180_30 < var_180_36 then
					arg_177_1.talkMaxDuration = var_180_36

					if var_180_36 + var_180_29 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_36 + var_180_29
					end
				end

				arg_177_1.text_.text = var_180_33
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071042", "story_v_out_412071.awb") ~= 0 then
					local var_180_37 = manager.audio:GetVoiceLength("story_v_out_412071", "412071042", "story_v_out_412071.awb") / 1000

					if var_180_37 + var_180_29 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_37 + var_180_29
					end

					if var_180_32.prefab_name ~= "" and arg_177_1.actors_[var_180_32.prefab_name] ~= nil then
						local var_180_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_32.prefab_name].transform, "story_v_out_412071", "412071042", "story_v_out_412071.awb")

						arg_177_1:RecordAudio("412071042", var_180_38)
						arg_177_1:RecordAudio("412071042", var_180_38)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_412071", "412071042", "story_v_out_412071.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_412071", "412071042", "story_v_out_412071.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_39 = math.max(var_180_30, arg_177_1.talkMaxDuration)

			if var_180_29 <= arg_177_1.time_ and arg_177_1.time_ < var_180_29 + var_180_39 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_29) / var_180_39

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_29 + var_180_39 and arg_177_1.time_ < var_180_29 + var_180_39 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412071043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 412071043
		arg_181_1.duration_ = 9.23

		local var_181_0 = {
			zh = 8.166,
			ja = 9.233
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play412071044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10083ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10083ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0, -2.6, -2.8)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10083ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["10083ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect10083ui_story == nil then
				arg_181_1.var_.characterEffect10083ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect10083ui_story and not isNil(var_184_9) then
					arg_181_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect10083ui_story then
				arg_181_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_184_13 = 0

			if var_184_13 < arg_181_1.time_ and arg_181_1.time_ <= var_184_13 + arg_184_0 then
				arg_181_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action4_1")
			end

			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				arg_181_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_15 = arg_181_1.actors_["10078ui_story"].transform
			local var_184_16 = 0

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.var_.moveOldPos10078ui_story = var_184_15.localPosition
			end

			local var_184_17 = 0.001

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_17 then
				local var_184_18 = (arg_181_1.time_ - var_184_16) / var_184_17
				local var_184_19 = Vector3.New(0, 100, 0)

				var_184_15.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10078ui_story, var_184_19, var_184_18)

				local var_184_20 = manager.ui.mainCamera.transform.position - var_184_15.position

				var_184_15.forward = Vector3.New(var_184_20.x, var_184_20.y, var_184_20.z)

				local var_184_21 = var_184_15.localEulerAngles

				var_184_21.z = 0
				var_184_21.x = 0
				var_184_15.localEulerAngles = var_184_21
			end

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 then
				var_184_15.localPosition = Vector3.New(0, 100, 0)

				local var_184_22 = manager.ui.mainCamera.transform.position - var_184_15.position

				var_184_15.forward = Vector3.New(var_184_22.x, var_184_22.y, var_184_22.z)

				local var_184_23 = var_184_15.localEulerAngles

				var_184_23.z = 0
				var_184_23.x = 0
				var_184_15.localEulerAngles = var_184_23
			end

			local var_184_24 = arg_181_1.actors_["10078ui_story"]
			local var_184_25 = 0

			if var_184_25 < arg_181_1.time_ and arg_181_1.time_ <= var_184_25 + arg_184_0 and not isNil(var_184_24) and arg_181_1.var_.characterEffect10078ui_story == nil then
				arg_181_1.var_.characterEffect10078ui_story = var_184_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_26 = 0.200000002980232

			if var_184_25 <= arg_181_1.time_ and arg_181_1.time_ < var_184_25 + var_184_26 and not isNil(var_184_24) then
				local var_184_27 = (arg_181_1.time_ - var_184_25) / var_184_26

				if arg_181_1.var_.characterEffect10078ui_story and not isNil(var_184_24) then
					local var_184_28 = Mathf.Lerp(0, 0.5, var_184_27)

					arg_181_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10078ui_story.fillRatio = var_184_28
				end
			end

			if arg_181_1.time_ >= var_184_25 + var_184_26 and arg_181_1.time_ < var_184_25 + var_184_26 + arg_184_0 and not isNil(var_184_24) and arg_181_1.var_.characterEffect10078ui_story then
				local var_184_29 = 0.5

				arg_181_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10078ui_story.fillRatio = var_184_29
			end

			local var_184_30 = 0
			local var_184_31 = 0.925

			if var_184_30 < arg_181_1.time_ and arg_181_1.time_ <= var_184_30 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_32 = arg_181_1:FormatText(StoryNameCfg[918].name)

				arg_181_1.leftNameTxt_.text = var_184_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_33 = arg_181_1:GetWordFromCfg(412071043)
				local var_184_34 = arg_181_1:FormatText(var_184_33.content)

				arg_181_1.text_.text = var_184_34

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_35 = 37
				local var_184_36 = utf8.len(var_184_34)
				local var_184_37 = var_184_35 <= 0 and var_184_31 or var_184_31 * (var_184_36 / var_184_35)

				if var_184_37 > 0 and var_184_31 < var_184_37 then
					arg_181_1.talkMaxDuration = var_184_37

					if var_184_37 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_37 + var_184_30
					end
				end

				arg_181_1.text_.text = var_184_34
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071043", "story_v_out_412071.awb") ~= 0 then
					local var_184_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071043", "story_v_out_412071.awb") / 1000

					if var_184_38 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_38 + var_184_30
					end

					if var_184_33.prefab_name ~= "" and arg_181_1.actors_[var_184_33.prefab_name] ~= nil then
						local var_184_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_33.prefab_name].transform, "story_v_out_412071", "412071043", "story_v_out_412071.awb")

						arg_181_1:RecordAudio("412071043", var_184_39)
						arg_181_1:RecordAudio("412071043", var_184_39)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_412071", "412071043", "story_v_out_412071.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_412071", "412071043", "story_v_out_412071.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_40 = math.max(var_184_31, arg_181_1.talkMaxDuration)

			if var_184_30 <= arg_181_1.time_ and arg_181_1.time_ < var_184_30 + var_184_40 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_30) / var_184_40

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_30 + var_184_40 and arg_181_1.time_ < var_184_30 + var_184_40 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 412071044
		arg_185_1.duration_ = 4.03

		local var_185_0 = {
			zh = 1.666,
			ja = 4.033
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
				arg_185_0:Play412071045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1097ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1097ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(0, -0.54, -6.3)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1097ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["1097ui_story"]
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1097ui_story == nil then
				arg_185_1.var_.characterEffect1097ui_story = var_188_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_11 = 0.200000002980232

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 and not isNil(var_188_9) then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11

				if arg_185_1.var_.characterEffect1097ui_story and not isNil(var_188_9) then
					arg_185_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 and not isNil(var_188_9) and arg_185_1.var_.characterEffect1097ui_story then
				arg_185_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_188_13 = 0

			if var_188_13 < arg_185_1.time_ and arg_185_1.time_ <= var_188_13 + arg_188_0 then
				arg_185_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_188_14 = 0

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_15 = arg_185_1.actors_["10083ui_story"].transform
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.var_.moveOldPos10083ui_story = var_188_15.localPosition
			end

			local var_188_17 = 0.001

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17
				local var_188_19 = Vector3.New(0, 100, 0)

				var_188_15.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10083ui_story, var_188_19, var_188_18)

				local var_188_20 = manager.ui.mainCamera.transform.position - var_188_15.position

				var_188_15.forward = Vector3.New(var_188_20.x, var_188_20.y, var_188_20.z)

				local var_188_21 = var_188_15.localEulerAngles

				var_188_21.z = 0
				var_188_21.x = 0
				var_188_15.localEulerAngles = var_188_21
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 then
				var_188_15.localPosition = Vector3.New(0, 100, 0)

				local var_188_22 = manager.ui.mainCamera.transform.position - var_188_15.position

				var_188_15.forward = Vector3.New(var_188_22.x, var_188_22.y, var_188_22.z)

				local var_188_23 = var_188_15.localEulerAngles

				var_188_23.z = 0
				var_188_23.x = 0
				var_188_15.localEulerAngles = var_188_23
			end

			local var_188_24 = arg_185_1.actors_["10083ui_story"]
			local var_188_25 = 0

			if var_188_25 < arg_185_1.time_ and arg_185_1.time_ <= var_188_25 + arg_188_0 and not isNil(var_188_24) and arg_185_1.var_.characterEffect10083ui_story == nil then
				arg_185_1.var_.characterEffect10083ui_story = var_188_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_26 = 0.200000002980232

			if var_188_25 <= arg_185_1.time_ and arg_185_1.time_ < var_188_25 + var_188_26 and not isNil(var_188_24) then
				local var_188_27 = (arg_185_1.time_ - var_188_25) / var_188_26

				if arg_185_1.var_.characterEffect10083ui_story and not isNil(var_188_24) then
					local var_188_28 = Mathf.Lerp(0, 0.5, var_188_27)

					arg_185_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10083ui_story.fillRatio = var_188_28
				end
			end

			if arg_185_1.time_ >= var_188_25 + var_188_26 and arg_185_1.time_ < var_188_25 + var_188_26 + arg_188_0 and not isNil(var_188_24) and arg_185_1.var_.characterEffect10083ui_story then
				local var_188_29 = 0.5

				arg_185_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10083ui_story.fillRatio = var_188_29
			end

			local var_188_30 = 0
			local var_188_31 = 0.15

			if var_188_30 < arg_185_1.time_ and arg_185_1.time_ <= var_188_30 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_32 = arg_185_1:FormatText(StoryNameCfg[216].name)

				arg_185_1.leftNameTxt_.text = var_188_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_33 = arg_185_1:GetWordFromCfg(412071044)
				local var_188_34 = arg_185_1:FormatText(var_188_33.content)

				arg_185_1.text_.text = var_188_34

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_35 = 6
				local var_188_36 = utf8.len(var_188_34)
				local var_188_37 = var_188_35 <= 0 and var_188_31 or var_188_31 * (var_188_36 / var_188_35)

				if var_188_37 > 0 and var_188_31 < var_188_37 then
					arg_185_1.talkMaxDuration = var_188_37

					if var_188_37 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_37 + var_188_30
					end
				end

				arg_185_1.text_.text = var_188_34
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071044", "story_v_out_412071.awb") ~= 0 then
					local var_188_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071044", "story_v_out_412071.awb") / 1000

					if var_188_38 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_38 + var_188_30
					end

					if var_188_33.prefab_name ~= "" and arg_185_1.actors_[var_188_33.prefab_name] ~= nil then
						local var_188_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_33.prefab_name].transform, "story_v_out_412071", "412071044", "story_v_out_412071.awb")

						arg_185_1:RecordAudio("412071044", var_188_39)
						arg_185_1:RecordAudio("412071044", var_188_39)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_412071", "412071044", "story_v_out_412071.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_412071", "412071044", "story_v_out_412071.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_40 = math.max(var_188_31, arg_185_1.talkMaxDuration)

			if var_188_30 <= arg_185_1.time_ and arg_185_1.time_ < var_188_30 + var_188_40 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_30) / var_188_40

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_30 + var_188_40 and arg_185_1.time_ < var_188_30 + var_188_40 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
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
	Play412071045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 412071045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play412071046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1097ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1097ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0, 100, 0)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1097ui_story, var_192_4, var_192_3)

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

			local var_192_9 = arg_189_1.actors_["1097ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1097ui_story == nil then
				arg_189_1.var_.characterEffect1097ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect1097ui_story and not isNil(var_192_9) then
					local var_192_13 = Mathf.Lerp(0, 0.5, var_192_12)

					arg_189_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1097ui_story.fillRatio = var_192_13
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect1097ui_story then
				local var_192_14 = 0.5

				arg_189_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1097ui_story.fillRatio = var_192_14
			end

			local var_192_15 = 0
			local var_192_16 = 0.7

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_17 = arg_189_1:GetWordFromCfg(412071045)
				local var_192_18 = arg_189_1:FormatText(var_192_17.content)

				arg_189_1.text_.text = var_192_18

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_19 = 28
				local var_192_20 = utf8.len(var_192_18)
				local var_192_21 = var_192_19 <= 0 and var_192_16 or var_192_16 * (var_192_20 / var_192_19)

				if var_192_21 > 0 and var_192_16 < var_192_21 then
					arg_189_1.talkMaxDuration = var_192_21

					if var_192_21 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_21 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_18
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_22 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_22 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_22

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_22 and arg_189_1.time_ < var_192_15 + var_192_22 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 412071046
		arg_193_1.duration_ = 4.43

		local var_193_0 = {
			zh = 3.233,
			ja = 4.433
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
				arg_193_0:Play412071047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10078ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10078ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(0, -0.5, -6.3)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10078ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["10078ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect10078ui_story == nil then
				arg_193_1.var_.characterEffect10078ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect10078ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect10078ui_story then
				arg_193_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_196_13 = 0

			if var_196_13 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_15 = 0
			local var_196_16 = 0.175

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[919].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(412071046)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 7
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071046", "story_v_out_412071.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_412071", "412071046", "story_v_out_412071.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_412071", "412071046", "story_v_out_412071.awb")

						arg_193_1:RecordAudio("412071046", var_196_24)
						arg_193_1:RecordAudio("412071046", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_412071", "412071046", "story_v_out_412071.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_412071", "412071046", "story_v_out_412071.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_25 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_25 and arg_193_1.time_ < var_196_15 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 412071047
		arg_197_1.duration_ = 3.63

		local var_197_0 = {
			zh = 3.633,
			ja = 1.999999999999
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
				arg_197_0:Play412071048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1097ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1097ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0, -0.54, -6.3)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1097ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["1097ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1097ui_story == nil then
				arg_197_1.var_.characterEffect1097ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect1097ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1097ui_story then
				arg_197_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_200_15 = arg_197_1.actors_["10078ui_story"].transform
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.var_.moveOldPos10078ui_story = var_200_15.localPosition
			end

			local var_200_17 = 0.001

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17
				local var_200_19 = Vector3.New(0, 100, 0)

				var_200_15.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10078ui_story, var_200_19, var_200_18)

				local var_200_20 = manager.ui.mainCamera.transform.position - var_200_15.position

				var_200_15.forward = Vector3.New(var_200_20.x, var_200_20.y, var_200_20.z)

				local var_200_21 = var_200_15.localEulerAngles

				var_200_21.z = 0
				var_200_21.x = 0
				var_200_15.localEulerAngles = var_200_21
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 then
				var_200_15.localPosition = Vector3.New(0, 100, 0)

				local var_200_22 = manager.ui.mainCamera.transform.position - var_200_15.position

				var_200_15.forward = Vector3.New(var_200_22.x, var_200_22.y, var_200_22.z)

				local var_200_23 = var_200_15.localEulerAngles

				var_200_23.z = 0
				var_200_23.x = 0
				var_200_15.localEulerAngles = var_200_23
			end

			local var_200_24 = arg_197_1.actors_["10078ui_story"]
			local var_200_25 = 0

			if var_200_25 < arg_197_1.time_ and arg_197_1.time_ <= var_200_25 + arg_200_0 and not isNil(var_200_24) and arg_197_1.var_.characterEffect10078ui_story == nil then
				arg_197_1.var_.characterEffect10078ui_story = var_200_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_26 = 0.200000002980232

			if var_200_25 <= arg_197_1.time_ and arg_197_1.time_ < var_200_25 + var_200_26 and not isNil(var_200_24) then
				local var_200_27 = (arg_197_1.time_ - var_200_25) / var_200_26

				if arg_197_1.var_.characterEffect10078ui_story and not isNil(var_200_24) then
					local var_200_28 = Mathf.Lerp(0, 0.5, var_200_27)

					arg_197_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10078ui_story.fillRatio = var_200_28
				end
			end

			if arg_197_1.time_ >= var_200_25 + var_200_26 and arg_197_1.time_ < var_200_25 + var_200_26 + arg_200_0 and not isNil(var_200_24) and arg_197_1.var_.characterEffect10078ui_story then
				local var_200_29 = 0.5

				arg_197_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10078ui_story.fillRatio = var_200_29
			end

			local var_200_30 = 0
			local var_200_31 = 0.4

			if var_200_30 < arg_197_1.time_ and arg_197_1.time_ <= var_200_30 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_32 = arg_197_1:FormatText(StoryNameCfg[216].name)

				arg_197_1.leftNameTxt_.text = var_200_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_33 = arg_197_1:GetWordFromCfg(412071047)
				local var_200_34 = arg_197_1:FormatText(var_200_33.content)

				arg_197_1.text_.text = var_200_34

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_35 = 16
				local var_200_36 = utf8.len(var_200_34)
				local var_200_37 = var_200_35 <= 0 and var_200_31 or var_200_31 * (var_200_36 / var_200_35)

				if var_200_37 > 0 and var_200_31 < var_200_37 then
					arg_197_1.talkMaxDuration = var_200_37

					if var_200_37 + var_200_30 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_37 + var_200_30
					end
				end

				arg_197_1.text_.text = var_200_34
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071047", "story_v_out_412071.awb") ~= 0 then
					local var_200_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071047", "story_v_out_412071.awb") / 1000

					if var_200_38 + var_200_30 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_38 + var_200_30
					end

					if var_200_33.prefab_name ~= "" and arg_197_1.actors_[var_200_33.prefab_name] ~= nil then
						local var_200_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_33.prefab_name].transform, "story_v_out_412071", "412071047", "story_v_out_412071.awb")

						arg_197_1:RecordAudio("412071047", var_200_39)
						arg_197_1:RecordAudio("412071047", var_200_39)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_412071", "412071047", "story_v_out_412071.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_412071", "412071047", "story_v_out_412071.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_40 = math.max(var_200_31, arg_197_1.talkMaxDuration)

			if var_200_30 <= arg_197_1.time_ and arg_197_1.time_ < var_200_30 + var_200_40 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_30) / var_200_40

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_30 + var_200_40 and arg_197_1.time_ < var_200_30 + var_200_40 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412071048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 412071048
		arg_201_1.duration_ = 7.17

		local var_201_0 = {
			zh = 5.133,
			ja = 7.166
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
				arg_201_0:Play412071049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.625

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[216].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(412071048)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 25
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071048", "story_v_out_412071.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_412071", "412071048", "story_v_out_412071.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_412071", "412071048", "story_v_out_412071.awb")

						arg_201_1:RecordAudio("412071048", var_204_9)
						arg_201_1:RecordAudio("412071048", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_412071", "412071048", "story_v_out_412071.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_412071", "412071048", "story_v_out_412071.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play412071049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 412071049
		arg_205_1.duration_ = 15.1

		local var_205_0 = {
			zh = 9.43300000298023,
			ja = 15.1000000029802
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
				arg_205_0:Play412071050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = "F02_1"

			if arg_205_1.bgs_[var_208_0] == nil then
				local var_208_1 = Object.Instantiate(arg_205_1.paintGo_)

				var_208_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_208_0)
				var_208_1.name = var_208_0
				var_208_1.transform.parent = arg_205_1.stage_.transform
				var_208_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.bgs_[var_208_0] = var_208_1
			end

			local var_208_2 = 2.00000000298023

			if var_208_2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				local var_208_3 = manager.ui.mainCamera.transform.localPosition
				local var_208_4 = Vector3.New(0, 0, 10) + Vector3.New(var_208_3.x, var_208_3.y, 0)
				local var_208_5 = arg_205_1.bgs_.F02_1

				var_208_5.transform.localPosition = var_208_4
				var_208_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_6 = var_208_5:GetComponent("SpriteRenderer")

				if var_208_6 and var_208_6.sprite then
					local var_208_7 = (var_208_5.transform.localPosition - var_208_3).z
					local var_208_8 = manager.ui.mainCameraCom_
					local var_208_9 = 2 * var_208_7 * Mathf.Tan(var_208_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_208_10 = var_208_9 * var_208_8.aspect
					local var_208_11 = var_208_6.sprite.bounds.size.x
					local var_208_12 = var_208_6.sprite.bounds.size.y
					local var_208_13 = var_208_10 / var_208_11
					local var_208_14 = var_208_9 / var_208_12
					local var_208_15 = var_208_14 < var_208_13 and var_208_13 or var_208_14

					var_208_5.transform.localScale = Vector3.New(var_208_15, var_208_15, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "F02_1" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_16 = 4.00000000298023

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				arg_205_1.allBtn_.enabled = false
			end

			local var_208_17 = 0.3

			if arg_205_1.time_ >= var_208_16 + var_208_17 and arg_205_1.time_ < var_208_16 + var_208_17 + arg_208_0 then
				arg_205_1.allBtn_.enabled = true
			end

			local var_208_18 = 0

			if var_208_18 < arg_205_1.time_ and arg_205_1.time_ <= var_208_18 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_19 = 2

			if var_208_18 <= arg_205_1.time_ and arg_205_1.time_ < var_208_18 + var_208_19 then
				local var_208_20 = (arg_205_1.time_ - var_208_18) / var_208_19
				local var_208_21 = Color.New(0, 0, 0)

				var_208_21.a = Mathf.Lerp(0, 1, var_208_20)
				arg_205_1.mask_.color = var_208_21
			end

			if arg_205_1.time_ >= var_208_18 + var_208_19 and arg_205_1.time_ < var_208_18 + var_208_19 + arg_208_0 then
				local var_208_22 = Color.New(0, 0, 0)

				var_208_22.a = 1
				arg_205_1.mask_.color = var_208_22
			end

			local var_208_23 = 2

			if var_208_23 < arg_205_1.time_ and arg_205_1.time_ <= var_208_23 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_24 = 2

			if var_208_23 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_24 then
				local var_208_25 = (arg_205_1.time_ - var_208_23) / var_208_24
				local var_208_26 = Color.New(0, 0, 0)

				var_208_26.a = Mathf.Lerp(1, 0, var_208_25)
				arg_205_1.mask_.color = var_208_26
			end

			if arg_205_1.time_ >= var_208_23 + var_208_24 and arg_205_1.time_ < var_208_23 + var_208_24 + arg_208_0 then
				local var_208_27 = Color.New(0, 0, 0)
				local var_208_28 = 0

				arg_205_1.mask_.enabled = false
				var_208_27.a = var_208_28
				arg_205_1.mask_.color = var_208_27
			end

			local var_208_29 = arg_205_1.actors_["1097ui_story"].transform
			local var_208_30 = 3.8

			if var_208_30 < arg_205_1.time_ and arg_205_1.time_ <= var_208_30 + arg_208_0 then
				arg_205_1.var_.moveOldPos1097ui_story = var_208_29.localPosition
			end

			local var_208_31 = 0.001

			if var_208_30 <= arg_205_1.time_ and arg_205_1.time_ < var_208_30 + var_208_31 then
				local var_208_32 = (arg_205_1.time_ - var_208_30) / var_208_31
				local var_208_33 = Vector3.New(0, -0.54, -6.3)

				var_208_29.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1097ui_story, var_208_33, var_208_32)

				local var_208_34 = manager.ui.mainCamera.transform.position - var_208_29.position

				var_208_29.forward = Vector3.New(var_208_34.x, var_208_34.y, var_208_34.z)

				local var_208_35 = var_208_29.localEulerAngles

				var_208_35.z = 0
				var_208_35.x = 0
				var_208_29.localEulerAngles = var_208_35
			end

			if arg_205_1.time_ >= var_208_30 + var_208_31 and arg_205_1.time_ < var_208_30 + var_208_31 + arg_208_0 then
				var_208_29.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_208_36 = manager.ui.mainCamera.transform.position - var_208_29.position

				var_208_29.forward = Vector3.New(var_208_36.x, var_208_36.y, var_208_36.z)

				local var_208_37 = var_208_29.localEulerAngles

				var_208_37.z = 0
				var_208_37.x = 0
				var_208_29.localEulerAngles = var_208_37
			end

			local var_208_38 = arg_205_1.actors_["1097ui_story"]
			local var_208_39 = 3.8

			if var_208_39 < arg_205_1.time_ and arg_205_1.time_ <= var_208_39 + arg_208_0 and not isNil(var_208_38) and arg_205_1.var_.characterEffect1097ui_story == nil then
				arg_205_1.var_.characterEffect1097ui_story = var_208_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_40 = 0.200000002980232

			if var_208_39 <= arg_205_1.time_ and arg_205_1.time_ < var_208_39 + var_208_40 and not isNil(var_208_38) then
				local var_208_41 = (arg_205_1.time_ - var_208_39) / var_208_40

				if arg_205_1.var_.characterEffect1097ui_story and not isNil(var_208_38) then
					arg_205_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_39 + var_208_40 and arg_205_1.time_ < var_208_39 + var_208_40 + arg_208_0 and not isNil(var_208_38) and arg_205_1.var_.characterEffect1097ui_story then
				arg_205_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_208_42 = 3.8

			if var_208_42 < arg_205_1.time_ and arg_205_1.time_ <= var_208_42 + arg_208_0 then
				arg_205_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_208_43 = 3.8

			if var_208_43 < arg_205_1.time_ and arg_205_1.time_ <= var_208_43 + arg_208_0 then
				arg_205_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_208_44 = arg_205_1.actors_["1097ui_story"].transform
			local var_208_45 = 1.96599999815226

			if var_208_45 < arg_205_1.time_ and arg_205_1.time_ <= var_208_45 + arg_208_0 then
				arg_205_1.var_.moveOldPos1097ui_story = var_208_44.localPosition
			end

			local var_208_46 = 0.001

			if var_208_45 <= arg_205_1.time_ and arg_205_1.time_ < var_208_45 + var_208_46 then
				local var_208_47 = (arg_205_1.time_ - var_208_45) / var_208_46
				local var_208_48 = Vector3.New(0, 100, 0)

				var_208_44.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1097ui_story, var_208_48, var_208_47)

				local var_208_49 = manager.ui.mainCamera.transform.position - var_208_44.position

				var_208_44.forward = Vector3.New(var_208_49.x, var_208_49.y, var_208_49.z)

				local var_208_50 = var_208_44.localEulerAngles

				var_208_50.z = 0
				var_208_50.x = 0
				var_208_44.localEulerAngles = var_208_50
			end

			if arg_205_1.time_ >= var_208_45 + var_208_46 and arg_205_1.time_ < var_208_45 + var_208_46 + arg_208_0 then
				var_208_44.localPosition = Vector3.New(0, 100, 0)

				local var_208_51 = manager.ui.mainCamera.transform.position - var_208_44.position

				var_208_44.forward = Vector3.New(var_208_51.x, var_208_51.y, var_208_51.z)

				local var_208_52 = var_208_44.localEulerAngles

				var_208_52.z = 0
				var_208_52.x = 0
				var_208_44.localEulerAngles = var_208_52
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_53 = 4.00000000298023
			local var_208_54 = 0.5

			if var_208_53 < arg_205_1.time_ and arg_205_1.time_ <= var_208_53 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_55 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_55:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_56 = arg_205_1:FormatText(StoryNameCfg[216].name)

				arg_205_1.leftNameTxt_.text = var_208_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_57 = arg_205_1:GetWordFromCfg(412071049)
				local var_208_58 = arg_205_1:FormatText(var_208_57.content)

				arg_205_1.text_.text = var_208_58

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_59 = 20
				local var_208_60 = utf8.len(var_208_58)
				local var_208_61 = var_208_59 <= 0 and var_208_54 or var_208_54 * (var_208_60 / var_208_59)

				if var_208_61 > 0 and var_208_54 < var_208_61 then
					arg_205_1.talkMaxDuration = var_208_61
					var_208_53 = var_208_53 + 0.3

					if var_208_61 + var_208_53 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_61 + var_208_53
					end
				end

				arg_205_1.text_.text = var_208_58
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071049", "story_v_out_412071.awb") ~= 0 then
					local var_208_62 = manager.audio:GetVoiceLength("story_v_out_412071", "412071049", "story_v_out_412071.awb") / 1000

					if var_208_62 + var_208_53 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_62 + var_208_53
					end

					if var_208_57.prefab_name ~= "" and arg_205_1.actors_[var_208_57.prefab_name] ~= nil then
						local var_208_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_57.prefab_name].transform, "story_v_out_412071", "412071049", "story_v_out_412071.awb")

						arg_205_1:RecordAudio("412071049", var_208_63)
						arg_205_1:RecordAudio("412071049", var_208_63)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_412071", "412071049", "story_v_out_412071.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_412071", "412071049", "story_v_out_412071.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_64 = var_208_53 + 0.3
			local var_208_65 = math.max(var_208_54, arg_205_1.talkMaxDuration)

			if var_208_64 <= arg_205_1.time_ and arg_205_1.time_ < var_208_64 + var_208_65 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_64) / var_208_65

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_64 + var_208_65 and arg_205_1.time_ < var_208_64 + var_208_65 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play412071050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 412071050
		arg_211_1.duration_ = 3.37

		local var_211_0 = {
			zh = 2.133,
			ja = 3.366
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play412071051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1097ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos1097ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1097ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["1097ui_story"]
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1097ui_story == nil then
				arg_211_1.var_.characterEffect1097ui_story = var_214_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_11 = 0.200000002980232

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 and not isNil(var_214_9) then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11

				if arg_211_1.var_.characterEffect1097ui_story and not isNil(var_214_9) then
					local var_214_13 = Mathf.Lerp(0, 0.5, var_214_12)

					arg_211_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1097ui_story.fillRatio = var_214_13
				end
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect1097ui_story then
				local var_214_14 = 0.5

				arg_211_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1097ui_story.fillRatio = var_214_14
			end

			local var_214_15 = manager.ui.mainCamera.transform
			local var_214_16 = 0

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 then
				arg_211_1.var_.shakeOldPos = var_214_15.localPosition
			end

			local var_214_17 = 1

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_17 then
				local var_214_18 = (arg_211_1.time_ - var_214_16) / 0.066
				local var_214_19, var_214_20 = math.modf(var_214_18)

				var_214_15.localPosition = Vector3.New(var_214_20 * 0.13, var_214_20 * 0.13, var_214_20 * 0.13) + arg_211_1.var_.shakeOldPos
			end

			if arg_211_1.time_ >= var_214_16 + var_214_17 and arg_211_1.time_ < var_214_16 + var_214_17 + arg_214_0 then
				var_214_15.localPosition = arg_211_1.var_.shakeOldPos
			end

			local var_214_21 = 0

			if var_214_21 < arg_211_1.time_ and arg_211_1.time_ <= var_214_21 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			local var_214_22 = 1

			if arg_211_1.time_ >= var_214_21 + var_214_22 and arg_211_1.time_ < var_214_21 + var_214_22 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			local var_214_23 = 0
			local var_214_24 = 0.45

			if var_214_23 < arg_211_1.time_ and arg_211_1.time_ <= var_214_23 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_25 = arg_211_1:FormatText(StoryNameCfg[913].name)

				arg_211_1.leftNameTxt_.text = var_214_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097_sheep")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_26 = arg_211_1:GetWordFromCfg(412071050)
				local var_214_27 = arg_211_1:FormatText(var_214_26.content)

				arg_211_1.text_.text = var_214_27

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_28 = 18
				local var_214_29 = utf8.len(var_214_27)
				local var_214_30 = var_214_28 <= 0 and var_214_24 or var_214_24 * (var_214_29 / var_214_28)

				if var_214_30 > 0 and var_214_24 < var_214_30 then
					arg_211_1.talkMaxDuration = var_214_30

					if var_214_30 + var_214_23 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_30 + var_214_23
					end
				end

				arg_211_1.text_.text = var_214_27
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071050", "story_v_out_412071.awb") ~= 0 then
					local var_214_31 = manager.audio:GetVoiceLength("story_v_out_412071", "412071050", "story_v_out_412071.awb") / 1000

					if var_214_31 + var_214_23 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_31 + var_214_23
					end

					if var_214_26.prefab_name ~= "" and arg_211_1.actors_[var_214_26.prefab_name] ~= nil then
						local var_214_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_26.prefab_name].transform, "story_v_out_412071", "412071050", "story_v_out_412071.awb")

						arg_211_1:RecordAudio("412071050", var_214_32)
						arg_211_1:RecordAudio("412071050", var_214_32)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_412071", "412071050", "story_v_out_412071.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_412071", "412071050", "story_v_out_412071.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_33 = math.max(var_214_24, arg_211_1.talkMaxDuration)

			if var_214_23 <= arg_211_1.time_ and arg_211_1.time_ < var_214_23 + var_214_33 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_23) / var_214_33

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_23 + var_214_33 and arg_211_1.time_ < var_214_23 + var_214_33 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play412071051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 412071051
		arg_215_1.duration_ = 5.33

		local var_215_0 = {
			zh = 4.433,
			ja = 5.333
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
				arg_215_0:Play412071052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10078ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos10078ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, -0.5, -6.3)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10078ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["10078ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect10078ui_story == nil then
				arg_215_1.var_.characterEffect10078ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect10078ui_story and not isNil(var_218_9) then
					arg_215_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect10078ui_story then
				arg_215_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_218_13 = 0

			if var_218_13 < arg_215_1.time_ and arg_215_1.time_ <= var_218_13 + arg_218_0 then
				arg_215_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			local var_218_14 = 0

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_218_15 = 0
			local var_218_16 = 0.325

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_17 = arg_215_1:FormatText(StoryNameCfg[919].name)

				arg_215_1.leftNameTxt_.text = var_218_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_18 = arg_215_1:GetWordFromCfg(412071051)
				local var_218_19 = arg_215_1:FormatText(var_218_18.content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_20 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071051", "story_v_out_412071.awb") ~= 0 then
					local var_218_23 = manager.audio:GetVoiceLength("story_v_out_412071", "412071051", "story_v_out_412071.awb") / 1000

					if var_218_23 + var_218_15 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_23 + var_218_15
					end

					if var_218_18.prefab_name ~= "" and arg_215_1.actors_[var_218_18.prefab_name] ~= nil then
						local var_218_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_18.prefab_name].transform, "story_v_out_412071", "412071051", "story_v_out_412071.awb")

						arg_215_1:RecordAudio("412071051", var_218_24)
						arg_215_1:RecordAudio("412071051", var_218_24)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_412071", "412071051", "story_v_out_412071.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_412071", "412071051", "story_v_out_412071.awb")
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
				actorName = "10078ui_story",
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
	Play412071052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 412071052
		arg_219_1.duration_ = 4

		local var_219_0 = {
			zh = 2.9,
			ja = 4
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play412071053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10083ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos10083ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(0, -2.6, -2.8)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10083ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(0, -2.6, -2.8)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["10083ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect10083ui_story == nil then
				arg_219_1.var_.characterEffect10083ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 and not isNil(var_222_9) then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect10083ui_story and not isNil(var_222_9) then
					arg_219_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and not isNil(var_222_9) and arg_219_1.var_.characterEffect10083ui_story then
				arg_219_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			local var_222_13 = 0

			if var_222_13 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				arg_219_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action5_1")
			end

			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_15 = arg_219_1.actors_["10078ui_story"].transform
			local var_222_16 = 0

			if var_222_16 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 then
				arg_219_1.var_.moveOldPos10078ui_story = var_222_15.localPosition
			end

			local var_222_17 = 0.001

			if var_222_16 <= arg_219_1.time_ and arg_219_1.time_ < var_222_16 + var_222_17 then
				local var_222_18 = (arg_219_1.time_ - var_222_16) / var_222_17
				local var_222_19 = Vector3.New(0, 100, 0)

				var_222_15.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10078ui_story, var_222_19, var_222_18)

				local var_222_20 = manager.ui.mainCamera.transform.position - var_222_15.position

				var_222_15.forward = Vector3.New(var_222_20.x, var_222_20.y, var_222_20.z)

				local var_222_21 = var_222_15.localEulerAngles

				var_222_21.z = 0
				var_222_21.x = 0
				var_222_15.localEulerAngles = var_222_21
			end

			if arg_219_1.time_ >= var_222_16 + var_222_17 and arg_219_1.time_ < var_222_16 + var_222_17 + arg_222_0 then
				var_222_15.localPosition = Vector3.New(0, 100, 0)

				local var_222_22 = manager.ui.mainCamera.transform.position - var_222_15.position

				var_222_15.forward = Vector3.New(var_222_22.x, var_222_22.y, var_222_22.z)

				local var_222_23 = var_222_15.localEulerAngles

				var_222_23.z = 0
				var_222_23.x = 0
				var_222_15.localEulerAngles = var_222_23
			end

			local var_222_24 = arg_219_1.actors_["10078ui_story"]
			local var_222_25 = 0

			if var_222_25 < arg_219_1.time_ and arg_219_1.time_ <= var_222_25 + arg_222_0 and not isNil(var_222_24) and arg_219_1.var_.characterEffect10078ui_story == nil then
				arg_219_1.var_.characterEffect10078ui_story = var_222_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_26 = 0.200000002980232

			if var_222_25 <= arg_219_1.time_ and arg_219_1.time_ < var_222_25 + var_222_26 and not isNil(var_222_24) then
				local var_222_27 = (arg_219_1.time_ - var_222_25) / var_222_26

				if arg_219_1.var_.characterEffect10078ui_story and not isNil(var_222_24) then
					local var_222_28 = Mathf.Lerp(0, 0.5, var_222_27)

					arg_219_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_219_1.var_.characterEffect10078ui_story.fillRatio = var_222_28
				end
			end

			if arg_219_1.time_ >= var_222_25 + var_222_26 and arg_219_1.time_ < var_222_25 + var_222_26 + arg_222_0 and not isNil(var_222_24) and arg_219_1.var_.characterEffect10078ui_story then
				local var_222_29 = 0.5

				arg_219_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_219_1.var_.characterEffect10078ui_story.fillRatio = var_222_29
			end

			local var_222_30 = 0
			local var_222_31 = 0.325

			if var_222_30 < arg_219_1.time_ and arg_219_1.time_ <= var_222_30 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_32 = arg_219_1:FormatText(StoryNameCfg[918].name)

				arg_219_1.leftNameTxt_.text = var_222_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_33 = arg_219_1:GetWordFromCfg(412071052)
				local var_222_34 = arg_219_1:FormatText(var_222_33.content)

				arg_219_1.text_.text = var_222_34

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_35 = 13
				local var_222_36 = utf8.len(var_222_34)
				local var_222_37 = var_222_35 <= 0 and var_222_31 or var_222_31 * (var_222_36 / var_222_35)

				if var_222_37 > 0 and var_222_31 < var_222_37 then
					arg_219_1.talkMaxDuration = var_222_37

					if var_222_37 + var_222_30 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_37 + var_222_30
					end
				end

				arg_219_1.text_.text = var_222_34
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071052", "story_v_out_412071.awb") ~= 0 then
					local var_222_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071052", "story_v_out_412071.awb") / 1000

					if var_222_38 + var_222_30 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_38 + var_222_30
					end

					if var_222_33.prefab_name ~= "" and arg_219_1.actors_[var_222_33.prefab_name] ~= nil then
						local var_222_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_33.prefab_name].transform, "story_v_out_412071", "412071052", "story_v_out_412071.awb")

						arg_219_1:RecordAudio("412071052", var_222_39)
						arg_219_1:RecordAudio("412071052", var_222_39)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_412071", "412071052", "story_v_out_412071.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_412071", "412071052", "story_v_out_412071.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_40 = math.max(var_222_31, arg_219_1.talkMaxDuration)

			if var_222_30 <= arg_219_1.time_ and arg_219_1.time_ < var_222_30 + var_222_40 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_30) / var_222_40

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_30 + var_222_40 and arg_219_1.time_ < var_222_30 + var_222_40 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play412071053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 412071053
		arg_223_1.duration_ = 10.63

		local var_223_0 = {
			zh = 3.266,
			ja = 10.633
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play412071054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1097ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1097ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0, -0.54, -6.3)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1097ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["1097ui_story"]
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1097ui_story == nil then
				arg_223_1.var_.characterEffect1097ui_story = var_226_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 and not isNil(var_226_9) then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11

				if arg_223_1.var_.characterEffect1097ui_story and not isNil(var_226_9) then
					arg_223_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1097ui_story then
				arg_223_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_226_13 = 0

			if var_226_13 < arg_223_1.time_ and arg_223_1.time_ <= var_226_13 + arg_226_0 then
				arg_223_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_226_14 = 0

			if var_226_14 < arg_223_1.time_ and arg_223_1.time_ <= var_226_14 + arg_226_0 then
				arg_223_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_15 = arg_223_1.actors_["10083ui_story"].transform
			local var_226_16 = 0

			if var_226_16 < arg_223_1.time_ and arg_223_1.time_ <= var_226_16 + arg_226_0 then
				arg_223_1.var_.moveOldPos10083ui_story = var_226_15.localPosition
			end

			local var_226_17 = 0.001

			if var_226_16 <= arg_223_1.time_ and arg_223_1.time_ < var_226_16 + var_226_17 then
				local var_226_18 = (arg_223_1.time_ - var_226_16) / var_226_17
				local var_226_19 = Vector3.New(0, 100, 0)

				var_226_15.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10083ui_story, var_226_19, var_226_18)

				local var_226_20 = manager.ui.mainCamera.transform.position - var_226_15.position

				var_226_15.forward = Vector3.New(var_226_20.x, var_226_20.y, var_226_20.z)

				local var_226_21 = var_226_15.localEulerAngles

				var_226_21.z = 0
				var_226_21.x = 0
				var_226_15.localEulerAngles = var_226_21
			end

			if arg_223_1.time_ >= var_226_16 + var_226_17 and arg_223_1.time_ < var_226_16 + var_226_17 + arg_226_0 then
				var_226_15.localPosition = Vector3.New(0, 100, 0)

				local var_226_22 = manager.ui.mainCamera.transform.position - var_226_15.position

				var_226_15.forward = Vector3.New(var_226_22.x, var_226_22.y, var_226_22.z)

				local var_226_23 = var_226_15.localEulerAngles

				var_226_23.z = 0
				var_226_23.x = 0
				var_226_15.localEulerAngles = var_226_23
			end

			local var_226_24 = arg_223_1.actors_["10083ui_story"]
			local var_226_25 = 0

			if var_226_25 < arg_223_1.time_ and arg_223_1.time_ <= var_226_25 + arg_226_0 and not isNil(var_226_24) and arg_223_1.var_.characterEffect10083ui_story == nil then
				arg_223_1.var_.characterEffect10083ui_story = var_226_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_26 = 0.200000002980232

			if var_226_25 <= arg_223_1.time_ and arg_223_1.time_ < var_226_25 + var_226_26 and not isNil(var_226_24) then
				local var_226_27 = (arg_223_1.time_ - var_226_25) / var_226_26

				if arg_223_1.var_.characterEffect10083ui_story and not isNil(var_226_24) then
					local var_226_28 = Mathf.Lerp(0, 0.5, var_226_27)

					arg_223_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10083ui_story.fillRatio = var_226_28
				end
			end

			if arg_223_1.time_ >= var_226_25 + var_226_26 and arg_223_1.time_ < var_226_25 + var_226_26 + arg_226_0 and not isNil(var_226_24) and arg_223_1.var_.characterEffect10083ui_story then
				local var_226_29 = 0.5

				arg_223_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10083ui_story.fillRatio = var_226_29
			end

			local var_226_30 = 0
			local var_226_31 = 0.375

			if var_226_30 < arg_223_1.time_ and arg_223_1.time_ <= var_226_30 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_32 = arg_223_1:FormatText(StoryNameCfg[216].name)

				arg_223_1.leftNameTxt_.text = var_226_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_33 = arg_223_1:GetWordFromCfg(412071053)
				local var_226_34 = arg_223_1:FormatText(var_226_33.content)

				arg_223_1.text_.text = var_226_34

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_35 = 15
				local var_226_36 = utf8.len(var_226_34)
				local var_226_37 = var_226_35 <= 0 and var_226_31 or var_226_31 * (var_226_36 / var_226_35)

				if var_226_37 > 0 and var_226_31 < var_226_37 then
					arg_223_1.talkMaxDuration = var_226_37

					if var_226_37 + var_226_30 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_37 + var_226_30
					end
				end

				arg_223_1.text_.text = var_226_34
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071053", "story_v_out_412071.awb") ~= 0 then
					local var_226_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071053", "story_v_out_412071.awb") / 1000

					if var_226_38 + var_226_30 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_38 + var_226_30
					end

					if var_226_33.prefab_name ~= "" and arg_223_1.actors_[var_226_33.prefab_name] ~= nil then
						local var_226_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_33.prefab_name].transform, "story_v_out_412071", "412071053", "story_v_out_412071.awb")

						arg_223_1:RecordAudio("412071053", var_226_39)
						arg_223_1:RecordAudio("412071053", var_226_39)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_412071", "412071053", "story_v_out_412071.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_412071", "412071053", "story_v_out_412071.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_40 = math.max(var_226_31, arg_223_1.talkMaxDuration)

			if var_226_30 <= arg_223_1.time_ and arg_223_1.time_ < var_226_30 + var_226_40 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_30) / var_226_40

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_30 + var_226_40 and arg_223_1.time_ < var_226_30 + var_226_40 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play412071054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 412071054
		arg_227_1.duration_ = 9.6

		local var_227_0 = {
			zh = 9.6,
			ja = 9.133
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
				arg_227_0:Play412071055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["10078ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos10078ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(0, -0.5, -6.3)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10078ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(0, -0.5, -6.3)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = arg_227_1.actors_["10078ui_story"]
			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect10078ui_story == nil then
				arg_227_1.var_.characterEffect10078ui_story = var_230_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_11 = 0.200000002980232

			if var_230_10 <= arg_227_1.time_ and arg_227_1.time_ < var_230_10 + var_230_11 and not isNil(var_230_9) then
				local var_230_12 = (arg_227_1.time_ - var_230_10) / var_230_11

				if arg_227_1.var_.characterEffect10078ui_story and not isNil(var_230_9) then
					arg_227_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_10 + var_230_11 and arg_227_1.time_ < var_230_10 + var_230_11 + arg_230_0 and not isNil(var_230_9) and arg_227_1.var_.characterEffect10078ui_story then
				arg_227_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_230_13 = 0

			if var_230_13 < arg_227_1.time_ and arg_227_1.time_ <= var_230_13 + arg_230_0 then
				arg_227_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action425")
			end

			local var_230_14 = 0

			if var_230_14 < arg_227_1.time_ and arg_227_1.time_ <= var_230_14 + arg_230_0 then
				arg_227_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_15 = arg_227_1.actors_["1097ui_story"].transform
			local var_230_16 = 0

			if var_230_16 < arg_227_1.time_ and arg_227_1.time_ <= var_230_16 + arg_230_0 then
				arg_227_1.var_.moveOldPos1097ui_story = var_230_15.localPosition
			end

			local var_230_17 = 0.001

			if var_230_16 <= arg_227_1.time_ and arg_227_1.time_ < var_230_16 + var_230_17 then
				local var_230_18 = (arg_227_1.time_ - var_230_16) / var_230_17
				local var_230_19 = Vector3.New(0, 100, 0)

				var_230_15.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1097ui_story, var_230_19, var_230_18)

				local var_230_20 = manager.ui.mainCamera.transform.position - var_230_15.position

				var_230_15.forward = Vector3.New(var_230_20.x, var_230_20.y, var_230_20.z)

				local var_230_21 = var_230_15.localEulerAngles

				var_230_21.z = 0
				var_230_21.x = 0
				var_230_15.localEulerAngles = var_230_21
			end

			if arg_227_1.time_ >= var_230_16 + var_230_17 and arg_227_1.time_ < var_230_16 + var_230_17 + arg_230_0 then
				var_230_15.localPosition = Vector3.New(0, 100, 0)

				local var_230_22 = manager.ui.mainCamera.transform.position - var_230_15.position

				var_230_15.forward = Vector3.New(var_230_22.x, var_230_22.y, var_230_22.z)

				local var_230_23 = var_230_15.localEulerAngles

				var_230_23.z = 0
				var_230_23.x = 0
				var_230_15.localEulerAngles = var_230_23
			end

			local var_230_24 = arg_227_1.actors_["1097ui_story"]
			local var_230_25 = 0

			if var_230_25 < arg_227_1.time_ and arg_227_1.time_ <= var_230_25 + arg_230_0 and not isNil(var_230_24) and arg_227_1.var_.characterEffect1097ui_story == nil then
				arg_227_1.var_.characterEffect1097ui_story = var_230_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_26 = 0.200000002980232

			if var_230_25 <= arg_227_1.time_ and arg_227_1.time_ < var_230_25 + var_230_26 and not isNil(var_230_24) then
				local var_230_27 = (arg_227_1.time_ - var_230_25) / var_230_26

				if arg_227_1.var_.characterEffect1097ui_story and not isNil(var_230_24) then
					local var_230_28 = Mathf.Lerp(0, 0.5, var_230_27)

					arg_227_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1097ui_story.fillRatio = var_230_28
				end
			end

			if arg_227_1.time_ >= var_230_25 + var_230_26 and arg_227_1.time_ < var_230_25 + var_230_26 + arg_230_0 and not isNil(var_230_24) and arg_227_1.var_.characterEffect1097ui_story then
				local var_230_29 = 0.5

				arg_227_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1097ui_story.fillRatio = var_230_29
			end

			local var_230_30 = 0
			local var_230_31 = 0.725

			if var_230_30 < arg_227_1.time_ and arg_227_1.time_ <= var_230_30 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_32 = arg_227_1:FormatText(StoryNameCfg[919].name)

				arg_227_1.leftNameTxt_.text = var_230_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_33 = arg_227_1:GetWordFromCfg(412071054)
				local var_230_34 = arg_227_1:FormatText(var_230_33.content)

				arg_227_1.text_.text = var_230_34

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_35 = 29
				local var_230_36 = utf8.len(var_230_34)
				local var_230_37 = var_230_35 <= 0 and var_230_31 or var_230_31 * (var_230_36 / var_230_35)

				if var_230_37 > 0 and var_230_31 < var_230_37 then
					arg_227_1.talkMaxDuration = var_230_37

					if var_230_37 + var_230_30 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_37 + var_230_30
					end
				end

				arg_227_1.text_.text = var_230_34
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071054", "story_v_out_412071.awb") ~= 0 then
					local var_230_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071054", "story_v_out_412071.awb") / 1000

					if var_230_38 + var_230_30 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_38 + var_230_30
					end

					if var_230_33.prefab_name ~= "" and arg_227_1.actors_[var_230_33.prefab_name] ~= nil then
						local var_230_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_33.prefab_name].transform, "story_v_out_412071", "412071054", "story_v_out_412071.awb")

						arg_227_1:RecordAudio("412071054", var_230_39)
						arg_227_1:RecordAudio("412071054", var_230_39)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_412071", "412071054", "story_v_out_412071.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_412071", "412071054", "story_v_out_412071.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_40 = math.max(var_230_31, arg_227_1.talkMaxDuration)

			if var_230_30 <= arg_227_1.time_ and arg_227_1.time_ < var_230_30 + var_230_40 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_30) / var_230_40

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_30 + var_230_40 and arg_227_1.time_ < var_230_30 + var_230_40 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 412071055
		arg_231_1.duration_ = 8.73

		local var_231_0 = {
			zh = 8.133,
			ja = 8.733
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play412071056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 0.65

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_2 = arg_231_1:FormatText(StoryNameCfg[919].name)

				arg_231_1.leftNameTxt_.text = var_234_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:GetWordFromCfg(412071055)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 26
				local var_234_6 = utf8.len(var_234_4)
				local var_234_7 = var_234_5 <= 0 and var_234_1 or var_234_1 * (var_234_6 / var_234_5)

				if var_234_7 > 0 and var_234_1 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_0
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071055", "story_v_out_412071.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_412071", "412071055", "story_v_out_412071.awb") / 1000

					if var_234_8 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_0
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_out_412071", "412071055", "story_v_out_412071.awb")

						arg_231_1:RecordAudio("412071055", var_234_9)
						arg_231_1:RecordAudio("412071055", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_412071", "412071055", "story_v_out_412071.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_412071", "412071055", "story_v_out_412071.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_1, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_0) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_10 and arg_231_1.time_ < var_234_0 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play412071056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 412071056
		arg_235_1.duration_ = 4.23

		local var_235_0 = {
			zh = 2.566,
			ja = 4.233
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play412071057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1097ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos1097ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0, -0.54, -6.3)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1097ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0, -0.54, -6.3)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = arg_235_1.actors_["1097ui_story"]
			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect1097ui_story == nil then
				arg_235_1.var_.characterEffect1097ui_story = var_238_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_11 = 0.200000002980232

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_11 and not isNil(var_238_9) then
				local var_238_12 = (arg_235_1.time_ - var_238_10) / var_238_11

				if arg_235_1.var_.characterEffect1097ui_story and not isNil(var_238_9) then
					arg_235_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_10 + var_238_11 and arg_235_1.time_ < var_238_10 + var_238_11 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect1097ui_story then
				arg_235_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_238_13 = 0

			if var_238_13 < arg_235_1.time_ and arg_235_1.time_ <= var_238_13 + arg_238_0 then
				arg_235_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_238_14 = 0

			if var_238_14 < arg_235_1.time_ and arg_235_1.time_ <= var_238_14 + arg_238_0 then
				arg_235_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_15 = arg_235_1.actors_["10078ui_story"].transform
			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 then
				arg_235_1.var_.moveOldPos10078ui_story = var_238_15.localPosition
			end

			local var_238_17 = 0.001

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_17 then
				local var_238_18 = (arg_235_1.time_ - var_238_16) / var_238_17
				local var_238_19 = Vector3.New(0, 100, 0)

				var_238_15.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10078ui_story, var_238_19, var_238_18)

				local var_238_20 = manager.ui.mainCamera.transform.position - var_238_15.position

				var_238_15.forward = Vector3.New(var_238_20.x, var_238_20.y, var_238_20.z)

				local var_238_21 = var_238_15.localEulerAngles

				var_238_21.z = 0
				var_238_21.x = 0
				var_238_15.localEulerAngles = var_238_21
			end

			if arg_235_1.time_ >= var_238_16 + var_238_17 and arg_235_1.time_ < var_238_16 + var_238_17 + arg_238_0 then
				var_238_15.localPosition = Vector3.New(0, 100, 0)

				local var_238_22 = manager.ui.mainCamera.transform.position - var_238_15.position

				var_238_15.forward = Vector3.New(var_238_22.x, var_238_22.y, var_238_22.z)

				local var_238_23 = var_238_15.localEulerAngles

				var_238_23.z = 0
				var_238_23.x = 0
				var_238_15.localEulerAngles = var_238_23
			end

			local var_238_24 = arg_235_1.actors_["10078ui_story"]
			local var_238_25 = 0

			if var_238_25 < arg_235_1.time_ and arg_235_1.time_ <= var_238_25 + arg_238_0 and not isNil(var_238_24) and arg_235_1.var_.characterEffect10078ui_story == nil then
				arg_235_1.var_.characterEffect10078ui_story = var_238_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_26 = 0.200000002980232

			if var_238_25 <= arg_235_1.time_ and arg_235_1.time_ < var_238_25 + var_238_26 and not isNil(var_238_24) then
				local var_238_27 = (arg_235_1.time_ - var_238_25) / var_238_26

				if arg_235_1.var_.characterEffect10078ui_story and not isNil(var_238_24) then
					local var_238_28 = Mathf.Lerp(0, 0.5, var_238_27)

					arg_235_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_235_1.var_.characterEffect10078ui_story.fillRatio = var_238_28
				end
			end

			if arg_235_1.time_ >= var_238_25 + var_238_26 and arg_235_1.time_ < var_238_25 + var_238_26 + arg_238_0 and not isNil(var_238_24) and arg_235_1.var_.characterEffect10078ui_story then
				local var_238_29 = 0.5

				arg_235_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_235_1.var_.characterEffect10078ui_story.fillRatio = var_238_29
			end

			local var_238_30 = 0
			local var_238_31 = 0.25

			if var_238_30 < arg_235_1.time_ and arg_235_1.time_ <= var_238_30 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_32 = arg_235_1:FormatText(StoryNameCfg[216].name)

				arg_235_1.leftNameTxt_.text = var_238_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_33 = arg_235_1:GetWordFromCfg(412071056)
				local var_238_34 = arg_235_1:FormatText(var_238_33.content)

				arg_235_1.text_.text = var_238_34

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_35 = 10
				local var_238_36 = utf8.len(var_238_34)
				local var_238_37 = var_238_35 <= 0 and var_238_31 or var_238_31 * (var_238_36 / var_238_35)

				if var_238_37 > 0 and var_238_31 < var_238_37 then
					arg_235_1.talkMaxDuration = var_238_37

					if var_238_37 + var_238_30 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_37 + var_238_30
					end
				end

				arg_235_1.text_.text = var_238_34
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071056", "story_v_out_412071.awb") ~= 0 then
					local var_238_38 = manager.audio:GetVoiceLength("story_v_out_412071", "412071056", "story_v_out_412071.awb") / 1000

					if var_238_38 + var_238_30 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_38 + var_238_30
					end

					if var_238_33.prefab_name ~= "" and arg_235_1.actors_[var_238_33.prefab_name] ~= nil then
						local var_238_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_33.prefab_name].transform, "story_v_out_412071", "412071056", "story_v_out_412071.awb")

						arg_235_1:RecordAudio("412071056", var_238_39)
						arg_235_1:RecordAudio("412071056", var_238_39)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_412071", "412071056", "story_v_out_412071.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_412071", "412071056", "story_v_out_412071.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_40 = math.max(var_238_31, arg_235_1.talkMaxDuration)

			if var_238_30 <= arg_235_1.time_ and arg_235_1.time_ < var_238_30 + var_238_40 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_30) / var_238_40

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_30 + var_238_40 and arg_235_1.time_ < var_238_30 + var_238_40 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play412071057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 412071057
		arg_239_1.duration_ = 5.97

		local var_239_0 = {
			zh = 5.966,
			ja = 4.766
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
				arg_239_0:Play412071058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_1")
			end

			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_2 = 0
			local var_242_3 = 0.5

			if var_242_2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_4 = arg_239_1:FormatText(StoryNameCfg[216].name)

				arg_239_1.leftNameTxt_.text = var_242_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_5 = arg_239_1:GetWordFromCfg(412071057)
				local var_242_6 = arg_239_1:FormatText(var_242_5.content)

				arg_239_1.text_.text = var_242_6

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_7 = 19
				local var_242_8 = utf8.len(var_242_6)
				local var_242_9 = var_242_7 <= 0 and var_242_3 or var_242_3 * (var_242_8 / var_242_7)

				if var_242_9 > 0 and var_242_3 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_6
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071057", "story_v_out_412071.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_412071", "412071057", "story_v_out_412071.awb") / 1000

					if var_242_10 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_2
					end

					if var_242_5.prefab_name ~= "" and arg_239_1.actors_[var_242_5.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_5.prefab_name].transform, "story_v_out_412071", "412071057", "story_v_out_412071.awb")

						arg_239_1:RecordAudio("412071057", var_242_11)
						arg_239_1:RecordAudio("412071057", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_412071", "412071057", "story_v_out_412071.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_412071", "412071057", "story_v_out_412071.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_12 and arg_239_1.time_ < var_242_2 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play412071058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 412071058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play412071059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1097ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1097ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(0, 100, 0)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1097ui_story, var_246_4, var_246_3)

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

			local var_246_9 = arg_243_1.actors_["1097ui_story"]
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1097ui_story == nil then
				arg_243_1.var_.characterEffect1097ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 and not isNil(var_246_9) then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11

				if arg_243_1.var_.characterEffect1097ui_story and not isNil(var_246_9) then
					local var_246_13 = Mathf.Lerp(0, 0.5, var_246_12)

					arg_243_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1097ui_story.fillRatio = var_246_13
				end
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1097ui_story then
				local var_246_14 = 0.5

				arg_243_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1097ui_story.fillRatio = var_246_14
			end

			local var_246_15 = 0
			local var_246_16 = 0.2

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_17 = arg_243_1:GetWordFromCfg(412071058)
				local var_246_18 = arg_243_1:FormatText(var_246_17.content)

				arg_243_1.text_.text = var_246_18

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_19 = 8
				local var_246_20 = utf8.len(var_246_18)
				local var_246_21 = var_246_19 <= 0 and var_246_16 or var_246_16 * (var_246_20 / var_246_19)

				if var_246_21 > 0 and var_246_16 < var_246_21 then
					arg_243_1.talkMaxDuration = var_246_21

					if var_246_21 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_21 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_18
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_22 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_22 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_22

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_22 and arg_243_1.time_ < var_246_15 + var_246_22 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 412071059
		arg_247_1.duration_ = 10.33

		local var_247_0 = {
			zh = 7.8,
			ja = 10.333
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
				arg_247_0:Play412071060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10078ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10078ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(-0.7, -0.5, -6.3)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10078ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["10078ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10078ui_story == nil then
				arg_247_1.var_.characterEffect10078ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect10078ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10078ui_story then
				arg_247_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 then
				arg_247_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_14 = arg_247_1.actors_["1097ui_story"].transform
			local var_250_15 = 0

			if var_250_15 < arg_247_1.time_ and arg_247_1.time_ <= var_250_15 + arg_250_0 then
				arg_247_1.var_.moveOldPos1097ui_story = var_250_14.localPosition
			end

			local var_250_16 = 0.001

			if var_250_15 <= arg_247_1.time_ and arg_247_1.time_ < var_250_15 + var_250_16 then
				local var_250_17 = (arg_247_1.time_ - var_250_15) / var_250_16
				local var_250_18 = Vector3.New(0.7, -0.54, -6.3)

				var_250_14.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1097ui_story, var_250_18, var_250_17)

				local var_250_19 = manager.ui.mainCamera.transform.position - var_250_14.position

				var_250_14.forward = Vector3.New(var_250_19.x, var_250_19.y, var_250_19.z)

				local var_250_20 = var_250_14.localEulerAngles

				var_250_20.z = 0
				var_250_20.x = 0
				var_250_14.localEulerAngles = var_250_20
			end

			if arg_247_1.time_ >= var_250_15 + var_250_16 and arg_247_1.time_ < var_250_15 + var_250_16 + arg_250_0 then
				var_250_14.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_250_21 = manager.ui.mainCamera.transform.position - var_250_14.position

				var_250_14.forward = Vector3.New(var_250_21.x, var_250_21.y, var_250_21.z)

				local var_250_22 = var_250_14.localEulerAngles

				var_250_22.z = 0
				var_250_22.x = 0
				var_250_14.localEulerAngles = var_250_22
			end

			local var_250_23 = arg_247_1.actors_["1097ui_story"]
			local var_250_24 = 0

			if var_250_24 < arg_247_1.time_ and arg_247_1.time_ <= var_250_24 + arg_250_0 and not isNil(var_250_23) and arg_247_1.var_.characterEffect1097ui_story == nil then
				arg_247_1.var_.characterEffect1097ui_story = var_250_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_25 = 0.200000002980232

			if var_250_24 <= arg_247_1.time_ and arg_247_1.time_ < var_250_24 + var_250_25 and not isNil(var_250_23) then
				local var_250_26 = (arg_247_1.time_ - var_250_24) / var_250_25

				if arg_247_1.var_.characterEffect1097ui_story and not isNil(var_250_23) then
					local var_250_27 = Mathf.Lerp(0, 0.5, var_250_26)

					arg_247_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1097ui_story.fillRatio = var_250_27
				end
			end

			if arg_247_1.time_ >= var_250_24 + var_250_25 and arg_247_1.time_ < var_250_24 + var_250_25 + arg_250_0 and not isNil(var_250_23) and arg_247_1.var_.characterEffect1097ui_story then
				local var_250_28 = 0.5

				arg_247_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1097ui_story.fillRatio = var_250_28
			end

			local var_250_29 = 0
			local var_250_30 = 0.525

			if var_250_29 < arg_247_1.time_ and arg_247_1.time_ <= var_250_29 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_31 = arg_247_1:FormatText(StoryNameCfg[919].name)

				arg_247_1.leftNameTxt_.text = var_250_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_32 = arg_247_1:GetWordFromCfg(412071059)
				local var_250_33 = arg_247_1:FormatText(var_250_32.content)

				arg_247_1.text_.text = var_250_33

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_34 = 21
				local var_250_35 = utf8.len(var_250_33)
				local var_250_36 = var_250_34 <= 0 and var_250_30 or var_250_30 * (var_250_35 / var_250_34)

				if var_250_36 > 0 and var_250_30 < var_250_36 then
					arg_247_1.talkMaxDuration = var_250_36

					if var_250_36 + var_250_29 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_36 + var_250_29
					end
				end

				arg_247_1.text_.text = var_250_33
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071059", "story_v_out_412071.awb") ~= 0 then
					local var_250_37 = manager.audio:GetVoiceLength("story_v_out_412071", "412071059", "story_v_out_412071.awb") / 1000

					if var_250_37 + var_250_29 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_37 + var_250_29
					end

					if var_250_32.prefab_name ~= "" and arg_247_1.actors_[var_250_32.prefab_name] ~= nil then
						local var_250_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_32.prefab_name].transform, "story_v_out_412071", "412071059", "story_v_out_412071.awb")

						arg_247_1:RecordAudio("412071059", var_250_38)
						arg_247_1:RecordAudio("412071059", var_250_38)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_412071", "412071059", "story_v_out_412071.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_412071", "412071059", "story_v_out_412071.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_39 = math.max(var_250_30, arg_247_1.talkMaxDuration)

			if var_250_29 <= arg_247_1.time_ and arg_247_1.time_ < var_250_29 + var_250_39 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_29) / var_250_39

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_29 + var_250_39 and arg_247_1.time_ < var_250_29 + var_250_39 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 412071060
		arg_251_1.duration_ = 2.1

		local var_251_0 = {
			zh = 2.1,
			ja = 1.999999999999
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
				arg_251_0:Play412071061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1097ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1097ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(0.7, -0.54, -6.3)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1097ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["1097ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1097ui_story == nil then
				arg_251_1.var_.characterEffect1097ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect1097ui_story and not isNil(var_254_9) then
					arg_251_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1097ui_story then
				arg_251_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_254_13 = 0

			if var_254_13 < arg_251_1.time_ and arg_251_1.time_ <= var_254_13 + arg_254_0 then
				arg_251_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action3_2")
			end

			local var_254_14 = 0

			if var_254_14 < arg_251_1.time_ and arg_251_1.time_ <= var_254_14 + arg_254_0 then
				arg_251_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_15 = arg_251_1.actors_["10078ui_story"]
			local var_254_16 = 0

			if var_254_16 < arg_251_1.time_ and arg_251_1.time_ <= var_254_16 + arg_254_0 and not isNil(var_254_15) and arg_251_1.var_.characterEffect10078ui_story == nil then
				arg_251_1.var_.characterEffect10078ui_story = var_254_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_17 = 0.200000002980232

			if var_254_16 <= arg_251_1.time_ and arg_251_1.time_ < var_254_16 + var_254_17 and not isNil(var_254_15) then
				local var_254_18 = (arg_251_1.time_ - var_254_16) / var_254_17

				if arg_251_1.var_.characterEffect10078ui_story and not isNil(var_254_15) then
					local var_254_19 = Mathf.Lerp(0, 0.5, var_254_18)

					arg_251_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10078ui_story.fillRatio = var_254_19
				end
			end

			if arg_251_1.time_ >= var_254_16 + var_254_17 and arg_251_1.time_ < var_254_16 + var_254_17 + arg_254_0 and not isNil(var_254_15) and arg_251_1.var_.characterEffect10078ui_story then
				local var_254_20 = 0.5

				arg_251_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10078ui_story.fillRatio = var_254_20
			end

			local var_254_21 = 0
			local var_254_22 = 0.15

			if var_254_21 < arg_251_1.time_ and arg_251_1.time_ <= var_254_21 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_23 = arg_251_1:FormatText(StoryNameCfg[216].name)

				arg_251_1.leftNameTxt_.text = var_254_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_24 = arg_251_1:GetWordFromCfg(412071060)
				local var_254_25 = arg_251_1:FormatText(var_254_24.content)

				arg_251_1.text_.text = var_254_25

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_26 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071060", "story_v_out_412071.awb") ~= 0 then
					local var_254_29 = manager.audio:GetVoiceLength("story_v_out_412071", "412071060", "story_v_out_412071.awb") / 1000

					if var_254_29 + var_254_21 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_29 + var_254_21
					end

					if var_254_24.prefab_name ~= "" and arg_251_1.actors_[var_254_24.prefab_name] ~= nil then
						local var_254_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_24.prefab_name].transform, "story_v_out_412071", "412071060", "story_v_out_412071.awb")

						arg_251_1:RecordAudio("412071060", var_254_30)
						arg_251_1:RecordAudio("412071060", var_254_30)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_412071", "412071060", "story_v_out_412071.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_412071", "412071060", "story_v_out_412071.awb")
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
				actorName = "1097ui_story",
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
	Play412071061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 412071061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play412071062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10078ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos10078ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0, 100, 0)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10078ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0, 100, 0)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = arg_255_1.actors_["10078ui_story"]
			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect10078ui_story == nil then
				arg_255_1.var_.characterEffect10078ui_story = var_258_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_11 = 0.200000002980232

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_11 and not isNil(var_258_9) then
				local var_258_12 = (arg_255_1.time_ - var_258_10) / var_258_11

				if arg_255_1.var_.characterEffect10078ui_story and not isNil(var_258_9) then
					local var_258_13 = Mathf.Lerp(0, 0.5, var_258_12)

					arg_255_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10078ui_story.fillRatio = var_258_13
				end
			end

			if arg_255_1.time_ >= var_258_10 + var_258_11 and arg_255_1.time_ < var_258_10 + var_258_11 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect10078ui_story then
				local var_258_14 = 0.5

				arg_255_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10078ui_story.fillRatio = var_258_14
			end

			local var_258_15 = arg_255_1.actors_["1097ui_story"].transform
			local var_258_16 = 0

			if var_258_16 < arg_255_1.time_ and arg_255_1.time_ <= var_258_16 + arg_258_0 then
				arg_255_1.var_.moveOldPos1097ui_story = var_258_15.localPosition
			end

			local var_258_17 = 0.001

			if var_258_16 <= arg_255_1.time_ and arg_255_1.time_ < var_258_16 + var_258_17 then
				local var_258_18 = (arg_255_1.time_ - var_258_16) / var_258_17
				local var_258_19 = Vector3.New(0, 100, 0)

				var_258_15.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1097ui_story, var_258_19, var_258_18)

				local var_258_20 = manager.ui.mainCamera.transform.position - var_258_15.position

				var_258_15.forward = Vector3.New(var_258_20.x, var_258_20.y, var_258_20.z)

				local var_258_21 = var_258_15.localEulerAngles

				var_258_21.z = 0
				var_258_21.x = 0
				var_258_15.localEulerAngles = var_258_21
			end

			if arg_255_1.time_ >= var_258_16 + var_258_17 and arg_255_1.time_ < var_258_16 + var_258_17 + arg_258_0 then
				var_258_15.localPosition = Vector3.New(0, 100, 0)

				local var_258_22 = manager.ui.mainCamera.transform.position - var_258_15.position

				var_258_15.forward = Vector3.New(var_258_22.x, var_258_22.y, var_258_22.z)

				local var_258_23 = var_258_15.localEulerAngles

				var_258_23.z = 0
				var_258_23.x = 0
				var_258_15.localEulerAngles = var_258_23
			end

			local var_258_24 = arg_255_1.actors_["1097ui_story"]
			local var_258_25 = 0

			if var_258_25 < arg_255_1.time_ and arg_255_1.time_ <= var_258_25 + arg_258_0 and not isNil(var_258_24) and arg_255_1.var_.characterEffect1097ui_story == nil then
				arg_255_1.var_.characterEffect1097ui_story = var_258_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_26 = 0.200000002980232

			if var_258_25 <= arg_255_1.time_ and arg_255_1.time_ < var_258_25 + var_258_26 and not isNil(var_258_24) then
				local var_258_27 = (arg_255_1.time_ - var_258_25) / var_258_26

				if arg_255_1.var_.characterEffect1097ui_story and not isNil(var_258_24) then
					local var_258_28 = Mathf.Lerp(0, 0.5, var_258_27)

					arg_255_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1097ui_story.fillRatio = var_258_28
				end
			end

			if arg_255_1.time_ >= var_258_25 + var_258_26 and arg_255_1.time_ < var_258_25 + var_258_26 + arg_258_0 and not isNil(var_258_24) and arg_255_1.var_.characterEffect1097ui_story then
				local var_258_29 = 0.5

				arg_255_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1097ui_story.fillRatio = var_258_29
			end

			local var_258_30 = 0
			local var_258_31 = 0.575

			if var_258_30 < arg_255_1.time_ and arg_255_1.time_ <= var_258_30 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_32 = arg_255_1:GetWordFromCfg(412071061)
				local var_258_33 = arg_255_1:FormatText(var_258_32.content)

				arg_255_1.text_.text = var_258_33

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_34 = 23
				local var_258_35 = utf8.len(var_258_33)
				local var_258_36 = var_258_34 <= 0 and var_258_31 or var_258_31 * (var_258_35 / var_258_34)

				if var_258_36 > 0 and var_258_31 < var_258_36 then
					arg_255_1.talkMaxDuration = var_258_36

					if var_258_36 + var_258_30 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_36 + var_258_30
					end
				end

				arg_255_1.text_.text = var_258_33
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_37 = math.max(var_258_31, arg_255_1.talkMaxDuration)

			if var_258_30 <= arg_255_1.time_ and arg_255_1.time_ < var_258_30 + var_258_37 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_30) / var_258_37

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_30 + var_258_37 and arg_255_1.time_ < var_258_30 + var_258_37 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
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
	Play412071062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 412071062
		arg_259_1.duration_ = 10.1

		local var_259_0 = {
			zh = 8.066,
			ja = 10.1
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
				arg_259_0:Play412071063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1097ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos1097ui_story = var_262_0.localPosition
			end

			local var_262_2 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2
				local var_262_4 = Vector3.New(0.7, -0.54, -6.3)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1097ui_story, var_262_4, var_262_3)

				local var_262_5 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_5.x, var_262_5.y, var_262_5.z)

				local var_262_6 = var_262_0.localEulerAngles

				var_262_6.z = 0
				var_262_6.x = 0
				var_262_0.localEulerAngles = var_262_6
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(0.7, -0.54, -6.3)

				local var_262_7 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_7.x, var_262_7.y, var_262_7.z)

				local var_262_8 = var_262_0.localEulerAngles

				var_262_8.z = 0
				var_262_8.x = 0
				var_262_0.localEulerAngles = var_262_8
			end

			local var_262_9 = arg_259_1.actors_["1097ui_story"]
			local var_262_10 = 0

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect1097ui_story == nil then
				arg_259_1.var_.characterEffect1097ui_story = var_262_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_11 = 0.200000002980232

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_11 and not isNil(var_262_9) then
				local var_262_12 = (arg_259_1.time_ - var_262_10) / var_262_11

				if arg_259_1.var_.characterEffect1097ui_story and not isNil(var_262_9) then
					arg_259_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_10 + var_262_11 and arg_259_1.time_ < var_262_10 + var_262_11 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect1097ui_story then
				arg_259_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_262_13 = 0

			if var_262_13 < arg_259_1.time_ and arg_259_1.time_ <= var_262_13 + arg_262_0 then
				arg_259_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			local var_262_14 = 0

			if var_262_14 < arg_259_1.time_ and arg_259_1.time_ <= var_262_14 + arg_262_0 then
				arg_259_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_15 = 0
			local var_262_16 = 0.875

			if var_262_15 < arg_259_1.time_ and arg_259_1.time_ <= var_262_15 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_17 = arg_259_1:FormatText(StoryNameCfg[216].name)

				arg_259_1.leftNameTxt_.text = var_262_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_18 = arg_259_1:GetWordFromCfg(412071062)
				local var_262_19 = arg_259_1:FormatText(var_262_18.content)

				arg_259_1.text_.text = var_262_19

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_20 = 35
				local var_262_21 = utf8.len(var_262_19)
				local var_262_22 = var_262_20 <= 0 and var_262_16 or var_262_16 * (var_262_21 / var_262_20)

				if var_262_22 > 0 and var_262_16 < var_262_22 then
					arg_259_1.talkMaxDuration = var_262_22

					if var_262_22 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_22 + var_262_15
					end
				end

				arg_259_1.text_.text = var_262_19
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071062", "story_v_out_412071.awb") ~= 0 then
					local var_262_23 = manager.audio:GetVoiceLength("story_v_out_412071", "412071062", "story_v_out_412071.awb") / 1000

					if var_262_23 + var_262_15 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_23 + var_262_15
					end

					if var_262_18.prefab_name ~= "" and arg_259_1.actors_[var_262_18.prefab_name] ~= nil then
						local var_262_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_18.prefab_name].transform, "story_v_out_412071", "412071062", "story_v_out_412071.awb")

						arg_259_1:RecordAudio("412071062", var_262_24)
						arg_259_1:RecordAudio("412071062", var_262_24)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_412071", "412071062", "story_v_out_412071.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_412071", "412071062", "story_v_out_412071.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_25 = math.max(var_262_16, arg_259_1.talkMaxDuration)

			if var_262_15 <= arg_259_1.time_ and arg_259_1.time_ < var_262_15 + var_262_25 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_15) / var_262_25

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_15 + var_262_25 and arg_259_1.time_ < var_262_15 + var_262_25 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play412071063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 412071063
		arg_263_1.duration_ = 2.87

		local var_263_0 = {
			zh = 2.866,
			ja = 2.533
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
			arg_263_1.auto_ = false
		end

		function arg_263_1.playNext_(arg_265_0)
			arg_263_1.onStoryFinished_()
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10078ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos10078ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(-0.7, -0.5, -6.3)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10078ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["10078ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect10078ui_story == nil then
				arg_263_1.var_.characterEffect10078ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect10078ui_story and not isNil(var_266_9) then
					arg_263_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect10078ui_story then
				arg_263_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			local var_266_13 = 0

			if var_266_13 < arg_263_1.time_ and arg_263_1.time_ <= var_266_13 + arg_266_0 then
				arg_263_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_266_14 = 0

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_266_15 = arg_263_1.actors_["1097ui_story"]
			local var_266_16 = 0

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 and not isNil(var_266_15) and arg_263_1.var_.characterEffect1097ui_story == nil then
				arg_263_1.var_.characterEffect1097ui_story = var_266_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_17 = 0.200000002980232

			if var_266_16 <= arg_263_1.time_ and arg_263_1.time_ < var_266_16 + var_266_17 and not isNil(var_266_15) then
				local var_266_18 = (arg_263_1.time_ - var_266_16) / var_266_17

				if arg_263_1.var_.characterEffect1097ui_story and not isNil(var_266_15) then
					local var_266_19 = Mathf.Lerp(0, 0.5, var_266_18)

					arg_263_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1097ui_story.fillRatio = var_266_19
				end
			end

			if arg_263_1.time_ >= var_266_16 + var_266_17 and arg_263_1.time_ < var_266_16 + var_266_17 + arg_266_0 and not isNil(var_266_15) and arg_263_1.var_.characterEffect1097ui_story then
				local var_266_20 = 0.5

				arg_263_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1097ui_story.fillRatio = var_266_20
			end

			local var_266_21 = 0
			local var_266_22 = 0.225

			if var_266_21 < arg_263_1.time_ and arg_263_1.time_ <= var_266_21 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_23 = arg_263_1:FormatText(StoryNameCfg[919].name)

				arg_263_1.leftNameTxt_.text = var_266_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_24 = arg_263_1:GetWordFromCfg(412071063)
				local var_266_25 = arg_263_1:FormatText(var_266_24.content)

				arg_263_1.text_.text = var_266_25

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_26 = 9
				local var_266_27 = utf8.len(var_266_25)
				local var_266_28 = var_266_26 <= 0 and var_266_22 or var_266_22 * (var_266_27 / var_266_26)

				if var_266_28 > 0 and var_266_22 < var_266_28 then
					arg_263_1.talkMaxDuration = var_266_28

					if var_266_28 + var_266_21 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_28 + var_266_21
					end
				end

				arg_263_1.text_.text = var_266_25
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412071", "412071063", "story_v_out_412071.awb") ~= 0 then
					local var_266_29 = manager.audio:GetVoiceLength("story_v_out_412071", "412071063", "story_v_out_412071.awb") / 1000

					if var_266_29 + var_266_21 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_29 + var_266_21
					end

					if var_266_24.prefab_name ~= "" and arg_263_1.actors_[var_266_24.prefab_name] ~= nil then
						local var_266_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_24.prefab_name].transform, "story_v_out_412071", "412071063", "story_v_out_412071.awb")

						arg_263_1:RecordAudio("412071063", var_266_30)
						arg_263_1:RecordAudio("412071063", var_266_30)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_412071", "412071063", "story_v_out_412071.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_412071", "412071063", "story_v_out_412071.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_31 = math.max(var_266_22, arg_263_1.talkMaxDuration)

			if var_266_21 <= arg_263_1.time_ and arg_263_1.time_ < var_266_21 + var_266_31 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_21) / var_266_31

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_21 + var_266_31 and arg_263_1.time_ < var_266_21 + var_266_31 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	assets = {
		"TextureConfig/Background/ST85b",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/F02_1"
	},
	voices = {
		"story_v_out_412071.awb"
	}
}
