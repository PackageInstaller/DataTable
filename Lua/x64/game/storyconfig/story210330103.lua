return {
	Play103303001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103303001
		arg_1_1.duration_ = 3

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play103303002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST18"

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
				local var_4_5 = arg_1_1.bgs_.ST18

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
					if iter_4_0 ~= "ST18" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 1

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

			local var_4_22 = "1066ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1066ui_story"].transform
			local var_4_28 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0.7, -0.77, -6.1)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0.7, -0.77, -6.1)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1066ui_story"]
			local var_4_37 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1066ui_story == nil then
				arg_1_1.var_.characterEffect1066ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.2

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1066ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1066ui_story then
				arg_1_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_4_40 = 1

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			local var_4_41 = 1

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_4_42 = 0
			local var_4_43 = 0.616666666666667

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

			local var_4_48 = 1.5
			local var_4_49 = 1.5

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			local var_4_54 = 1
			local var_4_55 = 0.1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[32].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(103303001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 4
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_55 or var_4_55 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_55 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61

					if var_4_61 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303001", "story_v_side_old_103303.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303001", "story_v_side_old_103303.awb") / 1000

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_side_old_103303", "103303001", "story_v_side_old_103303.awb")

						arg_1_1:RecordAudio("103303001", var_4_63)
						arg_1_1:RecordAudio("103303001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303001", "story_v_side_old_103303.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303001", "story_v_side_old_103303.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_64 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_54) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_54 + var_4_64 and arg_1_1.time_ < var_4_54 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play103303002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 103303002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play103303003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = arg_7_1.actors_["1066ui_story"]
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 and not isNil(var_10_0) and arg_7_1.var_.characterEffect1066ui_story == nil then
				arg_7_1.var_.characterEffect1066ui_story = var_10_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_2 = 0.2

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_2 and not isNil(var_10_0) then
				local var_10_3 = (arg_7_1.time_ - var_10_1) / var_10_2

				if arg_7_1.var_.characterEffect1066ui_story and not isNil(var_10_0) then
					local var_10_4 = Mathf.Lerp(0, 0.5, var_10_3)

					arg_7_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1066ui_story.fillRatio = var_10_4
				end
			end

			if arg_7_1.time_ >= var_10_1 + var_10_2 and arg_7_1.time_ < var_10_1 + var_10_2 + arg_10_0 and not isNil(var_10_0) and arg_7_1.var_.characterEffect1066ui_story then
				local var_10_5 = 0.5

				arg_7_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1066ui_story.fillRatio = var_10_5
			end

			local var_10_6 = 0
			local var_10_7 = 1.15

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_8 = arg_7_1:GetWordFromCfg(103303002)
				local var_10_9 = arg_7_1:FormatText(var_10_8.content)

				arg_7_1.text_.text = var_10_9

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_10 = 46
				local var_10_11 = utf8.len(var_10_9)
				local var_10_12 = var_10_10 <= 0 and var_10_7 or var_10_7 * (var_10_11 / var_10_10)

				if var_10_12 > 0 and var_10_7 < var_10_12 then
					arg_7_1.talkMaxDuration = var_10_12

					if var_10_12 + var_10_6 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_12 + var_10_6
					end
				end

				arg_7_1.text_.text = var_10_9
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_13 = math.max(var_10_7, arg_7_1.talkMaxDuration)

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_13 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_6) / var_10_13

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_6 + var_10_13 and arg_7_1.time_ < var_10_6 + var_10_13 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play103303003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 103303003
		arg_11_1.duration_ = 10.73

		local var_11_0 = {
			ja = 10.733,
			ko = 6.533,
			zh = 4.4,
			en = 5.333
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play103303004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = "1033ui_story"

			if arg_11_1.actors_[var_14_0] == nil then
				local var_14_1 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_14_1) then
					local var_14_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_11_1.stage_.transform)

					var_14_2.name = var_14_0
					var_14_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_11_1.actors_[var_14_0] = var_14_2

					local var_14_3 = var_14_2:GetComponentInChildren(typeof(CharacterEffect))

					var_14_3.enabled = true

					local var_14_4 = GameObjectTools.GetOrAddComponent(var_14_2, typeof(DynamicBoneHelper))

					if var_14_4 then
						var_14_4:EnableDynamicBone(false)
					end

					arg_11_1:ShowWeapon(var_14_3.transform, false)

					arg_11_1.var_[var_14_0 .. "Animator"] = var_14_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_11_1.var_[var_14_0 .. "Animator"].applyRootMotion = true
					arg_11_1.var_[var_14_0 .. "LipSync"] = var_14_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_14_5 = arg_11_1.actors_["1033ui_story"].transform
			local var_14_6 = 0

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 then
				arg_11_1.var_.moveOldPos1033ui_story = var_14_5.localPosition
			end

			local var_14_7 = 0.001

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_7 then
				local var_14_8 = (arg_11_1.time_ - var_14_6) / var_14_7
				local var_14_9 = Vector3.New(-0.7, -1.01, -6.13)

				var_14_5.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1033ui_story, var_14_9, var_14_8)

				local var_14_10 = manager.ui.mainCamera.transform.position - var_14_5.position

				var_14_5.forward = Vector3.New(var_14_10.x, var_14_10.y, var_14_10.z)

				local var_14_11 = var_14_5.localEulerAngles

				var_14_11.z = 0
				var_14_11.x = 0
				var_14_5.localEulerAngles = var_14_11
			end

			if arg_11_1.time_ >= var_14_6 + var_14_7 and arg_11_1.time_ < var_14_6 + var_14_7 + arg_14_0 then
				var_14_5.localPosition = Vector3.New(-0.7, -1.01, -6.13)

				local var_14_12 = manager.ui.mainCamera.transform.position - var_14_5.position

				var_14_5.forward = Vector3.New(var_14_12.x, var_14_12.y, var_14_12.z)

				local var_14_13 = var_14_5.localEulerAngles

				var_14_13.z = 0
				var_14_13.x = 0
				var_14_5.localEulerAngles = var_14_13
			end

			local var_14_14 = arg_11_1.actors_["1033ui_story"]
			local var_14_15 = 0

			if var_14_15 < arg_11_1.time_ and arg_11_1.time_ <= var_14_15 + arg_14_0 and not isNil(var_14_14) and arg_11_1.var_.characterEffect1033ui_story == nil then
				arg_11_1.var_.characterEffect1033ui_story = var_14_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_16 = 0.2

			if var_14_15 <= arg_11_1.time_ and arg_11_1.time_ < var_14_15 + var_14_16 and not isNil(var_14_14) then
				local var_14_17 = (arg_11_1.time_ - var_14_15) / var_14_16

				if arg_11_1.var_.characterEffect1033ui_story and not isNil(var_14_14) then
					arg_11_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_15 + var_14_16 and arg_11_1.time_ < var_14_15 + var_14_16 + arg_14_0 and not isNil(var_14_14) and arg_11_1.var_.characterEffect1033ui_story then
				arg_11_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_14_18 = 0

			if var_14_18 < arg_11_1.time_ and arg_11_1.time_ <= var_14_18 + arg_14_0 then
				arg_11_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			local var_14_19 = 0

			if var_14_19 < arg_11_1.time_ and arg_11_1.time_ <= var_14_19 + arg_14_0 then
				arg_11_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_14_20 = 0
			local var_14_21 = 0.6

			if var_14_20 < arg_11_1.time_ and arg_11_1.time_ <= var_14_20 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_22 = arg_11_1:FormatText(StoryNameCfg[236].name)

				arg_11_1.leftNameTxt_.text = var_14_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_23 = arg_11_1:GetWordFromCfg(103303003)
				local var_14_24 = arg_11_1:FormatText(var_14_23.content)

				arg_11_1.text_.text = var_14_24

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_25 = 24
				local var_14_26 = utf8.len(var_14_24)
				local var_14_27 = var_14_25 <= 0 and var_14_21 or var_14_21 * (var_14_26 / var_14_25)

				if var_14_27 > 0 and var_14_21 < var_14_27 then
					arg_11_1.talkMaxDuration = var_14_27

					if var_14_27 + var_14_20 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_27 + var_14_20
					end
				end

				arg_11_1.text_.text = var_14_24
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303003", "story_v_side_old_103303.awb") ~= 0 then
					local var_14_28 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303003", "story_v_side_old_103303.awb") / 1000

					if var_14_28 + var_14_20 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_28 + var_14_20
					end

					if var_14_23.prefab_name ~= "" and arg_11_1.actors_[var_14_23.prefab_name] ~= nil then
						local var_14_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_23.prefab_name].transform, "story_v_side_old_103303", "103303003", "story_v_side_old_103303.awb")

						arg_11_1:RecordAudio("103303003", var_14_29)
						arg_11_1:RecordAudio("103303003", var_14_29)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303003", "story_v_side_old_103303.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303003", "story_v_side_old_103303.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_30 = math.max(var_14_21, arg_11_1.talkMaxDuration)

			if var_14_20 <= arg_11_1.time_ and arg_11_1.time_ < var_14_20 + var_14_30 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_20) / var_14_30

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_20 + var_14_30 and arg_11_1.time_ < var_14_20 + var_14_30 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play103303004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 103303004
		arg_15_1.duration_ = 5.4

		local var_15_0 = {
			ja = 4.133,
			ko = 5.4,
			zh = 3.466,
			en = 4.9
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play103303005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["1066ui_story"]
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.characterEffect1066ui_story == nil then
				arg_15_1.var_.characterEffect1066ui_story = var_18_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.2

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 and not isNil(var_18_0) then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2

				if arg_15_1.var_.characterEffect1066ui_story and not isNil(var_18_0) then
					arg_15_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 and not isNil(var_18_0) and arg_15_1.var_.characterEffect1066ui_story then
				arg_15_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_18_4 = arg_15_1.actors_["1033ui_story"]
			local var_18_5 = 0

			if var_18_5 < arg_15_1.time_ and arg_15_1.time_ <= var_18_5 + arg_18_0 and not isNil(var_18_4) and arg_15_1.var_.characterEffect1033ui_story == nil then
				arg_15_1.var_.characterEffect1033ui_story = var_18_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_6 = 0.2

			if var_18_5 <= arg_15_1.time_ and arg_15_1.time_ < var_18_5 + var_18_6 and not isNil(var_18_4) then
				local var_18_7 = (arg_15_1.time_ - var_18_5) / var_18_6

				if arg_15_1.var_.characterEffect1033ui_story and not isNil(var_18_4) then
					local var_18_8 = Mathf.Lerp(0, 0.5, var_18_7)

					arg_15_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1033ui_story.fillRatio = var_18_8
				end
			end

			if arg_15_1.time_ >= var_18_5 + var_18_6 and arg_15_1.time_ < var_18_5 + var_18_6 + arg_18_0 and not isNil(var_18_4) and arg_15_1.var_.characterEffect1033ui_story then
				local var_18_9 = 0.5

				arg_15_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1033ui_story.fillRatio = var_18_9
			end

			local var_18_10 = 0

			if var_18_10 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 then
				arg_15_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action424")
			end

			local var_18_11 = 0

			if var_18_11 < arg_15_1.time_ and arg_15_1.time_ <= var_18_11 + arg_18_0 then
				arg_15_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_18_12 = 0
			local var_18_13 = 0.4

			if var_18_12 < arg_15_1.time_ and arg_15_1.time_ <= var_18_12 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_14 = arg_15_1:FormatText(StoryNameCfg[32].name)

				arg_15_1.leftNameTxt_.text = var_18_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_15 = arg_15_1:GetWordFromCfg(103303004)
				local var_18_16 = arg_15_1:FormatText(var_18_15.content)

				arg_15_1.text_.text = var_18_16

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_17 = 16
				local var_18_18 = utf8.len(var_18_16)
				local var_18_19 = var_18_17 <= 0 and var_18_13 or var_18_13 * (var_18_18 / var_18_17)

				if var_18_19 > 0 and var_18_13 < var_18_19 then
					arg_15_1.talkMaxDuration = var_18_19

					if var_18_19 + var_18_12 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_19 + var_18_12
					end
				end

				arg_15_1.text_.text = var_18_16
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303004", "story_v_side_old_103303.awb") ~= 0 then
					local var_18_20 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303004", "story_v_side_old_103303.awb") / 1000

					if var_18_20 + var_18_12 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_20 + var_18_12
					end

					if var_18_15.prefab_name ~= "" and arg_15_1.actors_[var_18_15.prefab_name] ~= nil then
						local var_18_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_15.prefab_name].transform, "story_v_side_old_103303", "103303004", "story_v_side_old_103303.awb")

						arg_15_1:RecordAudio("103303004", var_18_21)
						arg_15_1:RecordAudio("103303004", var_18_21)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303004", "story_v_side_old_103303.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303004", "story_v_side_old_103303.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_22 = math.max(var_18_13, arg_15_1.talkMaxDuration)

			if var_18_12 <= arg_15_1.time_ and arg_15_1.time_ < var_18_12 + var_18_22 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_12) / var_18_22

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_12 + var_18_22 and arg_15_1.time_ < var_18_12 + var_18_22 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play103303005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 103303005
		arg_19_1.duration_ = 4.63

		local var_19_0 = {
			ja = 4.533,
			ko = 4.633,
			zh = 2.833,
			en = 4.6
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play103303006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1066ui_story"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1066ui_story == nil then
				arg_19_1.var_.characterEffect1066ui_story = var_22_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.2

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 and not isNil(var_22_0) then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.characterEffect1066ui_story and not isNil(var_22_0) then
					local var_22_4 = Mathf.Lerp(0, 0.5, var_22_3)

					arg_19_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1066ui_story.fillRatio = var_22_4
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1066ui_story then
				local var_22_5 = 0.5

				arg_19_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1066ui_story.fillRatio = var_22_5
			end

			local var_22_6 = arg_19_1.actors_["1033ui_story"]
			local var_22_7 = 0

			if var_22_7 < arg_19_1.time_ and arg_19_1.time_ <= var_22_7 + arg_22_0 and not isNil(var_22_6) and arg_19_1.var_.characterEffect1033ui_story == nil then
				arg_19_1.var_.characterEffect1033ui_story = var_22_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_8 = 0.2

			if var_22_7 <= arg_19_1.time_ and arg_19_1.time_ < var_22_7 + var_22_8 and not isNil(var_22_6) then
				local var_22_9 = (arg_19_1.time_ - var_22_7) / var_22_8

				if arg_19_1.var_.characterEffect1033ui_story and not isNil(var_22_6) then
					arg_19_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_7 + var_22_8 and arg_19_1.time_ < var_22_7 + var_22_8 + arg_22_0 and not isNil(var_22_6) and arg_19_1.var_.characterEffect1033ui_story then
				arg_19_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_22_10 = 0

			if var_22_10 < arg_19_1.time_ and arg_19_1.time_ <= var_22_10 + arg_22_0 then
				arg_19_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action423")
			end

			local var_22_11 = 0

			if var_22_11 < arg_19_1.time_ and arg_19_1.time_ <= var_22_11 + arg_22_0 then
				arg_19_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_22_12 = 0
			local var_22_13 = 0.375

			if var_22_12 < arg_19_1.time_ and arg_19_1.time_ <= var_22_12 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_14 = arg_19_1:FormatText(StoryNameCfg[236].name)

				arg_19_1.leftNameTxt_.text = var_22_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_15 = arg_19_1:GetWordFromCfg(103303005)
				local var_22_16 = arg_19_1:FormatText(var_22_15.content)

				arg_19_1.text_.text = var_22_16

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_17 = 15
				local var_22_18 = utf8.len(var_22_16)
				local var_22_19 = var_22_17 <= 0 and var_22_13 or var_22_13 * (var_22_18 / var_22_17)

				if var_22_19 > 0 and var_22_13 < var_22_19 then
					arg_19_1.talkMaxDuration = var_22_19

					if var_22_19 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_19 + var_22_12
					end
				end

				arg_19_1.text_.text = var_22_16
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303005", "story_v_side_old_103303.awb") ~= 0 then
					local var_22_20 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303005", "story_v_side_old_103303.awb") / 1000

					if var_22_20 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_20 + var_22_12
					end

					if var_22_15.prefab_name ~= "" and arg_19_1.actors_[var_22_15.prefab_name] ~= nil then
						local var_22_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_15.prefab_name].transform, "story_v_side_old_103303", "103303005", "story_v_side_old_103303.awb")

						arg_19_1:RecordAudio("103303005", var_22_21)
						arg_19_1:RecordAudio("103303005", var_22_21)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303005", "story_v_side_old_103303.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303005", "story_v_side_old_103303.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_22 = math.max(var_22_13, arg_19_1.talkMaxDuration)

			if var_22_12 <= arg_19_1.time_ and arg_19_1.time_ < var_22_12 + var_22_22 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_12) / var_22_22

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_12 + var_22_22 and arg_19_1.time_ < var_22_12 + var_22_22 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play103303006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 103303006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play103303007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1033ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1033ui_story == nil then
				arg_23_1.var_.characterEffect1033ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1033ui_story and not isNil(var_26_0) then
					local var_26_4 = Mathf.Lerp(0, 0.5, var_26_3)

					arg_23_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1033ui_story.fillRatio = var_26_4
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1033ui_story then
				local var_26_5 = 0.5

				arg_23_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1033ui_story.fillRatio = var_26_5
			end

			local var_26_6 = arg_23_1.actors_["1033ui_story"]
			local var_26_7 = 0

			if var_26_7 < arg_23_1.time_ and arg_23_1.time_ <= var_26_7 + arg_26_0 and not isNil(var_26_6) and arg_23_1.var_.characterEffect1033ui_story == nil then
				arg_23_1.var_.characterEffect1033ui_story = var_26_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_8 = 0.2

			if var_26_7 <= arg_23_1.time_ and arg_23_1.time_ < var_26_7 + var_26_8 and not isNil(var_26_6) then
				local var_26_9 = (arg_23_1.time_ - var_26_7) / var_26_8

				if arg_23_1.var_.characterEffect1033ui_story and not isNil(var_26_6) then
					local var_26_10 = Mathf.Lerp(0, 0.5, var_26_9)

					arg_23_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1033ui_story.fillRatio = var_26_10
				end
			end

			if arg_23_1.time_ >= var_26_7 + var_26_8 and arg_23_1.time_ < var_26_7 + var_26_8 + arg_26_0 and not isNil(var_26_6) and arg_23_1.var_.characterEffect1033ui_story then
				local var_26_11 = 0.5

				arg_23_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1033ui_story.fillRatio = var_26_11
			end

			local var_26_12 = 0
			local var_26_13 = 0.925

			if var_26_12 < arg_23_1.time_ and arg_23_1.time_ <= var_26_12 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_14 = arg_23_1:FormatText(StoryNameCfg[7].name)

				arg_23_1.leftNameTxt_.text = var_26_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_15 = arg_23_1:GetWordFromCfg(103303006)
				local var_26_16 = arg_23_1:FormatText(var_26_15.content)

				arg_23_1.text_.text = var_26_16

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_17 = 37
				local var_26_18 = utf8.len(var_26_16)
				local var_26_19 = var_26_17 <= 0 and var_26_13 or var_26_13 * (var_26_18 / var_26_17)

				if var_26_19 > 0 and var_26_13 < var_26_19 then
					arg_23_1.talkMaxDuration = var_26_19

					if var_26_19 + var_26_12 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_19 + var_26_12
					end
				end

				arg_23_1.text_.text = var_26_16
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_20 = math.max(var_26_13, arg_23_1.talkMaxDuration)

			if var_26_12 <= arg_23_1.time_ and arg_23_1.time_ < var_26_12 + var_26_20 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_12) / var_26_20

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_12 + var_26_20 and arg_23_1.time_ < var_26_12 + var_26_20 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play103303007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 103303007
		arg_27_1.duration_ = 8.13

		local var_27_0 = {
			ja = 7.833,
			ko = 6.566,
			zh = 5.866,
			en = 8.133
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play103303008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1066ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1066ui_story == nil then
				arg_27_1.var_.characterEffect1066ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1066ui_story and not isNil(var_30_0) then
					arg_27_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1066ui_story then
				arg_27_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_30_4 = arg_27_1.actors_["1033ui_story"]
			local var_30_5 = 0

			if var_30_5 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1033ui_story == nil then
				arg_27_1.var_.characterEffect1033ui_story = var_30_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.2

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_6 and not isNil(var_30_4) then
				local var_30_7 = (arg_27_1.time_ - var_30_5) / var_30_6

				if arg_27_1.var_.characterEffect1033ui_story and not isNil(var_30_4) then
					local var_30_8 = Mathf.Lerp(0, 0.5, var_30_7)

					arg_27_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1033ui_story.fillRatio = var_30_8
				end
			end

			if arg_27_1.time_ >= var_30_5 + var_30_6 and arg_27_1.time_ < var_30_5 + var_30_6 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1033ui_story then
				local var_30_9 = 0.5

				arg_27_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1033ui_story.fillRatio = var_30_9
			end

			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
				arg_27_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action442")
			end

			local var_30_11 = 0

			if var_30_11 < arg_27_1.time_ and arg_27_1.time_ <= var_30_11 + arg_30_0 then
				arg_27_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_30_12 = 0
			local var_30_13 = 0.625

			if var_30_12 < arg_27_1.time_ and arg_27_1.time_ <= var_30_12 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_14 = arg_27_1:FormatText(StoryNameCfg[32].name)

				arg_27_1.leftNameTxt_.text = var_30_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_15 = arg_27_1:GetWordFromCfg(103303007)
				local var_30_16 = arg_27_1:FormatText(var_30_15.content)

				arg_27_1.text_.text = var_30_16

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_17 = 25
				local var_30_18 = utf8.len(var_30_16)
				local var_30_19 = var_30_17 <= 0 and var_30_13 or var_30_13 * (var_30_18 / var_30_17)

				if var_30_19 > 0 and var_30_13 < var_30_19 then
					arg_27_1.talkMaxDuration = var_30_19

					if var_30_19 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_19 + var_30_12
					end
				end

				arg_27_1.text_.text = var_30_16
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303007", "story_v_side_old_103303.awb") ~= 0 then
					local var_30_20 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303007", "story_v_side_old_103303.awb") / 1000

					if var_30_20 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_20 + var_30_12
					end

					if var_30_15.prefab_name ~= "" and arg_27_1.actors_[var_30_15.prefab_name] ~= nil then
						local var_30_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_15.prefab_name].transform, "story_v_side_old_103303", "103303007", "story_v_side_old_103303.awb")

						arg_27_1:RecordAudio("103303007", var_30_21)
						arg_27_1:RecordAudio("103303007", var_30_21)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303007", "story_v_side_old_103303.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303007", "story_v_side_old_103303.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_22 = math.max(var_30_13, arg_27_1.talkMaxDuration)

			if var_30_12 <= arg_27_1.time_ and arg_27_1.time_ < var_30_12 + var_30_22 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_12) / var_30_22

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_12 + var_30_22 and arg_27_1.time_ < var_30_12 + var_30_22 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play103303008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 103303008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play103303009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1066ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1066ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, 100, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1066ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, 100, 0)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["1033ui_story"].transform
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.var_.moveOldPos1033ui_story = var_34_9.localPosition
			end

			local var_34_11 = 0.001

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11
				local var_34_13 = Vector3.New(0, 100, 0)

				var_34_9.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1033ui_story, var_34_13, var_34_12)

				local var_34_14 = manager.ui.mainCamera.transform.position - var_34_9.position

				var_34_9.forward = Vector3.New(var_34_14.x, var_34_14.y, var_34_14.z)

				local var_34_15 = var_34_9.localEulerAngles

				var_34_15.z = 0
				var_34_15.x = 0
				var_34_9.localEulerAngles = var_34_15
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 then
				var_34_9.localPosition = Vector3.New(0, 100, 0)

				local var_34_16 = manager.ui.mainCamera.transform.position - var_34_9.position

				var_34_9.forward = Vector3.New(var_34_16.x, var_34_16.y, var_34_16.z)

				local var_34_17 = var_34_9.localEulerAngles

				var_34_17.z = 0
				var_34_17.x = 0
				var_34_9.localEulerAngles = var_34_17
			end

			local var_34_18 = 0
			local var_34_19 = 0.575

			if var_34_18 < arg_31_1.time_ and arg_31_1.time_ <= var_34_18 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_20 = arg_31_1:GetWordFromCfg(103303008)
				local var_34_21 = arg_31_1:FormatText(var_34_20.content)

				arg_31_1.text_.text = var_34_21

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_22 = 23
				local var_34_23 = utf8.len(var_34_21)
				local var_34_24 = var_34_22 <= 0 and var_34_19 or var_34_19 * (var_34_23 / var_34_22)

				if var_34_24 > 0 and var_34_19 < var_34_24 then
					arg_31_1.talkMaxDuration = var_34_24

					if var_34_24 + var_34_18 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_24 + var_34_18
					end
				end

				arg_31_1.text_.text = var_34_21
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_25 = math.max(var_34_19, arg_31_1.talkMaxDuration)

			if var_34_18 <= arg_31_1.time_ and arg_31_1.time_ < var_34_18 + var_34_25 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_18) / var_34_25

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_18 + var_34_25 and arg_31_1.time_ < var_34_18 + var_34_25 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play103303009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 103303009
		arg_35_1.duration_ = 2.3

		local var_35_0 = {
			ja = 2.3,
			ko = 1.9,
			zh = 2.033,
			en = 2.033
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play103303010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.2

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[14].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(103303009)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 8
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303009", "story_v_side_old_103303.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303009", "story_v_side_old_103303.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_side_old_103303", "103303009", "story_v_side_old_103303.awb")

						arg_35_1:RecordAudio("103303009", var_38_9)
						arg_35_1:RecordAudio("103303009", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303009", "story_v_side_old_103303.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303009", "story_v_side_old_103303.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play103303010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 103303010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play103303011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.5

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_2 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:GetWordFromCfg(103303010)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 20
				local var_42_6 = utf8.len(var_42_4)
				local var_42_7 = var_42_5 <= 0 and var_42_1 or var_42_1 * (var_42_6 / var_42_5)

				if var_42_7 > 0 and var_42_1 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_8 and arg_39_1.time_ < var_42_0 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play103303011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 103303011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play103303012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 1.05

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_2 = arg_43_1:GetWordFromCfg(103303011)
				local var_46_3 = arg_43_1:FormatText(var_46_2.content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 42
				local var_46_5 = utf8.len(var_46_3)
				local var_46_6 = var_46_4 <= 0 and var_46_1 or var_46_1 * (var_46_5 / var_46_4)

				if var_46_6 > 0 and var_46_1 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_7 and arg_43_1.time_ < var_46_0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play103303012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 103303012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play103303013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 1.4

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(103303012)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 56
				local var_50_5 = utf8.len(var_50_3)
				local var_50_6 = var_50_4 <= 0 and var_50_1 or var_50_1 * (var_50_5 / var_50_4)

				if var_50_6 > 0 and var_50_1 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_7 and arg_47_1.time_ < var_50_0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play103303013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 103303013
		arg_51_1.duration_ = 16.33

		local var_51_0 = {
			ja = 16.333,
			ko = 8.133,
			zh = 5.133,
			en = 8.533
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play103303014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1033ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1033ui_story = var_54_0.localPosition
			end

			local var_54_2 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2
				local var_54_4 = Vector3.New(0, -1.01, -6.13)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1033ui_story, var_54_4, var_54_3)

				local var_54_5 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_5.x, var_54_5.y, var_54_5.z)

				local var_54_6 = var_54_0.localEulerAngles

				var_54_6.z = 0
				var_54_6.x = 0
				var_54_0.localEulerAngles = var_54_6
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_54_7 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_7.x, var_54_7.y, var_54_7.z)

				local var_54_8 = var_54_0.localEulerAngles

				var_54_8.z = 0
				var_54_8.x = 0
				var_54_0.localEulerAngles = var_54_8
			end

			local var_54_9 = arg_51_1.actors_["1033ui_story"]
			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1033ui_story == nil then
				arg_51_1.var_.characterEffect1033ui_story = var_54_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.2

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_11 and not isNil(var_54_9) then
				local var_54_12 = (arg_51_1.time_ - var_54_10) / var_54_11

				if arg_51_1.var_.characterEffect1033ui_story and not isNil(var_54_9) then
					arg_51_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_10 + var_54_11 and arg_51_1.time_ < var_54_10 + var_54_11 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1033ui_story then
				arg_51_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_54_13 = 0

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 then
				arg_51_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action438")
			end

			local var_54_14 = 0

			if var_54_14 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_54_15 = 0
			local var_54_16 = 0.8

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_17 = arg_51_1:FormatText(StoryNameCfg[236].name)

				arg_51_1.leftNameTxt_.text = var_54_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_18 = arg_51_1:GetWordFromCfg(103303013)
				local var_54_19 = arg_51_1:FormatText(var_54_18.content)

				arg_51_1.text_.text = var_54_19

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_20 = 32
				local var_54_21 = utf8.len(var_54_19)
				local var_54_22 = var_54_20 <= 0 and var_54_16 or var_54_16 * (var_54_21 / var_54_20)

				if var_54_22 > 0 and var_54_16 < var_54_22 then
					arg_51_1.talkMaxDuration = var_54_22

					if var_54_22 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_22 + var_54_15
					end
				end

				arg_51_1.text_.text = var_54_19
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303013", "story_v_side_old_103303.awb") ~= 0 then
					local var_54_23 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303013", "story_v_side_old_103303.awb") / 1000

					if var_54_23 + var_54_15 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_23 + var_54_15
					end

					if var_54_18.prefab_name ~= "" and arg_51_1.actors_[var_54_18.prefab_name] ~= nil then
						local var_54_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_18.prefab_name].transform, "story_v_side_old_103303", "103303013", "story_v_side_old_103303.awb")

						arg_51_1:RecordAudio("103303013", var_54_24)
						arg_51_1:RecordAudio("103303013", var_54_24)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303013", "story_v_side_old_103303.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303013", "story_v_side_old_103303.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_25 = math.max(var_54_16, arg_51_1.talkMaxDuration)

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_25 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_15) / var_54_25

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_15 + var_54_25 and arg_51_1.time_ < var_54_15 + var_54_25 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play103303014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 103303014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play103303015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1033ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1033ui_story == nil then
				arg_55_1.var_.characterEffect1033ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1033ui_story and not isNil(var_58_0) then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1033ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1033ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1033ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0
			local var_58_7 = 0.25

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_8 = arg_55_1:FormatText(StoryNameCfg[7].name)

				arg_55_1.leftNameTxt_.text = var_58_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_9 = arg_55_1:GetWordFromCfg(103303014)
				local var_58_10 = arg_55_1:FormatText(var_58_9.content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 10
				local var_58_12 = utf8.len(var_58_10)
				local var_58_13 = var_58_11 <= 0 and var_58_7 or var_58_7 * (var_58_12 / var_58_11)

				if var_58_13 > 0 and var_58_7 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_10
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_14 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_14 and arg_55_1.time_ < var_58_6 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play103303015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 103303015
		arg_59_1.duration_ = 16.4

		local var_59_0 = {
			ja = 16.4,
			ko = 13.5,
			zh = 9.8,
			en = 12.5
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
				arg_59_0:Play103303016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1033ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1033ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(-0.7, -1.01, -6.13)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1033ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(-0.7, -1.01, -6.13)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = arg_59_1.actors_["1066ui_story"].transform
			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 then
				arg_59_1.var_.moveOldPos1066ui_story = var_62_9.localPosition
			end

			local var_62_11 = 0.001

			if var_62_10 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 then
				local var_62_12 = (arg_59_1.time_ - var_62_10) / var_62_11
				local var_62_13 = Vector3.New(0.7, -0.77, -6.1)

				var_62_9.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1066ui_story, var_62_13, var_62_12)

				local var_62_14 = manager.ui.mainCamera.transform.position - var_62_9.position

				var_62_9.forward = Vector3.New(var_62_14.x, var_62_14.y, var_62_14.z)

				local var_62_15 = var_62_9.localEulerAngles

				var_62_15.z = 0
				var_62_15.x = 0
				var_62_9.localEulerAngles = var_62_15
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 then
				var_62_9.localPosition = Vector3.New(0.7, -0.77, -6.1)

				local var_62_16 = manager.ui.mainCamera.transform.position - var_62_9.position

				var_62_9.forward = Vector3.New(var_62_16.x, var_62_16.y, var_62_16.z)

				local var_62_17 = var_62_9.localEulerAngles

				var_62_17.z = 0
				var_62_17.x = 0
				var_62_9.localEulerAngles = var_62_17
			end

			local var_62_18 = arg_59_1.actors_["1066ui_story"]
			local var_62_19 = 0

			if var_62_19 < arg_59_1.time_ and arg_59_1.time_ <= var_62_19 + arg_62_0 and not isNil(var_62_18) and arg_59_1.var_.characterEffect1066ui_story == nil then
				arg_59_1.var_.characterEffect1066ui_story = var_62_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_20 = 0.2

			if var_62_19 <= arg_59_1.time_ and arg_59_1.time_ < var_62_19 + var_62_20 and not isNil(var_62_18) then
				local var_62_21 = (arg_59_1.time_ - var_62_19) / var_62_20

				if arg_59_1.var_.characterEffect1066ui_story and not isNil(var_62_18) then
					arg_59_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_19 + var_62_20 and arg_59_1.time_ < var_62_19 + var_62_20 + arg_62_0 and not isNil(var_62_18) and arg_59_1.var_.characterEffect1066ui_story then
				arg_59_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_62_22 = 0

			if var_62_22 < arg_59_1.time_ and arg_59_1.time_ <= var_62_22 + arg_62_0 then
				arg_59_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_62_23 = 0

			if var_62_23 < arg_59_1.time_ and arg_59_1.time_ <= var_62_23 + arg_62_0 then
				arg_59_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_62_24 = 0
			local var_62_25 = 1.225

			if var_62_24 < arg_59_1.time_ and arg_59_1.time_ <= var_62_24 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_26 = arg_59_1:FormatText(StoryNameCfg[32].name)

				arg_59_1.leftNameTxt_.text = var_62_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_27 = arg_59_1:GetWordFromCfg(103303015)
				local var_62_28 = arg_59_1:FormatText(var_62_27.content)

				arg_59_1.text_.text = var_62_28

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_29 = 49
				local var_62_30 = utf8.len(var_62_28)
				local var_62_31 = var_62_29 <= 0 and var_62_25 or var_62_25 * (var_62_30 / var_62_29)

				if var_62_31 > 0 and var_62_25 < var_62_31 then
					arg_59_1.talkMaxDuration = var_62_31

					if var_62_31 + var_62_24 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_31 + var_62_24
					end
				end

				arg_59_1.text_.text = var_62_28
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303015", "story_v_side_old_103303.awb") ~= 0 then
					local var_62_32 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303015", "story_v_side_old_103303.awb") / 1000

					if var_62_32 + var_62_24 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_32 + var_62_24
					end

					if var_62_27.prefab_name ~= "" and arg_59_1.actors_[var_62_27.prefab_name] ~= nil then
						local var_62_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_27.prefab_name].transform, "story_v_side_old_103303", "103303015", "story_v_side_old_103303.awb")

						arg_59_1:RecordAudio("103303015", var_62_33)
						arg_59_1:RecordAudio("103303015", var_62_33)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303015", "story_v_side_old_103303.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303015", "story_v_side_old_103303.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_34 = math.max(var_62_25, arg_59_1.talkMaxDuration)

			if var_62_24 <= arg_59_1.time_ and arg_59_1.time_ < var_62_24 + var_62_34 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_24) / var_62_34

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_24 + var_62_34 and arg_59_1.time_ < var_62_24 + var_62_34 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play103303016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 103303016
		arg_63_1.duration_ = 14.37

		local var_63_0 = {
			ja = 14.366,
			ko = 11.8,
			zh = 8.866,
			en = 10
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play103303017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_66_2 = 0
			local var_66_3 = 1.125

			if var_66_2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_4 = arg_63_1:FormatText(StoryNameCfg[32].name)

				arg_63_1.leftNameTxt_.text = var_66_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_5 = arg_63_1:GetWordFromCfg(103303016)
				local var_66_6 = arg_63_1:FormatText(var_66_5.content)

				arg_63_1.text_.text = var_66_6

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_7 = 45
				local var_66_8 = utf8.len(var_66_6)
				local var_66_9 = var_66_7 <= 0 and var_66_3 or var_66_3 * (var_66_8 / var_66_7)

				if var_66_9 > 0 and var_66_3 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_2
					end
				end

				arg_63_1.text_.text = var_66_6
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303016", "story_v_side_old_103303.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303016", "story_v_side_old_103303.awb") / 1000

					if var_66_10 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_2
					end

					if var_66_5.prefab_name ~= "" and arg_63_1.actors_[var_66_5.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_5.prefab_name].transform, "story_v_side_old_103303", "103303016", "story_v_side_old_103303.awb")

						arg_63_1:RecordAudio("103303016", var_66_11)
						arg_63_1:RecordAudio("103303016", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303016", "story_v_side_old_103303.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303016", "story_v_side_old_103303.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_3, arg_63_1.talkMaxDuration)

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_2) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_2 + var_66_12 and arg_63_1.time_ < var_66_2 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play103303017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 103303017
		arg_67_1.duration_ = 14.5

		local var_67_0 = {
			ja = 14.5,
			ko = 5.466,
			zh = 3.566,
			en = 4.733
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
				arg_67_0:Play103303018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1066ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1066ui_story == nil then
				arg_67_1.var_.characterEffect1066ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1066ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1066ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1066ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1066ui_story.fillRatio = var_70_5
			end

			local var_70_6 = arg_67_1.actors_["1033ui_story"]
			local var_70_7 = 0

			if var_70_7 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1033ui_story == nil then
				arg_67_1.var_.characterEffect1033ui_story = var_70_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_8 = 0.2

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_8 and not isNil(var_70_6) then
				local var_70_9 = (arg_67_1.time_ - var_70_7) / var_70_8

				if arg_67_1.var_.characterEffect1033ui_story and not isNil(var_70_6) then
					arg_67_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_7 + var_70_8 and arg_67_1.time_ < var_70_7 + var_70_8 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1033ui_story then
				arg_67_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action482")
			end

			local var_70_11 = 0

			if var_70_11 < arg_67_1.time_ and arg_67_1.time_ <= var_70_11 + arg_70_0 then
				arg_67_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_70_12 = 0
			local var_70_13 = 0.55

			if var_70_12 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_14 = arg_67_1:FormatText(StoryNameCfg[236].name)

				arg_67_1.leftNameTxt_.text = var_70_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_15 = arg_67_1:GetWordFromCfg(103303017)
				local var_70_16 = arg_67_1:FormatText(var_70_15.content)

				arg_67_1.text_.text = var_70_16

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_17 = 22
				local var_70_18 = utf8.len(var_70_16)
				local var_70_19 = var_70_17 <= 0 and var_70_13 or var_70_13 * (var_70_18 / var_70_17)

				if var_70_19 > 0 and var_70_13 < var_70_19 then
					arg_67_1.talkMaxDuration = var_70_19

					if var_70_19 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_19 + var_70_12
					end
				end

				arg_67_1.text_.text = var_70_16
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303017", "story_v_side_old_103303.awb") ~= 0 then
					local var_70_20 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303017", "story_v_side_old_103303.awb") / 1000

					if var_70_20 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_20 + var_70_12
					end

					if var_70_15.prefab_name ~= "" and arg_67_1.actors_[var_70_15.prefab_name] ~= nil then
						local var_70_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_15.prefab_name].transform, "story_v_side_old_103303", "103303017", "story_v_side_old_103303.awb")

						arg_67_1:RecordAudio("103303017", var_70_21)
						arg_67_1:RecordAudio("103303017", var_70_21)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303017", "story_v_side_old_103303.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303017", "story_v_side_old_103303.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_22 = math.max(var_70_13, arg_67_1.talkMaxDuration)

			if var_70_12 <= arg_67_1.time_ and arg_67_1.time_ < var_70_12 + var_70_22 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_12) / var_70_22

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_12 + var_70_22 and arg_67_1.time_ < var_70_12 + var_70_22 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play103303018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 103303018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play103303019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1066ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1066ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, 100, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1066ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, 100, 0)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["1033ui_story"].transform
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.var_.moveOldPos1033ui_story = var_74_9.localPosition
			end

			local var_74_11 = 0.001

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11
				local var_74_13 = Vector3.New(0, 100, 0)

				var_74_9.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1033ui_story, var_74_13, var_74_12)

				local var_74_14 = manager.ui.mainCamera.transform.position - var_74_9.position

				var_74_9.forward = Vector3.New(var_74_14.x, var_74_14.y, var_74_14.z)

				local var_74_15 = var_74_9.localEulerAngles

				var_74_15.z = 0
				var_74_15.x = 0
				var_74_9.localEulerAngles = var_74_15
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 then
				var_74_9.localPosition = Vector3.New(0, 100, 0)

				local var_74_16 = manager.ui.mainCamera.transform.position - var_74_9.position

				var_74_9.forward = Vector3.New(var_74_16.x, var_74_16.y, var_74_16.z)

				local var_74_17 = var_74_9.localEulerAngles

				var_74_17.z = 0
				var_74_17.x = 0
				var_74_9.localEulerAngles = var_74_17
			end

			local var_74_18 = 0
			local var_74_19 = 0.575

			if var_74_18 < arg_71_1.time_ and arg_71_1.time_ <= var_74_18 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_20 = arg_71_1:GetWordFromCfg(103303018)
				local var_74_21 = arg_71_1:FormatText(var_74_20.content)

				arg_71_1.text_.text = var_74_21

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_22 = 23
				local var_74_23 = utf8.len(var_74_21)
				local var_74_24 = var_74_22 <= 0 and var_74_19 or var_74_19 * (var_74_23 / var_74_22)

				if var_74_24 > 0 and var_74_19 < var_74_24 then
					arg_71_1.talkMaxDuration = var_74_24

					if var_74_24 + var_74_18 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_24 + var_74_18
					end
				end

				arg_71_1.text_.text = var_74_21
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_25 = math.max(var_74_19, arg_71_1.talkMaxDuration)

			if var_74_18 <= arg_71_1.time_ and arg_71_1.time_ < var_74_18 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_18) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_18 + var_74_25 and arg_71_1.time_ < var_74_18 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play103303019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 103303019
		arg_75_1.duration_ = 16.57

		local var_75_0 = {
			ja = 16.566,
			ko = 11.433,
			zh = 8.033,
			en = 10.233
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
				arg_75_0:Play103303020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1033ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1033ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, -1.01, -6.13)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1033ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = arg_75_1.actors_["1033ui_story"]
			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1033ui_story == nil then
				arg_75_1.var_.characterEffect1033ui_story = var_78_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.2

			if var_78_10 <= arg_75_1.time_ and arg_75_1.time_ < var_78_10 + var_78_11 and not isNil(var_78_9) then
				local var_78_12 = (arg_75_1.time_ - var_78_10) / var_78_11

				if arg_75_1.var_.characterEffect1033ui_story and not isNil(var_78_9) then
					arg_75_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_10 + var_78_11 and arg_75_1.time_ < var_78_10 + var_78_11 + arg_78_0 and not isNil(var_78_9) and arg_75_1.var_.characterEffect1033ui_story then
				arg_75_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_78_13 = 0

			if var_78_13 < arg_75_1.time_ and arg_75_1.time_ <= var_78_13 + arg_78_0 then
				arg_75_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_2")
			end

			local var_78_14 = 0

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_78_15 = 0
			local var_78_16 = 0.975

			if var_78_15 < arg_75_1.time_ and arg_75_1.time_ <= var_78_15 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_17 = arg_75_1:FormatText(StoryNameCfg[236].name)

				arg_75_1.leftNameTxt_.text = var_78_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_18 = arg_75_1:GetWordFromCfg(103303019)
				local var_78_19 = arg_75_1:FormatText(var_78_18.content)

				arg_75_1.text_.text = var_78_19

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_20 = 39
				local var_78_21 = utf8.len(var_78_19)
				local var_78_22 = var_78_20 <= 0 and var_78_16 or var_78_16 * (var_78_21 / var_78_20)

				if var_78_22 > 0 and var_78_16 < var_78_22 then
					arg_75_1.talkMaxDuration = var_78_22

					if var_78_22 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_22 + var_78_15
					end
				end

				arg_75_1.text_.text = var_78_19
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303019", "story_v_side_old_103303.awb") ~= 0 then
					local var_78_23 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303019", "story_v_side_old_103303.awb") / 1000

					if var_78_23 + var_78_15 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_23 + var_78_15
					end

					if var_78_18.prefab_name ~= "" and arg_75_1.actors_[var_78_18.prefab_name] ~= nil then
						local var_78_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_18.prefab_name].transform, "story_v_side_old_103303", "103303019", "story_v_side_old_103303.awb")

						arg_75_1:RecordAudio("103303019", var_78_24)
						arg_75_1:RecordAudio("103303019", var_78_24)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303019", "story_v_side_old_103303.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303019", "story_v_side_old_103303.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_25 = math.max(var_78_16, arg_75_1.talkMaxDuration)

			if var_78_15 <= arg_75_1.time_ and arg_75_1.time_ < var_78_15 + var_78_25 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_15) / var_78_25

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_15 + var_78_25 and arg_75_1.time_ < var_78_15 + var_78_25 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play103303020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 103303020
		arg_79_1.duration_ = 11.33

		local var_79_0 = {
			ja = 11.333,
			ko = 5.933,
			zh = 3.966,
			en = 6.4
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
				arg_79_0:Play103303021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_1")
			end

			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_82_2 = 0
			local var_82_3 = 0.55

			if var_82_2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_4 = arg_79_1:FormatText(StoryNameCfg[236].name)

				arg_79_1.leftNameTxt_.text = var_82_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_5 = arg_79_1:GetWordFromCfg(103303020)
				local var_82_6 = arg_79_1:FormatText(var_82_5.content)

				arg_79_1.text_.text = var_82_6

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 22
				local var_82_8 = utf8.len(var_82_6)
				local var_82_9 = var_82_7 <= 0 and var_82_3 or var_82_3 * (var_82_8 / var_82_7)

				if var_82_9 > 0 and var_82_3 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_6
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303020", "story_v_side_old_103303.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303020", "story_v_side_old_103303.awb") / 1000

					if var_82_10 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_2
					end

					if var_82_5.prefab_name ~= "" and arg_79_1.actors_[var_82_5.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_5.prefab_name].transform, "story_v_side_old_103303", "103303020", "story_v_side_old_103303.awb")

						arg_79_1:RecordAudio("103303020", var_82_11)
						arg_79_1:RecordAudio("103303020", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303020", "story_v_side_old_103303.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303020", "story_v_side_old_103303.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_12 and arg_79_1.time_ < var_82_2 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play103303021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 103303021
		arg_83_1.duration_ = 11.87

		local var_83_0 = {
			ja = 11.866,
			ko = 4.133,
			zh = 5,
			en = 6.633
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
				arg_83_0:Play103303022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1033ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1033ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1033ui_story, var_86_4, var_86_3)

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

			local var_86_9 = 0
			local var_86_10 = 0.75

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_11 = arg_83_1:FormatText(StoryNameCfg[14].name)

				arg_83_1.leftNameTxt_.text = var_86_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_12 = arg_83_1:GetWordFromCfg(103303021)
				local var_86_13 = arg_83_1:FormatText(var_86_12.content)

				arg_83_1.text_.text = var_86_13

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_14 = 30
				local var_86_15 = utf8.len(var_86_13)
				local var_86_16 = var_86_14 <= 0 and var_86_10 or var_86_10 * (var_86_15 / var_86_14)

				if var_86_16 > 0 and var_86_10 < var_86_16 then
					arg_83_1.talkMaxDuration = var_86_16

					if var_86_16 + var_86_9 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_16 + var_86_9
					end
				end

				arg_83_1.text_.text = var_86_13
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303021", "story_v_side_old_103303.awb") ~= 0 then
					local var_86_17 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303021", "story_v_side_old_103303.awb") / 1000

					if var_86_17 + var_86_9 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_17 + var_86_9
					end

					if var_86_12.prefab_name ~= "" and arg_83_1.actors_[var_86_12.prefab_name] ~= nil then
						local var_86_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_12.prefab_name].transform, "story_v_side_old_103303", "103303021", "story_v_side_old_103303.awb")

						arg_83_1:RecordAudio("103303021", var_86_18)
						arg_83_1:RecordAudio("103303021", var_86_18)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303021", "story_v_side_old_103303.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303021", "story_v_side_old_103303.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_19 = math.max(var_86_10, arg_83_1.talkMaxDuration)

			if var_86_9 <= arg_83_1.time_ and arg_83_1.time_ < var_86_9 + var_86_19 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_9) / var_86_19

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_9 + var_86_19 and arg_83_1.time_ < var_86_9 + var_86_19 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play103303022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 103303022
		arg_87_1.duration_ = 15.5

		local var_87_0 = {
			ja = 15.5,
			ko = 12.6,
			zh = 10.233,
			en = 14.966
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
				arg_87_0:Play103303023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.325

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[14].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:GetWordFromCfg(103303022)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 53
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

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303022", "story_v_side_old_103303.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303022", "story_v_side_old_103303.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_side_old_103303", "103303022", "story_v_side_old_103303.awb")

						arg_87_1:RecordAudio("103303022", var_90_9)
						arg_87_1:RecordAudio("103303022", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303022", "story_v_side_old_103303.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303022", "story_v_side_old_103303.awb")
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
	Play103303023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 103303023
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play103303024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.875

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

				local var_94_2 = arg_91_1:GetWordFromCfg(103303023)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 35
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
	Play103303024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 103303024
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play103303025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.575

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:GetWordFromCfg(103303024)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 23
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_8 and arg_95_1.time_ < var_98_0 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play103303025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 103303025
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play103303026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 1.3

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[7].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(103303025)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 52
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
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_8 and arg_99_1.time_ < var_102_0 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play103303026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 103303026
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play103303027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.75

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[7].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:GetWordFromCfg(103303026)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 30
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_8 and arg_103_1.time_ < var_106_0 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play103303027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 103303027
		arg_107_1.duration_ = 1.03

		local var_107_0 = {
			ja = 0.999999999999,
			ko = 1,
			en = 1.033
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
				arg_107_0:Play103303028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.05

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[14].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(103303027)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 2
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303027", "story_v_side_old_103303.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303027", "story_v_side_old_103303.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_side_old_103303", "103303027", "story_v_side_old_103303.awb")

						arg_107_1:RecordAudio("103303027", var_110_9)
						arg_107_1:RecordAudio("103303027", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303027", "story_v_side_old_103303.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303027", "story_v_side_old_103303.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play103303028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 103303028
		arg_111_1.duration_ = 4.83

		local var_111_0 = {
			ja = 4.833,
			ko = 2.533,
			zh = 2.133,
			en = 2.7
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
				arg_111_0:Play103303029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.225

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[14].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(103303028)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303028", "story_v_side_old_103303.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303028", "story_v_side_old_103303.awb") / 1000

					if var_114_8 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_0
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_side_old_103303", "103303028", "story_v_side_old_103303.awb")

						arg_111_1:RecordAudio("103303028", var_114_9)
						arg_111_1:RecordAudio("103303028", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303028", "story_v_side_old_103303.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303028", "story_v_side_old_103303.awb")
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
	Play103303029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 103303029
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play103303030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.975

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(103303029)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 39
				local var_118_5 = utf8.len(var_118_3)
				local var_118_6 = var_118_4 <= 0 and var_118_1 or var_118_1 * (var_118_5 / var_118_4)

				if var_118_6 > 0 and var_118_1 < var_118_6 then
					arg_115_1.talkMaxDuration = var_118_6

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_7 and arg_115_1.time_ < var_118_0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play103303030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 103303030
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play103303031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 1.05

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(103303030)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 42
				local var_122_5 = utf8.len(var_122_3)
				local var_122_6 = var_122_4 <= 0 and var_122_1 or var_122_1 * (var_122_5 / var_122_4)

				if var_122_6 > 0 and var_122_1 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_7 and arg_119_1.time_ < var_122_0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play103303031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 103303031
		arg_123_1.duration_ = 7

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play103303032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				local var_126_1 = manager.ui.mainCamera.transform.localPosition
				local var_126_2 = Vector3.New(0, 0, 10) + Vector3.New(var_126_1.x, var_126_1.y, 0)
				local var_126_3 = arg_123_1.bgs_.ST18

				var_126_3.transform.localPosition = var_126_2
				var_126_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_4 = var_126_3:GetComponent("SpriteRenderer")

				if var_126_4 and var_126_4.sprite then
					local var_126_5 = (var_126_3.transform.localPosition - var_126_1).z
					local var_126_6 = manager.ui.mainCameraCom_
					local var_126_7 = 2 * var_126_5 * Mathf.Tan(var_126_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_126_8 = var_126_7 * var_126_6.aspect
					local var_126_9 = var_126_4.sprite.bounds.size.x
					local var_126_10 = var_126_4.sprite.bounds.size.y
					local var_126_11 = var_126_8 / var_126_9
					local var_126_12 = var_126_7 / var_126_10
					local var_126_13 = var_126_12 < var_126_11 and var_126_11 or var_126_12

					var_126_3.transform.localScale = Vector3.New(var_126_13, var_126_13, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "ST18" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_14 = "ST12"

			if arg_123_1.bgs_[var_126_14] == nil then
				local var_126_15 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_126_14)
				var_126_15.name = var_126_14
				var_126_15.transform.parent = arg_123_1.stage_.transform
				var_126_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_[var_126_14] = var_126_15
			end

			local var_126_16 = 1

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				local var_126_17 = manager.ui.mainCamera.transform.localPosition
				local var_126_18 = Vector3.New(0, 0, 10) + Vector3.New(var_126_17.x, var_126_17.y, 0)
				local var_126_19 = arg_123_1.bgs_.ST12

				var_126_19.transform.localPosition = var_126_18
				var_126_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_20 = var_126_19:GetComponent("SpriteRenderer")

				if var_126_20 and var_126_20.sprite then
					local var_126_21 = (var_126_19.transform.localPosition - var_126_17).z
					local var_126_22 = manager.ui.mainCameraCom_
					local var_126_23 = 2 * var_126_21 * Mathf.Tan(var_126_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_126_24 = var_126_23 * var_126_22.aspect
					local var_126_25 = var_126_20.sprite.bounds.size.x
					local var_126_26 = var_126_20.sprite.bounds.size.y
					local var_126_27 = var_126_24 / var_126_25
					local var_126_28 = var_126_23 / var_126_26
					local var_126_29 = var_126_28 < var_126_27 and var_126_27 or var_126_28

					var_126_19.transform.localScale = Vector3.New(var_126_29, var_126_29, 0)
				end

				for iter_126_2, iter_126_3 in pairs(arg_123_1.bgs_) do
					if iter_126_2 ~= "ST12" then
						iter_126_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_30 = 0

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = false

				arg_123_1:SetGaussion(false)
			end

			local var_126_31 = 1

			if var_126_30 <= arg_123_1.time_ and arg_123_1.time_ < var_126_30 + var_126_31 then
				local var_126_32 = (arg_123_1.time_ - var_126_30) / var_126_31
				local var_126_33 = Color.New(0, 0, 0)

				var_126_33.a = Mathf.Lerp(0, 1, var_126_32)
				arg_123_1.mask_.color = var_126_33
			end

			if arg_123_1.time_ >= var_126_30 + var_126_31 and arg_123_1.time_ < var_126_30 + var_126_31 + arg_126_0 then
				local var_126_34 = Color.New(0, 0, 0)

				var_126_34.a = 1
				arg_123_1.mask_.color = var_126_34
			end

			local var_126_35 = 1

			if var_126_35 < arg_123_1.time_ and arg_123_1.time_ <= var_126_35 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = false

				arg_123_1:SetGaussion(false)
			end

			local var_126_36 = 1

			if var_126_35 <= arg_123_1.time_ and arg_123_1.time_ < var_126_35 + var_126_36 then
				local var_126_37 = (arg_123_1.time_ - var_126_35) / var_126_36
				local var_126_38 = Color.New(0, 0, 0)

				var_126_38.a = Mathf.Lerp(1, 0, var_126_37)
				arg_123_1.mask_.color = var_126_38
			end

			if arg_123_1.time_ >= var_126_35 + var_126_36 and arg_123_1.time_ < var_126_35 + var_126_36 + arg_126_0 then
				local var_126_39 = Color.New(0, 0, 0)
				local var_126_40 = 0

				arg_123_1.mask_.enabled = false
				var_126_39.a = var_126_40
				arg_123_1.mask_.color = var_126_39
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_41 = 2
			local var_126_42 = 0.6

			if var_126_41 < arg_123_1.time_ and arg_123_1.time_ <= var_126_41 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_43 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_43:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_44 = arg_123_1:GetWordFromCfg(103303031)
				local var_126_45 = arg_123_1:FormatText(var_126_44.content)

				arg_123_1.text_.text = var_126_45

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_46 = 24
				local var_126_47 = utf8.len(var_126_45)
				local var_126_48 = var_126_46 <= 0 and var_126_42 or var_126_42 * (var_126_47 / var_126_46)

				if var_126_48 > 0 and var_126_42 < var_126_48 then
					arg_123_1.talkMaxDuration = var_126_48
					var_126_41 = var_126_41 + 0.3

					if var_126_48 + var_126_41 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_48 + var_126_41
					end
				end

				arg_123_1.text_.text = var_126_45
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_49 = var_126_41 + 0.3
			local var_126_50 = math.max(var_126_42, arg_123_1.talkMaxDuration)

			if var_126_49 <= arg_123_1.time_ and arg_123_1.time_ < var_126_49 + var_126_50 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_49) / var_126_50

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_49 + var_126_50 and arg_123_1.time_ < var_126_49 + var_126_50 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play103303032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 103303032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play103303033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.7

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(103303032)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 28
				local var_132_5 = utf8.len(var_132_3)
				local var_132_6 = var_132_4 <= 0 and var_132_1 or var_132_1 * (var_132_5 / var_132_4)

				if var_132_6 > 0 and var_132_1 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_7 and arg_129_1.time_ < var_132_0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play103303033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 103303033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play103303034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.975

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(103303033)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 39
				local var_136_5 = utf8.len(var_136_3)
				local var_136_6 = var_136_4 <= 0 and var_136_1 or var_136_1 * (var_136_5 / var_136_4)

				if var_136_6 > 0 and var_136_1 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_7 and arg_133_1.time_ < var_136_0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play103303034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 103303034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play103303035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.525

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:GetWordFromCfg(103303034)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 21
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play103303035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 103303035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play103303036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = manager.ui.mainCamera.transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.shakeOldPos = var_144_0.localPosition
			end

			local var_144_2 = 0.25

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / 0.066
				local var_144_4, var_144_5 = math.modf(var_144_3)

				var_144_0.localPosition = Vector3.New(var_144_5 * 0.13, var_144_5 * 0.13, var_144_5 * 0.13) + arg_141_1.var_.shakeOldPos
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = arg_141_1.var_.shakeOldPos
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

				local var_144_9 = arg_141_1:GetWordFromCfg(103303035)
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
	Play103303036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 103303036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play103303037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.7

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(103303036)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 28
				local var_148_5 = utf8.len(var_148_3)
				local var_148_6 = var_148_4 <= 0 and var_148_1 or var_148_1 * (var_148_5 / var_148_4)

				if var_148_6 > 0 and var_148_1 < var_148_6 then
					arg_145_1.talkMaxDuration = var_148_6

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_7 and arg_145_1.time_ < var_148_0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play103303037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 103303037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play103303038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.475

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_2

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

				local var_152_3 = arg_149_1:GetWordFromCfg(103303037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 19
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play103303038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 103303038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play103303039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 1.4

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(103303038)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 56
				local var_156_5 = utf8.len(var_156_3)
				local var_156_6 = var_156_4 <= 0 and var_156_1 or var_156_1 * (var_156_5 / var_156_4)

				if var_156_6 > 0 and var_156_1 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_7 and arg_153_1.time_ < var_156_0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play103303039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 103303039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play103303040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.7

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

				local var_160_2 = arg_157_1:GetWordFromCfg(103303039)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 28
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
	Play103303040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 103303040
		arg_161_1.duration_ = 7.9

		local var_161_0 = {
			ja = 7.9,
			ko = 5.933,
			zh = 4.366,
			en = 5.5
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
				arg_161_0:Play103303041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1033ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1033ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(0, -1.01, -6.13)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1033ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = arg_161_1.actors_["1033ui_story"]
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1033ui_story == nil then
				arg_161_1.var_.characterEffect1033ui_story = var_164_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_11 = 0.2

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 and not isNil(var_164_9) then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11

				if arg_161_1.var_.characterEffect1033ui_story and not isNil(var_164_9) then
					arg_161_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1033ui_story then
				arg_161_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_164_13 = 0

			if var_164_13 < arg_161_1.time_ and arg_161_1.time_ <= var_164_13 + arg_164_0 then
				arg_161_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			local var_164_14 = 0

			if var_164_14 < arg_161_1.time_ and arg_161_1.time_ <= var_164_14 + arg_164_0 then
				arg_161_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_164_15 = 0
			local var_164_16 = 0.6

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_17 = arg_161_1:FormatText(StoryNameCfg[236].name)

				arg_161_1.leftNameTxt_.text = var_164_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(103303040)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_20 = 24
				local var_164_21 = utf8.len(var_164_19)
				local var_164_22 = var_164_20 <= 0 and var_164_16 or var_164_16 * (var_164_21 / var_164_20)

				if var_164_22 > 0 and var_164_16 < var_164_22 then
					arg_161_1.talkMaxDuration = var_164_22

					if var_164_22 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_22 + var_164_15
					end
				end

				arg_161_1.text_.text = var_164_19
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303040", "story_v_side_old_103303.awb") ~= 0 then
					local var_164_23 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303040", "story_v_side_old_103303.awb") / 1000

					if var_164_23 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_23 + var_164_15
					end

					if var_164_18.prefab_name ~= "" and arg_161_1.actors_[var_164_18.prefab_name] ~= nil then
						local var_164_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_18.prefab_name].transform, "story_v_side_old_103303", "103303040", "story_v_side_old_103303.awb")

						arg_161_1:RecordAudio("103303040", var_164_24)
						arg_161_1:RecordAudio("103303040", var_164_24)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303040", "story_v_side_old_103303.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303040", "story_v_side_old_103303.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_25 = math.max(var_164_16, arg_161_1.talkMaxDuration)

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_25 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_15) / var_164_25

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_15 + var_164_25 and arg_161_1.time_ < var_164_15 + var_164_25 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play103303041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 103303041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play103303042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1033ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1033ui_story == nil then
				arg_165_1.var_.characterEffect1033ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1033ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1033ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1033ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1033ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 0.3

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_8 = arg_165_1:FormatText(StoryNameCfg[7].name)

				arg_165_1.leftNameTxt_.text = var_168_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_9 = arg_165_1:GetWordFromCfg(103303041)
				local var_168_10 = arg_165_1:FormatText(var_168_9.content)

				arg_165_1.text_.text = var_168_10

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 12
				local var_168_12 = utf8.len(var_168_10)
				local var_168_13 = var_168_11 <= 0 and var_168_7 or var_168_7 * (var_168_12 / var_168_11)

				if var_168_13 > 0 and var_168_7 < var_168_13 then
					arg_165_1.talkMaxDuration = var_168_13

					if var_168_13 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_13 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_10
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_14 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_14 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_14

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_14 and arg_165_1.time_ < var_168_6 + var_168_14 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play103303042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 103303042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play103303043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1033ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1033ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0, 100, 0)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1033ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, 100, 0)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = 0
			local var_172_10 = 0.6

			if var_172_9 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_11 = arg_169_1:GetWordFromCfg(103303042)
				local var_172_12 = arg_169_1:FormatText(var_172_11.content)

				arg_169_1.text_.text = var_172_12

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 24
				local var_172_14 = utf8.len(var_172_12)
				local var_172_15 = var_172_13 <= 0 and var_172_10 or var_172_10 * (var_172_14 / var_172_13)

				if var_172_15 > 0 and var_172_10 < var_172_15 then
					arg_169_1.talkMaxDuration = var_172_15

					if var_172_15 + var_172_9 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_9
					end
				end

				arg_169_1.text_.text = var_172_12
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_10, arg_169_1.talkMaxDuration)

			if var_172_9 <= arg_169_1.time_ and arg_169_1.time_ < var_172_9 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_9) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_9 + var_172_16 and arg_169_1.time_ < var_172_9 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play103303043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 103303043
		arg_173_1.duration_ = 10.1

		local var_173_0 = {
			ja = 9.533,
			ko = 8.866,
			zh = 6.733,
			en = 10.1
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
				arg_173_0:Play103303044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1033ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1033ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, -1.01, -6.13)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1033ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1033ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1033ui_story == nil then
				arg_173_1.var_.characterEffect1033ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.2

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect1033ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1033ui_story then
				arg_173_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action423")
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_176_15 = 0
			local var_176_16 = 0.825

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_17 = arg_173_1:FormatText(StoryNameCfg[236].name)

				arg_173_1.leftNameTxt_.text = var_176_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_18 = arg_173_1:GetWordFromCfg(103303043)
				local var_176_19 = arg_173_1:FormatText(var_176_18.content)

				arg_173_1.text_.text = var_176_19

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_20 = 33
				local var_176_21 = utf8.len(var_176_19)
				local var_176_22 = var_176_20 <= 0 and var_176_16 or var_176_16 * (var_176_21 / var_176_20)

				if var_176_22 > 0 and var_176_16 < var_176_22 then
					arg_173_1.talkMaxDuration = var_176_22

					if var_176_22 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_22 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_19
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303043", "story_v_side_old_103303.awb") ~= 0 then
					local var_176_23 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303043", "story_v_side_old_103303.awb") / 1000

					if var_176_23 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_23 + var_176_15
					end

					if var_176_18.prefab_name ~= "" and arg_173_1.actors_[var_176_18.prefab_name] ~= nil then
						local var_176_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_18.prefab_name].transform, "story_v_side_old_103303", "103303043", "story_v_side_old_103303.awb")

						arg_173_1:RecordAudio("103303043", var_176_24)
						arg_173_1:RecordAudio("103303043", var_176_24)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303043", "story_v_side_old_103303.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303043", "story_v_side_old_103303.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_25 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_25 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_25

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_25 and arg_173_1.time_ < var_176_15 + var_176_25 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play103303044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 103303044
		arg_177_1.duration_ = 11.47

		local var_177_0 = {
			ja = 11.466,
			ko = 7.966,
			zh = 6.266,
			en = 8.9
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
				arg_177_0:Play103303045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_180_1 = 0
			local var_180_2 = 0.7

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_3 = arg_177_1:FormatText(StoryNameCfg[236].name)

				arg_177_1.leftNameTxt_.text = var_180_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:GetWordFromCfg(103303044)
				local var_180_5 = arg_177_1:FormatText(var_180_4.content)

				arg_177_1.text_.text = var_180_5

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 28
				local var_180_7 = utf8.len(var_180_5)
				local var_180_8 = var_180_6 <= 0 and var_180_2 or var_180_2 * (var_180_7 / var_180_6)

				if var_180_8 > 0 and var_180_2 < var_180_8 then
					arg_177_1.talkMaxDuration = var_180_8

					if var_180_8 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_5
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303044", "story_v_side_old_103303.awb") ~= 0 then
					local var_180_9 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303044", "story_v_side_old_103303.awb") / 1000

					if var_180_9 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_1
					end

					if var_180_4.prefab_name ~= "" and arg_177_1.actors_[var_180_4.prefab_name] ~= nil then
						local var_180_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_4.prefab_name].transform, "story_v_side_old_103303", "103303044", "story_v_side_old_103303.awb")

						arg_177_1:RecordAudio("103303044", var_180_10)
						arg_177_1:RecordAudio("103303044", var_180_10)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303044", "story_v_side_old_103303.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303044", "story_v_side_old_103303.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_11 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_11 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_11

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_11 and arg_177_1.time_ < var_180_1 + var_180_11 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play103303045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 103303045
		arg_181_1.duration_ = 9.87

		local var_181_0 = {
			ja = 9.866,
			ko = 9.733,
			zh = 6.8,
			en = 9.1
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
				arg_181_0:Play103303046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action434")
			end

			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_184_2 = 0
			local var_184_3 = 0.725

			if var_184_2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_4 = arg_181_1:FormatText(StoryNameCfg[236].name)

				arg_181_1.leftNameTxt_.text = var_184_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_5 = arg_181_1:GetWordFromCfg(103303045)
				local var_184_6 = arg_181_1:FormatText(var_184_5.content)

				arg_181_1.text_.text = var_184_6

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 29
				local var_184_8 = utf8.len(var_184_6)
				local var_184_9 = var_184_7 <= 0 and var_184_3 or var_184_3 * (var_184_8 / var_184_7)

				if var_184_9 > 0 and var_184_3 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_6
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303045", "story_v_side_old_103303.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303045", "story_v_side_old_103303.awb") / 1000

					if var_184_10 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_2
					end

					if var_184_5.prefab_name ~= "" and arg_181_1.actors_[var_184_5.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_5.prefab_name].transform, "story_v_side_old_103303", "103303045", "story_v_side_old_103303.awb")

						arg_181_1:RecordAudio("103303045", var_184_11)
						arg_181_1:RecordAudio("103303045", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303045", "story_v_side_old_103303.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303045", "story_v_side_old_103303.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_12 and arg_181_1.time_ < var_184_2 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play103303046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 103303046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play103303047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1033ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1033ui_story == nil then
				arg_185_1.var_.characterEffect1033ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1033ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1033ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1033ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1033ui_story.fillRatio = var_188_5
			end

			local var_188_6 = 0
			local var_188_7 = 1

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_8 = arg_185_1:GetWordFromCfg(103303046)
				local var_188_9 = arg_185_1:FormatText(var_188_8.content)

				arg_185_1.text_.text = var_188_9

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_10 = 40
				local var_188_11 = utf8.len(var_188_9)
				local var_188_12 = var_188_10 <= 0 and var_188_7 or var_188_7 * (var_188_11 / var_188_10)

				if var_188_12 > 0 and var_188_7 < var_188_12 then
					arg_185_1.talkMaxDuration = var_188_12

					if var_188_12 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_9
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_13 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_13 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_13

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_13 and arg_185_1.time_ < var_188_6 + var_188_13 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play103303047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 103303047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play103303048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 1.35

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(103303047)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 54
				local var_192_5 = utf8.len(var_192_3)
				local var_192_6 = var_192_4 <= 0 and var_192_1 or var_192_1 * (var_192_5 / var_192_4)

				if var_192_6 > 0 and var_192_1 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_7 and arg_189_1.time_ < var_192_0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play103303048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 103303048
		arg_193_1.duration_ = 15.87

		local var_193_0 = {
			ja = 15.866,
			ko = 8.166,
			zh = 7.233,
			en = 9.566
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
				arg_193_0:Play103303049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1033ui_story"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1033ui_story == nil then
				arg_193_1.var_.characterEffect1033ui_story = var_196_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.characterEffect1033ui_story and not isNil(var_196_0) then
					arg_193_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.characterEffect1033ui_story then
				arg_193_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_196_4 = 0

			if var_196_4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action448")
			end

			local var_196_5 = 0

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_196_6 = 0
			local var_196_7 = 0.925

			if var_196_6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_8 = arg_193_1:FormatText(StoryNameCfg[236].name)

				arg_193_1.leftNameTxt_.text = var_196_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_9 = arg_193_1:GetWordFromCfg(103303048)
				local var_196_10 = arg_193_1:FormatText(var_196_9.content)

				arg_193_1.text_.text = var_196_10

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 37
				local var_196_12 = utf8.len(var_196_10)
				local var_196_13 = var_196_11 <= 0 and var_196_7 or var_196_7 * (var_196_12 / var_196_11)

				if var_196_13 > 0 and var_196_7 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_10
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303048", "story_v_side_old_103303.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303048", "story_v_side_old_103303.awb") / 1000

					if var_196_14 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_6
					end

					if var_196_9.prefab_name ~= "" and arg_193_1.actors_[var_196_9.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_9.prefab_name].transform, "story_v_side_old_103303", "103303048", "story_v_side_old_103303.awb")

						arg_193_1:RecordAudio("103303048", var_196_15)
						arg_193_1:RecordAudio("103303048", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303048", "story_v_side_old_103303.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303048", "story_v_side_old_103303.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_16 and arg_193_1.time_ < var_196_6 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play103303049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 103303049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play103303050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1033ui_story"]
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1033ui_story == nil then
				arg_197_1.var_.characterEffect1033ui_story = var_200_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.2

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 and not isNil(var_200_0) then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2

				if arg_197_1.var_.characterEffect1033ui_story and not isNil(var_200_0) then
					local var_200_4 = Mathf.Lerp(0, 0.5, var_200_3)

					arg_197_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1033ui_story.fillRatio = var_200_4
				end
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 and not isNil(var_200_0) and arg_197_1.var_.characterEffect1033ui_story then
				local var_200_5 = 0.5

				arg_197_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1033ui_story.fillRatio = var_200_5
			end

			local var_200_6 = 0
			local var_200_7 = 0.4

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_8 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_8

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

				local var_200_9 = arg_197_1:GetWordFromCfg(103303049)
				local var_200_10 = arg_197_1:FormatText(var_200_9.content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 16
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
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play103303050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 103303050
		arg_201_1.duration_ = 14.57

		local var_201_0 = {
			ja = 14.566,
			ko = 7.733,
			zh = 6.033,
			en = 9.533
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
				arg_201_0:Play103303051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1033ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1033ui_story == nil then
				arg_201_1.var_.characterEffect1033ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1033ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1033ui_story then
				arg_201_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_204_4 = 0

			if var_204_4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_204_5 = 0
			local var_204_6 = 0.775

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_7 = arg_201_1:FormatText(StoryNameCfg[236].name)

				arg_201_1.leftNameTxt_.text = var_204_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:GetWordFromCfg(103303050)
				local var_204_9 = arg_201_1:FormatText(var_204_8.content)

				arg_201_1.text_.text = var_204_9

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 31
				local var_204_11 = utf8.len(var_204_9)
				local var_204_12 = var_204_10 <= 0 and var_204_6 or var_204_6 * (var_204_11 / var_204_10)

				if var_204_12 > 0 and var_204_6 < var_204_12 then
					arg_201_1.talkMaxDuration = var_204_12

					if var_204_12 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_9
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303050", "story_v_side_old_103303.awb") ~= 0 then
					local var_204_13 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303050", "story_v_side_old_103303.awb") / 1000

					if var_204_13 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_5
					end

					if var_204_8.prefab_name ~= "" and arg_201_1.actors_[var_204_8.prefab_name] ~= nil then
						local var_204_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_8.prefab_name].transform, "story_v_side_old_103303", "103303050", "story_v_side_old_103303.awb")

						arg_201_1:RecordAudio("103303050", var_204_14)
						arg_201_1:RecordAudio("103303050", var_204_14)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303050", "story_v_side_old_103303.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303050", "story_v_side_old_103303.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_15 = math.max(var_204_6, arg_201_1.talkMaxDuration)

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_15 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_5) / var_204_15

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_5 + var_204_15 and arg_201_1.time_ < var_204_5 + var_204_15 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play103303051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 103303051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play103303052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1033ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1033ui_story == nil then
				arg_205_1.var_.characterEffect1033ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect1033ui_story and not isNil(var_208_0) then
					local var_208_4 = Mathf.Lerp(0, 0.5, var_208_3)

					arg_205_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1033ui_story.fillRatio = var_208_4
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1033ui_story then
				local var_208_5 = 0.5

				arg_205_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1033ui_story.fillRatio = var_208_5
			end

			local var_208_6 = 0
			local var_208_7 = 0.4

			if var_208_6 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_8 = arg_205_1:GetWordFromCfg(103303051)
				local var_208_9 = arg_205_1:FormatText(var_208_8.content)

				arg_205_1.text_.text = var_208_9

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_10 = 16
				local var_208_11 = utf8.len(var_208_9)
				local var_208_12 = var_208_10 <= 0 and var_208_7 or var_208_7 * (var_208_11 / var_208_10)

				if var_208_12 > 0 and var_208_7 < var_208_12 then
					arg_205_1.talkMaxDuration = var_208_12

					if var_208_12 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_9
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_13 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_13 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_13

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_13 and arg_205_1.time_ < var_208_6 + var_208_13 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play103303052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 103303052
		arg_209_1.duration_ = 11.47

		local var_209_0 = {
			ja = 11.466,
			ko = 9.8,
			zh = 9.8,
			en = 7.7
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
				arg_209_0:Play103303053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1033ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1033ui_story == nil then
				arg_209_1.var_.characterEffect1033ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1033ui_story and not isNil(var_212_0) then
					arg_209_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1033ui_story then
				arg_209_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_212_4 = 0

			if var_212_4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action484")
			end

			local var_212_5 = 0

			if var_212_5 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_212_6 = 0
			local var_212_7 = 1.025

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_8 = arg_209_1:FormatText(StoryNameCfg[236].name)

				arg_209_1.leftNameTxt_.text = var_212_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_9 = arg_209_1:GetWordFromCfg(103303052)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 41
				local var_212_12 = utf8.len(var_212_10)
				local var_212_13 = var_212_11 <= 0 and var_212_7 or var_212_7 * (var_212_12 / var_212_11)

				if var_212_13 > 0 and var_212_7 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303052", "story_v_side_old_103303.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303052", "story_v_side_old_103303.awb") / 1000

					if var_212_14 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_6
					end

					if var_212_9.prefab_name ~= "" and arg_209_1.actors_[var_212_9.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_9.prefab_name].transform, "story_v_side_old_103303", "103303052", "story_v_side_old_103303.awb")

						arg_209_1:RecordAudio("103303052", var_212_15)
						arg_209_1:RecordAudio("103303052", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303052", "story_v_side_old_103303.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303052", "story_v_side_old_103303.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_16 and arg_209_1.time_ < var_212_6 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play103303053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 103303053
		arg_213_1.duration_ = 4.67

		local var_213_0 = {
			ja = 4.2,
			ko = 4.666,
			zh = 4.066,
			en = 2.066
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
				arg_213_0:Play103303054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action442")
			end

			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_216_2 = 0
			local var_216_3 = 0.45

			if var_216_2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_4 = arg_213_1:FormatText(StoryNameCfg[236].name)

				arg_213_1.leftNameTxt_.text = var_216_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_5 = arg_213_1:GetWordFromCfg(103303053)
				local var_216_6 = arg_213_1:FormatText(var_216_5.content)

				arg_213_1.text_.text = var_216_6

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_7 = 18
				local var_216_8 = utf8.len(var_216_6)
				local var_216_9 = var_216_7 <= 0 and var_216_3 or var_216_3 * (var_216_8 / var_216_7)

				if var_216_9 > 0 and var_216_3 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_2
					end
				end

				arg_213_1.text_.text = var_216_6
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303053", "story_v_side_old_103303.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303053", "story_v_side_old_103303.awb") / 1000

					if var_216_10 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_2
					end

					if var_216_5.prefab_name ~= "" and arg_213_1.actors_[var_216_5.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_5.prefab_name].transform, "story_v_side_old_103303", "103303053", "story_v_side_old_103303.awb")

						arg_213_1:RecordAudio("103303053", var_216_11)
						arg_213_1:RecordAudio("103303053", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303053", "story_v_side_old_103303.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303053", "story_v_side_old_103303.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_3, arg_213_1.talkMaxDuration)

			if var_216_2 <= arg_213_1.time_ and arg_213_1.time_ < var_216_2 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_2) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_2 + var_216_12 and arg_213_1.time_ < var_216_2 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play103303054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 103303054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play103303055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1033ui_story"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1033ui_story == nil then
				arg_217_1.var_.characterEffect1033ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.characterEffect1033ui_story and not isNil(var_220_0) then
					local var_220_4 = Mathf.Lerp(0, 0.5, var_220_3)

					arg_217_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1033ui_story.fillRatio = var_220_4
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect1033ui_story then
				local var_220_5 = 0.5

				arg_217_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1033ui_story.fillRatio = var_220_5
			end

			local var_220_6 = 0
			local var_220_7 = 1.425

			if var_220_6 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_8 = arg_217_1:GetWordFromCfg(103303054)
				local var_220_9 = arg_217_1:FormatText(var_220_8.content)

				arg_217_1.text_.text = var_220_9

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 57
				local var_220_11 = utf8.len(var_220_9)
				local var_220_12 = var_220_10 <= 0 and var_220_7 or var_220_7 * (var_220_11 / var_220_10)

				if var_220_12 > 0 and var_220_7 < var_220_12 then
					arg_217_1.talkMaxDuration = var_220_12

					if var_220_12 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_9
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_13 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_13 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_13

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_13 and arg_217_1.time_ < var_220_6 + var_220_13 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play103303055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 103303055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play103303056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.225

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

				local var_224_3 = arg_221_1:GetWordFromCfg(103303055)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 9
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
	Play103303056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 103303056
		arg_225_1.duration_ = 10.2

		local var_225_0 = {
			ja = 10.2,
			ko = 6.033,
			zh = 6.2,
			en = 5.733
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
				arg_225_0:Play103303057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1033ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1033ui_story == nil then
				arg_225_1.var_.characterEffect1033ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1033ui_story and not isNil(var_228_0) then
					arg_225_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1033ui_story then
				arg_225_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_228_4 = 0

			if var_228_4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action428")
			end

			local var_228_5 = 0

			if var_228_5 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_228_6 = 0
			local var_228_7 = 0.9

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[236].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_9 = arg_225_1:GetWordFromCfg(103303056)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 36
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303056", "story_v_side_old_103303.awb") ~= 0 then
					local var_228_14 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303056", "story_v_side_old_103303.awb") / 1000

					if var_228_14 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_14 + var_228_6
					end

					if var_228_9.prefab_name ~= "" and arg_225_1.actors_[var_228_9.prefab_name] ~= nil then
						local var_228_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_9.prefab_name].transform, "story_v_side_old_103303", "103303056", "story_v_side_old_103303.awb")

						arg_225_1:RecordAudio("103303056", var_228_15)
						arg_225_1:RecordAudio("103303056", var_228_15)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303056", "story_v_side_old_103303.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303056", "story_v_side_old_103303.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_16 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_16 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_16

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_16 and arg_225_1.time_ < var_228_6 + var_228_16 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play103303057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 103303057
		arg_229_1.duration_ = 10.83

		local var_229_0 = {
			ja = 10.833,
			ko = 10,
			zh = 6.466,
			en = 6.5
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
				arg_229_0:Play103303058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_232_1 = 0
			local var_232_2 = 0.875

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_3 = arg_229_1:FormatText(StoryNameCfg[236].name)

				arg_229_1.leftNameTxt_.text = var_232_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(103303057)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_6 = 35
				local var_232_7 = utf8.len(var_232_5)
				local var_232_8 = var_232_6 <= 0 and var_232_2 or var_232_2 * (var_232_7 / var_232_6)

				if var_232_8 > 0 and var_232_2 < var_232_8 then
					arg_229_1.talkMaxDuration = var_232_8

					if var_232_8 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303057", "story_v_side_old_103303.awb") ~= 0 then
					local var_232_9 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303057", "story_v_side_old_103303.awb") / 1000

					if var_232_9 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_1
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_side_old_103303", "103303057", "story_v_side_old_103303.awb")

						arg_229_1:RecordAudio("103303057", var_232_10)
						arg_229_1:RecordAudio("103303057", var_232_10)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303057", "story_v_side_old_103303.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303057", "story_v_side_old_103303.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_11 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_11 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_11

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_11 and arg_229_1.time_ < var_232_1 + var_232_11 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play103303058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 103303058
		arg_233_1.duration_ = 9

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play103303059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_1 = 2

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_1 then
				local var_236_2 = (arg_233_1.time_ - var_236_0) / var_236_1
				local var_236_3 = Color.New(0, 0, 0)

				var_236_3.a = Mathf.Lerp(0, 1, var_236_2)
				arg_233_1.mask_.color = var_236_3
			end

			if arg_233_1.time_ >= var_236_0 + var_236_1 and arg_233_1.time_ < var_236_0 + var_236_1 + arg_236_0 then
				local var_236_4 = Color.New(0, 0, 0)

				var_236_4.a = 1
				arg_233_1.mask_.color = var_236_4
			end

			local var_236_5 = 2

			if var_236_5 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_6 = 2

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 then
				local var_236_7 = (arg_233_1.time_ - var_236_5) / var_236_6
				local var_236_8 = Color.New(0, 0, 0)

				var_236_8.a = Mathf.Lerp(1, 0, var_236_7)
				arg_233_1.mask_.color = var_236_8
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 then
				local var_236_9 = Color.New(0, 0, 0)
				local var_236_10 = 0

				arg_233_1.mask_.enabled = false
				var_236_9.a = var_236_10
				arg_233_1.mask_.color = var_236_9
			end

			local var_236_11 = arg_233_1.actors_["1033ui_story"].transform
			local var_236_12 = 1.966

			if var_236_12 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				arg_233_1.var_.moveOldPos1033ui_story = var_236_11.localPosition
			end

			local var_236_13 = 0.001

			if var_236_12 <= arg_233_1.time_ and arg_233_1.time_ < var_236_12 + var_236_13 then
				local var_236_14 = (arg_233_1.time_ - var_236_12) / var_236_13
				local var_236_15 = Vector3.New(0, 100, 0)

				var_236_11.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1033ui_story, var_236_15, var_236_14)

				local var_236_16 = manager.ui.mainCamera.transform.position - var_236_11.position

				var_236_11.forward = Vector3.New(var_236_16.x, var_236_16.y, var_236_16.z)

				local var_236_17 = var_236_11.localEulerAngles

				var_236_17.z = 0
				var_236_17.x = 0
				var_236_11.localEulerAngles = var_236_17
			end

			if arg_233_1.time_ >= var_236_12 + var_236_13 and arg_233_1.time_ < var_236_12 + var_236_13 + arg_236_0 then
				var_236_11.localPosition = Vector3.New(0, 100, 0)

				local var_236_18 = manager.ui.mainCamera.transform.position - var_236_11.position

				var_236_11.forward = Vector3.New(var_236_18.x, var_236_18.y, var_236_18.z)

				local var_236_19 = var_236_11.localEulerAngles

				var_236_19.z = 0
				var_236_19.x = 0
				var_236_11.localEulerAngles = var_236_19
			end

			local var_236_20 = 2

			if var_236_20 < arg_233_1.time_ and arg_233_1.time_ <= var_236_20 + arg_236_0 then
				local var_236_21 = manager.ui.mainCamera.transform.localPosition
				local var_236_22 = Vector3.New(0, 0, 10) + Vector3.New(var_236_21.x, var_236_21.y, 0)
				local var_236_23 = arg_233_1.bgs_.ST12

				var_236_23.transform.localPosition = var_236_22
				var_236_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_24 = var_236_23:GetComponent("SpriteRenderer")

				if var_236_24 and var_236_24.sprite then
					local var_236_25 = (var_236_23.transform.localPosition - var_236_21).z
					local var_236_26 = manager.ui.mainCameraCom_
					local var_236_27 = 2 * var_236_25 * Mathf.Tan(var_236_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_236_28 = var_236_27 * var_236_26.aspect
					local var_236_29 = var_236_24.sprite.bounds.size.x
					local var_236_30 = var_236_24.sprite.bounds.size.y
					local var_236_31 = var_236_28 / var_236_29
					local var_236_32 = var_236_27 / var_236_30
					local var_236_33 = var_236_32 < var_236_31 and var_236_31 or var_236_32

					var_236_23.transform.localScale = Vector3.New(var_236_33, var_236_33, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "ST12" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_34 = 2.38333333333333
			local var_236_35 = 1.78333333333333

			if var_236_34 < arg_233_1.time_ and arg_233_1.time_ <= var_236_34 + arg_236_0 then
				local var_236_36 = "play"
				local var_236_37 = "music"

				arg_233_1:AudioAction(var_236_36, var_236_37, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_236_38 = ""
				local var_236_39 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

				if var_236_39 ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_39 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_39

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_39
						arg_233_1.bgmTxt2_.text = var_236_39
					end

					if arg_233_1.bgmTimer then
						arg_233_1.bgmTimer:Stop()

						arg_233_1.bgmTimer = nil
					end

					if arg_233_1.settingData.show_music_name == 1 then
						arg_233_1.musicController:SetSelectedState("show")
						arg_233_1.musicAnimator_:Play("open", 0, 0)

						if arg_233_1.settingData.music_time ~= 0 then
							arg_233_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_233_1.settingData.music_time), function()
								if arg_233_1 == nil or isNil(arg_233_1.bgmTxt_) then
									return
								end

								arg_233_1.musicController:SetSelectedState("hide")
								arg_233_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_40 = 4
			local var_236_41 = 0.05

			if var_236_40 < arg_233_1.time_ and arg_233_1.time_ <= var_236_40 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_42 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_42:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_233_1.dialogCg_.alpha = arg_238_0
				end))
				var_236_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_43 = arg_233_1:GetWordFromCfg(103303058)
				local var_236_44 = arg_233_1:FormatText(var_236_43.content)

				arg_233_1.text_.text = var_236_44

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_45 = 2
				local var_236_46 = utf8.len(var_236_44)
				local var_236_47 = var_236_45 <= 0 and var_236_41 or var_236_41 * (var_236_46 / var_236_45)

				if var_236_47 > 0 and var_236_41 < var_236_47 then
					arg_233_1.talkMaxDuration = var_236_47
					var_236_40 = var_236_40 + 0.3

					if var_236_47 + var_236_40 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_47 + var_236_40
					end
				end

				arg_233_1.text_.text = var_236_44
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_48 = var_236_40 + 0.3
			local var_236_49 = math.max(var_236_41, arg_233_1.talkMaxDuration)

			if var_236_48 <= arg_233_1.time_ and arg_233_1.time_ < var_236_48 + var_236_49 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_48) / var_236_49

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_48 + var_236_49 and arg_233_1.time_ < var_236_48 + var_236_49 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play103303059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 103303059
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play103303060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.525

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				arg_240_1.dialog_:SetActive(true)

				arg_240_1.dialogCg_.alpha = 0

				local var_243_2 = LeanTween.value(arg_240_1.dialog_, 0, 1, 0.3)

				var_243_2:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_240_1.dialogCg_.alpha = arg_244_0
				end))
				var_243_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_240_1.dialog_)
					var_243_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_240_1.duration_ = arg_240_1.duration_ + 0.3

				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_3 = arg_240_1:GetWordFromCfg(103303059)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 21
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7
					var_243_0 = var_243_0 + 0.3

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

			local var_243_8 = var_243_0 + 0.3
			local var_243_9 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_8 <= arg_240_1.time_ and arg_240_1.time_ < var_243_8 + var_243_9 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_8) / var_243_9

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_8 + var_243_9 and arg_240_1.time_ < var_243_8 + var_243_9 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play103303060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 103303060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play103303061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.775

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_2 = arg_246_1:GetWordFromCfg(103303060)
				local var_249_3 = arg_246_1:FormatText(var_249_2.content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 31
				local var_249_5 = utf8.len(var_249_3)
				local var_249_6 = var_249_4 <= 0 and var_249_1 or var_249_1 * (var_249_5 / var_249_4)

				if var_249_6 > 0 and var_249_1 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_7 and arg_246_1.time_ < var_249_0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play103303061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 103303061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play103303062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0
			local var_253_1 = 0.35

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_2 = arg_250_1:FormatText(StoryNameCfg[7].name)

				arg_250_1.leftNameTxt_.text = var_253_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_3 = arg_250_1:GetWordFromCfg(103303061)
				local var_253_4 = arg_250_1:FormatText(var_253_3.content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 14
				local var_253_6 = utf8.len(var_253_4)
				local var_253_7 = var_253_5 <= 0 and var_253_1 or var_253_1 * (var_253_6 / var_253_5)

				if var_253_7 > 0 and var_253_1 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_0
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_8 = math.max(var_253_1, arg_250_1.talkMaxDuration)

			if var_253_0 <= arg_250_1.time_ and arg_250_1.time_ < var_253_0 + var_253_8 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_0) / var_253_8

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_0 + var_253_8 and arg_250_1.time_ < var_253_0 + var_253_8 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play103303062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 103303062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play103303063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 0.7

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				local var_257_2 = "play"
				local var_257_3 = "effect"

				arg_254_1:AudioAction(var_257_2, var_257_3, "se_story_side_1033", "se_story_1033_knock", "")
			end

			local var_257_4 = 0
			local var_257_5 = 0.1

			if var_257_4 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_6 = arg_254_1:GetWordFromCfg(103303062)
				local var_257_7 = arg_254_1:FormatText(var_257_6.content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_8 = 4
				local var_257_9 = utf8.len(var_257_7)
				local var_257_10 = var_257_8 <= 0 and var_257_5 or var_257_5 * (var_257_9 / var_257_8)

				if var_257_10 > 0 and var_257_5 < var_257_10 then
					arg_254_1.talkMaxDuration = var_257_10

					if var_257_10 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_11 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_11 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_11

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_11 and arg_254_1.time_ < var_257_4 + var_257_11 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play103303063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 103303063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play103303064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 1

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

				local var_261_2 = arg_258_1:GetWordFromCfg(103303063)
				local var_261_3 = arg_258_1:FormatText(var_261_2.content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 40
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
	Play103303064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 103303064
		arg_262_1.duration_ = 5.43

		local var_262_0 = {
			ja = 5.2,
			ko = 5.433,
			zh = 3.066,
			en = 2.933
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play103303065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1033ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1033ui_story = var_265_0.localPosition
			end

			local var_265_2 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2
				local var_265_4 = Vector3.New(0, -1.01, -6.13)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1033ui_story, var_265_4, var_265_3)

				local var_265_5 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_5.x, var_265_5.y, var_265_5.z)

				local var_265_6 = var_265_0.localEulerAngles

				var_265_6.z = 0
				var_265_6.x = 0
				var_265_0.localEulerAngles = var_265_6
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_265_7 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_7.x, var_265_7.y, var_265_7.z)

				local var_265_8 = var_265_0.localEulerAngles

				var_265_8.z = 0
				var_265_8.x = 0
				var_265_0.localEulerAngles = var_265_8
			end

			local var_265_9 = arg_262_1.actors_["1033ui_story"]
			local var_265_10 = 0

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 and not isNil(var_265_9) and arg_262_1.var_.characterEffect1033ui_story == nil then
				arg_262_1.var_.characterEffect1033ui_story = var_265_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_11 = 0.2

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_11 and not isNil(var_265_9) then
				local var_265_12 = (arg_262_1.time_ - var_265_10) / var_265_11

				if arg_262_1.var_.characterEffect1033ui_story and not isNil(var_265_9) then
					arg_262_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_10 + var_265_11 and arg_262_1.time_ < var_265_10 + var_265_11 + arg_265_0 and not isNil(var_265_9) and arg_262_1.var_.characterEffect1033ui_story then
				arg_262_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_265_13 = 0

			if var_265_13 < arg_262_1.time_ and arg_262_1.time_ <= var_265_13 + arg_265_0 then
				arg_262_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_1")
			end

			local var_265_14 = 0

			if var_265_14 < arg_262_1.time_ and arg_262_1.time_ <= var_265_14 + arg_265_0 then
				arg_262_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_265_15 = 0
			local var_265_16 = 0.425

			if var_265_15 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_17 = arg_262_1:FormatText(StoryNameCfg[236].name)

				arg_262_1.leftNameTxt_.text = var_265_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_18 = arg_262_1:GetWordFromCfg(103303064)
				local var_265_19 = arg_262_1:FormatText(var_265_18.content)

				arg_262_1.text_.text = var_265_19

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_20 = 17
				local var_265_21 = utf8.len(var_265_19)
				local var_265_22 = var_265_20 <= 0 and var_265_16 or var_265_16 * (var_265_21 / var_265_20)

				if var_265_22 > 0 and var_265_16 < var_265_22 then
					arg_262_1.talkMaxDuration = var_265_22

					if var_265_22 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_22 + var_265_15
					end
				end

				arg_262_1.text_.text = var_265_19
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303064", "story_v_side_old_103303.awb") ~= 0 then
					local var_265_23 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303064", "story_v_side_old_103303.awb") / 1000

					if var_265_23 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_23 + var_265_15
					end

					if var_265_18.prefab_name ~= "" and arg_262_1.actors_[var_265_18.prefab_name] ~= nil then
						local var_265_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_18.prefab_name].transform, "story_v_side_old_103303", "103303064", "story_v_side_old_103303.awb")

						arg_262_1:RecordAudio("103303064", var_265_24)
						arg_262_1:RecordAudio("103303064", var_265_24)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303064", "story_v_side_old_103303.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303064", "story_v_side_old_103303.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_25 = math.max(var_265_16, arg_262_1.talkMaxDuration)

			if var_265_15 <= arg_262_1.time_ and arg_262_1.time_ < var_265_15 + var_265_25 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_15) / var_265_25

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_15 + var_265_25 and arg_262_1.time_ < var_265_15 + var_265_25 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play103303065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 103303065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play103303066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1033ui_story"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1033ui_story == nil then
				arg_266_1.var_.characterEffect1033ui_story = var_269_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.2

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.characterEffect1033ui_story and not isNil(var_269_0) then
					local var_269_4 = Mathf.Lerp(0, 0.5, var_269_3)

					arg_266_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1033ui_story.fillRatio = var_269_4
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.characterEffect1033ui_story then
				local var_269_5 = 0.5

				arg_266_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1033ui_story.fillRatio = var_269_5
			end

			local var_269_6 = 0
			local var_269_7 = 0.55

			if var_269_6 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_8 = arg_266_1:FormatText(StoryNameCfg[7].name)

				arg_266_1.leftNameTxt_.text = var_269_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_9 = arg_266_1:GetWordFromCfg(103303065)
				local var_269_10 = arg_266_1:FormatText(var_269_9.content)

				arg_266_1.text_.text = var_269_10

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_11 = 22
				local var_269_12 = utf8.len(var_269_10)
				local var_269_13 = var_269_11 <= 0 and var_269_7 or var_269_7 * (var_269_12 / var_269_11)

				if var_269_13 > 0 and var_269_7 < var_269_13 then
					arg_266_1.talkMaxDuration = var_269_13

					if var_269_13 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_13 + var_269_6
					end
				end

				arg_266_1.text_.text = var_269_10
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_14 = math.max(var_269_7, arg_266_1.talkMaxDuration)

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_14 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_6) / var_269_14

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_6 + var_269_14 and arg_266_1.time_ < var_269_6 + var_269_14 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play103303066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 103303066
		arg_270_1.duration_ = 14.03

		local var_270_0 = {
			ja = 14.033,
			ko = 13.6,
			zh = 8.1,
			en = 10.6
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play103303067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1033ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1033ui_story == nil then
				arg_270_1.var_.characterEffect1033ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.2

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1033ui_story and not isNil(var_273_0) then
					arg_270_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1033ui_story then
				arg_270_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_273_4 = 0

			if var_273_4 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_273_5 = 0
			local var_273_6 = 1.15

			if var_273_5 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_7 = arg_270_1:FormatText(StoryNameCfg[236].name)

				arg_270_1.leftNameTxt_.text = var_273_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_8 = arg_270_1:GetWordFromCfg(103303066)
				local var_273_9 = arg_270_1:FormatText(var_273_8.content)

				arg_270_1.text_.text = var_273_9

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_10 = 46
				local var_273_11 = utf8.len(var_273_9)
				local var_273_12 = var_273_10 <= 0 and var_273_6 or var_273_6 * (var_273_11 / var_273_10)

				if var_273_12 > 0 and var_273_6 < var_273_12 then
					arg_270_1.talkMaxDuration = var_273_12

					if var_273_12 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_12 + var_273_5
					end
				end

				arg_270_1.text_.text = var_273_9
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303066", "story_v_side_old_103303.awb") ~= 0 then
					local var_273_13 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303066", "story_v_side_old_103303.awb") / 1000

					if var_273_13 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_5
					end

					if var_273_8.prefab_name ~= "" and arg_270_1.actors_[var_273_8.prefab_name] ~= nil then
						local var_273_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_8.prefab_name].transform, "story_v_side_old_103303", "103303066", "story_v_side_old_103303.awb")

						arg_270_1:RecordAudio("103303066", var_273_14)
						arg_270_1:RecordAudio("103303066", var_273_14)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303066", "story_v_side_old_103303.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303066", "story_v_side_old_103303.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_15 = math.max(var_273_6, arg_270_1.talkMaxDuration)

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_15 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_5) / var_273_15

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_5 + var_273_15 and arg_270_1.time_ < var_273_5 + var_273_15 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play103303067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 103303067
		arg_274_1.duration_ = 10.7

		local var_274_0 = {
			ja = 10.7,
			ko = 6.2,
			zh = 4.866,
			en = 4.533
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play103303068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_277_1 = 0
			local var_277_2 = 0.7

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_3 = arg_274_1:FormatText(StoryNameCfg[236].name)

				arg_274_1.leftNameTxt_.text = var_277_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:GetWordFromCfg(103303067)
				local var_277_5 = arg_274_1:FormatText(var_277_4.content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_6 = 28
				local var_277_7 = utf8.len(var_277_5)
				local var_277_8 = var_277_6 <= 0 and var_277_2 or var_277_2 * (var_277_7 / var_277_6)

				if var_277_8 > 0 and var_277_2 < var_277_8 then
					arg_274_1.talkMaxDuration = var_277_8

					if var_277_8 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303067", "story_v_side_old_103303.awb") ~= 0 then
					local var_277_9 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303067", "story_v_side_old_103303.awb") / 1000

					if var_277_9 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_9 + var_277_1
					end

					if var_277_4.prefab_name ~= "" and arg_274_1.actors_[var_277_4.prefab_name] ~= nil then
						local var_277_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_4.prefab_name].transform, "story_v_side_old_103303", "103303067", "story_v_side_old_103303.awb")

						arg_274_1:RecordAudio("103303067", var_277_10)
						arg_274_1:RecordAudio("103303067", var_277_10)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303067", "story_v_side_old_103303.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303067", "story_v_side_old_103303.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_11 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_11 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_11

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_11 and arg_274_1.time_ < var_277_1 + var_277_11 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play103303068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 103303068
		arg_278_1.duration_ = 14.13

		local var_278_0 = {
			ja = 14.133,
			ko = 13.733,
			zh = 9,
			en = 11
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play103303069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action484")
			end

			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_281_2 = 0
			local var_281_3 = 1.2

			if var_281_2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_2 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_4 = arg_278_1:FormatText(StoryNameCfg[236].name)

				arg_278_1.leftNameTxt_.text = var_281_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_5 = arg_278_1:GetWordFromCfg(103303068)
				local var_281_6 = arg_278_1:FormatText(var_281_5.content)

				arg_278_1.text_.text = var_281_6

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_7 = 48
				local var_281_8 = utf8.len(var_281_6)
				local var_281_9 = var_281_7 <= 0 and var_281_3 or var_281_3 * (var_281_8 / var_281_7)

				if var_281_9 > 0 and var_281_3 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_2 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_2
					end
				end

				arg_278_1.text_.text = var_281_6
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303068", "story_v_side_old_103303.awb") ~= 0 then
					local var_281_10 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303068", "story_v_side_old_103303.awb") / 1000

					if var_281_10 + var_281_2 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_2
					end

					if var_281_5.prefab_name ~= "" and arg_278_1.actors_[var_281_5.prefab_name] ~= nil then
						local var_281_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_5.prefab_name].transform, "story_v_side_old_103303", "103303068", "story_v_side_old_103303.awb")

						arg_278_1:RecordAudio("103303068", var_281_11)
						arg_278_1:RecordAudio("103303068", var_281_11)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303068", "story_v_side_old_103303.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303068", "story_v_side_old_103303.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_12 = math.max(var_281_3, arg_278_1.talkMaxDuration)

			if var_281_2 <= arg_278_1.time_ and arg_278_1.time_ < var_281_2 + var_281_12 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_2) / var_281_12

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_2 + var_281_12 and arg_278_1.time_ < var_281_2 + var_281_12 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play103303069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 103303069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play103303070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1033ui_story"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1033ui_story == nil then
				arg_282_1.var_.characterEffect1033ui_story = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.2

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect1033ui_story and not isNil(var_285_0) then
					local var_285_4 = Mathf.Lerp(0, 0.5, var_285_3)

					arg_282_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1033ui_story.fillRatio = var_285_4
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1033ui_story then
				local var_285_5 = 0.5

				arg_282_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1033ui_story.fillRatio = var_285_5
			end

			local var_285_6 = 0
			local var_285_7 = 0.55

			if var_285_6 < arg_282_1.time_ and arg_282_1.time_ <= var_285_6 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_8 = arg_282_1:FormatText(StoryNameCfg[7].name)

				arg_282_1.leftNameTxt_.text = var_285_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_9 = arg_282_1:GetWordFromCfg(103303069)
				local var_285_10 = arg_282_1:FormatText(var_285_9.content)

				arg_282_1.text_.text = var_285_10

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_11 = 22
				local var_285_12 = utf8.len(var_285_10)
				local var_285_13 = var_285_11 <= 0 and var_285_7 or var_285_7 * (var_285_12 / var_285_11)

				if var_285_13 > 0 and var_285_7 < var_285_13 then
					arg_282_1.talkMaxDuration = var_285_13

					if var_285_13 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_6
					end
				end

				arg_282_1.text_.text = var_285_10
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_14 = math.max(var_285_7, arg_282_1.talkMaxDuration)

			if var_285_6 <= arg_282_1.time_ and arg_282_1.time_ < var_285_6 + var_285_14 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_6) / var_285_14

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_6 + var_285_14 and arg_282_1.time_ < var_285_6 + var_285_14 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play103303070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 103303070
		arg_286_1.duration_ = 14.17

		local var_286_0 = {
			ja = 14.166,
			ko = 8.5,
			zh = 5.7,
			en = 6.8
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play103303071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1033ui_story"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1033ui_story == nil then
				arg_286_1.var_.characterEffect1033ui_story = var_289_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.2

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.characterEffect1033ui_story and not isNil(var_289_0) then
					arg_286_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1033ui_story then
				arg_286_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_289_4 = 0

			if var_289_4 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action442")
			end

			local var_289_5 = 0

			if var_289_5 < arg_286_1.time_ and arg_286_1.time_ <= var_289_5 + arg_289_0 then
				arg_286_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_289_6 = 0
			local var_289_7 = 0.625

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_8 = arg_286_1:FormatText(StoryNameCfg[236].name)

				arg_286_1.leftNameTxt_.text = var_289_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_9 = arg_286_1:GetWordFromCfg(103303070)
				local var_289_10 = arg_286_1:FormatText(var_289_9.content)

				arg_286_1.text_.text = var_289_10

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_11 = 25
				local var_289_12 = utf8.len(var_289_10)
				local var_289_13 = var_289_11 <= 0 and var_289_7 or var_289_7 * (var_289_12 / var_289_11)

				if var_289_13 > 0 and var_289_7 < var_289_13 then
					arg_286_1.talkMaxDuration = var_289_13

					if var_289_13 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_13 + var_289_6
					end
				end

				arg_286_1.text_.text = var_289_10
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303070", "story_v_side_old_103303.awb") ~= 0 then
					local var_289_14 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303070", "story_v_side_old_103303.awb") / 1000

					if var_289_14 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_14 + var_289_6
					end

					if var_289_9.prefab_name ~= "" and arg_286_1.actors_[var_289_9.prefab_name] ~= nil then
						local var_289_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_9.prefab_name].transform, "story_v_side_old_103303", "103303070", "story_v_side_old_103303.awb")

						arg_286_1:RecordAudio("103303070", var_289_15)
						arg_286_1:RecordAudio("103303070", var_289_15)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303070", "story_v_side_old_103303.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303070", "story_v_side_old_103303.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_16 = math.max(var_289_7, arg_286_1.talkMaxDuration)

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_16 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_6) / var_289_16

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_6 + var_289_16 and arg_286_1.time_ < var_289_6 + var_289_16 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play103303071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 103303071
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play103303072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1033ui_story"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos1033ui_story = var_293_0.localPosition
			end

			local var_293_2 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2
				local var_293_4 = Vector3.New(0, 100, 0)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1033ui_story, var_293_4, var_293_3)

				local var_293_5 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_5.x, var_293_5.y, var_293_5.z)

				local var_293_6 = var_293_0.localEulerAngles

				var_293_6.z = 0
				var_293_6.x = 0
				var_293_0.localEulerAngles = var_293_6
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(0, 100, 0)

				local var_293_7 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_7.x, var_293_7.y, var_293_7.z)

				local var_293_8 = var_293_0.localEulerAngles

				var_293_8.z = 0
				var_293_8.x = 0
				var_293_0.localEulerAngles = var_293_8
			end

			local var_293_9 = 0
			local var_293_10 = 1

			if var_293_9 < arg_290_1.time_ and arg_290_1.time_ <= var_293_9 + arg_293_0 then
				local var_293_11 = "play"
				local var_293_12 = "effect"

				arg_290_1:AudioAction(var_293_11, var_293_12, "se_story_side_1033", "se_story_1033_zizi", "")
			end

			local var_293_13 = 0
			local var_293_14 = 0.15

			if var_293_13 < arg_290_1.time_ and arg_290_1.time_ <= var_293_13 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_15 = arg_290_1:GetWordFromCfg(103303071)
				local var_293_16 = arg_290_1:FormatText(var_293_15.content)

				arg_290_1.text_.text = var_293_16

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_17 = 6
				local var_293_18 = utf8.len(var_293_16)
				local var_293_19 = var_293_17 <= 0 and var_293_14 or var_293_14 * (var_293_18 / var_293_17)

				if var_293_19 > 0 and var_293_14 < var_293_19 then
					arg_290_1.talkMaxDuration = var_293_19

					if var_293_19 + var_293_13 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_19 + var_293_13
					end
				end

				arg_290_1.text_.text = var_293_16
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_20 = math.max(var_293_14, arg_290_1.talkMaxDuration)

			if var_293_13 <= arg_290_1.time_ and arg_290_1.time_ < var_293_13 + var_293_20 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_13) / var_293_20

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_13 + var_293_20 and arg_290_1.time_ < var_293_13 + var_293_20 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play103303072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 103303072
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play103303073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 1.125

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_2 = arg_294_1:GetWordFromCfg(103303072)
				local var_297_3 = arg_294_1:FormatText(var_297_2.content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 45
				local var_297_5 = utf8.len(var_297_3)
				local var_297_6 = var_297_4 <= 0 and var_297_1 or var_297_1 * (var_297_5 / var_297_4)

				if var_297_6 > 0 and var_297_1 < var_297_6 then
					arg_294_1.talkMaxDuration = var_297_6

					if var_297_6 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_6 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_7 and arg_294_1.time_ < var_297_0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play103303073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 103303073
		arg_298_1.duration_ = 2

		local var_298_0 = {
			ja = 2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play103303074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1033ui_story"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos1033ui_story = var_301_0.localPosition
			end

			local var_301_2 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2
				local var_301_4 = Vector3.New(0, -1.01, -6.13)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1033ui_story, var_301_4, var_301_3)

				local var_301_5 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_5.x, var_301_5.y, var_301_5.z)

				local var_301_6 = var_301_0.localEulerAngles

				var_301_6.z = 0
				var_301_6.x = 0
				var_301_0.localEulerAngles = var_301_6
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_301_7 = manager.ui.mainCamera.transform.position - var_301_0.position

				var_301_0.forward = Vector3.New(var_301_7.x, var_301_7.y, var_301_7.z)

				local var_301_8 = var_301_0.localEulerAngles

				var_301_8.z = 0
				var_301_8.x = 0
				var_301_0.localEulerAngles = var_301_8
			end

			local var_301_9 = arg_298_1.actors_["1033ui_story"]
			local var_301_10 = 0

			if var_301_10 < arg_298_1.time_ and arg_298_1.time_ <= var_301_10 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1033ui_story == nil then
				arg_298_1.var_.characterEffect1033ui_story = var_301_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_11 = 0.2

			if var_301_10 <= arg_298_1.time_ and arg_298_1.time_ < var_301_10 + var_301_11 and not isNil(var_301_9) then
				local var_301_12 = (arg_298_1.time_ - var_301_10) / var_301_11

				if arg_298_1.var_.characterEffect1033ui_story and not isNil(var_301_9) then
					arg_298_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_10 + var_301_11 and arg_298_1.time_ < var_301_10 + var_301_11 + arg_301_0 and not isNil(var_301_9) and arg_298_1.var_.characterEffect1033ui_story then
				arg_298_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_301_13 = 0

			if var_301_13 < arg_298_1.time_ and arg_298_1.time_ <= var_301_13 + arg_301_0 then
				arg_298_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_2")
			end

			local var_301_14 = 0

			if var_301_14 < arg_298_1.time_ and arg_298_1.time_ <= var_301_14 + arg_301_0 then
				arg_298_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_301_15 = 0
			local var_301_16 = 0.125

			if var_301_15 < arg_298_1.time_ and arg_298_1.time_ <= var_301_15 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_17 = arg_298_1:FormatText(StoryNameCfg[236].name)

				arg_298_1.leftNameTxt_.text = var_301_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_18 = arg_298_1:GetWordFromCfg(103303073)
				local var_301_19 = arg_298_1:FormatText(var_301_18.content)

				arg_298_1.text_.text = var_301_19

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_20 = 5
				local var_301_21 = utf8.len(var_301_19)
				local var_301_22 = var_301_20 <= 0 and var_301_16 or var_301_16 * (var_301_21 / var_301_20)

				if var_301_22 > 0 and var_301_16 < var_301_22 then
					arg_298_1.talkMaxDuration = var_301_22

					if var_301_22 + var_301_15 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_22 + var_301_15
					end
				end

				arg_298_1.text_.text = var_301_19
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303073", "story_v_side_old_103303.awb") ~= 0 then
					local var_301_23 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303073", "story_v_side_old_103303.awb") / 1000

					if var_301_23 + var_301_15 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_23 + var_301_15
					end

					if var_301_18.prefab_name ~= "" and arg_298_1.actors_[var_301_18.prefab_name] ~= nil then
						local var_301_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_18.prefab_name].transform, "story_v_side_old_103303", "103303073", "story_v_side_old_103303.awb")

						arg_298_1:RecordAudio("103303073", var_301_24)
						arg_298_1:RecordAudio("103303073", var_301_24)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303073", "story_v_side_old_103303.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303073", "story_v_side_old_103303.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_25 = math.max(var_301_16, arg_298_1.talkMaxDuration)

			if var_301_15 <= arg_298_1.time_ and arg_298_1.time_ < var_301_15 + var_301_25 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_15) / var_301_25

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_15 + var_301_25 and arg_298_1.time_ < var_301_15 + var_301_25 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play103303074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 103303074
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play103303075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1033ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1033ui_story = var_305_0.localPosition
			end

			local var_305_2 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2
				local var_305_4 = Vector3.New(0, 100, 0)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1033ui_story, var_305_4, var_305_3)

				local var_305_5 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_5.x, var_305_5.y, var_305_5.z)

				local var_305_6 = var_305_0.localEulerAngles

				var_305_6.z = 0
				var_305_6.x = 0
				var_305_0.localEulerAngles = var_305_6
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, 100, 0)

				local var_305_7 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_7.x, var_305_7.y, var_305_7.z)

				local var_305_8 = var_305_0.localEulerAngles

				var_305_8.z = 0
				var_305_8.x = 0
				var_305_0.localEulerAngles = var_305_8
			end

			local var_305_9 = 0
			local var_305_10 = 0.6

			if var_305_9 < arg_302_1.time_ and arg_302_1.time_ <= var_305_9 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_11 = arg_302_1:FormatText(StoryNameCfg[7].name)

				arg_302_1.leftNameTxt_.text = var_305_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_12 = arg_302_1:GetWordFromCfg(103303074)
				local var_305_13 = arg_302_1:FormatText(var_305_12.content)

				arg_302_1.text_.text = var_305_13

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_14 = 24
				local var_305_15 = utf8.len(var_305_13)
				local var_305_16 = var_305_14 <= 0 and var_305_10 or var_305_10 * (var_305_15 / var_305_14)

				if var_305_16 > 0 and var_305_10 < var_305_16 then
					arg_302_1.talkMaxDuration = var_305_16

					if var_305_16 + var_305_9 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_16 + var_305_9
					end
				end

				arg_302_1.text_.text = var_305_13
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_17 = math.max(var_305_10, arg_302_1.talkMaxDuration)

			if var_305_9 <= arg_302_1.time_ and arg_302_1.time_ < var_305_9 + var_305_17 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_9) / var_305_17

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_9 + var_305_17 and arg_302_1.time_ < var_305_9 + var_305_17 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play103303075 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 103303075
		arg_306_1.duration_ = 14.83

		local var_306_0 = {
			ja = 14.833,
			ko = 10.733,
			zh = 8.433,
			en = 14.766
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play103303076(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 1.2

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_2 = arg_306_1:FormatText(StoryNameCfg[14].name)

				arg_306_1.leftNameTxt_.text = var_309_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:GetWordFromCfg(103303075)
				local var_309_4 = arg_306_1:FormatText(var_309_3.content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 48
				local var_309_6 = utf8.len(var_309_4)
				local var_309_7 = var_309_5 <= 0 and var_309_1 or var_309_1 * (var_309_6 / var_309_5)

				if var_309_7 > 0 and var_309_1 < var_309_7 then
					arg_306_1.talkMaxDuration = var_309_7

					if var_309_7 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_7 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303075", "story_v_side_old_103303.awb") ~= 0 then
					local var_309_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303075", "story_v_side_old_103303.awb") / 1000

					if var_309_8 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_8 + var_309_0
					end

					if var_309_3.prefab_name ~= "" and arg_306_1.actors_[var_309_3.prefab_name] ~= nil then
						local var_309_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_3.prefab_name].transform, "story_v_side_old_103303", "103303075", "story_v_side_old_103303.awb")

						arg_306_1:RecordAudio("103303075", var_309_9)
						arg_306_1:RecordAudio("103303075", var_309_9)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303075", "story_v_side_old_103303.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303075", "story_v_side_old_103303.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_10 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_10 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_10

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_10 and arg_306_1.time_ < var_309_0 + var_309_10 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play103303076 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 103303076
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play103303077(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 1.075

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_2 = arg_310_1:GetWordFromCfg(103303076)
				local var_313_3 = arg_310_1:FormatText(var_313_2.content)

				arg_310_1.text_.text = var_313_3

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_4 = 43
				local var_313_5 = utf8.len(var_313_3)
				local var_313_6 = var_313_4 <= 0 and var_313_1 or var_313_1 * (var_313_5 / var_313_4)

				if var_313_6 > 0 and var_313_1 < var_313_6 then
					arg_310_1.talkMaxDuration = var_313_6

					if var_313_6 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_3
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_7 and arg_310_1.time_ < var_313_0 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play103303077 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 103303077
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play103303078(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 0.325

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_2 = arg_314_1:FormatText(StoryNameCfg[7].name)

				arg_314_1.leftNameTxt_.text = var_317_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_3 = arg_314_1:GetWordFromCfg(103303077)
				local var_317_4 = arg_314_1:FormatText(var_317_3.content)

				arg_314_1.text_.text = var_317_4

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 13
				local var_317_6 = utf8.len(var_317_4)
				local var_317_7 = var_317_5 <= 0 and var_317_1 or var_317_1 * (var_317_6 / var_317_5)

				if var_317_7 > 0 and var_317_1 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_4
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_8 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_8 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_8

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_8 and arg_314_1.time_ < var_317_0 + var_317_8 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play103303078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 103303078
		arg_318_1.duration_ = 5.8

		local var_318_0 = {
			ja = 5.8,
			ko = 2.633,
			zh = 2.233,
			en = 4.066
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play103303079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 0.25

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[14].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:GetWordFromCfg(103303078)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 10
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303078", "story_v_side_old_103303.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303078", "story_v_side_old_103303.awb") / 1000

					if var_321_8 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_0
					end

					if var_321_3.prefab_name ~= "" and arg_318_1.actors_[var_321_3.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_3.prefab_name].transform, "story_v_side_old_103303", "103303078", "story_v_side_old_103303.awb")

						arg_318_1:RecordAudio("103303078", var_321_9)
						arg_318_1:RecordAudio("103303078", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303078", "story_v_side_old_103303.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303078", "story_v_side_old_103303.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_10 and arg_318_1.time_ < var_321_0 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play103303079 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 103303079
		arg_322_1.duration_ = 16.33

		local var_322_0 = {
			ja = 16.333,
			ko = 11.133,
			zh = 9.9,
			en = 12.833
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
				arg_322_0:Play103303080(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 1.45

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[14].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:GetWordFromCfg(103303079)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 58
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

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303079", "story_v_side_old_103303.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303079", "story_v_side_old_103303.awb") / 1000

					if var_325_8 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_0
					end

					if var_325_3.prefab_name ~= "" and arg_322_1.actors_[var_325_3.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_3.prefab_name].transform, "story_v_side_old_103303", "103303079", "story_v_side_old_103303.awb")

						arg_322_1:RecordAudio("103303079", var_325_9)
						arg_322_1:RecordAudio("103303079", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303079", "story_v_side_old_103303.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303079", "story_v_side_old_103303.awb")
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
	Play103303080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 103303080
		arg_326_1.duration_ = 9.47

		local var_326_0 = {
			ja = 9.466,
			ko = 7.666,
			zh = 6.333,
			en = 7.5
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play103303081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.825

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[14].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(103303080)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303080", "story_v_side_old_103303.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303080", "story_v_side_old_103303.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_side_old_103303", "103303080", "story_v_side_old_103303.awb")

						arg_326_1:RecordAudio("103303080", var_329_9)
						arg_326_1:RecordAudio("103303080", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303080", "story_v_side_old_103303.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303080", "story_v_side_old_103303.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_10 and arg_326_1.time_ < var_329_0 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play103303081 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 103303081
		arg_330_1.duration_ = 14.27

		local var_330_0 = {
			ja = 14.266,
			ko = 12.566,
			zh = 9.566,
			en = 13.4
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
				arg_330_0:Play103303082(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 1.35

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[14].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:GetWordFromCfg(103303081)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 54
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

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303081", "story_v_side_old_103303.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303081", "story_v_side_old_103303.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_side_old_103303", "103303081", "story_v_side_old_103303.awb")

						arg_330_1:RecordAudio("103303081", var_333_9)
						arg_330_1:RecordAudio("103303081", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303081", "story_v_side_old_103303.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303081", "story_v_side_old_103303.awb")
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
	Play103303082 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 103303082
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play103303083(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0
			local var_337_1 = 0.5

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
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(103303082)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 20
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
	Play103303083 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 103303083
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play103303084(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 0.825

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_2 = arg_338_1:FormatText(StoryNameCfg[7].name)

				arg_338_1.leftNameTxt_.text = var_341_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_3 = arg_338_1:GetWordFromCfg(103303083)
				local var_341_4 = arg_338_1:FormatText(var_341_3.content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 33
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
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_8 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_8 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_8

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_8 and arg_338_1.time_ < var_341_0 + var_341_8 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play103303084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 103303084
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play103303085(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 0.425

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_2 = arg_342_1:GetWordFromCfg(103303084)
				local var_345_3 = arg_342_1:FormatText(var_345_2.content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 17
				local var_345_5 = utf8.len(var_345_3)
				local var_345_6 = var_345_4 <= 0 and var_345_1 or var_345_1 * (var_345_5 / var_345_4)

				if var_345_6 > 0 and var_345_1 < var_345_6 then
					arg_342_1.talkMaxDuration = var_345_6

					if var_345_6 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_7 and arg_342_1.time_ < var_345_0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play103303085 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 103303085
		arg_346_1.duration_ = 4.63

		local var_346_0 = {
			ja = 2.4,
			ko = 3.8,
			zh = 1.7,
			en = 4.633
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
				arg_346_0:Play103303086(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.4

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[14].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:GetWordFromCfg(103303085)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303085", "story_v_side_old_103303.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303085", "story_v_side_old_103303.awb") / 1000

					if var_349_8 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_0
					end

					if var_349_3.prefab_name ~= "" and arg_346_1.actors_[var_349_3.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_3.prefab_name].transform, "story_v_side_old_103303", "103303085", "story_v_side_old_103303.awb")

						arg_346_1:RecordAudio("103303085", var_349_9)
						arg_346_1:RecordAudio("103303085", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303085", "story_v_side_old_103303.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303085", "story_v_side_old_103303.awb")
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
	Play103303086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 103303086
		arg_350_1.duration_ = 17.57

		local var_350_0 = {
			ja = 13.833,
			ko = 13.533,
			zh = 9.866,
			en = 17.566
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
				arg_350_0:Play103303087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 1.25

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[14].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_3 = arg_350_1:GetWordFromCfg(103303086)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 50
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

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303086", "story_v_side_old_103303.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303086", "story_v_side_old_103303.awb") / 1000

					if var_353_8 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_0
					end

					if var_353_3.prefab_name ~= "" and arg_350_1.actors_[var_353_3.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_3.prefab_name].transform, "story_v_side_old_103303", "103303086", "story_v_side_old_103303.awb")

						arg_350_1:RecordAudio("103303086", var_353_9)
						arg_350_1:RecordAudio("103303086", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303086", "story_v_side_old_103303.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303086", "story_v_side_old_103303.awb")
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
	Play103303087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 103303087
		arg_354_1.duration_ = 14.3

		local var_354_0 = {
			ja = 12.766,
			ko = 13.533,
			zh = 9.033,
			en = 14.3
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
				arg_354_0:Play103303088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0
			local var_357_1 = 1.225

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_2 = arg_354_1:FormatText(StoryNameCfg[14].name)

				arg_354_1.leftNameTxt_.text = var_357_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_3 = arg_354_1:GetWordFromCfg(103303087)
				local var_357_4 = arg_354_1:FormatText(var_357_3.content)

				arg_354_1.text_.text = var_357_4

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 49
				local var_357_6 = utf8.len(var_357_4)
				local var_357_7 = var_357_5 <= 0 and var_357_1 or var_357_1 * (var_357_6 / var_357_5)

				if var_357_7 > 0 and var_357_1 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_0
					end
				end

				arg_354_1.text_.text = var_357_4
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303087", "story_v_side_old_103303.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303087", "story_v_side_old_103303.awb") / 1000

					if var_357_8 + var_357_0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_0
					end

					if var_357_3.prefab_name ~= "" and arg_354_1.actors_[var_357_3.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_3.prefab_name].transform, "story_v_side_old_103303", "103303087", "story_v_side_old_103303.awb")

						arg_354_1:RecordAudio("103303087", var_357_9)
						arg_354_1:RecordAudio("103303087", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303087", "story_v_side_old_103303.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303087", "story_v_side_old_103303.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_1, arg_354_1.talkMaxDuration)

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_0) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_0 + var_357_10 and arg_354_1.time_ < var_357_0 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play103303088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 103303088
		arg_358_1.duration_ = 10.63

		local var_358_0 = {
			ja = 10.633,
			ko = 6.966,
			zh = 4.766,
			en = 6.633
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
				arg_358_0:Play103303089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 0.8

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[14].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(103303088)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 32
				local var_361_6 = utf8.len(var_361_4)
				local var_361_7 = var_361_5 <= 0 and var_361_1 or var_361_1 * (var_361_6 / var_361_5)

				if var_361_7 > 0 and var_361_1 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_4
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303088", "story_v_side_old_103303.awb") ~= 0 then
					local var_361_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303088", "story_v_side_old_103303.awb") / 1000

					if var_361_8 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_8 + var_361_0
					end

					if var_361_3.prefab_name ~= "" and arg_358_1.actors_[var_361_3.prefab_name] ~= nil then
						local var_361_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_3.prefab_name].transform, "story_v_side_old_103303", "103303088", "story_v_side_old_103303.awb")

						arg_358_1:RecordAudio("103303088", var_361_9)
						arg_358_1:RecordAudio("103303088", var_361_9)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303088", "story_v_side_old_103303.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303088", "story_v_side_old_103303.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_10 and arg_358_1.time_ < var_361_0 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play103303089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 103303089
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play103303090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 1.025

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, false)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_2 = arg_362_1:GetWordFromCfg(103303089)
				local var_365_3 = arg_362_1:FormatText(var_365_2.content)

				arg_362_1.text_.text = var_365_3

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 41
				local var_365_5 = utf8.len(var_365_3)
				local var_365_6 = var_365_4 <= 0 and var_365_1 or var_365_1 * (var_365_5 / var_365_4)

				if var_365_6 > 0 and var_365_1 < var_365_6 then
					arg_362_1.talkMaxDuration = var_365_6

					if var_365_6 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_6 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_3
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_7 and arg_362_1.time_ < var_365_0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play103303090 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 103303090
		arg_366_1.duration_ = 11.97

		local var_366_0 = {
			ja = 11.966,
			ko = 10.2,
			zh = 7.366,
			en = 8.7
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play103303091(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1033ui_story"].transform
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.var_.moveOldPos1033ui_story = var_369_0.localPosition
			end

			local var_369_2 = 0.001

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2
				local var_369_4 = Vector3.New(0, -1.01, -6.13)

				var_369_0.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1033ui_story, var_369_4, var_369_3)

				local var_369_5 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_5.x, var_369_5.y, var_369_5.z)

				local var_369_6 = var_369_0.localEulerAngles

				var_369_6.z = 0
				var_369_6.x = 0
				var_369_0.localEulerAngles = var_369_6
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 then
				var_369_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_369_7 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_7.x, var_369_7.y, var_369_7.z)

				local var_369_8 = var_369_0.localEulerAngles

				var_369_8.z = 0
				var_369_8.x = 0
				var_369_0.localEulerAngles = var_369_8
			end

			local var_369_9 = arg_366_1.actors_["1033ui_story"]
			local var_369_10 = 0

			if var_369_10 < arg_366_1.time_ and arg_366_1.time_ <= var_369_10 + arg_369_0 and not isNil(var_369_9) and arg_366_1.var_.characterEffect1033ui_story == nil then
				arg_366_1.var_.characterEffect1033ui_story = var_369_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_11 = 0.2

			if var_369_10 <= arg_366_1.time_ and arg_366_1.time_ < var_369_10 + var_369_11 and not isNil(var_369_9) then
				local var_369_12 = (arg_366_1.time_ - var_369_10) / var_369_11

				if arg_366_1.var_.characterEffect1033ui_story and not isNil(var_369_9) then
					arg_366_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_10 + var_369_11 and arg_366_1.time_ < var_369_10 + var_369_11 + arg_369_0 and not isNil(var_369_9) and arg_366_1.var_.characterEffect1033ui_story then
				arg_366_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_369_13 = 0

			if var_369_13 < arg_366_1.time_ and arg_366_1.time_ <= var_369_13 + arg_369_0 then
				arg_366_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action5_1")
			end

			local var_369_14 = 0

			if var_369_14 < arg_366_1.time_ and arg_366_1.time_ <= var_369_14 + arg_369_0 then
				arg_366_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_369_15 = 0
			local var_369_16 = 1.075

			if var_369_15 < arg_366_1.time_ and arg_366_1.time_ <= var_369_15 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_17 = arg_366_1:FormatText(StoryNameCfg[236].name)

				arg_366_1.leftNameTxt_.text = var_369_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_18 = arg_366_1:GetWordFromCfg(103303090)
				local var_369_19 = arg_366_1:FormatText(var_369_18.content)

				arg_366_1.text_.text = var_369_19

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_20 = 43
				local var_369_21 = utf8.len(var_369_19)
				local var_369_22 = var_369_20 <= 0 and var_369_16 or var_369_16 * (var_369_21 / var_369_20)

				if var_369_22 > 0 and var_369_16 < var_369_22 then
					arg_366_1.talkMaxDuration = var_369_22

					if var_369_22 + var_369_15 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_22 + var_369_15
					end
				end

				arg_366_1.text_.text = var_369_19
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303090", "story_v_side_old_103303.awb") ~= 0 then
					local var_369_23 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303090", "story_v_side_old_103303.awb") / 1000

					if var_369_23 + var_369_15 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_23 + var_369_15
					end

					if var_369_18.prefab_name ~= "" and arg_366_1.actors_[var_369_18.prefab_name] ~= nil then
						local var_369_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_18.prefab_name].transform, "story_v_side_old_103303", "103303090", "story_v_side_old_103303.awb")

						arg_366_1:RecordAudio("103303090", var_369_24)
						arg_366_1:RecordAudio("103303090", var_369_24)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303090", "story_v_side_old_103303.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303090", "story_v_side_old_103303.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_25 = math.max(var_369_16, arg_366_1.talkMaxDuration)

			if var_369_15 <= arg_366_1.time_ and arg_366_1.time_ < var_369_15 + var_369_25 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_15) / var_369_25

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_15 + var_369_25 and arg_366_1.time_ < var_369_15 + var_369_25 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play103303091 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 103303091
		arg_370_1.duration_ = 9.33

		local var_370_0 = {
			ja = 9.333,
			ko = 6.1,
			zh = 7.233,
			en = 8.5
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play103303092(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action458")
			end

			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_373_2 = 0
			local var_373_3 = 1.025

			if var_373_2 < arg_370_1.time_ and arg_370_1.time_ <= var_373_2 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_4 = arg_370_1:FormatText(StoryNameCfg[236].name)

				arg_370_1.leftNameTxt_.text = var_373_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_5 = arg_370_1:GetWordFromCfg(103303091)
				local var_373_6 = arg_370_1:FormatText(var_373_5.content)

				arg_370_1.text_.text = var_373_6

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_7 = 41
				local var_373_8 = utf8.len(var_373_6)
				local var_373_9 = var_373_7 <= 0 and var_373_3 or var_373_3 * (var_373_8 / var_373_7)

				if var_373_9 > 0 and var_373_3 < var_373_9 then
					arg_370_1.talkMaxDuration = var_373_9

					if var_373_9 + var_373_2 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_2
					end
				end

				arg_370_1.text_.text = var_373_6
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303091", "story_v_side_old_103303.awb") ~= 0 then
					local var_373_10 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303091", "story_v_side_old_103303.awb") / 1000

					if var_373_10 + var_373_2 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_2
					end

					if var_373_5.prefab_name ~= "" and arg_370_1.actors_[var_373_5.prefab_name] ~= nil then
						local var_373_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_5.prefab_name].transform, "story_v_side_old_103303", "103303091", "story_v_side_old_103303.awb")

						arg_370_1:RecordAudio("103303091", var_373_11)
						arg_370_1:RecordAudio("103303091", var_373_11)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303091", "story_v_side_old_103303.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303091", "story_v_side_old_103303.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_12 = math.max(var_373_3, arg_370_1.talkMaxDuration)

			if var_373_2 <= arg_370_1.time_ and arg_370_1.time_ < var_373_2 + var_373_12 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_2) / var_373_12

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_2 + var_373_12 and arg_370_1.time_ < var_373_2 + var_373_12 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play103303092 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 103303092
		arg_374_1.duration_ = 14.43

		local var_374_0 = {
			ja = 14,
			ko = 8.233,
			zh = 7.266,
			en = 14.433
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
				arg_374_0:Play103303093(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1033ui_story"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1033ui_story == nil then
				arg_374_1.var_.characterEffect1033ui_story = var_377_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.2

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.characterEffect1033ui_story and not isNil(var_377_0) then
					local var_377_4 = Mathf.Lerp(0, 0.5, var_377_3)

					arg_374_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_374_1.var_.characterEffect1033ui_story.fillRatio = var_377_4
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1033ui_story then
				local var_377_5 = 0.5

				arg_374_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_374_1.var_.characterEffect1033ui_story.fillRatio = var_377_5
			end

			local var_377_6 = 0
			local var_377_7 = 0.975

			if var_377_6 < arg_374_1.time_ and arg_374_1.time_ <= var_377_6 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_8 = arg_374_1:FormatText(StoryNameCfg[14].name)

				arg_374_1.leftNameTxt_.text = var_377_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_9 = arg_374_1:GetWordFromCfg(103303092)
				local var_377_10 = arg_374_1:FormatText(var_377_9.content)

				arg_374_1.text_.text = var_377_10

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_11 = 39
				local var_377_12 = utf8.len(var_377_10)
				local var_377_13 = var_377_11 <= 0 and var_377_7 or var_377_7 * (var_377_12 / var_377_11)

				if var_377_13 > 0 and var_377_7 < var_377_13 then
					arg_374_1.talkMaxDuration = var_377_13

					if var_377_13 + var_377_6 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_13 + var_377_6
					end
				end

				arg_374_1.text_.text = var_377_10
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303092", "story_v_side_old_103303.awb") ~= 0 then
					local var_377_14 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303092", "story_v_side_old_103303.awb") / 1000

					if var_377_14 + var_377_6 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_14 + var_377_6
					end

					if var_377_9.prefab_name ~= "" and arg_374_1.actors_[var_377_9.prefab_name] ~= nil then
						local var_377_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_9.prefab_name].transform, "story_v_side_old_103303", "103303092", "story_v_side_old_103303.awb")

						arg_374_1:RecordAudio("103303092", var_377_15)
						arg_374_1:RecordAudio("103303092", var_377_15)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303092", "story_v_side_old_103303.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303092", "story_v_side_old_103303.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_16 = math.max(var_377_7, arg_374_1.talkMaxDuration)

			if var_377_6 <= arg_374_1.time_ and arg_374_1.time_ < var_377_6 + var_377_16 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_6) / var_377_16

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_6 + var_377_16 and arg_374_1.time_ < var_377_6 + var_377_16 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play103303093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 103303093
		arg_378_1.duration_ = 11.77

		local var_378_0 = {
			ja = 7.933,
			ko = 6.833,
			zh = 5.733,
			en = 11.766
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play103303094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 0.825

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_2 = arg_378_1:FormatText(StoryNameCfg[14].name)

				arg_378_1.leftNameTxt_.text = var_381_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_3 = arg_378_1:GetWordFromCfg(103303093)
				local var_381_4 = arg_378_1:FormatText(var_381_3.content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 33
				local var_381_6 = utf8.len(var_381_4)
				local var_381_7 = var_381_5 <= 0 and var_381_1 or var_381_1 * (var_381_6 / var_381_5)

				if var_381_7 > 0 and var_381_1 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303093", "story_v_side_old_103303.awb") ~= 0 then
					local var_381_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303093", "story_v_side_old_103303.awb") / 1000

					if var_381_8 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_8 + var_381_0
					end

					if var_381_3.prefab_name ~= "" and arg_378_1.actors_[var_381_3.prefab_name] ~= nil then
						local var_381_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_3.prefab_name].transform, "story_v_side_old_103303", "103303093", "story_v_side_old_103303.awb")

						arg_378_1:RecordAudio("103303093", var_381_9)
						arg_378_1:RecordAudio("103303093", var_381_9)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303093", "story_v_side_old_103303.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303093", "story_v_side_old_103303.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_10 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_10 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_10

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_10 and arg_378_1.time_ < var_381_0 + var_381_10 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play103303094 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 103303094
		arg_382_1.duration_ = 10.9

		local var_382_0 = {
			ja = 5.166,
			ko = 4.6,
			zh = 3.6,
			en = 10.9
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
				arg_382_0:Play103303095(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 0.525

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[14].name)

				arg_382_1.leftNameTxt_.text = var_385_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:GetWordFromCfg(103303094)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 21
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_1 or var_385_1 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_1 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303094", "story_v_side_old_103303.awb") ~= 0 then
					local var_385_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303094", "story_v_side_old_103303.awb") / 1000

					if var_385_8 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_8 + var_385_0
					end

					if var_385_3.prefab_name ~= "" and arg_382_1.actors_[var_385_3.prefab_name] ~= nil then
						local var_385_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_3.prefab_name].transform, "story_v_side_old_103303", "103303094", "story_v_side_old_103303.awb")

						arg_382_1:RecordAudio("103303094", var_385_9)
						arg_382_1:RecordAudio("103303094", var_385_9)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303094", "story_v_side_old_103303.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303094", "story_v_side_old_103303.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_10 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_10 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_10

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_10 and arg_382_1.time_ < var_385_0 + var_385_10 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play103303095 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 103303095
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play103303096(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["1033ui_story"].transform
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.var_.moveOldPos1033ui_story = var_389_0.localPosition
			end

			local var_389_2 = 0.001

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2
				local var_389_4 = Vector3.New(0, 100, 0)

				var_389_0.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1033ui_story, var_389_4, var_389_3)

				local var_389_5 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_5.x, var_389_5.y, var_389_5.z)

				local var_389_6 = var_389_0.localEulerAngles

				var_389_6.z = 0
				var_389_6.x = 0
				var_389_0.localEulerAngles = var_389_6
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 then
				var_389_0.localPosition = Vector3.New(0, 100, 0)

				local var_389_7 = manager.ui.mainCamera.transform.position - var_389_0.position

				var_389_0.forward = Vector3.New(var_389_7.x, var_389_7.y, var_389_7.z)

				local var_389_8 = var_389_0.localEulerAngles

				var_389_8.z = 0
				var_389_8.x = 0
				var_389_0.localEulerAngles = var_389_8
			end

			local var_389_9 = 0
			local var_389_10 = 0.85

			if var_389_9 < arg_386_1.time_ and arg_386_1.time_ <= var_389_9 + arg_389_0 then
				local var_389_11 = "play"
				local var_389_12 = "effect"

				arg_386_1:AudioAction(var_389_11, var_389_12, "se_story_side_1033", "se_story_1033_zizi02", "")
			end

			local var_389_13 = 0
			local var_389_14 = 0.15

			if var_389_13 < arg_386_1.time_ and arg_386_1.time_ <= var_389_13 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_15 = arg_386_1:GetWordFromCfg(103303095)
				local var_389_16 = arg_386_1:FormatText(var_389_15.content)

				arg_386_1.text_.text = var_389_16

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_17 = 6
				local var_389_18 = utf8.len(var_389_16)
				local var_389_19 = var_389_17 <= 0 and var_389_14 or var_389_14 * (var_389_18 / var_389_17)

				if var_389_19 > 0 and var_389_14 < var_389_19 then
					arg_386_1.talkMaxDuration = var_389_19

					if var_389_19 + var_389_13 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_19 + var_389_13
					end
				end

				arg_386_1.text_.text = var_389_16
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_20 = math.max(var_389_14, arg_386_1.talkMaxDuration)

			if var_389_13 <= arg_386_1.time_ and arg_386_1.time_ < var_389_13 + var_389_20 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_13) / var_389_20

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_13 + var_389_20 and arg_386_1.time_ < var_389_13 + var_389_20 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play103303096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 103303096
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play103303097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 0.925

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_2 = arg_390_1:GetWordFromCfg(103303096)
				local var_393_3 = arg_390_1:FormatText(var_393_2.content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 37
				local var_393_5 = utf8.len(var_393_3)
				local var_393_6 = var_393_4 <= 0 and var_393_1 or var_393_1 * (var_393_5 / var_393_4)

				if var_393_6 > 0 and var_393_1 < var_393_6 then
					arg_390_1.talkMaxDuration = var_393_6

					if var_393_6 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_6 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_3
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_7 and arg_390_1.time_ < var_393_0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play103303097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 103303097
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play103303098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.65

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_2 = arg_394_1:GetWordFromCfg(103303097)
				local var_397_3 = arg_394_1:FormatText(var_397_2.content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 26
				local var_397_5 = utf8.len(var_397_3)
				local var_397_6 = var_397_4 <= 0 and var_397_1 or var_397_1 * (var_397_5 / var_397_4)

				if var_397_6 > 0 and var_397_1 < var_397_6 then
					arg_394_1.talkMaxDuration = var_397_6

					if var_397_6 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_6 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_7 and arg_394_1.time_ < var_397_0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play103303098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 103303098
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play103303099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 1.1

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_2 = arg_398_1:GetWordFromCfg(103303098)
				local var_401_3 = arg_398_1:FormatText(var_401_2.content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 44
				local var_401_5 = utf8.len(var_401_3)
				local var_401_6 = var_401_4 <= 0 and var_401_1 or var_401_1 * (var_401_5 / var_401_4)

				if var_401_6 > 0 and var_401_1 < var_401_6 then
					arg_398_1.talkMaxDuration = var_401_6

					if var_401_6 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_6 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_7 and arg_398_1.time_ < var_401_0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play103303099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 103303099
		arg_402_1.duration_ = 4.53

		local var_402_0 = {
			ja = 4.533,
			ko = 3.4,
			zh = 2.866,
			en = 3
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
				arg_402_0:Play103303100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["1066ui_story"].transform
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.var_.moveOldPos1066ui_story = var_405_0.localPosition
			end

			local var_405_2 = 0.001

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_2 then
				local var_405_3 = (arg_402_1.time_ - var_405_1) / var_405_2
				local var_405_4 = Vector3.New(0, -0.77, -6.1)

				var_405_0.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos1066ui_story, var_405_4, var_405_3)

				local var_405_5 = manager.ui.mainCamera.transform.position - var_405_0.position

				var_405_0.forward = Vector3.New(var_405_5.x, var_405_5.y, var_405_5.z)

				local var_405_6 = var_405_0.localEulerAngles

				var_405_6.z = 0
				var_405_6.x = 0
				var_405_0.localEulerAngles = var_405_6
			end

			if arg_402_1.time_ >= var_405_1 + var_405_2 and arg_402_1.time_ < var_405_1 + var_405_2 + arg_405_0 then
				var_405_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_405_7 = manager.ui.mainCamera.transform.position - var_405_0.position

				var_405_0.forward = Vector3.New(var_405_7.x, var_405_7.y, var_405_7.z)

				local var_405_8 = var_405_0.localEulerAngles

				var_405_8.z = 0
				var_405_8.x = 0
				var_405_0.localEulerAngles = var_405_8
			end

			local var_405_9 = arg_402_1.actors_["1066ui_story"]
			local var_405_10 = 0

			if var_405_10 < arg_402_1.time_ and arg_402_1.time_ <= var_405_10 + arg_405_0 and not isNil(var_405_9) and arg_402_1.var_.characterEffect1066ui_story == nil then
				arg_402_1.var_.characterEffect1066ui_story = var_405_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_11 = 0.2

			if var_405_10 <= arg_402_1.time_ and arg_402_1.time_ < var_405_10 + var_405_11 and not isNil(var_405_9) then
				local var_405_12 = (arg_402_1.time_ - var_405_10) / var_405_11

				if arg_402_1.var_.characterEffect1066ui_story and not isNil(var_405_9) then
					arg_402_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= var_405_10 + var_405_11 and arg_402_1.time_ < var_405_10 + var_405_11 + arg_405_0 and not isNil(var_405_9) and arg_402_1.var_.characterEffect1066ui_story then
				arg_402_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_405_13 = 0

			if var_405_13 < arg_402_1.time_ and arg_402_1.time_ <= var_405_13 + arg_405_0 then
				arg_402_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action9_1")
			end

			local var_405_14 = 0

			if var_405_14 < arg_402_1.time_ and arg_402_1.time_ <= var_405_14 + arg_405_0 then
				arg_402_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_405_15 = arg_402_1.actors_["1066ui_story"]
			local var_405_16 = 0

			if var_405_16 < arg_402_1.time_ and arg_402_1.time_ <= var_405_16 + arg_405_0 then
				if arg_402_1.var_.characterEffect1066ui_story == nil then
					arg_402_1.var_.characterEffect1066ui_story = var_405_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_405_17 = arg_402_1.var_.characterEffect1066ui_story

				var_405_17.imageEffect:turnOff()

				var_405_17.interferenceEffect.enabled = true
				var_405_17.interferenceEffect.noise = 0.001
				var_405_17.interferenceEffect.simTimeScale = 1
				var_405_17.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_405_18 = arg_402_1.actors_["1066ui_story"]
			local var_405_19 = 0
			local var_405_20 = 0.034

			if var_405_19 < arg_402_1.time_ and arg_402_1.time_ <= var_405_19 + arg_405_0 then
				if arg_402_1.var_.characterEffect1066ui_story == nil then
					arg_402_1.var_.characterEffect1066ui_story = var_405_18:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_402_1.var_.characterEffect1066ui_story.imageEffect:turnOn(false)
			end

			local var_405_21 = 0
			local var_405_22 = 0.35

			if var_405_21 < arg_402_1.time_ and arg_402_1.time_ <= var_405_21 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_23 = arg_402_1:FormatText(StoryNameCfg[32].name)

				arg_402_1.leftNameTxt_.text = var_405_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_24 = arg_402_1:GetWordFromCfg(103303099)
				local var_405_25 = arg_402_1:FormatText(var_405_24.content)

				arg_402_1.text_.text = var_405_25

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_26 = 14
				local var_405_27 = utf8.len(var_405_25)
				local var_405_28 = var_405_26 <= 0 and var_405_22 or var_405_22 * (var_405_27 / var_405_26)

				if var_405_28 > 0 and var_405_22 < var_405_28 then
					arg_402_1.talkMaxDuration = var_405_28

					if var_405_28 + var_405_21 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_28 + var_405_21
					end
				end

				arg_402_1.text_.text = var_405_25
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303099", "story_v_side_old_103303.awb") ~= 0 then
					local var_405_29 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303099", "story_v_side_old_103303.awb") / 1000

					if var_405_29 + var_405_21 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_29 + var_405_21
					end

					if var_405_24.prefab_name ~= "" and arg_402_1.actors_[var_405_24.prefab_name] ~= nil then
						local var_405_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_24.prefab_name].transform, "story_v_side_old_103303", "103303099", "story_v_side_old_103303.awb")

						arg_402_1:RecordAudio("103303099", var_405_30)
						arg_402_1:RecordAudio("103303099", var_405_30)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303099", "story_v_side_old_103303.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303099", "story_v_side_old_103303.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_31 = math.max(var_405_22, arg_402_1.talkMaxDuration)

			if var_405_21 <= arg_402_1.time_ and arg_402_1.time_ < var_405_21 + var_405_31 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_21) / var_405_31

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_21 + var_405_31 and arg_402_1.time_ < var_405_21 + var_405_31 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play103303100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 103303100
		arg_406_1.duration_ = 10.77

		local var_406_0 = {
			ja = 10.766,
			ko = 8.833,
			zh = 6.366,
			en = 6.933
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
				arg_406_0:Play103303101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1066ui_story"].transform
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.var_.moveOldPos1066ui_story = var_409_0.localPosition
			end

			local var_409_2 = 0.001

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2
				local var_409_4 = Vector3.New(0, 100, 0)

				var_409_0.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1066ui_story, var_409_4, var_409_3)

				local var_409_5 = manager.ui.mainCamera.transform.position - var_409_0.position

				var_409_0.forward = Vector3.New(var_409_5.x, var_409_5.y, var_409_5.z)

				local var_409_6 = var_409_0.localEulerAngles

				var_409_6.z = 0
				var_409_6.x = 0
				var_409_0.localEulerAngles = var_409_6
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 then
				var_409_0.localPosition = Vector3.New(0, 100, 0)

				local var_409_7 = manager.ui.mainCamera.transform.position - var_409_0.position

				var_409_0.forward = Vector3.New(var_409_7.x, var_409_7.y, var_409_7.z)

				local var_409_8 = var_409_0.localEulerAngles

				var_409_8.z = 0
				var_409_8.x = 0
				var_409_0.localEulerAngles = var_409_8
			end

			local var_409_9 = arg_406_1.actors_["1066ui_story"]
			local var_409_10 = 0
			local var_409_11 = 0.034

			if var_409_10 < arg_406_1.time_ and arg_406_1.time_ <= var_409_10 + arg_409_0 then
				if arg_406_1.var_.characterEffect1066ui_story == nil then
					arg_406_1.var_.characterEffect1066ui_story = var_409_9:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_406_1.var_.characterEffect1066ui_story.imageEffect:turnOff()
			end

			local var_409_12 = 0
			local var_409_13 = 0.975

			if var_409_12 < arg_406_1.time_ and arg_406_1.time_ <= var_409_12 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_14 = arg_406_1:FormatText(StoryNameCfg[254].name)

				arg_406_1.leftNameTxt_.text = var_409_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_15 = arg_406_1:GetWordFromCfg(103303100)
				local var_409_16 = arg_406_1:FormatText(var_409_15.content)

				arg_406_1.text_.text = var_409_16

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_17 = 39
				local var_409_18 = utf8.len(var_409_16)
				local var_409_19 = var_409_17 <= 0 and var_409_13 or var_409_13 * (var_409_18 / var_409_17)

				if var_409_19 > 0 and var_409_13 < var_409_19 then
					arg_406_1.talkMaxDuration = var_409_19

					if var_409_19 + var_409_12 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_19 + var_409_12
					end
				end

				arg_406_1.text_.text = var_409_16
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303100", "story_v_side_old_103303.awb") ~= 0 then
					local var_409_20 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303100", "story_v_side_old_103303.awb") / 1000

					if var_409_20 + var_409_12 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_20 + var_409_12
					end

					if var_409_15.prefab_name ~= "" and arg_406_1.actors_[var_409_15.prefab_name] ~= nil then
						local var_409_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_15.prefab_name].transform, "story_v_side_old_103303", "103303100", "story_v_side_old_103303.awb")

						arg_406_1:RecordAudio("103303100", var_409_21)
						arg_406_1:RecordAudio("103303100", var_409_21)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303100", "story_v_side_old_103303.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303100", "story_v_side_old_103303.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_22 = math.max(var_409_13, arg_406_1.talkMaxDuration)

			if var_409_12 <= arg_406_1.time_ and arg_406_1.time_ < var_409_12 + var_409_22 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_12) / var_409_22

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_12 + var_409_22 and arg_406_1.time_ < var_409_12 + var_409_22 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play103303101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 103303101
		arg_410_1.duration_ = 12.53

		local var_410_0 = {
			ja = 12.533,
			ko = 9.533,
			zh = 6.3,
			en = 7.233
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
				arg_410_0:Play103303102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = arg_410_1.actors_["1066ui_story"].transform
			local var_413_1 = 0

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.var_.moveOldPos1066ui_story = var_413_0.localPosition
			end

			local var_413_2 = 0.001

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_2 then
				local var_413_3 = (arg_410_1.time_ - var_413_1) / var_413_2
				local var_413_4 = Vector3.New(0, -0.77, -6.1)

				var_413_0.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos1066ui_story, var_413_4, var_413_3)

				local var_413_5 = manager.ui.mainCamera.transform.position - var_413_0.position

				var_413_0.forward = Vector3.New(var_413_5.x, var_413_5.y, var_413_5.z)

				local var_413_6 = var_413_0.localEulerAngles

				var_413_6.z = 0
				var_413_6.x = 0
				var_413_0.localEulerAngles = var_413_6
			end

			if arg_410_1.time_ >= var_413_1 + var_413_2 and arg_410_1.time_ < var_413_1 + var_413_2 + arg_413_0 then
				var_413_0.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_413_7 = manager.ui.mainCamera.transform.position - var_413_0.position

				var_413_0.forward = Vector3.New(var_413_7.x, var_413_7.y, var_413_7.z)

				local var_413_8 = var_413_0.localEulerAngles

				var_413_8.z = 0
				var_413_8.x = 0
				var_413_0.localEulerAngles = var_413_8
			end

			local var_413_9 = arg_410_1.actors_["1066ui_story"]
			local var_413_10 = 0

			if var_413_10 < arg_410_1.time_ and arg_410_1.time_ <= var_413_10 + arg_413_0 and not isNil(var_413_9) and arg_410_1.var_.characterEffect1066ui_story == nil then
				arg_410_1.var_.characterEffect1066ui_story = var_413_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_11 = 0.2

			if var_413_10 <= arg_410_1.time_ and arg_410_1.time_ < var_413_10 + var_413_11 and not isNil(var_413_9) then
				local var_413_12 = (arg_410_1.time_ - var_413_10) / var_413_11

				if arg_410_1.var_.characterEffect1066ui_story and not isNil(var_413_9) then
					arg_410_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_410_1.time_ >= var_413_10 + var_413_11 and arg_410_1.time_ < var_413_10 + var_413_11 + arg_413_0 and not isNil(var_413_9) and arg_410_1.var_.characterEffect1066ui_story then
				arg_410_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_413_13 = 0

			if var_413_13 < arg_410_1.time_ and arg_410_1.time_ <= var_413_13 + arg_413_0 then
				arg_410_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action497")
			end

			local var_413_14 = 0

			if var_413_14 < arg_410_1.time_ and arg_410_1.time_ <= var_413_14 + arg_413_0 then
				arg_410_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_413_15 = arg_410_1.actors_["1066ui_story"]
			local var_413_16 = 0

			if var_413_16 < arg_410_1.time_ and arg_410_1.time_ <= var_413_16 + arg_413_0 then
				if arg_410_1.var_.characterEffect1066ui_story == nil then
					arg_410_1.var_.characterEffect1066ui_story = var_413_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_413_17 = arg_410_1.var_.characterEffect1066ui_story

				var_413_17.imageEffect:turnOff()

				var_413_17.interferenceEffect.enabled = true
				var_413_17.interferenceEffect.noise = 0.001
				var_413_17.interferenceEffect.simTimeScale = 1
				var_413_17.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_413_18 = arg_410_1.actors_["1066ui_story"]
			local var_413_19 = 0
			local var_413_20 = 0.034

			if var_413_19 < arg_410_1.time_ and arg_410_1.time_ <= var_413_19 + arg_413_0 then
				if arg_410_1.var_.characterEffect1066ui_story == nil then
					arg_410_1.var_.characterEffect1066ui_story = var_413_18:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_410_1.var_.characterEffect1066ui_story.imageEffect:turnOn(false)
			end

			local var_413_21 = 0
			local var_413_22 = 0.825

			if var_413_21 < arg_410_1.time_ and arg_410_1.time_ <= var_413_21 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_23 = arg_410_1:FormatText(StoryNameCfg[32].name)

				arg_410_1.leftNameTxt_.text = var_413_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_24 = arg_410_1:GetWordFromCfg(103303101)
				local var_413_25 = arg_410_1:FormatText(var_413_24.content)

				arg_410_1.text_.text = var_413_25

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_26 = 33
				local var_413_27 = utf8.len(var_413_25)
				local var_413_28 = var_413_26 <= 0 and var_413_22 or var_413_22 * (var_413_27 / var_413_26)

				if var_413_28 > 0 and var_413_22 < var_413_28 then
					arg_410_1.talkMaxDuration = var_413_28

					if var_413_28 + var_413_21 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_28 + var_413_21
					end
				end

				arg_410_1.text_.text = var_413_25
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303101", "story_v_side_old_103303.awb") ~= 0 then
					local var_413_29 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303101", "story_v_side_old_103303.awb") / 1000

					if var_413_29 + var_413_21 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_29 + var_413_21
					end

					if var_413_24.prefab_name ~= "" and arg_410_1.actors_[var_413_24.prefab_name] ~= nil then
						local var_413_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_24.prefab_name].transform, "story_v_side_old_103303", "103303101", "story_v_side_old_103303.awb")

						arg_410_1:RecordAudio("103303101", var_413_30)
						arg_410_1:RecordAudio("103303101", var_413_30)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303101", "story_v_side_old_103303.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303101", "story_v_side_old_103303.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_31 = math.max(var_413_22, arg_410_1.talkMaxDuration)

			if var_413_21 <= arg_410_1.time_ and arg_410_1.time_ < var_413_21 + var_413_31 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_21) / var_413_31

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_21 + var_413_31 and arg_410_1.time_ < var_413_21 + var_413_31 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play103303102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 103303102
		arg_414_1.duration_ = 9.53

		local var_414_0 = {
			ja = 9.533,
			ko = 5.6,
			zh = 3.766,
			en = 5.733
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
				arg_414_0:Play103303103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1066ui_story"].transform
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.var_.moveOldPos1066ui_story = var_417_0.localPosition
			end

			local var_417_2 = 0.001

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2
				local var_417_4 = Vector3.New(0, 100, 0)

				var_417_0.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1066ui_story, var_417_4, var_417_3)

				local var_417_5 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_5.x, var_417_5.y, var_417_5.z)

				local var_417_6 = var_417_0.localEulerAngles

				var_417_6.z = 0
				var_417_6.x = 0
				var_417_0.localEulerAngles = var_417_6
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 then
				var_417_0.localPosition = Vector3.New(0, 100, 0)

				local var_417_7 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_7.x, var_417_7.y, var_417_7.z)

				local var_417_8 = var_417_0.localEulerAngles

				var_417_8.z = 0
				var_417_8.x = 0
				var_417_0.localEulerAngles = var_417_8
			end

			local var_417_9 = arg_414_1.actors_["1066ui_story"]
			local var_417_10 = 0
			local var_417_11 = 0.034

			if var_417_10 < arg_414_1.time_ and arg_414_1.time_ <= var_417_10 + arg_417_0 then
				if arg_414_1.var_.characterEffect1066ui_story == nil then
					arg_414_1.var_.characterEffect1066ui_story = var_417_9:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_414_1.var_.characterEffect1066ui_story.imageEffect:turnOff()
			end

			local var_417_12 = 0
			local var_417_13 = 0.625

			if var_417_12 < arg_414_1.time_ and arg_414_1.time_ <= var_417_12 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_14 = arg_414_1:FormatText(StoryNameCfg[254].name)

				arg_414_1.leftNameTxt_.text = var_417_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_15 = arg_414_1:GetWordFromCfg(103303102)
				local var_417_16 = arg_414_1:FormatText(var_417_15.content)

				arg_414_1.text_.text = var_417_16

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_17 = 25
				local var_417_18 = utf8.len(var_417_16)
				local var_417_19 = var_417_17 <= 0 and var_417_13 or var_417_13 * (var_417_18 / var_417_17)

				if var_417_19 > 0 and var_417_13 < var_417_19 then
					arg_414_1.talkMaxDuration = var_417_19

					if var_417_19 + var_417_12 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_19 + var_417_12
					end
				end

				arg_414_1.text_.text = var_417_16
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303102", "story_v_side_old_103303.awb") ~= 0 then
					local var_417_20 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303102", "story_v_side_old_103303.awb") / 1000

					if var_417_20 + var_417_12 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_20 + var_417_12
					end

					if var_417_15.prefab_name ~= "" and arg_414_1.actors_[var_417_15.prefab_name] ~= nil then
						local var_417_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_15.prefab_name].transform, "story_v_side_old_103303", "103303102", "story_v_side_old_103303.awb")

						arg_414_1:RecordAudio("103303102", var_417_21)
						arg_414_1:RecordAudio("103303102", var_417_21)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303102", "story_v_side_old_103303.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303102", "story_v_side_old_103303.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_22 = math.max(var_417_13, arg_414_1.talkMaxDuration)

			if var_417_12 <= arg_414_1.time_ and arg_414_1.time_ < var_417_12 + var_417_22 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_12) / var_417_22

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_12 + var_417_22 and arg_414_1.time_ < var_417_12 + var_417_22 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play103303103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 103303103
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play103303104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 0.05

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

				local var_421_2 = arg_418_1:GetWordFromCfg(103303103)
				local var_421_3 = arg_418_1:FormatText(var_421_2.content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 2
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
	Play103303104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 103303104
		arg_422_1.duration_ = 3.5

		local var_422_0 = {
			ja = 3.5,
			ko = 3.366,
			zh = 1.999999999999,
			en = 2.866
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
				arg_422_0:Play103303105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1033ui_story"].transform
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.var_.moveOldPos1033ui_story = var_425_0.localPosition
			end

			local var_425_2 = 0.001

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2
				local var_425_4 = Vector3.New(0, -1.01, -6.13)

				var_425_0.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos1033ui_story, var_425_4, var_425_3)

				local var_425_5 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_5.x, var_425_5.y, var_425_5.z)

				local var_425_6 = var_425_0.localEulerAngles

				var_425_6.z = 0
				var_425_6.x = 0
				var_425_0.localEulerAngles = var_425_6
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 then
				var_425_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_425_7 = manager.ui.mainCamera.transform.position - var_425_0.position

				var_425_0.forward = Vector3.New(var_425_7.x, var_425_7.y, var_425_7.z)

				local var_425_8 = var_425_0.localEulerAngles

				var_425_8.z = 0
				var_425_8.x = 0
				var_425_0.localEulerAngles = var_425_8
			end

			local var_425_9 = arg_422_1.actors_["1033ui_story"]
			local var_425_10 = 0

			if var_425_10 < arg_422_1.time_ and arg_422_1.time_ <= var_425_10 + arg_425_0 and not isNil(var_425_9) and arg_422_1.var_.characterEffect1033ui_story == nil then
				arg_422_1.var_.characterEffect1033ui_story = var_425_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_11 = 0.2

			if var_425_10 <= arg_422_1.time_ and arg_422_1.time_ < var_425_10 + var_425_11 and not isNil(var_425_9) then
				local var_425_12 = (arg_422_1.time_ - var_425_10) / var_425_11

				if arg_422_1.var_.characterEffect1033ui_story and not isNil(var_425_9) then
					arg_422_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= var_425_10 + var_425_11 and arg_422_1.time_ < var_425_10 + var_425_11 + arg_425_0 and not isNil(var_425_9) and arg_422_1.var_.characterEffect1033ui_story then
				arg_422_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_425_13 = 0

			if var_425_13 < arg_422_1.time_ and arg_422_1.time_ <= var_425_13 + arg_425_0 then
				arg_422_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_425_14 = 0

			if var_425_14 < arg_422_1.time_ and arg_422_1.time_ <= var_425_14 + arg_425_0 then
				arg_422_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_425_15 = 0
			local var_425_16 = 0.2

			if var_425_15 < arg_422_1.time_ and arg_422_1.time_ <= var_425_15 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_17 = arg_422_1:FormatText(StoryNameCfg[236].name)

				arg_422_1.leftNameTxt_.text = var_425_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_18 = arg_422_1:GetWordFromCfg(103303104)
				local var_425_19 = arg_422_1:FormatText(var_425_18.content)

				arg_422_1.text_.text = var_425_19

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_20 = 8
				local var_425_21 = utf8.len(var_425_19)
				local var_425_22 = var_425_20 <= 0 and var_425_16 or var_425_16 * (var_425_21 / var_425_20)

				if var_425_22 > 0 and var_425_16 < var_425_22 then
					arg_422_1.talkMaxDuration = var_425_22

					if var_425_22 + var_425_15 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_22 + var_425_15
					end
				end

				arg_422_1.text_.text = var_425_19
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303104", "story_v_side_old_103303.awb") ~= 0 then
					local var_425_23 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303104", "story_v_side_old_103303.awb") / 1000

					if var_425_23 + var_425_15 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_23 + var_425_15
					end

					if var_425_18.prefab_name ~= "" and arg_422_1.actors_[var_425_18.prefab_name] ~= nil then
						local var_425_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_18.prefab_name].transform, "story_v_side_old_103303", "103303104", "story_v_side_old_103303.awb")

						arg_422_1:RecordAudio("103303104", var_425_24)
						arg_422_1:RecordAudio("103303104", var_425_24)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303104", "story_v_side_old_103303.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303104", "story_v_side_old_103303.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_25 = math.max(var_425_16, arg_422_1.talkMaxDuration)

			if var_425_15 <= arg_422_1.time_ and arg_422_1.time_ < var_425_15 + var_425_25 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_15) / var_425_25

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_15 + var_425_25 and arg_422_1.time_ < var_425_15 + var_425_25 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play103303105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 103303105
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play103303106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["1033ui_story"]
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect1033ui_story == nil then
				arg_426_1.var_.characterEffect1033ui_story = var_429_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.2

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 and not isNil(var_429_0) then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2

				if arg_426_1.var_.characterEffect1033ui_story and not isNil(var_429_0) then
					local var_429_4 = Mathf.Lerp(0, 0.5, var_429_3)

					arg_426_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_426_1.var_.characterEffect1033ui_story.fillRatio = var_429_4
				end
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect1033ui_story then
				local var_429_5 = 0.5

				arg_426_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_426_1.var_.characterEffect1033ui_story.fillRatio = var_429_5
			end

			local var_429_6 = 0
			local var_429_7 = 0.2

			if var_429_6 < arg_426_1.time_ and arg_426_1.time_ <= var_429_6 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_8 = arg_426_1:FormatText(StoryNameCfg[7].name)

				arg_426_1.leftNameTxt_.text = var_429_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_9 = arg_426_1:GetWordFromCfg(103303105)
				local var_429_10 = arg_426_1:FormatText(var_429_9.content)

				arg_426_1.text_.text = var_429_10

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_11 = 8
				local var_429_12 = utf8.len(var_429_10)
				local var_429_13 = var_429_11 <= 0 and var_429_7 or var_429_7 * (var_429_12 / var_429_11)

				if var_429_13 > 0 and var_429_7 < var_429_13 then
					arg_426_1.talkMaxDuration = var_429_13

					if var_429_13 + var_429_6 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_13 + var_429_6
					end
				end

				arg_426_1.text_.text = var_429_10
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_14 = math.max(var_429_7, arg_426_1.talkMaxDuration)

			if var_429_6 <= arg_426_1.time_ and arg_426_1.time_ < var_429_6 + var_429_14 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_6) / var_429_14

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_6 + var_429_14 and arg_426_1.time_ < var_429_6 + var_429_14 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play103303106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 103303106
		arg_430_1.duration_ = 10.93

		local var_430_0 = {
			ja = 10.933,
			ko = 8.733,
			zh = 7.4,
			en = 9.433
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
				arg_430_0:Play103303107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1033ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1033ui_story == nil then
				arg_430_1.var_.characterEffect1033ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.2

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect1033ui_story and not isNil(var_433_0) then
					arg_430_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1033ui_story then
				arg_430_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_433_4 = 0

			if var_433_4 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			local var_433_5 = 0

			if var_433_5 < arg_430_1.time_ and arg_430_1.time_ <= var_433_5 + arg_433_0 then
				arg_430_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_433_6 = 0
			local var_433_7 = 0.95

			if var_433_6 < arg_430_1.time_ and arg_430_1.time_ <= var_433_6 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_8 = arg_430_1:FormatText(StoryNameCfg[236].name)

				arg_430_1.leftNameTxt_.text = var_433_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_9 = arg_430_1:GetWordFromCfg(103303106)
				local var_433_10 = arg_430_1:FormatText(var_433_9.content)

				arg_430_1.text_.text = var_433_10

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_11 = 38
				local var_433_12 = utf8.len(var_433_10)
				local var_433_13 = var_433_11 <= 0 and var_433_7 or var_433_7 * (var_433_12 / var_433_11)

				if var_433_13 > 0 and var_433_7 < var_433_13 then
					arg_430_1.talkMaxDuration = var_433_13

					if var_433_13 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_13 + var_433_6
					end
				end

				arg_430_1.text_.text = var_433_10
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303106", "story_v_side_old_103303.awb") ~= 0 then
					local var_433_14 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303106", "story_v_side_old_103303.awb") / 1000

					if var_433_14 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_14 + var_433_6
					end

					if var_433_9.prefab_name ~= "" and arg_430_1.actors_[var_433_9.prefab_name] ~= nil then
						local var_433_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_9.prefab_name].transform, "story_v_side_old_103303", "103303106", "story_v_side_old_103303.awb")

						arg_430_1:RecordAudio("103303106", var_433_15)
						arg_430_1:RecordAudio("103303106", var_433_15)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303106", "story_v_side_old_103303.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303106", "story_v_side_old_103303.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_16 = math.max(var_433_7, arg_430_1.talkMaxDuration)

			if var_433_6 <= arg_430_1.time_ and arg_430_1.time_ < var_433_6 + var_433_16 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_6) / var_433_16

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_6 + var_433_16 and arg_430_1.time_ < var_433_6 + var_433_16 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play103303107 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 103303107
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play103303108(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1033ui_story"].transform
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.var_.moveOldPos1033ui_story = var_437_0.localPosition
			end

			local var_437_2 = 0.001

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2
				local var_437_4 = Vector3.New(0, 100, 0)

				var_437_0.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1033ui_story, var_437_4, var_437_3)

				local var_437_5 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_5.x, var_437_5.y, var_437_5.z)

				local var_437_6 = var_437_0.localEulerAngles

				var_437_6.z = 0
				var_437_6.x = 0
				var_437_0.localEulerAngles = var_437_6
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 then
				var_437_0.localPosition = Vector3.New(0, 100, 0)

				local var_437_7 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_7.x, var_437_7.y, var_437_7.z)

				local var_437_8 = var_437_0.localEulerAngles

				var_437_8.z = 0
				var_437_8.x = 0
				var_437_0.localEulerAngles = var_437_8
			end

			local var_437_9 = 0
			local var_437_10 = 1.2

			if var_437_9 < arg_434_1.time_ and arg_434_1.time_ <= var_437_9 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_11 = arg_434_1:GetWordFromCfg(103303107)
				local var_437_12 = arg_434_1:FormatText(var_437_11.content)

				arg_434_1.text_.text = var_437_12

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_13 = 48
				local var_437_14 = utf8.len(var_437_12)
				local var_437_15 = var_437_13 <= 0 and var_437_10 or var_437_10 * (var_437_14 / var_437_13)

				if var_437_15 > 0 and var_437_10 < var_437_15 then
					arg_434_1.talkMaxDuration = var_437_15

					if var_437_15 + var_437_9 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_15 + var_437_9
					end
				end

				arg_434_1.text_.text = var_437_12
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_16 = math.max(var_437_10, arg_434_1.talkMaxDuration)

			if var_437_9 <= arg_434_1.time_ and arg_434_1.time_ < var_437_9 + var_437_16 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_9) / var_437_16

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_9 + var_437_16 and arg_434_1.time_ < var_437_9 + var_437_16 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play103303108 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 103303108
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play103303109(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.6

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_2 = arg_438_1:GetWordFromCfg(103303108)
				local var_441_3 = arg_438_1:FormatText(var_441_2.content)

				arg_438_1.text_.text = var_441_3

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 24
				local var_441_5 = utf8.len(var_441_3)
				local var_441_6 = var_441_4 <= 0 and var_441_1 or var_441_1 * (var_441_5 / var_441_4)

				if var_441_6 > 0 and var_441_1 < var_441_6 then
					arg_438_1.talkMaxDuration = var_441_6

					if var_441_6 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_6 + var_441_0
					end
				end

				arg_438_1.text_.text = var_441_3
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_1, arg_438_1.talkMaxDuration)

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_0) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_0 + var_441_7 and arg_438_1.time_ < var_441_0 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play103303109 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 103303109
		arg_442_1.duration_ = 7

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play103303110(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				local var_445_1 = manager.ui.mainCamera.transform.localPosition
				local var_445_2 = Vector3.New(0, 0, 10) + Vector3.New(var_445_1.x, var_445_1.y, 0)
				local var_445_3 = arg_442_1.bgs_.ST12

				var_445_3.transform.localPosition = var_445_2
				var_445_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_445_4 = var_445_3:GetComponent("SpriteRenderer")

				if var_445_4 and var_445_4.sprite then
					local var_445_5 = (var_445_3.transform.localPosition - var_445_1).z
					local var_445_6 = manager.ui.mainCameraCom_
					local var_445_7 = 2 * var_445_5 * Mathf.Tan(var_445_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_445_8 = var_445_7 * var_445_6.aspect
					local var_445_9 = var_445_4.sprite.bounds.size.x
					local var_445_10 = var_445_4.sprite.bounds.size.y
					local var_445_11 = var_445_8 / var_445_9
					local var_445_12 = var_445_7 / var_445_10
					local var_445_13 = var_445_12 < var_445_11 and var_445_11 or var_445_12

					var_445_3.transform.localScale = Vector3.New(var_445_13, var_445_13, 0)
				end

				for iter_445_0, iter_445_1 in pairs(arg_442_1.bgs_) do
					if iter_445_0 ~= "ST12" then
						iter_445_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_445_14 = "B13"

			if arg_442_1.bgs_[var_445_14] == nil then
				local var_445_15 = Object.Instantiate(arg_442_1.paintGo_)

				var_445_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_445_14)
				var_445_15.name = var_445_14
				var_445_15.transform.parent = arg_442_1.stage_.transform
				var_445_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_442_1.bgs_[var_445_14] = var_445_15
			end

			local var_445_16 = 1

			if var_445_16 < arg_442_1.time_ and arg_442_1.time_ <= var_445_16 + arg_445_0 then
				local var_445_17 = manager.ui.mainCamera.transform.localPosition
				local var_445_18 = Vector3.New(0, 0, 10) + Vector3.New(var_445_17.x, var_445_17.y, 0)
				local var_445_19 = arg_442_1.bgs_.B13

				var_445_19.transform.localPosition = var_445_18
				var_445_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_445_20 = var_445_19:GetComponent("SpriteRenderer")

				if var_445_20 and var_445_20.sprite then
					local var_445_21 = (var_445_19.transform.localPosition - var_445_17).z
					local var_445_22 = manager.ui.mainCameraCom_
					local var_445_23 = 2 * var_445_21 * Mathf.Tan(var_445_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_445_24 = var_445_23 * var_445_22.aspect
					local var_445_25 = var_445_20.sprite.bounds.size.x
					local var_445_26 = var_445_20.sprite.bounds.size.y
					local var_445_27 = var_445_24 / var_445_25
					local var_445_28 = var_445_23 / var_445_26
					local var_445_29 = var_445_28 < var_445_27 and var_445_27 or var_445_28

					var_445_19.transform.localScale = Vector3.New(var_445_29, var_445_29, 0)
				end

				for iter_445_2, iter_445_3 in pairs(arg_442_1.bgs_) do
					if iter_445_2 ~= "B13" then
						iter_445_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_445_30 = 0

			if var_445_30 < arg_442_1.time_ and arg_442_1.time_ <= var_445_30 + arg_445_0 then
				arg_442_1.mask_.enabled = true
				arg_442_1.mask_.raycastTarget = false

				arg_442_1:SetGaussion(false)
			end

			local var_445_31 = 1

			if var_445_30 <= arg_442_1.time_ and arg_442_1.time_ < var_445_30 + var_445_31 then
				local var_445_32 = (arg_442_1.time_ - var_445_30) / var_445_31
				local var_445_33 = Color.New(0, 0, 0)

				var_445_33.a = Mathf.Lerp(0, 1, var_445_32)
				arg_442_1.mask_.color = var_445_33
			end

			if arg_442_1.time_ >= var_445_30 + var_445_31 and arg_442_1.time_ < var_445_30 + var_445_31 + arg_445_0 then
				local var_445_34 = Color.New(0, 0, 0)

				var_445_34.a = 1
				arg_442_1.mask_.color = var_445_34
			end

			local var_445_35 = 1

			if var_445_35 < arg_442_1.time_ and arg_442_1.time_ <= var_445_35 + arg_445_0 then
				arg_442_1.mask_.enabled = true
				arg_442_1.mask_.raycastTarget = false

				arg_442_1:SetGaussion(false)
			end

			local var_445_36 = 1

			if var_445_35 <= arg_442_1.time_ and arg_442_1.time_ < var_445_35 + var_445_36 then
				local var_445_37 = (arg_442_1.time_ - var_445_35) / var_445_36
				local var_445_38 = Color.New(0, 0, 0)

				var_445_38.a = Mathf.Lerp(1, 0, var_445_37)
				arg_442_1.mask_.color = var_445_38
			end

			if arg_442_1.time_ >= var_445_35 + var_445_36 and arg_442_1.time_ < var_445_35 + var_445_36 + arg_445_0 then
				local var_445_39 = Color.New(0, 0, 0)
				local var_445_40 = 0

				arg_442_1.mask_.enabled = false
				var_445_39.a = var_445_40
				arg_442_1.mask_.color = var_445_39
			end

			local var_445_41 = 2
			local var_445_42 = 0.05

			if var_445_41 < arg_442_1.time_ and arg_442_1.time_ <= var_445_41 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_43 = arg_442_1:FormatText(StoryNameCfg[7].name)

				arg_442_1.leftNameTxt_.text = var_445_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_44 = arg_442_1:GetWordFromCfg(103303109)
				local var_445_45 = arg_442_1:FormatText(var_445_44.content)

				arg_442_1.text_.text = var_445_45

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_46 = 2
				local var_445_47 = utf8.len(var_445_45)
				local var_445_48 = var_445_46 <= 0 and var_445_42 or var_445_42 * (var_445_47 / var_445_46)

				if var_445_48 > 0 and var_445_42 < var_445_48 then
					arg_442_1.talkMaxDuration = var_445_48

					if var_445_48 + var_445_41 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_48 + var_445_41
					end
				end

				arg_442_1.text_.text = var_445_45
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_49 = math.max(var_445_42, arg_442_1.talkMaxDuration)

			if var_445_41 <= arg_442_1.time_ and arg_442_1.time_ < var_445_41 + var_445_49 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_41) / var_445_49

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_41 + var_445_49 and arg_442_1.time_ < var_445_41 + var_445_49 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play103303110 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 103303110
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play103303111(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 0.925

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_2 = arg_446_1:FormatText(StoryNameCfg[7].name)

				arg_446_1.leftNameTxt_.text = var_449_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_3 = arg_446_1:GetWordFromCfg(103303110)
				local var_449_4 = arg_446_1:FormatText(var_449_3.content)

				arg_446_1.text_.text = var_449_4

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 37
				local var_449_6 = utf8.len(var_449_4)
				local var_449_7 = var_449_5 <= 0 and var_449_1 or var_449_1 * (var_449_6 / var_449_5)

				if var_449_7 > 0 and var_449_1 < var_449_7 then
					arg_446_1.talkMaxDuration = var_449_7

					if var_449_7 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_4
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_8 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_8 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_8

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_8 and arg_446_1.time_ < var_449_0 + var_449_8 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play103303111 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 103303111
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play103303112(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 1.15

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, false)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_2 = arg_450_1:GetWordFromCfg(103303111)
				local var_453_3 = arg_450_1:FormatText(var_453_2.content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_4 = 46
				local var_453_5 = utf8.len(var_453_3)
				local var_453_6 = var_453_4 <= 0 and var_453_1 or var_453_1 * (var_453_5 / var_453_4)

				if var_453_6 > 0 and var_453_1 < var_453_6 then
					arg_450_1.talkMaxDuration = var_453_6

					if var_453_6 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_6 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_7 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_7 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_7

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_7 and arg_450_1.time_ < var_453_0 + var_453_7 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play103303112 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 103303112
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play103303113(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 1.05

			if var_457_0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, false)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_2 = arg_454_1:GetWordFromCfg(103303112)
				local var_457_3 = arg_454_1:FormatText(var_457_2.content)

				arg_454_1.text_.text = var_457_3

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_4 = 42
				local var_457_5 = utf8.len(var_457_3)
				local var_457_6 = var_457_4 <= 0 and var_457_1 or var_457_1 * (var_457_5 / var_457_4)

				if var_457_6 > 0 and var_457_1 < var_457_6 then
					arg_454_1.talkMaxDuration = var_457_6

					if var_457_6 + var_457_0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_6 + var_457_0
					end
				end

				arg_454_1.text_.text = var_457_3
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_7 = math.max(var_457_1, arg_454_1.talkMaxDuration)

			if var_457_0 <= arg_454_1.time_ and arg_454_1.time_ < var_457_0 + var_457_7 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_0) / var_457_7

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_0 + var_457_7 and arg_454_1.time_ < var_457_0 + var_457_7 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play103303113 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 103303113
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play103303114(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0
			local var_461_1 = 0.65

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_2 = arg_458_1:FormatText(StoryNameCfg[7].name)

				arg_458_1.leftNameTxt_.text = var_461_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_3 = arg_458_1:GetWordFromCfg(103303113)
				local var_461_4 = arg_458_1:FormatText(var_461_3.content)

				arg_458_1.text_.text = var_461_4

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 26
				local var_461_6 = utf8.len(var_461_4)
				local var_461_7 = var_461_5 <= 0 and var_461_1 or var_461_1 * (var_461_6 / var_461_5)

				if var_461_7 > 0 and var_461_1 < var_461_7 then
					arg_458_1.talkMaxDuration = var_461_7

					if var_461_7 + var_461_0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_7 + var_461_0
					end
				end

				arg_458_1.text_.text = var_461_4
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_8 = math.max(var_461_1, arg_458_1.talkMaxDuration)

			if var_461_0 <= arg_458_1.time_ and arg_458_1.time_ < var_461_0 + var_461_8 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_0) / var_461_8

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_0 + var_461_8 and arg_458_1.time_ < var_461_0 + var_461_8 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play103303114 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 103303114
		arg_462_1.duration_ = 10.2

		local var_462_0 = {
			ja = 10.2,
			ko = 5.7,
			zh = 5.5,
			en = 5
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
				arg_462_0:Play103303115(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["1033ui_story"].transform
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 then
				arg_462_1.var_.moveOldPos1033ui_story = var_465_0.localPosition
			end

			local var_465_2 = 0.001

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2
				local var_465_4 = Vector3.New(0, -1.01, -6.13)

				var_465_0.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos1033ui_story, var_465_4, var_465_3)

				local var_465_5 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_5.x, var_465_5.y, var_465_5.z)

				local var_465_6 = var_465_0.localEulerAngles

				var_465_6.z = 0
				var_465_6.x = 0
				var_465_0.localEulerAngles = var_465_6
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 then
				var_465_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_465_7 = manager.ui.mainCamera.transform.position - var_465_0.position

				var_465_0.forward = Vector3.New(var_465_7.x, var_465_7.y, var_465_7.z)

				local var_465_8 = var_465_0.localEulerAngles

				var_465_8.z = 0
				var_465_8.x = 0
				var_465_0.localEulerAngles = var_465_8
			end

			local var_465_9 = arg_462_1.actors_["1033ui_story"]
			local var_465_10 = 0

			if var_465_10 < arg_462_1.time_ and arg_462_1.time_ <= var_465_10 + arg_465_0 and not isNil(var_465_9) and arg_462_1.var_.characterEffect1033ui_story == nil then
				arg_462_1.var_.characterEffect1033ui_story = var_465_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_11 = 0.2

			if var_465_10 <= arg_462_1.time_ and arg_462_1.time_ < var_465_10 + var_465_11 and not isNil(var_465_9) then
				local var_465_12 = (arg_462_1.time_ - var_465_10) / var_465_11

				if arg_462_1.var_.characterEffect1033ui_story and not isNil(var_465_9) then
					arg_462_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_10 + var_465_11 and arg_462_1.time_ < var_465_10 + var_465_11 + arg_465_0 and not isNil(var_465_9) and arg_462_1.var_.characterEffect1033ui_story then
				arg_462_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_465_13 = 0

			if var_465_13 < arg_462_1.time_ and arg_462_1.time_ <= var_465_13 + arg_465_0 then
				arg_462_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action8_1")
			end

			local var_465_14 = 0

			if var_465_14 < arg_462_1.time_ and arg_462_1.time_ <= var_465_14 + arg_465_0 then
				arg_462_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_465_15 = 0
			local var_465_16 = 0.7

			if var_465_15 < arg_462_1.time_ and arg_462_1.time_ <= var_465_15 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_17 = arg_462_1:FormatText(StoryNameCfg[236].name)

				arg_462_1.leftNameTxt_.text = var_465_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_18 = arg_462_1:GetWordFromCfg(103303114)
				local var_465_19 = arg_462_1:FormatText(var_465_18.content)

				arg_462_1.text_.text = var_465_19

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_20 = 28
				local var_465_21 = utf8.len(var_465_19)
				local var_465_22 = var_465_20 <= 0 and var_465_16 or var_465_16 * (var_465_21 / var_465_20)

				if var_465_22 > 0 and var_465_16 < var_465_22 then
					arg_462_1.talkMaxDuration = var_465_22

					if var_465_22 + var_465_15 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_22 + var_465_15
					end
				end

				arg_462_1.text_.text = var_465_19
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303114", "story_v_side_old_103303.awb") ~= 0 then
					local var_465_23 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303114", "story_v_side_old_103303.awb") / 1000

					if var_465_23 + var_465_15 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_23 + var_465_15
					end

					if var_465_18.prefab_name ~= "" and arg_462_1.actors_[var_465_18.prefab_name] ~= nil then
						local var_465_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_18.prefab_name].transform, "story_v_side_old_103303", "103303114", "story_v_side_old_103303.awb")

						arg_462_1:RecordAudio("103303114", var_465_24)
						arg_462_1:RecordAudio("103303114", var_465_24)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303114", "story_v_side_old_103303.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303114", "story_v_side_old_103303.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_25 = math.max(var_465_16, arg_462_1.talkMaxDuration)

			if var_465_15 <= arg_462_1.time_ and arg_462_1.time_ < var_465_15 + var_465_25 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_15) / var_465_25

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_15 + var_465_25 and arg_462_1.time_ < var_465_15 + var_465_25 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_462_1:InitPlayNodeList()
	end,
	Play103303115 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 103303115
		arg_466_1.duration_ = 18.17

		local var_466_0 = {
			ja = 18.166,
			ko = 12.1,
			zh = 10.1,
			en = 10.166
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
				arg_466_0:Play103303116(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_469_1 = 0
			local var_469_2 = 1.225

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_3 = arg_466_1:FormatText(StoryNameCfg[236].name)

				arg_466_1.leftNameTxt_.text = var_469_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_4 = arg_466_1:GetWordFromCfg(103303115)
				local var_469_5 = arg_466_1:FormatText(var_469_4.content)

				arg_466_1.text_.text = var_469_5

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_6 = 49
				local var_469_7 = utf8.len(var_469_5)
				local var_469_8 = var_469_6 <= 0 and var_469_2 or var_469_2 * (var_469_7 / var_469_6)

				if var_469_8 > 0 and var_469_2 < var_469_8 then
					arg_466_1.talkMaxDuration = var_469_8

					if var_469_8 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_1
					end
				end

				arg_466_1.text_.text = var_469_5
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303115", "story_v_side_old_103303.awb") ~= 0 then
					local var_469_9 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303115", "story_v_side_old_103303.awb") / 1000

					if var_469_9 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_9 + var_469_1
					end

					if var_469_4.prefab_name ~= "" and arg_466_1.actors_[var_469_4.prefab_name] ~= nil then
						local var_469_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_4.prefab_name].transform, "story_v_side_old_103303", "103303115", "story_v_side_old_103303.awb")

						arg_466_1:RecordAudio("103303115", var_469_10)
						arg_466_1:RecordAudio("103303115", var_469_10)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303115", "story_v_side_old_103303.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303115", "story_v_side_old_103303.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_11 = math.max(var_469_2, arg_466_1.talkMaxDuration)

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_11 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_1) / var_469_11

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_1 + var_469_11 and arg_466_1.time_ < var_469_1 + var_469_11 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play103303116 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 103303116
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play103303117(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1033ui_story"].transform
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1.var_.moveOldPos1033ui_story = var_473_0.localPosition
			end

			local var_473_2 = 0.001

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2
				local var_473_4 = Vector3.New(0, 100, 0)

				var_473_0.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1033ui_story, var_473_4, var_473_3)

				local var_473_5 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_5.x, var_473_5.y, var_473_5.z)

				local var_473_6 = var_473_0.localEulerAngles

				var_473_6.z = 0
				var_473_6.x = 0
				var_473_0.localEulerAngles = var_473_6
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 then
				var_473_0.localPosition = Vector3.New(0, 100, 0)

				local var_473_7 = manager.ui.mainCamera.transform.position - var_473_0.position

				var_473_0.forward = Vector3.New(var_473_7.x, var_473_7.y, var_473_7.z)

				local var_473_8 = var_473_0.localEulerAngles

				var_473_8.z = 0
				var_473_8.x = 0
				var_473_0.localEulerAngles = var_473_8
			end

			local var_473_9 = 0
			local var_473_10 = 0.6

			if var_473_9 < arg_470_1.time_ and arg_470_1.time_ <= var_473_9 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_11 = arg_470_1:GetWordFromCfg(103303116)
				local var_473_12 = arg_470_1:FormatText(var_473_11.content)

				arg_470_1.text_.text = var_473_12

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_13 = 24
				local var_473_14 = utf8.len(var_473_12)
				local var_473_15 = var_473_13 <= 0 and var_473_10 or var_473_10 * (var_473_14 / var_473_13)

				if var_473_15 > 0 and var_473_10 < var_473_15 then
					arg_470_1.talkMaxDuration = var_473_15

					if var_473_15 + var_473_9 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_15 + var_473_9
					end
				end

				arg_470_1.text_.text = var_473_12
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_16 = math.max(var_473_10, arg_470_1.talkMaxDuration)

			if var_473_9 <= arg_470_1.time_ and arg_470_1.time_ < var_473_9 + var_473_16 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_9) / var_473_16

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_9 + var_473_16 and arg_470_1.time_ < var_473_9 + var_473_16 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play103303117 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 103303117
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play103303118(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0
			local var_477_1 = 0.125

			if var_477_0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_2 = arg_474_1:FormatText(StoryNameCfg[7].name)

				arg_474_1.leftNameTxt_.text = var_477_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_3 = arg_474_1:GetWordFromCfg(103303117)
				local var_477_4 = arg_474_1:FormatText(var_477_3.content)

				arg_474_1.text_.text = var_477_4

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 5
				local var_477_6 = utf8.len(var_477_4)
				local var_477_7 = var_477_5 <= 0 and var_477_1 or var_477_1 * (var_477_6 / var_477_5)

				if var_477_7 > 0 and var_477_1 < var_477_7 then
					arg_474_1.talkMaxDuration = var_477_7

					if var_477_7 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_7 + var_477_0
					end
				end

				arg_474_1.text_.text = var_477_4
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_8 = math.max(var_477_1, arg_474_1.talkMaxDuration)

			if var_477_0 <= arg_474_1.time_ and arg_474_1.time_ < var_477_0 + var_477_8 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_0) / var_477_8

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_0 + var_477_8 and arg_474_1.time_ < var_477_0 + var_477_8 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play103303118 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 103303118
		arg_478_1.duration_ = 5.93

		local var_478_0 = {
			ja = 5.933,
			ko = 2.2,
			zh = 2.633,
			en = 3.5
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
				arg_478_0:Play103303119(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 0.25

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_2 = arg_478_1:FormatText(StoryNameCfg[36].name)

				arg_478_1.leftNameTxt_.text = var_481_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_3 = arg_478_1:GetWordFromCfg(103303118)
				local var_481_4 = arg_478_1:FormatText(var_481_3.content)

				arg_478_1.text_.text = var_481_4

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 9
				local var_481_6 = utf8.len(var_481_4)
				local var_481_7 = var_481_5 <= 0 and var_481_1 or var_481_1 * (var_481_6 / var_481_5)

				if var_481_7 > 0 and var_481_1 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_4
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303118", "story_v_side_old_103303.awb") ~= 0 then
					local var_481_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303118", "story_v_side_old_103303.awb") / 1000

					if var_481_8 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_8 + var_481_0
					end

					if var_481_3.prefab_name ~= "" and arg_478_1.actors_[var_481_3.prefab_name] ~= nil then
						local var_481_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_3.prefab_name].transform, "story_v_side_old_103303", "103303118", "story_v_side_old_103303.awb")

						arg_478_1:RecordAudio("103303118", var_481_9)
						arg_478_1:RecordAudio("103303118", var_481_9)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303118", "story_v_side_old_103303.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303118", "story_v_side_old_103303.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_10 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_10 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_10

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_10 and arg_478_1.time_ < var_481_0 + var_481_10 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play103303119 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 103303119
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play103303120(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.875

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				local var_485_2 = "play"
				local var_485_3 = "effect"

				arg_482_1:AudioAction(var_485_2, var_485_3, "se_story_side_1033", "se_story_1033_elevator", "")
			end

			local var_485_4 = 0
			local var_485_5 = 0.875

			if var_485_4 < arg_482_1.time_ and arg_482_1.time_ <= var_485_4 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, false)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_6 = arg_482_1:GetWordFromCfg(103303119)
				local var_485_7 = arg_482_1:FormatText(var_485_6.content)

				arg_482_1.text_.text = var_485_7

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_8 = 35
				local var_485_9 = utf8.len(var_485_7)
				local var_485_10 = var_485_8 <= 0 and var_485_5 or var_485_5 * (var_485_9 / var_485_8)

				if var_485_10 > 0 and var_485_5 < var_485_10 then
					arg_482_1.talkMaxDuration = var_485_10

					if var_485_10 + var_485_4 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_10 + var_485_4
					end
				end

				arg_482_1.text_.text = var_485_7
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_11 = math.max(var_485_5, arg_482_1.talkMaxDuration)

			if var_485_4 <= arg_482_1.time_ and arg_482_1.time_ < var_485_4 + var_485_11 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_4) / var_485_11

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_4 + var_485_11 and arg_482_1.time_ < var_485_4 + var_485_11 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play103303120 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 103303120
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play103303121(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 0.275

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_2 = arg_486_1:FormatText(StoryNameCfg[7].name)

				arg_486_1.leftNameTxt_.text = var_489_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_3 = arg_486_1:GetWordFromCfg(103303120)
				local var_489_4 = arg_486_1:FormatText(var_489_3.content)

				arg_486_1.text_.text = var_489_4

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_5 = 11
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
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_8 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_8 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_8

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_8 and arg_486_1.time_ < var_489_0 + var_489_8 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play103303121 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 103303121
		arg_490_1.duration_ = 3.97

		local var_490_0 = {
			ja = 2.666,
			ko = 3.1,
			zh = 2.933,
			en = 3.966
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
				arg_490_0:Play103303122(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0
			local var_493_1 = 0.4

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_2 = arg_490_1:FormatText(StoryNameCfg[10].name)

				arg_490_1.leftNameTxt_.text = var_493_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, true)
				arg_490_1.iconController_:SetSelectedState("hero")

				arg_490_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_490_1.callingController_:SetSelectedState("normal")

				arg_490_1.keyicon_.color = Color.New(1, 1, 1)
				arg_490_1.icon_.color = Color.New(1, 1, 1)

				local var_493_3 = arg_490_1:GetWordFromCfg(103303121)
				local var_493_4 = arg_490_1:FormatText(var_493_3.content)

				arg_490_1.text_.text = var_493_4

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 16
				local var_493_6 = utf8.len(var_493_4)
				local var_493_7 = var_493_5 <= 0 and var_493_1 or var_493_1 * (var_493_6 / var_493_5)

				if var_493_7 > 0 and var_493_1 < var_493_7 then
					arg_490_1.talkMaxDuration = var_493_7

					if var_493_7 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_7 + var_493_0
					end
				end

				arg_490_1.text_.text = var_493_4
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303121", "story_v_side_old_103303.awb") ~= 0 then
					local var_493_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303121", "story_v_side_old_103303.awb") / 1000

					if var_493_8 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_0
					end

					if var_493_3.prefab_name ~= "" and arg_490_1.actors_[var_493_3.prefab_name] ~= nil then
						local var_493_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_3.prefab_name].transform, "story_v_side_old_103303", "103303121", "story_v_side_old_103303.awb")

						arg_490_1:RecordAudio("103303121", var_493_9)
						arg_490_1:RecordAudio("103303121", var_493_9)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303121", "story_v_side_old_103303.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303121", "story_v_side_old_103303.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_10 = math.max(var_493_1, arg_490_1.talkMaxDuration)

			if var_493_0 <= arg_490_1.time_ and arg_490_1.time_ < var_493_0 + var_493_10 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_0) / var_493_10

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_0 + var_493_10 and arg_490_1.time_ < var_493_0 + var_493_10 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play103303122 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 103303122
		arg_494_1.duration_ = 6.97

		local var_494_0 = {
			ja = 5.266,
			ko = 6.4,
			zh = 6.2,
			en = 6.966
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play103303123(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = 0
			local var_497_1 = 0.625

			if var_497_0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_2 = arg_494_1:FormatText(StoryNameCfg[10].name)

				arg_494_1.leftNameTxt_.text = var_497_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_3 = arg_494_1:GetWordFromCfg(103303122)
				local var_497_4 = arg_494_1:FormatText(var_497_3.content)

				arg_494_1.text_.text = var_497_4

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 25
				local var_497_6 = utf8.len(var_497_4)
				local var_497_7 = var_497_5 <= 0 and var_497_1 or var_497_1 * (var_497_6 / var_497_5)

				if var_497_7 > 0 and var_497_1 < var_497_7 then
					arg_494_1.talkMaxDuration = var_497_7

					if var_497_7 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_7 + var_497_0
					end
				end

				arg_494_1.text_.text = var_497_4
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303122", "story_v_side_old_103303.awb") ~= 0 then
					local var_497_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303122", "story_v_side_old_103303.awb") / 1000

					if var_497_8 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_8 + var_497_0
					end

					if var_497_3.prefab_name ~= "" and arg_494_1.actors_[var_497_3.prefab_name] ~= nil then
						local var_497_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_3.prefab_name].transform, "story_v_side_old_103303", "103303122", "story_v_side_old_103303.awb")

						arg_494_1:RecordAudio("103303122", var_497_9)
						arg_494_1:RecordAudio("103303122", var_497_9)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303122", "story_v_side_old_103303.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303122", "story_v_side_old_103303.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_10 = math.max(var_497_1, arg_494_1.talkMaxDuration)

			if var_497_0 <= arg_494_1.time_ and arg_494_1.time_ < var_497_0 + var_497_10 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_0) / var_497_10

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_0 + var_497_10 and arg_494_1.time_ < var_497_0 + var_497_10 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play103303123 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 103303123
		arg_498_1.duration_ = 15

		local var_498_0 = {
			ja = 15,
			ko = 11.066,
			zh = 8.1,
			en = 9.733
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play103303124(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1033ui_story"].transform
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 then
				arg_498_1.var_.moveOldPos1033ui_story = var_501_0.localPosition
			end

			local var_501_2 = 0.001

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2
				local var_501_4 = Vector3.New(0, -1.01, -6.13)

				var_501_0.localPosition = Vector3.Lerp(arg_498_1.var_.moveOldPos1033ui_story, var_501_4, var_501_3)

				local var_501_5 = manager.ui.mainCamera.transform.position - var_501_0.position

				var_501_0.forward = Vector3.New(var_501_5.x, var_501_5.y, var_501_5.z)

				local var_501_6 = var_501_0.localEulerAngles

				var_501_6.z = 0
				var_501_6.x = 0
				var_501_0.localEulerAngles = var_501_6
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 then
				var_501_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_501_7 = manager.ui.mainCamera.transform.position - var_501_0.position

				var_501_0.forward = Vector3.New(var_501_7.x, var_501_7.y, var_501_7.z)

				local var_501_8 = var_501_0.localEulerAngles

				var_501_8.z = 0
				var_501_8.x = 0
				var_501_0.localEulerAngles = var_501_8
			end

			local var_501_9 = 0

			if var_501_9 < arg_498_1.time_ and arg_498_1.time_ <= var_501_9 + arg_501_0 then
				arg_498_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action483")
			end

			local var_501_10 = 0

			if var_501_10 < arg_498_1.time_ and arg_498_1.time_ <= var_501_10 + arg_501_0 then
				arg_498_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_501_11 = 0
			local var_501_12 = 1.225

			if var_501_11 < arg_498_1.time_ and arg_498_1.time_ <= var_501_11 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_13 = arg_498_1:FormatText(StoryNameCfg[236].name)

				arg_498_1.leftNameTxt_.text = var_501_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_14 = arg_498_1:GetWordFromCfg(103303123)
				local var_501_15 = arg_498_1:FormatText(var_501_14.content)

				arg_498_1.text_.text = var_501_15

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_16 = 49
				local var_501_17 = utf8.len(var_501_15)
				local var_501_18 = var_501_16 <= 0 and var_501_12 or var_501_12 * (var_501_17 / var_501_16)

				if var_501_18 > 0 and var_501_12 < var_501_18 then
					arg_498_1.talkMaxDuration = var_501_18

					if var_501_18 + var_501_11 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_18 + var_501_11
					end
				end

				arg_498_1.text_.text = var_501_15
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303123", "story_v_side_old_103303.awb") ~= 0 then
					local var_501_19 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303123", "story_v_side_old_103303.awb") / 1000

					if var_501_19 + var_501_11 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_19 + var_501_11
					end

					if var_501_14.prefab_name ~= "" and arg_498_1.actors_[var_501_14.prefab_name] ~= nil then
						local var_501_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_14.prefab_name].transform, "story_v_side_old_103303", "103303123", "story_v_side_old_103303.awb")

						arg_498_1:RecordAudio("103303123", var_501_20)
						arg_498_1:RecordAudio("103303123", var_501_20)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303123", "story_v_side_old_103303.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303123", "story_v_side_old_103303.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_21 = math.max(var_501_12, arg_498_1.talkMaxDuration)

			if var_501_11 <= arg_498_1.time_ and arg_498_1.time_ < var_501_11 + var_501_21 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_11) / var_501_21

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_11 + var_501_21 and arg_498_1.time_ < var_501_11 + var_501_21 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_498_1:InitPlayNodeList()
	end,
	Play103303124 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 103303124
		arg_502_1.duration_ = 12.2

		local var_502_0 = {
			ja = 12.1,
			ko = 12.2,
			zh = 8.2,
			en = 10.6
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play103303125(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["1033ui_story"].transform
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 then
				arg_502_1.var_.moveOldPos1033ui_story = var_505_0.localPosition
			end

			local var_505_2 = 0.001

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2
				local var_505_4 = Vector3.New(0, 100, 0)

				var_505_0.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPos1033ui_story, var_505_4, var_505_3)

				local var_505_5 = manager.ui.mainCamera.transform.position - var_505_0.position

				var_505_0.forward = Vector3.New(var_505_5.x, var_505_5.y, var_505_5.z)

				local var_505_6 = var_505_0.localEulerAngles

				var_505_6.z = 0
				var_505_6.x = 0
				var_505_0.localEulerAngles = var_505_6
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 then
				var_505_0.localPosition = Vector3.New(0, 100, 0)

				local var_505_7 = manager.ui.mainCamera.transform.position - var_505_0.position

				var_505_0.forward = Vector3.New(var_505_7.x, var_505_7.y, var_505_7.z)

				local var_505_8 = var_505_0.localEulerAngles

				var_505_8.z = 0
				var_505_8.x = 0
				var_505_0.localEulerAngles = var_505_8
			end

			local var_505_9 = 0
			local var_505_10 = 0.925

			if var_505_9 < arg_502_1.time_ and arg_502_1.time_ <= var_505_9 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_11 = arg_502_1:FormatText(StoryNameCfg[10].name)

				arg_502_1.leftNameTxt_.text = var_505_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_12 = arg_502_1:GetWordFromCfg(103303124)
				local var_505_13 = arg_502_1:FormatText(var_505_12.content)

				arg_502_1.text_.text = var_505_13

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_14 = 37
				local var_505_15 = utf8.len(var_505_13)
				local var_505_16 = var_505_14 <= 0 and var_505_10 or var_505_10 * (var_505_15 / var_505_14)

				if var_505_16 > 0 and var_505_10 < var_505_16 then
					arg_502_1.talkMaxDuration = var_505_16

					if var_505_16 + var_505_9 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_16 + var_505_9
					end
				end

				arg_502_1.text_.text = var_505_13
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303124", "story_v_side_old_103303.awb") ~= 0 then
					local var_505_17 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303124", "story_v_side_old_103303.awb") / 1000

					if var_505_17 + var_505_9 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_17 + var_505_9
					end

					if var_505_12.prefab_name ~= "" and arg_502_1.actors_[var_505_12.prefab_name] ~= nil then
						local var_505_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_12.prefab_name].transform, "story_v_side_old_103303", "103303124", "story_v_side_old_103303.awb")

						arg_502_1:RecordAudio("103303124", var_505_18)
						arg_502_1:RecordAudio("103303124", var_505_18)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303124", "story_v_side_old_103303.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303124", "story_v_side_old_103303.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_19 = math.max(var_505_10, arg_502_1.talkMaxDuration)

			if var_505_9 <= arg_502_1.time_ and arg_502_1.time_ < var_505_9 + var_505_19 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_9) / var_505_19

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_9 + var_505_19 and arg_502_1.time_ < var_505_9 + var_505_19 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_502_1:InitPlayNodeList()
	end,
	Play103303125 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 103303125
		arg_506_1.duration_ = 11.7

		local var_506_0 = {
			ja = 11.7,
			ko = 8.033,
			zh = 5.3,
			en = 8.9
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play103303126(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0
			local var_509_1 = 0.575

			if var_509_0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_2 = arg_506_1:FormatText(StoryNameCfg[10].name)

				arg_506_1.leftNameTxt_.text = var_509_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, true)
				arg_506_1.iconController_:SetSelectedState("hero")

				arg_506_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_506_1.callingController_:SetSelectedState("normal")

				arg_506_1.keyicon_.color = Color.New(1, 1, 1)
				arg_506_1.icon_.color = Color.New(1, 1, 1)

				local var_509_3 = arg_506_1:GetWordFromCfg(103303125)
				local var_509_4 = arg_506_1:FormatText(var_509_3.content)

				arg_506_1.text_.text = var_509_4

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 23
				local var_509_6 = utf8.len(var_509_4)
				local var_509_7 = var_509_5 <= 0 and var_509_1 or var_509_1 * (var_509_6 / var_509_5)

				if var_509_7 > 0 and var_509_1 < var_509_7 then
					arg_506_1.talkMaxDuration = var_509_7

					if var_509_7 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_7 + var_509_0
					end
				end

				arg_506_1.text_.text = var_509_4
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303125", "story_v_side_old_103303.awb") ~= 0 then
					local var_509_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303125", "story_v_side_old_103303.awb") / 1000

					if var_509_8 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_8 + var_509_0
					end

					if var_509_3.prefab_name ~= "" and arg_506_1.actors_[var_509_3.prefab_name] ~= nil then
						local var_509_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_3.prefab_name].transform, "story_v_side_old_103303", "103303125", "story_v_side_old_103303.awb")

						arg_506_1:RecordAudio("103303125", var_509_9)
						arg_506_1:RecordAudio("103303125", var_509_9)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303125", "story_v_side_old_103303.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303125", "story_v_side_old_103303.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_10 = math.max(var_509_1, arg_506_1.talkMaxDuration)

			if var_509_0 <= arg_506_1.time_ and arg_506_1.time_ < var_509_0 + var_509_10 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_0) / var_509_10

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_0 + var_509_10 and arg_506_1.time_ < var_509_0 + var_509_10 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play103303126 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 103303126
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play103303127(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0
			local var_513_1 = 0.275

			if var_513_0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_2 = arg_510_1:GetWordFromCfg(103303126)
				local var_513_3 = arg_510_1:FormatText(var_513_2.content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_4 = 11
				local var_513_5 = utf8.len(var_513_3)
				local var_513_6 = var_513_4 <= 0 and var_513_1 or var_513_1 * (var_513_5 / var_513_4)

				if var_513_6 > 0 and var_513_1 < var_513_6 then
					arg_510_1.talkMaxDuration = var_513_6

					if var_513_6 + var_513_0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_6 + var_513_0
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_7 = math.max(var_513_1, arg_510_1.talkMaxDuration)

			if var_513_0 <= arg_510_1.time_ and arg_510_1.time_ < var_513_0 + var_513_7 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_0) / var_513_7

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_0 + var_513_7 and arg_510_1.time_ < var_513_0 + var_513_7 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play103303127 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 103303127
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play103303128(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0
			local var_517_1 = 0.925

			if var_517_0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_2 = arg_514_1:GetWordFromCfg(103303127)
				local var_517_3 = arg_514_1:FormatText(var_517_2.content)

				arg_514_1.text_.text = var_517_3

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_4 = 37
				local var_517_5 = utf8.len(var_517_3)
				local var_517_6 = var_517_4 <= 0 and var_517_1 or var_517_1 * (var_517_5 / var_517_4)

				if var_517_6 > 0 and var_517_1 < var_517_6 then
					arg_514_1.talkMaxDuration = var_517_6

					if var_517_6 + var_517_0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_6 + var_517_0
					end
				end

				arg_514_1.text_.text = var_517_3
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_7 = math.max(var_517_1, arg_514_1.talkMaxDuration)

			if var_517_0 <= arg_514_1.time_ and arg_514_1.time_ < var_517_0 + var_517_7 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_0) / var_517_7

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_0 + var_517_7 and arg_514_1.time_ < var_517_0 + var_517_7 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play103303128 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 103303128
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play103303129(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0
			local var_521_1 = 1.25

			if var_521_0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_0 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_2 = arg_518_1:GetWordFromCfg(103303128)
				local var_521_3 = arg_518_1:FormatText(var_521_2.content)

				arg_518_1.text_.text = var_521_3

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_4 = 50
				local var_521_5 = utf8.len(var_521_3)
				local var_521_6 = var_521_4 <= 0 and var_521_1 or var_521_1 * (var_521_5 / var_521_4)

				if var_521_6 > 0 and var_521_1 < var_521_6 then
					arg_518_1.talkMaxDuration = var_521_6

					if var_521_6 + var_521_0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_6 + var_521_0
					end
				end

				arg_518_1.text_.text = var_521_3
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_7 = math.max(var_521_1, arg_518_1.talkMaxDuration)

			if var_521_0 <= arg_518_1.time_ and arg_518_1.time_ < var_521_0 + var_521_7 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_0) / var_521_7

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_0 + var_521_7 and arg_518_1.time_ < var_521_0 + var_521_7 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play103303129 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 103303129
		arg_522_1.duration_ = 2.83

		local var_522_0 = {
			ja = 2.833,
			ko = 1.133,
			zh = 1.366,
			en = 1.4
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play103303130(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = 0
			local var_525_1 = 0.075

			if var_525_0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_0 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_2 = arg_522_1:FormatText(StoryNameCfg[10].name)

				arg_522_1.leftNameTxt_.text = var_525_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_522_1.callingController_:SetSelectedState("normal")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_3 = arg_522_1:GetWordFromCfg(103303129)
				local var_525_4 = arg_522_1:FormatText(var_525_3.content)

				arg_522_1.text_.text = var_525_4

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303129", "story_v_side_old_103303.awb") ~= 0 then
					local var_525_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303129", "story_v_side_old_103303.awb") / 1000

					if var_525_8 + var_525_0 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_8 + var_525_0
					end

					if var_525_3.prefab_name ~= "" and arg_522_1.actors_[var_525_3.prefab_name] ~= nil then
						local var_525_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_3.prefab_name].transform, "story_v_side_old_103303", "103303129", "story_v_side_old_103303.awb")

						arg_522_1:RecordAudio("103303129", var_525_9)
						arg_522_1:RecordAudio("103303129", var_525_9)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303129", "story_v_side_old_103303.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303129", "story_v_side_old_103303.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_10 = math.max(var_525_1, arg_522_1.talkMaxDuration)

			if var_525_0 <= arg_522_1.time_ and arg_522_1.time_ < var_525_0 + var_525_10 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_0) / var_525_10

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_0 + var_525_10 and arg_522_1.time_ < var_525_0 + var_525_10 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play103303130 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 103303130
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play103303131(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0
			local var_529_1 = 0.85

			if var_529_0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, false)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_2 = arg_526_1:GetWordFromCfg(103303130)
				local var_529_3 = arg_526_1:FormatText(var_529_2.content)

				arg_526_1.text_.text = var_529_3

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_4 = 34
				local var_529_5 = utf8.len(var_529_3)
				local var_529_6 = var_529_4 <= 0 and var_529_1 or var_529_1 * (var_529_5 / var_529_4)

				if var_529_6 > 0 and var_529_1 < var_529_6 then
					arg_526_1.talkMaxDuration = var_529_6

					if var_529_6 + var_529_0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_6 + var_529_0
					end
				end

				arg_526_1.text_.text = var_529_3
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_7 = math.max(var_529_1, arg_526_1.talkMaxDuration)

			if var_529_0 <= arg_526_1.time_ and arg_526_1.time_ < var_529_0 + var_529_7 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_0) / var_529_7

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_0 + var_529_7 and arg_526_1.time_ < var_529_0 + var_529_7 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play103303131 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 103303131
		arg_530_1.duration_ = 6.3

		local var_530_0 = {
			ja = 6.2,
			ko = 5.066,
			zh = 5.2,
			en = 6.3
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
				arg_530_0:Play103303132(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0
			local var_533_1 = 0.55

			if var_533_0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_2 = arg_530_1:FormatText(StoryNameCfg[10].name)

				arg_530_1.leftNameTxt_.text = var_533_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, true)
				arg_530_1.iconController_:SetSelectedState("hero")

				arg_530_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_530_1.callingController_:SetSelectedState("normal")

				arg_530_1.keyicon_.color = Color.New(1, 1, 1)
				arg_530_1.icon_.color = Color.New(1, 1, 1)

				local var_533_3 = arg_530_1:GetWordFromCfg(103303131)
				local var_533_4 = arg_530_1:FormatText(var_533_3.content)

				arg_530_1.text_.text = var_533_4

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303131", "story_v_side_old_103303.awb") ~= 0 then
					local var_533_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303131", "story_v_side_old_103303.awb") / 1000

					if var_533_8 + var_533_0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_8 + var_533_0
					end

					if var_533_3.prefab_name ~= "" and arg_530_1.actors_[var_533_3.prefab_name] ~= nil then
						local var_533_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_3.prefab_name].transform, "story_v_side_old_103303", "103303131", "story_v_side_old_103303.awb")

						arg_530_1:RecordAudio("103303131", var_533_9)
						arg_530_1:RecordAudio("103303131", var_533_9)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303131", "story_v_side_old_103303.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303131", "story_v_side_old_103303.awb")
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
	Play103303132 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 103303132
		arg_534_1.duration_ = 8.2

		local var_534_0 = {
			ja = 8.2,
			ko = 5.766,
			zh = 4.566,
			en = 6.266
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play103303133(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["1033ui_story"].transform
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 then
				arg_534_1.var_.moveOldPos1033ui_story = var_537_0.localPosition
			end

			local var_537_2 = 0.001

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2
				local var_537_4 = Vector3.New(0, -1.01, -6.13)

				var_537_0.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1033ui_story, var_537_4, var_537_3)

				local var_537_5 = manager.ui.mainCamera.transform.position - var_537_0.position

				var_537_0.forward = Vector3.New(var_537_5.x, var_537_5.y, var_537_5.z)

				local var_537_6 = var_537_0.localEulerAngles

				var_537_6.z = 0
				var_537_6.x = 0
				var_537_0.localEulerAngles = var_537_6
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 then
				var_537_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_537_7 = manager.ui.mainCamera.transform.position - var_537_0.position

				var_537_0.forward = Vector3.New(var_537_7.x, var_537_7.y, var_537_7.z)

				local var_537_8 = var_537_0.localEulerAngles

				var_537_8.z = 0
				var_537_8.x = 0
				var_537_0.localEulerAngles = var_537_8
			end

			local var_537_9 = 0

			if var_537_9 < arg_534_1.time_ and arg_534_1.time_ <= var_537_9 + arg_537_0 then
				arg_534_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			local var_537_10 = 0

			if var_537_10 < arg_534_1.time_ and arg_534_1.time_ <= var_537_10 + arg_537_0 then
				arg_534_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_537_11 = 0
			local var_537_12 = 0.625

			if var_537_11 < arg_534_1.time_ and arg_534_1.time_ <= var_537_11 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_13 = arg_534_1:FormatText(StoryNameCfg[236].name)

				arg_534_1.leftNameTxt_.text = var_537_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_14 = arg_534_1:GetWordFromCfg(103303132)
				local var_537_15 = arg_534_1:FormatText(var_537_14.content)

				arg_534_1.text_.text = var_537_15

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_16 = 25
				local var_537_17 = utf8.len(var_537_15)
				local var_537_18 = var_537_16 <= 0 and var_537_12 or var_537_12 * (var_537_17 / var_537_16)

				if var_537_18 > 0 and var_537_12 < var_537_18 then
					arg_534_1.talkMaxDuration = var_537_18

					if var_537_18 + var_537_11 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_18 + var_537_11
					end
				end

				arg_534_1.text_.text = var_537_15
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303132", "story_v_side_old_103303.awb") ~= 0 then
					local var_537_19 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303132", "story_v_side_old_103303.awb") / 1000

					if var_537_19 + var_537_11 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_19 + var_537_11
					end

					if var_537_14.prefab_name ~= "" and arg_534_1.actors_[var_537_14.prefab_name] ~= nil then
						local var_537_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_14.prefab_name].transform, "story_v_side_old_103303", "103303132", "story_v_side_old_103303.awb")

						arg_534_1:RecordAudio("103303132", var_537_20)
						arg_534_1:RecordAudio("103303132", var_537_20)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303132", "story_v_side_old_103303.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303132", "story_v_side_old_103303.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_21 = math.max(var_537_12, arg_534_1.talkMaxDuration)

			if var_537_11 <= arg_534_1.time_ and arg_534_1.time_ < var_537_11 + var_537_21 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_11) / var_537_21

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_11 + var_537_21 and arg_534_1.time_ < var_537_11 + var_537_21 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_534_1:InitPlayNodeList()
	end,
	Play103303133 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 103303133
		arg_538_1.duration_ = 2.77

		local var_538_0 = {
			ja = 2.766,
			ko = 1.466,
			zh = 1.7,
			en = 1.733
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play103303134(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["1033ui_story"].transform
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 then
				arg_538_1.var_.moveOldPos1033ui_story = var_541_0.localPosition
			end

			local var_541_2 = 0.001

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2
				local var_541_4 = Vector3.New(0, 100, 0)

				var_541_0.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos1033ui_story, var_541_4, var_541_3)

				local var_541_5 = manager.ui.mainCamera.transform.position - var_541_0.position

				var_541_0.forward = Vector3.New(var_541_5.x, var_541_5.y, var_541_5.z)

				local var_541_6 = var_541_0.localEulerAngles

				var_541_6.z = 0
				var_541_6.x = 0
				var_541_0.localEulerAngles = var_541_6
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 then
				var_541_0.localPosition = Vector3.New(0, 100, 0)

				local var_541_7 = manager.ui.mainCamera.transform.position - var_541_0.position

				var_541_0.forward = Vector3.New(var_541_7.x, var_541_7.y, var_541_7.z)

				local var_541_8 = var_541_0.localEulerAngles

				var_541_8.z = 0
				var_541_8.x = 0
				var_541_0.localEulerAngles = var_541_8
			end

			local var_541_9 = 0
			local var_541_10 = 0.125

			if var_541_9 < arg_538_1.time_ and arg_538_1.time_ <= var_541_9 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_11 = arg_538_1:FormatText(StoryNameCfg[10].name)

				arg_538_1.leftNameTxt_.text = var_541_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, true)
				arg_538_1.iconController_:SetSelectedState("hero")

				arg_538_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_538_1.callingController_:SetSelectedState("normal")

				arg_538_1.keyicon_.color = Color.New(1, 1, 1)
				arg_538_1.icon_.color = Color.New(1, 1, 1)

				local var_541_12 = arg_538_1:GetWordFromCfg(103303133)
				local var_541_13 = arg_538_1:FormatText(var_541_12.content)

				arg_538_1.text_.text = var_541_13

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_14 = 5
				local var_541_15 = utf8.len(var_541_13)
				local var_541_16 = var_541_14 <= 0 and var_541_10 or var_541_10 * (var_541_15 / var_541_14)

				if var_541_16 > 0 and var_541_10 < var_541_16 then
					arg_538_1.talkMaxDuration = var_541_16

					if var_541_16 + var_541_9 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_16 + var_541_9
					end
				end

				arg_538_1.text_.text = var_541_13
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303133", "story_v_side_old_103303.awb") ~= 0 then
					local var_541_17 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303133", "story_v_side_old_103303.awb") / 1000

					if var_541_17 + var_541_9 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_17 + var_541_9
					end

					if var_541_12.prefab_name ~= "" and arg_538_1.actors_[var_541_12.prefab_name] ~= nil then
						local var_541_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_12.prefab_name].transform, "story_v_side_old_103303", "103303133", "story_v_side_old_103303.awb")

						arg_538_1:RecordAudio("103303133", var_541_18)
						arg_538_1:RecordAudio("103303133", var_541_18)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303133", "story_v_side_old_103303.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303133", "story_v_side_old_103303.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_19 = math.max(var_541_10, arg_538_1.talkMaxDuration)

			if var_541_9 <= arg_538_1.time_ and arg_538_1.time_ < var_541_9 + var_541_19 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_9) / var_541_19

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_9 + var_541_19 and arg_538_1.time_ < var_541_9 + var_541_19 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play103303134 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 103303134
		arg_542_1.duration_ = 15.83

		local var_542_0 = {
			ja = 15.5,
			ko = 14,
			zh = 9.3,
			en = 15.833
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play103303135(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0
			local var_545_1 = 1.2

			if var_545_0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_2 = arg_542_1:FormatText(StoryNameCfg[10].name)

				arg_542_1.leftNameTxt_.text = var_545_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, true)
				arg_542_1.iconController_:SetSelectedState("hero")

				arg_542_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_542_1.callingController_:SetSelectedState("normal")

				arg_542_1.keyicon_.color = Color.New(1, 1, 1)
				arg_542_1.icon_.color = Color.New(1, 1, 1)

				local var_545_3 = arg_542_1:GetWordFromCfg(103303134)
				local var_545_4 = arg_542_1:FormatText(var_545_3.content)

				arg_542_1.text_.text = var_545_4

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_5 = 48
				local var_545_6 = utf8.len(var_545_4)
				local var_545_7 = var_545_5 <= 0 and var_545_1 or var_545_1 * (var_545_6 / var_545_5)

				if var_545_7 > 0 and var_545_1 < var_545_7 then
					arg_542_1.talkMaxDuration = var_545_7

					if var_545_7 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_7 + var_545_0
					end
				end

				arg_542_1.text_.text = var_545_4
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303134", "story_v_side_old_103303.awb") ~= 0 then
					local var_545_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303134", "story_v_side_old_103303.awb") / 1000

					if var_545_8 + var_545_0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_8 + var_545_0
					end

					if var_545_3.prefab_name ~= "" and arg_542_1.actors_[var_545_3.prefab_name] ~= nil then
						local var_545_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_3.prefab_name].transform, "story_v_side_old_103303", "103303134", "story_v_side_old_103303.awb")

						arg_542_1:RecordAudio("103303134", var_545_9)
						arg_542_1:RecordAudio("103303134", var_545_9)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303134", "story_v_side_old_103303.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303134", "story_v_side_old_103303.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_10 = math.max(var_545_1, arg_542_1.talkMaxDuration)

			if var_545_0 <= arg_542_1.time_ and arg_542_1.time_ < var_545_0 + var_545_10 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_0) / var_545_10

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_0 + var_545_10 and arg_542_1.time_ < var_545_0 + var_545_10 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play103303135 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 103303135
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play103303136(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 0.65

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, false)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_2 = arg_546_1:GetWordFromCfg(103303135)
				local var_549_3 = arg_546_1:FormatText(var_549_2.content)

				arg_546_1.text_.text = var_549_3

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_4 = 26
				local var_549_5 = utf8.len(var_549_3)
				local var_549_6 = var_549_4 <= 0 and var_549_1 or var_549_1 * (var_549_5 / var_549_4)

				if var_549_6 > 0 and var_549_1 < var_549_6 then
					arg_546_1.talkMaxDuration = var_549_6

					if var_549_6 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_6 + var_549_0
					end
				end

				arg_546_1.text_.text = var_549_3
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_7 = math.max(var_549_1, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_7 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_0) / var_549_7

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_7 and arg_546_1.time_ < var_549_0 + var_549_7 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play103303136 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 103303136
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play103303137(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0
			local var_553_1 = 1.475

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

				local var_553_2 = arg_550_1:GetWordFromCfg(103303136)
				local var_553_3 = arg_550_1:FormatText(var_553_2.content)

				arg_550_1.text_.text = var_553_3

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_4 = 59
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
	Play103303137 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 103303137
		arg_554_1.duration_ = 5

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play103303138(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0
			local var_557_1 = 1

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				local var_557_2 = "play"
				local var_557_3 = "effect"

				arg_554_1:AudioAction(var_557_2, var_557_3, "se_story_side_1033", "se_story_1033_door", "")
			end

			local var_557_4 = 0
			local var_557_5 = 0.95

			if var_557_4 < arg_554_1.time_ and arg_554_1.time_ <= var_557_4 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, false)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_6 = arg_554_1:GetWordFromCfg(103303137)
				local var_557_7 = arg_554_1:FormatText(var_557_6.content)

				arg_554_1.text_.text = var_557_7

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_8 = 38
				local var_557_9 = utf8.len(var_557_7)
				local var_557_10 = var_557_8 <= 0 and var_557_5 or var_557_5 * (var_557_9 / var_557_8)

				if var_557_10 > 0 and var_557_5 < var_557_10 then
					arg_554_1.talkMaxDuration = var_557_10

					if var_557_10 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_10 + var_557_4
					end
				end

				arg_554_1.text_.text = var_557_7
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)
				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_11 = math.max(var_557_5, arg_554_1.talkMaxDuration)

			if var_557_4 <= arg_554_1.time_ and arg_554_1.time_ < var_557_4 + var_557_11 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_4) / var_557_11

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_4 + var_557_11 and arg_554_1.time_ < var_557_4 + var_557_11 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play103303138 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 103303138
		arg_558_1.duration_ = 11

		local var_558_0 = {
			ja = 11,
			ko = 7.966,
			zh = 8.433,
			en = 9.766
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play103303139(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0
			local var_561_1 = 0.675

			if var_561_0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_2 = arg_558_1:FormatText(StoryNameCfg[14].name)

				arg_558_1.leftNameTxt_.text = var_561_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_3 = arg_558_1:GetWordFromCfg(103303138)
				local var_561_4 = arg_558_1:FormatText(var_561_3.content)

				arg_558_1.text_.text = var_561_4

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_5 = 27
				local var_561_6 = utf8.len(var_561_4)
				local var_561_7 = var_561_5 <= 0 and var_561_1 or var_561_1 * (var_561_6 / var_561_5)

				if var_561_7 > 0 and var_561_1 < var_561_7 then
					arg_558_1.talkMaxDuration = var_561_7

					if var_561_7 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_7 + var_561_0
					end
				end

				arg_558_1.text_.text = var_561_4
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303138", "story_v_side_old_103303.awb") ~= 0 then
					local var_561_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303138", "story_v_side_old_103303.awb") / 1000

					if var_561_8 + var_561_0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_8 + var_561_0
					end

					if var_561_3.prefab_name ~= "" and arg_558_1.actors_[var_561_3.prefab_name] ~= nil then
						local var_561_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_3.prefab_name].transform, "story_v_side_old_103303", "103303138", "story_v_side_old_103303.awb")

						arg_558_1:RecordAudio("103303138", var_561_9)
						arg_558_1:RecordAudio("103303138", var_561_9)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303138", "story_v_side_old_103303.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303138", "story_v_side_old_103303.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_10 = math.max(var_561_1, arg_558_1.talkMaxDuration)

			if var_561_0 <= arg_558_1.time_ and arg_558_1.time_ < var_561_0 + var_561_10 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_0) / var_561_10

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_0 + var_561_10 and arg_558_1.time_ < var_561_0 + var_561_10 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play103303139 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 103303139
		arg_562_1.duration_ = 15.8

		local var_562_0 = {
			ja = 15.8,
			ko = 9.233,
			zh = 12.233,
			en = 12.7
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play103303140(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0
			local var_565_1 = 0.85

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_2 = arg_562_1:FormatText(StoryNameCfg[14].name)

				arg_562_1.leftNameTxt_.text = var_565_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, true)
				arg_562_1.iconController_:SetSelectedState("hero")

				arg_562_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_562_1.callingController_:SetSelectedState("normal")

				arg_562_1.keyicon_.color = Color.New(1, 1, 1)
				arg_562_1.icon_.color = Color.New(1, 1, 1)

				local var_565_3 = arg_562_1:GetWordFromCfg(103303139)
				local var_565_4 = arg_562_1:FormatText(var_565_3.content)

				arg_562_1.text_.text = var_565_4

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_5 = 34
				local var_565_6 = utf8.len(var_565_4)
				local var_565_7 = var_565_5 <= 0 and var_565_1 or var_565_1 * (var_565_6 / var_565_5)

				if var_565_7 > 0 and var_565_1 < var_565_7 then
					arg_562_1.talkMaxDuration = var_565_7

					if var_565_7 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_7 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_4
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303139", "story_v_side_old_103303.awb") ~= 0 then
					local var_565_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303139", "story_v_side_old_103303.awb") / 1000

					if var_565_8 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_8 + var_565_0
					end

					if var_565_3.prefab_name ~= "" and arg_562_1.actors_[var_565_3.prefab_name] ~= nil then
						local var_565_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_3.prefab_name].transform, "story_v_side_old_103303", "103303139", "story_v_side_old_103303.awb")

						arg_562_1:RecordAudio("103303139", var_565_9)
						arg_562_1:RecordAudio("103303139", var_565_9)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303139", "story_v_side_old_103303.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303139", "story_v_side_old_103303.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_10 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_10 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_10

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_10 and arg_562_1.time_ < var_565_0 + var_565_10 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play103303140 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 103303140
		arg_566_1.duration_ = 16.4

		local var_566_0 = {
			ja = 16.4,
			ko = 10.066,
			zh = 13.033,
			en = 14.1
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play103303141(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0
			local var_569_1 = 0.925

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_2 = arg_566_1:FormatText(StoryNameCfg[14].name)

				arg_566_1.leftNameTxt_.text = var_569_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, true)
				arg_566_1.iconController_:SetSelectedState("hero")

				arg_566_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_566_1.callingController_:SetSelectedState("normal")

				arg_566_1.keyicon_.color = Color.New(1, 1, 1)
				arg_566_1.icon_.color = Color.New(1, 1, 1)

				local var_569_3 = arg_566_1:GetWordFromCfg(103303140)
				local var_569_4 = arg_566_1:FormatText(var_569_3.content)

				arg_566_1.text_.text = var_569_4

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_5 = 37
				local var_569_6 = utf8.len(var_569_4)
				local var_569_7 = var_569_5 <= 0 and var_569_1 or var_569_1 * (var_569_6 / var_569_5)

				if var_569_7 > 0 and var_569_1 < var_569_7 then
					arg_566_1.talkMaxDuration = var_569_7

					if var_569_7 + var_569_0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_7 + var_569_0
					end
				end

				arg_566_1.text_.text = var_569_4
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303140", "story_v_side_old_103303.awb") ~= 0 then
					local var_569_8 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303140", "story_v_side_old_103303.awb") / 1000

					if var_569_8 + var_569_0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_8 + var_569_0
					end

					if var_569_3.prefab_name ~= "" and arg_566_1.actors_[var_569_3.prefab_name] ~= nil then
						local var_569_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_3.prefab_name].transform, "story_v_side_old_103303", "103303140", "story_v_side_old_103303.awb")

						arg_566_1:RecordAudio("103303140", var_569_9)
						arg_566_1:RecordAudio("103303140", var_569_9)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303140", "story_v_side_old_103303.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303140", "story_v_side_old_103303.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_10 = math.max(var_569_1, arg_566_1.talkMaxDuration)

			if var_569_0 <= arg_566_1.time_ and arg_566_1.time_ < var_569_0 + var_569_10 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_0) / var_569_10

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_0 + var_569_10 and arg_566_1.time_ < var_569_0 + var_569_10 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play103303141 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 103303141
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play103303142(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = 0
			local var_573_1 = 0.875

			if var_573_0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_0 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, false)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_2 = arg_570_1:GetWordFromCfg(103303141)
				local var_573_3 = arg_570_1:FormatText(var_573_2.content)

				arg_570_1.text_.text = var_573_3

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_4 = 35
				local var_573_5 = utf8.len(var_573_3)
				local var_573_6 = var_573_4 <= 0 and var_573_1 or var_573_1 * (var_573_5 / var_573_4)

				if var_573_6 > 0 and var_573_1 < var_573_6 then
					arg_570_1.talkMaxDuration = var_573_6

					if var_573_6 + var_573_0 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_6 + var_573_0
					end
				end

				arg_570_1.text_.text = var_573_3
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_7 = math.max(var_573_1, arg_570_1.talkMaxDuration)

			if var_573_0 <= arg_570_1.time_ and arg_570_1.time_ < var_573_0 + var_573_7 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_0) / var_573_7

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_0 + var_573_7 and arg_570_1.time_ < var_573_0 + var_573_7 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play103303142 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 103303142
		arg_574_1.duration_ = 6.17

		local var_574_0 = {
			ja = 5.966,
			ko = 4.3,
			zh = 5,
			en = 6.166
		}
		local var_574_1 = manager.audio:GetLocalizationFlag()

		if var_574_0[var_574_1] ~= nil then
			arg_574_1.duration_ = var_574_0[var_574_1]
		end

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play103303143(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = arg_574_1.actors_["1033ui_story"].transform
			local var_577_1 = 0

			if var_577_1 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 then
				arg_574_1.var_.moveOldPos1033ui_story = var_577_0.localPosition
			end

			local var_577_2 = 0.001

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_2 then
				local var_577_3 = (arg_574_1.time_ - var_577_1) / var_577_2
				local var_577_4 = Vector3.New(0, -1.01, -6.13)

				var_577_0.localPosition = Vector3.Lerp(arg_574_1.var_.moveOldPos1033ui_story, var_577_4, var_577_3)

				local var_577_5 = manager.ui.mainCamera.transform.position - var_577_0.position

				var_577_0.forward = Vector3.New(var_577_5.x, var_577_5.y, var_577_5.z)

				local var_577_6 = var_577_0.localEulerAngles

				var_577_6.z = 0
				var_577_6.x = 0
				var_577_0.localEulerAngles = var_577_6
			end

			if arg_574_1.time_ >= var_577_1 + var_577_2 and arg_574_1.time_ < var_577_1 + var_577_2 + arg_577_0 then
				var_577_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_577_7 = manager.ui.mainCamera.transform.position - var_577_0.position

				var_577_0.forward = Vector3.New(var_577_7.x, var_577_7.y, var_577_7.z)

				local var_577_8 = var_577_0.localEulerAngles

				var_577_8.z = 0
				var_577_8.x = 0
				var_577_0.localEulerAngles = var_577_8
			end

			local var_577_9 = arg_574_1.actors_["1033ui_story"]
			local var_577_10 = 0

			if var_577_10 < arg_574_1.time_ and arg_574_1.time_ <= var_577_10 + arg_577_0 and not isNil(var_577_9) and arg_574_1.var_.characterEffect1033ui_story == nil then
				arg_574_1.var_.characterEffect1033ui_story = var_577_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_11 = 0.2

			if var_577_10 <= arg_574_1.time_ and arg_574_1.time_ < var_577_10 + var_577_11 and not isNil(var_577_9) then
				local var_577_12 = (arg_574_1.time_ - var_577_10) / var_577_11

				if arg_574_1.var_.characterEffect1033ui_story and not isNil(var_577_9) then
					arg_574_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_574_1.time_ >= var_577_10 + var_577_11 and arg_574_1.time_ < var_577_10 + var_577_11 + arg_577_0 and not isNil(var_577_9) and arg_574_1.var_.characterEffect1033ui_story then
				arg_574_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_577_13 = 0

			if var_577_13 < arg_574_1.time_ and arg_574_1.time_ <= var_577_13 + arg_577_0 then
				arg_574_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			local var_577_14 = 0

			if var_577_14 < arg_574_1.time_ and arg_574_1.time_ <= var_577_14 + arg_577_0 then
				arg_574_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_577_15 = 0
			local var_577_16 = 0.375

			if var_577_15 < arg_574_1.time_ and arg_574_1.time_ <= var_577_15 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				local var_577_17 = arg_574_1:FormatText(StoryNameCfg[236].name)

				arg_574_1.leftNameTxt_.text = var_577_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_18 = arg_574_1:GetWordFromCfg(103303142)
				local var_577_19 = arg_574_1:FormatText(var_577_18.content)

				arg_574_1.text_.text = var_577_19

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_20 = 15
				local var_577_21 = utf8.len(var_577_19)
				local var_577_22 = var_577_20 <= 0 and var_577_16 or var_577_16 * (var_577_21 / var_577_20)

				if var_577_22 > 0 and var_577_16 < var_577_22 then
					arg_574_1.talkMaxDuration = var_577_22

					if var_577_22 + var_577_15 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_22 + var_577_15
					end
				end

				arg_574_1.text_.text = var_577_19
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103303", "103303142", "story_v_side_old_103303.awb") ~= 0 then
					local var_577_23 = manager.audio:GetVoiceLength("story_v_side_old_103303", "103303142", "story_v_side_old_103303.awb") / 1000

					if var_577_23 + var_577_15 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_23 + var_577_15
					end

					if var_577_18.prefab_name ~= "" and arg_574_1.actors_[var_577_18.prefab_name] ~= nil then
						local var_577_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_18.prefab_name].transform, "story_v_side_old_103303", "103303142", "story_v_side_old_103303.awb")

						arg_574_1:RecordAudio("103303142", var_577_24)
						arg_574_1:RecordAudio("103303142", var_577_24)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_side_old_103303", "103303142", "story_v_side_old_103303.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_side_old_103303", "103303142", "story_v_side_old_103303.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_25 = math.max(var_577_16, arg_574_1.talkMaxDuration)

			if var_577_15 <= arg_574_1.time_ and arg_574_1.time_ < var_577_15 + var_577_25 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_15) / var_577_25

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_15 + var_577_25 and arg_574_1.time_ < var_577_15 + var_577_25 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_574_1:InitPlayNodeList()
	end,
	Play103303143 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 103303143
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play103303144(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.actors_["1033ui_story"]
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect1033ui_story == nil then
				arg_578_1.var_.characterEffect1033ui_story = var_581_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_2 = 0.2

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 and not isNil(var_581_0) then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2

				if arg_578_1.var_.characterEffect1033ui_story and not isNil(var_581_0) then
					local var_581_4 = Mathf.Lerp(0, 0.5, var_581_3)

					arg_578_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_578_1.var_.characterEffect1033ui_story.fillRatio = var_581_4
				end
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect1033ui_story then
				local var_581_5 = 0.5

				arg_578_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_578_1.var_.characterEffect1033ui_story.fillRatio = var_581_5
			end

			local var_581_6 = 0

			if var_581_6 < arg_578_1.time_ and arg_578_1.time_ <= var_581_6 + arg_581_0 then
				arg_578_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_581_7 = 0
			local var_581_8 = 0.35

			if var_581_7 < arg_578_1.time_ and arg_578_1.time_ <= var_581_7 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, false)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_9 = arg_578_1:GetWordFromCfg(103303143)
				local var_581_10 = arg_578_1:FormatText(var_581_9.content)

				arg_578_1.text_.text = var_581_10

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_11 = 14
				local var_581_12 = utf8.len(var_581_10)
				local var_581_13 = var_581_11 <= 0 and var_581_8 or var_581_8 * (var_581_12 / var_581_11)

				if var_581_13 > 0 and var_581_8 < var_581_13 then
					arg_578_1.talkMaxDuration = var_581_13

					if var_581_13 + var_581_7 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_13 + var_581_7
					end
				end

				arg_578_1.text_.text = var_581_10
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_14 = math.max(var_581_8, arg_578_1.talkMaxDuration)

			if var_581_7 <= arg_578_1.time_ and arg_578_1.time_ < var_581_7 + var_581_14 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_7) / var_581_14

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_7 + var_581_14 and arg_578_1.time_ < var_581_7 + var_581_14 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play103303144 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 103303144
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play103303145(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = arg_582_1.actors_["1033ui_story"].transform
			local var_585_1 = 0

			if var_585_1 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 then
				arg_582_1.var_.moveOldPos1033ui_story = var_585_0.localPosition
			end

			local var_585_2 = 0.001

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_2 then
				local var_585_3 = (arg_582_1.time_ - var_585_1) / var_585_2
				local var_585_4 = Vector3.New(0, 100, 0)

				var_585_0.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos1033ui_story, var_585_4, var_585_3)

				local var_585_5 = manager.ui.mainCamera.transform.position - var_585_0.position

				var_585_0.forward = Vector3.New(var_585_5.x, var_585_5.y, var_585_5.z)

				local var_585_6 = var_585_0.localEulerAngles

				var_585_6.z = 0
				var_585_6.x = 0
				var_585_0.localEulerAngles = var_585_6
			end

			if arg_582_1.time_ >= var_585_1 + var_585_2 and arg_582_1.time_ < var_585_1 + var_585_2 + arg_585_0 then
				var_585_0.localPosition = Vector3.New(0, 100, 0)

				local var_585_7 = manager.ui.mainCamera.transform.position - var_585_0.position

				var_585_0.forward = Vector3.New(var_585_7.x, var_585_7.y, var_585_7.z)

				local var_585_8 = var_585_0.localEulerAngles

				var_585_8.z = 0
				var_585_8.x = 0
				var_585_0.localEulerAngles = var_585_8
			end

			local var_585_9 = 0
			local var_585_10 = 0.825

			if var_585_9 < arg_582_1.time_ and arg_582_1.time_ <= var_585_9 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, false)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_11 = arg_582_1:GetWordFromCfg(103303144)
				local var_585_12 = arg_582_1:FormatText(var_585_11.content)

				arg_582_1.text_.text = var_585_12

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_13 = 33
				local var_585_14 = utf8.len(var_585_12)
				local var_585_15 = var_585_13 <= 0 and var_585_10 or var_585_10 * (var_585_14 / var_585_13)

				if var_585_15 > 0 and var_585_10 < var_585_15 then
					arg_582_1.talkMaxDuration = var_585_15

					if var_585_15 + var_585_9 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_15 + var_585_9
					end
				end

				arg_582_1.text_.text = var_585_12
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_16 = math.max(var_585_10, arg_582_1.talkMaxDuration)

			if var_585_9 <= arg_582_1.time_ and arg_582_1.time_ < var_585_9 + var_585_16 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_9) / var_585_16

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_9 + var_585_16 and arg_582_1.time_ < var_585_9 + var_585_16 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_582_1:InitPlayNodeList()
	end,
	Play103303145 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 103303145
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
			arg_586_1.auto_ = false
		end

		function arg_586_1.playNext_(arg_588_0)
			arg_586_1.onStoryFinished_()
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = 0
			local var_589_1 = 0.15

			if var_589_0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_0 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, false)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_2 = arg_586_1:GetWordFromCfg(103303145)
				local var_589_3 = arg_586_1:FormatText(var_589_2.content)

				arg_586_1.text_.text = var_589_3

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_4 = 6
				local var_589_5 = utf8.len(var_589_3)
				local var_589_6 = var_589_4 <= 0 and var_589_1 or var_589_1 * (var_589_5 / var_589_4)

				if var_589_6 > 0 and var_589_1 < var_589_6 then
					arg_586_1.talkMaxDuration = var_589_6

					if var_589_6 + var_589_0 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_6 + var_589_0
					end
				end

				arg_586_1.text_.text = var_589_3
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_7 = math.max(var_589_1, arg_586_1.talkMaxDuration)

			if var_589_0 <= arg_586_1.time_ and arg_586_1.time_ < var_589_0 + var_589_7 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_0) / var_589_7

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_0 + var_589_7 and arg_586_1.time_ < var_589_0 + var_589_7 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST18",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/B13"
	},
	voices = {
		"story_v_side_old_103303.awb"
	}
}
