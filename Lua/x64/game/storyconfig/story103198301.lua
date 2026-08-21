return {
	Play319831001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319831001
		arg_1_1.duration_ = 3.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319831002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST74"

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
				local var_4_5 = arg_1_1.bgs_.ST74

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
					if iter_4_0 ~= "ST74" then
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

			local var_4_24 = "1084ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_30 = 1.9

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_29.localPosition

				local var_4_31 = "1084ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_31 .. "Animator"].transform, false)
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -0.97, -6)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.97, -6)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38
			end

			local var_4_39 = arg_1_1.actors_["1084ui_story"]
			local var_4_40 = 1.9

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_41 = 0.200000002980232

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 and not isNil(var_4_39) then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_39) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_43 = 1.9

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_4_44 = 1.9

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_45 = 0
			local var_4_46 = 0.2

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_51 = 1.999999999999
			local var_4_52 = 0.175

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_53 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_53:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_54 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_55 = arg_1_1:GetWordFromCfg(319831001)
				local var_4_56 = arg_1_1:FormatText(var_4_55.content)

				arg_1_1.text_.text = var_4_56

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_57 = 7
				local var_4_58 = utf8.len(var_4_56)
				local var_4_59 = var_4_57 <= 0 and var_4_52 or var_4_52 * (var_4_58 / var_4_57)

				if var_4_59 > 0 and var_4_52 < var_4_59 then
					arg_1_1.talkMaxDuration = var_4_59
					var_4_51 = var_4_51 + 0.3

					if var_4_59 + var_4_51 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_59 + var_4_51
					end
				end

				arg_1_1.text_.text = var_4_56
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831001", "story_v_out_319831.awb") ~= 0 then
					local var_4_60 = manager.audio:GetVoiceLength("story_v_out_319831", "319831001", "story_v_out_319831.awb") / 1000

					if var_4_60 + var_4_51 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_51
					end

					if var_4_55.prefab_name ~= "" and arg_1_1.actors_[var_4_55.prefab_name] ~= nil then
						local var_4_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_55.prefab_name].transform, "story_v_out_319831", "319831001", "story_v_out_319831.awb")

						arg_1_1:RecordAudio("319831001", var_4_61)
						arg_1_1:RecordAudio("319831001", var_4_61)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319831", "319831001", "story_v_out_319831.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319831", "319831001", "story_v_out_319831.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_62 = var_4_51 + 0.3
			local var_4_63 = math.max(var_4_52, arg_1_1.talkMaxDuration)

			if var_4_62 <= arg_1_1.time_ and arg_1_1.time_ < var_4_62 + var_4_63 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_62) / var_4_63

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_62 + var_4_63 and arg_1_1.time_ < var_4_62 + var_4_63 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319831002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 319831002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play319831003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1084ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.200000002980232

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1084ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 1

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_8 = arg_8_1:GetWordFromCfg(319831002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_10 = 40
				local var_11_11 = utf8.len(var_11_9)
				local var_11_12 = var_11_10 <= 0 and var_11_7 or var_11_7 * (var_11_11 / var_11_10)

				if var_11_12 > 0 and var_11_7 < var_11_12 then
					arg_8_1.talkMaxDuration = var_11_12

					if var_11_12 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_9
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_13 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_13 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_13

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_13 and arg_8_1.time_ < var_11_6 + var_11_13 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play319831003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 319831003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play319831004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.125

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(319831003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 45
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play319831004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 319831004
		arg_16_1.duration_ = 3.5

		local var_16_0 = {
			zh = 3.5,
			ja = 3.366
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
				arg_16_0:Play319831005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_0.localPosition
			end

			local var_19_2 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2
				local var_19_4 = Vector3.New(0, -0.97, -6)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_4, var_19_3)

				local var_19_5 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_5.x, var_19_5.y, var_19_5.z)

				local var_19_6 = var_19_0.localEulerAngles

				var_19_6.z = 0
				var_19_6.x = 0
				var_19_0.localEulerAngles = var_19_6
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_19_7 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_7.x, var_19_7.y, var_19_7.z)

				local var_19_8 = var_19_0.localEulerAngles

				var_19_8.z = 0
				var_19_8.x = 0
				var_19_0.localEulerAngles = var_19_8
			end

			local var_19_9 = arg_16_1.actors_["1084ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.200000002980232

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_9) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_13 = 0

			if var_19_13 < arg_16_1.time_ and arg_16_1.time_ <= var_19_13 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_19_14 = 0

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_19_15 = 0
			local var_19_16 = 0.4

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_17 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:GetWordFromCfg(319831004)
				local var_19_19 = arg_16_1:FormatText(var_19_18.content)

				arg_16_1.text_.text = var_19_19

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_20 = 16
				local var_19_21 = utf8.len(var_19_19)
				local var_19_22 = var_19_20 <= 0 and var_19_16 or var_19_16 * (var_19_21 / var_19_20)

				if var_19_22 > 0 and var_19_16 < var_19_22 then
					arg_16_1.talkMaxDuration = var_19_22

					if var_19_22 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_19
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831004", "story_v_out_319831.awb") ~= 0 then
					local var_19_23 = manager.audio:GetVoiceLength("story_v_out_319831", "319831004", "story_v_out_319831.awb") / 1000

					if var_19_23 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_23 + var_19_15
					end

					if var_19_18.prefab_name ~= "" and arg_16_1.actors_[var_19_18.prefab_name] ~= nil then
						local var_19_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_18.prefab_name].transform, "story_v_out_319831", "319831004", "story_v_out_319831.awb")

						arg_16_1:RecordAudio("319831004", var_19_24)
						arg_16_1:RecordAudio("319831004", var_19_24)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_319831", "319831004", "story_v_out_319831.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_319831", "319831004", "story_v_out_319831.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_25 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_25 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_15) / var_19_25

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_15 + var_19_25 and arg_16_1.time_ < var_19_15 + var_19_25 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play319831005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 319831005
		arg_20_1.duration_ = 3.8

		local var_20_0 = {
			zh = 3.4,
			ja = 3.8
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
				arg_20_0:Play319831006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.4

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[6].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(319831005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 16
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831005", "story_v_out_319831.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_319831", "319831005", "story_v_out_319831.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_319831", "319831005", "story_v_out_319831.awb")

						arg_20_1:RecordAudio("319831005", var_23_9)
						arg_20_1:RecordAudio("319831005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_319831", "319831005", "story_v_out_319831.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_319831", "319831005", "story_v_out_319831.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play319831006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 319831006
		arg_24_1.duration_ = 7.6

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play319831007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "D02a"

			if arg_24_1.bgs_[var_27_0] == nil then
				local var_27_1 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_27_0)
				var_27_1.name = var_27_0
				var_27_1.transform.parent = arg_24_1.stage_.transform
				var_27_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_[var_27_0] = var_27_1
			end

			local var_27_2 = 1.23333333333333

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				local var_27_3 = manager.ui.mainCamera.transform.localPosition
				local var_27_4 = Vector3.New(0, 0, 10) + Vector3.New(var_27_3.x, var_27_3.y, 0)
				local var_27_5 = arg_24_1.bgs_.D02a

				var_27_5.transform.localPosition = var_27_4
				var_27_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_6 = var_27_5:GetComponent("SpriteRenderer")

				if var_27_6 and var_27_6.sprite then
					local var_27_7 = (var_27_5.transform.localPosition - var_27_3).z
					local var_27_8 = manager.ui.mainCameraCom_
					local var_27_9 = 2 * var_27_7 * Mathf.Tan(var_27_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_27_10 = var_27_9 * var_27_8.aspect
					local var_27_11 = var_27_6.sprite.bounds.size.x
					local var_27_12 = var_27_6.sprite.bounds.size.y
					local var_27_13 = var_27_10 / var_27_11
					local var_27_14 = var_27_9 / var_27_12
					local var_27_15 = var_27_14 < var_27_13 and var_27_13 or var_27_14

					var_27_5.transform.localScale = Vector3.New(var_27_15, var_27_15, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "D02a" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			local var_27_17 = 0.3

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_18 = 0

			if var_27_18 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_19 = 1.23333333333333

			if var_27_18 <= arg_24_1.time_ and arg_24_1.time_ < var_27_18 + var_27_19 then
				local var_27_20 = (arg_24_1.time_ - var_27_18) / var_27_19
				local var_27_21 = Color.New(0, 0, 0)

				var_27_21.a = Mathf.Lerp(0, 1, var_27_20)
				arg_24_1.mask_.color = var_27_21
			end

			if arg_24_1.time_ >= var_27_18 + var_27_19 and arg_24_1.time_ < var_27_18 + var_27_19 + arg_27_0 then
				local var_27_22 = Color.New(0, 0, 0)

				var_27_22.a = 1
				arg_24_1.mask_.color = var_27_22
			end

			local var_27_23 = 1.23333333333333

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_24 = 2

			if var_27_23 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_24 then
				local var_27_25 = (arg_24_1.time_ - var_27_23) / var_27_24
				local var_27_26 = Color.New(0, 0, 0)

				var_27_26.a = Mathf.Lerp(1, 0, var_27_25)
				arg_24_1.mask_.color = var_27_26
			end

			if arg_24_1.time_ >= var_27_23 + var_27_24 and arg_24_1.time_ < var_27_23 + var_27_24 + arg_27_0 then
				local var_27_27 = Color.New(0, 0, 0)
				local var_27_28 = 0

				arg_24_1.mask_.enabled = false
				var_27_27.a = var_27_28
				arg_24_1.mask_.color = var_27_27
			end

			local var_27_29 = arg_24_1.actors_["1084ui_story"].transform
			local var_27_30 = 1.23333333333333

			if var_27_30 < arg_24_1.time_ and arg_24_1.time_ <= var_27_30 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_29.localPosition
			end

			local var_27_31 = 0.001

			if var_27_30 <= arg_24_1.time_ and arg_24_1.time_ < var_27_30 + var_27_31 then
				local var_27_32 = (arg_24_1.time_ - var_27_30) / var_27_31
				local var_27_33 = Vector3.New(0, 100, 0)

				var_27_29.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, var_27_33, var_27_32)

				local var_27_34 = manager.ui.mainCamera.transform.position - var_27_29.position

				var_27_29.forward = Vector3.New(var_27_34.x, var_27_34.y, var_27_34.z)

				local var_27_35 = var_27_29.localEulerAngles

				var_27_35.z = 0
				var_27_35.x = 0
				var_27_29.localEulerAngles = var_27_35
			end

			if arg_24_1.time_ >= var_27_30 + var_27_31 and arg_24_1.time_ < var_27_30 + var_27_31 + arg_27_0 then
				var_27_29.localPosition = Vector3.New(0, 100, 0)

				local var_27_36 = manager.ui.mainCamera.transform.position - var_27_29.position

				var_27_29.forward = Vector3.New(var_27_36.x, var_27_36.y, var_27_36.z)

				local var_27_37 = var_27_29.localEulerAngles

				var_27_37.z = 0
				var_27_37.x = 0
				var_27_29.localEulerAngles = var_27_37
			end

			local var_27_38 = 0
			local var_27_39 = 0.2

			if var_27_38 < arg_24_1.time_ and arg_24_1.time_ <= var_27_38 + arg_27_0 then
				local var_27_40 = "play"
				local var_27_41 = "music"

				arg_24_1:AudioAction(var_27_40, var_27_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_27_42 = ""
				local var_27_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_27_43 ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_43 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_43

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_43
						arg_24_1.bgmTxt2_.text = var_27_43
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_27_44 = 0.233333333333333
			local var_27_45 = 1

			if var_27_44 < arg_24_1.time_ and arg_24_1.time_ <= var_27_44 + arg_27_0 then
				local var_27_46 = "play"
				local var_27_47 = "music"

				arg_24_1:AudioAction(var_27_46, var_27_47, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_27_48 = ""
				local var_27_49 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_27_49 ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_49 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_49

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_49
						arg_24_1.bgmTxt2_.text = var_27_49
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_50 = 2.6
			local var_27_51 = 0.85

			if var_27_50 < arg_24_1.time_ and arg_24_1.time_ <= var_27_50 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_52 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_52:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_24_1.dialogCg_.alpha = arg_30_0
				end))
				var_27_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_53 = arg_24_1:GetWordFromCfg(319831006)
				local var_27_54 = arg_24_1:FormatText(var_27_53.content)

				arg_24_1.text_.text = var_27_54

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_55 = 34
				local var_27_56 = utf8.len(var_27_54)
				local var_27_57 = var_27_55 <= 0 and var_27_51 or var_27_51 * (var_27_56 / var_27_55)

				if var_27_57 > 0 and var_27_51 < var_27_57 then
					arg_24_1.talkMaxDuration = var_27_57
					var_27_50 = var_27_50 + 0.3

					if var_27_57 + var_27_50 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_57 + var_27_50
					end
				end

				arg_24_1.text_.text = var_27_54
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_58 = var_27_50 + 0.3
			local var_27_59 = math.max(var_27_51, arg_24_1.talkMaxDuration)

			if var_27_58 <= arg_24_1.time_ and arg_24_1.time_ < var_27_58 + var_27_59 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_58) / var_27_59

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_58 + var_27_59 and arg_24_1.time_ < var_27_58 + var_27_59 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play319831007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 319831007
		arg_32_1.duration_ = 6.1

		local var_32_0 = {
			zh = 4.733,
			ja = 6.1
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
				arg_32_0:Play319831008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "4040ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["4040ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos4040ui_story = var_35_5.localPosition
			end

			local var_35_7 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7
				local var_35_9 = Vector3.New(-0.7, -1.55, -5.5)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4040ui_story, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_5.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_5.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_5.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_5.localEulerAngles = var_35_13
			end

			local var_35_14 = arg_32_1.actors_["4040ui_story"]
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect4040ui_story == nil then
				arg_32_1.var_.characterEffect4040ui_story = var_35_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_16 = 0.200000002980232

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_16 and not isNil(var_35_14) then
				local var_35_17 = (arg_32_1.time_ - var_35_15) / var_35_16

				if arg_32_1.var_.characterEffect4040ui_story and not isNil(var_35_14) then
					arg_32_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_15 + var_35_16 and arg_32_1.time_ < var_35_15 + var_35_16 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect4040ui_story then
				arg_32_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_35_18 = 0

			if var_35_18 < arg_32_1.time_ and arg_32_1.time_ <= var_35_18 + arg_35_0 then
				arg_32_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_35_19 = 0

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_20 = 0
			local var_35_21 = 0.575

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_22 = arg_32_1:FormatText(StoryNameCfg[668].name)

				arg_32_1.leftNameTxt_.text = var_35_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_23 = arg_32_1:GetWordFromCfg(319831007)
				local var_35_24 = arg_32_1:FormatText(var_35_23.content)

				arg_32_1.text_.text = var_35_24

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_25 = 23
				local var_35_26 = utf8.len(var_35_24)
				local var_35_27 = var_35_25 <= 0 and var_35_21 or var_35_21 * (var_35_26 / var_35_25)

				if var_35_27 > 0 and var_35_21 < var_35_27 then
					arg_32_1.talkMaxDuration = var_35_27

					if var_35_27 + var_35_20 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_27 + var_35_20
					end
				end

				arg_32_1.text_.text = var_35_24
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831007", "story_v_out_319831.awb") ~= 0 then
					local var_35_28 = manager.audio:GetVoiceLength("story_v_out_319831", "319831007", "story_v_out_319831.awb") / 1000

					if var_35_28 + var_35_20 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_28 + var_35_20
					end

					if var_35_23.prefab_name ~= "" and arg_32_1.actors_[var_35_23.prefab_name] ~= nil then
						local var_35_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_23.prefab_name].transform, "story_v_out_319831", "319831007", "story_v_out_319831.awb")

						arg_32_1:RecordAudio("319831007", var_35_29)
						arg_32_1:RecordAudio("319831007", var_35_29)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_319831", "319831007", "story_v_out_319831.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_319831", "319831007", "story_v_out_319831.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_30 = math.max(var_35_21, arg_32_1.talkMaxDuration)

			if var_35_20 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_30 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_20) / var_35_30

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_20 + var_35_30 and arg_32_1.time_ < var_35_20 + var_35_30 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play319831008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 319831008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play319831009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["4040ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect4040ui_story == nil then
				arg_36_1.var_.characterEffect4040ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect4040ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_36_1.var_.characterEffect4040ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect4040ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_36_1.var_.characterEffect4040ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.975

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(319831008)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_10 = 39
				local var_39_11 = utf8.len(var_39_9)
				local var_39_12 = var_39_10 <= 0 and var_39_7 or var_39_7 * (var_39_11 / var_39_10)

				if var_39_12 > 0 and var_39_7 < var_39_12 then
					arg_36_1.talkMaxDuration = var_39_12

					if var_39_12 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_13 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_13 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_13

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_13 and arg_36_1.time_ < var_39_6 + var_39_13 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play319831009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 319831009
		arg_40_1.duration_ = 3.03

		local var_40_0 = {
			zh = 3.033,
			ja = 2.866
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
				arg_40_0:Play319831010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["4040ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4040ui_story == nil then
				arg_40_1.var_.characterEffect4040ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect4040ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect4040ui_story then
				arg_40_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_43_4 = 0
			local var_43_5 = 0.35

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_6 = arg_40_1:FormatText(StoryNameCfg[668].name)

				arg_40_1.leftNameTxt_.text = var_43_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:GetWordFromCfg(319831009)
				local var_43_8 = arg_40_1:FormatText(var_43_7.content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 14
				local var_43_10 = utf8.len(var_43_8)
				local var_43_11 = var_43_9 <= 0 and var_43_5 or var_43_5 * (var_43_10 / var_43_9)

				if var_43_11 > 0 and var_43_5 < var_43_11 then
					arg_40_1.talkMaxDuration = var_43_11

					if var_43_11 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831009", "story_v_out_319831.awb") ~= 0 then
					local var_43_12 = manager.audio:GetVoiceLength("story_v_out_319831", "319831009", "story_v_out_319831.awb") / 1000

					if var_43_12 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_4
					end

					if var_43_7.prefab_name ~= "" and arg_40_1.actors_[var_43_7.prefab_name] ~= nil then
						local var_43_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_7.prefab_name].transform, "story_v_out_319831", "319831009", "story_v_out_319831.awb")

						arg_40_1:RecordAudio("319831009", var_43_13)
						arg_40_1:RecordAudio("319831009", var_43_13)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_319831", "319831009", "story_v_out_319831.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_319831", "319831009", "story_v_out_319831.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_14 and arg_40_1.time_ < var_43_4 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play319831010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319831010
		arg_44_1.duration_ = 4.4

		local var_44_0 = {
			zh = 2.466,
			ja = 4.4
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
				arg_44_0:Play319831011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0.7, -0.97, -6)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["1084ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_47_13 = 0

			if var_47_13 < arg_44_1.time_ and arg_44_1.time_ <= var_47_13 + arg_47_0 then
				arg_44_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_47_14 = arg_44_1.actors_["4040ui_story"].transform
			local var_47_15 = 0

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.var_.moveOldPos4040ui_story = var_47_14.localPosition
			end

			local var_47_16 = 0.001

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_16 then
				local var_47_17 = (arg_44_1.time_ - var_47_15) / var_47_16
				local var_47_18 = Vector3.New(-0.7, -1.55, -5.5)

				var_47_14.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos4040ui_story, var_47_18, var_47_17)

				local var_47_19 = manager.ui.mainCamera.transform.position - var_47_14.position

				var_47_14.forward = Vector3.New(var_47_19.x, var_47_19.y, var_47_19.z)

				local var_47_20 = var_47_14.localEulerAngles

				var_47_20.z = 0
				var_47_20.x = 0
				var_47_14.localEulerAngles = var_47_20
			end

			if arg_44_1.time_ >= var_47_15 + var_47_16 and arg_44_1.time_ < var_47_15 + var_47_16 + arg_47_0 then
				var_47_14.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_47_21 = manager.ui.mainCamera.transform.position - var_47_14.position

				var_47_14.forward = Vector3.New(var_47_21.x, var_47_21.y, var_47_21.z)

				local var_47_22 = var_47_14.localEulerAngles

				var_47_22.z = 0
				var_47_22.x = 0
				var_47_14.localEulerAngles = var_47_22
			end

			local var_47_23 = arg_44_1.actors_["4040ui_story"]
			local var_47_24 = 0

			if var_47_24 < arg_44_1.time_ and arg_44_1.time_ <= var_47_24 + arg_47_0 and not isNil(var_47_23) and arg_44_1.var_.characterEffect4040ui_story == nil then
				arg_44_1.var_.characterEffect4040ui_story = var_47_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_25 = 0.200000002980232

			if var_47_24 <= arg_44_1.time_ and arg_44_1.time_ < var_47_24 + var_47_25 and not isNil(var_47_23) then
				local var_47_26 = (arg_44_1.time_ - var_47_24) / var_47_25

				if arg_44_1.var_.characterEffect4040ui_story and not isNil(var_47_23) then
					local var_47_27 = Mathf.Lerp(0, 0.5, var_47_26)

					arg_44_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_44_1.var_.characterEffect4040ui_story.fillRatio = var_47_27
				end
			end

			if arg_44_1.time_ >= var_47_24 + var_47_25 and arg_44_1.time_ < var_47_24 + var_47_25 + arg_47_0 and not isNil(var_47_23) and arg_44_1.var_.characterEffect4040ui_story then
				local var_47_28 = 0.5

				arg_44_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_44_1.var_.characterEffect4040ui_story.fillRatio = var_47_28
			end

			local var_47_29 = 0
			local var_47_30 = 0.325

			if var_47_29 < arg_44_1.time_ and arg_44_1.time_ <= var_47_29 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_31 = arg_44_1:FormatText(StoryNameCfg[6].name)

				arg_44_1.leftNameTxt_.text = var_47_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_32 = arg_44_1:GetWordFromCfg(319831010)
				local var_47_33 = arg_44_1:FormatText(var_47_32.content)

				arg_44_1.text_.text = var_47_33

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_34 = 13
				local var_47_35 = utf8.len(var_47_33)
				local var_47_36 = var_47_34 <= 0 and var_47_30 or var_47_30 * (var_47_35 / var_47_34)

				if var_47_36 > 0 and var_47_30 < var_47_36 then
					arg_44_1.talkMaxDuration = var_47_36

					if var_47_36 + var_47_29 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_36 + var_47_29
					end
				end

				arg_44_1.text_.text = var_47_33
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831010", "story_v_out_319831.awb") ~= 0 then
					local var_47_37 = manager.audio:GetVoiceLength("story_v_out_319831", "319831010", "story_v_out_319831.awb") / 1000

					if var_47_37 + var_47_29 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_37 + var_47_29
					end

					if var_47_32.prefab_name ~= "" and arg_44_1.actors_[var_47_32.prefab_name] ~= nil then
						local var_47_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_32.prefab_name].transform, "story_v_out_319831", "319831010", "story_v_out_319831.awb")

						arg_44_1:RecordAudio("319831010", var_47_38)
						arg_44_1:RecordAudio("319831010", var_47_38)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_319831", "319831010", "story_v_out_319831.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_319831", "319831010", "story_v_out_319831.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_39 = math.max(var_47_30, arg_44_1.talkMaxDuration)

			if var_47_29 <= arg_44_1.time_ and arg_44_1.time_ < var_47_29 + var_47_39 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_29) / var_47_39

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_29 + var_47_39 and arg_44_1.time_ < var_47_29 + var_47_39 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play319831011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319831011
		arg_48_1.duration_ = 4.77

		local var_48_0 = {
			zh = 1.633,
			ja = 4.766
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play319831012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.15

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:GetWordFromCfg(319831011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 6
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831011", "story_v_out_319831.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_319831", "319831011", "story_v_out_319831.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_319831", "319831011", "story_v_out_319831.awb")

						arg_48_1:RecordAudio("319831011", var_51_9)
						arg_48_1:RecordAudio("319831011", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319831", "319831011", "story_v_out_319831.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319831", "319831011", "story_v_out_319831.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play319831012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319831012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play319831013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1084ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1084ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 1.2

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_8 = arg_52_1:GetWordFromCfg(319831012)
				local var_55_9 = arg_52_1:FormatText(var_55_8.content)

				arg_52_1.text_.text = var_55_9

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_10 = 48
				local var_55_11 = utf8.len(var_55_9)
				local var_55_12 = var_55_10 <= 0 and var_55_7 or var_55_7 * (var_55_11 / var_55_10)

				if var_55_12 > 0 and var_55_7 < var_55_12 then
					arg_52_1.talkMaxDuration = var_55_12

					if var_55_12 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_9
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_13 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_13 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_13

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_13 and arg_52_1.time_ < var_55_6 + var_55_13 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play319831013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319831013
		arg_56_1.duration_ = 3.6

		local var_56_0 = {
			zh = 2.4,
			ja = 3.6
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319831014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["4040ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos4040ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos4040ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["4040ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect4040ui_story == nil then
				arg_56_1.var_.characterEffect4040ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect4040ui_story and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect4040ui_story then
				arg_56_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_59_13 = 0

			if var_59_13 < arg_56_1.time_ and arg_56_1.time_ <= var_59_13 + arg_59_0 then
				arg_56_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_59_15 = 0
			local var_59_16 = 0.175

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_17 = arg_56_1:FormatText(StoryNameCfg[668].name)

				arg_56_1.leftNameTxt_.text = var_59_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(319831013)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_20 = 7
				local var_59_21 = utf8.len(var_59_19)
				local var_59_22 = var_59_20 <= 0 and var_59_16 or var_59_16 * (var_59_21 / var_59_20)

				if var_59_22 > 0 and var_59_16 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22

					if var_59_22 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831013", "story_v_out_319831.awb") ~= 0 then
					local var_59_23 = manager.audio:GetVoiceLength("story_v_out_319831", "319831013", "story_v_out_319831.awb") / 1000

					if var_59_23 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_15
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_out_319831", "319831013", "story_v_out_319831.awb")

						arg_56_1:RecordAudio("319831013", var_59_24)
						arg_56_1:RecordAudio("319831013", var_59_24)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_319831", "319831013", "story_v_out_319831.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_319831", "319831013", "story_v_out_319831.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_25 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_25 and arg_56_1.time_ < var_59_15 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319831014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319831014
		arg_60_1.duration_ = 10.23

		local var_60_0 = {
			zh = 9,
			ja = 10.233
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
				arg_60_0:Play319831015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["4040ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect4040ui_story == nil then
				arg_60_1.var_.characterEffect4040ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect4040ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_60_1.var_.characterEffect4040ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect4040ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_60_1.var_.characterEffect4040ui_story.fillRatio = var_63_5
			end

			local var_63_6 = 0

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_63_7 = arg_60_1.actors_["1084ui_story"]
			local var_63_8 = 0

			if var_63_8 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 and not isNil(var_63_7) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_9 = 0.200000002980232

			if var_63_8 <= arg_60_1.time_ and arg_60_1.time_ < var_63_8 + var_63_9 and not isNil(var_63_7) then
				local var_63_10 = (arg_60_1.time_ - var_63_8) / var_63_9

				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_7) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_8 + var_63_9 and arg_60_1.time_ < var_63_8 + var_63_9 + arg_63_0 and not isNil(var_63_7) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_63_11 = 0
			local var_63_12 = 0.975

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_13 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_14 = arg_60_1:GetWordFromCfg(319831014)
				local var_63_15 = arg_60_1:FormatText(var_63_14.content)

				arg_60_1.text_.text = var_63_15

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_16 = 39
				local var_63_17 = utf8.len(var_63_15)
				local var_63_18 = var_63_16 <= 0 and var_63_12 or var_63_12 * (var_63_17 / var_63_16)

				if var_63_18 > 0 and var_63_12 < var_63_18 then
					arg_60_1.talkMaxDuration = var_63_18

					if var_63_18 + var_63_11 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_11
					end
				end

				arg_60_1.text_.text = var_63_15
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831014", "story_v_out_319831.awb") ~= 0 then
					local var_63_19 = manager.audio:GetVoiceLength("story_v_out_319831", "319831014", "story_v_out_319831.awb") / 1000

					if var_63_19 + var_63_11 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_11
					end

					if var_63_14.prefab_name ~= "" and arg_60_1.actors_[var_63_14.prefab_name] ~= nil then
						local var_63_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_14.prefab_name].transform, "story_v_out_319831", "319831014", "story_v_out_319831.awb")

						arg_60_1:RecordAudio("319831014", var_63_20)
						arg_60_1:RecordAudio("319831014", var_63_20)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_319831", "319831014", "story_v_out_319831.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_319831", "319831014", "story_v_out_319831.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_21 = math.max(var_63_12, arg_60_1.talkMaxDuration)

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_21 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_11) / var_63_21

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_11 + var_63_21 and arg_60_1.time_ < var_63_11 + var_63_21 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play319831015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319831015
		arg_64_1.duration_ = 4.8

		local var_64_0 = {
			zh = 1.366,
			ja = 4.8
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319831016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["4040ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect4040ui_story == nil then
				arg_64_1.var_.characterEffect4040ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect4040ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect4040ui_story then
				arg_64_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1084ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.200000002980232

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1084ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_9
			end

			local var_67_10 = 0
			local var_67_11 = 0.15

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_12 = arg_64_1:FormatText(StoryNameCfg[668].name)

				arg_64_1.leftNameTxt_.text = var_67_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_13 = arg_64_1:GetWordFromCfg(319831015)
				local var_67_14 = arg_64_1:FormatText(var_67_13.content)

				arg_64_1.text_.text = var_67_14

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 6
				local var_67_16 = utf8.len(var_67_14)
				local var_67_17 = var_67_15 <= 0 and var_67_11 or var_67_11 * (var_67_16 / var_67_15)

				if var_67_17 > 0 and var_67_11 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_10
					end
				end

				arg_64_1.text_.text = var_67_14
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831015", "story_v_out_319831.awb") ~= 0 then
					local var_67_18 = manager.audio:GetVoiceLength("story_v_out_319831", "319831015", "story_v_out_319831.awb") / 1000

					if var_67_18 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_10
					end

					if var_67_13.prefab_name ~= "" and arg_64_1.actors_[var_67_13.prefab_name] ~= nil then
						local var_67_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_13.prefab_name].transform, "story_v_out_319831", "319831015", "story_v_out_319831.awb")

						arg_64_1:RecordAudio("319831015", var_67_19)
						arg_64_1:RecordAudio("319831015", var_67_19)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_319831", "319831015", "story_v_out_319831.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_319831", "319831015", "story_v_out_319831.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_20 = math.max(var_67_11, arg_64_1.talkMaxDuration)

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_20 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_10) / var_67_20

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_10 + var_67_20 and arg_64_1.time_ < var_67_10 + var_67_20 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play319831016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319831016
		arg_68_1.duration_ = 1.27

		local var_68_0 = {
			zh = 1.266,
			ja = 1.133
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
				arg_68_0:Play319831017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["4040ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect4040ui_story == nil then
				arg_68_1.var_.characterEffect4040ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect4040ui_story and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_68_1.var_.characterEffect4040ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect4040ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_68_1.var_.characterEffect4040ui_story.fillRatio = var_71_5
			end

			local var_71_6 = arg_68_1.actors_["1084ui_story"]
			local var_71_7 = 0

			if var_71_7 < arg_68_1.time_ and arg_68_1.time_ <= var_71_7 + arg_71_0 and not isNil(var_71_6) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_8 = 0.200000002980232

			if var_71_7 <= arg_68_1.time_ and arg_68_1.time_ < var_71_7 + var_71_8 and not isNil(var_71_6) then
				local var_71_9 = (arg_68_1.time_ - var_71_7) / var_71_8

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_6) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_7 + var_71_8 and arg_68_1.time_ < var_71_7 + var_71_8 + arg_71_0 and not isNil(var_71_6) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_71_10 = 0
			local var_71_11 = 0.075

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_12 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_13 = arg_68_1:GetWordFromCfg(319831016)
				local var_71_14 = arg_68_1:FormatText(var_71_13.content)

				arg_68_1.text_.text = var_71_14

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_15 = 3
				local var_71_16 = utf8.len(var_71_14)
				local var_71_17 = var_71_15 <= 0 and var_71_11 or var_71_11 * (var_71_16 / var_71_15)

				if var_71_17 > 0 and var_71_11 < var_71_17 then
					arg_68_1.talkMaxDuration = var_71_17

					if var_71_17 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_17 + var_71_10
					end
				end

				arg_68_1.text_.text = var_71_14
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831016", "story_v_out_319831.awb") ~= 0 then
					local var_71_18 = manager.audio:GetVoiceLength("story_v_out_319831", "319831016", "story_v_out_319831.awb") / 1000

					if var_71_18 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_18 + var_71_10
					end

					if var_71_13.prefab_name ~= "" and arg_68_1.actors_[var_71_13.prefab_name] ~= nil then
						local var_71_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_13.prefab_name].transform, "story_v_out_319831", "319831016", "story_v_out_319831.awb")

						arg_68_1:RecordAudio("319831016", var_71_19)
						arg_68_1:RecordAudio("319831016", var_71_19)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_319831", "319831016", "story_v_out_319831.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_319831", "319831016", "story_v_out_319831.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_20 = math.max(var_71_11, arg_68_1.talkMaxDuration)

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_20 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_10) / var_71_20

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_10 + var_71_20 and arg_68_1.time_ < var_71_10 + var_71_20 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play319831017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319831017
		arg_72_1.duration_ = 4.4

		local var_72_0 = {
			zh = 2.166,
			ja = 4.4
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
				arg_72_0:Play319831018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["4040ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos4040ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos4040ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = arg_72_1.actors_["4040ui_story"]
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect4040ui_story == nil then
				arg_72_1.var_.characterEffect4040ui_story = var_75_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_11 = 0.200000002980232

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_11 and not isNil(var_75_9) then
				local var_75_12 = (arg_72_1.time_ - var_75_10) / var_75_11

				if arg_72_1.var_.characterEffect4040ui_story and not isNil(var_75_9) then
					arg_72_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_10 + var_75_11 and arg_72_1.time_ < var_75_10 + var_75_11 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect4040ui_story then
				arg_72_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_75_13 = 0

			if var_75_13 < arg_72_1.time_ and arg_72_1.time_ <= var_75_13 + arg_75_0 then
				arg_72_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_75_14 = 0

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_75_15 = arg_72_1.actors_["1084ui_story"]
			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 and not isNil(var_75_15) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_17 = 0.200000002980232

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_17 and not isNil(var_75_15) then
				local var_75_18 = (arg_72_1.time_ - var_75_16) / var_75_17

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_15) then
					local var_75_19 = Mathf.Lerp(0, 0.5, var_75_18)

					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_19
				end
			end

			if arg_72_1.time_ >= var_75_16 + var_75_17 and arg_72_1.time_ < var_75_16 + var_75_17 + arg_75_0 and not isNil(var_75_15) and arg_72_1.var_.characterEffect1084ui_story then
				local var_75_20 = 0.5

				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_20
			end

			local var_75_21 = 0
			local var_75_22 = 0.175

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_23 = arg_72_1:FormatText(StoryNameCfg[668].name)

				arg_72_1.leftNameTxt_.text = var_75_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_24 = arg_72_1:GetWordFromCfg(319831017)
				local var_75_25 = arg_72_1:FormatText(var_75_24.content)

				arg_72_1.text_.text = var_75_25

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_26 = 7
				local var_75_27 = utf8.len(var_75_25)
				local var_75_28 = var_75_26 <= 0 and var_75_22 or var_75_22 * (var_75_27 / var_75_26)

				if var_75_28 > 0 and var_75_22 < var_75_28 then
					arg_72_1.talkMaxDuration = var_75_28

					if var_75_28 + var_75_21 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_28 + var_75_21
					end
				end

				arg_72_1.text_.text = var_75_25
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831017", "story_v_out_319831.awb") ~= 0 then
					local var_75_29 = manager.audio:GetVoiceLength("story_v_out_319831", "319831017", "story_v_out_319831.awb") / 1000

					if var_75_29 + var_75_21 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_29 + var_75_21
					end

					if var_75_24.prefab_name ~= "" and arg_72_1.actors_[var_75_24.prefab_name] ~= nil then
						local var_75_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_24.prefab_name].transform, "story_v_out_319831", "319831017", "story_v_out_319831.awb")

						arg_72_1:RecordAudio("319831017", var_75_30)
						arg_72_1:RecordAudio("319831017", var_75_30)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_319831", "319831017", "story_v_out_319831.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_319831", "319831017", "story_v_out_319831.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_31 = math.max(var_75_22, arg_72_1.talkMaxDuration)

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_31 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_21) / var_75_31

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_21 + var_75_31 and arg_72_1.time_ < var_75_21 + var_75_31 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319831018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319831018
		arg_76_1.duration_ = 4.2

		local var_76_0 = {
			zh = 1.999999999999,
			ja = 4.2
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play319831019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["4040ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect4040ui_story == nil then
				arg_76_1.var_.characterEffect4040ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect4040ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_76_1.var_.characterEffect4040ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect4040ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_76_1.var_.characterEffect4040ui_story.fillRatio = var_79_5
			end

			local var_79_6 = arg_76_1.actors_["1084ui_story"]
			local var_79_7 = 0

			if var_79_7 < arg_76_1.time_ and arg_76_1.time_ <= var_79_7 + arg_79_0 and not isNil(var_79_6) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = var_79_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_8 = 0.200000002980232

			if var_79_7 <= arg_76_1.time_ and arg_76_1.time_ < var_79_7 + var_79_8 and not isNil(var_79_6) then
				local var_79_9 = (arg_76_1.time_ - var_79_7) / var_79_8

				if arg_76_1.var_.characterEffect1084ui_story and not isNil(var_79_6) then
					arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_7 + var_79_8 and arg_76_1.time_ < var_79_7 + var_79_8 + arg_79_0 and not isNil(var_79_6) and arg_76_1.var_.characterEffect1084ui_story then
				arg_76_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_79_11 = 0

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_79_12 = 0
			local var_79_13 = 0.25

			if var_79_12 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_14 = arg_76_1:FormatText(StoryNameCfg[6].name)

				arg_76_1.leftNameTxt_.text = var_79_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_15 = arg_76_1:GetWordFromCfg(319831018)
				local var_79_16 = arg_76_1:FormatText(var_79_15.content)

				arg_76_1.text_.text = var_79_16

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_17 = 10
				local var_79_18 = utf8.len(var_79_16)
				local var_79_19 = var_79_17 <= 0 and var_79_13 or var_79_13 * (var_79_18 / var_79_17)

				if var_79_19 > 0 and var_79_13 < var_79_19 then
					arg_76_1.talkMaxDuration = var_79_19

					if var_79_19 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_19 + var_79_12
					end
				end

				arg_76_1.text_.text = var_79_16
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831018", "story_v_out_319831.awb") ~= 0 then
					local var_79_20 = manager.audio:GetVoiceLength("story_v_out_319831", "319831018", "story_v_out_319831.awb") / 1000

					if var_79_20 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_20 + var_79_12
					end

					if var_79_15.prefab_name ~= "" and arg_76_1.actors_[var_79_15.prefab_name] ~= nil then
						local var_79_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_15.prefab_name].transform, "story_v_out_319831", "319831018", "story_v_out_319831.awb")

						arg_76_1:RecordAudio("319831018", var_79_21)
						arg_76_1:RecordAudio("319831018", var_79_21)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_319831", "319831018", "story_v_out_319831.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_319831", "319831018", "story_v_out_319831.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_22 = math.max(var_79_13, arg_76_1.talkMaxDuration)

			if var_79_12 <= arg_76_1.time_ and arg_76_1.time_ < var_79_12 + var_79_22 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_12) / var_79_22

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_12 + var_79_22 and arg_76_1.time_ < var_79_12 + var_79_22 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play319831019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319831019
		arg_80_1.duration_ = 12.3

		local var_80_0 = {
			zh = 9.133,
			ja = 12.3
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
				arg_80_0:Play319831020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["4040ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect4040ui_story == nil then
				arg_80_1.var_.characterEffect4040ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect4040ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect4040ui_story then
				arg_80_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1084ui_story"]
			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = var_83_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.200000002980232

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_6 and not isNil(var_83_4) then
				local var_83_7 = (arg_80_1.time_ - var_83_5) / var_83_6

				if arg_80_1.var_.characterEffect1084ui_story and not isNil(var_83_4) then
					local var_83_8 = Mathf.Lerp(0, 0.5, var_83_7)

					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = var_83_8
				end
			end

			if arg_80_1.time_ >= var_83_5 + var_83_6 and arg_80_1.time_ < var_83_5 + var_83_6 + arg_83_0 and not isNil(var_83_4) and arg_80_1.var_.characterEffect1084ui_story then
				local var_83_9 = 0.5

				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = var_83_9
			end

			local var_83_10 = 0
			local var_83_11 = 1.025

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_12 = arg_80_1:FormatText(StoryNameCfg[668].name)

				arg_80_1.leftNameTxt_.text = var_83_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_13 = arg_80_1:GetWordFromCfg(319831019)
				local var_83_14 = arg_80_1:FormatText(var_83_13.content)

				arg_80_1.text_.text = var_83_14

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_15 = 41
				local var_83_16 = utf8.len(var_83_14)
				local var_83_17 = var_83_15 <= 0 and var_83_11 or var_83_11 * (var_83_16 / var_83_15)

				if var_83_17 > 0 and var_83_11 < var_83_17 then
					arg_80_1.talkMaxDuration = var_83_17

					if var_83_17 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_17 + var_83_10
					end
				end

				arg_80_1.text_.text = var_83_14
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831019", "story_v_out_319831.awb") ~= 0 then
					local var_83_18 = manager.audio:GetVoiceLength("story_v_out_319831", "319831019", "story_v_out_319831.awb") / 1000

					if var_83_18 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_10
					end

					if var_83_13.prefab_name ~= "" and arg_80_1.actors_[var_83_13.prefab_name] ~= nil then
						local var_83_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_13.prefab_name].transform, "story_v_out_319831", "319831019", "story_v_out_319831.awb")

						arg_80_1:RecordAudio("319831019", var_83_19)
						arg_80_1:RecordAudio("319831019", var_83_19)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_319831", "319831019", "story_v_out_319831.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_319831", "319831019", "story_v_out_319831.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_20 = math.max(var_83_11, arg_80_1.talkMaxDuration)

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_20 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_10) / var_83_20

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_10 + var_83_20 and arg_80_1.time_ < var_83_10 + var_83_20 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play319831020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 319831020
		arg_84_1.duration_ = 3.4

		local var_84_0 = {
			zh = 2.3,
			ja = 3.4
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
				arg_84_0:Play319831021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1084ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0.7, -0.97, -6)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				arg_84_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_87_10 = arg_84_1.actors_["4040ui_story"]
			local var_87_11 = 0

			if var_87_11 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 and not isNil(var_87_10) and arg_84_1.var_.characterEffect4040ui_story == nil then
				arg_84_1.var_.characterEffect4040ui_story = var_87_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_12 = 0.200000002980232

			if var_87_11 <= arg_84_1.time_ and arg_84_1.time_ < var_87_11 + var_87_12 and not isNil(var_87_10) then
				local var_87_13 = (arg_84_1.time_ - var_87_11) / var_87_12

				if arg_84_1.var_.characterEffect4040ui_story and not isNil(var_87_10) then
					local var_87_14 = Mathf.Lerp(0, 0.5, var_87_13)

					arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_84_1.var_.characterEffect4040ui_story.fillRatio = var_87_14
				end
			end

			if arg_84_1.time_ >= var_87_11 + var_87_12 and arg_84_1.time_ < var_87_11 + var_87_12 + arg_87_0 and not isNil(var_87_10) and arg_84_1.var_.characterEffect4040ui_story then
				local var_87_15 = 0.5

				arg_84_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_84_1.var_.characterEffect4040ui_story.fillRatio = var_87_15
			end

			local var_87_16 = arg_84_1.actors_["1084ui_story"]
			local var_87_17 = 0

			if var_87_17 < arg_84_1.time_ and arg_84_1.time_ <= var_87_17 + arg_87_0 and not isNil(var_87_16) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_18 = 0.200000002980232

			if var_87_17 <= arg_84_1.time_ and arg_84_1.time_ < var_87_17 + var_87_18 and not isNil(var_87_16) then
				local var_87_19 = (arg_84_1.time_ - var_87_17) / var_87_18

				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_16) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_17 + var_87_18 and arg_84_1.time_ < var_87_17 + var_87_18 + arg_87_0 and not isNil(var_87_16) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_87_20 = 0
			local var_87_21 = 0.325

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_22 = arg_84_1:FormatText(StoryNameCfg[6].name)

				arg_84_1.leftNameTxt_.text = var_87_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_23 = arg_84_1:GetWordFromCfg(319831020)
				local var_87_24 = arg_84_1:FormatText(var_87_23.content)

				arg_84_1.text_.text = var_87_24

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_25 = 13
				local var_87_26 = utf8.len(var_87_24)
				local var_87_27 = var_87_25 <= 0 and var_87_21 or var_87_21 * (var_87_26 / var_87_25)

				if var_87_27 > 0 and var_87_21 < var_87_27 then
					arg_84_1.talkMaxDuration = var_87_27

					if var_87_27 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_27 + var_87_20
					end
				end

				arg_84_1.text_.text = var_87_24
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831020", "story_v_out_319831.awb") ~= 0 then
					local var_87_28 = manager.audio:GetVoiceLength("story_v_out_319831", "319831020", "story_v_out_319831.awb") / 1000

					if var_87_28 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_28 + var_87_20
					end

					if var_87_23.prefab_name ~= "" and arg_84_1.actors_[var_87_23.prefab_name] ~= nil then
						local var_87_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_23.prefab_name].transform, "story_v_out_319831", "319831020", "story_v_out_319831.awb")

						arg_84_1:RecordAudio("319831020", var_87_29)
						arg_84_1:RecordAudio("319831020", var_87_29)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_319831", "319831020", "story_v_out_319831.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_319831", "319831020", "story_v_out_319831.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_30 = math.max(var_87_21, arg_84_1.talkMaxDuration)

			if var_87_20 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_30 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_20) / var_87_30

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_20 + var_87_30 and arg_84_1.time_ < var_87_20 + var_87_30 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play319831021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 319831021
		arg_88_1.duration_ = 11.13

		local var_88_0 = {
			zh = 8.233,
			ja = 11.133
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
				arg_88_0:Play319831022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["4040ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos4040ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos4040ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["4040ui_story"]
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect4040ui_story == nil then
				arg_88_1.var_.characterEffect4040ui_story = var_91_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.200000002980232

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 and not isNil(var_91_9) then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11

				if arg_88_1.var_.characterEffect4040ui_story and not isNil(var_91_9) then
					arg_88_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect4040ui_story then
				arg_88_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_91_13 = arg_88_1.actors_["1084ui_story"]
			local var_91_14 = 0

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 and not isNil(var_91_13) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_15 = 0.200000002980232

			if var_91_14 <= arg_88_1.time_ and arg_88_1.time_ < var_91_14 + var_91_15 and not isNil(var_91_13) then
				local var_91_16 = (arg_88_1.time_ - var_91_14) / var_91_15

				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_13) then
					local var_91_17 = Mathf.Lerp(0, 0.5, var_91_16)

					arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_17
				end
			end

			if arg_88_1.time_ >= var_91_14 + var_91_15 and arg_88_1.time_ < var_91_14 + var_91_15 + arg_91_0 and not isNil(var_91_13) and arg_88_1.var_.characterEffect1084ui_story then
				local var_91_18 = 0.5

				arg_88_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1084ui_story.fillRatio = var_91_18
			end

			local var_91_19 = 0
			local var_91_20 = 0.95

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_21 = arg_88_1:FormatText(StoryNameCfg[668].name)

				arg_88_1.leftNameTxt_.text = var_91_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_22 = arg_88_1:GetWordFromCfg(319831021)
				local var_91_23 = arg_88_1:FormatText(var_91_22.content)

				arg_88_1.text_.text = var_91_23

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_24 = 38
				local var_91_25 = utf8.len(var_91_23)
				local var_91_26 = var_91_24 <= 0 and var_91_20 or var_91_20 * (var_91_25 / var_91_24)

				if var_91_26 > 0 and var_91_20 < var_91_26 then
					arg_88_1.talkMaxDuration = var_91_26

					if var_91_26 + var_91_19 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_26 + var_91_19
					end
				end

				arg_88_1.text_.text = var_91_23
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831021", "story_v_out_319831.awb") ~= 0 then
					local var_91_27 = manager.audio:GetVoiceLength("story_v_out_319831", "319831021", "story_v_out_319831.awb") / 1000

					if var_91_27 + var_91_19 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_27 + var_91_19
					end

					if var_91_22.prefab_name ~= "" and arg_88_1.actors_[var_91_22.prefab_name] ~= nil then
						local var_91_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_22.prefab_name].transform, "story_v_out_319831", "319831021", "story_v_out_319831.awb")

						arg_88_1:RecordAudio("319831021", var_91_28)
						arg_88_1:RecordAudio("319831021", var_91_28)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_319831", "319831021", "story_v_out_319831.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_319831", "319831021", "story_v_out_319831.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_29 = math.max(var_91_20, arg_88_1.talkMaxDuration)

			if var_91_19 <= arg_88_1.time_ and arg_88_1.time_ < var_91_19 + var_91_29 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_19) / var_91_29

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_19 + var_91_29 and arg_88_1.time_ < var_91_19 + var_91_29 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play319831022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 319831022
		arg_92_1.duration_ = 12.33

		local var_92_0 = {
			zh = 9.7,
			ja = 12.333
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
				arg_92_0:Play319831023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_95_2 = 0
			local var_95_3 = 1.15

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_4 = arg_92_1:FormatText(StoryNameCfg[668].name)

				arg_92_1.leftNameTxt_.text = var_95_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_5 = arg_92_1:GetWordFromCfg(319831022)
				local var_95_6 = arg_92_1:FormatText(var_95_5.content)

				arg_92_1.text_.text = var_95_6

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 46
				local var_95_8 = utf8.len(var_95_6)
				local var_95_9 = var_95_7 <= 0 and var_95_3 or var_95_3 * (var_95_8 / var_95_7)

				if var_95_9 > 0 and var_95_3 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_6
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831022", "story_v_out_319831.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_out_319831", "319831022", "story_v_out_319831.awb") / 1000

					if var_95_10 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_2
					end

					if var_95_5.prefab_name ~= "" and arg_92_1.actors_[var_95_5.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_5.prefab_name].transform, "story_v_out_319831", "319831022", "story_v_out_319831.awb")

						arg_92_1:RecordAudio("319831022", var_95_11)
						arg_92_1:RecordAudio("319831022", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_319831", "319831022", "story_v_out_319831.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_319831", "319831022", "story_v_out_319831.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_12 and arg_92_1.time_ < var_95_2 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play319831023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 319831023
		arg_96_1.duration_ = 10.17

		local var_96_0 = {
			zh = 3.266,
			ja = 10.166
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
				arg_96_0:Play319831024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.35

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[668].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_3 = arg_96_1:GetWordFromCfg(319831023)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 14
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831023", "story_v_out_319831.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_319831", "319831023", "story_v_out_319831.awb") / 1000

					if var_99_8 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_0
					end

					if var_99_3.prefab_name ~= "" and arg_96_1.actors_[var_99_3.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_3.prefab_name].transform, "story_v_out_319831", "319831023", "story_v_out_319831.awb")

						arg_96_1:RecordAudio("319831023", var_99_9)
						arg_96_1:RecordAudio("319831023", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_319831", "319831023", "story_v_out_319831.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_319831", "319831023", "story_v_out_319831.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_10 and arg_96_1.time_ < var_99_0 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play319831024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319831024
		arg_100_1.duration_ = 3.23

		local var_100_0 = {
			zh = 1.999999999999,
			ja = 3.233
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
				arg_100_0:Play319831025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["4040ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect4040ui_story == nil then
				arg_100_1.var_.characterEffect4040ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect4040ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_100_1.var_.characterEffect4040ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect4040ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_100_1.var_.characterEffect4040ui_story.fillRatio = var_103_5
			end

			local var_103_6 = arg_100_1.actors_["1084ui_story"]
			local var_103_7 = 0

			if var_103_7 < arg_100_1.time_ and arg_100_1.time_ <= var_103_7 + arg_103_0 and not isNil(var_103_6) and arg_100_1.var_.characterEffect1084ui_story == nil then
				arg_100_1.var_.characterEffect1084ui_story = var_103_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_8 = 0.200000002980232

			if var_103_7 <= arg_100_1.time_ and arg_100_1.time_ < var_103_7 + var_103_8 and not isNil(var_103_6) then
				local var_103_9 = (arg_100_1.time_ - var_103_7) / var_103_8

				if arg_100_1.var_.characterEffect1084ui_story and not isNil(var_103_6) then
					arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_7 + var_103_8 and arg_100_1.time_ < var_103_7 + var_103_8 + arg_103_0 and not isNil(var_103_6) and arg_100_1.var_.characterEffect1084ui_story then
				arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_103_11 = 0
			local var_103_12 = 0.175

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_13 = arg_100_1:FormatText(StoryNameCfg[6].name)

				arg_100_1.leftNameTxt_.text = var_103_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_14 = arg_100_1:GetWordFromCfg(319831024)
				local var_103_15 = arg_100_1:FormatText(var_103_14.content)

				arg_100_1.text_.text = var_103_15

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_16 = 7
				local var_103_17 = utf8.len(var_103_15)
				local var_103_18 = var_103_16 <= 0 and var_103_12 or var_103_12 * (var_103_17 / var_103_16)

				if var_103_18 > 0 and var_103_12 < var_103_18 then
					arg_100_1.talkMaxDuration = var_103_18

					if var_103_18 + var_103_11 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_18 + var_103_11
					end
				end

				arg_100_1.text_.text = var_103_15
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831024", "story_v_out_319831.awb") ~= 0 then
					local var_103_19 = manager.audio:GetVoiceLength("story_v_out_319831", "319831024", "story_v_out_319831.awb") / 1000

					if var_103_19 + var_103_11 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_19 + var_103_11
					end

					if var_103_14.prefab_name ~= "" and arg_100_1.actors_[var_103_14.prefab_name] ~= nil then
						local var_103_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_14.prefab_name].transform, "story_v_out_319831", "319831024", "story_v_out_319831.awb")

						arg_100_1:RecordAudio("319831024", var_103_20)
						arg_100_1:RecordAudio("319831024", var_103_20)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_319831", "319831024", "story_v_out_319831.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_319831", "319831024", "story_v_out_319831.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_21 = math.max(var_103_12, arg_100_1.talkMaxDuration)

			if var_103_11 <= arg_100_1.time_ and arg_100_1.time_ < var_103_11 + var_103_21 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_11) / var_103_21

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_11 + var_103_21 and arg_100_1.time_ < var_103_11 + var_103_21 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play319831025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319831025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play319831026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1084ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1084ui_story == nil then
				arg_104_1.var_.characterEffect1084ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1084ui_story and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1084ui_story.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1084ui_story then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1084ui_story.fillRatio = var_107_5
			end

			local var_107_6 = 0
			local var_107_7 = 1.225

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:GetWordFromCfg(319831025)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_10 = 49
				local var_107_11 = utf8.len(var_107_9)
				local var_107_12 = var_107_10 <= 0 and var_107_7 or var_107_7 * (var_107_11 / var_107_10)

				if var_107_12 > 0 and var_107_7 < var_107_12 then
					arg_104_1.talkMaxDuration = var_107_12

					if var_107_12 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_13 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_13 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_13

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_13 and arg_104_1.time_ < var_107_6 + var_107_13 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play319831026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319831026
		arg_108_1.duration_ = 3.87

		local var_108_0 = {
			zh = 3.866,
			ja = 2.833
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
				arg_108_0:Play319831027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1084ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1084ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0.7, -0.97, -6)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1084ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["1084ui_story"]
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1084ui_story == nil then
				arg_108_1.var_.characterEffect1084ui_story = var_111_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_11 = 0.200000002980232

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 and not isNil(var_111_9) then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11

				if arg_108_1.var_.characterEffect1084ui_story and not isNil(var_111_9) then
					arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1084ui_story then
				arg_108_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_111_13 = 0

			if var_111_13 < arg_108_1.time_ and arg_108_1.time_ <= var_111_13 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_111_14 = 0

			if var_111_14 < arg_108_1.time_ and arg_108_1.time_ <= var_111_14 + arg_111_0 then
				arg_108_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_111_15 = 0
			local var_111_16 = 0.475

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_17 = arg_108_1:FormatText(StoryNameCfg[6].name)

				arg_108_1.leftNameTxt_.text = var_111_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_18 = arg_108_1:GetWordFromCfg(319831026)
				local var_111_19 = arg_108_1:FormatText(var_111_18.content)

				arg_108_1.text_.text = var_111_19

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_20 = 19
				local var_111_21 = utf8.len(var_111_19)
				local var_111_22 = var_111_20 <= 0 and var_111_16 or var_111_16 * (var_111_21 / var_111_20)

				if var_111_22 > 0 and var_111_16 < var_111_22 then
					arg_108_1.talkMaxDuration = var_111_22

					if var_111_22 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_22 + var_111_15
					end
				end

				arg_108_1.text_.text = var_111_19
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831026", "story_v_out_319831.awb") ~= 0 then
					local var_111_23 = manager.audio:GetVoiceLength("story_v_out_319831", "319831026", "story_v_out_319831.awb") / 1000

					if var_111_23 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_15
					end

					if var_111_18.prefab_name ~= "" and arg_108_1.actors_[var_111_18.prefab_name] ~= nil then
						local var_111_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_18.prefab_name].transform, "story_v_out_319831", "319831026", "story_v_out_319831.awb")

						arg_108_1:RecordAudio("319831026", var_111_24)
						arg_108_1:RecordAudio("319831026", var_111_24)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_319831", "319831026", "story_v_out_319831.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_319831", "319831026", "story_v_out_319831.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_25 = math.max(var_111_16, arg_108_1.talkMaxDuration)

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_25 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_15) / var_111_25

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_15 + var_111_25 and arg_108_1.time_ < var_111_15 + var_111_25 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play319831027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319831027
		arg_112_1.duration_ = 6.23

		local var_112_0 = {
			zh = 3.4,
			ja = 6.233
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
				arg_112_0:Play319831028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["4040ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos4040ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos4040ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = arg_112_1.actors_["1084ui_story"]
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = var_115_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_11 = 0.200000002980232

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 and not isNil(var_115_9) then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11

				if arg_112_1.var_.characterEffect1084ui_story and not isNil(var_115_9) then
					local var_115_13 = Mathf.Lerp(0, 0.5, var_115_12)

					arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1084ui_story.fillRatio = var_115_13
				end
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1084ui_story then
				local var_115_14 = 0.5

				arg_112_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1084ui_story.fillRatio = var_115_14
			end

			local var_115_15 = arg_112_1.actors_["4040ui_story"]
			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 and not isNil(var_115_15) and arg_112_1.var_.characterEffect4040ui_story == nil then
				arg_112_1.var_.characterEffect4040ui_story = var_115_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_17 = 0.200000002980232

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_17 and not isNil(var_115_15) then
				local var_115_18 = (arg_112_1.time_ - var_115_16) / var_115_17

				if arg_112_1.var_.characterEffect4040ui_story and not isNil(var_115_15) then
					arg_112_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_16 + var_115_17 and arg_112_1.time_ < var_115_16 + var_115_17 + arg_115_0 and not isNil(var_115_15) and arg_112_1.var_.characterEffect4040ui_story then
				arg_112_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_115_19 = 0
			local var_115_20 = 0.35

			if var_115_19 < arg_112_1.time_ and arg_112_1.time_ <= var_115_19 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_21 = arg_112_1:FormatText(StoryNameCfg[668].name)

				arg_112_1.leftNameTxt_.text = var_115_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_22 = arg_112_1:GetWordFromCfg(319831027)
				local var_115_23 = arg_112_1:FormatText(var_115_22.content)

				arg_112_1.text_.text = var_115_23

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_24 = 14
				local var_115_25 = utf8.len(var_115_23)
				local var_115_26 = var_115_24 <= 0 and var_115_20 or var_115_20 * (var_115_25 / var_115_24)

				if var_115_26 > 0 and var_115_20 < var_115_26 then
					arg_112_1.talkMaxDuration = var_115_26

					if var_115_26 + var_115_19 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_26 + var_115_19
					end
				end

				arg_112_1.text_.text = var_115_23
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831027", "story_v_out_319831.awb") ~= 0 then
					local var_115_27 = manager.audio:GetVoiceLength("story_v_out_319831", "319831027", "story_v_out_319831.awb") / 1000

					if var_115_27 + var_115_19 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_27 + var_115_19
					end

					if var_115_22.prefab_name ~= "" and arg_112_1.actors_[var_115_22.prefab_name] ~= nil then
						local var_115_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_22.prefab_name].transform, "story_v_out_319831", "319831027", "story_v_out_319831.awb")

						arg_112_1:RecordAudio("319831027", var_115_28)
						arg_112_1:RecordAudio("319831027", var_115_28)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_319831", "319831027", "story_v_out_319831.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_319831", "319831027", "story_v_out_319831.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_29 = math.max(var_115_20, arg_112_1.talkMaxDuration)

			if var_115_19 <= arg_112_1.time_ and arg_112_1.time_ < var_115_19 + var_115_29 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_19) / var_115_29

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_19 + var_115_29 and arg_112_1.time_ < var_115_19 + var_115_29 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play319831028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319831028
		arg_116_1.duration_ = 3.5

		local var_116_0 = {
			zh = 2.933,
			ja = 3.5
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
				arg_116_0:Play319831029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1084ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1084ui_story == nil then
				arg_116_1.var_.characterEffect1084ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1084ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1084ui_story then
				arg_116_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_119_4 = arg_116_1.actors_["4040ui_story"]
			local var_119_5 = 0

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect4040ui_story == nil then
				arg_116_1.var_.characterEffect4040ui_story = var_119_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_6 = 0.200000002980232

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 and not isNil(var_119_4) then
				local var_119_7 = (arg_116_1.time_ - var_119_5) / var_119_6

				if arg_116_1.var_.characterEffect4040ui_story and not isNil(var_119_4) then
					local var_119_8 = Mathf.Lerp(0, 0.5, var_119_7)

					arg_116_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_116_1.var_.characterEffect4040ui_story.fillRatio = var_119_8
				end
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 and not isNil(var_119_4) and arg_116_1.var_.characterEffect4040ui_story then
				local var_119_9 = 0.5

				arg_116_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_116_1.var_.characterEffect4040ui_story.fillRatio = var_119_9
			end

			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_119_11 = 0

			if var_119_11 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_119_12 = 0
			local var_119_13 = 0.25

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_14 = arg_116_1:FormatText(StoryNameCfg[6].name)

				arg_116_1.leftNameTxt_.text = var_119_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_15 = arg_116_1:GetWordFromCfg(319831028)
				local var_119_16 = arg_116_1:FormatText(var_119_15.content)

				arg_116_1.text_.text = var_119_16

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_17 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831028", "story_v_out_319831.awb") ~= 0 then
					local var_119_20 = manager.audio:GetVoiceLength("story_v_out_319831", "319831028", "story_v_out_319831.awb") / 1000

					if var_119_20 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_20 + var_119_12
					end

					if var_119_15.prefab_name ~= "" and arg_116_1.actors_[var_119_15.prefab_name] ~= nil then
						local var_119_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_15.prefab_name].transform, "story_v_out_319831", "319831028", "story_v_out_319831.awb")

						arg_116_1:RecordAudio("319831028", var_119_21)
						arg_116_1:RecordAudio("319831028", var_119_21)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319831", "319831028", "story_v_out_319831.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319831", "319831028", "story_v_out_319831.awb")
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
	Play319831029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319831029
		arg_120_1.duration_ = 7.7

		local var_120_0 = {
			zh = 7.7,
			ja = 7.366
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
				arg_120_0:Play319831030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_1")
			end

			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_123_2 = arg_120_1.actors_["1084ui_story"]
			local var_123_3 = 0

			if var_123_3 < arg_120_1.time_ and arg_120_1.time_ <= var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1084ui_story == nil then
				arg_120_1.var_.characterEffect1084ui_story = var_123_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_4 = 0.200000002980232

			if var_123_3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_3 + var_123_4 and not isNil(var_123_2) then
				local var_123_5 = (arg_120_1.time_ - var_123_3) / var_123_4

				if arg_120_1.var_.characterEffect1084ui_story and not isNil(var_123_2) then
					local var_123_6 = Mathf.Lerp(0, 0.5, var_123_5)

					arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_6
				end
			end

			if arg_120_1.time_ >= var_123_3 + var_123_4 and arg_120_1.time_ < var_123_3 + var_123_4 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1084ui_story then
				local var_123_7 = 0.5

				arg_120_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1084ui_story.fillRatio = var_123_7
			end

			local var_123_8 = arg_120_1.actors_["4040ui_story"]
			local var_123_9 = 0

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.characterEffect4040ui_story == nil then
				arg_120_1.var_.characterEffect4040ui_story = var_123_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_10 = 0.200000002980232

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 and not isNil(var_123_8) then
				local var_123_11 = (arg_120_1.time_ - var_123_9) / var_123_10

				if arg_120_1.var_.characterEffect4040ui_story and not isNil(var_123_8) then
					arg_120_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.characterEffect4040ui_story then
				arg_120_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_123_12 = 0
			local var_123_13 = 0.95

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_14 = arg_120_1:FormatText(StoryNameCfg[668].name)

				arg_120_1.leftNameTxt_.text = var_123_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_15 = arg_120_1:GetWordFromCfg(319831029)
				local var_123_16 = arg_120_1:FormatText(var_123_15.content)

				arg_120_1.text_.text = var_123_16

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_17 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831029", "story_v_out_319831.awb") ~= 0 then
					local var_123_20 = manager.audio:GetVoiceLength("story_v_out_319831", "319831029", "story_v_out_319831.awb") / 1000

					if var_123_20 + var_123_12 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_20 + var_123_12
					end

					if var_123_15.prefab_name ~= "" and arg_120_1.actors_[var_123_15.prefab_name] ~= nil then
						local var_123_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_15.prefab_name].transform, "story_v_out_319831", "319831029", "story_v_out_319831.awb")

						arg_120_1:RecordAudio("319831029", var_123_21)
						arg_120_1:RecordAudio("319831029", var_123_21)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_319831", "319831029", "story_v_out_319831.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_319831", "319831029", "story_v_out_319831.awb")
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
	Play319831030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319831030
		arg_124_1.duration_ = 6.4

		local var_124_0 = {
			zh = 6.2,
			ja = 6.4
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
				arg_124_0:Play319831031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.85

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[668].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:GetWordFromCfg(319831030)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831030", "story_v_out_319831.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_319831", "319831030", "story_v_out_319831.awb") / 1000

					if var_127_8 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_0
					end

					if var_127_3.prefab_name ~= "" and arg_124_1.actors_[var_127_3.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_3.prefab_name].transform, "story_v_out_319831", "319831030", "story_v_out_319831.awb")

						arg_124_1:RecordAudio("319831030", var_127_9)
						arg_124_1:RecordAudio("319831030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_319831", "319831030", "story_v_out_319831.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_319831", "319831030", "story_v_out_319831.awb")
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
	Play319831031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319831031
		arg_128_1.duration_ = 2.47

		local var_128_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play319831032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1084ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1084ui_story == nil then
				arg_128_1.var_.characterEffect1084ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1084ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1084ui_story then
				arg_128_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["4040ui_story"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect4040ui_story == nil then
				arg_128_1.var_.characterEffect4040ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.200000002980232

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.characterEffect4040ui_story and not isNil(var_131_4) then
					local var_131_8 = Mathf.Lerp(0, 0.5, var_131_7)

					arg_128_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_128_1.var_.characterEffect4040ui_story.fillRatio = var_131_8
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect4040ui_story then
				local var_131_9 = 0.5

				arg_128_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_128_1.var_.characterEffect4040ui_story.fillRatio = var_131_9
			end

			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_131_11 = 0
			local var_131_12 = 0.2

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_13 = arg_128_1:FormatText(StoryNameCfg[6].name)

				arg_128_1.leftNameTxt_.text = var_131_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_14 = arg_128_1:GetWordFromCfg(319831031)
				local var_131_15 = arg_128_1:FormatText(var_131_14.content)

				arg_128_1.text_.text = var_131_15

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_16 = 8
				local var_131_17 = utf8.len(var_131_15)
				local var_131_18 = var_131_16 <= 0 and var_131_12 or var_131_12 * (var_131_17 / var_131_16)

				if var_131_18 > 0 and var_131_12 < var_131_18 then
					arg_128_1.talkMaxDuration = var_131_18

					if var_131_18 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_18 + var_131_11
					end
				end

				arg_128_1.text_.text = var_131_15
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831031", "story_v_out_319831.awb") ~= 0 then
					local var_131_19 = manager.audio:GetVoiceLength("story_v_out_319831", "319831031", "story_v_out_319831.awb") / 1000

					if var_131_19 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_11
					end

					if var_131_14.prefab_name ~= "" and arg_128_1.actors_[var_131_14.prefab_name] ~= nil then
						local var_131_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_14.prefab_name].transform, "story_v_out_319831", "319831031", "story_v_out_319831.awb")

						arg_128_1:RecordAudio("319831031", var_131_20)
						arg_128_1:RecordAudio("319831031", var_131_20)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_319831", "319831031", "story_v_out_319831.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_319831", "319831031", "story_v_out_319831.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_21 = math.max(var_131_12, arg_128_1.talkMaxDuration)

			if var_131_11 <= arg_128_1.time_ and arg_128_1.time_ < var_131_11 + var_131_21 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_11) / var_131_21

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_11 + var_131_21 and arg_128_1.time_ < var_131_11 + var_131_21 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play319831032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 319831032
		arg_132_1.duration_ = 8.23

		local var_132_0 = {
			zh = 5.133,
			ja = 8.233
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play319831033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1084ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1084ui_story == nil then
				arg_132_1.var_.characterEffect1084ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1084ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1084ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1084ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1084ui_story.fillRatio = var_135_5
			end

			local var_135_6 = arg_132_1.actors_["4040ui_story"]
			local var_135_7 = 0

			if var_135_7 < arg_132_1.time_ and arg_132_1.time_ <= var_135_7 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect4040ui_story == nil then
				arg_132_1.var_.characterEffect4040ui_story = var_135_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_8 = 0.200000002980232

			if var_135_7 <= arg_132_1.time_ and arg_132_1.time_ < var_135_7 + var_135_8 and not isNil(var_135_6) then
				local var_135_9 = (arg_132_1.time_ - var_135_7) / var_135_8

				if arg_132_1.var_.characterEffect4040ui_story and not isNil(var_135_6) then
					arg_132_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_7 + var_135_8 and arg_132_1.time_ < var_135_7 + var_135_8 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect4040ui_story then
				arg_132_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_135_10 = 0
			local var_135_11 = 0.65

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_12 = arg_132_1:FormatText(StoryNameCfg[668].name)

				arg_132_1.leftNameTxt_.text = var_135_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_13 = arg_132_1:GetWordFromCfg(319831032)
				local var_135_14 = arg_132_1:FormatText(var_135_13.content)

				arg_132_1.text_.text = var_135_14

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_15 = 26
				local var_135_16 = utf8.len(var_135_14)
				local var_135_17 = var_135_15 <= 0 and var_135_11 or var_135_11 * (var_135_16 / var_135_15)

				if var_135_17 > 0 and var_135_11 < var_135_17 then
					arg_132_1.talkMaxDuration = var_135_17

					if var_135_17 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_17 + var_135_10
					end
				end

				arg_132_1.text_.text = var_135_14
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831032", "story_v_out_319831.awb") ~= 0 then
					local var_135_18 = manager.audio:GetVoiceLength("story_v_out_319831", "319831032", "story_v_out_319831.awb") / 1000

					if var_135_18 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_18 + var_135_10
					end

					if var_135_13.prefab_name ~= "" and arg_132_1.actors_[var_135_13.prefab_name] ~= nil then
						local var_135_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_13.prefab_name].transform, "story_v_out_319831", "319831032", "story_v_out_319831.awb")

						arg_132_1:RecordAudio("319831032", var_135_19)
						arg_132_1:RecordAudio("319831032", var_135_19)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_319831", "319831032", "story_v_out_319831.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_319831", "319831032", "story_v_out_319831.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_20 = math.max(var_135_11, arg_132_1.talkMaxDuration)

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_20 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_10) / var_135_20

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_10 + var_135_20 and arg_132_1.time_ < var_135_10 + var_135_20 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play319831033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 319831033
		arg_136_1.duration_ = 2

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play319831034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1084ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos1084ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0.7, -0.97, -6)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1084ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = arg_136_1.actors_["1084ui_story"]
			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1084ui_story == nil then
				arg_136_1.var_.characterEffect1084ui_story = var_139_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_11 = 0.200000002980232

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_11 and not isNil(var_139_9) then
				local var_139_12 = (arg_136_1.time_ - var_139_10) / var_139_11

				if arg_136_1.var_.characterEffect1084ui_story and not isNil(var_139_9) then
					arg_136_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_10 + var_139_11 and arg_136_1.time_ < var_139_10 + var_139_11 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1084ui_story then
				arg_136_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_139_13 = arg_136_1.actors_["4040ui_story"]
			local var_139_14 = 0

			if var_139_14 < arg_136_1.time_ and arg_136_1.time_ <= var_139_14 + arg_139_0 and not isNil(var_139_13) and arg_136_1.var_.characterEffect4040ui_story == nil then
				arg_136_1.var_.characterEffect4040ui_story = var_139_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_15 = 0.200000002980232

			if var_139_14 <= arg_136_1.time_ and arg_136_1.time_ < var_139_14 + var_139_15 and not isNil(var_139_13) then
				local var_139_16 = (arg_136_1.time_ - var_139_14) / var_139_15

				if arg_136_1.var_.characterEffect4040ui_story and not isNil(var_139_13) then
					local var_139_17 = Mathf.Lerp(0, 0.5, var_139_16)

					arg_136_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_136_1.var_.characterEffect4040ui_story.fillRatio = var_139_17
				end
			end

			if arg_136_1.time_ >= var_139_14 + var_139_15 and arg_136_1.time_ < var_139_14 + var_139_15 + arg_139_0 and not isNil(var_139_13) and arg_136_1.var_.characterEffect4040ui_story then
				local var_139_18 = 0.5

				arg_136_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_136_1.var_.characterEffect4040ui_story.fillRatio = var_139_18
			end

			local var_139_19 = 0

			if var_139_19 < arg_136_1.time_ and arg_136_1.time_ <= var_139_19 + arg_139_0 then
				arg_136_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4135")
			end

			local var_139_20 = 0

			if var_139_20 < arg_136_1.time_ and arg_136_1.time_ <= var_139_20 + arg_139_0 then
				arg_136_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_139_21 = 0
			local var_139_22 = 0.1

			if var_139_21 < arg_136_1.time_ and arg_136_1.time_ <= var_139_21 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_23 = arg_136_1:FormatText(StoryNameCfg[6].name)

				arg_136_1.leftNameTxt_.text = var_139_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_24 = arg_136_1:GetWordFromCfg(319831033)
				local var_139_25 = arg_136_1:FormatText(var_139_24.content)

				arg_136_1.text_.text = var_139_25

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_26 = 4
				local var_139_27 = utf8.len(var_139_25)
				local var_139_28 = var_139_26 <= 0 and var_139_22 or var_139_22 * (var_139_27 / var_139_26)

				if var_139_28 > 0 and var_139_22 < var_139_28 then
					arg_136_1.talkMaxDuration = var_139_28

					if var_139_28 + var_139_21 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_28 + var_139_21
					end
				end

				arg_136_1.text_.text = var_139_25
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831033", "story_v_out_319831.awb") ~= 0 then
					local var_139_29 = manager.audio:GetVoiceLength("story_v_out_319831", "319831033", "story_v_out_319831.awb") / 1000

					if var_139_29 + var_139_21 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_29 + var_139_21
					end

					if var_139_24.prefab_name ~= "" and arg_136_1.actors_[var_139_24.prefab_name] ~= nil then
						local var_139_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_24.prefab_name].transform, "story_v_out_319831", "319831033", "story_v_out_319831.awb")

						arg_136_1:RecordAudio("319831033", var_139_30)
						arg_136_1:RecordAudio("319831033", var_139_30)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_319831", "319831033", "story_v_out_319831.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_319831", "319831033", "story_v_out_319831.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_31 = math.max(var_139_22, arg_136_1.talkMaxDuration)

			if var_139_21 <= arg_136_1.time_ and arg_136_1.time_ < var_139_21 + var_139_31 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_21) / var_139_31

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_21 + var_139_31 and arg_136_1.time_ < var_139_21 + var_139_31 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play319831034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319831034
		arg_140_1.duration_ = 6

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play319831035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = "STblack"

			if arg_140_1.bgs_[var_143_0] == nil then
				local var_143_1 = Object.Instantiate(arg_140_1.paintGo_)

				var_143_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_143_0)
				var_143_1.name = var_143_0
				var_143_1.transform.parent = arg_140_1.stage_.transform
				var_143_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.bgs_[var_143_0] = var_143_1
			end

			local var_143_2 = 0

			if var_143_2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				local var_143_3 = manager.ui.mainCamera.transform.localPosition
				local var_143_4 = Vector3.New(0, 0, 10) + Vector3.New(var_143_3.x, var_143_3.y, 0)
				local var_143_5 = arg_140_1.bgs_.STblack

				var_143_5.transform.localPosition = var_143_4
				var_143_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_143_6 = var_143_5:GetComponent("SpriteRenderer")

				if var_143_6 and var_143_6.sprite then
					local var_143_7 = (var_143_5.transform.localPosition - var_143_3).z
					local var_143_8 = manager.ui.mainCameraCom_
					local var_143_9 = 2 * var_143_7 * Mathf.Tan(var_143_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_143_10 = var_143_9 * var_143_8.aspect
					local var_143_11 = var_143_6.sprite.bounds.size.x
					local var_143_12 = var_143_6.sprite.bounds.size.y
					local var_143_13 = var_143_10 / var_143_11
					local var_143_14 = var_143_9 / var_143_12
					local var_143_15 = var_143_14 < var_143_13 and var_143_13 or var_143_14

					var_143_5.transform.localScale = Vector3.New(var_143_15, var_143_15, 0)
				end

				for iter_143_0, iter_143_1 in pairs(arg_140_1.bgs_) do
					if iter_143_0 ~= "STblack" then
						iter_143_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.allBtn_.enabled = false
			end

			local var_143_17 = 0.3

			if arg_140_1.time_ >= var_143_16 + var_143_17 and arg_140_1.time_ < var_143_16 + var_143_17 + arg_143_0 then
				arg_140_1.allBtn_.enabled = true
			end

			local var_143_18 = 0

			if var_143_18 < arg_140_1.time_ and arg_140_1.time_ <= var_143_18 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_19 = 2

			if var_143_18 <= arg_140_1.time_ and arg_140_1.time_ < var_143_18 + var_143_19 then
				local var_143_20 = (arg_140_1.time_ - var_143_18) / var_143_19
				local var_143_21 = Color.New(0, 0, 0)

				var_143_21.a = Mathf.Lerp(1, 0, var_143_20)
				arg_140_1.mask_.color = var_143_21
			end

			if arg_140_1.time_ >= var_143_18 + var_143_19 and arg_140_1.time_ < var_143_18 + var_143_19 + arg_143_0 then
				local var_143_22 = Color.New(0, 0, 0)
				local var_143_23 = 0

				arg_140_1.mask_.enabled = false
				var_143_22.a = var_143_23
				arg_140_1.mask_.color = var_143_22
			end

			local var_143_24 = arg_140_1.actors_["1084ui_story"].transform
			local var_143_25 = 0

			if var_143_25 < arg_140_1.time_ and arg_140_1.time_ <= var_143_25 + arg_143_0 then
				arg_140_1.var_.moveOldPos1084ui_story = var_143_24.localPosition
			end

			local var_143_26 = 0.001

			if var_143_25 <= arg_140_1.time_ and arg_140_1.time_ < var_143_25 + var_143_26 then
				local var_143_27 = (arg_140_1.time_ - var_143_25) / var_143_26
				local var_143_28 = Vector3.New(0, 100, 0)

				var_143_24.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1084ui_story, var_143_28, var_143_27)

				local var_143_29 = manager.ui.mainCamera.transform.position - var_143_24.position

				var_143_24.forward = Vector3.New(var_143_29.x, var_143_29.y, var_143_29.z)

				local var_143_30 = var_143_24.localEulerAngles

				var_143_30.z = 0
				var_143_30.x = 0
				var_143_24.localEulerAngles = var_143_30
			end

			if arg_140_1.time_ >= var_143_25 + var_143_26 and arg_140_1.time_ < var_143_25 + var_143_26 + arg_143_0 then
				var_143_24.localPosition = Vector3.New(0, 100, 0)

				local var_143_31 = manager.ui.mainCamera.transform.position - var_143_24.position

				var_143_24.forward = Vector3.New(var_143_31.x, var_143_31.y, var_143_31.z)

				local var_143_32 = var_143_24.localEulerAngles

				var_143_32.z = 0
				var_143_32.x = 0
				var_143_24.localEulerAngles = var_143_32
			end

			local var_143_33 = arg_140_1.actors_["1084ui_story"]
			local var_143_34 = 0

			if var_143_34 < arg_140_1.time_ and arg_140_1.time_ <= var_143_34 + arg_143_0 and not isNil(var_143_33) and arg_140_1.var_.characterEffect1084ui_story == nil then
				arg_140_1.var_.characterEffect1084ui_story = var_143_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_35 = 0.200000002980232

			if var_143_34 <= arg_140_1.time_ and arg_140_1.time_ < var_143_34 + var_143_35 and not isNil(var_143_33) then
				local var_143_36 = (arg_140_1.time_ - var_143_34) / var_143_35

				if arg_140_1.var_.characterEffect1084ui_story and not isNil(var_143_33) then
					local var_143_37 = Mathf.Lerp(0, 0.5, var_143_36)

					arg_140_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1084ui_story.fillRatio = var_143_37
				end
			end

			if arg_140_1.time_ >= var_143_34 + var_143_35 and arg_140_1.time_ < var_143_34 + var_143_35 + arg_143_0 and not isNil(var_143_33) and arg_140_1.var_.characterEffect1084ui_story then
				local var_143_38 = 0.5

				arg_140_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1084ui_story.fillRatio = var_143_38
			end

			local var_143_39 = arg_140_1.actors_["4040ui_story"].transform
			local var_143_40 = 0

			if var_143_40 < arg_140_1.time_ and arg_140_1.time_ <= var_143_40 + arg_143_0 then
				arg_140_1.var_.moveOldPos4040ui_story = var_143_39.localPosition
			end

			local var_143_41 = 0.001

			if var_143_40 <= arg_140_1.time_ and arg_140_1.time_ < var_143_40 + var_143_41 then
				local var_143_42 = (arg_140_1.time_ - var_143_40) / var_143_41
				local var_143_43 = Vector3.New(0, 100, 0)

				var_143_39.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos4040ui_story, var_143_43, var_143_42)

				local var_143_44 = manager.ui.mainCamera.transform.position - var_143_39.position

				var_143_39.forward = Vector3.New(var_143_44.x, var_143_44.y, var_143_44.z)

				local var_143_45 = var_143_39.localEulerAngles

				var_143_45.z = 0
				var_143_45.x = 0
				var_143_39.localEulerAngles = var_143_45
			end

			if arg_140_1.time_ >= var_143_40 + var_143_41 and arg_140_1.time_ < var_143_40 + var_143_41 + arg_143_0 then
				var_143_39.localPosition = Vector3.New(0, 100, 0)

				local var_143_46 = manager.ui.mainCamera.transform.position - var_143_39.position

				var_143_39.forward = Vector3.New(var_143_46.x, var_143_46.y, var_143_46.z)

				local var_143_47 = var_143_39.localEulerAngles

				var_143_47.z = 0
				var_143_47.x = 0
				var_143_39.localEulerAngles = var_143_47
			end

			local var_143_48 = arg_140_1.actors_["4040ui_story"]
			local var_143_49 = 0

			if var_143_49 < arg_140_1.time_ and arg_140_1.time_ <= var_143_49 + arg_143_0 and not isNil(var_143_48) and arg_140_1.var_.characterEffect4040ui_story == nil then
				arg_140_1.var_.characterEffect4040ui_story = var_143_48:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_50 = 0.200000002980232

			if var_143_49 <= arg_140_1.time_ and arg_140_1.time_ < var_143_49 + var_143_50 and not isNil(var_143_48) then
				local var_143_51 = (arg_140_1.time_ - var_143_49) / var_143_50

				if arg_140_1.var_.characterEffect4040ui_story and not isNil(var_143_48) then
					local var_143_52 = Mathf.Lerp(0, 0.5, var_143_51)

					arg_140_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_140_1.var_.characterEffect4040ui_story.fillRatio = var_143_52
				end
			end

			if arg_140_1.time_ >= var_143_49 + var_143_50 and arg_140_1.time_ < var_143_49 + var_143_50 + arg_143_0 and not isNil(var_143_48) and arg_140_1.var_.characterEffect4040ui_story then
				local var_143_53 = 0.5

				arg_140_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_140_1.var_.characterEffect4040ui_story.fillRatio = var_143_53
			end

			if arg_140_1.frameCnt_ <= 1 then
				arg_140_1.dialog_:SetActive(false)
			end

			local var_143_54 = 1
			local var_143_55 = 0.175

			if var_143_54 < arg_140_1.time_ and arg_140_1.time_ <= var_143_54 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0

				arg_140_1.dialog_:SetActive(true)

				arg_140_1.dialogCg_.alpha = 0

				local var_143_56 = LeanTween.value(arg_140_1.dialog_, 0, 1, 0.3)

				var_143_56:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_140_1.dialogCg_.alpha = arg_144_0
				end))
				var_143_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_140_1.dialog_)
					var_143_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_140_1.duration_ = arg_140_1.duration_ + 0.3

				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_57 = arg_140_1:GetWordFromCfg(319831034)
				local var_143_58 = arg_140_1:FormatText(var_143_57.content)

				arg_140_1.text_.text = var_143_58

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_59 = 7
				local var_143_60 = utf8.len(var_143_58)
				local var_143_61 = var_143_59 <= 0 and var_143_55 or var_143_55 * (var_143_60 / var_143_59)

				if var_143_61 > 0 and var_143_55 < var_143_61 then
					arg_140_1.talkMaxDuration = var_143_61
					var_143_54 = var_143_54 + 0.3

					if var_143_61 + var_143_54 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_61 + var_143_54
					end
				end

				arg_140_1.text_.text = var_143_58
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_62 = var_143_54 + 0.3
			local var_143_63 = math.max(var_143_55, arg_140_1.talkMaxDuration)

			if var_143_62 <= arg_140_1.time_ and arg_140_1.time_ < var_143_62 + var_143_63 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_62) / var_143_63

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_62 + var_143_63 and arg_140_1.time_ < var_143_62 + var_143_63 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play319831035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 319831035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play319831036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0
			local var_149_1 = 1.05

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_2 = arg_146_1:GetWordFromCfg(319831035)
				local var_149_3 = arg_146_1:FormatText(var_149_2.content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 42
				local var_149_5 = utf8.len(var_149_3)
				local var_149_6 = var_149_4 <= 0 and var_149_1 or var_149_1 * (var_149_5 / var_149_4)

				if var_149_6 > 0 and var_149_1 < var_149_6 then
					arg_146_1.talkMaxDuration = var_149_6

					if var_149_6 + var_149_0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_6 + var_149_0
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_1, arg_146_1.talkMaxDuration)

			if var_149_0 <= arg_146_1.time_ and arg_146_1.time_ < var_149_0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_0 + var_149_7 and arg_146_1.time_ < var_149_0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play319831036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 319831036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play319831037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 1.225

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_2 = arg_150_1:GetWordFromCfg(319831036)
				local var_153_3 = arg_150_1:FormatText(var_153_2.content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 49
				local var_153_5 = utf8.len(var_153_3)
				local var_153_6 = var_153_4 <= 0 and var_153_1 or var_153_1 * (var_153_5 / var_153_4)

				if var_153_6 > 0 and var_153_1 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_7 and arg_150_1.time_ < var_153_0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play319831037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 319831037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play319831038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0
			local var_157_1 = 1.325

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_2 = arg_154_1:GetWordFromCfg(319831037)
				local var_157_3 = arg_154_1:FormatText(var_157_2.content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 53
				local var_157_5 = utf8.len(var_157_3)
				local var_157_6 = var_157_4 <= 0 and var_157_1 or var_157_1 * (var_157_5 / var_157_4)

				if var_157_6 > 0 and var_157_1 < var_157_6 then
					arg_154_1.talkMaxDuration = var_157_6

					if var_157_6 + var_157_0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_6 + var_157_0
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_1, arg_154_1.talkMaxDuration)

			if var_157_0 <= arg_154_1.time_ and arg_154_1.time_ < var_157_0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_0 + var_157_7 and arg_154_1.time_ < var_157_0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play319831038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 319831038
		arg_158_1.duration_ = 6.2

		local var_158_0 = {
			zh = 4.866,
			ja = 6.2
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play319831039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				local var_161_1 = manager.ui.mainCamera.transform.localPosition
				local var_161_2 = Vector3.New(0, 0, 10) + Vector3.New(var_161_1.x, var_161_1.y, 0)
				local var_161_3 = arg_158_1.bgs_.D02a

				var_161_3.transform.localPosition = var_161_2
				var_161_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_161_4 = var_161_3:GetComponent("SpriteRenderer")

				if var_161_4 and var_161_4.sprite then
					local var_161_5 = (var_161_3.transform.localPosition - var_161_1).z
					local var_161_6 = manager.ui.mainCameraCom_
					local var_161_7 = 2 * var_161_5 * Mathf.Tan(var_161_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_161_8 = var_161_7 * var_161_6.aspect
					local var_161_9 = var_161_4.sprite.bounds.size.x
					local var_161_10 = var_161_4.sprite.bounds.size.y
					local var_161_11 = var_161_8 / var_161_9
					local var_161_12 = var_161_7 / var_161_10
					local var_161_13 = var_161_12 < var_161_11 and var_161_11 or var_161_12

					var_161_3.transform.localScale = Vector3.New(var_161_13, var_161_13, 0)
				end

				for iter_161_0, iter_161_1 in pairs(arg_158_1.bgs_) do
					if iter_161_0 ~= "D02a" then
						iter_161_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_161_14 = 0

			if var_161_14 < arg_158_1.time_ and arg_158_1.time_ <= var_161_14 + arg_161_0 then
				arg_158_1.allBtn_.enabled = false
			end

			local var_161_15 = 0.3

			if arg_158_1.time_ >= var_161_14 + var_161_15 and arg_158_1.time_ < var_161_14 + var_161_15 + arg_161_0 then
				arg_158_1.allBtn_.enabled = true
			end

			local var_161_16 = 0

			if var_161_16 < arg_158_1.time_ and arg_158_1.time_ <= var_161_16 + arg_161_0 then
				arg_158_1.mask_.enabled = true
				arg_158_1.mask_.raycastTarget = true

				arg_158_1:SetGaussion(false)
			end

			local var_161_17 = 2

			if var_161_16 <= arg_158_1.time_ and arg_158_1.time_ < var_161_16 + var_161_17 then
				local var_161_18 = (arg_158_1.time_ - var_161_16) / var_161_17
				local var_161_19 = Color.New(0, 0, 0)

				var_161_19.a = Mathf.Lerp(1, 0, var_161_18)
				arg_158_1.mask_.color = var_161_19
			end

			if arg_158_1.time_ >= var_161_16 + var_161_17 and arg_158_1.time_ < var_161_16 + var_161_17 + arg_161_0 then
				local var_161_20 = Color.New(0, 0, 0)
				local var_161_21 = 0

				arg_158_1.mask_.enabled = false
				var_161_20.a = var_161_21
				arg_158_1.mask_.color = var_161_20
			end

			local var_161_22 = arg_158_1.actors_["1084ui_story"].transform
			local var_161_23 = 1.9

			if var_161_23 < arg_158_1.time_ and arg_158_1.time_ <= var_161_23 + arg_161_0 then
				arg_158_1.var_.moveOldPos1084ui_story = var_161_22.localPosition

				local var_161_24 = "1084ui_story"

				arg_158_1:ShowWeapon(arg_158_1.var_[var_161_24 .. "Animator"].transform, false)
			end

			local var_161_25 = 0.001

			if var_161_23 <= arg_158_1.time_ and arg_158_1.time_ < var_161_23 + var_161_25 then
				local var_161_26 = (arg_158_1.time_ - var_161_23) / var_161_25
				local var_161_27 = Vector3.New(0.7, -0.97, -6)

				var_161_22.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1084ui_story, var_161_27, var_161_26)

				local var_161_28 = manager.ui.mainCamera.transform.position - var_161_22.position

				var_161_22.forward = Vector3.New(var_161_28.x, var_161_28.y, var_161_28.z)

				local var_161_29 = var_161_22.localEulerAngles

				var_161_29.z = 0
				var_161_29.x = 0
				var_161_22.localEulerAngles = var_161_29
			end

			if arg_158_1.time_ >= var_161_23 + var_161_25 and arg_158_1.time_ < var_161_23 + var_161_25 + arg_161_0 then
				var_161_22.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_161_30 = manager.ui.mainCamera.transform.position - var_161_22.position

				var_161_22.forward = Vector3.New(var_161_30.x, var_161_30.y, var_161_30.z)

				local var_161_31 = var_161_22.localEulerAngles

				var_161_31.z = 0
				var_161_31.x = 0
				var_161_22.localEulerAngles = var_161_31
			end

			local var_161_32 = arg_158_1.actors_["1084ui_story"]
			local var_161_33 = 1.9

			if var_161_33 < arg_158_1.time_ and arg_158_1.time_ <= var_161_33 + arg_161_0 and not isNil(var_161_32) and arg_158_1.var_.characterEffect1084ui_story == nil then
				arg_158_1.var_.characterEffect1084ui_story = var_161_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_34 = 0.200000002980232

			if var_161_33 <= arg_158_1.time_ and arg_158_1.time_ < var_161_33 + var_161_34 and not isNil(var_161_32) then
				local var_161_35 = (arg_158_1.time_ - var_161_33) / var_161_34

				if arg_158_1.var_.characterEffect1084ui_story and not isNil(var_161_32) then
					arg_158_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_33 + var_161_34 and arg_158_1.time_ < var_161_33 + var_161_34 + arg_161_0 and not isNil(var_161_32) and arg_158_1.var_.characterEffect1084ui_story then
				arg_158_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_161_36 = 1.9

			if var_161_36 < arg_158_1.time_ and arg_158_1.time_ <= var_161_36 + arg_161_0 then
				arg_158_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			if arg_158_1.frameCnt_ <= 1 then
				arg_158_1.dialog_:SetActive(false)
			end

			local var_161_37 = 2
			local var_161_38 = 0.25

			if var_161_37 < arg_158_1.time_ and arg_158_1.time_ <= var_161_37 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0

				arg_158_1.dialog_:SetActive(true)

				arg_158_1.dialogCg_.alpha = 0

				local var_161_39 = LeanTween.value(arg_158_1.dialog_, 0, 1, 0.3)

				var_161_39:setOnUpdate(LuaHelper.FloatAction(function(arg_162_0)
					arg_158_1.dialogCg_.alpha = arg_162_0
				end))
				var_161_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_158_1.dialog_)
					var_161_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_158_1.duration_ = arg_158_1.duration_ + 0.3

				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_40 = arg_158_1:FormatText(StoryNameCfg[6].name)

				arg_158_1.leftNameTxt_.text = var_161_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_41 = arg_158_1:GetWordFromCfg(319831038)
				local var_161_42 = arg_158_1:FormatText(var_161_41.content)

				arg_158_1.text_.text = var_161_42

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_43 = 10
				local var_161_44 = utf8.len(var_161_42)
				local var_161_45 = var_161_43 <= 0 and var_161_38 or var_161_38 * (var_161_44 / var_161_43)

				if var_161_45 > 0 and var_161_38 < var_161_45 then
					arg_158_1.talkMaxDuration = var_161_45
					var_161_37 = var_161_37 + 0.3

					if var_161_45 + var_161_37 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_45 + var_161_37
					end
				end

				arg_158_1.text_.text = var_161_42
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831038", "story_v_out_319831.awb") ~= 0 then
					local var_161_46 = manager.audio:GetVoiceLength("story_v_out_319831", "319831038", "story_v_out_319831.awb") / 1000

					if var_161_46 + var_161_37 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_46 + var_161_37
					end

					if var_161_41.prefab_name ~= "" and arg_158_1.actors_[var_161_41.prefab_name] ~= nil then
						local var_161_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_41.prefab_name].transform, "story_v_out_319831", "319831038", "story_v_out_319831.awb")

						arg_158_1:RecordAudio("319831038", var_161_47)
						arg_158_1:RecordAudio("319831038", var_161_47)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_319831", "319831038", "story_v_out_319831.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_319831", "319831038", "story_v_out_319831.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_48 = var_161_37 + 0.3
			local var_161_49 = math.max(var_161_38, arg_158_1.talkMaxDuration)

			if var_161_48 <= arg_158_1.time_ and arg_158_1.time_ < var_161_48 + var_161_49 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_48) / var_161_49

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_48 + var_161_49 and arg_158_1.time_ < var_161_48 + var_161_49 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play319831039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319831039
		arg_164_1.duration_ = 3.13

		local var_164_0 = {
			zh = 3.133,
			ja = 1.999999999999
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
				arg_164_0:Play319831040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["4040ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos4040ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(-0.7, -1.55, -5.5)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos4040ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(-0.7, -1.55, -5.5)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["4040ui_story"]
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect4040ui_story == nil then
				arg_164_1.var_.characterEffect4040ui_story = var_167_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_11 = 0.200000002980232

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 and not isNil(var_167_9) then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11

				if arg_164_1.var_.characterEffect4040ui_story and not isNil(var_167_9) then
					arg_164_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect4040ui_story then
				arg_164_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_167_13 = 0

			if var_167_13 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_167_14 = 0

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_167_15 = arg_164_1.actors_["1084ui_story"].transform
			local var_167_16 = 0

			if var_167_16 < arg_164_1.time_ and arg_164_1.time_ <= var_167_16 + arg_167_0 then
				arg_164_1.var_.moveOldPos1084ui_story = var_167_15.localPosition
			end

			local var_167_17 = 0.001

			if var_167_16 <= arg_164_1.time_ and arg_164_1.time_ < var_167_16 + var_167_17 then
				local var_167_18 = (arg_164_1.time_ - var_167_16) / var_167_17
				local var_167_19 = Vector3.New(0.7, -0.97, -6)

				var_167_15.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1084ui_story, var_167_19, var_167_18)

				local var_167_20 = manager.ui.mainCamera.transform.position - var_167_15.position

				var_167_15.forward = Vector3.New(var_167_20.x, var_167_20.y, var_167_20.z)

				local var_167_21 = var_167_15.localEulerAngles

				var_167_21.z = 0
				var_167_21.x = 0
				var_167_15.localEulerAngles = var_167_21
			end

			if arg_164_1.time_ >= var_167_16 + var_167_17 and arg_164_1.time_ < var_167_16 + var_167_17 + arg_167_0 then
				var_167_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_167_22 = manager.ui.mainCamera.transform.position - var_167_15.position

				var_167_15.forward = Vector3.New(var_167_22.x, var_167_22.y, var_167_22.z)

				local var_167_23 = var_167_15.localEulerAngles

				var_167_23.z = 0
				var_167_23.x = 0
				var_167_15.localEulerAngles = var_167_23
			end

			local var_167_24 = arg_164_1.actors_["1084ui_story"]
			local var_167_25 = 0

			if var_167_25 < arg_164_1.time_ and arg_164_1.time_ <= var_167_25 + arg_167_0 and not isNil(var_167_24) and arg_164_1.var_.characterEffect1084ui_story == nil then
				arg_164_1.var_.characterEffect1084ui_story = var_167_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_26 = 0.200000002980232

			if var_167_25 <= arg_164_1.time_ and arg_164_1.time_ < var_167_25 + var_167_26 and not isNil(var_167_24) then
				local var_167_27 = (arg_164_1.time_ - var_167_25) / var_167_26

				if arg_164_1.var_.characterEffect1084ui_story and not isNil(var_167_24) then
					local var_167_28 = Mathf.Lerp(0, 0.5, var_167_27)

					arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1084ui_story.fillRatio = var_167_28
				end
			end

			if arg_164_1.time_ >= var_167_25 + var_167_26 and arg_164_1.time_ < var_167_25 + var_167_26 + arg_167_0 and not isNil(var_167_24) and arg_164_1.var_.characterEffect1084ui_story then
				local var_167_29 = 0.5

				arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1084ui_story.fillRatio = var_167_29
			end

			local var_167_30 = 0
			local var_167_31 = 0.4

			if var_167_30 < arg_164_1.time_ and arg_164_1.time_ <= var_167_30 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_32 = arg_164_1:FormatText(StoryNameCfg[668].name)

				arg_164_1.leftNameTxt_.text = var_167_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_33 = arg_164_1:GetWordFromCfg(319831039)
				local var_167_34 = arg_164_1:FormatText(var_167_33.content)

				arg_164_1.text_.text = var_167_34

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_35 = 16
				local var_167_36 = utf8.len(var_167_34)
				local var_167_37 = var_167_35 <= 0 and var_167_31 or var_167_31 * (var_167_36 / var_167_35)

				if var_167_37 > 0 and var_167_31 < var_167_37 then
					arg_164_1.talkMaxDuration = var_167_37

					if var_167_37 + var_167_30 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_37 + var_167_30
					end
				end

				arg_164_1.text_.text = var_167_34
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831039", "story_v_out_319831.awb") ~= 0 then
					local var_167_38 = manager.audio:GetVoiceLength("story_v_out_319831", "319831039", "story_v_out_319831.awb") / 1000

					if var_167_38 + var_167_30 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_38 + var_167_30
					end

					if var_167_33.prefab_name ~= "" and arg_164_1.actors_[var_167_33.prefab_name] ~= nil then
						local var_167_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_33.prefab_name].transform, "story_v_out_319831", "319831039", "story_v_out_319831.awb")

						arg_164_1:RecordAudio("319831039", var_167_39)
						arg_164_1:RecordAudio("319831039", var_167_39)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_319831", "319831039", "story_v_out_319831.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_319831", "319831039", "story_v_out_319831.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_40 = math.max(var_167_31, arg_164_1.talkMaxDuration)

			if var_167_30 <= arg_164_1.time_ and arg_164_1.time_ < var_167_30 + var_167_40 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_30) / var_167_40

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_30 + var_167_40 and arg_164_1.time_ < var_167_30 + var_167_40 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_164_1:InitPlayNodeList()
	end,
	Play319831040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 319831040
		arg_168_1.duration_ = 3

		local var_168_0 = {
			zh = 1.533,
			ja = 3
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
				arg_168_0:Play319831041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["4040ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect4040ui_story == nil then
				arg_168_1.var_.characterEffect4040ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect4040ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_168_1.var_.characterEffect4040ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect4040ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_168_1.var_.characterEffect4040ui_story.fillRatio = var_171_5
			end

			local var_171_6 = arg_168_1.actors_["1084ui_story"]
			local var_171_7 = 0

			if var_171_7 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect1084ui_story == nil then
				arg_168_1.var_.characterEffect1084ui_story = var_171_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_8 = 0.200000002980232

			if var_171_7 <= arg_168_1.time_ and arg_168_1.time_ < var_171_7 + var_171_8 and not isNil(var_171_6) then
				local var_171_9 = (arg_168_1.time_ - var_171_7) / var_171_8

				if arg_168_1.var_.characterEffect1084ui_story and not isNil(var_171_6) then
					arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_7 + var_171_8 and arg_168_1.time_ < var_171_7 + var_171_8 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect1084ui_story then
				arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_171_10 = 0
			local var_171_11 = 0.15

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_12 = arg_168_1:FormatText(StoryNameCfg[6].name)

				arg_168_1.leftNameTxt_.text = var_171_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_13 = arg_168_1:GetWordFromCfg(319831040)
				local var_171_14 = arg_168_1:FormatText(var_171_13.content)

				arg_168_1.text_.text = var_171_14

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_15 = 6
				local var_171_16 = utf8.len(var_171_14)
				local var_171_17 = var_171_15 <= 0 and var_171_11 or var_171_11 * (var_171_16 / var_171_15)

				if var_171_17 > 0 and var_171_11 < var_171_17 then
					arg_168_1.talkMaxDuration = var_171_17

					if var_171_17 + var_171_10 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_17 + var_171_10
					end
				end

				arg_168_1.text_.text = var_171_14
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831040", "story_v_out_319831.awb") ~= 0 then
					local var_171_18 = manager.audio:GetVoiceLength("story_v_out_319831", "319831040", "story_v_out_319831.awb") / 1000

					if var_171_18 + var_171_10 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_18 + var_171_10
					end

					if var_171_13.prefab_name ~= "" and arg_168_1.actors_[var_171_13.prefab_name] ~= nil then
						local var_171_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_13.prefab_name].transform, "story_v_out_319831", "319831040", "story_v_out_319831.awb")

						arg_168_1:RecordAudio("319831040", var_171_19)
						arg_168_1:RecordAudio("319831040", var_171_19)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_319831", "319831040", "story_v_out_319831.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_319831", "319831040", "story_v_out_319831.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_20 = math.max(var_171_11, arg_168_1.talkMaxDuration)

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_20 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_10) / var_171_20

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_10 + var_171_20 and arg_168_1.time_ < var_171_10 + var_171_20 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play319831041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 319831041
		arg_172_1.duration_ = 6.13

		local var_172_0 = {
			zh = 6.133,
			ja = 5.733
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
				arg_172_0:Play319831042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_175_2 = arg_172_1.actors_["4040ui_story"]
			local var_175_3 = 0

			if var_175_3 < arg_172_1.time_ and arg_172_1.time_ <= var_175_3 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.characterEffect4040ui_story == nil then
				arg_172_1.var_.characterEffect4040ui_story = var_175_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_4 = 0.200000002980232

			if var_175_3 <= arg_172_1.time_ and arg_172_1.time_ < var_175_3 + var_175_4 and not isNil(var_175_2) then
				local var_175_5 = (arg_172_1.time_ - var_175_3) / var_175_4

				if arg_172_1.var_.characterEffect4040ui_story and not isNil(var_175_2) then
					arg_172_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_3 + var_175_4 and arg_172_1.time_ < var_175_3 + var_175_4 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.characterEffect4040ui_story then
				arg_172_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_175_6 = arg_172_1.actors_["1084ui_story"]
			local var_175_7 = 0

			if var_175_7 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 and not isNil(var_175_6) and arg_172_1.var_.characterEffect1084ui_story == nil then
				arg_172_1.var_.characterEffect1084ui_story = var_175_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_8 = 0.200000002980232

			if var_175_7 <= arg_172_1.time_ and arg_172_1.time_ < var_175_7 + var_175_8 and not isNil(var_175_6) then
				local var_175_9 = (arg_172_1.time_ - var_175_7) / var_175_8

				if arg_172_1.var_.characterEffect1084ui_story and not isNil(var_175_6) then
					local var_175_10 = Mathf.Lerp(0, 0.5, var_175_9)

					arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1084ui_story.fillRatio = var_175_10
				end
			end

			if arg_172_1.time_ >= var_175_7 + var_175_8 and arg_172_1.time_ < var_175_7 + var_175_8 + arg_175_0 and not isNil(var_175_6) and arg_172_1.var_.characterEffect1084ui_story then
				local var_175_11 = 0.5

				arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1084ui_story.fillRatio = var_175_11
			end

			local var_175_12 = 0
			local var_175_13 = 0.6

			if var_175_12 < arg_172_1.time_ and arg_172_1.time_ <= var_175_12 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_14 = arg_172_1:FormatText(StoryNameCfg[668].name)

				arg_172_1.leftNameTxt_.text = var_175_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_15 = arg_172_1:GetWordFromCfg(319831041)
				local var_175_16 = arg_172_1:FormatText(var_175_15.content)

				arg_172_1.text_.text = var_175_16

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_17 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831041", "story_v_out_319831.awb") ~= 0 then
					local var_175_20 = manager.audio:GetVoiceLength("story_v_out_319831", "319831041", "story_v_out_319831.awb") / 1000

					if var_175_20 + var_175_12 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_20 + var_175_12
					end

					if var_175_15.prefab_name ~= "" and arg_172_1.actors_[var_175_15.prefab_name] ~= nil then
						local var_175_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_15.prefab_name].transform, "story_v_out_319831", "319831041", "story_v_out_319831.awb")

						arg_172_1:RecordAudio("319831041", var_175_21)
						arg_172_1:RecordAudio("319831041", var_175_21)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_319831", "319831041", "story_v_out_319831.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_319831", "319831041", "story_v_out_319831.awb")
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
	Play319831042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 319831042
		arg_176_1.duration_ = 3.4

		local var_176_0 = {
			zh = 2.333,
			ja = 3.4
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
				arg_176_0:Play319831043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4513")
			end

			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_179_2 = arg_176_1.actors_["4040ui_story"]
			local var_179_3 = 0

			if var_179_3 < arg_176_1.time_ and arg_176_1.time_ <= var_179_3 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.characterEffect4040ui_story == nil then
				arg_176_1.var_.characterEffect4040ui_story = var_179_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_4 = 0.200000002980232

			if var_179_3 <= arg_176_1.time_ and arg_176_1.time_ < var_179_3 + var_179_4 and not isNil(var_179_2) then
				local var_179_5 = (arg_176_1.time_ - var_179_3) / var_179_4

				if arg_176_1.var_.characterEffect4040ui_story and not isNil(var_179_2) then
					local var_179_6 = Mathf.Lerp(0, 0.5, var_179_5)

					arg_176_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_176_1.var_.characterEffect4040ui_story.fillRatio = var_179_6
				end
			end

			if arg_176_1.time_ >= var_179_3 + var_179_4 and arg_176_1.time_ < var_179_3 + var_179_4 + arg_179_0 and not isNil(var_179_2) and arg_176_1.var_.characterEffect4040ui_story then
				local var_179_7 = 0.5

				arg_176_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_176_1.var_.characterEffect4040ui_story.fillRatio = var_179_7
			end

			local var_179_8 = arg_176_1.actors_["1084ui_story"]
			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.characterEffect1084ui_story == nil then
				arg_176_1.var_.characterEffect1084ui_story = var_179_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_10 = 0.200000002980232

			if var_179_9 <= arg_176_1.time_ and arg_176_1.time_ < var_179_9 + var_179_10 and not isNil(var_179_8) then
				local var_179_11 = (arg_176_1.time_ - var_179_9) / var_179_10

				if arg_176_1.var_.characterEffect1084ui_story and not isNil(var_179_8) then
					arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_9 + var_179_10 and arg_176_1.time_ < var_179_9 + var_179_10 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.characterEffect1084ui_story then
				arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_179_12 = 0
			local var_179_13 = 0.35

			if var_179_12 < arg_176_1.time_ and arg_176_1.time_ <= var_179_12 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_14 = arg_176_1:FormatText(StoryNameCfg[6].name)

				arg_176_1.leftNameTxt_.text = var_179_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_15 = arg_176_1:GetWordFromCfg(319831042)
				local var_179_16 = arg_176_1:FormatText(var_179_15.content)

				arg_176_1.text_.text = var_179_16

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_17 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831042", "story_v_out_319831.awb") ~= 0 then
					local var_179_20 = manager.audio:GetVoiceLength("story_v_out_319831", "319831042", "story_v_out_319831.awb") / 1000

					if var_179_20 + var_179_12 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_20 + var_179_12
					end

					if var_179_15.prefab_name ~= "" and arg_176_1.actors_[var_179_15.prefab_name] ~= nil then
						local var_179_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_15.prefab_name].transform, "story_v_out_319831", "319831042", "story_v_out_319831.awb")

						arg_176_1:RecordAudio("319831042", var_179_21)
						arg_176_1:RecordAudio("319831042", var_179_21)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_319831", "319831042", "story_v_out_319831.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_319831", "319831042", "story_v_out_319831.awb")
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
	Play319831043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 319831043
		arg_180_1.duration_ = 5.77

		local var_180_0 = {
			zh = 4.033,
			ja = 5.766
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
				arg_180_0:Play319831044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_183_2 = 0
			local var_183_3 = 0.5

			if var_183_2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_4 = arg_180_1:FormatText(StoryNameCfg[6].name)

				arg_180_1.leftNameTxt_.text = var_183_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_5 = arg_180_1:GetWordFromCfg(319831043)
				local var_183_6 = arg_180_1:FormatText(var_183_5.content)

				arg_180_1.text_.text = var_183_6

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 20
				local var_183_8 = utf8.len(var_183_6)
				local var_183_9 = var_183_7 <= 0 and var_183_3 or var_183_3 * (var_183_8 / var_183_7)

				if var_183_9 > 0 and var_183_3 < var_183_9 then
					arg_180_1.talkMaxDuration = var_183_9

					if var_183_9 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_2
					end
				end

				arg_180_1.text_.text = var_183_6
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831043", "story_v_out_319831.awb") ~= 0 then
					local var_183_10 = manager.audio:GetVoiceLength("story_v_out_319831", "319831043", "story_v_out_319831.awb") / 1000

					if var_183_10 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_2
					end

					if var_183_5.prefab_name ~= "" and arg_180_1.actors_[var_183_5.prefab_name] ~= nil then
						local var_183_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_5.prefab_name].transform, "story_v_out_319831", "319831043", "story_v_out_319831.awb")

						arg_180_1:RecordAudio("319831043", var_183_11)
						arg_180_1:RecordAudio("319831043", var_183_11)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_319831", "319831043", "story_v_out_319831.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_319831", "319831043", "story_v_out_319831.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_12 = math.max(var_183_3, arg_180_1.talkMaxDuration)

			if var_183_2 <= arg_180_1.time_ and arg_180_1.time_ < var_183_2 + var_183_12 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_2) / var_183_12

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_2 + var_183_12 and arg_180_1.time_ < var_183_2 + var_183_12 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play319831044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 319831044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play319831045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1084ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1084ui_story == nil then
				arg_184_1.var_.characterEffect1084ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1084ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1084ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1084ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1084ui_story.fillRatio = var_187_5
			end

			local var_187_6 = arg_184_1.actors_["4040ui_story"].transform
			local var_187_7 = 0

			if var_187_7 < arg_184_1.time_ and arg_184_1.time_ <= var_187_7 + arg_187_0 then
				arg_184_1.var_.moveOldPos4040ui_story = var_187_6.localPosition
			end

			local var_187_8 = 0.001

			if var_187_7 <= arg_184_1.time_ and arg_184_1.time_ < var_187_7 + var_187_8 then
				local var_187_9 = (arg_184_1.time_ - var_187_7) / var_187_8
				local var_187_10 = Vector3.New(0, 100, 0)

				var_187_6.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos4040ui_story, var_187_10, var_187_9)

				local var_187_11 = manager.ui.mainCamera.transform.position - var_187_6.position

				var_187_6.forward = Vector3.New(var_187_11.x, var_187_11.y, var_187_11.z)

				local var_187_12 = var_187_6.localEulerAngles

				var_187_12.z = 0
				var_187_12.x = 0
				var_187_6.localEulerAngles = var_187_12
			end

			if arg_184_1.time_ >= var_187_7 + var_187_8 and arg_184_1.time_ < var_187_7 + var_187_8 + arg_187_0 then
				var_187_6.localPosition = Vector3.New(0, 100, 0)

				local var_187_13 = manager.ui.mainCamera.transform.position - var_187_6.position

				var_187_6.forward = Vector3.New(var_187_13.x, var_187_13.y, var_187_13.z)

				local var_187_14 = var_187_6.localEulerAngles

				var_187_14.z = 0
				var_187_14.x = 0
				var_187_6.localEulerAngles = var_187_14
			end

			local var_187_15 = arg_184_1.actors_["1084ui_story"].transform
			local var_187_16 = 0

			if var_187_16 < arg_184_1.time_ and arg_184_1.time_ <= var_187_16 + arg_187_0 then
				arg_184_1.var_.moveOldPos1084ui_story = var_187_15.localPosition
			end

			local var_187_17 = 0.001

			if var_187_16 <= arg_184_1.time_ and arg_184_1.time_ < var_187_16 + var_187_17 then
				local var_187_18 = (arg_184_1.time_ - var_187_16) / var_187_17
				local var_187_19 = Vector3.New(0, 100, 0)

				var_187_15.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1084ui_story, var_187_19, var_187_18)

				local var_187_20 = manager.ui.mainCamera.transform.position - var_187_15.position

				var_187_15.forward = Vector3.New(var_187_20.x, var_187_20.y, var_187_20.z)

				local var_187_21 = var_187_15.localEulerAngles

				var_187_21.z = 0
				var_187_21.x = 0
				var_187_15.localEulerAngles = var_187_21
			end

			if arg_184_1.time_ >= var_187_16 + var_187_17 and arg_184_1.time_ < var_187_16 + var_187_17 + arg_187_0 then
				var_187_15.localPosition = Vector3.New(0, 100, 0)

				local var_187_22 = manager.ui.mainCamera.transform.position - var_187_15.position

				var_187_15.forward = Vector3.New(var_187_22.x, var_187_22.y, var_187_22.z)

				local var_187_23 = var_187_15.localEulerAngles

				var_187_23.z = 0
				var_187_23.x = 0
				var_187_15.localEulerAngles = var_187_23
			end

			local var_187_24 = 0
			local var_187_25 = 0.9

			if var_187_24 < arg_184_1.time_ and arg_184_1.time_ <= var_187_24 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_26 = arg_184_1:GetWordFromCfg(319831044)
				local var_187_27 = arg_184_1:FormatText(var_187_26.content)

				arg_184_1.text_.text = var_187_27

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_28 = 36
				local var_187_29 = utf8.len(var_187_27)
				local var_187_30 = var_187_28 <= 0 and var_187_25 or var_187_25 * (var_187_29 / var_187_28)

				if var_187_30 > 0 and var_187_25 < var_187_30 then
					arg_184_1.talkMaxDuration = var_187_30

					if var_187_30 + var_187_24 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_30 + var_187_24
					end
				end

				arg_184_1.text_.text = var_187_27
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_31 = math.max(var_187_25, arg_184_1.talkMaxDuration)

			if var_187_24 <= arg_184_1.time_ and arg_184_1.time_ < var_187_24 + var_187_31 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_24) / var_187_31

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_24 + var_187_31 and arg_184_1.time_ < var_187_24 + var_187_31 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_184_1:InitPlayNodeList()
	end,
	Play319831045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 319831045
		arg_188_1.duration_ = 3.07

		local var_188_0 = {
			zh = 3.066,
			ja = 2.433
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
				arg_188_0:Play319831046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["4040ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos4040ui_story = var_191_0.localPosition
			end

			local var_191_2 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2
				local var_191_4 = Vector3.New(0, -1.55, -5.5)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos4040ui_story, var_191_4, var_191_3)

				local var_191_5 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_5.x, var_191_5.y, var_191_5.z)

				local var_191_6 = var_191_0.localEulerAngles

				var_191_6.z = 0
				var_191_6.x = 0
				var_191_0.localEulerAngles = var_191_6
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_191_7 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_7.x, var_191_7.y, var_191_7.z)

				local var_191_8 = var_191_0.localEulerAngles

				var_191_8.z = 0
				var_191_8.x = 0
				var_191_0.localEulerAngles = var_191_8
			end

			local var_191_9 = 0

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 then
				arg_188_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_191_10 = 0

			if var_191_10 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 then
				arg_188_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_191_11 = arg_188_1.actors_["4040ui_story"]
			local var_191_12 = 0

			if var_191_12 < arg_188_1.time_ and arg_188_1.time_ <= var_191_12 + arg_191_0 and not isNil(var_191_11) and arg_188_1.var_.characterEffect4040ui_story == nil then
				arg_188_1.var_.characterEffect4040ui_story = var_191_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_13 = 0.200000002980232

			if var_191_12 <= arg_188_1.time_ and arg_188_1.time_ < var_191_12 + var_191_13 and not isNil(var_191_11) then
				local var_191_14 = (arg_188_1.time_ - var_191_12) / var_191_13

				if arg_188_1.var_.characterEffect4040ui_story and not isNil(var_191_11) then
					arg_188_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_12 + var_191_13 and arg_188_1.time_ < var_191_12 + var_191_13 + arg_191_0 and not isNil(var_191_11) and arg_188_1.var_.characterEffect4040ui_story then
				arg_188_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_191_15 = 0
			local var_191_16 = 0.15

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_17 = arg_188_1:FormatText(StoryNameCfg[668].name)

				arg_188_1.leftNameTxt_.text = var_191_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_18 = arg_188_1:GetWordFromCfg(319831045)
				local var_191_19 = arg_188_1:FormatText(var_191_18.content)

				arg_188_1.text_.text = var_191_19

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_20 = 6
				local var_191_21 = utf8.len(var_191_19)
				local var_191_22 = var_191_20 <= 0 and var_191_16 or var_191_16 * (var_191_21 / var_191_20)

				if var_191_22 > 0 and var_191_16 < var_191_22 then
					arg_188_1.talkMaxDuration = var_191_22

					if var_191_22 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_22 + var_191_15
					end
				end

				arg_188_1.text_.text = var_191_19
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831045", "story_v_out_319831.awb") ~= 0 then
					local var_191_23 = manager.audio:GetVoiceLength("story_v_out_319831", "319831045", "story_v_out_319831.awb") / 1000

					if var_191_23 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_23 + var_191_15
					end

					if var_191_18.prefab_name ~= "" and arg_188_1.actors_[var_191_18.prefab_name] ~= nil then
						local var_191_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_18.prefab_name].transform, "story_v_out_319831", "319831045", "story_v_out_319831.awb")

						arg_188_1:RecordAudio("319831045", var_191_24)
						arg_188_1:RecordAudio("319831045", var_191_24)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_319831", "319831045", "story_v_out_319831.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_319831", "319831045", "story_v_out_319831.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_25 = math.max(var_191_16, arg_188_1.talkMaxDuration)

			if var_191_15 <= arg_188_1.time_ and arg_188_1.time_ < var_191_15 + var_191_25 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_15) / var_191_25

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_15 + var_191_25 and arg_188_1.time_ < var_191_15 + var_191_25 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319831046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 319831046
		arg_192_1.duration_ = 6.3

		local var_192_0 = {
			zh = 4.3,
			ja = 6.3
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
				arg_192_0:Play319831047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 0.5

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[668].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:GetWordFromCfg(319831046)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 20
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319831", "319831046", "story_v_out_319831.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_319831", "319831046", "story_v_out_319831.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_319831", "319831046", "story_v_out_319831.awb")

						arg_192_1:RecordAudio("319831046", var_195_9)
						arg_192_1:RecordAudio("319831046", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_319831", "319831046", "story_v_out_319831.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_319831", "319831046", "story_v_out_319831.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play319831047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 319831047
		arg_196_1.duration_ = 5.63

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play319831048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["4040ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect4040ui_story == nil then
				arg_196_1.var_.characterEffect4040ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect4040ui_story and not isNil(var_199_0) then
					local var_199_4 = Mathf.Lerp(0, 0.5, var_199_3)

					arg_196_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_196_1.var_.characterEffect4040ui_story.fillRatio = var_199_4
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect4040ui_story then
				local var_199_5 = 0.5

				arg_196_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_196_1.var_.characterEffect4040ui_story.fillRatio = var_199_5
			end

			local var_199_6 = 0
			local var_199_7 = 1

			if var_199_6 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				local var_199_8 = "play"
				local var_199_9 = "effect"

				arg_196_1:AudioAction(var_199_8, var_199_9, "se_story_122_03", "se_story_122_03_swordlight", "")
			end

			local var_199_10 = arg_196_1.actors_["4040ui_story"].transform
			local var_199_11 = 0

			if var_199_11 < arg_196_1.time_ and arg_196_1.time_ <= var_199_11 + arg_199_0 then
				arg_196_1.var_.moveOldPos4040ui_story = var_199_10.localPosition
			end

			local var_199_12 = 0.001

			if var_199_11 <= arg_196_1.time_ and arg_196_1.time_ < var_199_11 + var_199_12 then
				local var_199_13 = (arg_196_1.time_ - var_199_11) / var_199_12
				local var_199_14 = Vector3.New(0, 100, 0)

				var_199_10.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos4040ui_story, var_199_14, var_199_13)

				local var_199_15 = manager.ui.mainCamera.transform.position - var_199_10.position

				var_199_10.forward = Vector3.New(var_199_15.x, var_199_15.y, var_199_15.z)

				local var_199_16 = var_199_10.localEulerAngles

				var_199_16.z = 0
				var_199_16.x = 0
				var_199_10.localEulerAngles = var_199_16
			end

			if arg_196_1.time_ >= var_199_11 + var_199_12 and arg_196_1.time_ < var_199_11 + var_199_12 + arg_199_0 then
				var_199_10.localPosition = Vector3.New(0, 100, 0)

				local var_199_17 = manager.ui.mainCamera.transform.position - var_199_10.position

				var_199_10.forward = Vector3.New(var_199_17.x, var_199_17.y, var_199_17.z)

				local var_199_18 = var_199_10.localEulerAngles

				var_199_18.z = 0
				var_199_18.x = 0
				var_199_10.localEulerAngles = var_199_18
			end

			local var_199_19 = manager.ui.mainCamera.transform
			local var_199_20 = 0

			if var_199_20 < arg_196_1.time_ and arg_196_1.time_ <= var_199_20 + arg_199_0 then
				local var_199_21 = arg_196_1.var_.effect123
				local var_199_22
				local var_199_23 = var_199_19

				if not var_199_21 then
					var_199_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_199_23)
					var_199_21.name = "123"
					arg_196_1.var_.effect123 = var_199_21
				else
					var_199_21.transform:SetParent(var_199_23)
				end

				var_199_21.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_199_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_196_1.frameCnt_ <= 1 then
				arg_196_1.dialog_:SetActive(false)
			end

			local var_199_24 = 0.633333333333333
			local var_199_25 = 0.825

			if var_199_24 < arg_196_1.time_ and arg_196_1.time_ <= var_199_24 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0

				arg_196_1.dialog_:SetActive(true)

				arg_196_1.dialogCg_.alpha = 0

				local var_199_26 = LeanTween.value(arg_196_1.dialog_, 0, 1, 0.3)

				var_199_26:setOnUpdate(LuaHelper.FloatAction(function(arg_200_0)
					arg_196_1.dialogCg_.alpha = arg_200_0
				end))
				var_199_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_196_1.dialog_)
					var_199_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_196_1.duration_ = arg_196_1.duration_ + 0.3

				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_27 = arg_196_1:GetWordFromCfg(319831047)
				local var_199_28 = arg_196_1:FormatText(var_199_27.content)

				arg_196_1.text_.text = var_199_28

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_29 = 33
				local var_199_30 = utf8.len(var_199_28)
				local var_199_31 = var_199_29 <= 0 and var_199_25 or var_199_25 * (var_199_30 / var_199_29)

				if var_199_31 > 0 and var_199_25 < var_199_31 then
					arg_196_1.talkMaxDuration = var_199_31
					var_199_24 = var_199_24 + 0.3

					if var_199_31 + var_199_24 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_31 + var_199_24
					end
				end

				arg_196_1.text_.text = var_199_28
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_32 = var_199_24 + 0.3
			local var_199_33 = math.max(var_199_25, arg_196_1.talkMaxDuration)

			if var_199_32 <= arg_196_1.time_ and arg_196_1.time_ < var_199_32 + var_199_33 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_32) / var_199_33

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_32 + var_199_33 and arg_196_1.time_ < var_199_32 + var_199_33 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play319831048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319831048
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play319831049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = manager.ui.mainCamera.transform
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				local var_205_2 = arg_202_1.var_.effect123

				if var_205_2 then
					Object.Destroy(var_205_2)

					arg_202_1.var_.effect123 = nil
				end
			end

			local var_205_3 = 0
			local var_205_4 = 1.325

			if var_205_3 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_5 = arg_202_1:GetWordFromCfg(319831048)
				local var_205_6 = arg_202_1:FormatText(var_205_5.content)

				arg_202_1.text_.text = var_205_6

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 53
				local var_205_8 = utf8.len(var_205_6)
				local var_205_9 = var_205_7 <= 0 and var_205_4 or var_205_4 * (var_205_8 / var_205_7)

				if var_205_9 > 0 and var_205_4 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9

					if var_205_9 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_3
					end
				end

				arg_202_1.text_.text = var_205_6
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_4, arg_202_1.talkMaxDuration)

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_3) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_3 + var_205_10 and arg_202_1.time_ < var_205_3 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play319831049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319831049
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
			arg_206_1.auto_ = false
		end

		function arg_206_1.playNext_(arg_208_0)
			arg_206_1.onStoryFinished_()
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 1.025

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_2 = arg_206_1:GetWordFromCfg(319831049)
				local var_209_3 = arg_206_1:FormatText(var_209_2.content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 41
				local var_209_5 = utf8.len(var_209_3)
				local var_209_6 = var_209_4 <= 0 and var_209_1 or var_209_1 * (var_209_5 / var_209_4)

				if var_209_6 > 0 and var_209_1 < var_209_6 then
					arg_206_1.talkMaxDuration = var_209_6

					if var_209_6 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_7 and arg_206_1.time_ < var_209_0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/D02a",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319831.awb"
	}
}
