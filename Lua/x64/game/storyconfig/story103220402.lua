return {
	Play322042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322042001
		arg_1_1.duration_ = 4.1

		local var_1_0 = {
			zh = 4.1,
			ja = 3.9
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
				arg_1_0:Play322042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L15f"

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
				local var_4_5 = arg_1_1.bgs_.L15f

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
					if iter_4_0 ~= "L15f" then
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

			local var_4_24 = "1284ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1284ui_story"].transform
			local var_4_30 = 1.88

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1284ui_story = var_4_29.localPosition

				local var_4_31 = "1284ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_31 .. "Animator"].transform, false)
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(-0.7, -0.985, -6.22)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1284ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38
			end

			local var_4_39 = arg_1_1.actors_["1284ui_story"]
			local var_4_40 = 1.88

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1284ui_story == nil then
				arg_1_1.var_.characterEffect1284ui_story = var_4_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_41 = 0.200000002980232

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 and not isNil(var_4_39) then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41

				if arg_1_1.var_.characterEffect1284ui_story and not isNil(var_4_39) then
					arg_1_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1284ui_story then
				arg_1_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_4_43 = 1.88

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_4_44 = 1.88

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
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

			local var_4_51 = 0.433333333333333
			local var_4_52 = 1

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				local var_4_53 = "play"
				local var_4_54 = "music"

				arg_1_1:AudioAction(var_4_53, var_4_54, "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_4_55 = ""
				local var_4_56 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

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

			local var_4_57 = 0.2
			local var_4_58 = 1

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				local var_4_59 = "play"
				local var_4_60 = "effect"

				arg_1_1:AudioAction(var_4_59, var_4_60, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_61 = 2
			local var_4_62 = 0.325

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

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(322042001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042001", "story_v_out_322042.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_322042", "322042001", "story_v_out_322042.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_322042", "322042001", "story_v_out_322042.awb")

						arg_1_1:RecordAudio("322042001", var_4_71)
						arg_1_1:RecordAudio("322042001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322042", "322042001", "story_v_out_322042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322042", "322042001", "story_v_out_322042.awb")
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
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.88,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322042002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10104ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["10104ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos10104ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0.99, -1.12, -5.99)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10104ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["10104ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10104ui_story == nil then
				arg_9_1.var_.characterEffect10104ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect10104ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10104ui_story then
				arg_9_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_12_18 = arg_9_1.actors_["1284ui_story"]
			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 and not isNil(var_12_18) and arg_9_1.var_.characterEffect1284ui_story == nil then
				arg_9_1.var_.characterEffect1284ui_story = var_12_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_20 = 0.200000002980232

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_20 and not isNil(var_12_18) then
				local var_12_21 = (arg_9_1.time_ - var_12_19) / var_12_20

				if arg_9_1.var_.characterEffect1284ui_story and not isNil(var_12_18) then
					local var_12_22 = Mathf.Lerp(0, 0.5, var_12_21)

					arg_9_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1284ui_story.fillRatio = var_12_22
				end
			end

			if arg_9_1.time_ >= var_12_19 + var_12_20 and arg_9_1.time_ < var_12_19 + var_12_20 + arg_12_0 and not isNil(var_12_18) and arg_9_1.var_.characterEffect1284ui_story then
				local var_12_23 = 0.5

				arg_9_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1284ui_story.fillRatio = var_12_23
			end

			local var_12_24 = 0

			if var_12_24 < arg_9_1.time_ and arg_9_1.time_ <= var_12_24 + arg_12_0 then
				arg_9_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_12_25 = 0

			if var_12_25 < arg_9_1.time_ and arg_9_1.time_ <= var_12_25 + arg_12_0 then
				arg_9_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_12_26 = arg_9_1.actors_["10104ui_story"]
			local var_12_27 = 0

			if var_12_27 < arg_9_1.time_ and arg_9_1.time_ <= var_12_27 + arg_12_0 then
				if arg_9_1.var_.characterEffect10104ui_story == nil then
					arg_9_1.var_.characterEffect10104ui_story = var_12_26:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_12_28 = arg_9_1.var_.characterEffect10104ui_story

				var_12_28.imageEffect:turnOff()

				var_12_28.interferenceEffect.enabled = true
				var_12_28.interferenceEffect.noise = 0.001
				var_12_28.interferenceEffect.simTimeScale = 1
				var_12_28.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_12_29 = arg_9_1.actors_["10104ui_story"]
			local var_12_30 = 0
			local var_12_31 = 5

			if var_12_30 < arg_9_1.time_ and arg_9_1.time_ <= var_12_30 + arg_12_0 then
				if arg_9_1.var_.characterEffect10104ui_story == nil then
					arg_9_1.var_.characterEffect10104ui_story = var_12_29:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_9_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_12_32 = 0
			local var_12_33 = 0.05

			if var_12_32 < arg_9_1.time_ and arg_9_1.time_ <= var_12_32 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_34 = arg_9_1:FormatText(StoryNameCfg[1030].name)

				arg_9_1.leftNameTxt_.text = var_12_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_35 = arg_9_1:GetWordFromCfg(322042002)
				local var_12_36 = arg_9_1:FormatText(var_12_35.content)

				arg_9_1.text_.text = var_12_36

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_37 = 2
				local var_12_38 = utf8.len(var_12_36)
				local var_12_39 = var_12_37 <= 0 and var_12_33 or var_12_33 * (var_12_38 / var_12_37)

				if var_12_39 > 0 and var_12_33 < var_12_39 then
					arg_9_1.talkMaxDuration = var_12_39

					if var_12_39 + var_12_32 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_39 + var_12_32
					end
				end

				arg_9_1.text_.text = var_12_36
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042002", "story_v_out_322042.awb") ~= 0 then
					local var_12_40 = manager.audio:GetVoiceLength("story_v_out_322042", "322042002", "story_v_out_322042.awb") / 1000

					if var_12_40 + var_12_32 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_40 + var_12_32
					end

					if var_12_35.prefab_name ~= "" and arg_9_1.actors_[var_12_35.prefab_name] ~= nil then
						local var_12_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_35.prefab_name].transform, "story_v_out_322042", "322042002", "story_v_out_322042.awb")

						arg_9_1:RecordAudio("322042002", var_12_41)
						arg_9_1:RecordAudio("322042002", var_12_41)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_322042", "322042002", "story_v_out_322042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_322042", "322042002", "story_v_out_322042.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_42 = math.max(var_12_33, arg_9_1.talkMaxDuration)

			if var_12_32 <= arg_9_1.time_ and arg_9_1.time_ < var_12_32 + var_12_42 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_32) / var_12_42

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_32 + var_12_42 and arg_9_1.time_ < var_12_32 + var_12_42 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play322042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322042003
		arg_13_1.duration_ = 5.47

		local var_13_0 = {
			zh = 3.633,
			ja = 5.466
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
				arg_13_0:Play322042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1284ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1284ui_story == nil then
				arg_13_1.var_.characterEffect1284ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1284ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1284ui_story then
				arg_13_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_16_4 = arg_13_1.actors_["10104ui_story"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect10104ui_story == nil then
				arg_13_1.var_.characterEffect10104ui_story = var_16_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.characterEffect10104ui_story and not isNil(var_16_4) then
					local var_16_8 = Mathf.Lerp(0, 0.5, var_16_7)

					arg_13_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10104ui_story.fillRatio = var_16_8
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.characterEffect10104ui_story then
				local var_16_9 = 0.5

				arg_13_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10104ui_story.fillRatio = var_16_9
			end

			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			local var_16_11 = 0

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_12 = 0
			local var_16_13 = 0.525

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_14 = arg_13_1:FormatText(StoryNameCfg[6].name)

				arg_13_1.leftNameTxt_.text = var_16_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:GetWordFromCfg(322042003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042003", "story_v_out_322042.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042003", "story_v_out_322042.awb") / 1000

					if var_16_20 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_12
					end

					if var_16_15.prefab_name ~= "" and arg_13_1.actors_[var_16_15.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_15.prefab_name].transform, "story_v_out_322042", "322042003", "story_v_out_322042.awb")

						arg_13_1:RecordAudio("322042003", var_16_21)
						arg_13_1:RecordAudio("322042003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322042", "322042003", "story_v_out_322042.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322042", "322042003", "story_v_out_322042.awb")
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
	Play322042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322042004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play322042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1284ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1284ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1284ui_story, var_20_4, var_20_3)

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

			local var_20_9 = arg_17_1.actors_["10104ui_story"].transform
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.var_.moveOldPos10104ui_story = var_20_9.localPosition
			end

			local var_20_11 = 0.001

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11
				local var_20_13 = Vector3.New(0, 100, 0)

				var_20_9.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10104ui_story, var_20_13, var_20_12)

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
			local var_20_19 = 1.375

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

				local var_20_20 = arg_17_1:GetWordFromCfg(322042004)
				local var_20_21 = arg_17_1:FormatText(var_20_20.content)

				arg_17_1.text_.text = var_20_21

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_22 = 55
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

		arg_17_1:InitPlayNodeList()
	end,
	Play322042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322042005
		arg_21_1.duration_ = 11.67

		local var_21_0 = {
			zh = 8.633,
			ja = 11.666
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
				arg_21_0:Play322042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1284ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1284ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, -0.985, -6.22)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1284ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, -0.985, -6.22)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1284ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1284ui_story == nil then
				arg_21_1.var_.characterEffect1284ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1284ui_story and not isNil(var_24_9) then
					arg_21_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1284ui_story then
				arg_21_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_24_13 = 0

			if var_24_13 < arg_21_1.time_ and arg_21_1.time_ <= var_24_13 + arg_24_0 then
				arg_21_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_24_15 = 0
			local var_24_16 = 1.2

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(322042005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042005", "story_v_out_322042.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_322042", "322042005", "story_v_out_322042.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_322042", "322042005", "story_v_out_322042.awb")

						arg_21_1:RecordAudio("322042005", var_24_24)
						arg_21_1:RecordAudio("322042005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_322042", "322042005", "story_v_out_322042.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_322042", "322042005", "story_v_out_322042.awb")
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
				actorName = "1284ui_story",
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
	Play322042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322042006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play322042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "404001ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["404001ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos404001ui_story = var_28_5.localPosition
			end

			local var_28_7 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7
				local var_28_9 = Vector3.New(0.8, -1.55, -5.5)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos404001ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_28_12 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_12.x, var_28_12.y, var_28_12.z)

				local var_28_13 = var_28_5.localEulerAngles

				var_28_13.z = 0
				var_28_13.x = 0
				var_28_5.localEulerAngles = var_28_13
			end

			local var_28_14 = arg_25_1.actors_["1284ui_story"].transform
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.var_.moveOldPos1284ui_story = var_28_14.localPosition
			end

			local var_28_16 = 0.001

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16
				local var_28_18 = Vector3.New(-0.7, -0.985, -6.22)

				var_28_14.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1284ui_story, var_28_18, var_28_17)

				local var_28_19 = manager.ui.mainCamera.transform.position - var_28_14.position

				var_28_14.forward = Vector3.New(var_28_19.x, var_28_19.y, var_28_19.z)

				local var_28_20 = var_28_14.localEulerAngles

				var_28_20.z = 0
				var_28_20.x = 0
				var_28_14.localEulerAngles = var_28_20
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 then
				var_28_14.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_28_21 = manager.ui.mainCamera.transform.position - var_28_14.position

				var_28_14.forward = Vector3.New(var_28_21.x, var_28_21.y, var_28_21.z)

				local var_28_22 = var_28_14.localEulerAngles

				var_28_22.z = 0
				var_28_22.x = 0
				var_28_14.localEulerAngles = var_28_22
			end

			local var_28_23 = arg_25_1.actors_["404001ui_story"]
			local var_28_24 = 0

			if var_28_24 < arg_25_1.time_ and arg_25_1.time_ <= var_28_24 + arg_28_0 and not isNil(var_28_23) and arg_25_1.var_.characterEffect404001ui_story == nil then
				arg_25_1.var_.characterEffect404001ui_story = var_28_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_25 = 0.200000002980232

			if var_28_24 <= arg_25_1.time_ and arg_25_1.time_ < var_28_24 + var_28_25 and not isNil(var_28_23) then
				local var_28_26 = (arg_25_1.time_ - var_28_24) / var_28_25

				if arg_25_1.var_.characterEffect404001ui_story and not isNil(var_28_23) then
					arg_25_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_24 + var_28_25 and arg_25_1.time_ < var_28_24 + var_28_25 + arg_28_0 and not isNil(var_28_23) and arg_25_1.var_.characterEffect404001ui_story then
				arg_25_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_28_27 = arg_25_1.actors_["1284ui_story"]
			local var_28_28 = 0

			if var_28_28 < arg_25_1.time_ and arg_25_1.time_ <= var_28_28 + arg_28_0 and not isNil(var_28_27) and arg_25_1.var_.characterEffect1284ui_story == nil then
				arg_25_1.var_.characterEffect1284ui_story = var_28_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_29 = 0.200000002980232

			if var_28_28 <= arg_25_1.time_ and arg_25_1.time_ < var_28_28 + var_28_29 and not isNil(var_28_27) then
				local var_28_30 = (arg_25_1.time_ - var_28_28) / var_28_29

				if arg_25_1.var_.characterEffect1284ui_story and not isNil(var_28_27) then
					local var_28_31 = Mathf.Lerp(0, 0.5, var_28_30)

					arg_25_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1284ui_story.fillRatio = var_28_31
				end
			end

			if arg_25_1.time_ >= var_28_28 + var_28_29 and arg_25_1.time_ < var_28_28 + var_28_29 + arg_28_0 and not isNil(var_28_27) and arg_25_1.var_.characterEffect1284ui_story then
				local var_28_32 = 0.5

				arg_25_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1284ui_story.fillRatio = var_28_32
			end

			local var_28_33 = 0

			if var_28_33 < arg_25_1.time_ and arg_25_1.time_ <= var_28_33 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_28_34 = 0

			if var_28_34 < arg_25_1.time_ and arg_25_1.time_ <= var_28_34 + arg_28_0 then
				arg_25_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_35 = arg_25_1.actors_["404001ui_story"]
			local var_28_36 = 0

			if var_28_36 < arg_25_1.time_ and arg_25_1.time_ <= var_28_36 + arg_28_0 then
				if arg_25_1.var_.characterEffect404001ui_story == nil then
					arg_25_1.var_.characterEffect404001ui_story = var_28_35:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_28_37 = arg_25_1.var_.characterEffect404001ui_story

				var_28_37.imageEffect:turnOff()

				var_28_37.interferenceEffect.enabled = true
				var_28_37.interferenceEffect.noise = 0.001
				var_28_37.interferenceEffect.simTimeScale = 1
				var_28_37.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_28_38 = arg_25_1.actors_["404001ui_story"]
			local var_28_39 = 0
			local var_28_40 = 5

			if var_28_39 < arg_25_1.time_ and arg_25_1.time_ <= var_28_39 + arg_28_0 then
				if arg_25_1.var_.characterEffect404001ui_story == nil then
					arg_25_1.var_.characterEffect404001ui_story = var_28_38:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_25_1.var_.characterEffect404001ui_story.imageEffect:turnOn(false)
			end

			local var_28_41 = 0
			local var_28_42 = 0.25

			if var_28_41 < arg_25_1.time_ and arg_25_1.time_ <= var_28_41 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_43 = arg_25_1:FormatText(StoryNameCfg[668].name)

				arg_25_1.leftNameTxt_.text = var_28_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_44 = arg_25_1:GetWordFromCfg(322042006)
				local var_28_45 = arg_25_1:FormatText(var_28_44.content)

				arg_25_1.text_.text = var_28_45

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_46 = 10
				local var_28_47 = utf8.len(var_28_45)
				local var_28_48 = var_28_46 <= 0 and var_28_42 or var_28_42 * (var_28_47 / var_28_46)

				if var_28_48 > 0 and var_28_42 < var_28_48 then
					arg_25_1.talkMaxDuration = var_28_48

					if var_28_48 + var_28_41 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_48 + var_28_41
					end
				end

				arg_25_1.text_.text = var_28_45
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042006", "story_v_out_322042.awb") ~= 0 then
					local var_28_49 = manager.audio:GetVoiceLength("story_v_out_322042", "322042006", "story_v_out_322042.awb") / 1000

					if var_28_49 + var_28_41 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_49 + var_28_41
					end

					if var_28_44.prefab_name ~= "" and arg_25_1.actors_[var_28_44.prefab_name] ~= nil then
						local var_28_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_44.prefab_name].transform, "story_v_out_322042", "322042006", "story_v_out_322042.awb")

						arg_25_1:RecordAudio("322042006", var_28_50)
						arg_25_1:RecordAudio("322042006", var_28_50)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322042", "322042006", "story_v_out_322042.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322042", "322042006", "story_v_out_322042.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_51 = math.max(var_28_42, arg_25_1.talkMaxDuration)

			if var_28_41 <= arg_25_1.time_ and arg_25_1.time_ < var_28_41 + var_28_51 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_41) / var_28_51

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_41 + var_28_51 and arg_25_1.time_ < var_28_41 + var_28_51 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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
				actorName = "1284ui_story",
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
	Play322042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322042007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play322042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1284ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1284ui_story == nil then
				arg_29_1.var_.characterEffect1284ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1284ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1284ui_story then
				arg_29_1.var_.characterEffect1284ui_story.fillFlat = false
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
				arg_29_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_32_11 = 0

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_32_12 = 0
			local var_32_13 = 0.075

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_14 = arg_29_1:FormatText(StoryNameCfg[6].name)

				arg_29_1.leftNameTxt_.text = var_32_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_15 = arg_29_1:GetWordFromCfg(322042007)
				local var_32_16 = arg_29_1:FormatText(var_32_15.content)

				arg_29_1.text_.text = var_32_16

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 3
				local var_32_18 = utf8.len(var_32_16)
				local var_32_19 = var_32_17 <= 0 and var_32_13 or var_32_13 * (var_32_18 / var_32_17)

				if var_32_19 > 0 and var_32_13 < var_32_19 then
					arg_29_1.talkMaxDuration = var_32_19

					if var_32_19 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_19 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_16
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042007", "story_v_out_322042.awb") ~= 0 then
					local var_32_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042007", "story_v_out_322042.awb") / 1000

					if var_32_20 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_12
					end

					if var_32_15.prefab_name ~= "" and arg_29_1.actors_[var_32_15.prefab_name] ~= nil then
						local var_32_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_15.prefab_name].transform, "story_v_out_322042", "322042007", "story_v_out_322042.awb")

						arg_29_1:RecordAudio("322042007", var_32_21)
						arg_29_1:RecordAudio("322042007", var_32_21)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322042", "322042007", "story_v_out_322042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322042", "322042007", "story_v_out_322042.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_22 and arg_29_1.time_ < var_32_12 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322042008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322042009(arg_33_1)
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

			local var_36_4 = arg_33_1.actors_["1284ui_story"]
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1284ui_story == nil then
				arg_33_1.var_.characterEffect1284ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 and not isNil(var_36_4) then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6

				if arg_33_1.var_.characterEffect1284ui_story and not isNil(var_36_4) then
					local var_36_8 = Mathf.Lerp(0, 0.5, var_36_7)

					arg_33_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1284ui_story.fillRatio = var_36_8
				end
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1284ui_story then
				local var_36_9 = 0.5

				arg_33_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1284ui_story.fillRatio = var_36_9
			end

			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_36_11 = 0

			if var_36_11 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_12 = arg_33_1.actors_["404001ui_story"]
			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				if arg_33_1.var_.characterEffect404001ui_story == nil then
					arg_33_1.var_.characterEffect404001ui_story = var_36_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_36_14 = arg_33_1.var_.characterEffect404001ui_story

				var_36_14.imageEffect:turnOff()

				var_36_14.interferenceEffect.enabled = true
				var_36_14.interferenceEffect.noise = 0.001
				var_36_14.interferenceEffect.simTimeScale = 1
				var_36_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_36_15 = arg_33_1.actors_["404001ui_story"]
			local var_36_16 = 0
			local var_36_17 = 5

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				if arg_33_1.var_.characterEffect404001ui_story == nil then
					arg_33_1.var_.characterEffect404001ui_story = var_36_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_33_1.var_.characterEffect404001ui_story.imageEffect:turnOn(false)
			end

			local var_36_18 = 0
			local var_36_19 = 0.325

			if var_36_18 < arg_33_1.time_ and arg_33_1.time_ <= var_36_18 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_20 = arg_33_1:FormatText(StoryNameCfg[668].name)

				arg_33_1.leftNameTxt_.text = var_36_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_21 = arg_33_1:GetWordFromCfg(322042008)
				local var_36_22 = arg_33_1:FormatText(var_36_21.content)

				arg_33_1.text_.text = var_36_22

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_23 = 13
				local var_36_24 = utf8.len(var_36_22)
				local var_36_25 = var_36_23 <= 0 and var_36_19 or var_36_19 * (var_36_24 / var_36_23)

				if var_36_25 > 0 and var_36_19 < var_36_25 then
					arg_33_1.talkMaxDuration = var_36_25

					if var_36_25 + var_36_18 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_25 + var_36_18
					end
				end

				arg_33_1.text_.text = var_36_22
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042008", "story_v_out_322042.awb") ~= 0 then
					local var_36_26 = manager.audio:GetVoiceLength("story_v_out_322042", "322042008", "story_v_out_322042.awb") / 1000

					if var_36_26 + var_36_18 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_26 + var_36_18
					end

					if var_36_21.prefab_name ~= "" and arg_33_1.actors_[var_36_21.prefab_name] ~= nil then
						local var_36_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_21.prefab_name].transform, "story_v_out_322042", "322042008", "story_v_out_322042.awb")

						arg_33_1:RecordAudio("322042008", var_36_27)
						arg_33_1:RecordAudio("322042008", var_36_27)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322042", "322042008", "story_v_out_322042.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322042", "322042008", "story_v_out_322042.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_28 = math.max(var_36_19, arg_33_1.talkMaxDuration)

			if var_36_18 <= arg_33_1.time_ and arg_33_1.time_ < var_36_18 + var_36_28 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_18) / var_36_28

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_18 + var_36_28 and arg_33_1.time_ < var_36_18 + var_36_28 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322042009
		arg_37_1.duration_ = 4.03

		local var_37_0 = {
			zh = 2.7,
			ja = 4.033
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
				arg_37_0:Play322042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1284ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1284ui_story == nil then
				arg_37_1.var_.characterEffect1284ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1284ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1284ui_story then
				arg_37_1.var_.characterEffect1284ui_story.fillFlat = false
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
				arg_37_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_1")
			end

			local var_40_11 = 0

			if var_40_11 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_12 = 0
			local var_40_13 = 0.375

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_14 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:GetWordFromCfg(322042009)
				local var_40_16 = arg_37_1:FormatText(var_40_15.content)

				arg_37_1.text_.text = var_40_16

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 15
				local var_40_18 = utf8.len(var_40_16)
				local var_40_19 = var_40_17 <= 0 and var_40_13 or var_40_13 * (var_40_18 / var_40_17)

				if var_40_19 > 0 and var_40_13 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19

					if var_40_19 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_16
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042009", "story_v_out_322042.awb") ~= 0 then
					local var_40_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042009", "story_v_out_322042.awb") / 1000

					if var_40_20 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_12
					end

					if var_40_15.prefab_name ~= "" and arg_37_1.actors_[var_40_15.prefab_name] ~= nil then
						local var_40_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_15.prefab_name].transform, "story_v_out_322042", "322042009", "story_v_out_322042.awb")

						arg_37_1:RecordAudio("322042009", var_40_21)
						arg_37_1:RecordAudio("322042009", var_40_21)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322042", "322042009", "story_v_out_322042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322042", "322042009", "story_v_out_322042.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_22 and arg_37_1.time_ < var_40_12 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play322042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322042010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play322042011(arg_41_1)
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

			local var_44_4 = arg_41_1.actors_["1284ui_story"]
			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1284ui_story == nil then
				arg_41_1.var_.characterEffect1284ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 and not isNil(var_44_4) then
				local var_44_7 = (arg_41_1.time_ - var_44_5) / var_44_6

				if arg_41_1.var_.characterEffect1284ui_story and not isNil(var_44_4) then
					local var_44_8 = Mathf.Lerp(0, 0.5, var_44_7)

					arg_41_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1284ui_story.fillRatio = var_44_8
				end
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1284ui_story then
				local var_44_9 = 0.5

				arg_41_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1284ui_story.fillRatio = var_44_9
			end

			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_44_11 = 0

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_44_12 = arg_41_1.actors_["404001ui_story"]
			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				if arg_41_1.var_.characterEffect404001ui_story == nil then
					arg_41_1.var_.characterEffect404001ui_story = var_44_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_44_14 = arg_41_1.var_.characterEffect404001ui_story

				var_44_14.imageEffect:turnOff()

				var_44_14.interferenceEffect.enabled = true
				var_44_14.interferenceEffect.noise = 0.001
				var_44_14.interferenceEffect.simTimeScale = 1
				var_44_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_44_15 = arg_41_1.actors_["404001ui_story"]
			local var_44_16 = 0
			local var_44_17 = 5

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				if arg_41_1.var_.characterEffect404001ui_story == nil then
					arg_41_1.var_.characterEffect404001ui_story = var_44_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_41_1.var_.characterEffect404001ui_story.imageEffect:turnOn(false)
			end

			local var_44_18 = 0
			local var_44_19 = 0.35

			if var_44_18 < arg_41_1.time_ and arg_41_1.time_ <= var_44_18 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_20 = arg_41_1:FormatText(StoryNameCfg[668].name)

				arg_41_1.leftNameTxt_.text = var_44_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_21 = arg_41_1:GetWordFromCfg(322042010)
				local var_44_22 = arg_41_1:FormatText(var_44_21.content)

				arg_41_1.text_.text = var_44_22

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_23 = 14
				local var_44_24 = utf8.len(var_44_22)
				local var_44_25 = var_44_23 <= 0 and var_44_19 or var_44_19 * (var_44_24 / var_44_23)

				if var_44_25 > 0 and var_44_19 < var_44_25 then
					arg_41_1.talkMaxDuration = var_44_25

					if var_44_25 + var_44_18 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_25 + var_44_18
					end
				end

				arg_41_1.text_.text = var_44_22
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042010", "story_v_out_322042.awb") ~= 0 then
					local var_44_26 = manager.audio:GetVoiceLength("story_v_out_322042", "322042010", "story_v_out_322042.awb") / 1000

					if var_44_26 + var_44_18 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_26 + var_44_18
					end

					if var_44_21.prefab_name ~= "" and arg_41_1.actors_[var_44_21.prefab_name] ~= nil then
						local var_44_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_21.prefab_name].transform, "story_v_out_322042", "322042010", "story_v_out_322042.awb")

						arg_41_1:RecordAudio("322042010", var_44_27)
						arg_41_1:RecordAudio("322042010", var_44_27)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322042", "322042010", "story_v_out_322042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322042", "322042010", "story_v_out_322042.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_28 = math.max(var_44_19, arg_41_1.talkMaxDuration)

			if var_44_18 <= arg_41_1.time_ and arg_41_1.time_ < var_44_18 + var_44_28 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_18) / var_44_28

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_18 + var_44_28 and arg_41_1.time_ < var_44_18 + var_44_28 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play322042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322042011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10104ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10104ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0.99, -1.12, -5.99)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10104ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["404001ui_story"].transform
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.var_.moveOldPos404001ui_story = var_48_9.localPosition
			end

			local var_48_11 = 0.001

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11
				local var_48_13 = Vector3.New(0, 100, 0)

				var_48_9.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos404001ui_story, var_48_13, var_48_12)

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

			local var_48_18 = arg_45_1.actors_["10104ui_story"]
			local var_48_19 = 0

			if var_48_19 < arg_45_1.time_ and arg_45_1.time_ <= var_48_19 + arg_48_0 and not isNil(var_48_18) and arg_45_1.var_.characterEffect10104ui_story == nil then
				arg_45_1.var_.characterEffect10104ui_story = var_48_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_20 = 0.200000002980232

			if var_48_19 <= arg_45_1.time_ and arg_45_1.time_ < var_48_19 + var_48_20 and not isNil(var_48_18) then
				local var_48_21 = (arg_45_1.time_ - var_48_19) / var_48_20

				if arg_45_1.var_.characterEffect10104ui_story and not isNil(var_48_18) then
					arg_45_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_19 + var_48_20 and arg_45_1.time_ < var_48_19 + var_48_20 + arg_48_0 and not isNil(var_48_18) and arg_45_1.var_.characterEffect10104ui_story then
				arg_45_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_48_22 = arg_45_1.actors_["404001ui_story"]
			local var_48_23 = 0

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.characterEffect404001ui_story == nil then
				arg_45_1.var_.characterEffect404001ui_story = var_48_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_24 = 0.200000002980232

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_24 and not isNil(var_48_22) then
				local var_48_25 = (arg_45_1.time_ - var_48_23) / var_48_24

				if arg_45_1.var_.characterEffect404001ui_story and not isNil(var_48_22) then
					local var_48_26 = Mathf.Lerp(0, 0.5, var_48_25)

					arg_45_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_45_1.var_.characterEffect404001ui_story.fillRatio = var_48_26
				end
			end

			if arg_45_1.time_ >= var_48_23 + var_48_24 and arg_45_1.time_ < var_48_23 + var_48_24 + arg_48_0 and not isNil(var_48_22) and arg_45_1.var_.characterEffect404001ui_story then
				local var_48_27 = 0.5

				arg_45_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_45_1.var_.characterEffect404001ui_story.fillRatio = var_48_27
			end

			local var_48_28 = 0

			if var_48_28 < arg_45_1.time_ and arg_45_1.time_ <= var_48_28 + arg_48_0 then
				arg_45_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_48_29 = 0

			if var_48_29 < arg_45_1.time_ and arg_45_1.time_ <= var_48_29 + arg_48_0 then
				arg_45_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_48_30 = arg_45_1.actors_["10104ui_story"]
			local var_48_31 = 0

			if var_48_31 < arg_45_1.time_ and arg_45_1.time_ <= var_48_31 + arg_48_0 then
				if arg_45_1.var_.characterEffect10104ui_story == nil then
					arg_45_1.var_.characterEffect10104ui_story = var_48_30:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_48_32 = arg_45_1.var_.characterEffect10104ui_story

				var_48_32.imageEffect:turnOff()

				var_48_32.interferenceEffect.enabled = true
				var_48_32.interferenceEffect.noise = 0.001
				var_48_32.interferenceEffect.simTimeScale = 1
				var_48_32.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_48_33 = arg_45_1.actors_["10104ui_story"]
			local var_48_34 = 0
			local var_48_35 = 5

			if var_48_34 < arg_45_1.time_ and arg_45_1.time_ <= var_48_34 + arg_48_0 then
				if arg_45_1.var_.characterEffect10104ui_story == nil then
					arg_45_1.var_.characterEffect10104ui_story = var_48_33:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_45_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_48_36 = 0
			local var_48_37 = 0.375

			if var_48_36 < arg_45_1.time_ and arg_45_1.time_ <= var_48_36 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_38 = arg_45_1:FormatText(StoryNameCfg[1030].name)

				arg_45_1.leftNameTxt_.text = var_48_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_39 = arg_45_1:GetWordFromCfg(322042011)
				local var_48_40 = arg_45_1:FormatText(var_48_39.content)

				arg_45_1.text_.text = var_48_40

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_41 = 15
				local var_48_42 = utf8.len(var_48_40)
				local var_48_43 = var_48_41 <= 0 and var_48_37 or var_48_37 * (var_48_42 / var_48_41)

				if var_48_43 > 0 and var_48_37 < var_48_43 then
					arg_45_1.talkMaxDuration = var_48_43

					if var_48_43 + var_48_36 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_43 + var_48_36
					end
				end

				arg_45_1.text_.text = var_48_40
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042011", "story_v_out_322042.awb") ~= 0 then
					local var_48_44 = manager.audio:GetVoiceLength("story_v_out_322042", "322042011", "story_v_out_322042.awb") / 1000

					if var_48_44 + var_48_36 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_44 + var_48_36
					end

					if var_48_39.prefab_name ~= "" and arg_45_1.actors_[var_48_39.prefab_name] ~= nil then
						local var_48_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_39.prefab_name].transform, "story_v_out_322042", "322042011", "story_v_out_322042.awb")

						arg_45_1:RecordAudio("322042011", var_48_45)
						arg_45_1:RecordAudio("322042011", var_48_45)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322042", "322042011", "story_v_out_322042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322042", "322042011", "story_v_out_322042.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_46 = math.max(var_48_37, arg_45_1.talkMaxDuration)

			if var_48_36 <= arg_45_1.time_ and arg_45_1.time_ < var_48_36 + var_48_46 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_36) / var_48_46

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_36 + var_48_46 and arg_45_1.time_ < var_48_36 + var_48_46 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
				actorName = "404001ui_story",
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
	Play322042012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322042012
		arg_49_1.duration_ = 5.47

		local var_49_0 = {
			zh = 5.466,
			ja = 5.2
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
				arg_49_0:Play322042013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_52_2 = arg_49_1.actors_["10104ui_story"]
			local var_52_3 = 0

			if var_52_3 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				if arg_49_1.var_.characterEffect10104ui_story == nil then
					arg_49_1.var_.characterEffect10104ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_52_4 = arg_49_1.var_.characterEffect10104ui_story

				var_52_4.imageEffect:turnOff()

				var_52_4.interferenceEffect.enabled = true
				var_52_4.interferenceEffect.noise = 0.001
				var_52_4.interferenceEffect.simTimeScale = 1
				var_52_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_52_5 = arg_49_1.actors_["10104ui_story"]
			local var_52_6 = 0
			local var_52_7 = 5

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				if arg_49_1.var_.characterEffect10104ui_story == nil then
					arg_49_1.var_.characterEffect10104ui_story = var_52_5:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_49_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_52_8 = 0
			local var_52_9 = 0.775

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_10 = arg_49_1:FormatText(StoryNameCfg[1030].name)

				arg_49_1.leftNameTxt_.text = var_52_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_11 = arg_49_1:GetWordFromCfg(322042012)
				local var_52_12 = arg_49_1:FormatText(var_52_11.content)

				arg_49_1.text_.text = var_52_12

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 31
				local var_52_14 = utf8.len(var_52_12)
				local var_52_15 = var_52_13 <= 0 and var_52_9 or var_52_9 * (var_52_14 / var_52_13)

				if var_52_15 > 0 and var_52_9 < var_52_15 then
					arg_49_1.talkMaxDuration = var_52_15

					if var_52_15 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_15 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_12
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042012", "story_v_out_322042.awb") ~= 0 then
					local var_52_16 = manager.audio:GetVoiceLength("story_v_out_322042", "322042012", "story_v_out_322042.awb") / 1000

					if var_52_16 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_16 + var_52_8
					end

					if var_52_11.prefab_name ~= "" and arg_49_1.actors_[var_52_11.prefab_name] ~= nil then
						local var_52_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_11.prefab_name].transform, "story_v_out_322042", "322042012", "story_v_out_322042.awb")

						arg_49_1:RecordAudio("322042012", var_52_17)
						arg_49_1:RecordAudio("322042012", var_52_17)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322042", "322042012", "story_v_out_322042.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322042", "322042012", "story_v_out_322042.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_18 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_18 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_18

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_18 and arg_49_1.time_ < var_52_8 + var_52_18 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322042013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322042013
		arg_53_1.duration_ = 2.3

		local var_53_0 = {
			zh = 2.1,
			ja = 2.3
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
				arg_53_0:Play322042014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1284ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1284ui_story == nil then
				arg_53_1.var_.characterEffect1284ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1284ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1284ui_story then
				arg_53_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_56_4 = arg_53_1.actors_["10104ui_story"]
			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect10104ui_story == nil then
				arg_53_1.var_.characterEffect10104ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_6 and not isNil(var_56_4) then
				local var_56_7 = (arg_53_1.time_ - var_56_5) / var_56_6

				if arg_53_1.var_.characterEffect10104ui_story and not isNil(var_56_4) then
					local var_56_8 = Mathf.Lerp(0, 0.5, var_56_7)

					arg_53_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10104ui_story.fillRatio = var_56_8
				end
			end

			if arg_53_1.time_ >= var_56_5 + var_56_6 and arg_53_1.time_ < var_56_5 + var_56_6 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect10104ui_story then
				local var_56_9 = 0.5

				arg_53_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10104ui_story.fillRatio = var_56_9
			end

			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_2")
			end

			local var_56_11 = 0

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_12 = 0
			local var_56_13 = 0.25

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_14 = arg_53_1:FormatText(StoryNameCfg[6].name)

				arg_53_1.leftNameTxt_.text = var_56_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_15 = arg_53_1:GetWordFromCfg(322042013)
				local var_56_16 = arg_53_1:FormatText(var_56_15.content)

				arg_53_1.text_.text = var_56_16

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 10
				local var_56_18 = utf8.len(var_56_16)
				local var_56_19 = var_56_17 <= 0 and var_56_13 or var_56_13 * (var_56_18 / var_56_17)

				if var_56_19 > 0 and var_56_13 < var_56_19 then
					arg_53_1.talkMaxDuration = var_56_19

					if var_56_19 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_16
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042013", "story_v_out_322042.awb") ~= 0 then
					local var_56_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042013", "story_v_out_322042.awb") / 1000

					if var_56_20 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_20 + var_56_12
					end

					if var_56_15.prefab_name ~= "" and arg_53_1.actors_[var_56_15.prefab_name] ~= nil then
						local var_56_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_15.prefab_name].transform, "story_v_out_322042", "322042013", "story_v_out_322042.awb")

						arg_53_1:RecordAudio("322042013", var_56_21)
						arg_53_1:RecordAudio("322042013", var_56_21)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322042", "322042013", "story_v_out_322042.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322042", "322042013", "story_v_out_322042.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_22 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_22 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_22

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_22 and arg_53_1.time_ < var_56_12 + var_56_22 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322042014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322042014
		arg_57_1.duration_ = 7

		local var_57_0 = {
			zh = 4.999999999999,
			ja = 7
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
				arg_57_0:Play322042015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10104ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10104ui_story == nil then
				arg_57_1.var_.characterEffect10104ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect10104ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10104ui_story then
				arg_57_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_60_4 = arg_57_1.actors_["1284ui_story"]
			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1284ui_story == nil then
				arg_57_1.var_.characterEffect1284ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_6 = 0.200000002980232

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 and not isNil(var_60_4) then
				local var_60_7 = (arg_57_1.time_ - var_60_5) / var_60_6

				if arg_57_1.var_.characterEffect1284ui_story and not isNil(var_60_4) then
					local var_60_8 = Mathf.Lerp(0, 0.5, var_60_7)

					arg_57_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1284ui_story.fillRatio = var_60_8
				end
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1284ui_story then
				local var_60_9 = 0.5

				arg_57_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1284ui_story.fillRatio = var_60_9
			end

			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			local var_60_11 = 0

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 then
				arg_57_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_60_12 = arg_57_1.actors_["10104ui_story"]
			local var_60_13 = 0

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				if arg_57_1.var_.characterEffect10104ui_story == nil then
					arg_57_1.var_.characterEffect10104ui_story = var_60_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_60_14 = arg_57_1.var_.characterEffect10104ui_story

				var_60_14.imageEffect:turnOff()

				var_60_14.interferenceEffect.enabled = true
				var_60_14.interferenceEffect.noise = 0.001
				var_60_14.interferenceEffect.simTimeScale = 1
				var_60_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_60_15 = arg_57_1.actors_["10104ui_story"]
			local var_60_16 = 0
			local var_60_17 = 5

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				if arg_57_1.var_.characterEffect10104ui_story == nil then
					arg_57_1.var_.characterEffect10104ui_story = var_60_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_57_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_60_18 = 0
			local var_60_19 = 0.625

			if var_60_18 < arg_57_1.time_ and arg_57_1.time_ <= var_60_18 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_20 = arg_57_1:FormatText(StoryNameCfg[1030].name)

				arg_57_1.leftNameTxt_.text = var_60_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_21 = arg_57_1:GetWordFromCfg(322042014)
				local var_60_22 = arg_57_1:FormatText(var_60_21.content)

				arg_57_1.text_.text = var_60_22

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_23 = 25
				local var_60_24 = utf8.len(var_60_22)
				local var_60_25 = var_60_23 <= 0 and var_60_19 or var_60_19 * (var_60_24 / var_60_23)

				if var_60_25 > 0 and var_60_19 < var_60_25 then
					arg_57_1.talkMaxDuration = var_60_25

					if var_60_25 + var_60_18 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_25 + var_60_18
					end
				end

				arg_57_1.text_.text = var_60_22
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042014", "story_v_out_322042.awb") ~= 0 then
					local var_60_26 = manager.audio:GetVoiceLength("story_v_out_322042", "322042014", "story_v_out_322042.awb") / 1000

					if var_60_26 + var_60_18 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_26 + var_60_18
					end

					if var_60_21.prefab_name ~= "" and arg_57_1.actors_[var_60_21.prefab_name] ~= nil then
						local var_60_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_21.prefab_name].transform, "story_v_out_322042", "322042014", "story_v_out_322042.awb")

						arg_57_1:RecordAudio("322042014", var_60_27)
						arg_57_1:RecordAudio("322042014", var_60_27)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322042", "322042014", "story_v_out_322042.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322042", "322042014", "story_v_out_322042.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_28 = math.max(var_60_19, arg_57_1.talkMaxDuration)

			if var_60_18 <= arg_57_1.time_ and arg_57_1.time_ < var_60_18 + var_60_28 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_18) / var_60_28

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_18 + var_60_28 and arg_57_1.time_ < var_60_18 + var_60_28 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play322042015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322042015
		arg_61_1.duration_ = 10.83

		local var_61_0 = {
			zh = 6.266,
			ja = 10.833
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
				arg_61_0:Play322042016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_1")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_2 = arg_61_1.actors_["10104ui_story"]
			local var_64_3 = 0

			if var_64_3 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				if arg_61_1.var_.characterEffect10104ui_story == nil then
					arg_61_1.var_.characterEffect10104ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_64_4 = arg_61_1.var_.characterEffect10104ui_story

				var_64_4.imageEffect:turnOff()

				var_64_4.interferenceEffect.enabled = true
				var_64_4.interferenceEffect.noise = 0.001
				var_64_4.interferenceEffect.simTimeScale = 1
				var_64_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_64_5 = arg_61_1.actors_["10104ui_story"]
			local var_64_6 = 0
			local var_64_7 = 5

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				if arg_61_1.var_.characterEffect10104ui_story == nil then
					arg_61_1.var_.characterEffect10104ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_61_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_64_8 = 0
			local var_64_9 = 0.825

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_10 = arg_61_1:FormatText(StoryNameCfg[1030].name)

				arg_61_1.leftNameTxt_.text = var_64_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_11 = arg_61_1:GetWordFromCfg(322042015)
				local var_64_12 = arg_61_1:FormatText(var_64_11.content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 33
				local var_64_14 = utf8.len(var_64_12)
				local var_64_15 = var_64_13 <= 0 and var_64_9 or var_64_9 * (var_64_14 / var_64_13)

				if var_64_15 > 0 and var_64_9 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15

					if var_64_15 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_12
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042015", "story_v_out_322042.awb") ~= 0 then
					local var_64_16 = manager.audio:GetVoiceLength("story_v_out_322042", "322042015", "story_v_out_322042.awb") / 1000

					if var_64_16 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_8
					end

					if var_64_11.prefab_name ~= "" and arg_61_1.actors_[var_64_11.prefab_name] ~= nil then
						local var_64_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_11.prefab_name].transform, "story_v_out_322042", "322042015", "story_v_out_322042.awb")

						arg_61_1:RecordAudio("322042015", var_64_17)
						arg_61_1:RecordAudio("322042015", var_64_17)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322042", "322042015", "story_v_out_322042.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322042", "322042015", "story_v_out_322042.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_18 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_18 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_18

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_18 and arg_61_1.time_ < var_64_8 + var_64_18 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play322042016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322042016
		arg_65_1.duration_ = 9

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play322042017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = "L15h"

			if arg_65_1.bgs_[var_68_0] == nil then
				local var_68_1 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_68_0)
				var_68_1.name = var_68_0
				var_68_1.transform.parent = arg_65_1.stage_.transform
				var_68_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_[var_68_0] = var_68_1
			end

			local var_68_2 = 2

			if var_68_2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				local var_68_3 = manager.ui.mainCamera.transform.localPosition
				local var_68_4 = Vector3.New(0, 0, 10) + Vector3.New(var_68_3.x, var_68_3.y, 0)
				local var_68_5 = arg_65_1.bgs_.L15h

				var_68_5.transform.localPosition = var_68_4
				var_68_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_6 = var_68_5:GetComponent("SpriteRenderer")

				if var_68_6 and var_68_6.sprite then
					local var_68_7 = (var_68_5.transform.localPosition - var_68_3).z
					local var_68_8 = manager.ui.mainCameraCom_
					local var_68_9 = 2 * var_68_7 * Mathf.Tan(var_68_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_68_10 = var_68_9 * var_68_8.aspect
					local var_68_11 = var_68_6.sprite.bounds.size.x
					local var_68_12 = var_68_6.sprite.bounds.size.y
					local var_68_13 = var_68_10 / var_68_11
					local var_68_14 = var_68_9 / var_68_12
					local var_68_15 = var_68_14 < var_68_13 and var_68_13 or var_68_14

					var_68_5.transform.localScale = Vector3.New(var_68_15, var_68_15, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "L15h" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_16 = 3.999999999999

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			local var_68_17 = 0.3

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_18 = 0

			if var_68_18 < arg_65_1.time_ and arg_65_1.time_ <= var_68_18 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_19 = 2

			if var_68_18 <= arg_65_1.time_ and arg_65_1.time_ < var_68_18 + var_68_19 then
				local var_68_20 = (arg_65_1.time_ - var_68_18) / var_68_19
				local var_68_21 = Color.New(0, 0, 0)

				var_68_21.a = Mathf.Lerp(0, 1, var_68_20)
				arg_65_1.mask_.color = var_68_21
			end

			if arg_65_1.time_ >= var_68_18 + var_68_19 and arg_65_1.time_ < var_68_18 + var_68_19 + arg_68_0 then
				local var_68_22 = Color.New(0, 0, 0)

				var_68_22.a = 1
				arg_65_1.mask_.color = var_68_22
			end

			local var_68_23 = 2

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_24 = 2

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_24 then
				local var_68_25 = (arg_65_1.time_ - var_68_23) / var_68_24
				local var_68_26 = Color.New(0, 0, 0)

				var_68_26.a = Mathf.Lerp(1, 0, var_68_25)
				arg_65_1.mask_.color = var_68_26
			end

			if arg_65_1.time_ >= var_68_23 + var_68_24 and arg_65_1.time_ < var_68_23 + var_68_24 + arg_68_0 then
				local var_68_27 = Color.New(0, 0, 0)
				local var_68_28 = 0

				arg_65_1.mask_.enabled = false
				var_68_27.a = var_68_28
				arg_65_1.mask_.color = var_68_27
			end

			local var_68_29 = arg_65_1.actors_["1284ui_story"].transform
			local var_68_30 = 1.96599999815226

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1.var_.moveOldPos1284ui_story = var_68_29.localPosition
			end

			local var_68_31 = 0.001

			if var_68_30 <= arg_65_1.time_ and arg_65_1.time_ < var_68_30 + var_68_31 then
				local var_68_32 = (arg_65_1.time_ - var_68_30) / var_68_31
				local var_68_33 = Vector3.New(0, 100, 0)

				var_68_29.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1284ui_story, var_68_33, var_68_32)

				local var_68_34 = manager.ui.mainCamera.transform.position - var_68_29.position

				var_68_29.forward = Vector3.New(var_68_34.x, var_68_34.y, var_68_34.z)

				local var_68_35 = var_68_29.localEulerAngles

				var_68_35.z = 0
				var_68_35.x = 0
				var_68_29.localEulerAngles = var_68_35
			end

			if arg_65_1.time_ >= var_68_30 + var_68_31 and arg_65_1.time_ < var_68_30 + var_68_31 + arg_68_0 then
				var_68_29.localPosition = Vector3.New(0, 100, 0)

				local var_68_36 = manager.ui.mainCamera.transform.position - var_68_29.position

				var_68_29.forward = Vector3.New(var_68_36.x, var_68_36.y, var_68_36.z)

				local var_68_37 = var_68_29.localEulerAngles

				var_68_37.z = 0
				var_68_37.x = 0
				var_68_29.localEulerAngles = var_68_37
			end

			local var_68_38 = arg_65_1.actors_["10104ui_story"].transform
			local var_68_39 = 1.96599999815226

			if var_68_39 < arg_65_1.time_ and arg_65_1.time_ <= var_68_39 + arg_68_0 then
				arg_65_1.var_.moveOldPos10104ui_story = var_68_38.localPosition
			end

			local var_68_40 = 0.001

			if var_68_39 <= arg_65_1.time_ and arg_65_1.time_ < var_68_39 + var_68_40 then
				local var_68_41 = (arg_65_1.time_ - var_68_39) / var_68_40
				local var_68_42 = Vector3.New(0, 100, 0)

				var_68_38.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10104ui_story, var_68_42, var_68_41)

				local var_68_43 = manager.ui.mainCamera.transform.position - var_68_38.position

				var_68_38.forward = Vector3.New(var_68_43.x, var_68_43.y, var_68_43.z)

				local var_68_44 = var_68_38.localEulerAngles

				var_68_44.z = 0
				var_68_44.x = 0
				var_68_38.localEulerAngles = var_68_44
			end

			if arg_65_1.time_ >= var_68_39 + var_68_40 and arg_65_1.time_ < var_68_39 + var_68_40 + arg_68_0 then
				var_68_38.localPosition = Vector3.New(0, 100, 0)

				local var_68_45 = manager.ui.mainCamera.transform.position - var_68_38.position

				var_68_38.forward = Vector3.New(var_68_45.x, var_68_45.y, var_68_45.z)

				local var_68_46 = var_68_38.localEulerAngles

				var_68_46.z = 0
				var_68_46.x = 0
				var_68_38.localEulerAngles = var_68_46
			end

			local var_68_47 = arg_65_1.actors_["10104ui_story"]
			local var_68_48 = 1.96599999815226

			if var_68_48 < arg_65_1.time_ and arg_65_1.time_ <= var_68_48 + arg_68_0 and not isNil(var_68_47) and arg_65_1.var_.characterEffect10104ui_story == nil then
				arg_65_1.var_.characterEffect10104ui_story = var_68_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_49 = 0.034000001847744

			if var_68_48 <= arg_65_1.time_ and arg_65_1.time_ < var_68_48 + var_68_49 and not isNil(var_68_47) then
				local var_68_50 = (arg_65_1.time_ - var_68_48) / var_68_49

				if arg_65_1.var_.characterEffect10104ui_story and not isNil(var_68_47) then
					local var_68_51 = Mathf.Lerp(0, 0.5, var_68_50)

					arg_65_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10104ui_story.fillRatio = var_68_51
				end
			end

			if arg_65_1.time_ >= var_68_48 + var_68_49 and arg_65_1.time_ < var_68_48 + var_68_49 + arg_68_0 and not isNil(var_68_47) and arg_65_1.var_.characterEffect10104ui_story then
				local var_68_52 = 0.5

				arg_65_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10104ui_story.fillRatio = var_68_52
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_53 = 3.999999999999
			local var_68_54 = 0.6

			if var_68_53 < arg_65_1.time_ and arg_65_1.time_ <= var_68_53 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_55 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_55:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_56 = arg_65_1:GetWordFromCfg(322042016)
				local var_68_57 = arg_65_1:FormatText(var_68_56.content)

				arg_65_1.text_.text = var_68_57

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_58 = 24
				local var_68_59 = utf8.len(var_68_57)
				local var_68_60 = var_68_58 <= 0 and var_68_54 or var_68_54 * (var_68_59 / var_68_58)

				if var_68_60 > 0 and var_68_54 < var_68_60 then
					arg_65_1.talkMaxDuration = var_68_60
					var_68_53 = var_68_53 + 0.3

					if var_68_60 + var_68_53 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_60 + var_68_53
					end
				end

				arg_65_1.text_.text = var_68_57
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_61 = var_68_53 + 0.3
			local var_68_62 = math.max(var_68_54, arg_65_1.talkMaxDuration)

			if var_68_61 <= arg_65_1.time_ and arg_65_1.time_ < var_68_61 + var_68_62 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_61) / var_68_62

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_61 + var_68_62 and arg_65_1.time_ < var_68_61 + var_68_62 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play322042017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322042017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play322042018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.766666666666667
			local var_74_1 = 1

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				local var_74_2 = "play"
				local var_74_3 = "effect"

				arg_71_1:AudioAction(var_74_2, var_74_3, "se_story_140", "se_story_140_explosion05", "")
			end

			local var_74_4 = manager.ui.mainCamera.transform
			local var_74_5 = 0.766666666666667

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.var_.shakeOldPos = var_74_4.localPosition
			end

			local var_74_6 = 0.833333333333333

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_6 then
				local var_74_7 = (arg_71_1.time_ - var_74_5) / 0.066
				local var_74_8, var_74_9 = math.modf(var_74_7)

				var_74_4.localPosition = Vector3.New(var_74_9 * 0.13, var_74_9 * 0.13, var_74_9 * 0.13) + arg_71_1.var_.shakeOldPos
			end

			if arg_71_1.time_ >= var_74_5 + var_74_6 and arg_71_1.time_ < var_74_5 + var_74_6 + arg_74_0 then
				var_74_4.localPosition = arg_71_1.var_.shakeOldPos
			end

			local var_74_10 = 0
			local var_74_11 = 1.025

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_12 = arg_71_1:GetWordFromCfg(322042017)
				local var_74_13 = arg_71_1:FormatText(var_74_12.content)

				arg_71_1.text_.text = var_74_13

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_14 = 41
				local var_74_15 = utf8.len(var_74_13)
				local var_74_16 = var_74_14 <= 0 and var_74_11 or var_74_11 * (var_74_15 / var_74_14)

				if var_74_16 > 0 and var_74_11 < var_74_16 then
					arg_71_1.talkMaxDuration = var_74_16

					if var_74_16 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_16 + var_74_10
					end
				end

				arg_71_1.text_.text = var_74_13
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_17 = math.max(var_74_11, arg_71_1.talkMaxDuration)

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_17 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_10) / var_74_17

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_10 + var_74_17 and arg_71_1.time_ < var_74_10 + var_74_17 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play322042018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322042018
		arg_75_1.duration_ = 2

		local var_75_0 = {
			zh = 1.999999999999,
			ja = 2
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play322042019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "1156ui_story"

			if arg_75_1.actors_[var_78_0] == nil then
				local var_78_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_78_1) then
					local var_78_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_75_1.stage_.transform)

					var_78_2.name = var_78_0
					var_78_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_75_1.actors_[var_78_0] = var_78_2

					local var_78_3 = var_78_2:GetComponentInChildren(typeof(CharacterEffect))

					var_78_3.enabled = true

					local var_78_4 = GameObjectTools.GetOrAddComponent(var_78_2, typeof(DynamicBoneHelper))

					if var_78_4 then
						var_78_4:EnableDynamicBone(false)
					end

					arg_75_1:ShowWeapon(var_78_3.transform, false)

					arg_75_1.var_[var_78_0 .. "Animator"] = var_78_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_75_1.var_[var_78_0 .. "Animator"].applyRootMotion = true
					arg_75_1.var_[var_78_0 .. "LipSync"] = var_78_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_78_5 = arg_75_1.actors_["1156ui_story"].transform
			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.var_.moveOldPos1156ui_story = var_78_5.localPosition
			end

			local var_78_7 = 0.001

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_7 then
				local var_78_8 = (arg_75_1.time_ - var_78_6) / var_78_7
				local var_78_9 = Vector3.New(-0.9, -1.1, -6.18)

				var_78_5.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1156ui_story, var_78_9, var_78_8)

				local var_78_10 = manager.ui.mainCamera.transform.position - var_78_5.position

				var_78_5.forward = Vector3.New(var_78_10.x, var_78_10.y, var_78_10.z)

				local var_78_11 = var_78_5.localEulerAngles

				var_78_11.z = 0
				var_78_11.x = 0
				var_78_5.localEulerAngles = var_78_11
			end

			if arg_75_1.time_ >= var_78_6 + var_78_7 and arg_75_1.time_ < var_78_6 + var_78_7 + arg_78_0 then
				var_78_5.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_78_12 = manager.ui.mainCamera.transform.position - var_78_5.position

				var_78_5.forward = Vector3.New(var_78_12.x, var_78_12.y, var_78_12.z)

				local var_78_13 = var_78_5.localEulerAngles

				var_78_13.z = 0
				var_78_13.x = 0
				var_78_5.localEulerAngles = var_78_13
			end

			local var_78_14 = arg_75_1.actors_["1156ui_story"]
			local var_78_15 = 0

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 and not isNil(var_78_14) and arg_75_1.var_.characterEffect1156ui_story == nil then
				arg_75_1.var_.characterEffect1156ui_story = var_78_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_16 = 0.200000002980232

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_16 and not isNil(var_78_14) then
				local var_78_17 = (arg_75_1.time_ - var_78_15) / var_78_16

				if arg_75_1.var_.characterEffect1156ui_story and not isNil(var_78_14) then
					arg_75_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_15 + var_78_16 and arg_75_1.time_ < var_78_15 + var_78_16 + arg_78_0 and not isNil(var_78_14) and arg_75_1.var_.characterEffect1156ui_story then
				arg_75_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_78_18 = 0

			if var_78_18 < arg_75_1.time_ and arg_75_1.time_ <= var_78_18 + arg_78_0 then
				arg_75_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_78_19 = 0

			if var_78_19 < arg_75_1.time_ and arg_75_1.time_ <= var_78_19 + arg_78_0 then
				arg_75_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_78_20 = 0
			local var_78_21 = 0.125

			if var_78_20 < arg_75_1.time_ and arg_75_1.time_ <= var_78_20 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_22 = arg_75_1:FormatText(StoryNameCfg[605].name)

				arg_75_1.leftNameTxt_.text = var_78_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_23 = arg_75_1:GetWordFromCfg(322042018)
				local var_78_24 = arg_75_1:FormatText(var_78_23.content)

				arg_75_1.text_.text = var_78_24

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_25 = 5
				local var_78_26 = utf8.len(var_78_24)
				local var_78_27 = var_78_25 <= 0 and var_78_21 or var_78_21 * (var_78_26 / var_78_25)

				if var_78_27 > 0 and var_78_21 < var_78_27 then
					arg_75_1.talkMaxDuration = var_78_27

					if var_78_27 + var_78_20 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_27 + var_78_20
					end
				end

				arg_75_1.text_.text = var_78_24
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042018", "story_v_out_322042.awb") ~= 0 then
					local var_78_28 = manager.audio:GetVoiceLength("story_v_out_322042", "322042018", "story_v_out_322042.awb") / 1000

					if var_78_28 + var_78_20 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_28 + var_78_20
					end

					if var_78_23.prefab_name ~= "" and arg_75_1.actors_[var_78_23.prefab_name] ~= nil then
						local var_78_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_23.prefab_name].transform, "story_v_out_322042", "322042018", "story_v_out_322042.awb")

						arg_75_1:RecordAudio("322042018", var_78_29)
						arg_75_1:RecordAudio("322042018", var_78_29)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_322042", "322042018", "story_v_out_322042.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_322042", "322042018", "story_v_out_322042.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_30 = math.max(var_78_21, arg_75_1.talkMaxDuration)

			if var_78_20 <= arg_75_1.time_ and arg_75_1.time_ < var_78_20 + var_78_30 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_20) / var_78_30

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_20 + var_78_30 and arg_75_1.time_ < var_78_20 + var_78_30 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play322042019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322042019
		arg_79_1.duration_ = 2

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play322042020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1284ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1284ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0.7, -0.985, -6.22)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1284ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["1284ui_story"]
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1284ui_story == nil then
				arg_79_1.var_.characterEffect1284ui_story = var_82_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_11 = 0.200000002980232

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 and not isNil(var_82_9) then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11

				if arg_79_1.var_.characterEffect1284ui_story and not isNil(var_82_9) then
					arg_79_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1284ui_story then
				arg_79_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_82_13 = arg_79_1.actors_["1156ui_story"]
			local var_82_14 = 0

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 and not isNil(var_82_13) and arg_79_1.var_.characterEffect1156ui_story == nil then
				arg_79_1.var_.characterEffect1156ui_story = var_82_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_15 = 0.200000002980232

			if var_82_14 <= arg_79_1.time_ and arg_79_1.time_ < var_82_14 + var_82_15 and not isNil(var_82_13) then
				local var_82_16 = (arg_79_1.time_ - var_82_14) / var_82_15

				if arg_79_1.var_.characterEffect1156ui_story and not isNil(var_82_13) then
					local var_82_17 = Mathf.Lerp(0, 0.5, var_82_16)

					arg_79_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1156ui_story.fillRatio = var_82_17
				end
			end

			if arg_79_1.time_ >= var_82_14 + var_82_15 and arg_79_1.time_ < var_82_14 + var_82_15 + arg_82_0 and not isNil(var_82_13) and arg_79_1.var_.characterEffect1156ui_story then
				local var_82_18 = 0.5

				arg_79_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1156ui_story.fillRatio = var_82_18
			end

			local var_82_19 = 0

			if var_82_19 < arg_79_1.time_ and arg_79_1.time_ <= var_82_19 + arg_82_0 then
				arg_79_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_82_20 = 0

			if var_82_20 < arg_79_1.time_ and arg_79_1.time_ <= var_82_20 + arg_82_0 then
				arg_79_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_82_21 = 0
			local var_82_22 = 0.2

			if var_82_21 < arg_79_1.time_ and arg_79_1.time_ <= var_82_21 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_23 = arg_79_1:FormatText(StoryNameCfg[6].name)

				arg_79_1.leftNameTxt_.text = var_82_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_24 = arg_79_1:GetWordFromCfg(322042019)
				local var_82_25 = arg_79_1:FormatText(var_82_24.content)

				arg_79_1.text_.text = var_82_25

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_26 = 8
				local var_82_27 = utf8.len(var_82_25)
				local var_82_28 = var_82_26 <= 0 and var_82_22 or var_82_22 * (var_82_27 / var_82_26)

				if var_82_28 > 0 and var_82_22 < var_82_28 then
					arg_79_1.talkMaxDuration = var_82_28

					if var_82_28 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_28 + var_82_21
					end
				end

				arg_79_1.text_.text = var_82_25
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042019", "story_v_out_322042.awb") ~= 0 then
					local var_82_29 = manager.audio:GetVoiceLength("story_v_out_322042", "322042019", "story_v_out_322042.awb") / 1000

					if var_82_29 + var_82_21 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_29 + var_82_21
					end

					if var_82_24.prefab_name ~= "" and arg_79_1.actors_[var_82_24.prefab_name] ~= nil then
						local var_82_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_24.prefab_name].transform, "story_v_out_322042", "322042019", "story_v_out_322042.awb")

						arg_79_1:RecordAudio("322042019", var_82_30)
						arg_79_1:RecordAudio("322042019", var_82_30)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_322042", "322042019", "story_v_out_322042.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_322042", "322042019", "story_v_out_322042.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_31 = math.max(var_82_22, arg_79_1.talkMaxDuration)

			if var_82_21 <= arg_79_1.time_ and arg_79_1.time_ < var_82_21 + var_82_31 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_21) / var_82_31

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_21 + var_82_31 and arg_79_1.time_ < var_82_21 + var_82_31 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play322042020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322042020
		arg_83_1.duration_ = 6

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play322042021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1284ui_story"].transform
			local var_86_1 = 1

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1284ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1284ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["1156ui_story"].transform
			local var_86_10 = 1

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1.var_.moveOldPos1156ui_story = var_86_9.localPosition
			end

			local var_86_11 = 0.001

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11
				local var_86_13 = Vector3.New(0, 100, 0)

				var_86_9.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1156ui_story, var_86_13, var_86_12)

				local var_86_14 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_14.x, var_86_14.y, var_86_14.z)

				local var_86_15 = var_86_9.localEulerAngles

				var_86_15.z = 0
				var_86_15.x = 0
				var_86_9.localEulerAngles = var_86_15
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 then
				var_86_9.localPosition = Vector3.New(0, 100, 0)

				local var_86_16 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_16.x, var_86_16.y, var_86_16.z)

				local var_86_17 = var_86_9.localEulerAngles

				var_86_17.z = 0
				var_86_17.x = 0
				var_86_9.localEulerAngles = var_86_17
			end

			local var_86_18 = manager.ui.mainCamera.transform
			local var_86_19 = 1

			if var_86_19 < arg_83_1.time_ and arg_83_1.time_ <= var_86_19 + arg_86_0 then
				local var_86_20 = arg_83_1.var_.effect2023
				local var_86_21
				local var_86_22 = var_86_18

				if not var_86_20 then
					var_86_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), var_86_22)
					var_86_20.name = "2023"
					arg_83_1.var_.effect2023 = var_86_20
				else
					var_86_20.transform:SetParent(var_86_22)
				end

				var_86_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_86_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_86_23 = 1
			local var_86_24 = 1

			if var_86_23 < arg_83_1.time_ and arg_83_1.time_ <= var_86_23 + arg_86_0 then
				local var_86_25 = "play"
				local var_86_26 = "effect"

				arg_83_1:AudioAction(var_86_25, var_86_26, "se_story_145", "se_story_145_fire04_loop", "")
			end

			local var_86_27 = 0

			if var_86_27 < arg_83_1.time_ and arg_83_1.time_ <= var_86_27 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_28 = 1

			if var_86_27 <= arg_83_1.time_ and arg_83_1.time_ < var_86_27 + var_86_28 then
				local var_86_29 = (arg_83_1.time_ - var_86_27) / var_86_28
				local var_86_30 = Color.New(0, 0, 0)

				var_86_30.a = Mathf.Lerp(0, 1, var_86_29)
				arg_83_1.mask_.color = var_86_30
			end

			if arg_83_1.time_ >= var_86_27 + var_86_28 and arg_83_1.time_ < var_86_27 + var_86_28 + arg_86_0 then
				local var_86_31 = Color.New(0, 0, 0)

				var_86_31.a = 1
				arg_83_1.mask_.color = var_86_31
			end

			local var_86_32 = 1

			if var_86_32 < arg_83_1.time_ and arg_83_1.time_ <= var_86_32 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_33 = 1

			if var_86_32 <= arg_83_1.time_ and arg_83_1.time_ < var_86_32 + var_86_33 then
				local var_86_34 = (arg_83_1.time_ - var_86_32) / var_86_33
				local var_86_35 = Color.New(0, 0, 0)

				var_86_35.a = Mathf.Lerp(1, 0, var_86_34)
				arg_83_1.mask_.color = var_86_35
			end

			if arg_83_1.time_ >= var_86_32 + var_86_33 and arg_83_1.time_ < var_86_32 + var_86_33 + arg_86_0 then
				local var_86_36 = Color.New(0, 0, 0)
				local var_86_37 = 0

				arg_83_1.mask_.enabled = false
				var_86_36.a = var_86_37
				arg_83_1.mask_.color = var_86_36
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_38 = 1
			local var_86_39 = 1.275

			if var_86_38 < arg_83_1.time_ and arg_83_1.time_ <= var_86_38 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_40 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_40:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_41 = arg_83_1:GetWordFromCfg(322042020)
				local var_86_42 = arg_83_1:FormatText(var_86_41.content)

				arg_83_1.text_.text = var_86_42

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_43 = 51
				local var_86_44 = utf8.len(var_86_42)
				local var_86_45 = var_86_43 <= 0 and var_86_39 or var_86_39 * (var_86_44 / var_86_43)

				if var_86_45 > 0 and var_86_39 < var_86_45 then
					arg_83_1.talkMaxDuration = var_86_45
					var_86_38 = var_86_38 + 0.3

					if var_86_45 + var_86_38 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_45 + var_86_38
					end
				end

				arg_83_1.text_.text = var_86_42
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_46 = var_86_38 + 0.3
			local var_86_47 = math.max(var_86_39, arg_83_1.talkMaxDuration)

			if var_86_46 <= arg_83_1.time_ and arg_83_1.time_ < var_86_46 + var_86_47 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_46) / var_86_47

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_46 + var_86_47 and arg_83_1.time_ < var_86_46 + var_86_47 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play322042021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 322042021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play322042022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 1.275

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

				local var_92_2 = arg_89_1:GetWordFromCfg(322042021)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 51
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
	Play322042022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322042022
		arg_93_1.duration_ = 3.4

		local var_93_0 = {
			zh = 2.7,
			ja = 3.4
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
				arg_93_0:Play322042023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = "10150ui_story"

			if arg_93_1.actors_[var_96_0] == nil then
				local var_96_1 = Asset.Load("Char/" .. "10150ui_story")

				if not isNil(var_96_1) then
					local var_96_2 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_93_1.stage_.transform)

					var_96_2.name = var_96_0
					var_96_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_93_1.actors_[var_96_0] = var_96_2

					local var_96_3 = var_96_2:GetComponentInChildren(typeof(CharacterEffect))

					var_96_3.enabled = true

					local var_96_4 = GameObjectTools.GetOrAddComponent(var_96_2, typeof(DynamicBoneHelper))

					if var_96_4 then
						var_96_4:EnableDynamicBone(false)
					end

					arg_93_1:ShowWeapon(var_96_3.transform, false)

					arg_93_1.var_[var_96_0 .. "Animator"] = var_96_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_93_1.var_[var_96_0 .. "Animator"].applyRootMotion = true
					arg_93_1.var_[var_96_0 .. "LipSync"] = var_96_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_96_5 = arg_93_1.actors_["10150ui_story"].transform
			local var_96_6 = 0

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.var_.moveOldPos10150ui_story = var_96_5.localPosition

				local var_96_7 = GameObjectTools.GetOrAddComponent(var_96_5.gameObject, typeof(DynamicBoneHelper))

				if var_96_7 then
					var_96_7:EnableDynamicBone(false)
				end
			end

			local var_96_8 = 0.001

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_8 then
				local var_96_9 = (arg_93_1.time_ - var_96_6) / var_96_8
				local var_96_10 = Vector3.New(0, -1.73, -5.5)

				var_96_5.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10150ui_story, var_96_10, var_96_9)

				local var_96_11 = manager.ui.mainCamera.transform.position - var_96_5.position

				var_96_5.forward = Vector3.New(var_96_11.x, var_96_11.y, var_96_11.z)

				local var_96_12 = var_96_5.localEulerAngles

				var_96_12.z = 0
				var_96_12.x = 0
				var_96_5.localEulerAngles = var_96_12
			end

			if arg_93_1.time_ >= var_96_6 + var_96_8 and arg_93_1.time_ < var_96_6 + var_96_8 + arg_96_0 then
				var_96_5.localPosition = Vector3.New(0, -1.73, -5.5)

				local var_96_13 = manager.ui.mainCamera.transform.position - var_96_5.position

				var_96_5.forward = Vector3.New(var_96_13.x, var_96_13.y, var_96_13.z)

				local var_96_14 = var_96_5.localEulerAngles

				var_96_14.z = 0
				var_96_14.x = 0
				var_96_5.localEulerAngles = var_96_14

				local var_96_15 = GameObjectTools.GetOrAddComponent(var_96_5.gameObject, typeof(DynamicBoneHelper))

				if var_96_15 then
					var_96_15:EnableDynamicBone(true)
				end
			end

			local var_96_16 = arg_93_1.actors_["10150ui_story"]
			local var_96_17 = 0

			if var_96_17 < arg_93_1.time_ and arg_93_1.time_ <= var_96_17 + arg_96_0 and not isNil(var_96_16) and arg_93_1.var_.characterEffect10150ui_story == nil then
				arg_93_1.var_.characterEffect10150ui_story = var_96_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_18 = 0.200000002980232

			if var_96_17 <= arg_93_1.time_ and arg_93_1.time_ < var_96_17 + var_96_18 and not isNil(var_96_16) then
				local var_96_19 = (arg_93_1.time_ - var_96_17) / var_96_18

				if arg_93_1.var_.characterEffect10150ui_story and not isNil(var_96_16) then
					arg_93_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_17 + var_96_18 and arg_93_1.time_ < var_96_17 + var_96_18 + arg_96_0 and not isNil(var_96_16) and arg_93_1.var_.characterEffect10150ui_story then
				arg_93_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_96_20 = 0

			if var_96_20 < arg_93_1.time_ and arg_93_1.time_ <= var_96_20 + arg_96_0 then
				arg_93_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_1")
			end

			local var_96_21 = 0

			if var_96_21 < arg_93_1.time_ and arg_93_1.time_ <= var_96_21 + arg_96_0 then
				arg_93_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_22 = 0
			local var_96_23 = 0.175

			if var_96_22 < arg_93_1.time_ and arg_93_1.time_ <= var_96_22 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_24 = arg_93_1:FormatText(StoryNameCfg[1361].name)

				arg_93_1.leftNameTxt_.text = var_96_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_25 = arg_93_1:GetWordFromCfg(322042022)
				local var_96_26 = arg_93_1:FormatText(var_96_25.content)

				arg_93_1.text_.text = var_96_26

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_27 = 7
				local var_96_28 = utf8.len(var_96_26)
				local var_96_29 = var_96_27 <= 0 and var_96_23 or var_96_23 * (var_96_28 / var_96_27)

				if var_96_29 > 0 and var_96_23 < var_96_29 then
					arg_93_1.talkMaxDuration = var_96_29

					if var_96_29 + var_96_22 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_29 + var_96_22
					end
				end

				arg_93_1.text_.text = var_96_26
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042022", "story_v_out_322042.awb") ~= 0 then
					local var_96_30 = manager.audio:GetVoiceLength("story_v_out_322042", "322042022", "story_v_out_322042.awb") / 1000

					if var_96_30 + var_96_22 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_30 + var_96_22
					end

					if var_96_25.prefab_name ~= "" and arg_93_1.actors_[var_96_25.prefab_name] ~= nil then
						local var_96_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_25.prefab_name].transform, "story_v_out_322042", "322042022", "story_v_out_322042.awb")

						arg_93_1:RecordAudio("322042022", var_96_31)
						arg_93_1:RecordAudio("322042022", var_96_31)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322042", "322042022", "story_v_out_322042.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322042", "322042022", "story_v_out_322042.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_32 = math.max(var_96_23, arg_93_1.talkMaxDuration)

			if var_96_22 <= arg_93_1.time_ and arg_93_1.time_ < var_96_22 + var_96_32 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_22) / var_96_32

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_22 + var_96_32 and arg_93_1.time_ < var_96_22 + var_96_32 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322042023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322042023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322042024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10150ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10150ui_story = var_100_0.localPosition

				local var_100_2 = GameObjectTools.GetOrAddComponent(var_100_0.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(false)
				end
			end

			local var_100_3 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_3 then
				local var_100_4 = (arg_97_1.time_ - var_100_1) / var_100_3
				local var_100_5 = Vector3.New(0, 100, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10150ui_story, var_100_5, var_100_4)

				local var_100_6 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_6.x, var_100_6.y, var_100_6.z)

				local var_100_7 = var_100_0.localEulerAngles

				var_100_7.z = 0
				var_100_7.x = 0
				var_100_0.localEulerAngles = var_100_7
			end

			if arg_97_1.time_ >= var_100_1 + var_100_3 and arg_97_1.time_ < var_100_1 + var_100_3 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, 100, 0)

				local var_100_8 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_8.x, var_100_8.y, var_100_8.z)

				local var_100_9 = var_100_0.localEulerAngles

				var_100_9.z = 0
				var_100_9.x = 0
				var_100_0.localEulerAngles = var_100_9

				local var_100_10 = GameObjectTools.GetOrAddComponent(var_100_0.gameObject, typeof(DynamicBoneHelper))

				if var_100_10 then
					var_100_10:EnableDynamicBone(true)
				end
			end

			local var_100_11 = 0.200000002980232
			local var_100_12 = 1

			if var_100_11 < arg_97_1.time_ and arg_97_1.time_ <= var_100_11 + arg_100_0 then
				local var_100_13 = "play"
				local var_100_14 = "effect"

				arg_97_1:AudioAction(var_100_13, var_100_14, "se_story_121_04", "se_story_121_04_fireanergy2", "")
			end

			local var_100_15 = 0
			local var_100_16 = 1.675

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_17 = arg_97_1:GetWordFromCfg(322042023)
				local var_100_18 = arg_97_1:FormatText(var_100_17.content)

				arg_97_1.text_.text = var_100_18

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_19 = 67
				local var_100_20 = utf8.len(var_100_18)
				local var_100_21 = var_100_19 <= 0 and var_100_16 or var_100_16 * (var_100_20 / var_100_19)

				if var_100_21 > 0 and var_100_16 < var_100_21 then
					arg_97_1.talkMaxDuration = var_100_21

					if var_100_21 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_21 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_18
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_22 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_22 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_22

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_22 and arg_97_1.time_ < var_100_15 + var_100_22 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322042024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322042024
		arg_101_1.duration_ = 5.77

		local var_101_0 = {
			zh = 5.5,
			ja = 5.766
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
				arg_101_0:Play322042025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1284ui_story"].transform
			local var_104_1 = 2

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1284ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1284ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1284ui_story"]
			local var_104_10 = 2

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1284ui_story == nil then
				arg_101_1.var_.characterEffect1284ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1284ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1284ui_story then
				arg_101_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_104_13 = 2

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_1")
			end

			local var_104_14 = 2

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_104_15 = manager.ui.mainCamera.transform
			local var_104_16 = 0.983333333333333

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				local var_104_17 = arg_101_1.var_.effect2023

				if var_104_17 then
					Object.Destroy(var_104_17)

					arg_101_1.var_.effect2023 = nil
				end
			end

			local var_104_18 = 0

			if var_104_18 < arg_101_1.time_ and arg_101_1.time_ <= var_104_18 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = false

				arg_101_1:SetGaussion(false)
			end

			local var_104_19 = 1

			if var_104_18 <= arg_101_1.time_ and arg_101_1.time_ < var_104_18 + var_104_19 then
				local var_104_20 = (arg_101_1.time_ - var_104_18) / var_104_19
				local var_104_21 = Color.New(0, 0, 0)

				var_104_21.a = Mathf.Lerp(0, 1, var_104_20)
				arg_101_1.mask_.color = var_104_21
			end

			if arg_101_1.time_ >= var_104_18 + var_104_19 and arg_101_1.time_ < var_104_18 + var_104_19 + arg_104_0 then
				local var_104_22 = Color.New(0, 0, 0)

				var_104_22.a = 1
				arg_101_1.mask_.color = var_104_22
			end

			local var_104_23 = 1

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = false

				arg_101_1:SetGaussion(false)
			end

			local var_104_24 = 1

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_24 then
				local var_104_25 = (arg_101_1.time_ - var_104_23) / var_104_24
				local var_104_26 = Color.New(0, 0, 0)

				var_104_26.a = Mathf.Lerp(1, 0, var_104_25)
				arg_101_1.mask_.color = var_104_26
			end

			if arg_101_1.time_ >= var_104_23 + var_104_24 and arg_101_1.time_ < var_104_23 + var_104_24 + arg_104_0 then
				local var_104_27 = Color.New(0, 0, 0)
				local var_104_28 = 0

				arg_101_1.mask_.enabled = false
				var_104_27.a = var_104_28
				arg_101_1.mask_.color = var_104_27
			end

			local var_104_29 = 1.38777878078145e-17
			local var_104_30 = 1

			if var_104_29 < arg_101_1.time_ and arg_101_1.time_ <= var_104_29 + arg_104_0 then
				local var_104_31 = "stop"
				local var_104_32 = "effect"

				arg_101_1:AudioAction(var_104_31, var_104_32, "se_story_145", "se_story_145_fire04_loop", "")
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_33 = 2
			local var_104_34 = 0.475

			if var_104_33 < arg_101_1.time_ and arg_101_1.time_ <= var_104_33 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_35 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_35:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_36 = arg_101_1:FormatText(StoryNameCfg[6].name)

				arg_101_1.leftNameTxt_.text = var_104_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_37 = arg_101_1:GetWordFromCfg(322042024)
				local var_104_38 = arg_101_1:FormatText(var_104_37.content)

				arg_101_1.text_.text = var_104_38

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_39 = 19
				local var_104_40 = utf8.len(var_104_38)
				local var_104_41 = var_104_39 <= 0 and var_104_34 or var_104_34 * (var_104_40 / var_104_39)

				if var_104_41 > 0 and var_104_34 < var_104_41 then
					arg_101_1.talkMaxDuration = var_104_41
					var_104_33 = var_104_33 + 0.3

					if var_104_41 + var_104_33 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_41 + var_104_33
					end
				end

				arg_101_1.text_.text = var_104_38
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042024", "story_v_out_322042.awb") ~= 0 then
					local var_104_42 = manager.audio:GetVoiceLength("story_v_out_322042", "322042024", "story_v_out_322042.awb") / 1000

					if var_104_42 + var_104_33 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_42 + var_104_33
					end

					if var_104_37.prefab_name ~= "" and arg_101_1.actors_[var_104_37.prefab_name] ~= nil then
						local var_104_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_37.prefab_name].transform, "story_v_out_322042", "322042024", "story_v_out_322042.awb")

						arg_101_1:RecordAudio("322042024", var_104_43)
						arg_101_1:RecordAudio("322042024", var_104_43)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322042", "322042024", "story_v_out_322042.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322042", "322042024", "story_v_out_322042.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_44 = var_104_33 + 0.3
			local var_104_45 = math.max(var_104_34, arg_101_1.talkMaxDuration)

			if var_104_44 <= arg_101_1.time_ and arg_101_1.time_ < var_104_44 + var_104_45 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_44) / var_104_45

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_44 + var_104_45 and arg_101_1.time_ < var_104_44 + var_104_45 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play322042025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 322042025
		arg_107_1.duration_ = 3.07

		local var_107_0 = {
			zh = 2.5,
			ja = 3.066
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
				arg_107_0:Play322042026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10150ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10150ui_story = var_110_0.localPosition

				local var_110_2 = GameObjectTools.GetOrAddComponent(var_110_0.gameObject, typeof(DynamicBoneHelper))

				if var_110_2 then
					var_110_2:EnableDynamicBone(false)
				end
			end

			local var_110_3 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_3 then
				local var_110_4 = (arg_107_1.time_ - var_110_1) / var_110_3
				local var_110_5 = Vector3.New(0.9, -1.73, -5.5)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10150ui_story, var_110_5, var_110_4)

				local var_110_6 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_6.x, var_110_6.y, var_110_6.z)

				local var_110_7 = var_110_0.localEulerAngles

				var_110_7.z = 0
				var_110_7.x = 0
				var_110_0.localEulerAngles = var_110_7
			end

			if arg_107_1.time_ >= var_110_1 + var_110_3 and arg_107_1.time_ < var_110_1 + var_110_3 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0.9, -1.73, -5.5)

				local var_110_8 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_8.x, var_110_8.y, var_110_8.z)

				local var_110_9 = var_110_0.localEulerAngles

				var_110_9.z = 0
				var_110_9.x = 0
				var_110_0.localEulerAngles = var_110_9

				local var_110_10 = GameObjectTools.GetOrAddComponent(var_110_0.gameObject, typeof(DynamicBoneHelper))

				if var_110_10 then
					var_110_10:EnableDynamicBone(true)
				end
			end

			local var_110_11 = arg_107_1.actors_["10150ui_story"]
			local var_110_12 = 0

			if var_110_12 < arg_107_1.time_ and arg_107_1.time_ <= var_110_12 + arg_110_0 and not isNil(var_110_11) and arg_107_1.var_.characterEffect10150ui_story == nil then
				arg_107_1.var_.characterEffect10150ui_story = var_110_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_13 = 0.200000002980232

			if var_110_12 <= arg_107_1.time_ and arg_107_1.time_ < var_110_12 + var_110_13 and not isNil(var_110_11) then
				local var_110_14 = (arg_107_1.time_ - var_110_12) / var_110_13

				if arg_107_1.var_.characterEffect10150ui_story and not isNil(var_110_11) then
					arg_107_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_12 + var_110_13 and arg_107_1.time_ < var_110_12 + var_110_13 + arg_110_0 and not isNil(var_110_11) and arg_107_1.var_.characterEffect10150ui_story then
				arg_107_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_110_15 = arg_107_1.actors_["1284ui_story"]
			local var_110_16 = 0

			if var_110_16 < arg_107_1.time_ and arg_107_1.time_ <= var_110_16 + arg_110_0 and not isNil(var_110_15) and arg_107_1.var_.characterEffect1284ui_story == nil then
				arg_107_1.var_.characterEffect1284ui_story = var_110_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_17 = 0.200000002980232

			if var_110_16 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_17 and not isNil(var_110_15) then
				local var_110_18 = (arg_107_1.time_ - var_110_16) / var_110_17

				if arg_107_1.var_.characterEffect1284ui_story and not isNil(var_110_15) then
					local var_110_19 = Mathf.Lerp(0, 0.5, var_110_18)

					arg_107_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1284ui_story.fillRatio = var_110_19
				end
			end

			if arg_107_1.time_ >= var_110_16 + var_110_17 and arg_107_1.time_ < var_110_16 + var_110_17 + arg_110_0 and not isNil(var_110_15) and arg_107_1.var_.characterEffect1284ui_story then
				local var_110_20 = 0.5

				arg_107_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1284ui_story.fillRatio = var_110_20
			end

			local var_110_21 = 0

			if var_110_21 < arg_107_1.time_ and arg_107_1.time_ <= var_110_21 + arg_110_0 then
				arg_107_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_2")
			end

			local var_110_22 = 0

			if var_110_22 < arg_107_1.time_ and arg_107_1.time_ <= var_110_22 + arg_110_0 then
				arg_107_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_110_23 = 0
			local var_110_24 = 0.125

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_25 = arg_107_1:FormatText(StoryNameCfg[1361].name)

				arg_107_1.leftNameTxt_.text = var_110_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_26 = arg_107_1:GetWordFromCfg(322042025)
				local var_110_27 = arg_107_1:FormatText(var_110_26.content)

				arg_107_1.text_.text = var_110_27

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_28 = 5
				local var_110_29 = utf8.len(var_110_27)
				local var_110_30 = var_110_28 <= 0 and var_110_24 or var_110_24 * (var_110_29 / var_110_28)

				if var_110_30 > 0 and var_110_24 < var_110_30 then
					arg_107_1.talkMaxDuration = var_110_30

					if var_110_30 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_30 + var_110_23
					end
				end

				arg_107_1.text_.text = var_110_27
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042025", "story_v_out_322042.awb") ~= 0 then
					local var_110_31 = manager.audio:GetVoiceLength("story_v_out_322042", "322042025", "story_v_out_322042.awb") / 1000

					if var_110_31 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_31 + var_110_23
					end

					if var_110_26.prefab_name ~= "" and arg_107_1.actors_[var_110_26.prefab_name] ~= nil then
						local var_110_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_26.prefab_name].transform, "story_v_out_322042", "322042025", "story_v_out_322042.awb")

						arg_107_1:RecordAudio("322042025", var_110_32)
						arg_107_1:RecordAudio("322042025", var_110_32)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_322042", "322042025", "story_v_out_322042.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_322042", "322042025", "story_v_out_322042.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_33 = math.max(var_110_24, arg_107_1.talkMaxDuration)

			if var_110_23 <= arg_107_1.time_ and arg_107_1.time_ < var_110_23 + var_110_33 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_23) / var_110_33

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_23 + var_110_33 and arg_107_1.time_ < var_110_23 + var_110_33 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play322042026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 322042026
		arg_111_1.duration_ = 4.73

		local var_111_0 = {
			zh = 2.7,
			ja = 4.733
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
				arg_111_0:Play322042027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1284ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1284ui_story == nil then
				arg_111_1.var_.characterEffect1284ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1284ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1284ui_story then
				arg_111_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_114_4 = arg_111_1.actors_["10150ui_story"]
			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect10150ui_story == nil then
				arg_111_1.var_.characterEffect10150ui_story = var_114_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_6 = 0.200000002980232

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_6 and not isNil(var_114_4) then
				local var_114_7 = (arg_111_1.time_ - var_114_5) / var_114_6

				if arg_111_1.var_.characterEffect10150ui_story and not isNil(var_114_4) then
					local var_114_8 = Mathf.Lerp(0, 0.5, var_114_7)

					arg_111_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10150ui_story.fillRatio = var_114_8
				end
			end

			if arg_111_1.time_ >= var_114_5 + var_114_6 and arg_111_1.time_ < var_114_5 + var_114_6 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect10150ui_story then
				local var_114_9 = 0.5

				arg_111_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10150ui_story.fillRatio = var_114_9
			end

			local var_114_10 = 0
			local var_114_11 = 0.3

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_12 = arg_111_1:FormatText(StoryNameCfg[6].name)

				arg_111_1.leftNameTxt_.text = var_114_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_13 = arg_111_1:GetWordFromCfg(322042026)
				local var_114_14 = arg_111_1:FormatText(var_114_13.content)

				arg_111_1.text_.text = var_114_14

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_15 = 12
				local var_114_16 = utf8.len(var_114_14)
				local var_114_17 = var_114_15 <= 0 and var_114_11 or var_114_11 * (var_114_16 / var_114_15)

				if var_114_17 > 0 and var_114_11 < var_114_17 then
					arg_111_1.talkMaxDuration = var_114_17

					if var_114_17 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_17 + var_114_10
					end
				end

				arg_111_1.text_.text = var_114_14
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042026", "story_v_out_322042.awb") ~= 0 then
					local var_114_18 = manager.audio:GetVoiceLength("story_v_out_322042", "322042026", "story_v_out_322042.awb") / 1000

					if var_114_18 + var_114_10 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_18 + var_114_10
					end

					if var_114_13.prefab_name ~= "" and arg_111_1.actors_[var_114_13.prefab_name] ~= nil then
						local var_114_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_13.prefab_name].transform, "story_v_out_322042", "322042026", "story_v_out_322042.awb")

						arg_111_1:RecordAudio("322042026", var_114_19)
						arg_111_1:RecordAudio("322042026", var_114_19)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_322042", "322042026", "story_v_out_322042.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_322042", "322042026", "story_v_out_322042.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_20 = math.max(var_114_11, arg_111_1.talkMaxDuration)

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_20 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_10) / var_114_20

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_10 + var_114_20 and arg_111_1.time_ < var_114_10 + var_114_20 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play322042027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 322042027
		arg_115_1.duration_ = 4.27

		local var_115_0 = {
			zh = 3.666,
			ja = 4.266
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
				arg_115_0:Play322042028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10150ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect10150ui_story == nil then
				arg_115_1.var_.characterEffect10150ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect10150ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect10150ui_story then
				arg_115_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_118_4 = arg_115_1.actors_["1284ui_story"]
			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 and not isNil(var_118_4) and arg_115_1.var_.characterEffect1284ui_story == nil then
				arg_115_1.var_.characterEffect1284ui_story = var_118_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_6 = 0.200000002980232

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_6 and not isNil(var_118_4) then
				local var_118_7 = (arg_115_1.time_ - var_118_5) / var_118_6

				if arg_115_1.var_.characterEffect1284ui_story and not isNil(var_118_4) then
					local var_118_8 = Mathf.Lerp(0, 0.5, var_118_7)

					arg_115_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1284ui_story.fillRatio = var_118_8
				end
			end

			if arg_115_1.time_ >= var_118_5 + var_118_6 and arg_115_1.time_ < var_118_5 + var_118_6 + arg_118_0 and not isNil(var_118_4) and arg_115_1.var_.characterEffect1284ui_story then
				local var_118_9 = 0.5

				arg_115_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1284ui_story.fillRatio = var_118_9
			end

			local var_118_10 = 0
			local var_118_11 = 0.325

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_12 = arg_115_1:FormatText(StoryNameCfg[1361].name)

				arg_115_1.leftNameTxt_.text = var_118_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_13 = arg_115_1:GetWordFromCfg(322042027)
				local var_118_14 = arg_115_1:FormatText(var_118_13.content)

				arg_115_1.text_.text = var_118_14

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_15 = 13
				local var_118_16 = utf8.len(var_118_14)
				local var_118_17 = var_118_15 <= 0 and var_118_11 or var_118_11 * (var_118_16 / var_118_15)

				if var_118_17 > 0 and var_118_11 < var_118_17 then
					arg_115_1.talkMaxDuration = var_118_17

					if var_118_17 + var_118_10 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_17 + var_118_10
					end
				end

				arg_115_1.text_.text = var_118_14
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042027", "story_v_out_322042.awb") ~= 0 then
					local var_118_18 = manager.audio:GetVoiceLength("story_v_out_322042", "322042027", "story_v_out_322042.awb") / 1000

					if var_118_18 + var_118_10 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_18 + var_118_10
					end

					if var_118_13.prefab_name ~= "" and arg_115_1.actors_[var_118_13.prefab_name] ~= nil then
						local var_118_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_13.prefab_name].transform, "story_v_out_322042", "322042027", "story_v_out_322042.awb")

						arg_115_1:RecordAudio("322042027", var_118_19)
						arg_115_1:RecordAudio("322042027", var_118_19)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_322042", "322042027", "story_v_out_322042.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_322042", "322042027", "story_v_out_322042.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_20 = math.max(var_118_11, arg_115_1.talkMaxDuration)

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_20 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_10) / var_118_20

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_10 + var_118_20 and arg_115_1.time_ < var_118_10 + var_118_20 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play322042028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322042028
		arg_119_1.duration_ = 3.87

		local var_119_0 = {
			zh = 3,
			ja = 3.866
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
				arg_119_0:Play322042029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1156ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1156ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0.9, -1.1, -6.18)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1156ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["10150ui_story"].transform
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1.var_.moveOldPos10150ui_story = var_122_9.localPosition

				local var_122_11 = GameObjectTools.GetOrAddComponent(var_122_9.gameObject, typeof(DynamicBoneHelper))

				if var_122_11 then
					var_122_11:EnableDynamicBone(false)
				end
			end

			local var_122_12 = 0.001

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_12 then
				local var_122_13 = (arg_119_1.time_ - var_122_10) / var_122_12
				local var_122_14 = Vector3.New(0, 100, 0)

				var_122_9.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10150ui_story, var_122_14, var_122_13)

				local var_122_15 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_15.x, var_122_15.y, var_122_15.z)

				local var_122_16 = var_122_9.localEulerAngles

				var_122_16.z = 0
				var_122_16.x = 0
				var_122_9.localEulerAngles = var_122_16
			end

			if arg_119_1.time_ >= var_122_10 + var_122_12 and arg_119_1.time_ < var_122_10 + var_122_12 + arg_122_0 then
				var_122_9.localPosition = Vector3.New(0, 100, 0)

				local var_122_17 = manager.ui.mainCamera.transform.position - var_122_9.position

				var_122_9.forward = Vector3.New(var_122_17.x, var_122_17.y, var_122_17.z)

				local var_122_18 = var_122_9.localEulerAngles

				var_122_18.z = 0
				var_122_18.x = 0
				var_122_9.localEulerAngles = var_122_18

				local var_122_19 = GameObjectTools.GetOrAddComponent(var_122_9.gameObject, typeof(DynamicBoneHelper))

				if var_122_19 then
					var_122_19:EnableDynamicBone(true)
				end
			end

			local var_122_20 = arg_119_1.actors_["1156ui_story"]
			local var_122_21 = 0

			if var_122_21 < arg_119_1.time_ and arg_119_1.time_ <= var_122_21 + arg_122_0 and not isNil(var_122_20) and arg_119_1.var_.characterEffect1156ui_story == nil then
				arg_119_1.var_.characterEffect1156ui_story = var_122_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_22 = 0.200000002980232

			if var_122_21 <= arg_119_1.time_ and arg_119_1.time_ < var_122_21 + var_122_22 and not isNil(var_122_20) then
				local var_122_23 = (arg_119_1.time_ - var_122_21) / var_122_22

				if arg_119_1.var_.characterEffect1156ui_story and not isNil(var_122_20) then
					arg_119_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_21 + var_122_22 and arg_119_1.time_ < var_122_21 + var_122_22 + arg_122_0 and not isNil(var_122_20) and arg_119_1.var_.characterEffect1156ui_story then
				arg_119_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_122_24 = arg_119_1.actors_["10150ui_story"]
			local var_122_25 = 0

			if var_122_25 < arg_119_1.time_ and arg_119_1.time_ <= var_122_25 + arg_122_0 and not isNil(var_122_24) and arg_119_1.var_.characterEffect10150ui_story == nil then
				arg_119_1.var_.characterEffect10150ui_story = var_122_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_26 = 0.200000002980232

			if var_122_25 <= arg_119_1.time_ and arg_119_1.time_ < var_122_25 + var_122_26 and not isNil(var_122_24) then
				local var_122_27 = (arg_119_1.time_ - var_122_25) / var_122_26

				if arg_119_1.var_.characterEffect10150ui_story and not isNil(var_122_24) then
					local var_122_28 = Mathf.Lerp(0, 0.5, var_122_27)

					arg_119_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10150ui_story.fillRatio = var_122_28
				end
			end

			if arg_119_1.time_ >= var_122_25 + var_122_26 and arg_119_1.time_ < var_122_25 + var_122_26 + arg_122_0 and not isNil(var_122_24) and arg_119_1.var_.characterEffect10150ui_story then
				local var_122_29 = 0.5

				arg_119_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10150ui_story.fillRatio = var_122_29
			end

			local var_122_30 = 0

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				arg_119_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_122_31 = 0

			if var_122_31 < arg_119_1.time_ and arg_119_1.time_ <= var_122_31 + arg_122_0 then
				arg_119_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_122_32 = 0
			local var_122_33 = 0.325

			if var_122_32 < arg_119_1.time_ and arg_119_1.time_ <= var_122_32 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_34 = arg_119_1:FormatText(StoryNameCfg[605].name)

				arg_119_1.leftNameTxt_.text = var_122_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_35 = arg_119_1:GetWordFromCfg(322042028)
				local var_122_36 = arg_119_1:FormatText(var_122_35.content)

				arg_119_1.text_.text = var_122_36

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_37 = 13
				local var_122_38 = utf8.len(var_122_36)
				local var_122_39 = var_122_37 <= 0 and var_122_33 or var_122_33 * (var_122_38 / var_122_37)

				if var_122_39 > 0 and var_122_33 < var_122_39 then
					arg_119_1.talkMaxDuration = var_122_39

					if var_122_39 + var_122_32 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_39 + var_122_32
					end
				end

				arg_119_1.text_.text = var_122_36
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042028", "story_v_out_322042.awb") ~= 0 then
					local var_122_40 = manager.audio:GetVoiceLength("story_v_out_322042", "322042028", "story_v_out_322042.awb") / 1000

					if var_122_40 + var_122_32 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_40 + var_122_32
					end

					if var_122_35.prefab_name ~= "" and arg_119_1.actors_[var_122_35.prefab_name] ~= nil then
						local var_122_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_35.prefab_name].transform, "story_v_out_322042", "322042028", "story_v_out_322042.awb")

						arg_119_1:RecordAudio("322042028", var_122_41)
						arg_119_1:RecordAudio("322042028", var_122_41)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_322042", "322042028", "story_v_out_322042.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_322042", "322042028", "story_v_out_322042.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_42 = math.max(var_122_33, arg_119_1.talkMaxDuration)

			if var_122_32 <= arg_119_1.time_ and arg_119_1.time_ < var_122_32 + var_122_42 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_32) / var_122_42

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_32 + var_122_42 and arg_119_1.time_ < var_122_32 + var_122_42 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play322042029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322042029
		arg_123_1.duration_ = 9.87

		local var_123_0 = {
			zh = 9.7,
			ja = 9.866
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
				arg_123_0:Play322042030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1284ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1284ui_story == nil then
				arg_123_1.var_.characterEffect1284ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1284ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1284ui_story then
				arg_123_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_126_4 = arg_123_1.actors_["1156ui_story"]
			local var_126_5 = 0

			if var_126_5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect1156ui_story == nil then
				arg_123_1.var_.characterEffect1156ui_story = var_126_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.200000002980232

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 and not isNil(var_126_4) then
				local var_126_7 = (arg_123_1.time_ - var_126_5) / var_126_6

				if arg_123_1.var_.characterEffect1156ui_story and not isNil(var_126_4) then
					local var_126_8 = Mathf.Lerp(0, 0.5, var_126_7)

					arg_123_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1156ui_story.fillRatio = var_126_8
				end
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect1156ui_story then
				local var_126_9 = 0.5

				arg_123_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1156ui_story.fillRatio = var_126_9
			end

			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_2")
			end

			local var_126_11 = 0

			if var_126_11 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_12 = 0
			local var_126_13 = 1.275

			if var_126_12 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_14 = arg_123_1:FormatText(StoryNameCfg[6].name)

				arg_123_1.leftNameTxt_.text = var_126_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_15 = arg_123_1:GetWordFromCfg(322042029)
				local var_126_16 = arg_123_1:FormatText(var_126_15.content)

				arg_123_1.text_.text = var_126_16

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_17 = 51
				local var_126_18 = utf8.len(var_126_16)
				local var_126_19 = var_126_17 <= 0 and var_126_13 or var_126_13 * (var_126_18 / var_126_17)

				if var_126_19 > 0 and var_126_13 < var_126_19 then
					arg_123_1.talkMaxDuration = var_126_19

					if var_126_19 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_19 + var_126_12
					end
				end

				arg_123_1.text_.text = var_126_16
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042029", "story_v_out_322042.awb") ~= 0 then
					local var_126_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042029", "story_v_out_322042.awb") / 1000

					if var_126_20 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_20 + var_126_12
					end

					if var_126_15.prefab_name ~= "" and arg_123_1.actors_[var_126_15.prefab_name] ~= nil then
						local var_126_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_15.prefab_name].transform, "story_v_out_322042", "322042029", "story_v_out_322042.awb")

						arg_123_1:RecordAudio("322042029", var_126_21)
						arg_123_1:RecordAudio("322042029", var_126_21)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_322042", "322042029", "story_v_out_322042.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_322042", "322042029", "story_v_out_322042.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_22 = math.max(var_126_13, arg_123_1.talkMaxDuration)

			if var_126_12 <= arg_123_1.time_ and arg_123_1.time_ < var_126_12 + var_126_22 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_12) / var_126_22

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_12 + var_126_22 and arg_123_1.time_ < var_126_12 + var_126_22 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play322042030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322042030
		arg_127_1.duration_ = 5.37

		local var_127_0 = {
			zh = 3.4,
			ja = 5.366
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
				arg_127_0:Play322042031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1156ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1156ui_story == nil then
				arg_127_1.var_.characterEffect1156ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1156ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1156ui_story then
				arg_127_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_130_4 = arg_127_1.actors_["1284ui_story"]
			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect1284ui_story == nil then
				arg_127_1.var_.characterEffect1284ui_story = var_130_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_6 = 0.200000002980232

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 and not isNil(var_130_4) then
				local var_130_7 = (arg_127_1.time_ - var_130_5) / var_130_6

				if arg_127_1.var_.characterEffect1284ui_story and not isNil(var_130_4) then
					local var_130_8 = Mathf.Lerp(0, 0.5, var_130_7)

					arg_127_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1284ui_story.fillRatio = var_130_8
				end
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect1284ui_story then
				local var_130_9 = 0.5

				arg_127_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1284ui_story.fillRatio = var_130_9
			end

			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			local var_130_11 = 0
			local var_130_12 = 0.475

			if var_130_11 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_13 = arg_127_1:FormatText(StoryNameCfg[605].name)

				arg_127_1.leftNameTxt_.text = var_130_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_14 = arg_127_1:GetWordFromCfg(322042030)
				local var_130_15 = arg_127_1:FormatText(var_130_14.content)

				arg_127_1.text_.text = var_130_15

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_16 = 19
				local var_130_17 = utf8.len(var_130_15)
				local var_130_18 = var_130_16 <= 0 and var_130_12 or var_130_12 * (var_130_17 / var_130_16)

				if var_130_18 > 0 and var_130_12 < var_130_18 then
					arg_127_1.talkMaxDuration = var_130_18

					if var_130_18 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_11
					end
				end

				arg_127_1.text_.text = var_130_15
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042030", "story_v_out_322042.awb") ~= 0 then
					local var_130_19 = manager.audio:GetVoiceLength("story_v_out_322042", "322042030", "story_v_out_322042.awb") / 1000

					if var_130_19 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_11
					end

					if var_130_14.prefab_name ~= "" and arg_127_1.actors_[var_130_14.prefab_name] ~= nil then
						local var_130_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_14.prefab_name].transform, "story_v_out_322042", "322042030", "story_v_out_322042.awb")

						arg_127_1:RecordAudio("322042030", var_130_20)
						arg_127_1:RecordAudio("322042030", var_130_20)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_322042", "322042030", "story_v_out_322042.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_322042", "322042030", "story_v_out_322042.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_21 = math.max(var_130_12, arg_127_1.talkMaxDuration)

			if var_130_11 <= arg_127_1.time_ and arg_127_1.time_ < var_130_11 + var_130_21 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_11) / var_130_21

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_11 + var_130_21 and arg_127_1.time_ < var_130_11 + var_130_21 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play322042031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322042031
		arg_131_1.duration_ = 4.67

		local var_131_0 = {
			zh = 3.766,
			ja = 4.666
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
				arg_131_0:Play322042032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1156ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1156ui_story == nil then
				arg_131_1.var_.characterEffect1156ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect1156ui_story and not isNil(var_134_0) then
					local var_134_4 = Mathf.Lerp(0, 0.5, var_134_3)

					arg_131_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1156ui_story.fillRatio = var_134_4
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect1156ui_story then
				local var_134_5 = 0.5

				arg_131_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1156ui_story.fillRatio = var_134_5
			end

			local var_134_6 = 0
			local var_134_7 = 0.5

			if var_134_6 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_8 = arg_131_1:FormatText(StoryNameCfg[668].name)

				arg_131_1.leftNameTxt_.text = var_134_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_131_1.callingController_:SetSelectedState("calling")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_9 = arg_131_1:GetWordFromCfg(322042031)
				local var_134_10 = arg_131_1:FormatText(var_134_9.content)

				arg_131_1.text_.text = var_134_10

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042031", "story_v_out_322042.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_322042", "322042031", "story_v_out_322042.awb") / 1000

					if var_134_14 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_6
					end

					if var_134_9.prefab_name ~= "" and arg_131_1.actors_[var_134_9.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_9.prefab_name].transform, "story_v_out_322042", "322042031", "story_v_out_322042.awb")

						arg_131_1:RecordAudio("322042031", var_134_15)
						arg_131_1:RecordAudio("322042031", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_322042", "322042031", "story_v_out_322042.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_322042", "322042031", "story_v_out_322042.awb")
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
	Play322042032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322042032
		arg_135_1.duration_ = 1.4

		local var_135_0 = {
			zh = 0.999999999999,
			ja = 1.4
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
				arg_135_0:Play322042033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1284ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1284ui_story == nil then
				arg_135_1.var_.characterEffect1284ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1284ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1284ui_story then
				arg_135_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_138_4 = 0
			local var_138_5 = 0.075

			if var_138_4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_6 = arg_135_1:FormatText(StoryNameCfg[6].name)

				arg_135_1.leftNameTxt_.text = var_138_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_7 = arg_135_1:GetWordFromCfg(322042032)
				local var_138_8 = arg_135_1:FormatText(var_138_7.content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 3
				local var_138_10 = utf8.len(var_138_8)
				local var_138_11 = var_138_9 <= 0 and var_138_5 or var_138_5 * (var_138_10 / var_138_9)

				if var_138_11 > 0 and var_138_5 < var_138_11 then
					arg_135_1.talkMaxDuration = var_138_11

					if var_138_11 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042032", "story_v_out_322042.awb") ~= 0 then
					local var_138_12 = manager.audio:GetVoiceLength("story_v_out_322042", "322042032", "story_v_out_322042.awb") / 1000

					if var_138_12 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_4
					end

					if var_138_7.prefab_name ~= "" and arg_135_1.actors_[var_138_7.prefab_name] ~= nil then
						local var_138_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_7.prefab_name].transform, "story_v_out_322042", "322042032", "story_v_out_322042.awb")

						arg_135_1:RecordAudio("322042032", var_138_13)
						arg_135_1:RecordAudio("322042032", var_138_13)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_322042", "322042032", "story_v_out_322042.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_322042", "322042032", "story_v_out_322042.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_14 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_14 and arg_135_1.time_ < var_138_4 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play322042033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322042033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play322042034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1284ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1284ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, 100, 0)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1284ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, 100, 0)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1156ui_story"].transform
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1.var_.moveOldPos1156ui_story = var_142_9.localPosition
			end

			local var_142_11 = 0.001

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11
				local var_142_13 = Vector3.New(0, 100, 0)

				var_142_9.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1156ui_story, var_142_13, var_142_12)

				local var_142_14 = manager.ui.mainCamera.transform.position - var_142_9.position

				var_142_9.forward = Vector3.New(var_142_14.x, var_142_14.y, var_142_14.z)

				local var_142_15 = var_142_9.localEulerAngles

				var_142_15.z = 0
				var_142_15.x = 0
				var_142_9.localEulerAngles = var_142_15
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 then
				var_142_9.localPosition = Vector3.New(0, 100, 0)

				local var_142_16 = manager.ui.mainCamera.transform.position - var_142_9.position

				var_142_9.forward = Vector3.New(var_142_16.x, var_142_16.y, var_142_16.z)

				local var_142_17 = var_142_9.localEulerAngles

				var_142_17.z = 0
				var_142_17.x = 0
				var_142_9.localEulerAngles = var_142_17
			end

			local var_142_18 = 0
			local var_142_19 = 1.275

			if var_142_18 < arg_139_1.time_ and arg_139_1.time_ <= var_142_18 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_20 = arg_139_1:GetWordFromCfg(322042033)
				local var_142_21 = arg_139_1:FormatText(var_142_20.content)

				arg_139_1.text_.text = var_142_21

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_22 = 51
				local var_142_23 = utf8.len(var_142_21)
				local var_142_24 = var_142_22 <= 0 and var_142_19 or var_142_19 * (var_142_23 / var_142_22)

				if var_142_24 > 0 and var_142_19 < var_142_24 then
					arg_139_1.talkMaxDuration = var_142_24

					if var_142_24 + var_142_18 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_24 + var_142_18
					end
				end

				arg_139_1.text_.text = var_142_21
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = math.max(var_142_19, arg_139_1.talkMaxDuration)

			if var_142_18 <= arg_139_1.time_ and arg_139_1.time_ < var_142_18 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_18) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_18 + var_142_25 and arg_139_1.time_ < var_142_18 + var_142_25 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
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
	Play322042034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322042034
		arg_143_1.duration_ = 5.36

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play322042035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.1
			local var_146_1 = 1

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				local var_146_2 = "play"
				local var_146_3 = "effect"

				arg_143_1:AudioAction(var_146_2, var_146_3, "se_story_1310", "se_story_1310_rush", "")
			end

			local var_146_4 = 1.83333333333333
			local var_146_5 = 1

			if var_146_4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				local var_146_6 = "play"
				local var_146_7 = "effect"

				arg_143_1:AudioAction(var_146_6, var_146_7, "se_story_145", "se_story_145_explosion02", "")
			end

			local var_146_8 = manager.ui.mainCamera.transform
			local var_146_9 = 0

			if var_146_9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				local var_146_10 = arg_143_1.var_.effect2034
				local var_146_11
				local var_146_12 = var_146_8

				if not var_146_10 then
					var_146_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_146_12)
					var_146_10.name = "2034"
					arg_143_1.var_.effect2034 = var_146_10
				else
					var_146_10.transform:SetParent(var_146_12)
				end

				var_146_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_146_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_146_13 = manager.ui.mainCamera.transform
			local var_146_14 = 0

			if var_146_14 < arg_143_1.time_ and arg_143_1.time_ <= var_146_14 + arg_146_0 then
				arg_143_1.var_.shakeOldPos = var_146_13.localPosition
			end

			local var_146_15 = 0.533333333333333

			if var_146_14 <= arg_143_1.time_ and arg_143_1.time_ < var_146_14 + var_146_15 then
				local var_146_16 = (arg_143_1.time_ - var_146_14) / 0.066
				local var_146_17, var_146_18 = math.modf(var_146_16)

				var_146_13.localPosition = Vector3.New(var_146_18 * 0.13, var_146_18 * 0.13, var_146_18 * 0.13) + arg_143_1.var_.shakeOldPos
			end

			if arg_143_1.time_ >= var_146_14 + var_146_15 and arg_143_1.time_ < var_146_14 + var_146_15 + arg_146_0 then
				var_146_13.localPosition = arg_143_1.var_.shakeOldPos
			end

			local var_146_19 = manager.ui.mainCamera.transform
			local var_146_20 = 1.83333333333333

			if var_146_20 < arg_143_1.time_ and arg_143_1.time_ <= var_146_20 + arg_146_0 then
				local var_146_21 = arg_143_1.var_.effect20342
				local var_146_22
				local var_146_23 = var_146_19

				if not var_146_21 then
					var_146_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_146_23)
					var_146_21.name = "20342"
					arg_143_1.var_.effect20342 = var_146_21
				else
					var_146_21.transform:SetParent(var_146_23)
				end

				var_146_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_146_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_146_24 = 0.1
			local var_146_25 = 1

			if var_146_24 < arg_143_1.time_ and arg_143_1.time_ <= var_146_24 + arg_146_0 then
				local var_146_26 = "play"
				local var_146_27 = "effect"

				arg_143_1:AudioAction(var_146_26, var_146_27, "se_story_10", "se_story_10_sword02", "")
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_28 = 0.358333333333333
			local var_146_29 = 1.475

			if var_146_28 < arg_143_1.time_ and arg_143_1.time_ <= var_146_28 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_30 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_30:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_31 = arg_143_1:GetWordFromCfg(322042034)
				local var_146_32 = arg_143_1:FormatText(var_146_31.content)

				arg_143_1.text_.text = var_146_32

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_33 = 59
				local var_146_34 = utf8.len(var_146_32)
				local var_146_35 = var_146_33 <= 0 and var_146_29 or var_146_29 * (var_146_34 / var_146_33)

				if var_146_35 > 0 and var_146_29 < var_146_35 then
					arg_143_1.talkMaxDuration = var_146_35
					var_146_28 = var_146_28 + 0.3

					if var_146_35 + var_146_28 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_35 + var_146_28
					end
				end

				arg_143_1.text_.text = var_146_32
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_36 = var_146_28 + 0.3
			local var_146_37 = math.max(var_146_29, arg_143_1.talkMaxDuration)

			if var_146_36 <= arg_143_1.time_ and arg_143_1.time_ < var_146_36 + var_146_37 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_36) / var_146_37

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_36 + var_146_37 and arg_143_1.time_ < var_146_36 + var_146_37 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play322042035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322042035
		arg_149_1.duration_ = 2.13

		local var_149_0 = {
			zh = 2.133,
			ja = 1.466
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
				arg_149_0:Play322042036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10150ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10150ui_story = var_152_0.localPosition

				local var_152_2 = GameObjectTools.GetOrAddComponent(var_152_0.gameObject, typeof(DynamicBoneHelper))

				if var_152_2 then
					var_152_2:EnableDynamicBone(false)
				end
			end

			local var_152_3 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_3 then
				local var_152_4 = (arg_149_1.time_ - var_152_1) / var_152_3
				local var_152_5 = Vector3.New(0, -1.73, -5.5)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10150ui_story, var_152_5, var_152_4)

				local var_152_6 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_6.x, var_152_6.y, var_152_6.z)

				local var_152_7 = var_152_0.localEulerAngles

				var_152_7.z = 0
				var_152_7.x = 0
				var_152_0.localEulerAngles = var_152_7
			end

			if arg_149_1.time_ >= var_152_1 + var_152_3 and arg_149_1.time_ < var_152_1 + var_152_3 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -1.73, -5.5)

				local var_152_8 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_8.x, var_152_8.y, var_152_8.z)

				local var_152_9 = var_152_0.localEulerAngles

				var_152_9.z = 0
				var_152_9.x = 0
				var_152_0.localEulerAngles = var_152_9

				local var_152_10 = GameObjectTools.GetOrAddComponent(var_152_0.gameObject, typeof(DynamicBoneHelper))

				if var_152_10 then
					var_152_10:EnableDynamicBone(true)
				end
			end

			local var_152_11 = arg_149_1.actors_["10150ui_story"]
			local var_152_12 = 0

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 and not isNil(var_152_11) and arg_149_1.var_.characterEffect10150ui_story == nil then
				arg_149_1.var_.characterEffect10150ui_story = var_152_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_13 = 0.200000002980232

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_13 and not isNil(var_152_11) then
				local var_152_14 = (arg_149_1.time_ - var_152_12) / var_152_13

				if arg_149_1.var_.characterEffect10150ui_story and not isNil(var_152_11) then
					arg_149_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_12 + var_152_13 and arg_149_1.time_ < var_152_12 + var_152_13 + arg_152_0 and not isNil(var_152_11) and arg_149_1.var_.characterEffect10150ui_story then
				arg_149_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_152_15 = 0

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 then
				arg_149_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_152_17 = 0
			local var_152_18 = 0.05

			if var_152_17 < arg_149_1.time_ and arg_149_1.time_ <= var_152_17 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_19 = arg_149_1:FormatText(StoryNameCfg[1361].name)

				arg_149_1.leftNameTxt_.text = var_152_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_20 = arg_149_1:GetWordFromCfg(322042035)
				local var_152_21 = arg_149_1:FormatText(var_152_20.content)

				arg_149_1.text_.text = var_152_21

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_22 = 2
				local var_152_23 = utf8.len(var_152_21)
				local var_152_24 = var_152_22 <= 0 and var_152_18 or var_152_18 * (var_152_23 / var_152_22)

				if var_152_24 > 0 and var_152_18 < var_152_24 then
					arg_149_1.talkMaxDuration = var_152_24

					if var_152_24 + var_152_17 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_24 + var_152_17
					end
				end

				arg_149_1.text_.text = var_152_21
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042035", "story_v_out_322042.awb") ~= 0 then
					local var_152_25 = manager.audio:GetVoiceLength("story_v_out_322042", "322042035", "story_v_out_322042.awb") / 1000

					if var_152_25 + var_152_17 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_25 + var_152_17
					end

					if var_152_20.prefab_name ~= "" and arg_149_1.actors_[var_152_20.prefab_name] ~= nil then
						local var_152_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_20.prefab_name].transform, "story_v_out_322042", "322042035", "story_v_out_322042.awb")

						arg_149_1:RecordAudio("322042035", var_152_26)
						arg_149_1:RecordAudio("322042035", var_152_26)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322042", "322042035", "story_v_out_322042.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322042", "322042035", "story_v_out_322042.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_27 = math.max(var_152_18, arg_149_1.talkMaxDuration)

			if var_152_17 <= arg_149_1.time_ and arg_149_1.time_ < var_152_17 + var_152_27 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_17) / var_152_27

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_17 + var_152_27 and arg_149_1.time_ < var_152_17 + var_152_27 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322042036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322042036
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play322042037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10150ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos10150ui_story = var_156_0.localPosition

				local var_156_2 = GameObjectTools.GetOrAddComponent(var_156_0.gameObject, typeof(DynamicBoneHelper))

				if var_156_2 then
					var_156_2:EnableDynamicBone(false)
				end
			end

			local var_156_3 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_3 then
				local var_156_4 = (arg_153_1.time_ - var_156_1) / var_156_3
				local var_156_5 = Vector3.New(0, 100, 0)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10150ui_story, var_156_5, var_156_4)

				local var_156_6 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_6.x, var_156_6.y, var_156_6.z)

				local var_156_7 = var_156_0.localEulerAngles

				var_156_7.z = 0
				var_156_7.x = 0
				var_156_0.localEulerAngles = var_156_7
			end

			if arg_153_1.time_ >= var_156_1 + var_156_3 and arg_153_1.time_ < var_156_1 + var_156_3 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, 100, 0)

				local var_156_8 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_8.x, var_156_8.y, var_156_8.z)

				local var_156_9 = var_156_0.localEulerAngles

				var_156_9.z = 0
				var_156_9.x = 0
				var_156_0.localEulerAngles = var_156_9

				local var_156_10 = GameObjectTools.GetOrAddComponent(var_156_0.gameObject, typeof(DynamicBoneHelper))

				if var_156_10 then
					var_156_10:EnableDynamicBone(true)
				end
			end

			local var_156_11 = 0.433333333333333
			local var_156_12 = 1

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				local var_156_13 = "play"
				local var_156_14 = "effect"

				arg_153_1:AudioAction(var_156_13, var_156_14, "se_story_141", "se_story_141_sword_aim", "")
			end

			local var_156_15 = 0
			local var_156_16 = 0.825

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_17 = arg_153_1:GetWordFromCfg(322042036)
				local var_156_18 = arg_153_1:FormatText(var_156_17.content)

				arg_153_1.text_.text = var_156_18

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_19 = 33
				local var_156_20 = utf8.len(var_156_18)
				local var_156_21 = var_156_19 <= 0 and var_156_16 or var_156_16 * (var_156_20 / var_156_19)

				if var_156_21 > 0 and var_156_16 < var_156_21 then
					arg_153_1.talkMaxDuration = var_156_21

					if var_156_21 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_21 + var_156_15
					end
				end

				arg_153_1.text_.text = var_156_18
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_22 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_22 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_22

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_22 and arg_153_1.time_ < var_156_15 + var_156_22 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322042037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 322042037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play322042038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 1.5

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(322042037)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 60
				local var_160_5 = utf8.len(var_160_3)
				local var_160_6 = var_160_4 <= 0 and var_160_1 or var_160_1 * (var_160_5 / var_160_4)

				if var_160_6 > 0 and var_160_1 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_7 and arg_157_1.time_ < var_160_0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play322042038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 322042038
		arg_161_1.duration_ = 4.73

		local var_161_0 = {
			zh = 4.533,
			ja = 4.733
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
				arg_161_0:Play322042039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10150ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos10150ui_story = var_164_0.localPosition

				local var_164_2 = GameObjectTools.GetOrAddComponent(var_164_0.gameObject, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(false)
				end
			end

			local var_164_3 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_3 then
				local var_164_4 = (arg_161_1.time_ - var_164_1) / var_164_3
				local var_164_5 = Vector3.New(-0.9, -1.73, -5.5)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10150ui_story, var_164_5, var_164_4)

				local var_164_6 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_6.x, var_164_6.y, var_164_6.z)

				local var_164_7 = var_164_0.localEulerAngles

				var_164_7.z = 0
				var_164_7.x = 0
				var_164_0.localEulerAngles = var_164_7
			end

			if arg_161_1.time_ >= var_164_1 + var_164_3 and arg_161_1.time_ < var_164_1 + var_164_3 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_164_8 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_8.x, var_164_8.y, var_164_8.z)

				local var_164_9 = var_164_0.localEulerAngles

				var_164_9.z = 0
				var_164_9.x = 0
				var_164_0.localEulerAngles = var_164_9

				local var_164_10 = GameObjectTools.GetOrAddComponent(var_164_0.gameObject, typeof(DynamicBoneHelper))

				if var_164_10 then
					var_164_10:EnableDynamicBone(true)
				end
			end

			local var_164_11 = arg_161_1.actors_["10150ui_story"]
			local var_164_12 = 0

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 and not isNil(var_164_11) and arg_161_1.var_.characterEffect10150ui_story == nil then
				arg_161_1.var_.characterEffect10150ui_story = var_164_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_13 = 0.200000002980232

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_13 and not isNil(var_164_11) then
				local var_164_14 = (arg_161_1.time_ - var_164_12) / var_164_13

				if arg_161_1.var_.characterEffect10150ui_story and not isNil(var_164_11) then
					arg_161_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_12 + var_164_13 and arg_161_1.time_ < var_164_12 + var_164_13 + arg_164_0 and not isNil(var_164_11) and arg_161_1.var_.characterEffect10150ui_story then
				arg_161_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_164_15 = 0

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action4_1")
			end

			local var_164_16 = 0

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_164_17 = 0
			local var_164_18 = 0.325

			if var_164_17 < arg_161_1.time_ and arg_161_1.time_ <= var_164_17 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_19 = arg_161_1:FormatText(StoryNameCfg[1361].name)

				arg_161_1.leftNameTxt_.text = var_164_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_20 = arg_161_1:GetWordFromCfg(322042038)
				local var_164_21 = arg_161_1:FormatText(var_164_20.content)

				arg_161_1.text_.text = var_164_21

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_22 = 13
				local var_164_23 = utf8.len(var_164_21)
				local var_164_24 = var_164_22 <= 0 and var_164_18 or var_164_18 * (var_164_23 / var_164_22)

				if var_164_24 > 0 and var_164_18 < var_164_24 then
					arg_161_1.talkMaxDuration = var_164_24

					if var_164_24 + var_164_17 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_24 + var_164_17
					end
				end

				arg_161_1.text_.text = var_164_21
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042038", "story_v_out_322042.awb") ~= 0 then
					local var_164_25 = manager.audio:GetVoiceLength("story_v_out_322042", "322042038", "story_v_out_322042.awb") / 1000

					if var_164_25 + var_164_17 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_25 + var_164_17
					end

					if var_164_20.prefab_name ~= "" and arg_161_1.actors_[var_164_20.prefab_name] ~= nil then
						local var_164_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_20.prefab_name].transform, "story_v_out_322042", "322042038", "story_v_out_322042.awb")

						arg_161_1:RecordAudio("322042038", var_164_26)
						arg_161_1:RecordAudio("322042038", var_164_26)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_322042", "322042038", "story_v_out_322042.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_322042", "322042038", "story_v_out_322042.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_27 = math.max(var_164_18, arg_161_1.talkMaxDuration)

			if var_164_17 <= arg_161_1.time_ and arg_161_1.time_ < var_164_17 + var_164_27 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_17) / var_164_27

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_17 + var_164_27 and arg_161_1.time_ < var_164_17 + var_164_27 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322042039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 322042039
		arg_165_1.duration_ = 4.6

		local var_165_0 = {
			zh = 3.7,
			ja = 4.6
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
				arg_165_0:Play322042040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1156ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos1156ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0.9, -1.1, -6.18)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1156ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["1156ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1156ui_story == nil then
				arg_165_1.var_.characterEffect1156ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect1156ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1156ui_story then
				arg_165_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_168_13 = arg_165_1.actors_["10150ui_story"]
			local var_168_14 = 0

			if var_168_14 < arg_165_1.time_ and arg_165_1.time_ <= var_168_14 + arg_168_0 and not isNil(var_168_13) and arg_165_1.var_.characterEffect10150ui_story == nil then
				arg_165_1.var_.characterEffect10150ui_story = var_168_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_15 = 0.200000002980232

			if var_168_14 <= arg_165_1.time_ and arg_165_1.time_ < var_168_14 + var_168_15 and not isNil(var_168_13) then
				local var_168_16 = (arg_165_1.time_ - var_168_14) / var_168_15

				if arg_165_1.var_.characterEffect10150ui_story and not isNil(var_168_13) then
					local var_168_17 = Mathf.Lerp(0, 0.5, var_168_16)

					arg_165_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10150ui_story.fillRatio = var_168_17
				end
			end

			if arg_165_1.time_ >= var_168_14 + var_168_15 and arg_165_1.time_ < var_168_14 + var_168_15 + arg_168_0 and not isNil(var_168_13) and arg_165_1.var_.characterEffect10150ui_story then
				local var_168_18 = 0.5

				arg_165_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10150ui_story.fillRatio = var_168_18
			end

			local var_168_19 = 0

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action2_1")
			end

			local var_168_20 = 0
			local var_168_21 = 0.475

			if var_168_20 < arg_165_1.time_ and arg_165_1.time_ <= var_168_20 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_22 = arg_165_1:FormatText(StoryNameCfg[605].name)

				arg_165_1.leftNameTxt_.text = var_168_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_23 = arg_165_1:GetWordFromCfg(322042039)
				local var_168_24 = arg_165_1:FormatText(var_168_23.content)

				arg_165_1.text_.text = var_168_24

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_25 = 19
				local var_168_26 = utf8.len(var_168_24)
				local var_168_27 = var_168_25 <= 0 and var_168_21 or var_168_21 * (var_168_26 / var_168_25)

				if var_168_27 > 0 and var_168_21 < var_168_27 then
					arg_165_1.talkMaxDuration = var_168_27

					if var_168_27 + var_168_20 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_27 + var_168_20
					end
				end

				arg_165_1.text_.text = var_168_24
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042039", "story_v_out_322042.awb") ~= 0 then
					local var_168_28 = manager.audio:GetVoiceLength("story_v_out_322042", "322042039", "story_v_out_322042.awb") / 1000

					if var_168_28 + var_168_20 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_28 + var_168_20
					end

					if var_168_23.prefab_name ~= "" and arg_165_1.actors_[var_168_23.prefab_name] ~= nil then
						local var_168_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_23.prefab_name].transform, "story_v_out_322042", "322042039", "story_v_out_322042.awb")

						arg_165_1:RecordAudio("322042039", var_168_29)
						arg_165_1:RecordAudio("322042039", var_168_29)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_322042", "322042039", "story_v_out_322042.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_322042", "322042039", "story_v_out_322042.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_30 = math.max(var_168_21, arg_165_1.talkMaxDuration)

			if var_168_20 <= arg_165_1.time_ and arg_165_1.time_ < var_168_20 + var_168_30 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_20) / var_168_30

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_20 + var_168_30 and arg_165_1.time_ < var_168_20 + var_168_30 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play322042040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 322042040
		arg_169_1.duration_ = 7.97

		local var_169_0 = {
			zh = 5,
			ja = 7.966
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
				arg_169_0:Play322042041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10150ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10150ui_story = var_172_0.localPosition

				local var_172_2 = GameObjectTools.GetOrAddComponent(var_172_0.gameObject, typeof(DynamicBoneHelper))

				if var_172_2 then
					var_172_2:EnableDynamicBone(false)
				end
			end

			local var_172_3 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_3 then
				local var_172_4 = (arg_169_1.time_ - var_172_1) / var_172_3
				local var_172_5 = Vector3.New(-0.9, -1.73, -5.5)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10150ui_story, var_172_5, var_172_4)

				local var_172_6 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_6.x, var_172_6.y, var_172_6.z)

				local var_172_7 = var_172_0.localEulerAngles

				var_172_7.z = 0
				var_172_7.x = 0
				var_172_0.localEulerAngles = var_172_7
			end

			if arg_169_1.time_ >= var_172_1 + var_172_3 and arg_169_1.time_ < var_172_1 + var_172_3 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_172_8 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_8.x, var_172_8.y, var_172_8.z)

				local var_172_9 = var_172_0.localEulerAngles

				var_172_9.z = 0
				var_172_9.x = 0
				var_172_0.localEulerAngles = var_172_9

				local var_172_10 = GameObjectTools.GetOrAddComponent(var_172_0.gameObject, typeof(DynamicBoneHelper))

				if var_172_10 then
					var_172_10:EnableDynamicBone(true)
				end
			end

			local var_172_11 = arg_169_1.actors_["10150ui_story"]
			local var_172_12 = 0

			if var_172_12 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 and not isNil(var_172_11) and arg_169_1.var_.characterEffect10150ui_story == nil then
				arg_169_1.var_.characterEffect10150ui_story = var_172_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_13 = 0.200000002980232

			if var_172_12 <= arg_169_1.time_ and arg_169_1.time_ < var_172_12 + var_172_13 and not isNil(var_172_11) then
				local var_172_14 = (arg_169_1.time_ - var_172_12) / var_172_13

				if arg_169_1.var_.characterEffect10150ui_story and not isNil(var_172_11) then
					arg_169_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_12 + var_172_13 and arg_169_1.time_ < var_172_12 + var_172_13 + arg_172_0 and not isNil(var_172_11) and arg_169_1.var_.characterEffect10150ui_story then
				arg_169_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_172_15 = arg_169_1.actors_["1156ui_story"]
			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.characterEffect1156ui_story == nil then
				arg_169_1.var_.characterEffect1156ui_story = var_172_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_17 = 0.200000002980232

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 and not isNil(var_172_15) then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17

				if arg_169_1.var_.characterEffect1156ui_story and not isNil(var_172_15) then
					local var_172_19 = Mathf.Lerp(0, 0.5, var_172_18)

					arg_169_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1156ui_story.fillRatio = var_172_19
				end
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 and not isNil(var_172_15) and arg_169_1.var_.characterEffect1156ui_story then
				local var_172_20 = 0.5

				arg_169_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1156ui_story.fillRatio = var_172_20
			end

			local var_172_21 = 0

			if var_172_21 < arg_169_1.time_ and arg_169_1.time_ <= var_172_21 + arg_172_0 then
				arg_169_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action4_2")
			end

			local var_172_22 = 0

			if var_172_22 < arg_169_1.time_ and arg_169_1.time_ <= var_172_22 + arg_172_0 then
				arg_169_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_172_23 = 0
			local var_172_24 = 0.5

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_25 = arg_169_1:FormatText(StoryNameCfg[1361].name)

				arg_169_1.leftNameTxt_.text = var_172_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_26 = arg_169_1:GetWordFromCfg(322042040)
				local var_172_27 = arg_169_1:FormatText(var_172_26.content)

				arg_169_1.text_.text = var_172_27

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_28 = 20
				local var_172_29 = utf8.len(var_172_27)
				local var_172_30 = var_172_28 <= 0 and var_172_24 or var_172_24 * (var_172_29 / var_172_28)

				if var_172_30 > 0 and var_172_24 < var_172_30 then
					arg_169_1.talkMaxDuration = var_172_30

					if var_172_30 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_30 + var_172_23
					end
				end

				arg_169_1.text_.text = var_172_27
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042040", "story_v_out_322042.awb") ~= 0 then
					local var_172_31 = manager.audio:GetVoiceLength("story_v_out_322042", "322042040", "story_v_out_322042.awb") / 1000

					if var_172_31 + var_172_23 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_31 + var_172_23
					end

					if var_172_26.prefab_name ~= "" and arg_169_1.actors_[var_172_26.prefab_name] ~= nil then
						local var_172_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_26.prefab_name].transform, "story_v_out_322042", "322042040", "story_v_out_322042.awb")

						arg_169_1:RecordAudio("322042040", var_172_32)
						arg_169_1:RecordAudio("322042040", var_172_32)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_322042", "322042040", "story_v_out_322042.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_322042", "322042040", "story_v_out_322042.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_33 = math.max(var_172_24, arg_169_1.talkMaxDuration)

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_33 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_23) / var_172_33

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_23 + var_172_33 and arg_169_1.time_ < var_172_23 + var_172_33 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322042041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 322042041
		arg_173_1.duration_ = 7.17

		local var_173_0 = {
			zh = 4.233,
			ja = 7.166
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
				arg_173_0:Play322042042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1284ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1284ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0.7, -0.985, -6.22)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1284ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1156ui_story"].transform
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.var_.moveOldPos1156ui_story = var_176_9.localPosition
			end

			local var_176_11 = 0.001

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11
				local var_176_13 = Vector3.New(0, 100, 0)

				var_176_9.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1156ui_story, var_176_13, var_176_12)

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

			local var_176_18 = arg_173_1.actors_["1284ui_story"]
			local var_176_19 = 0

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 and not isNil(var_176_18) and arg_173_1.var_.characterEffect1284ui_story == nil then
				arg_173_1.var_.characterEffect1284ui_story = var_176_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_20 = 0.200000002980232

			if var_176_19 <= arg_173_1.time_ and arg_173_1.time_ < var_176_19 + var_176_20 and not isNil(var_176_18) then
				local var_176_21 = (arg_173_1.time_ - var_176_19) / var_176_20

				if arg_173_1.var_.characterEffect1284ui_story and not isNil(var_176_18) then
					arg_173_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_19 + var_176_20 and arg_173_1.time_ < var_176_19 + var_176_20 + arg_176_0 and not isNil(var_176_18) and arg_173_1.var_.characterEffect1284ui_story then
				arg_173_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_176_22 = arg_173_1.actors_["10150ui_story"]
			local var_176_23 = 0

			if var_176_23 < arg_173_1.time_ and arg_173_1.time_ <= var_176_23 + arg_176_0 and not isNil(var_176_22) and arg_173_1.var_.characterEffect10150ui_story == nil then
				arg_173_1.var_.characterEffect10150ui_story = var_176_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_24 = 0.200000002980232

			if var_176_23 <= arg_173_1.time_ and arg_173_1.time_ < var_176_23 + var_176_24 and not isNil(var_176_22) then
				local var_176_25 = (arg_173_1.time_ - var_176_23) / var_176_24

				if arg_173_1.var_.characterEffect10150ui_story and not isNil(var_176_22) then
					local var_176_26 = Mathf.Lerp(0, 0.5, var_176_25)

					arg_173_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10150ui_story.fillRatio = var_176_26
				end
			end

			if arg_173_1.time_ >= var_176_23 + var_176_24 and arg_173_1.time_ < var_176_23 + var_176_24 + arg_176_0 and not isNil(var_176_22) and arg_173_1.var_.characterEffect10150ui_story then
				local var_176_27 = 0.5

				arg_173_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10150ui_story.fillRatio = var_176_27
			end

			local var_176_28 = 0

			if var_176_28 < arg_173_1.time_ and arg_173_1.time_ <= var_176_28 + arg_176_0 then
				arg_173_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_176_29 = 0

			if var_176_29 < arg_173_1.time_ and arg_173_1.time_ <= var_176_29 + arg_176_0 then
				arg_173_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_176_30 = 0
			local var_176_31 = 0.625

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

				local var_176_33 = arg_173_1:GetWordFromCfg(322042041)
				local var_176_34 = arg_173_1:FormatText(var_176_33.content)

				arg_173_1.text_.text = var_176_34

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_35 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042041", "story_v_out_322042.awb") ~= 0 then
					local var_176_38 = manager.audio:GetVoiceLength("story_v_out_322042", "322042041", "story_v_out_322042.awb") / 1000

					if var_176_38 + var_176_30 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_38 + var_176_30
					end

					if var_176_33.prefab_name ~= "" and arg_173_1.actors_[var_176_33.prefab_name] ~= nil then
						local var_176_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_33.prefab_name].transform, "story_v_out_322042", "322042041", "story_v_out_322042.awb")

						arg_173_1:RecordAudio("322042041", var_176_39)
						arg_173_1:RecordAudio("322042041", var_176_39)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_322042", "322042041", "story_v_out_322042.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_322042", "322042041", "story_v_out_322042.awb")
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
				actorName = "1156ui_story",
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
	Play322042042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 322042042
		arg_177_1.duration_ = 2

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play322042043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10150ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10150ui_story == nil then
				arg_177_1.var_.characterEffect10150ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect10150ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10150ui_story then
				arg_177_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_180_4 = arg_177_1.actors_["1284ui_story"]
			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1284ui_story == nil then
				arg_177_1.var_.characterEffect1284ui_story = var_180_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_6 = 0.200000002980232

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_6 and not isNil(var_180_4) then
				local var_180_7 = (arg_177_1.time_ - var_180_5) / var_180_6

				if arg_177_1.var_.characterEffect1284ui_story and not isNil(var_180_4) then
					local var_180_8 = Mathf.Lerp(0, 0.5, var_180_7)

					arg_177_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1284ui_story.fillRatio = var_180_8
				end
			end

			if arg_177_1.time_ >= var_180_5 + var_180_6 and arg_177_1.time_ < var_180_5 + var_180_6 + arg_180_0 and not isNil(var_180_4) and arg_177_1.var_.characterEffect1284ui_story then
				local var_180_9 = 0.5

				arg_177_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1284ui_story.fillRatio = var_180_9
			end

			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_1")
			end

			local var_180_11 = 0

			if var_180_11 < arg_177_1.time_ and arg_177_1.time_ <= var_180_11 + arg_180_0 then
				arg_177_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_180_12 = 0
			local var_180_13 = 0.1

			if var_180_12 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_14 = arg_177_1:FormatText(StoryNameCfg[1361].name)

				arg_177_1.leftNameTxt_.text = var_180_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_15 = arg_177_1:GetWordFromCfg(322042042)
				local var_180_16 = arg_177_1:FormatText(var_180_15.content)

				arg_177_1.text_.text = var_180_16

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_17 = 4
				local var_180_18 = utf8.len(var_180_16)
				local var_180_19 = var_180_17 <= 0 and var_180_13 or var_180_13 * (var_180_18 / var_180_17)

				if var_180_19 > 0 and var_180_13 < var_180_19 then
					arg_177_1.talkMaxDuration = var_180_19

					if var_180_19 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_19 + var_180_12
					end
				end

				arg_177_1.text_.text = var_180_16
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042042", "story_v_out_322042.awb") ~= 0 then
					local var_180_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042042", "story_v_out_322042.awb") / 1000

					if var_180_20 + var_180_12 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_20 + var_180_12
					end

					if var_180_15.prefab_name ~= "" and arg_177_1.actors_[var_180_15.prefab_name] ~= nil then
						local var_180_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_15.prefab_name].transform, "story_v_out_322042", "322042042", "story_v_out_322042.awb")

						arg_177_1:RecordAudio("322042042", var_180_21)
						arg_177_1:RecordAudio("322042042", var_180_21)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_322042", "322042042", "story_v_out_322042.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_322042", "322042042", "story_v_out_322042.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_22 = math.max(var_180_13, arg_177_1.talkMaxDuration)

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_22 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_12) / var_180_22

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_12 + var_180_22 and arg_177_1.time_ < var_180_12 + var_180_22 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play322042043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 322042043
		arg_181_1.duration_ = 7.43

		local var_181_0 = {
			zh = 2.966,
			ja = 7.433
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
				arg_181_0:Play322042044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1284ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1284ui_story == nil then
				arg_181_1.var_.characterEffect1284ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1284ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1284ui_story then
				arg_181_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["10150ui_story"]
			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect10150ui_story == nil then
				arg_181_1.var_.characterEffect10150ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 and not isNil(var_184_4) then
				local var_184_7 = (arg_181_1.time_ - var_184_5) / var_184_6

				if arg_181_1.var_.characterEffect10150ui_story and not isNil(var_184_4) then
					local var_184_8 = Mathf.Lerp(0, 0.5, var_184_7)

					arg_181_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10150ui_story.fillRatio = var_184_8
				end
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect10150ui_story then
				local var_184_9 = 0.5

				arg_181_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10150ui_story.fillRatio = var_184_9
			end

			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_184_11 = 0
			local var_184_12 = 0.425

			if var_184_11 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_13 = arg_181_1:FormatText(StoryNameCfg[6].name)

				arg_181_1.leftNameTxt_.text = var_184_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_14 = arg_181_1:GetWordFromCfg(322042043)
				local var_184_15 = arg_181_1:FormatText(var_184_14.content)

				arg_181_1.text_.text = var_184_15

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_16 = 17
				local var_184_17 = utf8.len(var_184_15)
				local var_184_18 = var_184_16 <= 0 and var_184_12 or var_184_12 * (var_184_17 / var_184_16)

				if var_184_18 > 0 and var_184_12 < var_184_18 then
					arg_181_1.talkMaxDuration = var_184_18

					if var_184_18 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_18 + var_184_11
					end
				end

				arg_181_1.text_.text = var_184_15
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042043", "story_v_out_322042.awb") ~= 0 then
					local var_184_19 = manager.audio:GetVoiceLength("story_v_out_322042", "322042043", "story_v_out_322042.awb") / 1000

					if var_184_19 + var_184_11 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_19 + var_184_11
					end

					if var_184_14.prefab_name ~= "" and arg_181_1.actors_[var_184_14.prefab_name] ~= nil then
						local var_184_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_14.prefab_name].transform, "story_v_out_322042", "322042043", "story_v_out_322042.awb")

						arg_181_1:RecordAudio("322042043", var_184_20)
						arg_181_1:RecordAudio("322042043", var_184_20)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_322042", "322042043", "story_v_out_322042.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_322042", "322042043", "story_v_out_322042.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_21 = math.max(var_184_12, arg_181_1.talkMaxDuration)

			if var_184_11 <= arg_181_1.time_ and arg_181_1.time_ < var_184_11 + var_184_21 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_11) / var_184_21

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_11 + var_184_21 and arg_181_1.time_ < var_184_11 + var_184_21 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play322042044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 322042044
		arg_185_1.duration_ = 13.2

		local var_185_0 = {
			zh = 8.5,
			ja = 13.2
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
				arg_185_0:Play322042045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10150ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10150ui_story = var_188_0.localPosition

				local var_188_2 = GameObjectTools.GetOrAddComponent(var_188_0.gameObject, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(false)
				end
			end

			local var_188_3 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_3 then
				local var_188_4 = (arg_185_1.time_ - var_188_1) / var_188_3
				local var_188_5 = Vector3.New(-0.9, -1.73, -5.5)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10150ui_story, var_188_5, var_188_4)

				local var_188_6 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_6.x, var_188_6.y, var_188_6.z)

				local var_188_7 = var_188_0.localEulerAngles

				var_188_7.z = 0
				var_188_7.x = 0
				var_188_0.localEulerAngles = var_188_7
			end

			if arg_185_1.time_ >= var_188_1 + var_188_3 and arg_185_1.time_ < var_188_1 + var_188_3 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_188_8 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_8.x, var_188_8.y, var_188_8.z)

				local var_188_9 = var_188_0.localEulerAngles

				var_188_9.z = 0
				var_188_9.x = 0
				var_188_0.localEulerAngles = var_188_9

				local var_188_10 = GameObjectTools.GetOrAddComponent(var_188_0.gameObject, typeof(DynamicBoneHelper))

				if var_188_10 then
					var_188_10:EnableDynamicBone(true)
				end
			end

			local var_188_11 = arg_185_1.actors_["10150ui_story"]
			local var_188_12 = 0

			if var_188_12 < arg_185_1.time_ and arg_185_1.time_ <= var_188_12 + arg_188_0 and not isNil(var_188_11) and arg_185_1.var_.characterEffect10150ui_story == nil then
				arg_185_1.var_.characterEffect10150ui_story = var_188_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_13 = 0.200000002980232

			if var_188_12 <= arg_185_1.time_ and arg_185_1.time_ < var_188_12 + var_188_13 and not isNil(var_188_11) then
				local var_188_14 = (arg_185_1.time_ - var_188_12) / var_188_13

				if arg_185_1.var_.characterEffect10150ui_story and not isNil(var_188_11) then
					arg_185_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= var_188_12 + var_188_13 and arg_185_1.time_ < var_188_12 + var_188_13 + arg_188_0 and not isNil(var_188_11) and arg_185_1.var_.characterEffect10150ui_story then
				arg_185_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_188_15 = arg_185_1.actors_["1284ui_story"]
			local var_188_16 = 0

			if var_188_16 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.characterEffect1284ui_story == nil then
				arg_185_1.var_.characterEffect1284ui_story = var_188_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_17 = 0.200000002980232

			if var_188_16 <= arg_185_1.time_ and arg_185_1.time_ < var_188_16 + var_188_17 and not isNil(var_188_15) then
				local var_188_18 = (arg_185_1.time_ - var_188_16) / var_188_17

				if arg_185_1.var_.characterEffect1284ui_story and not isNil(var_188_15) then
					local var_188_19 = Mathf.Lerp(0, 0.5, var_188_18)

					arg_185_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1284ui_story.fillRatio = var_188_19
				end
			end

			if arg_185_1.time_ >= var_188_16 + var_188_17 and arg_185_1.time_ < var_188_16 + var_188_17 + arg_188_0 and not isNil(var_188_15) and arg_185_1.var_.characterEffect1284ui_story then
				local var_188_20 = 0.5

				arg_185_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1284ui_story.fillRatio = var_188_20
			end

			local var_188_21 = 0

			if var_188_21 < arg_185_1.time_ and arg_185_1.time_ <= var_188_21 + arg_188_0 then
				arg_185_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_2")
			end

			local var_188_22 = 0

			if var_188_22 < arg_185_1.time_ and arg_185_1.time_ <= var_188_22 + arg_188_0 then
				arg_185_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_188_23 = 0
			local var_188_24 = 0.875

			if var_188_23 < arg_185_1.time_ and arg_185_1.time_ <= var_188_23 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_25 = arg_185_1:FormatText(StoryNameCfg[1361].name)

				arg_185_1.leftNameTxt_.text = var_188_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_26 = arg_185_1:GetWordFromCfg(322042044)
				local var_188_27 = arg_185_1:FormatText(var_188_26.content)

				arg_185_1.text_.text = var_188_27

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_28 = 35
				local var_188_29 = utf8.len(var_188_27)
				local var_188_30 = var_188_28 <= 0 and var_188_24 or var_188_24 * (var_188_29 / var_188_28)

				if var_188_30 > 0 and var_188_24 < var_188_30 then
					arg_185_1.talkMaxDuration = var_188_30

					if var_188_30 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_30 + var_188_23
					end
				end

				arg_185_1.text_.text = var_188_27
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042044", "story_v_out_322042.awb") ~= 0 then
					local var_188_31 = manager.audio:GetVoiceLength("story_v_out_322042", "322042044", "story_v_out_322042.awb") / 1000

					if var_188_31 + var_188_23 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_31 + var_188_23
					end

					if var_188_26.prefab_name ~= "" and arg_185_1.actors_[var_188_26.prefab_name] ~= nil then
						local var_188_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_26.prefab_name].transform, "story_v_out_322042", "322042044", "story_v_out_322042.awb")

						arg_185_1:RecordAudio("322042044", var_188_32)
						arg_185_1:RecordAudio("322042044", var_188_32)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_322042", "322042044", "story_v_out_322042.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_322042", "322042044", "story_v_out_322042.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_33 = math.max(var_188_24, arg_185_1.talkMaxDuration)

			if var_188_23 <= arg_185_1.time_ and arg_185_1.time_ < var_188_23 + var_188_33 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_23) / var_188_33

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_23 + var_188_33 and arg_185_1.time_ < var_188_23 + var_188_33 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322042045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 322042045
		arg_189_1.duration_ = 5.67

		local var_189_0 = {
			zh = 5.433,
			ja = 5.666
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
				arg_189_0:Play322042046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_192_2 = 0
			local var_192_3 = 0.575

			if var_192_2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_4 = arg_189_1:FormatText(StoryNameCfg[1361].name)

				arg_189_1.leftNameTxt_.text = var_192_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_5 = arg_189_1:GetWordFromCfg(322042045)
				local var_192_6 = arg_189_1:FormatText(var_192_5.content)

				arg_189_1.text_.text = var_192_6

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 23
				local var_192_8 = utf8.len(var_192_6)
				local var_192_9 = var_192_7 <= 0 and var_192_3 or var_192_3 * (var_192_8 / var_192_7)

				if var_192_9 > 0 and var_192_3 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_6
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042045", "story_v_out_322042.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_322042", "322042045", "story_v_out_322042.awb") / 1000

					if var_192_10 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_2
					end

					if var_192_5.prefab_name ~= "" and arg_189_1.actors_[var_192_5.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_5.prefab_name].transform, "story_v_out_322042", "322042045", "story_v_out_322042.awb")

						arg_189_1:RecordAudio("322042045", var_192_11)
						arg_189_1:RecordAudio("322042045", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_322042", "322042045", "story_v_out_322042.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_322042", "322042045", "story_v_out_322042.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_12 and arg_189_1.time_ < var_192_2 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play322042046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 322042046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play322042047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10150ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect10150ui_story == nil then
				arg_193_1.var_.characterEffect10150ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect10150ui_story and not isNil(var_196_0) then
					local var_196_4 = Mathf.Lerp(0, 0.5, var_196_3)

					arg_193_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10150ui_story.fillRatio = var_196_4
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect10150ui_story then
				local var_196_5 = 0.5

				arg_193_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10150ui_story.fillRatio = var_196_5
			end

			local var_196_6 = 0
			local var_196_7 = 1.475

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:GetWordFromCfg(322042046)
				local var_196_9 = arg_193_1:FormatText(var_196_8.content)

				arg_193_1.text_.text = var_196_9

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 59
				local var_196_11 = utf8.len(var_196_9)
				local var_196_12 = var_196_10 <= 0 and var_196_7 or var_196_7 * (var_196_11 / var_196_10)

				if var_196_12 > 0 and var_196_7 < var_196_12 then
					arg_193_1.talkMaxDuration = var_196_12

					if var_196_12 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_12 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_9
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_13 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_13

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_13 and arg_193_1.time_ < var_196_6 + var_196_13 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play322042047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 322042047
		arg_197_1.duration_ = 10.67

		local var_197_0 = {
			zh = 9.333,
			ja = 10.666
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
				arg_197_0:Play322042048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1284ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1284ui_story == nil then
				arg_197_1.var_.characterEffect1284ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1284ui_story and not isNil(var_200_0) then
					arg_197_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1284ui_story then
				arg_197_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_200_4 = 0

			if var_200_4 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			local var_200_5 = 0

			if var_200_5 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_200_6 = 0
			local var_200_7 = 1.3

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[6].name)

				arg_197_1.leftNameTxt_.text = var_200_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_9 = arg_197_1:GetWordFromCfg(322042047)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 52
				local var_200_12 = utf8.len(var_200_10)
				local var_200_13 = var_200_11 <= 0 and var_200_7 or var_200_7 * (var_200_12 / var_200_11)

				if var_200_13 > 0 and var_200_7 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042047", "story_v_out_322042.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_322042", "322042047", "story_v_out_322042.awb") / 1000

					if var_200_14 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_6
					end

					if var_200_9.prefab_name ~= "" and arg_197_1.actors_[var_200_9.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_9.prefab_name].transform, "story_v_out_322042", "322042047", "story_v_out_322042.awb")

						arg_197_1:RecordAudio("322042047", var_200_15)
						arg_197_1:RecordAudio("322042047", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_322042", "322042047", "story_v_out_322042.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_322042", "322042047", "story_v_out_322042.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_16 and arg_197_1.time_ < var_200_6 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play322042048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 322042048
		arg_201_1.duration_ = 7.07

		local var_201_0 = {
			zh = 6.5,
			ja = 7.066
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
				arg_201_0:Play322042049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10150ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect10150ui_story == nil then
				arg_201_1.var_.characterEffect10150ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect10150ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect10150ui_story then
				arg_201_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["1284ui_story"]
			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1284ui_story == nil then
				arg_201_1.var_.characterEffect1284ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_6 = 0.200000002980232

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 and not isNil(var_204_4) then
				local var_204_7 = (arg_201_1.time_ - var_204_5) / var_204_6

				if arg_201_1.var_.characterEffect1284ui_story and not isNil(var_204_4) then
					local var_204_8 = Mathf.Lerp(0, 0.5, var_204_7)

					arg_201_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1284ui_story.fillRatio = var_204_8
				end
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect1284ui_story then
				local var_204_9 = 0.5

				arg_201_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1284ui_story.fillRatio = var_204_9
			end

			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 then
				arg_201_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action2_1")
			end

			local var_204_11 = 0

			if var_204_11 < arg_201_1.time_ and arg_201_1.time_ <= var_204_11 + arg_204_0 then
				arg_201_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_204_12 = 0
			local var_204_13 = 0.45

			if var_204_12 < arg_201_1.time_ and arg_201_1.time_ <= var_204_12 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_14 = arg_201_1:FormatText(StoryNameCfg[1361].name)

				arg_201_1.leftNameTxt_.text = var_204_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_15 = arg_201_1:GetWordFromCfg(322042048)
				local var_204_16 = arg_201_1:FormatText(var_204_15.content)

				arg_201_1.text_.text = var_204_16

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_17 = 18
				local var_204_18 = utf8.len(var_204_16)
				local var_204_19 = var_204_17 <= 0 and var_204_13 or var_204_13 * (var_204_18 / var_204_17)

				if var_204_19 > 0 and var_204_13 < var_204_19 then
					arg_201_1.talkMaxDuration = var_204_19

					if var_204_19 + var_204_12 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_19 + var_204_12
					end
				end

				arg_201_1.text_.text = var_204_16
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042048", "story_v_out_322042.awb") ~= 0 then
					local var_204_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042048", "story_v_out_322042.awb") / 1000

					if var_204_20 + var_204_12 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_20 + var_204_12
					end

					if var_204_15.prefab_name ~= "" and arg_201_1.actors_[var_204_15.prefab_name] ~= nil then
						local var_204_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_15.prefab_name].transform, "story_v_out_322042", "322042048", "story_v_out_322042.awb")

						arg_201_1:RecordAudio("322042048", var_204_21)
						arg_201_1:RecordAudio("322042048", var_204_21)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_322042", "322042048", "story_v_out_322042.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_322042", "322042048", "story_v_out_322042.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_22 = math.max(var_204_13, arg_201_1.talkMaxDuration)

			if var_204_12 <= arg_201_1.time_ and arg_201_1.time_ < var_204_12 + var_204_22 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_12) / var_204_22

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_12 + var_204_22 and arg_201_1.time_ < var_204_12 + var_204_22 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play322042049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 322042049
		arg_205_1.duration_ = 9.83

		local var_205_0 = {
			zh = 7.5,
			ja = 9.833
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
				arg_205_0:Play322042050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1284ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1284ui_story == nil then
				arg_205_1.var_.characterEffect1284ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect1284ui_story and not isNil(var_208_0) then
					arg_205_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1284ui_story then
				arg_205_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_208_4 = arg_205_1.actors_["10150ui_story"]
			local var_208_5 = 0

			if var_208_5 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect10150ui_story == nil then
				arg_205_1.var_.characterEffect10150ui_story = var_208_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_6 = 0.200000002980232

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_6 and not isNil(var_208_4) then
				local var_208_7 = (arg_205_1.time_ - var_208_5) / var_208_6

				if arg_205_1.var_.characterEffect10150ui_story and not isNil(var_208_4) then
					local var_208_8 = Mathf.Lerp(0, 0.5, var_208_7)

					arg_205_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10150ui_story.fillRatio = var_208_8
				end
			end

			if arg_205_1.time_ >= var_208_5 + var_208_6 and arg_205_1.time_ < var_208_5 + var_208_6 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect10150ui_story then
				local var_208_9 = 0.5

				arg_205_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10150ui_story.fillRatio = var_208_9
			end

			local var_208_10 = 0

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 then
				arg_205_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action6_1")
			end

			local var_208_11 = 0

			if var_208_11 < arg_205_1.time_ and arg_205_1.time_ <= var_208_11 + arg_208_0 then
				arg_205_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_208_12 = 0
			local var_208_13 = 1.075

			if var_208_12 < arg_205_1.time_ and arg_205_1.time_ <= var_208_12 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_14 = arg_205_1:FormatText(StoryNameCfg[6].name)

				arg_205_1.leftNameTxt_.text = var_208_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_15 = arg_205_1:GetWordFromCfg(322042049)
				local var_208_16 = arg_205_1:FormatText(var_208_15.content)

				arg_205_1.text_.text = var_208_16

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_17 = 43
				local var_208_18 = utf8.len(var_208_16)
				local var_208_19 = var_208_17 <= 0 and var_208_13 or var_208_13 * (var_208_18 / var_208_17)

				if var_208_19 > 0 and var_208_13 < var_208_19 then
					arg_205_1.talkMaxDuration = var_208_19

					if var_208_19 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_19 + var_208_12
					end
				end

				arg_205_1.text_.text = var_208_16
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042049", "story_v_out_322042.awb") ~= 0 then
					local var_208_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042049", "story_v_out_322042.awb") / 1000

					if var_208_20 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_20 + var_208_12
					end

					if var_208_15.prefab_name ~= "" and arg_205_1.actors_[var_208_15.prefab_name] ~= nil then
						local var_208_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_15.prefab_name].transform, "story_v_out_322042", "322042049", "story_v_out_322042.awb")

						arg_205_1:RecordAudio("322042049", var_208_21)
						arg_205_1:RecordAudio("322042049", var_208_21)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_322042", "322042049", "story_v_out_322042.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_322042", "322042049", "story_v_out_322042.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_22 = math.max(var_208_13, arg_205_1.talkMaxDuration)

			if var_208_12 <= arg_205_1.time_ and arg_205_1.time_ < var_208_12 + var_208_22 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_12) / var_208_22

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_12 + var_208_22 and arg_205_1.time_ < var_208_12 + var_208_22 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play322042050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322042050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play322042051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1284ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1284ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0, 100, 0)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1284ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0, 100, 0)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["10150ui_story"].transform
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 then
				arg_209_1.var_.moveOldPos10150ui_story = var_212_9.localPosition

				local var_212_11 = GameObjectTools.GetOrAddComponent(var_212_9.gameObject, typeof(DynamicBoneHelper))

				if var_212_11 then
					var_212_11:EnableDynamicBone(false)
				end
			end

			local var_212_12 = 0.001

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_12 then
				local var_212_13 = (arg_209_1.time_ - var_212_10) / var_212_12
				local var_212_14 = Vector3.New(0, 100, 0)

				var_212_9.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10150ui_story, var_212_14, var_212_13)

				local var_212_15 = manager.ui.mainCamera.transform.position - var_212_9.position

				var_212_9.forward = Vector3.New(var_212_15.x, var_212_15.y, var_212_15.z)

				local var_212_16 = var_212_9.localEulerAngles

				var_212_16.z = 0
				var_212_16.x = 0
				var_212_9.localEulerAngles = var_212_16
			end

			if arg_209_1.time_ >= var_212_10 + var_212_12 and arg_209_1.time_ < var_212_10 + var_212_12 + arg_212_0 then
				var_212_9.localPosition = Vector3.New(0, 100, 0)

				local var_212_17 = manager.ui.mainCamera.transform.position - var_212_9.position

				var_212_9.forward = Vector3.New(var_212_17.x, var_212_17.y, var_212_17.z)

				local var_212_18 = var_212_9.localEulerAngles

				var_212_18.z = 0
				var_212_18.x = 0
				var_212_9.localEulerAngles = var_212_18

				local var_212_19 = GameObjectTools.GetOrAddComponent(var_212_9.gameObject, typeof(DynamicBoneHelper))

				if var_212_19 then
					var_212_19:EnableDynamicBone(true)
				end
			end

			local var_212_20 = 0
			local var_212_21 = 1.075

			if var_212_20 < arg_209_1.time_ and arg_209_1.time_ <= var_212_20 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_22 = arg_209_1:GetWordFromCfg(322042050)
				local var_212_23 = arg_209_1:FormatText(var_212_22.content)

				arg_209_1.text_.text = var_212_23

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_24 = 43
				local var_212_25 = utf8.len(var_212_23)
				local var_212_26 = var_212_24 <= 0 and var_212_21 or var_212_21 * (var_212_25 / var_212_24)

				if var_212_26 > 0 and var_212_21 < var_212_26 then
					arg_209_1.talkMaxDuration = var_212_26

					if var_212_26 + var_212_20 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_26 + var_212_20
					end
				end

				arg_209_1.text_.text = var_212_23
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_27 = math.max(var_212_21, arg_209_1.talkMaxDuration)

			if var_212_20 <= arg_209_1.time_ and arg_209_1.time_ < var_212_20 + var_212_27 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_20) / var_212_27

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_20 + var_212_27 and arg_209_1.time_ < var_212_20 + var_212_27 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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
				actorName = "10150ui_story",
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
	Play322042051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322042051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play322042052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.433333333333333
			local var_216_1 = 1

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				local var_216_2 = "play"
				local var_216_3 = "effect"

				arg_213_1:AudioAction(var_216_2, var_216_3, "se_story_140", "se_story_140_microphone", "")
			end

			local var_216_4 = manager.ui.mainCamera.transform
			local var_216_5 = 0.433333333333333

			if var_216_5 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				local var_216_6 = arg_213_1.var_.effect2051
				local var_216_7
				local var_216_8 = var_216_4

				if not var_216_6 then
					var_216_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_216_8)
					var_216_6.name = "2051"
					arg_213_1.var_.effect2051 = var_216_6
				else
					var_216_6.transform:SetParent(var_216_8)
				end

				var_216_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_216_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_216_9 = manager.ui.mainCamera.transform
			local var_216_10 = 1.73333333333333

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				local var_216_11 = arg_213_1.var_.effect2051

				if var_216_11 then
					Object.Destroy(var_216_11)

					arg_213_1.var_.effect2051 = nil
				end
			end

			local var_216_12 = 0
			local var_216_13 = 1.25

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_14 = arg_213_1:GetWordFromCfg(322042051)
				local var_216_15 = arg_213_1:FormatText(var_216_14.content)

				arg_213_1.text_.text = var_216_15

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_16 = 50
				local var_216_17 = utf8.len(var_216_15)
				local var_216_18 = var_216_16 <= 0 and var_216_13 or var_216_13 * (var_216_17 / var_216_16)

				if var_216_18 > 0 and var_216_13 < var_216_18 then
					arg_213_1.talkMaxDuration = var_216_18

					if var_216_18 + var_216_12 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_18 + var_216_12
					end
				end

				arg_213_1.text_.text = var_216_15
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_19 = math.max(var_216_13, arg_213_1.talkMaxDuration)

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_19 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_12) / var_216_19

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_12 + var_216_19 and arg_213_1.time_ < var_216_12 + var_216_19 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play322042052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322042052
		arg_217_1.duration_ = 2

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play322042053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1156ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1156ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0, -1.1, -6.18)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1156ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["1156ui_story"]
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1156ui_story == nil then
				arg_217_1.var_.characterEffect1156ui_story = var_220_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_11 = 0.200000002980232

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 and not isNil(var_220_9) then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11

				if arg_217_1.var_.characterEffect1156ui_story and not isNil(var_220_9) then
					arg_217_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1156ui_story then
				arg_217_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_220_13 = 0

			if var_220_13 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 then
				arg_217_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_220_14 = 0

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				arg_217_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_220_15 = 0
			local var_220_16 = 0.25

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_17 = arg_217_1:FormatText(StoryNameCfg[605].name)

				arg_217_1.leftNameTxt_.text = var_220_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_18 = arg_217_1:GetWordFromCfg(322042052)
				local var_220_19 = arg_217_1:FormatText(var_220_18.content)

				arg_217_1.text_.text = var_220_19

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_20 = 10
				local var_220_21 = utf8.len(var_220_19)
				local var_220_22 = var_220_20 <= 0 and var_220_16 or var_220_16 * (var_220_21 / var_220_20)

				if var_220_22 > 0 and var_220_16 < var_220_22 then
					arg_217_1.talkMaxDuration = var_220_22

					if var_220_22 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_22 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_19
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042052", "story_v_out_322042.awb") ~= 0 then
					local var_220_23 = manager.audio:GetVoiceLength("story_v_out_322042", "322042052", "story_v_out_322042.awb") / 1000

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end

					if var_220_18.prefab_name ~= "" and arg_217_1.actors_[var_220_18.prefab_name] ~= nil then
						local var_220_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_18.prefab_name].transform, "story_v_out_322042", "322042052", "story_v_out_322042.awb")

						arg_217_1:RecordAudio("322042052", var_220_24)
						arg_217_1:RecordAudio("322042052", var_220_24)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322042", "322042052", "story_v_out_322042.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322042", "322042052", "story_v_out_322042.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_25 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_25 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_15) / var_220_25

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_15 + var_220_25 and arg_217_1.time_ < var_220_15 + var_220_25 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play322042053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322042053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play322042054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1156ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos1156ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, 100, 0)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1156ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, 100, 0)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = 0.433333333333333
			local var_224_10 = 1

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				local var_224_11 = "play"
				local var_224_12 = "effect"

				arg_221_1:AudioAction(var_224_11, var_224_12, "se_story_145", "se_story_145_rock", "")
			end

			local var_224_13 = manager.ui.mainCamera.transform
			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				local var_224_15 = arg_221_1.var_.effect2043
				local var_224_16
				local var_224_17 = var_224_13

				if not var_224_15 then
					var_224_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_black_in"), var_224_17)
					var_224_15.name = "2043"
					arg_221_1.var_.effect2043 = var_224_15
				else
					var_224_15.transform:SetParent(var_224_17)
				end

				var_224_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_224_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_224_18 = 0
			local var_224_19 = 1.675

			if var_224_18 < arg_221_1.time_ and arg_221_1.time_ <= var_224_18 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_20 = arg_221_1:GetWordFromCfg(322042053)
				local var_224_21 = arg_221_1:FormatText(var_224_20.content)

				arg_221_1.text_.text = var_224_21

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_22 = 67
				local var_224_23 = utf8.len(var_224_21)
				local var_224_24 = var_224_22 <= 0 and var_224_19 or var_224_19 * (var_224_23 / var_224_22)

				if var_224_24 > 0 and var_224_19 < var_224_24 then
					arg_221_1.talkMaxDuration = var_224_24

					if var_224_24 + var_224_18 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_24 + var_224_18
					end
				end

				arg_221_1.text_.text = var_224_21
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_25 = math.max(var_224_19, arg_221_1.talkMaxDuration)

			if var_224_18 <= arg_221_1.time_ and arg_221_1.time_ < var_224_18 + var_224_25 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_18) / var_224_25

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_18 + var_224_25 and arg_221_1.time_ < var_224_18 + var_224_25 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play322042054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 322042054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play322042055(arg_225_1)
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

				local var_228_2 = arg_225_1:GetWordFromCfg(322042054)
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
	Play322042055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 322042055
		arg_229_1.duration_ = 3.1

		local var_229_0 = {
			zh = 2.99966666666667,
			ja = 3.09966666666667
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
				arg_229_0:Play322042056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1284ui_story"].transform
			local var_232_1 = 0.166666666666667

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.var_.moveOldPos1284ui_story = var_232_0.localPosition
			end

			local var_232_2 = 0.001

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2
				local var_232_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_232_0.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1284ui_story, var_232_4, var_232_3)

				local var_232_5 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_5.x, var_232_5.y, var_232_5.z)

				local var_232_6 = var_232_0.localEulerAngles

				var_232_6.z = 0
				var_232_6.x = 0
				var_232_0.localEulerAngles = var_232_6
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 then
				var_232_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_232_7 = manager.ui.mainCamera.transform.position - var_232_0.position

				var_232_0.forward = Vector3.New(var_232_7.x, var_232_7.y, var_232_7.z)

				local var_232_8 = var_232_0.localEulerAngles

				var_232_8.z = 0
				var_232_8.x = 0
				var_232_0.localEulerAngles = var_232_8
			end

			local var_232_9 = arg_229_1.actors_["1284ui_story"]
			local var_232_10 = 0.166666666666667

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect1284ui_story == nil then
				arg_229_1.var_.characterEffect1284ui_story = var_232_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_11 = 0.200000002980232

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_11 and not isNil(var_232_9) then
				local var_232_12 = (arg_229_1.time_ - var_232_10) / var_232_11

				if arg_229_1.var_.characterEffect1284ui_story and not isNil(var_232_9) then
					arg_229_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_10 + var_232_11 and arg_229_1.time_ < var_232_10 + var_232_11 + arg_232_0 and not isNil(var_232_9) and arg_229_1.var_.characterEffect1284ui_story then
				arg_229_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_232_13 = 0.166666666666667

			if var_232_13 < arg_229_1.time_ and arg_229_1.time_ <= var_232_13 + arg_232_0 then
				arg_229_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_232_14 = 0.166666666666667

			if var_232_14 < arg_229_1.time_ and arg_229_1.time_ <= var_232_14 + arg_232_0 then
				arg_229_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_232_15 = manager.ui.mainCamera.transform
			local var_232_16 = 0

			if var_232_16 < arg_229_1.time_ and arg_229_1.time_ <= var_232_16 + arg_232_0 then
				local var_232_17 = arg_229_1.var_.effect2043

				if var_232_17 then
					Object.Destroy(var_232_17)

					arg_229_1.var_.effect2043 = nil
				end
			end

			local var_232_18 = 0

			if var_232_18 < arg_229_1.time_ and arg_229_1.time_ <= var_232_18 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = false

				arg_229_1:SetGaussion(false)
			end

			local var_232_19 = 0.166666666666667

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

			local var_232_23 = 0.166666666666667

			if var_232_23 < arg_229_1.time_ and arg_229_1.time_ <= var_232_23 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = false

				arg_229_1:SetGaussion(false)
			end

			local var_232_24 = 0.166666666666667

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

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_29 = 0.166666666666667
			local var_232_30 = 0.325

			if var_232_29 < arg_229_1.time_ and arg_229_1.time_ <= var_232_29 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_31 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_31:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_32 = arg_229_1:FormatText(StoryNameCfg[6].name)

				arg_229_1.leftNameTxt_.text = var_232_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_33 = arg_229_1:GetWordFromCfg(322042055)
				local var_232_34 = arg_229_1:FormatText(var_232_33.content)

				arg_229_1.text_.text = var_232_34

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_35 = 13
				local var_232_36 = utf8.len(var_232_34)
				local var_232_37 = var_232_35 <= 0 and var_232_30 or var_232_30 * (var_232_36 / var_232_35)

				if var_232_37 > 0 and var_232_30 < var_232_37 then
					arg_229_1.talkMaxDuration = var_232_37
					var_232_29 = var_232_29 + 0.3

					if var_232_37 + var_232_29 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_37 + var_232_29
					end
				end

				arg_229_1.text_.text = var_232_34
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042055", "story_v_out_322042.awb") ~= 0 then
					local var_232_38 = manager.audio:GetVoiceLength("story_v_out_322042", "322042055", "story_v_out_322042.awb") / 1000

					if var_232_38 + var_232_29 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_38 + var_232_29
					end

					if var_232_33.prefab_name ~= "" and arg_229_1.actors_[var_232_33.prefab_name] ~= nil then
						local var_232_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_33.prefab_name].transform, "story_v_out_322042", "322042055", "story_v_out_322042.awb")

						arg_229_1:RecordAudio("322042055", var_232_39)
						arg_229_1:RecordAudio("322042055", var_232_39)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_322042", "322042055", "story_v_out_322042.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_322042", "322042055", "story_v_out_322042.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_40 = var_232_29 + 0.3
			local var_232_41 = math.max(var_232_30, arg_229_1.talkMaxDuration)

			if var_232_40 <= arg_229_1.time_ and arg_229_1.time_ < var_232_40 + var_232_41 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_40) / var_232_41

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_40 + var_232_41 and arg_229_1.time_ < var_232_40 + var_232_41 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play322042056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 322042056
		arg_235_1.duration_ = 7.9

		local var_235_0 = {
			zh = 4.833,
			ja = 7.9
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
				arg_235_0:Play322042057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10104ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos10104ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0.99, -1.12, -5.99)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10104ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0.99, -1.12, -5.99)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = arg_235_1.actors_["10104ui_story"]
			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect10104ui_story == nil then
				arg_235_1.var_.characterEffect10104ui_story = var_238_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_11 = 0.200000002980232

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_11 and not isNil(var_238_9) then
				local var_238_12 = (arg_235_1.time_ - var_238_10) / var_238_11

				if arg_235_1.var_.characterEffect10104ui_story and not isNil(var_238_9) then
					arg_235_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_10 + var_238_11 and arg_235_1.time_ < var_238_10 + var_238_11 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect10104ui_story then
				arg_235_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_238_13 = arg_235_1.actors_["1284ui_story"]
			local var_238_14 = 0

			if var_238_14 < arg_235_1.time_ and arg_235_1.time_ <= var_238_14 + arg_238_0 and not isNil(var_238_13) and arg_235_1.var_.characterEffect1284ui_story == nil then
				arg_235_1.var_.characterEffect1284ui_story = var_238_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_15 = 0.200000002980232

			if var_238_14 <= arg_235_1.time_ and arg_235_1.time_ < var_238_14 + var_238_15 and not isNil(var_238_13) then
				local var_238_16 = (arg_235_1.time_ - var_238_14) / var_238_15

				if arg_235_1.var_.characterEffect1284ui_story and not isNil(var_238_13) then
					local var_238_17 = Mathf.Lerp(0, 0.5, var_238_16)

					arg_235_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1284ui_story.fillRatio = var_238_17
				end
			end

			if arg_235_1.time_ >= var_238_14 + var_238_15 and arg_235_1.time_ < var_238_14 + var_238_15 + arg_238_0 and not isNil(var_238_13) and arg_235_1.var_.characterEffect1284ui_story then
				local var_238_18 = 0.5

				arg_235_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1284ui_story.fillRatio = var_238_18
			end

			local var_238_19 = 0

			if var_238_19 < arg_235_1.time_ and arg_235_1.time_ <= var_238_19 + arg_238_0 then
				arg_235_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_238_20 = 0

			if var_238_20 < arg_235_1.time_ and arg_235_1.time_ <= var_238_20 + arg_238_0 then
				arg_235_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_238_21 = 0
			local var_238_22 = 0.5

			if var_238_21 < arg_235_1.time_ and arg_235_1.time_ <= var_238_21 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_23 = arg_235_1:FormatText(StoryNameCfg[1030].name)

				arg_235_1.leftNameTxt_.text = var_238_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_24 = arg_235_1:GetWordFromCfg(322042056)
				local var_238_25 = arg_235_1:FormatText(var_238_24.content)

				arg_235_1.text_.text = var_238_25

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_26 = 20
				local var_238_27 = utf8.len(var_238_25)
				local var_238_28 = var_238_26 <= 0 and var_238_22 or var_238_22 * (var_238_27 / var_238_26)

				if var_238_28 > 0 and var_238_22 < var_238_28 then
					arg_235_1.talkMaxDuration = var_238_28

					if var_238_28 + var_238_21 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_28 + var_238_21
					end
				end

				arg_235_1.text_.text = var_238_25
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042056", "story_v_out_322042.awb") ~= 0 then
					local var_238_29 = manager.audio:GetVoiceLength("story_v_out_322042", "322042056", "story_v_out_322042.awb") / 1000

					if var_238_29 + var_238_21 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_29 + var_238_21
					end

					if var_238_24.prefab_name ~= "" and arg_235_1.actors_[var_238_24.prefab_name] ~= nil then
						local var_238_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_24.prefab_name].transform, "story_v_out_322042", "322042056", "story_v_out_322042.awb")

						arg_235_1:RecordAudio("322042056", var_238_30)
						arg_235_1:RecordAudio("322042056", var_238_30)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_322042", "322042056", "story_v_out_322042.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_322042", "322042056", "story_v_out_322042.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_31 = math.max(var_238_22, arg_235_1.talkMaxDuration)

			if var_238_21 <= arg_235_1.time_ and arg_235_1.time_ < var_238_21 + var_238_31 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_21) / var_238_31

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_21 + var_238_31 and arg_235_1.time_ < var_238_21 + var_238_31 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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

		arg_235_1:InitPlayNodeList()
	end,
	Play322042057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 322042057
		arg_239_1.duration_ = 2.73

		local var_239_0 = {
			zh = 2.066,
			ja = 2.733
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
				arg_239_0:Play322042058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1156ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1156ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, -1.1, -6.18)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1156ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["10104ui_story"].transform
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 then
				arg_239_1.var_.moveOldPos10104ui_story = var_242_9.localPosition
			end

			local var_242_11 = 0.001

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11
				local var_242_13 = Vector3.New(0, 100, 0)

				var_242_9.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10104ui_story, var_242_13, var_242_12)

				local var_242_14 = manager.ui.mainCamera.transform.position - var_242_9.position

				var_242_9.forward = Vector3.New(var_242_14.x, var_242_14.y, var_242_14.z)

				local var_242_15 = var_242_9.localEulerAngles

				var_242_15.z = 0
				var_242_15.x = 0
				var_242_9.localEulerAngles = var_242_15
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 then
				var_242_9.localPosition = Vector3.New(0, 100, 0)

				local var_242_16 = manager.ui.mainCamera.transform.position - var_242_9.position

				var_242_9.forward = Vector3.New(var_242_16.x, var_242_16.y, var_242_16.z)

				local var_242_17 = var_242_9.localEulerAngles

				var_242_17.z = 0
				var_242_17.x = 0
				var_242_9.localEulerAngles = var_242_17
			end

			local var_242_18 = arg_239_1.actors_["1284ui_story"].transform
			local var_242_19 = 0

			if var_242_19 < arg_239_1.time_ and arg_239_1.time_ <= var_242_19 + arg_242_0 then
				arg_239_1.var_.moveOldPos1284ui_story = var_242_18.localPosition
			end

			local var_242_20 = 0.001

			if var_242_19 <= arg_239_1.time_ and arg_239_1.time_ < var_242_19 + var_242_20 then
				local var_242_21 = (arg_239_1.time_ - var_242_19) / var_242_20
				local var_242_22 = Vector3.New(0, 100, 0)

				var_242_18.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1284ui_story, var_242_22, var_242_21)

				local var_242_23 = manager.ui.mainCamera.transform.position - var_242_18.position

				var_242_18.forward = Vector3.New(var_242_23.x, var_242_23.y, var_242_23.z)

				local var_242_24 = var_242_18.localEulerAngles

				var_242_24.z = 0
				var_242_24.x = 0
				var_242_18.localEulerAngles = var_242_24
			end

			if arg_239_1.time_ >= var_242_19 + var_242_20 and arg_239_1.time_ < var_242_19 + var_242_20 + arg_242_0 then
				var_242_18.localPosition = Vector3.New(0, 100, 0)

				local var_242_25 = manager.ui.mainCamera.transform.position - var_242_18.position

				var_242_18.forward = Vector3.New(var_242_25.x, var_242_25.y, var_242_25.z)

				local var_242_26 = var_242_18.localEulerAngles

				var_242_26.z = 0
				var_242_26.x = 0
				var_242_18.localEulerAngles = var_242_26
			end

			local var_242_27 = arg_239_1.actors_["1156ui_story"]
			local var_242_28 = 0

			if var_242_28 < arg_239_1.time_ and arg_239_1.time_ <= var_242_28 + arg_242_0 and not isNil(var_242_27) and arg_239_1.var_.characterEffect1156ui_story == nil then
				arg_239_1.var_.characterEffect1156ui_story = var_242_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_29 = 0.200000002980232

			if var_242_28 <= arg_239_1.time_ and arg_239_1.time_ < var_242_28 + var_242_29 and not isNil(var_242_27) then
				local var_242_30 = (arg_239_1.time_ - var_242_28) / var_242_29

				if arg_239_1.var_.characterEffect1156ui_story and not isNil(var_242_27) then
					arg_239_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_28 + var_242_29 and arg_239_1.time_ < var_242_28 + var_242_29 + arg_242_0 and not isNil(var_242_27) and arg_239_1.var_.characterEffect1156ui_story then
				arg_239_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_242_31 = arg_239_1.actors_["10104ui_story"]
			local var_242_32 = 0

			if var_242_32 < arg_239_1.time_ and arg_239_1.time_ <= var_242_32 + arg_242_0 and not isNil(var_242_31) and arg_239_1.var_.characterEffect10104ui_story == nil then
				arg_239_1.var_.characterEffect10104ui_story = var_242_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_33 = 0.200000002980232

			if var_242_32 <= arg_239_1.time_ and arg_239_1.time_ < var_242_32 + var_242_33 and not isNil(var_242_31) then
				local var_242_34 = (arg_239_1.time_ - var_242_32) / var_242_33

				if arg_239_1.var_.characterEffect10104ui_story and not isNil(var_242_31) then
					local var_242_35 = Mathf.Lerp(0, 0.5, var_242_34)

					arg_239_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10104ui_story.fillRatio = var_242_35
				end
			end

			if arg_239_1.time_ >= var_242_32 + var_242_33 and arg_239_1.time_ < var_242_32 + var_242_33 + arg_242_0 and not isNil(var_242_31) and arg_239_1.var_.characterEffect10104ui_story then
				local var_242_36 = 0.5

				arg_239_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10104ui_story.fillRatio = var_242_36
			end

			local var_242_37 = 0

			if var_242_37 < arg_239_1.time_ and arg_239_1.time_ <= var_242_37 + arg_242_0 then
				arg_239_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			local var_242_38 = 0

			if var_242_38 < arg_239_1.time_ and arg_239_1.time_ <= var_242_38 + arg_242_0 then
				arg_239_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_242_39 = 0
			local var_242_40 = 0.275

			if var_242_39 < arg_239_1.time_ and arg_239_1.time_ <= var_242_39 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_41 = arg_239_1:FormatText(StoryNameCfg[605].name)

				arg_239_1.leftNameTxt_.text = var_242_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_42 = arg_239_1:GetWordFromCfg(322042057)
				local var_242_43 = arg_239_1:FormatText(var_242_42.content)

				arg_239_1.text_.text = var_242_43

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_44 = 11
				local var_242_45 = utf8.len(var_242_43)
				local var_242_46 = var_242_44 <= 0 and var_242_40 or var_242_40 * (var_242_45 / var_242_44)

				if var_242_46 > 0 and var_242_40 < var_242_46 then
					arg_239_1.talkMaxDuration = var_242_46

					if var_242_46 + var_242_39 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_46 + var_242_39
					end
				end

				arg_239_1.text_.text = var_242_43
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042057", "story_v_out_322042.awb") ~= 0 then
					local var_242_47 = manager.audio:GetVoiceLength("story_v_out_322042", "322042057", "story_v_out_322042.awb") / 1000

					if var_242_47 + var_242_39 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_47 + var_242_39
					end

					if var_242_42.prefab_name ~= "" and arg_239_1.actors_[var_242_42.prefab_name] ~= nil then
						local var_242_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_42.prefab_name].transform, "story_v_out_322042", "322042057", "story_v_out_322042.awb")

						arg_239_1:RecordAudio("322042057", var_242_48)
						arg_239_1:RecordAudio("322042057", var_242_48)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_322042", "322042057", "story_v_out_322042.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_322042", "322042057", "story_v_out_322042.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_49 = math.max(var_242_40, arg_239_1.talkMaxDuration)

			if var_242_39 <= arg_239_1.time_ and arg_239_1.time_ < var_242_39 + var_242_49 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_39) / var_242_49

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_39 + var_242_49 and arg_239_1.time_ < var_242_39 + var_242_49 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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

		arg_239_1:InitPlayNodeList()
	end,
	Play322042058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 322042058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play322042059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.3
			local var_246_1 = 1

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				local var_246_2 = "play"
				local var_246_3 = "effect"

				arg_243_1:AudioAction(var_246_2, var_246_3, "se_story_145", "se_story_145_fire01", "")
			end

			local var_246_4 = arg_243_1.actors_["1156ui_story"].transform
			local var_246_5 = 0

			if var_246_5 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.var_.moveOldPos1156ui_story = var_246_4.localPosition
			end

			local var_246_6 = 0.001

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_6 then
				local var_246_7 = (arg_243_1.time_ - var_246_5) / var_246_6
				local var_246_8 = Vector3.New(0, 100, 0)

				var_246_4.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1156ui_story, var_246_8, var_246_7)

				local var_246_9 = manager.ui.mainCamera.transform.position - var_246_4.position

				var_246_4.forward = Vector3.New(var_246_9.x, var_246_9.y, var_246_9.z)

				local var_246_10 = var_246_4.localEulerAngles

				var_246_10.z = 0
				var_246_10.x = 0
				var_246_4.localEulerAngles = var_246_10
			end

			if arg_243_1.time_ >= var_246_5 + var_246_6 and arg_243_1.time_ < var_246_5 + var_246_6 + arg_246_0 then
				var_246_4.localPosition = Vector3.New(0, 100, 0)

				local var_246_11 = manager.ui.mainCamera.transform.position - var_246_4.position

				var_246_4.forward = Vector3.New(var_246_11.x, var_246_11.y, var_246_11.z)

				local var_246_12 = var_246_4.localEulerAngles

				var_246_12.z = 0
				var_246_12.x = 0
				var_246_4.localEulerAngles = var_246_12
			end

			local var_246_13 = 0
			local var_246_14 = 1.45

			if var_246_13 < arg_243_1.time_ and arg_243_1.time_ <= var_246_13 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_15 = arg_243_1:GetWordFromCfg(322042058)
				local var_246_16 = arg_243_1:FormatText(var_246_15.content)

				arg_243_1.text_.text = var_246_16

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_17 = 58
				local var_246_18 = utf8.len(var_246_16)
				local var_246_19 = var_246_17 <= 0 and var_246_14 or var_246_14 * (var_246_18 / var_246_17)

				if var_246_19 > 0 and var_246_14 < var_246_19 then
					arg_243_1.talkMaxDuration = var_246_19

					if var_246_19 + var_246_13 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_19 + var_246_13
					end
				end

				arg_243_1.text_.text = var_246_16
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_20 = math.max(var_246_14, arg_243_1.talkMaxDuration)

			if var_246_13 <= arg_243_1.time_ and arg_243_1.time_ < var_246_13 + var_246_20 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_13) / var_246_20

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_13 + var_246_20 and arg_243_1.time_ < var_246_13 + var_246_20 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play322042059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 322042059
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play322042060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 1.1

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:GetWordFromCfg(322042059)
				local var_250_3 = arg_247_1:FormatText(var_250_2.content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 44
				local var_250_5 = utf8.len(var_250_3)
				local var_250_6 = var_250_4 <= 0 and var_250_1 or var_250_1 * (var_250_5 / var_250_4)

				if var_250_6 > 0 and var_250_1 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_7 and arg_247_1.time_ < var_250_0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play322042060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 322042060
		arg_251_1.duration_ = 5.1

		local var_251_0 = {
			zh = 4.866,
			ja = 5.1
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
				arg_251_0:Play322042061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.475

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[1361].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10150")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(322042060)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042060", "story_v_out_322042.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_322042", "322042060", "story_v_out_322042.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_322042", "322042060", "story_v_out_322042.awb")

						arg_251_1:RecordAudio("322042060", var_254_9)
						arg_251_1:RecordAudio("322042060", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_322042", "322042060", "story_v_out_322042.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_322042", "322042060", "story_v_out_322042.awb")
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
	Play322042061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 322042061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play322042062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.225
			local var_258_1 = 1

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				local var_258_2 = "play"
				local var_258_3 = "effect"

				arg_255_1:AudioAction(var_258_2, var_258_3, "se_story_145", "se_story_145_firework", "")
			end

			local var_258_4 = manager.ui.mainCamera.transform
			local var_258_5 = 0.225

			if var_258_5 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.var_.shakeOldPos = var_258_4.localPosition
			end

			local var_258_6 = 0.508333333333333

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_6 then
				local var_258_7 = (arg_255_1.time_ - var_258_5) / 0.132
				local var_258_8, var_258_9 = math.modf(var_258_7)

				var_258_4.localPosition = Vector3.New(var_258_9 * 0.13, var_258_9 * 0.13, var_258_9 * 0.13) + arg_255_1.var_.shakeOldPos
			end

			if arg_255_1.time_ >= var_258_5 + var_258_6 and arg_255_1.time_ < var_258_5 + var_258_6 + arg_258_0 then
				var_258_4.localPosition = arg_255_1.var_.shakeOldPos
			end

			local var_258_10 = manager.ui.mainCamera.transform
			local var_258_11 = 0

			if var_258_11 < arg_255_1.time_ and arg_255_1.time_ <= var_258_11 + arg_258_0 then
				local var_258_12 = arg_255_1.var_.effect2062
				local var_258_13
				local var_258_14 = var_258_10

				if not var_258_12 then
					var_258_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_keep"), var_258_14)
					var_258_12.name = "2062"
					arg_255_1.var_.effect2062 = var_258_12
				else
					var_258_12.transform:SetParent(var_258_14)
				end

				var_258_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_258_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_258_15 = 0
			local var_258_16 = 1.225

			if var_258_15 < arg_255_1.time_ and arg_255_1.time_ <= var_258_15 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_17 = arg_255_1:GetWordFromCfg(322042061)
				local var_258_18 = arg_255_1:FormatText(var_258_17.content)

				arg_255_1.text_.text = var_258_18

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_19 = 49
				local var_258_20 = utf8.len(var_258_18)
				local var_258_21 = var_258_19 <= 0 and var_258_16 or var_258_16 * (var_258_20 / var_258_19)

				if var_258_21 > 0 and var_258_16 < var_258_21 then
					arg_255_1.talkMaxDuration = var_258_21

					if var_258_21 + var_258_15 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_21 + var_258_15
					end
				end

				arg_255_1.text_.text = var_258_18
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_22 = math.max(var_258_16, arg_255_1.talkMaxDuration)

			if var_258_15 <= arg_255_1.time_ and arg_255_1.time_ < var_258_15 + var_258_22 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_15) / var_258_22

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_15 + var_258_22 and arg_255_1.time_ < var_258_15 + var_258_22 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play322042062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 322042062
		arg_259_1.duration_ = 6.33

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play322042063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.333333333333333
			local var_262_1 = 1

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				local var_262_2 = "play"
				local var_262_3 = "effect"

				arg_259_1:AudioAction(var_262_2, var_262_3, "se_story_145", "se_story_145_fall", "")
			end

			local var_262_4 = 0
			local var_262_5 = 1

			if var_262_4 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				local var_262_6 = "play"
				local var_262_7 = "effect"

				arg_259_1:AudioAction(var_262_6, var_262_7, "se_story_123_02", "se_story_123_02_fire", "")
			end

			local var_262_8 = manager.ui.mainCamera.transform
			local var_262_9 = 0

			if var_262_9 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 then
				local var_262_10 = arg_259_1.var_.effect2062
				local var_262_11
				local var_262_12 = var_262_8

				if not var_262_10 then
					var_262_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), var_262_12)
					var_262_10.name = "2062"
					arg_259_1.var_.effect2062 = var_262_10
				else
					var_262_10.transform:SetParent(var_262_12)
				end

				var_262_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_262_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_262_13 = manager.ui.mainCamera.transform
			local var_262_14 = 0

			if var_262_14 < arg_259_1.time_ and arg_259_1.time_ <= var_262_14 + arg_262_0 then
				arg_259_1.var_.shakeOldPos = var_262_13.localPosition
			end

			local var_262_15 = 0.866666666666667

			if var_262_14 <= arg_259_1.time_ and arg_259_1.time_ < var_262_14 + var_262_15 then
				local var_262_16 = (arg_259_1.time_ - var_262_14) / 0.066
				local var_262_17, var_262_18 = math.modf(var_262_16)

				var_262_13.localPosition = Vector3.New(var_262_18 * 0.13, var_262_18 * 0.13, var_262_18 * 0.13) + arg_259_1.var_.shakeOldPos
			end

			if arg_259_1.time_ >= var_262_14 + var_262_15 and arg_259_1.time_ < var_262_14 + var_262_15 + arg_262_0 then
				var_262_13.localPosition = arg_259_1.var_.shakeOldPos
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_19 = 1.33333333333333
			local var_262_20 = 1.15

			if var_262_19 < arg_259_1.time_ and arg_259_1.time_ <= var_262_19 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_21 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_21:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_22 = arg_259_1:GetWordFromCfg(322042062)
				local var_262_23 = arg_259_1:FormatText(var_262_22.content)

				arg_259_1.text_.text = var_262_23

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_24 = 46
				local var_262_25 = utf8.len(var_262_23)
				local var_262_26 = var_262_24 <= 0 and var_262_20 or var_262_20 * (var_262_25 / var_262_24)

				if var_262_26 > 0 and var_262_20 < var_262_26 then
					arg_259_1.talkMaxDuration = var_262_26
					var_262_19 = var_262_19 + 0.3

					if var_262_26 + var_262_19 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_26 + var_262_19
					end
				end

				arg_259_1.text_.text = var_262_23
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_27 = var_262_19 + 0.3
			local var_262_28 = math.max(var_262_20, arg_259_1.talkMaxDuration)

			if var_262_27 <= arg_259_1.time_ and arg_259_1.time_ < var_262_27 + var_262_28 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_27) / var_262_28

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_27 + var_262_28 and arg_259_1.time_ < var_262_27 + var_262_28 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play322042063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322042063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play322042064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = manager.ui.mainCamera.transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				local var_268_2 = arg_265_1.var_.effect2062

				if var_268_2 then
					Object.Destroy(var_268_2)

					arg_265_1.var_.effect2062 = nil
				end
			end

			local var_268_3 = manager.ui.mainCamera.transform
			local var_268_4 = 0

			if var_268_4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				local var_268_5 = arg_265_1.var_.effect2063
				local var_268_6
				local var_268_7 = var_268_3

				if not var_268_5 then
					var_268_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), var_268_7)
					var_268_5.name = "2063"
					arg_265_1.var_.effect2063 = var_268_5
				else
					var_268_5.transform:SetParent(var_268_7)
				end

				var_268_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_268_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_268_8 = 0
			local var_268_9 = 1

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				local var_268_10 = "play"
				local var_268_11 = "effect"

				arg_265_1:AudioAction(var_268_10, var_268_11, "se_story_145", "se_story_145_fire01", "")
			end

			local var_268_12 = 0
			local var_268_13 = 1.25

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_14 = arg_265_1:GetWordFromCfg(322042063)
				local var_268_15 = arg_265_1:FormatText(var_268_14.content)

				arg_265_1.text_.text = var_268_15

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_16 = 50
				local var_268_17 = utf8.len(var_268_15)
				local var_268_18 = var_268_16 <= 0 and var_268_13 or var_268_13 * (var_268_17 / var_268_16)

				if var_268_18 > 0 and var_268_13 < var_268_18 then
					arg_265_1.talkMaxDuration = var_268_18

					if var_268_18 + var_268_12 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_18 + var_268_12
					end
				end

				arg_265_1.text_.text = var_268_15
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_19 = math.max(var_268_13, arg_265_1.talkMaxDuration)

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_19 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_12) / var_268_19

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_12 + var_268_19 and arg_265_1.time_ < var_268_12 + var_268_19 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play322042064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322042064
		arg_269_1.duration_ = 3.9

		local var_269_0 = {
			zh = 2.666,
			ja = 3.9
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
				arg_269_0:Play322042065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1156ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1156ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1156ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1156ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1156ui_story == nil then
				arg_269_1.var_.characterEffect1156ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1156ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1156ui_story then
				arg_269_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_272_13 = 0

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action2_1")
			end

			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 then
				arg_269_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_15 = 0
			local var_272_16 = 0.275

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_17 = arg_269_1:FormatText(StoryNameCfg[605].name)

				arg_269_1.leftNameTxt_.text = var_272_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_18 = arg_269_1:GetWordFromCfg(322042064)
				local var_272_19 = arg_269_1:FormatText(var_272_18.content)

				arg_269_1.text_.text = var_272_19

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_20 = 11
				local var_272_21 = utf8.len(var_272_19)
				local var_272_22 = var_272_20 <= 0 and var_272_16 or var_272_16 * (var_272_21 / var_272_20)

				if var_272_22 > 0 and var_272_16 < var_272_22 then
					arg_269_1.talkMaxDuration = var_272_22

					if var_272_22 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_22 + var_272_15
					end
				end

				arg_269_1.text_.text = var_272_19
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042064", "story_v_out_322042.awb") ~= 0 then
					local var_272_23 = manager.audio:GetVoiceLength("story_v_out_322042", "322042064", "story_v_out_322042.awb") / 1000

					if var_272_23 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_15
					end

					if var_272_18.prefab_name ~= "" and arg_269_1.actors_[var_272_18.prefab_name] ~= nil then
						local var_272_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_18.prefab_name].transform, "story_v_out_322042", "322042064", "story_v_out_322042.awb")

						arg_269_1:RecordAudio("322042064", var_272_24)
						arg_269_1:RecordAudio("322042064", var_272_24)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322042", "322042064", "story_v_out_322042.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322042", "322042064", "story_v_out_322042.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_25 = math.max(var_272_16, arg_269_1.talkMaxDuration)

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_15) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_15 + var_272_25 and arg_269_1.time_ < var_272_15 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play322042065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322042065
		arg_273_1.duration_ = 7.97

		local var_273_0 = {
			zh = 7.1,
			ja = 7.966
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
				arg_273_0:Play322042066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1284ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1284ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0.7, -0.985, -6.22)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1284ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = arg_273_1.actors_["1284ui_story"]
			local var_276_10 = 0

			if var_276_10 < arg_273_1.time_ and arg_273_1.time_ <= var_276_10 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1284ui_story == nil then
				arg_273_1.var_.characterEffect1284ui_story = var_276_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_11 = 0.200000002980232

			if var_276_10 <= arg_273_1.time_ and arg_273_1.time_ < var_276_10 + var_276_11 and not isNil(var_276_9) then
				local var_276_12 = (arg_273_1.time_ - var_276_10) / var_276_11

				if arg_273_1.var_.characterEffect1284ui_story and not isNil(var_276_9) then
					arg_273_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_10 + var_276_11 and arg_273_1.time_ < var_276_10 + var_276_11 + arg_276_0 and not isNil(var_276_9) and arg_273_1.var_.characterEffect1284ui_story then
				arg_273_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_276_13 = arg_273_1.actors_["1156ui_story"]
			local var_276_14 = 0

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 and not isNil(var_276_13) and arg_273_1.var_.characterEffect1156ui_story == nil then
				arg_273_1.var_.characterEffect1156ui_story = var_276_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_15 = 0.200000002980232

			if var_276_14 <= arg_273_1.time_ and arg_273_1.time_ < var_276_14 + var_276_15 and not isNil(var_276_13) then
				local var_276_16 = (arg_273_1.time_ - var_276_14) / var_276_15

				if arg_273_1.var_.characterEffect1156ui_story and not isNil(var_276_13) then
					local var_276_17 = Mathf.Lerp(0, 0.5, var_276_16)

					arg_273_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1156ui_story.fillRatio = var_276_17
				end
			end

			if arg_273_1.time_ >= var_276_14 + var_276_15 and arg_273_1.time_ < var_276_14 + var_276_15 + arg_276_0 and not isNil(var_276_13) and arg_273_1.var_.characterEffect1156ui_story then
				local var_276_18 = 0.5

				arg_273_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1156ui_story.fillRatio = var_276_18
			end

			local var_276_19 = 0

			if var_276_19 < arg_273_1.time_ and arg_273_1.time_ <= var_276_19 + arg_276_0 then
				arg_273_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_276_20 = 0

			if var_276_20 < arg_273_1.time_ and arg_273_1.time_ <= var_276_20 + arg_276_0 then
				arg_273_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_276_21 = 0
			local var_276_22 = 0.925

			if var_276_21 < arg_273_1.time_ and arg_273_1.time_ <= var_276_21 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_23 = arg_273_1:FormatText(StoryNameCfg[6].name)

				arg_273_1.leftNameTxt_.text = var_276_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_24 = arg_273_1:GetWordFromCfg(322042065)
				local var_276_25 = arg_273_1:FormatText(var_276_24.content)

				arg_273_1.text_.text = var_276_25

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_26 = 37
				local var_276_27 = utf8.len(var_276_25)
				local var_276_28 = var_276_26 <= 0 and var_276_22 or var_276_22 * (var_276_27 / var_276_26)

				if var_276_28 > 0 and var_276_22 < var_276_28 then
					arg_273_1.talkMaxDuration = var_276_28

					if var_276_28 + var_276_21 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_28 + var_276_21
					end
				end

				arg_273_1.text_.text = var_276_25
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042065", "story_v_out_322042.awb") ~= 0 then
					local var_276_29 = manager.audio:GetVoiceLength("story_v_out_322042", "322042065", "story_v_out_322042.awb") / 1000

					if var_276_29 + var_276_21 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_29 + var_276_21
					end

					if var_276_24.prefab_name ~= "" and arg_273_1.actors_[var_276_24.prefab_name] ~= nil then
						local var_276_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_24.prefab_name].transform, "story_v_out_322042", "322042065", "story_v_out_322042.awb")

						arg_273_1:RecordAudio("322042065", var_276_30)
						arg_273_1:RecordAudio("322042065", var_276_30)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322042", "322042065", "story_v_out_322042.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322042", "322042065", "story_v_out_322042.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_31 = math.max(var_276_22, arg_273_1.talkMaxDuration)

			if var_276_21 <= arg_273_1.time_ and arg_273_1.time_ < var_276_21 + var_276_31 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_21) / var_276_31

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_21 + var_276_31 and arg_273_1.time_ < var_276_21 + var_276_31 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play322042066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322042066
		arg_277_1.duration_ = 2

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322042067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10104ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos10104ui_story = var_280_0.localPosition
			end

			local var_280_2 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2
				local var_280_4 = Vector3.New(-0.88, -1.12, -5.99)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10104ui_story, var_280_4, var_280_3)

				local var_280_5 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_5.x, var_280_5.y, var_280_5.z)

				local var_280_6 = var_280_0.localEulerAngles

				var_280_6.z = 0
				var_280_6.x = 0
				var_280_0.localEulerAngles = var_280_6
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_280_7 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_7.x, var_280_7.y, var_280_7.z)

				local var_280_8 = var_280_0.localEulerAngles

				var_280_8.z = 0
				var_280_8.x = 0
				var_280_0.localEulerAngles = var_280_8
			end

			local var_280_9 = arg_277_1.actors_["1156ui_story"].transform
			local var_280_10 = 0

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 then
				arg_277_1.var_.moveOldPos1156ui_story = var_280_9.localPosition
			end

			local var_280_11 = 0.001

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_11 then
				local var_280_12 = (arg_277_1.time_ - var_280_10) / var_280_11
				local var_280_13 = Vector3.New(0, 100, 0)

				var_280_9.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1156ui_story, var_280_13, var_280_12)

				local var_280_14 = manager.ui.mainCamera.transform.position - var_280_9.position

				var_280_9.forward = Vector3.New(var_280_14.x, var_280_14.y, var_280_14.z)

				local var_280_15 = var_280_9.localEulerAngles

				var_280_15.z = 0
				var_280_15.x = 0
				var_280_9.localEulerAngles = var_280_15
			end

			if arg_277_1.time_ >= var_280_10 + var_280_11 and arg_277_1.time_ < var_280_10 + var_280_11 + arg_280_0 then
				var_280_9.localPosition = Vector3.New(0, 100, 0)

				local var_280_16 = manager.ui.mainCamera.transform.position - var_280_9.position

				var_280_9.forward = Vector3.New(var_280_16.x, var_280_16.y, var_280_16.z)

				local var_280_17 = var_280_9.localEulerAngles

				var_280_17.z = 0
				var_280_17.x = 0
				var_280_9.localEulerAngles = var_280_17
			end

			local var_280_18 = arg_277_1.actors_["10104ui_story"]
			local var_280_19 = 0

			if var_280_19 < arg_277_1.time_ and arg_277_1.time_ <= var_280_19 + arg_280_0 and not isNil(var_280_18) and arg_277_1.var_.characterEffect10104ui_story == nil then
				arg_277_1.var_.characterEffect10104ui_story = var_280_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_20 = 0.200000002980232

			if var_280_19 <= arg_277_1.time_ and arg_277_1.time_ < var_280_19 + var_280_20 and not isNil(var_280_18) then
				local var_280_21 = (arg_277_1.time_ - var_280_19) / var_280_20

				if arg_277_1.var_.characterEffect10104ui_story and not isNil(var_280_18) then
					arg_277_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_19 + var_280_20 and arg_277_1.time_ < var_280_19 + var_280_20 + arg_280_0 and not isNil(var_280_18) and arg_277_1.var_.characterEffect10104ui_story then
				arg_277_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_280_22 = arg_277_1.actors_["1284ui_story"]
			local var_280_23 = 0

			if var_280_23 < arg_277_1.time_ and arg_277_1.time_ <= var_280_23 + arg_280_0 and not isNil(var_280_22) and arg_277_1.var_.characterEffect1284ui_story == nil then
				arg_277_1.var_.characterEffect1284ui_story = var_280_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_24 = 0.200000002980232

			if var_280_23 <= arg_277_1.time_ and arg_277_1.time_ < var_280_23 + var_280_24 and not isNil(var_280_22) then
				local var_280_25 = (arg_277_1.time_ - var_280_23) / var_280_24

				if arg_277_1.var_.characterEffect1284ui_story and not isNil(var_280_22) then
					local var_280_26 = Mathf.Lerp(0, 0.5, var_280_25)

					arg_277_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1284ui_story.fillRatio = var_280_26
				end
			end

			if arg_277_1.time_ >= var_280_23 + var_280_24 and arg_277_1.time_ < var_280_23 + var_280_24 + arg_280_0 and not isNil(var_280_22) and arg_277_1.var_.characterEffect1284ui_story then
				local var_280_27 = 0.5

				arg_277_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1284ui_story.fillRatio = var_280_27
			end

			local var_280_28 = 0

			if var_280_28 < arg_277_1.time_ and arg_277_1.time_ <= var_280_28 + arg_280_0 then
				arg_277_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action7_1")
			end

			local var_280_29 = 0

			if var_280_29 < arg_277_1.time_ and arg_277_1.time_ <= var_280_29 + arg_280_0 then
				arg_277_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_30 = 0
			local var_280_31 = 0.1

			if var_280_30 < arg_277_1.time_ and arg_277_1.time_ <= var_280_30 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_32 = arg_277_1:FormatText(StoryNameCfg[1030].name)

				arg_277_1.leftNameTxt_.text = var_280_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_33 = arg_277_1:GetWordFromCfg(322042066)
				local var_280_34 = arg_277_1:FormatText(var_280_33.content)

				arg_277_1.text_.text = var_280_34

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_35 = 4
				local var_280_36 = utf8.len(var_280_34)
				local var_280_37 = var_280_35 <= 0 and var_280_31 or var_280_31 * (var_280_36 / var_280_35)

				if var_280_37 > 0 and var_280_31 < var_280_37 then
					arg_277_1.talkMaxDuration = var_280_37

					if var_280_37 + var_280_30 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_37 + var_280_30
					end
				end

				arg_277_1.text_.text = var_280_34
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042066", "story_v_out_322042.awb") ~= 0 then
					local var_280_38 = manager.audio:GetVoiceLength("story_v_out_322042", "322042066", "story_v_out_322042.awb") / 1000

					if var_280_38 + var_280_30 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_38 + var_280_30
					end

					if var_280_33.prefab_name ~= "" and arg_277_1.actors_[var_280_33.prefab_name] ~= nil then
						local var_280_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_33.prefab_name].transform, "story_v_out_322042", "322042066", "story_v_out_322042.awb")

						arg_277_1:RecordAudio("322042066", var_280_39)
						arg_277_1:RecordAudio("322042066", var_280_39)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322042", "322042066", "story_v_out_322042.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322042", "322042066", "story_v_out_322042.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_40 = math.max(var_280_31, arg_277_1.talkMaxDuration)

			if var_280_30 <= arg_277_1.time_ and arg_277_1.time_ < var_280_30 + var_280_40 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_30) / var_280_40

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_30 + var_280_40 and arg_277_1.time_ < var_280_30 + var_280_40 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
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
	Play322042067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322042067
		arg_281_1.duration_ = 2

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322042068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1284ui_story"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1284ui_story == nil then
				arg_281_1.var_.characterEffect1284ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.characterEffect1284ui_story and not isNil(var_284_0) then
					arg_281_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1284ui_story then
				arg_281_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_284_4 = arg_281_1.actors_["10104ui_story"]
			local var_284_5 = 0

			if var_284_5 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 and not isNil(var_284_4) and arg_281_1.var_.characterEffect10104ui_story == nil then
				arg_281_1.var_.characterEffect10104ui_story = var_284_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_6 = 0.200000002980232

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_6 and not isNil(var_284_4) then
				local var_284_7 = (arg_281_1.time_ - var_284_5) / var_284_6

				if arg_281_1.var_.characterEffect10104ui_story and not isNil(var_284_4) then
					local var_284_8 = Mathf.Lerp(0, 0.5, var_284_7)

					arg_281_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10104ui_story.fillRatio = var_284_8
				end
			end

			if arg_281_1.time_ >= var_284_5 + var_284_6 and arg_281_1.time_ < var_284_5 + var_284_6 + arg_284_0 and not isNil(var_284_4) and arg_281_1.var_.characterEffect10104ui_story then
				local var_284_9 = 0.5

				arg_281_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10104ui_story.fillRatio = var_284_9
			end

			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			local var_284_11 = 0

			if var_284_11 < arg_281_1.time_ and arg_281_1.time_ <= var_284_11 + arg_284_0 then
				arg_281_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_284_12 = 0
			local var_284_13 = 0.05

			if var_284_12 < arg_281_1.time_ and arg_281_1.time_ <= var_284_12 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_14 = arg_281_1:FormatText(StoryNameCfg[6].name)

				arg_281_1.leftNameTxt_.text = var_284_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_15 = arg_281_1:GetWordFromCfg(322042067)
				local var_284_16 = arg_281_1:FormatText(var_284_15.content)

				arg_281_1.text_.text = var_284_16

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_17 = 2
				local var_284_18 = utf8.len(var_284_16)
				local var_284_19 = var_284_17 <= 0 and var_284_13 or var_284_13 * (var_284_18 / var_284_17)

				if var_284_19 > 0 and var_284_13 < var_284_19 then
					arg_281_1.talkMaxDuration = var_284_19

					if var_284_19 + var_284_12 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_19 + var_284_12
					end
				end

				arg_281_1.text_.text = var_284_16
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042067", "story_v_out_322042.awb") ~= 0 then
					local var_284_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042067", "story_v_out_322042.awb") / 1000

					if var_284_20 + var_284_12 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_20 + var_284_12
					end

					if var_284_15.prefab_name ~= "" and arg_281_1.actors_[var_284_15.prefab_name] ~= nil then
						local var_284_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_15.prefab_name].transform, "story_v_out_322042", "322042067", "story_v_out_322042.awb")

						arg_281_1:RecordAudio("322042067", var_284_21)
						arg_281_1:RecordAudio("322042067", var_284_21)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322042", "322042067", "story_v_out_322042.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322042", "322042067", "story_v_out_322042.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_22 = math.max(var_284_13, arg_281_1.talkMaxDuration)

			if var_284_12 <= arg_281_1.time_ and arg_281_1.time_ < var_284_12 + var_284_22 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_12) / var_284_22

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_12 + var_284_22 and arg_281_1.time_ < var_284_12 + var_284_22 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322042068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322042068
		arg_285_1.duration_ = 5.57

		local var_285_0 = {
			zh = 4.066,
			ja = 5.566
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
				arg_285_0:Play322042069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10104ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect10104ui_story == nil then
				arg_285_1.var_.characterEffect10104ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect10104ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect10104ui_story then
				arg_285_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_288_4 = arg_285_1.actors_["1284ui_story"]
			local var_288_5 = 0

			if var_288_5 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect1284ui_story == nil then
				arg_285_1.var_.characterEffect1284ui_story = var_288_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.200000002980232

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_6 and not isNil(var_288_4) then
				local var_288_7 = (arg_285_1.time_ - var_288_5) / var_288_6

				if arg_285_1.var_.characterEffect1284ui_story and not isNil(var_288_4) then
					local var_288_8 = Mathf.Lerp(0, 0.5, var_288_7)

					arg_285_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1284ui_story.fillRatio = var_288_8
				end
			end

			if arg_285_1.time_ >= var_288_5 + var_288_6 and arg_285_1.time_ < var_288_5 + var_288_6 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect1284ui_story then
				local var_288_9 = 0.5

				arg_285_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1284ui_story.fillRatio = var_288_9
			end

			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action7_2")
			end

			local var_288_11 = 0

			if var_288_11 < arg_285_1.time_ and arg_285_1.time_ <= var_288_11 + arg_288_0 then
				arg_285_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_288_12 = 0
			local var_288_13 = 0.625

			if var_288_12 < arg_285_1.time_ and arg_285_1.time_ <= var_288_12 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_14 = arg_285_1:FormatText(StoryNameCfg[1030].name)

				arg_285_1.leftNameTxt_.text = var_288_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_15 = arg_285_1:GetWordFromCfg(322042068)
				local var_288_16 = arg_285_1:FormatText(var_288_15.content)

				arg_285_1.text_.text = var_288_16

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_17 = 25
				local var_288_18 = utf8.len(var_288_16)
				local var_288_19 = var_288_17 <= 0 and var_288_13 or var_288_13 * (var_288_18 / var_288_17)

				if var_288_19 > 0 and var_288_13 < var_288_19 then
					arg_285_1.talkMaxDuration = var_288_19

					if var_288_19 + var_288_12 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_19 + var_288_12
					end
				end

				arg_285_1.text_.text = var_288_16
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322042", "322042068", "story_v_out_322042.awb") ~= 0 then
					local var_288_20 = manager.audio:GetVoiceLength("story_v_out_322042", "322042068", "story_v_out_322042.awb") / 1000

					if var_288_20 + var_288_12 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_20 + var_288_12
					end

					if var_288_15.prefab_name ~= "" and arg_285_1.actors_[var_288_15.prefab_name] ~= nil then
						local var_288_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_15.prefab_name].transform, "story_v_out_322042", "322042068", "story_v_out_322042.awb")

						arg_285_1:RecordAudio("322042068", var_288_21)
						arg_285_1:RecordAudio("322042068", var_288_21)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322042", "322042068", "story_v_out_322042.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322042", "322042068", "story_v_out_322042.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_22 = math.max(var_288_13, arg_285_1.talkMaxDuration)

			if var_288_12 <= arg_285_1.time_ and arg_285_1.time_ < var_288_12 + var_288_22 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_12) / var_288_22

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_12 + var_288_22 and arg_285_1.time_ < var_288_12 + var_288_22 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play322042069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322042069
		arg_289_1.duration_ = 7

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322042070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10104ui_story"].transform
			local var_292_1 = 1

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos10104ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0, 100, 0)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10104ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, 100, 0)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["1284ui_story"].transform
			local var_292_10 = 1

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.var_.moveOldPos1284ui_story = var_292_9.localPosition
			end

			local var_292_11 = 0.001

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11
				local var_292_13 = Vector3.New(0, 100, 0)

				var_292_9.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1284ui_story, var_292_13, var_292_12)

				local var_292_14 = manager.ui.mainCamera.transform.position - var_292_9.position

				var_292_9.forward = Vector3.New(var_292_14.x, var_292_14.y, var_292_14.z)

				local var_292_15 = var_292_9.localEulerAngles

				var_292_15.z = 0
				var_292_15.x = 0
				var_292_9.localEulerAngles = var_292_15
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 then
				var_292_9.localPosition = Vector3.New(0, 100, 0)

				local var_292_16 = manager.ui.mainCamera.transform.position - var_292_9.position

				var_292_9.forward = Vector3.New(var_292_16.x, var_292_16.y, var_292_16.z)

				local var_292_17 = var_292_9.localEulerAngles

				var_292_17.z = 0
				var_292_17.x = 0
				var_292_9.localEulerAngles = var_292_17
			end

			local var_292_18 = 2.03400000184774
			local var_292_19 = 1

			if var_292_18 < arg_289_1.time_ and arg_289_1.time_ <= var_292_18 + arg_292_0 then
				local var_292_20 = "play"
				local var_292_21 = "effect"

				arg_289_1:AudioAction(var_292_20, var_292_21, "se_story_145", "se_story_145_fire02", "")
			end

			local var_292_22 = manager.ui.mainCamera.transform
			local var_292_23 = 1.03400000184774

			if var_292_23 < arg_289_1.time_ and arg_289_1.time_ <= var_292_23 + arg_292_0 then
				local var_292_24 = arg_289_1.var_.effect2069
				local var_292_25
				local var_292_26 = var_292_22

				if not var_292_24 then
					var_292_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning"), var_292_26)
					var_292_24.name = "2069"
					arg_289_1.var_.effect2069 = var_292_24
				else
					var_292_24.transform:SetParent(var_292_26)
				end

				var_292_24.transform.localPosition = Vector3.New(0, 0, 0)
				var_292_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_292_27 = 0

			if var_292_27 < arg_289_1.time_ and arg_289_1.time_ <= var_292_27 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_28 = 1

			if var_292_27 <= arg_289_1.time_ and arg_289_1.time_ < var_292_27 + var_292_28 then
				local var_292_29 = (arg_289_1.time_ - var_292_27) / var_292_28
				local var_292_30 = Color.New(0, 0, 0)

				var_292_30.a = Mathf.Lerp(0, 1, var_292_29)
				arg_289_1.mask_.color = var_292_30
			end

			if arg_289_1.time_ >= var_292_27 + var_292_28 and arg_289_1.time_ < var_292_27 + var_292_28 + arg_292_0 then
				local var_292_31 = Color.New(0, 0, 0)

				var_292_31.a = 1
				arg_289_1.mask_.color = var_292_31
			end

			local var_292_32 = 1

			if var_292_32 < arg_289_1.time_ and arg_289_1.time_ <= var_292_32 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_33 = 1

			if var_292_32 <= arg_289_1.time_ and arg_289_1.time_ < var_292_32 + var_292_33 then
				local var_292_34 = (arg_289_1.time_ - var_292_32) / var_292_33
				local var_292_35 = Color.New(0, 0, 0)

				var_292_35.a = Mathf.Lerp(1, 0, var_292_34)
				arg_289_1.mask_.color = var_292_35
			end

			if arg_289_1.time_ >= var_292_32 + var_292_33 and arg_289_1.time_ < var_292_32 + var_292_33 + arg_292_0 then
				local var_292_36 = Color.New(0, 0, 0)
				local var_292_37 = 0

				arg_289_1.mask_.enabled = false
				var_292_36.a = var_292_37
				arg_289_1.mask_.color = var_292_36
			end

			local var_292_38 = "L10b"

			if arg_289_1.bgs_[var_292_38] == nil then
				local var_292_39 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_39:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_292_38)
				var_292_39.name = var_292_38
				var_292_39.transform.parent = arg_289_1.stage_.transform
				var_292_39.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_[var_292_38] = var_292_39
			end

			local var_292_40 = arg_289_1.bgs_.L10b.transform
			local var_292_41 = 1

			if var_292_41 < arg_289_1.time_ and arg_289_1.time_ <= var_292_41 + arg_292_0 then
				arg_289_1.var_.moveOldPosL10b = var_292_40.localPosition
			end

			local var_292_42 = 1

			if var_292_41 <= arg_289_1.time_ and arg_289_1.time_ < var_292_41 + var_292_42 then
				local var_292_43 = (arg_289_1.time_ - var_292_41) / var_292_42
				local var_292_44 = Vector3.New(0, 0.5, 7)

				var_292_40.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPosL10b, var_292_44, var_292_43)
			end

			if arg_289_1.time_ >= var_292_41 + var_292_42 and arg_289_1.time_ < var_292_41 + var_292_42 + arg_292_0 then
				var_292_40.localPosition = Vector3.New(0, 0.5, 7)
			end

			local var_292_45 = 0.6
			local var_292_46 = 1

			if var_292_45 < arg_289_1.time_ and arg_289_1.time_ <= var_292_45 + arg_292_0 then
				local var_292_47 = "play"
				local var_292_48 = "effect"

				arg_289_1:AudioAction(var_292_47, var_292_48, "se_story_145", "se_story_145_fire04_loop", "")
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_49 = 2
			local var_292_50 = 1.8

			if var_292_49 < arg_289_1.time_ and arg_289_1.time_ <= var_292_49 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_51 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_51:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_52 = arg_289_1:GetWordFromCfg(322042069)
				local var_292_53 = arg_289_1:FormatText(var_292_52.content)

				arg_289_1.text_.text = var_292_53

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_54 = 72
				local var_292_55 = utf8.len(var_292_53)
				local var_292_56 = var_292_54 <= 0 and var_292_50 or var_292_50 * (var_292_55 / var_292_54)

				if var_292_56 > 0 and var_292_50 < var_292_56 then
					arg_289_1.talkMaxDuration = var_292_56
					var_292_49 = var_292_49 + 0.3

					if var_292_56 + var_292_49 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_56 + var_292_49
					end
				end

				arg_289_1.text_.text = var_292_53
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_57 = var_292_49 + 0.3
			local var_292_58 = math.max(var_292_50, arg_289_1.talkMaxDuration)

			if var_292_57 <= arg_289_1.time_ and arg_289_1.time_ < var_292_57 + var_292_58 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_57) / var_292_58

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_57 + var_292_58 and arg_289_1.time_ < var_292_57 + var_292_58 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "L10b",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 8),
					endPos = Vector3.New(0, 0.5, 7),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play322042070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 322042070
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
			arg_295_1.auto_ = false
		end

		function arg_295_1.playNext_(arg_297_0)
			arg_295_1.onStoryFinished_()
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 1.275

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_2 = arg_295_1:GetWordFromCfg(322042070)
				local var_298_3 = arg_295_1:FormatText(var_298_2.content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 51
				local var_298_5 = utf8.len(var_298_3)
				local var_298_6 = var_298_4 <= 0 and var_298_1 or var_298_1 * (var_298_5 / var_298_4)

				if var_298_6 > 0 and var_298_1 < var_298_6 then
					arg_295_1.talkMaxDuration = var_298_6

					if var_298_6 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_7 and arg_295_1.time_ < var_298_0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L15f",
		"TextureConfig/Background/L15h"
	},
	voices = {
		"story_v_out_322042.awb"
	}
}
