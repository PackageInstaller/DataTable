return {
	Play112231001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112231001
		arg_1_1.duration_ = 9.1

		local var_1_0 = {
			ja = 6.8,
			ko = 6.166,
			zh = 6.133,
			en = 9.1
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
				arg_1_0:Play112231002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 1

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = (arg_1_1.time_ - var_4_0) / var_4_1
				local var_4_3 = Color.New(1, 1, 1)

				var_4_3.a = Mathf.Lerp(1, 0, var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_4 = Color.New(1, 1, 1)
				local var_4_5 = 0

				arg_1_1.mask_.enabled = false
				var_4_4.a = var_4_5
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_6 = "H01a"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = 0

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				local var_4_9 = manager.ui.mainCamera.transform.localPosition
				local var_4_10 = Vector3.New(0, 0, 10) + Vector3.New(var_4_9.x, var_4_9.y, 0)
				local var_4_11 = arg_1_1.bgs_.H01a

				var_4_11.transform.localPosition = var_4_10
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = (var_4_11.transform.localPosition - var_4_9).z
					local var_4_14 = manager.ui.mainCameraCom_
					local var_4_15 = 2 * var_4_13 * Mathf.Tan(var_4_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_16 = var_4_15 * var_4_14.aspect
					local var_4_17 = var_4_12.sprite.bounds.size.x
					local var_4_18 = var_4_12.sprite.bounds.size.y
					local var_4_19 = var_4_16 / var_4_17
					local var_4_20 = var_4_15 / var_4_18
					local var_4_21 = var_4_20 < var_4_19 and var_4_19 or var_4_20

					var_4_11.transform.localScale = Vector3.New(var_4_21, var_4_21, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H01a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_22 = "1081ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1081ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1081ui_story"].transform
			local var_4_28 = 1.2

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1081ui_story = var_4_27.localPosition

				local var_4_29 = "1081ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_29 .. "Animator"].transform, false)
			end

			local var_4_30 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_28) / var_4_30
				local var_4_32 = Vector3.New(0, -0.92, -5.8)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1081ui_story, var_4_32, var_4_31)

				local var_4_33 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_33.x, var_4_33.y, var_4_33.z)

				local var_4_34 = var_4_27.localEulerAngles

				var_4_34.z = 0
				var_4_34.x = 0
				var_4_27.localEulerAngles = var_4_34
			end

			if arg_1_1.time_ >= var_4_28 + var_4_30 and arg_1_1.time_ < var_4_28 + var_4_30 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_27.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_27.localEulerAngles = var_4_36
			end

			local var_4_37 = arg_1_1.actors_["1081ui_story"]
			local var_4_38 = 1.2

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 and not isNil(var_4_37) and arg_1_1.var_.characterEffect1081ui_story == nil then
				arg_1_1.var_.characterEffect1081ui_story = var_4_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_39 = 0.2

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 and not isNil(var_4_37) then
				local var_4_40 = (arg_1_1.time_ - var_4_38) / var_4_39

				if arg_1_1.var_.characterEffect1081ui_story and not isNil(var_4_37) then
					arg_1_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 and not isNil(var_4_37) and arg_1_1.var_.characterEffect1081ui_story then
				arg_1_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_4_41 = 1.2

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_1")
			end

			local var_4_42 = 1.2

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_4_43 = 0
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "effect"

				arg_1_1:AudioAction(var_4_45, var_4_46, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_47 = 1.2
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

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

			local var_4_53 = 1.2
			local var_4_54 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "effect"

				arg_1_1:AudioAction(var_4_55, var_4_56, "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_57 = 1.2
			local var_4_58 = 0.45

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_59 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_59:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_60 = arg_1_1:FormatText(StoryNameCfg[202].name)

				arg_1_1.leftNameTxt_.text = var_4_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_61 = arg_1_1:GetWordFromCfg(112231001)
				local var_4_62 = arg_1_1:FormatText(var_4_61.content)

				arg_1_1.text_.text = var_4_62

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_63 = 18
				local var_4_64 = utf8.len(var_4_62)
				local var_4_65 = var_4_63 <= 0 and var_4_58 or var_4_58 * (var_4_64 / var_4_63)

				if var_4_65 > 0 and var_4_58 < var_4_65 then
					arg_1_1.talkMaxDuration = var_4_65
					var_4_57 = var_4_57 + 0.3

					if var_4_65 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_57
					end
				end

				arg_1_1.text_.text = var_4_62
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231001", "story_v_out_112231.awb") ~= 0 then
					local var_4_66 = manager.audio:GetVoiceLength("story_v_out_112231", "112231001", "story_v_out_112231.awb") / 1000

					if var_4_66 + var_4_57 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_57
					end

					if var_4_61.prefab_name ~= "" and arg_1_1.actors_[var_4_61.prefab_name] ~= nil then
						local var_4_67 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_61.prefab_name].transform, "story_v_out_112231", "112231001", "story_v_out_112231.awb")

						arg_1_1:RecordAudio("112231001", var_4_67)
						arg_1_1:RecordAudio("112231001", var_4_67)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_112231", "112231001", "story_v_out_112231.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_112231", "112231001", "story_v_out_112231.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_68 = var_4_57 + 0.3
			local var_4_69 = math.max(var_4_58, arg_1_1.talkMaxDuration)

			if var_4_68 <= arg_1_1.time_ and arg_1_1.time_ < var_4_68 + var_4_69 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_68) / var_4_69

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_68 + var_4_69 and arg_1_1.time_ < var_4_68 + var_4_69 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play112231002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 112231002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play112231003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1081ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1081ui_story == nil then
				arg_8_1.var_.characterEffect1081ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.2

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1081ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1081ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1081ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1081ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_2")
			end

			local var_11_7 = 0
			local var_11_8 = 0.475

			if var_11_7 < arg_8_1.time_ and arg_8_1.time_ <= var_11_7 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_9 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_10 = arg_8_1:GetWordFromCfg(112231002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_12 = 19
				local var_11_13 = utf8.len(var_11_11)
				local var_11_14 = var_11_12 <= 0 and var_11_8 or var_11_8 * (var_11_13 / var_11_12)

				if var_11_14 > 0 and var_11_8 < var_11_14 then
					arg_8_1.talkMaxDuration = var_11_14

					if var_11_14 + var_11_7 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_7
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_15 = math.max(var_11_8, arg_8_1.talkMaxDuration)

			if var_11_7 <= arg_8_1.time_ and arg_8_1.time_ < var_11_7 + var_11_15 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_7) / var_11_15

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_7 + var_11_15 and arg_8_1.time_ < var_11_7 + var_11_15 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play112231003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 112231003
		arg_12_1.duration_ = 4.3

		local var_12_0 = {
			ja = 3.133,
			ko = 2.633,
			zh = 3.533,
			en = 4.3
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play112231004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1081ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1081ui_story == nil then
				arg_12_1.var_.characterEffect1081ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1081ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1081ui_story then
				arg_12_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_15_4 = 0

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_15_6 = 0
			local var_15_7 = 0.3

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[202].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_9 = arg_12_1:GetWordFromCfg(112231003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 12
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231003", "story_v_out_112231.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231003", "story_v_out_112231.awb") / 1000

					if var_15_14 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_6
					end

					if var_15_9.prefab_name ~= "" and arg_12_1.actors_[var_15_9.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_9.prefab_name].transform, "story_v_out_112231", "112231003", "story_v_out_112231.awb")

						arg_12_1:RecordAudio("112231003", var_15_15)
						arg_12_1:RecordAudio("112231003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_112231", "112231003", "story_v_out_112231.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_112231", "112231003", "story_v_out_112231.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_16 and arg_12_1.time_ < var_15_6 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play112231004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 112231004
		arg_16_1.duration_ = 8.67

		local var_16_0 = {
			ja = 6.766,
			ko = 6.6,
			zh = 7.866,
			en = 8.666
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
				arg_16_0:Play112231005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_19_1 = 0
			local var_19_2 = 1.075

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_3 = arg_16_1:FormatText(StoryNameCfg[202].name)

				arg_16_1.leftNameTxt_.text = var_19_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:GetWordFromCfg(112231004)
				local var_19_5 = arg_16_1:FormatText(var_19_4.content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 43
				local var_19_7 = utf8.len(var_19_5)
				local var_19_8 = var_19_6 <= 0 and var_19_2 or var_19_2 * (var_19_7 / var_19_6)

				if var_19_8 > 0 and var_19_2 < var_19_8 then
					arg_16_1.talkMaxDuration = var_19_8

					if var_19_8 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231004", "story_v_out_112231.awb") ~= 0 then
					local var_19_9 = manager.audio:GetVoiceLength("story_v_out_112231", "112231004", "story_v_out_112231.awb") / 1000

					if var_19_9 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_1
					end

					if var_19_4.prefab_name ~= "" and arg_16_1.actors_[var_19_4.prefab_name] ~= nil then
						local var_19_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_4.prefab_name].transform, "story_v_out_112231", "112231004", "story_v_out_112231.awb")

						arg_16_1:RecordAudio("112231004", var_19_10)
						arg_16_1:RecordAudio("112231004", var_19_10)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_112231", "112231004", "story_v_out_112231.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_112231", "112231004", "story_v_out_112231.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_11 and arg_16_1.time_ < var_19_1 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play112231005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 112231005
		arg_20_1.duration_ = 6.5

		local var_20_0 = {
			ja = 6.5,
			ko = 5.633,
			zh = 4.8,
			en = 6.266
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
				arg_20_0:Play112231006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action474")
			end

			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_23_2 = 0
			local var_23_3 = 0.65

			if var_23_2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_4 = arg_20_1:FormatText(StoryNameCfg[202].name)

				arg_20_1.leftNameTxt_.text = var_23_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_5 = arg_20_1:GetWordFromCfg(112231005)
				local var_23_6 = arg_20_1:FormatText(var_23_5.content)

				arg_20_1.text_.text = var_23_6

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 26
				local var_23_8 = utf8.len(var_23_6)
				local var_23_9 = var_23_7 <= 0 and var_23_3 or var_23_3 * (var_23_8 / var_23_7)

				if var_23_9 > 0 and var_23_3 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_6
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231005", "story_v_out_112231.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_112231", "112231005", "story_v_out_112231.awb") / 1000

					if var_23_10 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_2
					end

					if var_23_5.prefab_name ~= "" and arg_20_1.actors_[var_23_5.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_5.prefab_name].transform, "story_v_out_112231", "112231005", "story_v_out_112231.awb")

						arg_20_1:RecordAudio("112231005", var_23_11)
						arg_20_1:RecordAudio("112231005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_112231", "112231005", "story_v_out_112231.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_112231", "112231005", "story_v_out_112231.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_12 and arg_20_1.time_ < var_23_2 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play112231006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 112231006
		arg_24_1.duration_ = 4.47

		local var_24_0 = {
			ja = 4.466,
			ko = 3.266,
			zh = 3.866,
			en = 3.233
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
				arg_24_0:Play112231007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_2")
			end

			local var_27_1 = arg_24_1.actors_["1081ui_story"]
			local var_27_2 = 0

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1081ui_story == nil then
				arg_24_1.var_.characterEffect1081ui_story = var_27_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.2

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_3 and not isNil(var_27_1) then
				local var_27_4 = (arg_24_1.time_ - var_27_2) / var_27_3

				if arg_24_1.var_.characterEffect1081ui_story and not isNil(var_27_1) then
					local var_27_5 = Mathf.Lerp(0, 0.5, var_27_4)

					arg_24_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1081ui_story.fillRatio = var_27_5
				end
			end

			if arg_24_1.time_ >= var_27_2 + var_27_3 and arg_24_1.time_ < var_27_2 + var_27_3 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1081ui_story then
				local var_27_6 = 0.5

				arg_24_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1081ui_story.fillRatio = var_27_6
			end

			local var_27_7 = 0
			local var_27_8 = 0.325

			if var_27_7 < arg_24_1.time_ and arg_24_1.time_ <= var_27_7 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_9 = arg_24_1:FormatText(StoryNameCfg[9].name)

				arg_24_1.leftNameTxt_.text = var_27_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_10 = arg_24_1:GetWordFromCfg(112231006)
				local var_27_11 = arg_24_1:FormatText(var_27_10.content)

				arg_24_1.text_.text = var_27_11

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_12 = 13
				local var_27_13 = utf8.len(var_27_11)
				local var_27_14 = var_27_12 <= 0 and var_27_8 or var_27_8 * (var_27_13 / var_27_12)

				if var_27_14 > 0 and var_27_8 < var_27_14 then
					arg_24_1.talkMaxDuration = var_27_14

					if var_27_14 + var_27_7 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_7
					end
				end

				arg_24_1.text_.text = var_27_11
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231006", "story_v_out_112231.awb") ~= 0 then
					local var_27_15 = manager.audio:GetVoiceLength("story_v_out_112231", "112231006", "story_v_out_112231.awb") / 1000

					if var_27_15 + var_27_7 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_7
					end

					if var_27_10.prefab_name ~= "" and arg_24_1.actors_[var_27_10.prefab_name] ~= nil then
						local var_27_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_10.prefab_name].transform, "story_v_out_112231", "112231006", "story_v_out_112231.awb")

						arg_24_1:RecordAudio("112231006", var_27_16)
						arg_24_1:RecordAudio("112231006", var_27_16)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_112231", "112231006", "story_v_out_112231.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_112231", "112231006", "story_v_out_112231.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_17 = math.max(var_27_8, arg_24_1.talkMaxDuration)

			if var_27_7 <= arg_24_1.time_ and arg_24_1.time_ < var_27_7 + var_27_17 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_7) / var_27_17

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_7 + var_27_17 and arg_24_1.time_ < var_27_7 + var_27_17 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play112231007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 112231007
		arg_28_1.duration_ = 4.17

		local var_28_0 = {
			ja = 3.266,
			ko = 4.166,
			zh = 3.033,
			en = 3.9
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
				arg_28_0:Play112231008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.225

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[6].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(112231007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 9
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231007", "story_v_out_112231.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231007", "story_v_out_112231.awb") / 1000

					if var_31_8 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_0
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_112231", "112231007", "story_v_out_112231.awb")

						arg_28_1:RecordAudio("112231007", var_31_9)
						arg_28_1:RecordAudio("112231007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_112231", "112231007", "story_v_out_112231.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_112231", "112231007", "story_v_out_112231.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_10 and arg_28_1.time_ < var_31_0 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play112231008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 112231008
		arg_32_1.duration_ = 9.4

		local var_32_0 = {
			ja = 9.4,
			ko = 6.133,
			zh = 5.2,
			en = 5.1
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
				arg_32_0:Play112231009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.575

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[56].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(112231008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 23
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231008", "story_v_out_112231.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231008", "story_v_out_112231.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_112231", "112231008", "story_v_out_112231.awb")

						arg_32_1:RecordAudio("112231008", var_35_9)
						arg_32_1:RecordAudio("112231008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_112231", "112231008", "story_v_out_112231.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_112231", "112231008", "story_v_out_112231.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play112231009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 112231009
		arg_36_1.duration_ = 8.37

		local var_36_0 = {
			ja = 8.366,
			ko = 7,
			zh = 5.833,
			en = 6.1
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
				arg_36_0:Play112231010(arg_36_1)
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

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[8].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(112231009)
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

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231009", "story_v_out_112231.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231009", "story_v_out_112231.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_112231", "112231009", "story_v_out_112231.awb")

						arg_36_1:RecordAudio("112231009", var_39_9)
						arg_36_1:RecordAudio("112231009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_112231", "112231009", "story_v_out_112231.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_112231", "112231009", "story_v_out_112231.awb")
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
	Play112231010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 112231010
		arg_40_1.duration_ = 8.53

		local var_40_0 = {
			ja = 7.333,
			ko = 7.633,
			zh = 7.433,
			en = 8.533
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
				arg_40_0:Play112231011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1081ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1081ui_story == nil then
				arg_40_1.var_.characterEffect1081ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1081ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1081ui_story then
				arg_40_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_43_4 = 0

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_43_6 = 0
			local var_43_7 = 0.85

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[202].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_9 = arg_40_1:GetWordFromCfg(112231010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 34
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231010", "story_v_out_112231.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231010", "story_v_out_112231.awb") / 1000

					if var_43_14 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_6
					end

					if var_43_9.prefab_name ~= "" and arg_40_1.actors_[var_43_9.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_9.prefab_name].transform, "story_v_out_112231", "112231010", "story_v_out_112231.awb")

						arg_40_1:RecordAudio("112231010", var_43_15)
						arg_40_1:RecordAudio("112231010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_112231", "112231010", "story_v_out_112231.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_112231", "112231010", "story_v_out_112231.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_16 and arg_40_1.time_ < var_43_6 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play112231011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 112231011
		arg_44_1.duration_ = 10.73

		local var_44_0 = {
			ja = 10.2,
			ko = 9.066,
			zh = 8.933,
			en = 10.733
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
				arg_44_0:Play112231012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_47_1 = 0
			local var_47_2 = 1.025

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_3 = arg_44_1:FormatText(StoryNameCfg[202].name)

				arg_44_1.leftNameTxt_.text = var_47_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(112231011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_6 = 41
				local var_47_7 = utf8.len(var_47_5)
				local var_47_8 = var_47_6 <= 0 and var_47_2 or var_47_2 * (var_47_7 / var_47_6)

				if var_47_8 > 0 and var_47_2 < var_47_8 then
					arg_44_1.talkMaxDuration = var_47_8

					if var_47_8 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231011", "story_v_out_112231.awb") ~= 0 then
					local var_47_9 = manager.audio:GetVoiceLength("story_v_out_112231", "112231011", "story_v_out_112231.awb") / 1000

					if var_47_9 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_1
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_112231", "112231011", "story_v_out_112231.awb")

						arg_44_1:RecordAudio("112231011", var_47_10)
						arg_44_1:RecordAudio("112231011", var_47_10)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_112231", "112231011", "story_v_out_112231.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_112231", "112231011", "story_v_out_112231.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_11 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_11 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_11

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_11 and arg_44_1.time_ < var_47_1 + var_47_11 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play112231012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 112231012
		arg_48_1.duration_ = 5.7

		local var_48_0 = {
			ja = 5.7,
			ko = 3.966,
			zh = 4.2,
			en = 5.533
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
				arg_48_0:Play112231013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action474")
			end

			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_51_2 = 0
			local var_51_3 = 0.4

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_4 = arg_48_1:FormatText(StoryNameCfg[202].name)

				arg_48_1.leftNameTxt_.text = var_51_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_5 = arg_48_1:GetWordFromCfg(112231012)
				local var_51_6 = arg_48_1:FormatText(var_51_5.content)

				arg_48_1.text_.text = var_51_6

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 16
				local var_51_8 = utf8.len(var_51_6)
				local var_51_9 = var_51_7 <= 0 and var_51_3 or var_51_3 * (var_51_8 / var_51_7)

				if var_51_9 > 0 and var_51_3 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_6
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231012", "story_v_out_112231.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_112231", "112231012", "story_v_out_112231.awb") / 1000

					if var_51_10 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_2
					end

					if var_51_5.prefab_name ~= "" and arg_48_1.actors_[var_51_5.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_5.prefab_name].transform, "story_v_out_112231", "112231012", "story_v_out_112231.awb")

						arg_48_1:RecordAudio("112231012", var_51_11)
						arg_48_1:RecordAudio("112231012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_112231", "112231012", "story_v_out_112231.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_112231", "112231012", "story_v_out_112231.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_3, arg_48_1.talkMaxDuration)

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_2) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_2 + var_51_12 and arg_48_1.time_ < var_51_2 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play112231013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 112231013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play112231014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1081ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1081ui_story == nil then
				arg_52_1.var_.characterEffect1081ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1081ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1081ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1081ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1081ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_2")
			end

			local var_55_7 = 0

			if var_55_7 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				arg_52_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_55_8 = 0
			local var_55_9 = 0.575

			if var_55_8 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_10 = arg_52_1:GetWordFromCfg(112231013)
				local var_55_11 = arg_52_1:FormatText(var_55_10.content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_12 = 23
				local var_55_13 = utf8.len(var_55_11)
				local var_55_14 = var_55_12 <= 0 and var_55_9 or var_55_9 * (var_55_13 / var_55_12)

				if var_55_14 > 0 and var_55_9 < var_55_14 then
					arg_52_1.talkMaxDuration = var_55_14

					if var_55_14 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_15 = math.max(var_55_9, arg_52_1.talkMaxDuration)

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_15 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_8) / var_55_15

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_8 + var_55_15 and arg_52_1.time_ < var_55_8 + var_55_15 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play112231014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 112231014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play112231015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.325

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(112231014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 13
				local var_59_6 = utf8.len(var_59_4)
				local var_59_7 = var_59_5 <= 0 and var_59_1 or var_59_1 * (var_59_6 / var_59_5)

				if var_59_7 > 0 and var_59_1 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play112231015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 112231015
		arg_60_1.duration_ = 11.2

		local var_60_0 = {
			ja = 8.266,
			ko = 11.2,
			zh = 9.766,
			en = 9.7
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
				arg_60_0:Play112231016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1081ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1081ui_story == nil then
				arg_60_1.var_.characterEffect1081ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1081ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1081ui_story then
				arg_60_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_63_4 = 0

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_63_6 = 0
			local var_63_7 = 1.3

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_8 = arg_60_1:FormatText(StoryNameCfg[202].name)

				arg_60_1.leftNameTxt_.text = var_63_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_9 = arg_60_1:GetWordFromCfg(112231015)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 52
				local var_63_12 = utf8.len(var_63_10)
				local var_63_13 = var_63_11 <= 0 and var_63_7 or var_63_7 * (var_63_12 / var_63_11)

				if var_63_13 > 0 and var_63_7 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_10
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231015", "story_v_out_112231.awb") ~= 0 then
					local var_63_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231015", "story_v_out_112231.awb") / 1000

					if var_63_14 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_6
					end

					if var_63_9.prefab_name ~= "" and arg_60_1.actors_[var_63_9.prefab_name] ~= nil then
						local var_63_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_9.prefab_name].transform, "story_v_out_112231", "112231015", "story_v_out_112231.awb")

						arg_60_1:RecordAudio("112231015", var_63_15)
						arg_60_1:RecordAudio("112231015", var_63_15)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_112231", "112231015", "story_v_out_112231.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_112231", "112231015", "story_v_out_112231.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_16 and arg_60_1.time_ < var_63_6 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play112231016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 112231016
		arg_64_1.duration_ = 8.43

		local var_64_0 = {
			ja = 8,
			ko = 8.433,
			zh = 7.766,
			en = 8.233
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
				arg_64_0:Play112231017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action457")
			end

			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_67_2 = 0
			local var_67_3 = 1.025

			if var_67_2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_4 = arg_64_1:FormatText(StoryNameCfg[202].name)

				arg_64_1.leftNameTxt_.text = var_67_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_5 = arg_64_1:GetWordFromCfg(112231016)
				local var_67_6 = arg_64_1:FormatText(var_67_5.content)

				arg_64_1.text_.text = var_67_6

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 41
				local var_67_8 = utf8.len(var_67_6)
				local var_67_9 = var_67_7 <= 0 and var_67_3 or var_67_3 * (var_67_8 / var_67_7)

				if var_67_9 > 0 and var_67_3 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_2
					end
				end

				arg_64_1.text_.text = var_67_6
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231016", "story_v_out_112231.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_112231", "112231016", "story_v_out_112231.awb") / 1000

					if var_67_10 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_2
					end

					if var_67_5.prefab_name ~= "" and arg_64_1.actors_[var_67_5.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_5.prefab_name].transform, "story_v_out_112231", "112231016", "story_v_out_112231.awb")

						arg_64_1:RecordAudio("112231016", var_67_11)
						arg_64_1:RecordAudio("112231016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_112231", "112231016", "story_v_out_112231.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_112231", "112231016", "story_v_out_112231.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_3, arg_64_1.talkMaxDuration)

			if var_67_2 <= arg_64_1.time_ and arg_64_1.time_ < var_67_2 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_2) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_2 + var_67_12 and arg_64_1.time_ < var_67_2 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play112231017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 112231017
		arg_68_1.duration_ = 9.03

		local var_68_0 = {
			ja = 8.3,
			ko = 6.166,
			zh = 8.1,
			en = 9.033
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
				arg_68_0:Play112231018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1081ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1081ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, 100, 0)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1081ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, 100, 0)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = "1027ui_story"

			if arg_68_1.actors_[var_71_9] == nil then
				local var_71_10 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_71_10) then
					local var_71_11 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_68_1.stage_.transform)

					var_71_11.name = var_71_9
					var_71_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_68_1.actors_[var_71_9] = var_71_11

					local var_71_12 = var_71_11:GetComponentInChildren(typeof(CharacterEffect))

					var_71_12.enabled = true

					local var_71_13 = GameObjectTools.GetOrAddComponent(var_71_11, typeof(DynamicBoneHelper))

					if var_71_13 then
						var_71_13:EnableDynamicBone(false)
					end

					arg_68_1:ShowWeapon(var_71_12.transform, false)

					arg_68_1.var_[var_71_9 .. "Animator"] = var_71_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_68_1.var_[var_71_9 .. "Animator"].applyRootMotion = true
					arg_68_1.var_[var_71_9 .. "LipSync"] = var_71_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_71_14 = arg_68_1.actors_["1027ui_story"].transform
			local var_71_15 = 0

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.var_.moveOldPos1027ui_story = var_71_14.localPosition

				local var_71_16 = "1027ui_story"

				arg_68_1:ShowWeapon(arg_68_1.var_[var_71_16 .. "Animator"].transform, false)
			end

			local var_71_17 = 0.001

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_17 then
				local var_71_18 = (arg_68_1.time_ - var_71_15) / var_71_17
				local var_71_19 = Vector3.New(0, -0.81, -5.8)

				var_71_14.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1027ui_story, var_71_19, var_71_18)

				local var_71_20 = manager.ui.mainCamera.transform.position - var_71_14.position

				var_71_14.forward = Vector3.New(var_71_20.x, var_71_20.y, var_71_20.z)

				local var_71_21 = var_71_14.localEulerAngles

				var_71_21.z = 0
				var_71_21.x = 0
				var_71_14.localEulerAngles = var_71_21
			end

			if arg_68_1.time_ >= var_71_15 + var_71_17 and arg_68_1.time_ < var_71_15 + var_71_17 + arg_71_0 then
				var_71_14.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_71_22 = manager.ui.mainCamera.transform.position - var_71_14.position

				var_71_14.forward = Vector3.New(var_71_22.x, var_71_22.y, var_71_22.z)

				local var_71_23 = var_71_14.localEulerAngles

				var_71_23.z = 0
				var_71_23.x = 0
				var_71_14.localEulerAngles = var_71_23
			end

			local var_71_24 = arg_68_1.actors_["1027ui_story"]
			local var_71_25 = 0

			if var_71_25 < arg_68_1.time_ and arg_68_1.time_ <= var_71_25 + arg_71_0 and not isNil(var_71_24) and arg_68_1.var_.characterEffect1027ui_story == nil then
				arg_68_1.var_.characterEffect1027ui_story = var_71_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_26 = 0.2

			if var_71_25 <= arg_68_1.time_ and arg_68_1.time_ < var_71_25 + var_71_26 and not isNil(var_71_24) then
				local var_71_27 = (arg_68_1.time_ - var_71_25) / var_71_26

				if arg_68_1.var_.characterEffect1027ui_story and not isNil(var_71_24) then
					arg_68_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_25 + var_71_26 and arg_68_1.time_ < var_71_25 + var_71_26 + arg_71_0 and not isNil(var_71_24) and arg_68_1.var_.characterEffect1027ui_story then
				arg_68_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_71_28 = 0

			if var_71_28 < arg_68_1.time_ and arg_68_1.time_ <= var_71_28 + arg_71_0 then
				arg_68_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			local var_71_29 = 0

			if var_71_29 < arg_68_1.time_ and arg_68_1.time_ <= var_71_29 + arg_71_0 then
				arg_68_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_71_30 = 0
			local var_71_31 = 0.925

			if var_71_30 < arg_68_1.time_ and arg_68_1.time_ <= var_71_30 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_32 = arg_68_1:FormatText(StoryNameCfg[56].name)

				arg_68_1.leftNameTxt_.text = var_71_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_33 = arg_68_1:GetWordFromCfg(112231017)
				local var_71_34 = arg_68_1:FormatText(var_71_33.content)

				arg_68_1.text_.text = var_71_34

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_35 = 37
				local var_71_36 = utf8.len(var_71_34)
				local var_71_37 = var_71_35 <= 0 and var_71_31 or var_71_31 * (var_71_36 / var_71_35)

				if var_71_37 > 0 and var_71_31 < var_71_37 then
					arg_68_1.talkMaxDuration = var_71_37

					if var_71_37 + var_71_30 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_37 + var_71_30
					end
				end

				arg_68_1.text_.text = var_71_34
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231017", "story_v_out_112231.awb") ~= 0 then
					local var_71_38 = manager.audio:GetVoiceLength("story_v_out_112231", "112231017", "story_v_out_112231.awb") / 1000

					if var_71_38 + var_71_30 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_38 + var_71_30
					end

					if var_71_33.prefab_name ~= "" and arg_68_1.actors_[var_71_33.prefab_name] ~= nil then
						local var_71_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_33.prefab_name].transform, "story_v_out_112231", "112231017", "story_v_out_112231.awb")

						arg_68_1:RecordAudio("112231017", var_71_39)
						arg_68_1:RecordAudio("112231017", var_71_39)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_112231", "112231017", "story_v_out_112231.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_112231", "112231017", "story_v_out_112231.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_40 = math.max(var_71_31, arg_68_1.talkMaxDuration)

			if var_71_30 <= arg_68_1.time_ and arg_68_1.time_ < var_71_30 + var_71_40 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_30) / var_71_40

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_30 + var_71_40 and arg_68_1.time_ < var_71_30 + var_71_40 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play112231018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 112231018
		arg_72_1.duration_ = 3.53

		local var_72_0 = {
			ja = 3.533,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
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
				arg_72_0:Play112231019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1027ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1027ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(-0.7, -0.81, -5.8)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1027ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(-0.7, -0.81, -5.8)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = arg_72_1.actors_["1027ui_story"]
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1027ui_story == nil then
				arg_72_1.var_.characterEffect1027ui_story = var_75_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_11 = 0.2

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_11 and not isNil(var_75_9) then
				local var_75_12 = (arg_72_1.time_ - var_75_10) / var_75_11

				if arg_72_1.var_.characterEffect1027ui_story and not isNil(var_75_9) then
					local var_75_13 = Mathf.Lerp(0, 0.5, var_75_12)

					arg_72_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1027ui_story.fillRatio = var_75_13
				end
			end

			if arg_72_1.time_ >= var_75_10 + var_75_11 and arg_72_1.time_ < var_75_10 + var_75_11 + arg_75_0 and not isNil(var_75_9) and arg_72_1.var_.characterEffect1027ui_story then
				local var_75_14 = 0.5

				arg_72_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1027ui_story.fillRatio = var_75_14
			end

			local var_75_15 = 0

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_2")
			end

			local var_75_16 = "1148ui_story"

			if arg_72_1.actors_[var_75_16] == nil then
				local var_75_17 = Asset.Load("Char/" .. "1148ui_story")

				if not isNil(var_75_17) then
					local var_75_18 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_72_1.stage_.transform)

					var_75_18.name = var_75_16
					var_75_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_72_1.actors_[var_75_16] = var_75_18

					local var_75_19 = var_75_18:GetComponentInChildren(typeof(CharacterEffect))

					var_75_19.enabled = true

					local var_75_20 = GameObjectTools.GetOrAddComponent(var_75_18, typeof(DynamicBoneHelper))

					if var_75_20 then
						var_75_20:EnableDynamicBone(false)
					end

					arg_72_1:ShowWeapon(var_75_19.transform, false)

					arg_72_1.var_[var_75_16 .. "Animator"] = var_75_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_72_1.var_[var_75_16 .. "Animator"].applyRootMotion = true
					arg_72_1.var_[var_75_16 .. "LipSync"] = var_75_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_75_21 = arg_72_1.actors_["1148ui_story"].transform
			local var_75_22 = 0

			if var_75_22 < arg_72_1.time_ and arg_72_1.time_ <= var_75_22 + arg_75_0 then
				arg_72_1.var_.moveOldPos1148ui_story = var_75_21.localPosition

				local var_75_23 = "1148ui_story"

				arg_72_1:ShowWeapon(arg_72_1.var_[var_75_23 .. "Animator"].transform, false)
			end

			local var_75_24 = 0.001

			if var_75_22 <= arg_72_1.time_ and arg_72_1.time_ < var_75_22 + var_75_24 then
				local var_75_25 = (arg_72_1.time_ - var_75_22) / var_75_24
				local var_75_26 = Vector3.New(0.7, -0.8, -6.2)

				var_75_21.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1148ui_story, var_75_26, var_75_25)

				local var_75_27 = manager.ui.mainCamera.transform.position - var_75_21.position

				var_75_21.forward = Vector3.New(var_75_27.x, var_75_27.y, var_75_27.z)

				local var_75_28 = var_75_21.localEulerAngles

				var_75_28.z = 0
				var_75_28.x = 0
				var_75_21.localEulerAngles = var_75_28
			end

			if arg_72_1.time_ >= var_75_22 + var_75_24 and arg_72_1.time_ < var_75_22 + var_75_24 + arg_75_0 then
				var_75_21.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_75_29 = manager.ui.mainCamera.transform.position - var_75_21.position

				var_75_21.forward = Vector3.New(var_75_29.x, var_75_29.y, var_75_29.z)

				local var_75_30 = var_75_21.localEulerAngles

				var_75_30.z = 0
				var_75_30.x = 0
				var_75_21.localEulerAngles = var_75_30
			end

			local var_75_31 = arg_72_1.actors_["1148ui_story"]
			local var_75_32 = 0

			if var_75_32 < arg_72_1.time_ and arg_72_1.time_ <= var_75_32 + arg_75_0 and not isNil(var_75_31) and arg_72_1.var_.characterEffect1148ui_story == nil then
				arg_72_1.var_.characterEffect1148ui_story = var_75_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_33 = 0.2

			if var_75_32 <= arg_72_1.time_ and arg_72_1.time_ < var_75_32 + var_75_33 and not isNil(var_75_31) then
				local var_75_34 = (arg_72_1.time_ - var_75_32) / var_75_33

				if arg_72_1.var_.characterEffect1148ui_story and not isNil(var_75_31) then
					arg_72_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_32 + var_75_33 and arg_72_1.time_ < var_75_32 + var_75_33 + arg_75_0 and not isNil(var_75_31) and arg_72_1.var_.characterEffect1148ui_story then
				arg_72_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_75_35 = 0

			if var_75_35 < arg_72_1.time_ and arg_72_1.time_ <= var_75_35 + arg_75_0 then
				arg_72_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_75_36 = 0

			if var_75_36 < arg_72_1.time_ and arg_72_1.time_ <= var_75_36 + arg_75_0 then
				arg_72_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_75_37 = 0

			if var_75_37 < arg_72_1.time_ and arg_72_1.time_ <= var_75_37 + arg_75_0 then
				arg_72_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_75_38 = 0
			local var_75_39 = 0.15

			if var_75_38 < arg_72_1.time_ and arg_72_1.time_ <= var_75_38 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_40 = arg_72_1:FormatText(StoryNameCfg[8].name)

				arg_72_1.leftNameTxt_.text = var_75_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_41 = arg_72_1:GetWordFromCfg(112231018)
				local var_75_42 = arg_72_1:FormatText(var_75_41.content)

				arg_72_1.text_.text = var_75_42

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_43 = 6
				local var_75_44 = utf8.len(var_75_42)
				local var_75_45 = var_75_43 <= 0 and var_75_39 or var_75_39 * (var_75_44 / var_75_43)

				if var_75_45 > 0 and var_75_39 < var_75_45 then
					arg_72_1.talkMaxDuration = var_75_45

					if var_75_45 + var_75_38 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_45 + var_75_38
					end
				end

				arg_72_1.text_.text = var_75_42
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231018", "story_v_out_112231.awb") ~= 0 then
					local var_75_46 = manager.audio:GetVoiceLength("story_v_out_112231", "112231018", "story_v_out_112231.awb") / 1000

					if var_75_46 + var_75_38 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_46 + var_75_38
					end

					if var_75_41.prefab_name ~= "" and arg_72_1.actors_[var_75_41.prefab_name] ~= nil then
						local var_75_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_41.prefab_name].transform, "story_v_out_112231", "112231018", "story_v_out_112231.awb")

						arg_72_1:RecordAudio("112231018", var_75_47)
						arg_72_1:RecordAudio("112231018", var_75_47)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_112231", "112231018", "story_v_out_112231.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_112231", "112231018", "story_v_out_112231.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_48 = math.max(var_75_39, arg_72_1.talkMaxDuration)

			if var_75_38 <= arg_72_1.time_ and arg_72_1.time_ < var_75_38 + var_75_48 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_38) / var_75_48

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_38 + var_75_48 and arg_72_1.time_ < var_75_38 + var_75_48 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play112231019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 112231019
		arg_76_1.duration_ = 3.7

		local var_76_0 = {
			ja = 3.7,
			ko = 2.333,
			zh = 2.366,
			en = 3.6
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
				arg_76_0:Play112231020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1027ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1027ui_story == nil then
				arg_76_1.var_.characterEffect1027ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.2

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1027ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1027ui_story then
				arg_76_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_79_4 = 0

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_79_5 = arg_76_1.actors_["1148ui_story"]
			local var_79_6 = 0

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 and not isNil(var_79_5) and arg_76_1.var_.characterEffect1148ui_story == nil then
				arg_76_1.var_.characterEffect1148ui_story = var_79_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_7 = 0.2

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_7 and not isNil(var_79_5) then
				local var_79_8 = (arg_76_1.time_ - var_79_6) / var_79_7

				if arg_76_1.var_.characterEffect1148ui_story and not isNil(var_79_5) then
					local var_79_9 = Mathf.Lerp(0, 0.5, var_79_8)

					arg_76_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1148ui_story.fillRatio = var_79_9
				end
			end

			if arg_76_1.time_ >= var_79_6 + var_79_7 and arg_76_1.time_ < var_79_6 + var_79_7 + arg_79_0 and not isNil(var_79_5) and arg_76_1.var_.characterEffect1148ui_story then
				local var_79_10 = 0.5

				arg_76_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1148ui_story.fillRatio = var_79_10
			end

			local var_79_11 = 0

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_79_12 = 0
			local var_79_13 = 0.25

			if var_79_12 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_14 = arg_76_1:FormatText(StoryNameCfg[56].name)

				arg_76_1.leftNameTxt_.text = var_79_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_15 = arg_76_1:GetWordFromCfg(112231019)
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

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231019", "story_v_out_112231.awb") ~= 0 then
					local var_79_20 = manager.audio:GetVoiceLength("story_v_out_112231", "112231019", "story_v_out_112231.awb") / 1000

					if var_79_20 + var_79_12 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_20 + var_79_12
					end

					if var_79_15.prefab_name ~= "" and arg_76_1.actors_[var_79_15.prefab_name] ~= nil then
						local var_79_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_15.prefab_name].transform, "story_v_out_112231", "112231019", "story_v_out_112231.awb")

						arg_76_1:RecordAudio("112231019", var_79_21)
						arg_76_1:RecordAudio("112231019", var_79_21)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_112231", "112231019", "story_v_out_112231.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_112231", "112231019", "story_v_out_112231.awb")
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
	Play112231020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 112231020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play112231021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1027ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1027ui_story == nil then
				arg_80_1.var_.characterEffect1027ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1027ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1027ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1027ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1027ui_story.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 1.15

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_8 = arg_80_1:GetWordFromCfg(112231020)
				local var_83_9 = arg_80_1:FormatText(var_83_8.content)

				arg_80_1.text_.text = var_83_9

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 46
				local var_83_11 = utf8.len(var_83_9)
				local var_83_12 = var_83_10 <= 0 and var_83_7 or var_83_7 * (var_83_11 / var_83_10)

				if var_83_12 > 0 and var_83_7 < var_83_12 then
					arg_80_1.talkMaxDuration = var_83_12

					if var_83_12 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_12 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_9
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_13 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_13 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_13

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_13 and arg_80_1.time_ < var_83_6 + var_83_13 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play112231021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 112231021
		arg_84_1.duration_ = 8.9

		local var_84_0 = {
			ja = 7.2,
			ko = 6.4,
			zh = 5.966,
			en = 8.9
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
				arg_84_0:Play112231022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1148ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1148ui_story == nil then
				arg_84_1.var_.characterEffect1148ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1148ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1148ui_story then
				arg_84_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_87_4 = 0

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action445")
			end

			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_87_6 = 0
			local var_87_7 = 0.625

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[8].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_9 = arg_84_1:GetWordFromCfg(112231021)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 25
				local var_87_12 = utf8.len(var_87_10)
				local var_87_13 = var_87_11 <= 0 and var_87_7 or var_87_7 * (var_87_12 / var_87_11)

				if var_87_13 > 0 and var_87_7 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231021", "story_v_out_112231.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231021", "story_v_out_112231.awb") / 1000

					if var_87_14 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_6
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_112231", "112231021", "story_v_out_112231.awb")

						arg_84_1:RecordAudio("112231021", var_87_15)
						arg_84_1:RecordAudio("112231021", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_112231", "112231021", "story_v_out_112231.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_112231", "112231021", "story_v_out_112231.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_16 and arg_84_1.time_ < var_87_6 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play112231022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 112231022
		arg_88_1.duration_ = 19.9

		local var_88_0 = {
			ja = 15.6,
			ko = 9.2,
			zh = 11.866,
			en = 19.9
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
				arg_88_0:Play112231023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action454")
			end

			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_91_2 = 0
			local var_91_3 = 1.375

			if var_91_2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_4 = arg_88_1:FormatText(StoryNameCfg[8].name)

				arg_88_1.leftNameTxt_.text = var_91_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_5 = arg_88_1:GetWordFromCfg(112231022)
				local var_91_6 = arg_88_1:FormatText(var_91_5.content)

				arg_88_1.text_.text = var_91_6

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 55
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

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231022", "story_v_out_112231.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_112231", "112231022", "story_v_out_112231.awb") / 1000

					if var_91_10 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_2
					end

					if var_91_5.prefab_name ~= "" and arg_88_1.actors_[var_91_5.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_5.prefab_name].transform, "story_v_out_112231", "112231022", "story_v_out_112231.awb")

						arg_88_1:RecordAudio("112231022", var_91_11)
						arg_88_1:RecordAudio("112231022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_112231", "112231022", "story_v_out_112231.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_112231", "112231022", "story_v_out_112231.awb")
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
	Play112231023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 112231023
		arg_92_1.duration_ = 5.33

		local var_92_0 = {
			ja = 5.233,
			ko = 4.266,
			zh = 3.566,
			en = 5.333
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
				arg_92_0:Play112231024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1148ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1148ui_story == nil then
				arg_92_1.var_.characterEffect1148ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.2

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1148ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1148ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1148ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1148ui_story.fillRatio = var_95_5
			end

			local var_95_6 = arg_92_1.actors_["1027ui_story"]
			local var_95_7 = 0

			if var_95_7 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 and not isNil(var_95_6) and arg_92_1.var_.characterEffect1027ui_story == nil then
				arg_92_1.var_.characterEffect1027ui_story = var_95_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_8 = 0.2

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_8 and not isNil(var_95_6) then
				local var_95_9 = (arg_92_1.time_ - var_95_7) / var_95_8

				if arg_92_1.var_.characterEffect1027ui_story and not isNil(var_95_6) then
					arg_92_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_7 + var_95_8 and arg_92_1.time_ < var_95_7 + var_95_8 + arg_95_0 and not isNil(var_95_6) and arg_92_1.var_.characterEffect1027ui_story then
				arg_92_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action424")
			end

			local var_95_11 = 0

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_95_12 = 0
			local var_95_13 = 0.475

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_14 = arg_92_1:FormatText(StoryNameCfg[56].name)

				arg_92_1.leftNameTxt_.text = var_95_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_15 = arg_92_1:GetWordFromCfg(112231023)
				local var_95_16 = arg_92_1:FormatText(var_95_15.content)

				arg_92_1.text_.text = var_95_16

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_17 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231023", "story_v_out_112231.awb") ~= 0 then
					local var_95_20 = manager.audio:GetVoiceLength("story_v_out_112231", "112231023", "story_v_out_112231.awb") / 1000

					if var_95_20 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_20 + var_95_12
					end

					if var_95_15.prefab_name ~= "" and arg_92_1.actors_[var_95_15.prefab_name] ~= nil then
						local var_95_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_15.prefab_name].transform, "story_v_out_112231", "112231023", "story_v_out_112231.awb")

						arg_92_1:RecordAudio("112231023", var_95_21)
						arg_92_1:RecordAudio("112231023", var_95_21)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_112231", "112231023", "story_v_out_112231.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_112231", "112231023", "story_v_out_112231.awb")
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
	Play112231024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 112231024
		arg_96_1.duration_ = 11.2

		local var_96_0 = {
			ja = 10.233,
			ko = 8.466,
			zh = 8.4,
			en = 11.2
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
				arg_96_0:Play112231025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1027ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1027ui_story == nil then
				arg_96_1.var_.characterEffect1027ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1027ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1027ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1027ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1027ui_story.fillRatio = var_99_5
			end

			local var_99_6 = arg_96_1.actors_["1148ui_story"]
			local var_99_7 = 0

			if var_99_7 < arg_96_1.time_ and arg_96_1.time_ <= var_99_7 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1148ui_story == nil then
				arg_96_1.var_.characterEffect1148ui_story = var_99_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_8 = 0.2

			if var_99_7 <= arg_96_1.time_ and arg_96_1.time_ < var_99_7 + var_99_8 and not isNil(var_99_6) then
				local var_99_9 = (arg_96_1.time_ - var_99_7) / var_99_8

				if arg_96_1.var_.characterEffect1148ui_story and not isNil(var_99_6) then
					arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_7 + var_99_8 and arg_96_1.time_ < var_99_7 + var_99_8 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1148ui_story then
				arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_99_11 = 0
			local var_99_12 = 0.95

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_13 = arg_96_1:FormatText(StoryNameCfg[8].name)

				arg_96_1.leftNameTxt_.text = var_99_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_14 = arg_96_1:GetWordFromCfg(112231024)
				local var_99_15 = arg_96_1:FormatText(var_99_14.content)

				arg_96_1.text_.text = var_99_15

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_16 = 38
				local var_99_17 = utf8.len(var_99_15)
				local var_99_18 = var_99_16 <= 0 and var_99_12 or var_99_12 * (var_99_17 / var_99_16)

				if var_99_18 > 0 and var_99_12 < var_99_18 then
					arg_96_1.talkMaxDuration = var_99_18

					if var_99_18 + var_99_11 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_11
					end
				end

				arg_96_1.text_.text = var_99_15
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231024", "story_v_out_112231.awb") ~= 0 then
					local var_99_19 = manager.audio:GetVoiceLength("story_v_out_112231", "112231024", "story_v_out_112231.awb") / 1000

					if var_99_19 + var_99_11 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_11
					end

					if var_99_14.prefab_name ~= "" and arg_96_1.actors_[var_99_14.prefab_name] ~= nil then
						local var_99_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_14.prefab_name].transform, "story_v_out_112231", "112231024", "story_v_out_112231.awb")

						arg_96_1:RecordAudio("112231024", var_99_20)
						arg_96_1:RecordAudio("112231024", var_99_20)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_112231", "112231024", "story_v_out_112231.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_112231", "112231024", "story_v_out_112231.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_21 = math.max(var_99_12, arg_96_1.talkMaxDuration)

			if var_99_11 <= arg_96_1.time_ and arg_96_1.time_ < var_99_11 + var_99_21 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_11) / var_99_21

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_11 + var_99_21 and arg_96_1.time_ < var_99_11 + var_99_21 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play112231025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 112231025
		arg_100_1.duration_ = 3.43

		local var_100_0 = {
			ja = 1.999999999999,
			ko = 2.3,
			zh = 2.466,
			en = 3.433
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
				arg_100_0:Play112231026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1027ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1027ui_story == nil then
				arg_100_1.var_.characterEffect1027ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1027ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1027ui_story then
				arg_100_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["1148ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1148ui_story == nil then
				arg_100_1.var_.characterEffect1148ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.2

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect1148ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1148ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1148ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1148ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_103_11 = 0
			local var_103_12 = 0.175

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_13 = arg_100_1:FormatText(StoryNameCfg[56].name)

				arg_100_1.leftNameTxt_.text = var_103_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_14 = arg_100_1:GetWordFromCfg(112231025)
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

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231025", "story_v_out_112231.awb") ~= 0 then
					local var_103_19 = manager.audio:GetVoiceLength("story_v_out_112231", "112231025", "story_v_out_112231.awb") / 1000

					if var_103_19 + var_103_11 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_19 + var_103_11
					end

					if var_103_14.prefab_name ~= "" and arg_100_1.actors_[var_103_14.prefab_name] ~= nil then
						local var_103_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_14.prefab_name].transform, "story_v_out_112231", "112231025", "story_v_out_112231.awb")

						arg_100_1:RecordAudio("112231025", var_103_20)
						arg_100_1:RecordAudio("112231025", var_103_20)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_112231", "112231025", "story_v_out_112231.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_112231", "112231025", "story_v_out_112231.awb")
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
	Play112231026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 112231026
		arg_104_1.duration_ = 2.83

		local var_104_0 = {
			ja = 2.833,
			ko = 1.866,
			zh = 2.066,
			en = 1.6
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
				arg_104_0:Play112231027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1027ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1027ui_story == nil then
				arg_104_1.var_.characterEffect1027ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1027ui_story and not isNil(var_107_0) then
					local var_107_4 = Mathf.Lerp(0, 0.5, var_107_3)

					arg_104_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1027ui_story.fillRatio = var_107_4
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1027ui_story then
				local var_107_5 = 0.5

				arg_104_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1027ui_story.fillRatio = var_107_5
			end

			local var_107_6 = 0
			local var_107_7 = 0.2

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_8 = arg_104_1:FormatText(StoryNameCfg[6].name)

				arg_104_1.leftNameTxt_.text = var_107_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_9 = arg_104_1:GetWordFromCfg(112231026)
				local var_107_10 = arg_104_1:FormatText(var_107_9.content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 8
				local var_107_12 = utf8.len(var_107_10)
				local var_107_13 = var_107_11 <= 0 and var_107_7 or var_107_7 * (var_107_12 / var_107_11)

				if var_107_13 > 0 and var_107_7 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231026", "story_v_out_112231.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231026", "story_v_out_112231.awb") / 1000

					if var_107_14 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_6
					end

					if var_107_9.prefab_name ~= "" and arg_104_1.actors_[var_107_9.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_9.prefab_name].transform, "story_v_out_112231", "112231026", "story_v_out_112231.awb")

						arg_104_1:RecordAudio("112231026", var_107_15)
						arg_104_1:RecordAudio("112231026", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_112231", "112231026", "story_v_out_112231.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_112231", "112231026", "story_v_out_112231.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_16 and arg_104_1.time_ < var_107_6 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play112231027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 112231027
		arg_108_1.duration_ = 5.43

		local var_108_0 = {
			ja = 5,
			ko = 5.333,
			zh = 5.433,
			en = 4.333
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
				arg_108_0:Play112231028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.6

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[9].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(112231027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231027", "story_v_out_112231.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231027", "story_v_out_112231.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_112231", "112231027", "story_v_out_112231.awb")

						arg_108_1:RecordAudio("112231027", var_111_9)
						arg_108_1:RecordAudio("112231027", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_112231", "112231027", "story_v_out_112231.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_112231", "112231027", "story_v_out_112231.awb")
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
	Play112231028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 112231028
		arg_112_1.duration_ = 5.63

		local var_112_0 = {
			ja = 3.233,
			ko = 5.133,
			zh = 5.633,
			en = 5.066
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
				arg_112_0:Play112231029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.6

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[202].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(112231028)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 24
				local var_115_6 = utf8.len(var_115_4)
				local var_115_7 = var_115_5 <= 0 and var_115_1 or var_115_1 * (var_115_6 / var_115_5)

				if var_115_7 > 0 and var_115_1 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231028", "story_v_out_112231.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231028", "story_v_out_112231.awb") / 1000

					if var_115_8 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_0
					end

					if var_115_3.prefab_name ~= "" and arg_112_1.actors_[var_115_3.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_3.prefab_name].transform, "story_v_out_112231", "112231028", "story_v_out_112231.awb")

						arg_112_1:RecordAudio("112231028", var_115_9)
						arg_112_1:RecordAudio("112231028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_112231", "112231028", "story_v_out_112231.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_112231", "112231028", "story_v_out_112231.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_10 and arg_112_1.time_ < var_115_0 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play112231029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 112231029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play112231030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.625

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[7].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(112231029)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 25
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_8 and arg_116_1.time_ < var_119_0 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play112231030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 112231030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play112231031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.15

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(112231030)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 6
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_8 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_8 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_8

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_8 and arg_120_1.time_ < var_123_0 + var_123_8 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play112231031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 112231031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play112231032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1027ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1027ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1027ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = arg_124_1.actors_["1148ui_story"].transform
			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1.var_.moveOldPos1148ui_story = var_127_9.localPosition
			end

			local var_127_11 = 0.001

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_11 then
				local var_127_12 = (arg_124_1.time_ - var_127_10) / var_127_11
				local var_127_13 = Vector3.New(0, 100, 0)

				var_127_9.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1148ui_story, var_127_13, var_127_12)

				local var_127_14 = manager.ui.mainCamera.transform.position - var_127_9.position

				var_127_9.forward = Vector3.New(var_127_14.x, var_127_14.y, var_127_14.z)

				local var_127_15 = var_127_9.localEulerAngles

				var_127_15.z = 0
				var_127_15.x = 0
				var_127_9.localEulerAngles = var_127_15
			end

			if arg_124_1.time_ >= var_127_10 + var_127_11 and arg_124_1.time_ < var_127_10 + var_127_11 + arg_127_0 then
				var_127_9.localPosition = Vector3.New(0, 100, 0)

				local var_127_16 = manager.ui.mainCamera.transform.position - var_127_9.position

				var_127_9.forward = Vector3.New(var_127_16.x, var_127_16.y, var_127_16.z)

				local var_127_17 = var_127_9.localEulerAngles

				var_127_17.z = 0
				var_127_17.x = 0
				var_127_9.localEulerAngles = var_127_17
			end

			local var_127_18 = 0
			local var_127_19 = 0.725

			if var_127_18 < arg_124_1.time_ and arg_124_1.time_ <= var_127_18 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_20 = arg_124_1:GetWordFromCfg(112231031)
				local var_127_21 = arg_124_1:FormatText(var_127_20.content)

				arg_124_1.text_.text = var_127_21

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_22 = 29
				local var_127_23 = utf8.len(var_127_21)
				local var_127_24 = var_127_22 <= 0 and var_127_19 or var_127_19 * (var_127_23 / var_127_22)

				if var_127_24 > 0 and var_127_19 < var_127_24 then
					arg_124_1.talkMaxDuration = var_127_24

					if var_127_24 + var_127_18 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_24 + var_127_18
					end
				end

				arg_124_1.text_.text = var_127_21
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_25 = math.max(var_127_19, arg_124_1.talkMaxDuration)

			if var_127_18 <= arg_124_1.time_ and arg_124_1.time_ < var_127_18 + var_127_25 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_18) / var_127_25

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_18 + var_127_25 and arg_124_1.time_ < var_127_18 + var_127_25 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play112231032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 112231032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play112231033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.3

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[7].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(112231032)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 12
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_8 and arg_128_1.time_ < var_131_0 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play112231033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 112231033
		arg_132_1.duration_ = 6.83

		local var_132_0 = {
			ja = 5.733,
			ko = 6.833,
			zh = 6.4,
			en = 4.766
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
				arg_132_0:Play112231034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1081ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1081ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(0, -0.92, -5.8)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1081ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["1081ui_story"]
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1081ui_story == nil then
				arg_132_1.var_.characterEffect1081ui_story = var_135_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.2

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 and not isNil(var_135_9) then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11

				if arg_132_1.var_.characterEffect1081ui_story and not isNil(var_135_9) then
					arg_132_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect1081ui_story then
				arg_132_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_135_13 = 0

			if var_135_13 < arg_132_1.time_ and arg_132_1.time_ <= var_135_13 + arg_135_0 then
				arg_132_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_135_14 = 0

			if var_135_14 < arg_132_1.time_ and arg_132_1.time_ <= var_135_14 + arg_135_0 then
				arg_132_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_135_15 = 0
			local var_135_16 = 0.8

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_17 = arg_132_1:FormatText(StoryNameCfg[202].name)

				arg_132_1.leftNameTxt_.text = var_135_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_18 = arg_132_1:GetWordFromCfg(112231033)
				local var_135_19 = arg_132_1:FormatText(var_135_18.content)

				arg_132_1.text_.text = var_135_19

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_20 = 32
				local var_135_21 = utf8.len(var_135_19)
				local var_135_22 = var_135_20 <= 0 and var_135_16 or var_135_16 * (var_135_21 / var_135_20)

				if var_135_22 > 0 and var_135_16 < var_135_22 then
					arg_132_1.talkMaxDuration = var_135_22

					if var_135_22 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_22 + var_135_15
					end
				end

				arg_132_1.text_.text = var_135_19
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231033", "story_v_out_112231.awb") ~= 0 then
					local var_135_23 = manager.audio:GetVoiceLength("story_v_out_112231", "112231033", "story_v_out_112231.awb") / 1000

					if var_135_23 + var_135_15 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_23 + var_135_15
					end

					if var_135_18.prefab_name ~= "" and arg_132_1.actors_[var_135_18.prefab_name] ~= nil then
						local var_135_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_18.prefab_name].transform, "story_v_out_112231", "112231033", "story_v_out_112231.awb")

						arg_132_1:RecordAudio("112231033", var_135_24)
						arg_132_1:RecordAudio("112231033", var_135_24)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_112231", "112231033", "story_v_out_112231.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_112231", "112231033", "story_v_out_112231.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_25 = math.max(var_135_16, arg_132_1.talkMaxDuration)

			if var_135_15 <= arg_132_1.time_ and arg_132_1.time_ < var_135_15 + var_135_25 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_15) / var_135_25

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_15 + var_135_25 and arg_132_1.time_ < var_135_15 + var_135_25 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play112231034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 112231034
		arg_136_1.duration_ = 3.3

		local var_136_0 = {
			ja = 2.966,
			ko = 3.3,
			zh = 2.933,
			en = 3.133
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play112231035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1081ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1081ui_story == nil then
				arg_136_1.var_.characterEffect1081ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1081ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1081ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1081ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1081ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 0.225

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_8 = arg_136_1:FormatText(StoryNameCfg[9].name)

				arg_136_1.leftNameTxt_.text = var_139_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_9 = arg_136_1:GetWordFromCfg(112231034)
				local var_139_10 = arg_136_1:FormatText(var_139_9.content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 9
				local var_139_12 = utf8.len(var_139_10)
				local var_139_13 = var_139_11 <= 0 and var_139_7 or var_139_7 * (var_139_12 / var_139_11)

				if var_139_13 > 0 and var_139_7 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_10
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231034", "story_v_out_112231.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231034", "story_v_out_112231.awb") / 1000

					if var_139_14 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_6
					end

					if var_139_9.prefab_name ~= "" and arg_136_1.actors_[var_139_9.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_9.prefab_name].transform, "story_v_out_112231", "112231034", "story_v_out_112231.awb")

						arg_136_1:RecordAudio("112231034", var_139_15)
						arg_136_1:RecordAudio("112231034", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_112231", "112231034", "story_v_out_112231.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_112231", "112231034", "story_v_out_112231.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_16 and arg_136_1.time_ < var_139_6 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play112231035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 112231035
		arg_140_1.duration_ = 6.3

		local var_140_0 = {
			ja = 6.3,
			ko = 3.6,
			zh = 4.9,
			en = 2.9
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play112231036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1081ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1081ui_story == nil then
				arg_140_1.var_.characterEffect1081ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1081ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1081ui_story then
				arg_140_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_143_4 = 0

			if var_143_4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action474")
			end

			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_143_6 = 0
			local var_143_7 = 0.4

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[202].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_9 = arg_140_1:GetWordFromCfg(112231035)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 16
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231035", "story_v_out_112231.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231035", "story_v_out_112231.awb") / 1000

					if var_143_14 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_6
					end

					if var_143_9.prefab_name ~= "" and arg_140_1.actors_[var_143_9.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_9.prefab_name].transform, "story_v_out_112231", "112231035", "story_v_out_112231.awb")

						arg_140_1:RecordAudio("112231035", var_143_15)
						arg_140_1:RecordAudio("112231035", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_112231", "112231035", "story_v_out_112231.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_112231", "112231035", "story_v_out_112231.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_16 and arg_140_1.time_ < var_143_6 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play112231036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 112231036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play112231037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1081ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1081ui_story = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, 100, 0)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1081ui_story, var_147_4, var_147_3)

				local var_147_5 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_5.x, var_147_5.y, var_147_5.z)

				local var_147_6 = var_147_0.localEulerAngles

				var_147_6.z = 0
				var_147_6.x = 0
				var_147_0.localEulerAngles = var_147_6
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, 100, 0)

				local var_147_7 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_7.x, var_147_7.y, var_147_7.z)

				local var_147_8 = var_147_0.localEulerAngles

				var_147_8.z = 0
				var_147_8.x = 0
				var_147_0.localEulerAngles = var_147_8
			end

			local var_147_9 = 0
			local var_147_10 = 1.1

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_11 = arg_144_1:GetWordFromCfg(112231036)
				local var_147_12 = arg_144_1:FormatText(var_147_11.content)

				arg_144_1.text_.text = var_147_12

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_13 = 44
				local var_147_14 = utf8.len(var_147_12)
				local var_147_15 = var_147_13 <= 0 and var_147_10 or var_147_10 * (var_147_14 / var_147_13)

				if var_147_15 > 0 and var_147_10 < var_147_15 then
					arg_144_1.talkMaxDuration = var_147_15

					if var_147_15 + var_147_9 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_15 + var_147_9
					end
				end

				arg_144_1.text_.text = var_147_12
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_10, arg_144_1.talkMaxDuration)

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_9) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_9 + var_147_16 and arg_144_1.time_ < var_147_9 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play112231037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 112231037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play112231038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 1

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_2 = arg_148_1:GetWordFromCfg(112231037)
				local var_151_3 = arg_148_1:FormatText(var_151_2.content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 40
				local var_151_5 = utf8.len(var_151_3)
				local var_151_6 = var_151_4 <= 0 and var_151_1 or var_151_1 * (var_151_5 / var_151_4)

				if var_151_6 > 0 and var_151_1 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_7 and arg_148_1.time_ < var_151_0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play112231038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 112231038
		arg_152_1.duration_ = 8.8

		local var_152_0 = {
			ja = 6.866,
			ko = 7.433,
			zh = 6.966,
			en = 8.8
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
				arg_152_0:Play112231039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1081ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1081ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, -0.92, -5.8)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1081ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["1081ui_story"]
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1081ui_story == nil then
				arg_152_1.var_.characterEffect1081ui_story = var_155_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.2

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 and not isNil(var_155_9) then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11

				if arg_152_1.var_.characterEffect1081ui_story and not isNil(var_155_9) then
					arg_152_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1081ui_story then
				arg_152_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_155_13 = 0

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			local var_155_14 = 0

			if var_155_14 < arg_152_1.time_ and arg_152_1.time_ <= var_155_14 + arg_155_0 then
				arg_152_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_155_15 = 0
			local var_155_16 = 0.65

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[202].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(112231038)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 26
				local var_155_21 = utf8.len(var_155_19)
				local var_155_22 = var_155_20 <= 0 and var_155_16 or var_155_16 * (var_155_21 / var_155_20)

				if var_155_22 > 0 and var_155_16 < var_155_22 then
					arg_152_1.talkMaxDuration = var_155_22

					if var_155_22 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_15
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231038", "story_v_out_112231.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_out_112231", "112231038", "story_v_out_112231.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_out_112231", "112231038", "story_v_out_112231.awb")

						arg_152_1:RecordAudio("112231038", var_155_24)
						arg_152_1:RecordAudio("112231038", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_112231", "112231038", "story_v_out_112231.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_112231", "112231038", "story_v_out_112231.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_16, arg_152_1.talkMaxDuration)

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_25 and arg_152_1.time_ < var_155_15 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play112231039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 112231039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play112231040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1081ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1081ui_story == nil then
				arg_156_1.var_.characterEffect1081ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1081ui_story and not isNil(var_159_0) then
					local var_159_4 = Mathf.Lerp(0, 0.5, var_159_3)

					arg_156_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1081ui_story.fillRatio = var_159_4
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1081ui_story then
				local var_159_5 = 0.5

				arg_156_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1081ui_story.fillRatio = var_159_5
			end

			local var_159_6 = 0

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_2")
			end

			local var_159_7 = 0
			local var_159_8 = 0.725

			if var_159_7 < arg_156_1.time_ and arg_156_1.time_ <= var_159_7 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_9 = arg_156_1:GetWordFromCfg(112231039)
				local var_159_10 = arg_156_1:FormatText(var_159_9.content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 29
				local var_159_12 = utf8.len(var_159_10)
				local var_159_13 = var_159_11 <= 0 and var_159_8 or var_159_8 * (var_159_12 / var_159_11)

				if var_159_13 > 0 and var_159_8 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_7 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_7
					end
				end

				arg_156_1.text_.text = var_159_10
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_8, arg_156_1.talkMaxDuration)

			if var_159_7 <= arg_156_1.time_ and arg_156_1.time_ < var_159_7 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_7) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_7 + var_159_14 and arg_156_1.time_ < var_159_7 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play112231040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 112231040
		arg_160_1.duration_ = 2.17

		local var_160_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.066,
			en = 2.166
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
				arg_160_0:Play112231041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1081ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1081ui_story == nil then
				arg_160_1.var_.characterEffect1081ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1081ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1081ui_story then
				arg_160_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_163_4 = 0

			if var_163_4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_163_5 = 0
			local var_163_6 = 0.075

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_7 = arg_160_1:FormatText(StoryNameCfg[202].name)

				arg_160_1.leftNameTxt_.text = var_163_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_8 = arg_160_1:GetWordFromCfg(112231040)
				local var_163_9 = arg_160_1:FormatText(var_163_8.content)

				arg_160_1.text_.text = var_163_9

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_10 = 3
				local var_163_11 = utf8.len(var_163_9)
				local var_163_12 = var_163_10 <= 0 and var_163_6 or var_163_6 * (var_163_11 / var_163_10)

				if var_163_12 > 0 and var_163_6 < var_163_12 then
					arg_160_1.talkMaxDuration = var_163_12

					if var_163_12 + var_163_5 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_5
					end
				end

				arg_160_1.text_.text = var_163_9
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231040", "story_v_out_112231.awb") ~= 0 then
					local var_163_13 = manager.audio:GetVoiceLength("story_v_out_112231", "112231040", "story_v_out_112231.awb") / 1000

					if var_163_13 + var_163_5 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_5
					end

					if var_163_8.prefab_name ~= "" and arg_160_1.actors_[var_163_8.prefab_name] ~= nil then
						local var_163_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_8.prefab_name].transform, "story_v_out_112231", "112231040", "story_v_out_112231.awb")

						arg_160_1:RecordAudio("112231040", var_163_14)
						arg_160_1:RecordAudio("112231040", var_163_14)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_112231", "112231040", "story_v_out_112231.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_112231", "112231040", "story_v_out_112231.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_15 = math.max(var_163_6, arg_160_1.talkMaxDuration)

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_15 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_5) / var_163_15

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_5 + var_163_15 and arg_160_1.time_ < var_163_5 + var_163_15 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play112231041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 112231041
		arg_164_1.duration_ = 6.4

		local var_164_0 = {
			ja = 5.133,
			ko = 6.4,
			zh = 4.166,
			en = 4.833
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
				arg_164_0:Play112231042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1081ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1081ui_story == nil then
				arg_164_1.var_.characterEffect1081ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.2

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1081ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1081ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1081ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1081ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 0.35

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_8 = arg_164_1:FormatText(StoryNameCfg[6].name)

				arg_164_1.leftNameTxt_.text = var_167_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_9 = arg_164_1:GetWordFromCfg(112231041)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 14
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_7 or var_167_7 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_7 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231041", "story_v_out_112231.awb") ~= 0 then
					local var_167_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231041", "story_v_out_112231.awb") / 1000

					if var_167_14 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_6
					end

					if var_167_9.prefab_name ~= "" and arg_164_1.actors_[var_167_9.prefab_name] ~= nil then
						local var_167_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_9.prefab_name].transform, "story_v_out_112231", "112231041", "story_v_out_112231.awb")

						arg_164_1:RecordAudio("112231041", var_167_15)
						arg_164_1:RecordAudio("112231041", var_167_15)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_112231", "112231041", "story_v_out_112231.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_112231", "112231041", "story_v_out_112231.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_16 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_16 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_16

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_16 and arg_164_1.time_ < var_167_6 + var_167_16 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play112231042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 112231042
		arg_168_1.duration_ = 7.53

		local var_168_0 = {
			ja = 6.233,
			ko = 2.933,
			zh = 2,
			en = 7.533
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
				arg_168_0:Play112231043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1081ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1081ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(-0.7, -0.92, -5.8)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1081ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(-0.7, -0.92, -5.8)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = "1039ui_story"

			if arg_168_1.actors_[var_171_9] == nil then
				local var_171_10 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_171_10) then
					local var_171_11 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_168_1.stage_.transform)

					var_171_11.name = var_171_9
					var_171_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_168_1.actors_[var_171_9] = var_171_11

					local var_171_12 = var_171_11:GetComponentInChildren(typeof(CharacterEffect))

					var_171_12.enabled = true

					local var_171_13 = GameObjectTools.GetOrAddComponent(var_171_11, typeof(DynamicBoneHelper))

					if var_171_13 then
						var_171_13:EnableDynamicBone(false)
					end

					arg_168_1:ShowWeapon(var_171_12.transform, false)

					arg_168_1.var_[var_171_9 .. "Animator"] = var_171_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_168_1.var_[var_171_9 .. "Animator"].applyRootMotion = true
					arg_168_1.var_[var_171_9 .. "LipSync"] = var_171_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_171_14 = arg_168_1.actors_["1039ui_story"].transform
			local var_171_15 = 0

			if var_171_15 < arg_168_1.time_ and arg_168_1.time_ <= var_171_15 + arg_171_0 then
				arg_168_1.var_.moveOldPos1039ui_story = var_171_14.localPosition

				local var_171_16 = "1039ui_story"

				arg_168_1:ShowWeapon(arg_168_1.var_[var_171_16 .. "Animator"].transform, false)
			end

			local var_171_17 = 0.001

			if var_171_15 <= arg_168_1.time_ and arg_168_1.time_ < var_171_15 + var_171_17 then
				local var_171_18 = (arg_168_1.time_ - var_171_15) / var_171_17
				local var_171_19 = Vector3.New(0.7, -1.01, -5.9)

				var_171_14.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1039ui_story, var_171_19, var_171_18)

				local var_171_20 = manager.ui.mainCamera.transform.position - var_171_14.position

				var_171_14.forward = Vector3.New(var_171_20.x, var_171_20.y, var_171_20.z)

				local var_171_21 = var_171_14.localEulerAngles

				var_171_21.z = 0
				var_171_21.x = 0
				var_171_14.localEulerAngles = var_171_21
			end

			if arg_168_1.time_ >= var_171_15 + var_171_17 and arg_168_1.time_ < var_171_15 + var_171_17 + arg_171_0 then
				var_171_14.localPosition = Vector3.New(0.7, -1.01, -5.9)

				local var_171_22 = manager.ui.mainCamera.transform.position - var_171_14.position

				var_171_14.forward = Vector3.New(var_171_22.x, var_171_22.y, var_171_22.z)

				local var_171_23 = var_171_14.localEulerAngles

				var_171_23.z = 0
				var_171_23.x = 0
				var_171_14.localEulerAngles = var_171_23
			end

			local var_171_24 = arg_168_1.actors_["1039ui_story"]
			local var_171_25 = 0

			if var_171_25 < arg_168_1.time_ and arg_168_1.time_ <= var_171_25 + arg_171_0 and not isNil(var_171_24) and arg_168_1.var_.characterEffect1039ui_story == nil then
				arg_168_1.var_.characterEffect1039ui_story = var_171_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_26 = 0.2

			if var_171_25 <= arg_168_1.time_ and arg_168_1.time_ < var_171_25 + var_171_26 and not isNil(var_171_24) then
				local var_171_27 = (arg_168_1.time_ - var_171_25) / var_171_26

				if arg_168_1.var_.characterEffect1039ui_story and not isNil(var_171_24) then
					arg_168_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_25 + var_171_26 and arg_168_1.time_ < var_171_25 + var_171_26 + arg_171_0 and not isNil(var_171_24) and arg_168_1.var_.characterEffect1039ui_story then
				arg_168_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_171_28 = 0

			if var_171_28 < arg_168_1.time_ and arg_168_1.time_ <= var_171_28 + arg_171_0 then
				arg_168_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			local var_171_29 = 0

			if var_171_29 < arg_168_1.time_ and arg_168_1.time_ <= var_171_29 + arg_171_0 then
				arg_168_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_171_30 = 0
			local var_171_31 = 0.175

			if var_171_30 < arg_168_1.time_ and arg_168_1.time_ <= var_171_30 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_32 = arg_168_1:FormatText(StoryNameCfg[9].name)

				arg_168_1.leftNameTxt_.text = var_171_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_33 = arg_168_1:GetWordFromCfg(112231042)
				local var_171_34 = arg_168_1:FormatText(var_171_33.content)

				arg_168_1.text_.text = var_171_34

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_35 = 7
				local var_171_36 = utf8.len(var_171_34)
				local var_171_37 = var_171_35 <= 0 and var_171_31 or var_171_31 * (var_171_36 / var_171_35)

				if var_171_37 > 0 and var_171_31 < var_171_37 then
					arg_168_1.talkMaxDuration = var_171_37

					if var_171_37 + var_171_30 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_37 + var_171_30
					end
				end

				arg_168_1.text_.text = var_171_34
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231042", "story_v_out_112231.awb") ~= 0 then
					local var_171_38 = manager.audio:GetVoiceLength("story_v_out_112231", "112231042", "story_v_out_112231.awb") / 1000

					if var_171_38 + var_171_30 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_38 + var_171_30
					end

					if var_171_33.prefab_name ~= "" and arg_168_1.actors_[var_171_33.prefab_name] ~= nil then
						local var_171_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_33.prefab_name].transform, "story_v_out_112231", "112231042", "story_v_out_112231.awb")

						arg_168_1:RecordAudio("112231042", var_171_39)
						arg_168_1:RecordAudio("112231042", var_171_39)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_112231", "112231042", "story_v_out_112231.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_112231", "112231042", "story_v_out_112231.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_40 = math.max(var_171_31, arg_168_1.talkMaxDuration)

			if var_171_30 <= arg_168_1.time_ and arg_168_1.time_ < var_171_30 + var_171_40 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_30) / var_171_40

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_30 + var_171_40 and arg_168_1.time_ < var_171_30 + var_171_40 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play112231043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 112231043
		arg_172_1.duration_ = 3.23

		local var_172_0 = {
			ja = 3.133,
			ko = 2.5,
			zh = 2.733,
			en = 3.233
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
				arg_172_0:Play112231044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1039ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1039ui_story == nil then
				arg_172_1.var_.characterEffect1039ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1039ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1039ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1039ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1039ui_story.fillRatio = var_175_5
			end

			local var_175_6 = arg_172_1.actors_["1081ui_story"]
			local var_175_7 = 0

			if var_175_7 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 and not isNil(var_175_6) and arg_172_1.var_.characterEffect1081ui_story == nil then
				arg_172_1.var_.characterEffect1081ui_story = var_175_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_8 = 0.2

			if var_175_7 <= arg_172_1.time_ and arg_172_1.time_ < var_175_7 + var_175_8 and not isNil(var_175_6) then
				local var_175_9 = (arg_172_1.time_ - var_175_7) / var_175_8

				if arg_172_1.var_.characterEffect1081ui_story and not isNil(var_175_6) then
					arg_172_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_7 + var_175_8 and arg_172_1.time_ < var_175_7 + var_175_8 + arg_175_0 and not isNil(var_175_6) and arg_172_1.var_.characterEffect1081ui_story then
				arg_172_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			local var_175_11 = 0

			if var_175_11 < arg_172_1.time_ and arg_172_1.time_ <= var_175_11 + arg_175_0 then
				arg_172_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_175_12 = 0
			local var_175_13 = 0.225

			if var_175_12 < arg_172_1.time_ and arg_172_1.time_ <= var_175_12 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_14 = arg_172_1:FormatText(StoryNameCfg[202].name)

				arg_172_1.leftNameTxt_.text = var_175_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_15 = arg_172_1:GetWordFromCfg(112231043)
				local var_175_16 = arg_172_1:FormatText(var_175_15.content)

				arg_172_1.text_.text = var_175_16

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_17 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231043", "story_v_out_112231.awb") ~= 0 then
					local var_175_20 = manager.audio:GetVoiceLength("story_v_out_112231", "112231043", "story_v_out_112231.awb") / 1000

					if var_175_20 + var_175_12 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_20 + var_175_12
					end

					if var_175_15.prefab_name ~= "" and arg_172_1.actors_[var_175_15.prefab_name] ~= nil then
						local var_175_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_15.prefab_name].transform, "story_v_out_112231", "112231043", "story_v_out_112231.awb")

						arg_172_1:RecordAudio("112231043", var_175_21)
						arg_172_1:RecordAudio("112231043", var_175_21)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_112231", "112231043", "story_v_out_112231.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_112231", "112231043", "story_v_out_112231.awb")
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
	Play112231044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 112231044
		arg_176_1.duration_ = 11.53

		local var_176_0 = {
			ja = 11.533,
			ko = 5.933,
			zh = 6.866,
			en = 5.9
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
				arg_176_0:Play112231045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1081ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1081ui_story == nil then
				arg_176_1.var_.characterEffect1081ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1081ui_story and not isNil(var_179_0) then
					local var_179_4 = Mathf.Lerp(0, 0.5, var_179_3)

					arg_176_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1081ui_story.fillRatio = var_179_4
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1081ui_story then
				local var_179_5 = 0.5

				arg_176_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1081ui_story.fillRatio = var_179_5
			end

			local var_179_6 = arg_176_1.actors_["1039ui_story"]
			local var_179_7 = 0

			if var_179_7 < arg_176_1.time_ and arg_176_1.time_ <= var_179_7 + arg_179_0 and not isNil(var_179_6) and arg_176_1.var_.characterEffect1039ui_story == nil then
				arg_176_1.var_.characterEffect1039ui_story = var_179_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_8 = 0.2

			if var_179_7 <= arg_176_1.time_ and arg_176_1.time_ < var_179_7 + var_179_8 and not isNil(var_179_6) then
				local var_179_9 = (arg_176_1.time_ - var_179_7) / var_179_8

				if arg_176_1.var_.characterEffect1039ui_story and not isNil(var_179_6) then
					arg_176_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_7 + var_179_8 and arg_176_1.time_ < var_179_7 + var_179_8 + arg_179_0 and not isNil(var_179_6) and arg_176_1.var_.characterEffect1039ui_story then
				arg_176_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_179_10 = 0

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 then
				arg_176_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action446")
			end

			local var_179_11 = 0

			if var_179_11 < arg_176_1.time_ and arg_176_1.time_ <= var_179_11 + arg_179_0 then
				arg_176_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_179_12 = 0
			local var_179_13 = 0.725

			if var_179_12 < arg_176_1.time_ and arg_176_1.time_ <= var_179_12 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_14 = arg_176_1:FormatText(StoryNameCfg[9].name)

				arg_176_1.leftNameTxt_.text = var_179_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_15 = arg_176_1:GetWordFromCfg(112231044)
				local var_179_16 = arg_176_1:FormatText(var_179_15.content)

				arg_176_1.text_.text = var_179_16

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_17 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231044", "story_v_out_112231.awb") ~= 0 then
					local var_179_20 = manager.audio:GetVoiceLength("story_v_out_112231", "112231044", "story_v_out_112231.awb") / 1000

					if var_179_20 + var_179_12 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_20 + var_179_12
					end

					if var_179_15.prefab_name ~= "" and arg_176_1.actors_[var_179_15.prefab_name] ~= nil then
						local var_179_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_15.prefab_name].transform, "story_v_out_112231", "112231044", "story_v_out_112231.awb")

						arg_176_1:RecordAudio("112231044", var_179_21)
						arg_176_1:RecordAudio("112231044", var_179_21)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_112231", "112231044", "story_v_out_112231.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_112231", "112231044", "story_v_out_112231.awb")
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
	Play112231045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 112231045
		arg_180_1.duration_ = 6.4

		local var_180_0 = {
			ja = 5.233,
			ko = 4.933,
			zh = 3.6,
			en = 6.4
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
				arg_180_0:Play112231046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1081ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1081ui_story == nil then
				arg_180_1.var_.characterEffect1081ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1081ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1081ui_story then
				arg_180_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_183_4 = arg_180_1.actors_["1039ui_story"]
			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect1039ui_story == nil then
				arg_180_1.var_.characterEffect1039ui_story = var_183_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_6 = 0.2

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_6 and not isNil(var_183_4) then
				local var_183_7 = (arg_180_1.time_ - var_183_5) / var_183_6

				if arg_180_1.var_.characterEffect1039ui_story and not isNil(var_183_4) then
					local var_183_8 = Mathf.Lerp(0, 0.5, var_183_7)

					arg_180_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1039ui_story.fillRatio = var_183_8
				end
			end

			if arg_180_1.time_ >= var_183_5 + var_183_6 and arg_180_1.time_ < var_183_5 + var_183_6 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect1039ui_story then
				local var_183_9 = 0.5

				arg_180_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1039ui_story.fillRatio = var_183_9
			end

			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 then
				arg_180_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action457")
			end

			local var_183_11 = 0

			if var_183_11 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				arg_180_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_183_12 = 0
			local var_183_13 = 0.5

			if var_183_12 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_14 = arg_180_1:FormatText(StoryNameCfg[202].name)

				arg_180_1.leftNameTxt_.text = var_183_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_15 = arg_180_1:GetWordFromCfg(112231045)
				local var_183_16 = arg_180_1:FormatText(var_183_15.content)

				arg_180_1.text_.text = var_183_16

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_17 = 20
				local var_183_18 = utf8.len(var_183_16)
				local var_183_19 = var_183_17 <= 0 and var_183_13 or var_183_13 * (var_183_18 / var_183_17)

				if var_183_19 > 0 and var_183_13 < var_183_19 then
					arg_180_1.talkMaxDuration = var_183_19

					if var_183_19 + var_183_12 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_19 + var_183_12
					end
				end

				arg_180_1.text_.text = var_183_16
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231045", "story_v_out_112231.awb") ~= 0 then
					local var_183_20 = manager.audio:GetVoiceLength("story_v_out_112231", "112231045", "story_v_out_112231.awb") / 1000

					if var_183_20 + var_183_12 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_20 + var_183_12
					end

					if var_183_15.prefab_name ~= "" and arg_180_1.actors_[var_183_15.prefab_name] ~= nil then
						local var_183_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_15.prefab_name].transform, "story_v_out_112231", "112231045", "story_v_out_112231.awb")

						arg_180_1:RecordAudio("112231045", var_183_21)
						arg_180_1:RecordAudio("112231045", var_183_21)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_112231", "112231045", "story_v_out_112231.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_112231", "112231045", "story_v_out_112231.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_22 = math.max(var_183_13, arg_180_1.talkMaxDuration)

			if var_183_12 <= arg_180_1.time_ and arg_180_1.time_ < var_183_12 + var_183_22 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_12) / var_183_22

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_12 + var_183_22 and arg_180_1.time_ < var_183_12 + var_183_22 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play112231046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 112231046
		arg_184_1.duration_ = 11.13

		local var_184_0 = {
			ja = 8.066,
			ko = 7.533,
			zh = 6.266,
			en = 11.133
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
				arg_184_0:Play112231047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1081ui_story"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos1081ui_story = var_187_0.localPosition
			end

			local var_187_2 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2
				local var_187_4 = Vector3.New(0, 100, 0)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1081ui_story, var_187_4, var_187_3)

				local var_187_5 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_5.x, var_187_5.y, var_187_5.z)

				local var_187_6 = var_187_0.localEulerAngles

				var_187_6.z = 0
				var_187_6.x = 0
				var_187_0.localEulerAngles = var_187_6
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(0, 100, 0)

				local var_187_7 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_7.x, var_187_7.y, var_187_7.z)

				local var_187_8 = var_187_0.localEulerAngles

				var_187_8.z = 0
				var_187_8.x = 0
				var_187_0.localEulerAngles = var_187_8
			end

			local var_187_9 = arg_184_1.actors_["1039ui_story"].transform
			local var_187_10 = 0

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 then
				arg_184_1.var_.moveOldPos1039ui_story = var_187_9.localPosition
			end

			local var_187_11 = 0.001

			if var_187_10 <= arg_184_1.time_ and arg_184_1.time_ < var_187_10 + var_187_11 then
				local var_187_12 = (arg_184_1.time_ - var_187_10) / var_187_11
				local var_187_13 = Vector3.New(0, 100, 0)

				var_187_9.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1039ui_story, var_187_13, var_187_12)

				local var_187_14 = manager.ui.mainCamera.transform.position - var_187_9.position

				var_187_9.forward = Vector3.New(var_187_14.x, var_187_14.y, var_187_14.z)

				local var_187_15 = var_187_9.localEulerAngles

				var_187_15.z = 0
				var_187_15.x = 0
				var_187_9.localEulerAngles = var_187_15
			end

			if arg_184_1.time_ >= var_187_10 + var_187_11 and arg_184_1.time_ < var_187_10 + var_187_11 + arg_187_0 then
				var_187_9.localPosition = Vector3.New(0, 100, 0)

				local var_187_16 = manager.ui.mainCamera.transform.position - var_187_9.position

				var_187_9.forward = Vector3.New(var_187_16.x, var_187_16.y, var_187_16.z)

				local var_187_17 = var_187_9.localEulerAngles

				var_187_17.z = 0
				var_187_17.x = 0
				var_187_9.localEulerAngles = var_187_17
			end

			local var_187_18 = arg_184_1.actors_["1148ui_story"].transform
			local var_187_19 = 0

			if var_187_19 < arg_184_1.time_ and arg_184_1.time_ <= var_187_19 + arg_187_0 then
				arg_184_1.var_.moveOldPos1148ui_story = var_187_18.localPosition
			end

			local var_187_20 = 0.001

			if var_187_19 <= arg_184_1.time_ and arg_184_1.time_ < var_187_19 + var_187_20 then
				local var_187_21 = (arg_184_1.time_ - var_187_19) / var_187_20
				local var_187_22 = Vector3.New(0, -0.8, -6.2)

				var_187_18.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1148ui_story, var_187_22, var_187_21)

				local var_187_23 = manager.ui.mainCamera.transform.position - var_187_18.position

				var_187_18.forward = Vector3.New(var_187_23.x, var_187_23.y, var_187_23.z)

				local var_187_24 = var_187_18.localEulerAngles

				var_187_24.z = 0
				var_187_24.x = 0
				var_187_18.localEulerAngles = var_187_24
			end

			if arg_184_1.time_ >= var_187_19 + var_187_20 and arg_184_1.time_ < var_187_19 + var_187_20 + arg_187_0 then
				var_187_18.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_187_25 = manager.ui.mainCamera.transform.position - var_187_18.position

				var_187_18.forward = Vector3.New(var_187_25.x, var_187_25.y, var_187_25.z)

				local var_187_26 = var_187_18.localEulerAngles

				var_187_26.z = 0
				var_187_26.x = 0
				var_187_18.localEulerAngles = var_187_26
			end

			local var_187_27 = arg_184_1.actors_["1148ui_story"]
			local var_187_28 = 0

			if var_187_28 < arg_184_1.time_ and arg_184_1.time_ <= var_187_28 + arg_187_0 and not isNil(var_187_27) and arg_184_1.var_.characterEffect1148ui_story == nil then
				arg_184_1.var_.characterEffect1148ui_story = var_187_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_29 = 0.2

			if var_187_28 <= arg_184_1.time_ and arg_184_1.time_ < var_187_28 + var_187_29 and not isNil(var_187_27) then
				local var_187_30 = (arg_184_1.time_ - var_187_28) / var_187_29

				if arg_184_1.var_.characterEffect1148ui_story and not isNil(var_187_27) then
					arg_184_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_28 + var_187_29 and arg_184_1.time_ < var_187_28 + var_187_29 + arg_187_0 and not isNil(var_187_27) and arg_184_1.var_.characterEffect1148ui_story then
				arg_184_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_187_31 = 0

			if var_187_31 < arg_184_1.time_ and arg_184_1.time_ <= var_187_31 + arg_187_0 then
				arg_184_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_187_32 = 0

			if var_187_32 < arg_184_1.time_ and arg_184_1.time_ <= var_187_32 + arg_187_0 then
				arg_184_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_187_33 = 0
			local var_187_34 = 0.725

			if var_187_33 < arg_184_1.time_ and arg_184_1.time_ <= var_187_33 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_35 = arg_184_1:FormatText(StoryNameCfg[8].name)

				arg_184_1.leftNameTxt_.text = var_187_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_36 = arg_184_1:GetWordFromCfg(112231046)
				local var_187_37 = arg_184_1:FormatText(var_187_36.content)

				arg_184_1.text_.text = var_187_37

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_38 = 29
				local var_187_39 = utf8.len(var_187_37)
				local var_187_40 = var_187_38 <= 0 and var_187_34 or var_187_34 * (var_187_39 / var_187_38)

				if var_187_40 > 0 and var_187_34 < var_187_40 then
					arg_184_1.talkMaxDuration = var_187_40

					if var_187_40 + var_187_33 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_40 + var_187_33
					end
				end

				arg_184_1.text_.text = var_187_37
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231046", "story_v_out_112231.awb") ~= 0 then
					local var_187_41 = manager.audio:GetVoiceLength("story_v_out_112231", "112231046", "story_v_out_112231.awb") / 1000

					if var_187_41 + var_187_33 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_41 + var_187_33
					end

					if var_187_36.prefab_name ~= "" and arg_184_1.actors_[var_187_36.prefab_name] ~= nil then
						local var_187_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_36.prefab_name].transform, "story_v_out_112231", "112231046", "story_v_out_112231.awb")

						arg_184_1:RecordAudio("112231046", var_187_42)
						arg_184_1:RecordAudio("112231046", var_187_42)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_112231", "112231046", "story_v_out_112231.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_112231", "112231046", "story_v_out_112231.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_43 = math.max(var_187_34, arg_184_1.talkMaxDuration)

			if var_187_33 <= arg_184_1.time_ and arg_184_1.time_ < var_187_33 + var_187_43 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_33) / var_187_43

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_33 + var_187_43 and arg_184_1.time_ < var_187_33 + var_187_43 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play112231047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 112231047
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play112231048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1148ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1148ui_story == nil then
				arg_188_1.var_.characterEffect1148ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1148ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1148ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1148ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1148ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0
			local var_191_7 = 1.05

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_8 = arg_188_1:GetWordFromCfg(112231047)
				local var_191_9 = arg_188_1:FormatText(var_191_8.content)

				arg_188_1.text_.text = var_191_9

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_10 = 42
				local var_191_11 = utf8.len(var_191_9)
				local var_191_12 = var_191_10 <= 0 and var_191_7 or var_191_7 * (var_191_11 / var_191_10)

				if var_191_12 > 0 and var_191_7 < var_191_12 then
					arg_188_1.talkMaxDuration = var_191_12

					if var_191_12 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_12 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_9
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_13 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_13 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_13

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_13 and arg_188_1.time_ < var_191_6 + var_191_13 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play112231048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 112231048
		arg_192_1.duration_ = 6.67

		local var_192_0 = {
			ja = 4.833,
			ko = 5.9,
			zh = 6.333,
			en = 6.666
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
				arg_192_0:Play112231049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1148ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1148ui_story == nil then
				arg_192_1.var_.characterEffect1148ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1148ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1148ui_story then
				arg_192_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_195_4 = 0

			if var_195_4 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action442")
			end

			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 then
				arg_192_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_195_6 = 0
			local var_195_7 = 0.5

			if var_195_6 < arg_192_1.time_ and arg_192_1.time_ <= var_195_6 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_8 = arg_192_1:FormatText(StoryNameCfg[8].name)

				arg_192_1.leftNameTxt_.text = var_195_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_9 = arg_192_1:GetWordFromCfg(112231048)
				local var_195_10 = arg_192_1:FormatText(var_195_9.content)

				arg_192_1.text_.text = var_195_10

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_11 = 20
				local var_195_12 = utf8.len(var_195_10)
				local var_195_13 = var_195_11 <= 0 and var_195_7 or var_195_7 * (var_195_12 / var_195_11)

				if var_195_13 > 0 and var_195_7 < var_195_13 then
					arg_192_1.talkMaxDuration = var_195_13

					if var_195_13 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_6
					end
				end

				arg_192_1.text_.text = var_195_10
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231048", "story_v_out_112231.awb") ~= 0 then
					local var_195_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231048", "story_v_out_112231.awb") / 1000

					if var_195_14 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_14 + var_195_6
					end

					if var_195_9.prefab_name ~= "" and arg_192_1.actors_[var_195_9.prefab_name] ~= nil then
						local var_195_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_9.prefab_name].transform, "story_v_out_112231", "112231048", "story_v_out_112231.awb")

						arg_192_1:RecordAudio("112231048", var_195_15)
						arg_192_1:RecordAudio("112231048", var_195_15)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_112231", "112231048", "story_v_out_112231.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_112231", "112231048", "story_v_out_112231.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_16 = math.max(var_195_7, arg_192_1.talkMaxDuration)

			if var_195_6 <= arg_192_1.time_ and arg_192_1.time_ < var_195_6 + var_195_16 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_6) / var_195_16

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_6 + var_195_16 and arg_192_1.time_ < var_195_6 + var_195_16 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play112231049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 112231049
		arg_196_1.duration_ = 8.3

		local var_196_0 = {
			ja = 8.2,
			ko = 6.4,
			zh = 7.633,
			en = 8.3
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
				arg_196_0:Play112231050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1148ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1148ui_story == nil then
				arg_196_1.var_.characterEffect1148ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.2

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect1148ui_story and not isNil(var_199_0) then
					local var_199_4 = Mathf.Lerp(0, 0.5, var_199_3)

					arg_196_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1148ui_story.fillRatio = var_199_4
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect1148ui_story then
				local var_199_5 = 0.5

				arg_196_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1148ui_story.fillRatio = var_199_5
			end

			local var_199_6 = 0
			local var_199_7 = 0.7

			if var_199_6 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_8 = arg_196_1:FormatText(StoryNameCfg[9].name)

				arg_196_1.leftNameTxt_.text = var_199_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_9 = arg_196_1:GetWordFromCfg(112231049)
				local var_199_10 = arg_196_1:FormatText(var_199_9.content)

				arg_196_1.text_.text = var_199_10

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 28
				local var_199_12 = utf8.len(var_199_10)
				local var_199_13 = var_199_11 <= 0 and var_199_7 or var_199_7 * (var_199_12 / var_199_11)

				if var_199_13 > 0 and var_199_7 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_6
					end
				end

				arg_196_1.text_.text = var_199_10
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231049", "story_v_out_112231.awb") ~= 0 then
					local var_199_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231049", "story_v_out_112231.awb") / 1000

					if var_199_14 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_14 + var_199_6
					end

					if var_199_9.prefab_name ~= "" and arg_196_1.actors_[var_199_9.prefab_name] ~= nil then
						local var_199_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_9.prefab_name].transform, "story_v_out_112231", "112231049", "story_v_out_112231.awb")

						arg_196_1:RecordAudio("112231049", var_199_15)
						arg_196_1:RecordAudio("112231049", var_199_15)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_112231", "112231049", "story_v_out_112231.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_112231", "112231049", "story_v_out_112231.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_16 = math.max(var_199_7, arg_196_1.talkMaxDuration)

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_16 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_6) / var_199_16

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_6 + var_199_16 and arg_196_1.time_ < var_199_6 + var_199_16 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play112231050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 112231050
		arg_200_1.duration_ = 5.03

		local var_200_0 = {
			ja = 3.866,
			ko = 3.266,
			zh = 5.033,
			en = 4.133
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
				arg_200_0:Play112231051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.475

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[9].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:GetWordFromCfg(112231050)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231050", "story_v_out_112231.awb") ~= 0 then
					local var_203_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231050", "story_v_out_112231.awb") / 1000

					if var_203_8 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_8 + var_203_0
					end

					if var_203_3.prefab_name ~= "" and arg_200_1.actors_[var_203_3.prefab_name] ~= nil then
						local var_203_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_3.prefab_name].transform, "story_v_out_112231", "112231050", "story_v_out_112231.awb")

						arg_200_1:RecordAudio("112231050", var_203_9)
						arg_200_1:RecordAudio("112231050", var_203_9)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_112231", "112231050", "story_v_out_112231.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_112231", "112231050", "story_v_out_112231.awb")
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
	Play112231051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 112231051
		arg_204_1.duration_ = 4.1

		local var_204_0 = {
			ja = 3.3,
			ko = 3.566,
			zh = 2.7,
			en = 4.1
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
				arg_204_0:Play112231052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1148ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1148ui_story == nil then
				arg_204_1.var_.characterEffect1148ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.2

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1148ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1148ui_story then
				arg_204_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_207_4 = 0

			if var_207_4 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action427")
			end

			local var_207_5 = 0

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_207_6 = 0
			local var_207_7 = 0.175

			if var_207_6 < arg_204_1.time_ and arg_204_1.time_ <= var_207_6 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_8 = arg_204_1:FormatText(StoryNameCfg[8].name)

				arg_204_1.leftNameTxt_.text = var_207_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_9 = arg_204_1:GetWordFromCfg(112231051)
				local var_207_10 = arg_204_1:FormatText(var_207_9.content)

				arg_204_1.text_.text = var_207_10

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_11 = 7
				local var_207_12 = utf8.len(var_207_10)
				local var_207_13 = var_207_11 <= 0 and var_207_7 or var_207_7 * (var_207_12 / var_207_11)

				if var_207_13 > 0 and var_207_7 < var_207_13 then
					arg_204_1.talkMaxDuration = var_207_13

					if var_207_13 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_13 + var_207_6
					end
				end

				arg_204_1.text_.text = var_207_10
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231051", "story_v_out_112231.awb") ~= 0 then
					local var_207_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231051", "story_v_out_112231.awb") / 1000

					if var_207_14 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_14 + var_207_6
					end

					if var_207_9.prefab_name ~= "" and arg_204_1.actors_[var_207_9.prefab_name] ~= nil then
						local var_207_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_9.prefab_name].transform, "story_v_out_112231", "112231051", "story_v_out_112231.awb")

						arg_204_1:RecordAudio("112231051", var_207_15)
						arg_204_1:RecordAudio("112231051", var_207_15)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_112231", "112231051", "story_v_out_112231.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_112231", "112231051", "story_v_out_112231.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_16 = math.max(var_207_7, arg_204_1.talkMaxDuration)

			if var_207_6 <= arg_204_1.time_ and arg_204_1.time_ < var_207_6 + var_207_16 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_6) / var_207_16

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_6 + var_207_16 and arg_204_1.time_ < var_207_6 + var_207_16 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play112231052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 112231052
		arg_208_1.duration_ = 8.07

		local var_208_0 = {
			ja = 8.066,
			ko = 7.433,
			zh = 5.1,
			en = 6.7
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
				arg_208_0:Play112231053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1148ui_story"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos1148ui_story = var_211_0.localPosition
			end

			local var_211_2 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2
				local var_211_4 = Vector3.New(0, 100, 0)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1148ui_story, var_211_4, var_211_3)

				local var_211_5 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_5.x, var_211_5.y, var_211_5.z)

				local var_211_6 = var_211_0.localEulerAngles

				var_211_6.z = 0
				var_211_6.x = 0
				var_211_0.localEulerAngles = var_211_6
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(0, 100, 0)

				local var_211_7 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_7.x, var_211_7.y, var_211_7.z)

				local var_211_8 = var_211_0.localEulerAngles

				var_211_8.z = 0
				var_211_8.x = 0
				var_211_0.localEulerAngles = var_211_8
			end

			local var_211_9 = "1084ui_story"

			if arg_208_1.actors_[var_211_9] == nil then
				local var_211_10 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_211_10) then
					local var_211_11 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_208_1.stage_.transform)

					var_211_11.name = var_211_9
					var_211_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_208_1.actors_[var_211_9] = var_211_11

					local var_211_12 = var_211_11:GetComponentInChildren(typeof(CharacterEffect))

					var_211_12.enabled = true

					local var_211_13 = GameObjectTools.GetOrAddComponent(var_211_11, typeof(DynamicBoneHelper))

					if var_211_13 then
						var_211_13:EnableDynamicBone(false)
					end

					arg_208_1:ShowWeapon(var_211_12.transform, false)

					arg_208_1.var_[var_211_9 .. "Animator"] = var_211_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_208_1.var_[var_211_9 .. "Animator"].applyRootMotion = true
					arg_208_1.var_[var_211_9 .. "LipSync"] = var_211_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_211_14 = arg_208_1.actors_["1084ui_story"].transform
			local var_211_15 = 0

			if var_211_15 < arg_208_1.time_ and arg_208_1.time_ <= var_211_15 + arg_211_0 then
				arg_208_1.var_.moveOldPos1084ui_story = var_211_14.localPosition

				local var_211_16 = "1084ui_story"

				arg_208_1:ShowWeapon(arg_208_1.var_[var_211_16 .. "Animator"].transform, false)
			end

			local var_211_17 = 0.001

			if var_211_15 <= arg_208_1.time_ and arg_208_1.time_ < var_211_15 + var_211_17 then
				local var_211_18 = (arg_208_1.time_ - var_211_15) / var_211_17
				local var_211_19 = Vector3.New(0, -0.97, -6)

				var_211_14.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1084ui_story, var_211_19, var_211_18)

				local var_211_20 = manager.ui.mainCamera.transform.position - var_211_14.position

				var_211_14.forward = Vector3.New(var_211_20.x, var_211_20.y, var_211_20.z)

				local var_211_21 = var_211_14.localEulerAngles

				var_211_21.z = 0
				var_211_21.x = 0
				var_211_14.localEulerAngles = var_211_21
			end

			if arg_208_1.time_ >= var_211_15 + var_211_17 and arg_208_1.time_ < var_211_15 + var_211_17 + arg_211_0 then
				var_211_14.localPosition = Vector3.New(0, -0.97, -6)

				local var_211_22 = manager.ui.mainCamera.transform.position - var_211_14.position

				var_211_14.forward = Vector3.New(var_211_22.x, var_211_22.y, var_211_22.z)

				local var_211_23 = var_211_14.localEulerAngles

				var_211_23.z = 0
				var_211_23.x = 0
				var_211_14.localEulerAngles = var_211_23
			end

			local var_211_24 = arg_208_1.actors_["1084ui_story"]
			local var_211_25 = 0

			if var_211_25 < arg_208_1.time_ and arg_208_1.time_ <= var_211_25 + arg_211_0 and not isNil(var_211_24) and arg_208_1.var_.characterEffect1084ui_story == nil then
				arg_208_1.var_.characterEffect1084ui_story = var_211_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_26 = 0.2

			if var_211_25 <= arg_208_1.time_ and arg_208_1.time_ < var_211_25 + var_211_26 and not isNil(var_211_24) then
				local var_211_27 = (arg_208_1.time_ - var_211_25) / var_211_26

				if arg_208_1.var_.characterEffect1084ui_story and not isNil(var_211_24) then
					arg_208_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_25 + var_211_26 and arg_208_1.time_ < var_211_25 + var_211_26 + arg_211_0 and not isNil(var_211_24) and arg_208_1.var_.characterEffect1084ui_story then
				arg_208_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_211_28 = 0

			if var_211_28 < arg_208_1.time_ and arg_208_1.time_ <= var_211_28 + arg_211_0 then
				arg_208_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_211_29 = 0

			if var_211_29 < arg_208_1.time_ and arg_208_1.time_ <= var_211_29 + arg_211_0 then
				arg_208_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_211_30 = 0
			local var_211_31 = 0.55

			if var_211_30 < arg_208_1.time_ and arg_208_1.time_ <= var_211_30 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_32 = arg_208_1:FormatText(StoryNameCfg[6].name)

				arg_208_1.leftNameTxt_.text = var_211_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_33 = arg_208_1:GetWordFromCfg(112231052)
				local var_211_34 = arg_208_1:FormatText(var_211_33.content)

				arg_208_1.text_.text = var_211_34

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_35 = 22
				local var_211_36 = utf8.len(var_211_34)
				local var_211_37 = var_211_35 <= 0 and var_211_31 or var_211_31 * (var_211_36 / var_211_35)

				if var_211_37 > 0 and var_211_31 < var_211_37 then
					arg_208_1.talkMaxDuration = var_211_37

					if var_211_37 + var_211_30 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_37 + var_211_30
					end
				end

				arg_208_1.text_.text = var_211_34
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231052", "story_v_out_112231.awb") ~= 0 then
					local var_211_38 = manager.audio:GetVoiceLength("story_v_out_112231", "112231052", "story_v_out_112231.awb") / 1000

					if var_211_38 + var_211_30 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_38 + var_211_30
					end

					if var_211_33.prefab_name ~= "" and arg_208_1.actors_[var_211_33.prefab_name] ~= nil then
						local var_211_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_33.prefab_name].transform, "story_v_out_112231", "112231052", "story_v_out_112231.awb")

						arg_208_1:RecordAudio("112231052", var_211_39)
						arg_208_1:RecordAudio("112231052", var_211_39)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_112231", "112231052", "story_v_out_112231.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_112231", "112231052", "story_v_out_112231.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_40 = math.max(var_211_31, arg_208_1.talkMaxDuration)

			if var_211_30 <= arg_208_1.time_ and arg_208_1.time_ < var_211_30 + var_211_40 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_30) / var_211_40

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_30 + var_211_40 and arg_208_1.time_ < var_211_30 + var_211_40 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play112231053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 112231053
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play112231054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1084ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1084ui_story == nil then
				arg_212_1.var_.characterEffect1084ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.2

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1084ui_story and not isNil(var_215_0) then
					local var_215_4 = Mathf.Lerp(0, 0.5, var_215_3)

					arg_212_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1084ui_story.fillRatio = var_215_4
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1084ui_story then
				local var_215_5 = 0.5

				arg_212_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1084ui_story.fillRatio = var_215_5
			end

			local var_215_6 = 0
			local var_215_7 = 0.75

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_8 = arg_212_1:GetWordFromCfg(112231053)
				local var_215_9 = arg_212_1:FormatText(var_215_8.content)

				arg_212_1.text_.text = var_215_9

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_10 = 30
				local var_215_11 = utf8.len(var_215_9)
				local var_215_12 = var_215_10 <= 0 and var_215_7 or var_215_7 * (var_215_11 / var_215_10)

				if var_215_12 > 0 and var_215_7 < var_215_12 then
					arg_212_1.talkMaxDuration = var_215_12

					if var_215_12 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_12 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_9
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_13 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_13 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_13

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_13 and arg_212_1.time_ < var_215_6 + var_215_13 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play112231054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 112231054
		arg_216_1.duration_ = 4.9

		local var_216_0 = {
			ja = 3.633,
			ko = 3.133,
			zh = 4.4,
			en = 4.9
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
				arg_216_0:Play112231055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0
			local var_219_1 = 0.45

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_2 = arg_216_1:FormatText(StoryNameCfg[202].name)

				arg_216_1.leftNameTxt_.text = var_219_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_3 = arg_216_1:GetWordFromCfg(112231054)
				local var_219_4 = arg_216_1:FormatText(var_219_3.content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 18
				local var_219_6 = utf8.len(var_219_4)
				local var_219_7 = var_219_5 <= 0 and var_219_1 or var_219_1 * (var_219_6 / var_219_5)

				if var_219_7 > 0 and var_219_1 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231054", "story_v_out_112231.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231054", "story_v_out_112231.awb") / 1000

					if var_219_8 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_0
					end

					if var_219_3.prefab_name ~= "" and arg_216_1.actors_[var_219_3.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_3.prefab_name].transform, "story_v_out_112231", "112231054", "story_v_out_112231.awb")

						arg_216_1:RecordAudio("112231054", var_219_9)
						arg_216_1:RecordAudio("112231054", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_112231", "112231054", "story_v_out_112231.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_112231", "112231054", "story_v_out_112231.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_10 and arg_216_1.time_ < var_219_0 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play112231055 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 112231055
		arg_220_1.duration_ = 2.43

		local var_220_0 = {
			ja = 2.033,
			ko = 1.999999999999,
			zh = 2.1,
			en = 2.433
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play112231056(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1084ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1084ui_story == nil then
				arg_220_1.var_.characterEffect1084ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.2

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect1084ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect1084ui_story then
				arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_223_4 = 0

			if var_223_4 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action459")
			end

			local var_223_5 = 0

			if var_223_5 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_223_6 = 0
			local var_223_7 = 0.075

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_8 = arg_220_1:FormatText(StoryNameCfg[6].name)

				arg_220_1.leftNameTxt_.text = var_223_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_9 = arg_220_1:GetWordFromCfg(112231055)
				local var_223_10 = arg_220_1:FormatText(var_223_9.content)

				arg_220_1.text_.text = var_223_10

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 3
				local var_223_12 = utf8.len(var_223_10)
				local var_223_13 = var_223_11 <= 0 and var_223_7 or var_223_7 * (var_223_12 / var_223_11)

				if var_223_13 > 0 and var_223_7 < var_223_13 then
					arg_220_1.talkMaxDuration = var_223_13

					if var_223_13 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_10
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231055", "story_v_out_112231.awb") ~= 0 then
					local var_223_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231055", "story_v_out_112231.awb") / 1000

					if var_223_14 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_14 + var_223_6
					end

					if var_223_9.prefab_name ~= "" and arg_220_1.actors_[var_223_9.prefab_name] ~= nil then
						local var_223_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_9.prefab_name].transform, "story_v_out_112231", "112231055", "story_v_out_112231.awb")

						arg_220_1:RecordAudio("112231055", var_223_15)
						arg_220_1:RecordAudio("112231055", var_223_15)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_112231", "112231055", "story_v_out_112231.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_112231", "112231055", "story_v_out_112231.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_16 = math.max(var_223_7, arg_220_1.talkMaxDuration)

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_16 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_6) / var_223_16

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_6 + var_223_16 and arg_220_1.time_ < var_223_6 + var_223_16 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play112231056 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 112231056
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play112231057(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1084ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1084ui_story == nil then
				arg_224_1.var_.characterEffect1084ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.2

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1084ui_story and not isNil(var_227_0) then
					local var_227_4 = Mathf.Lerp(0, 0.5, var_227_3)

					arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1084ui_story.fillRatio = var_227_4
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1084ui_story then
				local var_227_5 = 0.5

				arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1084ui_story.fillRatio = var_227_5
			end

			local var_227_6 = 0
			local var_227_7 = 0.85

			if var_227_6 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_8 = arg_224_1:GetWordFromCfg(112231056)
				local var_227_9 = arg_224_1:FormatText(var_227_8.content)

				arg_224_1.text_.text = var_227_9

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_10 = 34
				local var_227_11 = utf8.len(var_227_9)
				local var_227_12 = var_227_10 <= 0 and var_227_7 or var_227_7 * (var_227_11 / var_227_10)

				if var_227_12 > 0 and var_227_7 < var_227_12 then
					arg_224_1.talkMaxDuration = var_227_12

					if var_227_12 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_12 + var_227_6
					end
				end

				arg_224_1.text_.text = var_227_9
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_13 = math.max(var_227_7, arg_224_1.talkMaxDuration)

			if var_227_6 <= arg_224_1.time_ and arg_224_1.time_ < var_227_6 + var_227_13 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_6) / var_227_13

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_6 + var_227_13 and arg_224_1.time_ < var_227_6 + var_227_13 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play112231057 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 112231057
		arg_228_1.duration_ = 3.4

		local var_228_0 = {
			ja = 3.4,
			ko = 2.433,
			zh = 2.5,
			en = 3.066
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play112231058(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0
			local var_231_1 = 0.15

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_2 = arg_228_1:FormatText(StoryNameCfg[8].name)

				arg_228_1.leftNameTxt_.text = var_231_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_3 = arg_228_1:GetWordFromCfg(112231057)
				local var_231_4 = arg_228_1:FormatText(var_231_3.content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231057", "story_v_out_112231.awb") ~= 0 then
					local var_231_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231057", "story_v_out_112231.awb") / 1000

					if var_231_8 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_8 + var_231_0
					end

					if var_231_3.prefab_name ~= "" and arg_228_1.actors_[var_231_3.prefab_name] ~= nil then
						local var_231_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_3.prefab_name].transform, "story_v_out_112231", "112231057", "story_v_out_112231.awb")

						arg_228_1:RecordAudio("112231057", var_231_9)
						arg_228_1:RecordAudio("112231057", var_231_9)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_112231", "112231057", "story_v_out_112231.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_112231", "112231057", "story_v_out_112231.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_10 and arg_228_1.time_ < var_231_0 + var_231_10 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play112231058 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 112231058
		arg_232_1.duration_ = 4.5

		local var_232_0 = {
			ja = 2.9,
			ko = 3.433,
			zh = 4.1,
			en = 4.5
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
				arg_232_0:Play112231059(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0
			local var_235_1 = 0.425

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_2 = arg_232_1:FormatText(StoryNameCfg[202].name)

				arg_232_1.leftNameTxt_.text = var_235_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_3 = arg_232_1:GetWordFromCfg(112231058)
				local var_235_4 = arg_232_1:FormatText(var_235_3.content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 17
				local var_235_6 = utf8.len(var_235_4)
				local var_235_7 = var_235_5 <= 0 and var_235_1 or var_235_1 * (var_235_6 / var_235_5)

				if var_235_7 > 0 and var_235_1 < var_235_7 then
					arg_232_1.talkMaxDuration = var_235_7

					if var_235_7 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_4
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231058", "story_v_out_112231.awb") ~= 0 then
					local var_235_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231058", "story_v_out_112231.awb") / 1000

					if var_235_8 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_8 + var_235_0
					end

					if var_235_3.prefab_name ~= "" and arg_232_1.actors_[var_235_3.prefab_name] ~= nil then
						local var_235_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_3.prefab_name].transform, "story_v_out_112231", "112231058", "story_v_out_112231.awb")

						arg_232_1:RecordAudio("112231058", var_235_9)
						arg_232_1:RecordAudio("112231058", var_235_9)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_112231", "112231058", "story_v_out_112231.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_112231", "112231058", "story_v_out_112231.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_10 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_10 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_10

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_10 and arg_232_1.time_ < var_235_0 + var_235_10 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play112231059 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 112231059
		arg_236_1.duration_ = 6.83

		local var_236_0 = {
			ja = 6.833,
			ko = 3.866,
			zh = 6.066,
			en = 3.2
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play112231060(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.6

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[9].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:GetWordFromCfg(112231059)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 24
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231059", "story_v_out_112231.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231059", "story_v_out_112231.awb") / 1000

					if var_239_8 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_0
					end

					if var_239_3.prefab_name ~= "" and arg_236_1.actors_[var_239_3.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_3.prefab_name].transform, "story_v_out_112231", "112231059", "story_v_out_112231.awb")

						arg_236_1:RecordAudio("112231059", var_239_9)
						arg_236_1:RecordAudio("112231059", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_112231", "112231059", "story_v_out_112231.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_112231", "112231059", "story_v_out_112231.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_10 and arg_236_1.time_ < var_239_0 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play112231060 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 112231060
		arg_240_1.duration_ = 6.1

		local var_240_0 = {
			ja = 6.1,
			ko = 5.366,
			zh = 3.933,
			en = 5.133
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play112231061(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1084ui_story"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1084ui_story == nil then
				arg_240_1.var_.characterEffect1084ui_story = var_243_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.2

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.characterEffect1084ui_story and not isNil(var_243_0) then
					arg_240_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.characterEffect1084ui_story then
				arg_240_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_243_4 = 0

			if var_243_4 < arg_240_1.time_ and arg_240_1.time_ <= var_243_4 + arg_243_0 then
				arg_240_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action492")
			end

			local var_243_5 = 0

			if var_243_5 < arg_240_1.time_ and arg_240_1.time_ <= var_243_5 + arg_243_0 then
				arg_240_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_243_6 = 0
			local var_243_7 = 0.475

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_8 = arg_240_1:FormatText(StoryNameCfg[6].name)

				arg_240_1.leftNameTxt_.text = var_243_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_9 = arg_240_1:GetWordFromCfg(112231060)
				local var_243_10 = arg_240_1:FormatText(var_243_9.content)

				arg_240_1.text_.text = var_243_10

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_11 = 19
				local var_243_12 = utf8.len(var_243_10)
				local var_243_13 = var_243_11 <= 0 and var_243_7 or var_243_7 * (var_243_12 / var_243_11)

				if var_243_13 > 0 and var_243_7 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_6
					end
				end

				arg_240_1.text_.text = var_243_10
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231060", "story_v_out_112231.awb") ~= 0 then
					local var_243_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231060", "story_v_out_112231.awb") / 1000

					if var_243_14 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_14 + var_243_6
					end

					if var_243_9.prefab_name ~= "" and arg_240_1.actors_[var_243_9.prefab_name] ~= nil then
						local var_243_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_9.prefab_name].transform, "story_v_out_112231", "112231060", "story_v_out_112231.awb")

						arg_240_1:RecordAudio("112231060", var_243_15)
						arg_240_1:RecordAudio("112231060", var_243_15)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_112231", "112231060", "story_v_out_112231.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_112231", "112231060", "story_v_out_112231.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_16 = math.max(var_243_7, arg_240_1.talkMaxDuration)

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_16 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_6) / var_243_16

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_6 + var_243_16 and arg_240_1.time_ < var_243_6 + var_243_16 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play112231061 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 112231061
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play112231062(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1084ui_story"].transform
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos1084ui_story = var_247_0.localPosition
			end

			local var_247_2 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2
				local var_247_4 = Vector3.New(0, 100, 0)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1084ui_story, var_247_4, var_247_3)

				local var_247_5 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_5.x, var_247_5.y, var_247_5.z)

				local var_247_6 = var_247_0.localEulerAngles

				var_247_6.z = 0
				var_247_6.x = 0
				var_247_0.localEulerAngles = var_247_6
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(0, 100, 0)

				local var_247_7 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_7.x, var_247_7.y, var_247_7.z)

				local var_247_8 = var_247_0.localEulerAngles

				var_247_8.z = 0
				var_247_8.x = 0
				var_247_0.localEulerAngles = var_247_8
			end

			local var_247_9 = 0
			local var_247_10 = 0.575

			if var_247_9 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_11 = arg_244_1:GetWordFromCfg(112231061)
				local var_247_12 = arg_244_1:FormatText(var_247_11.content)

				arg_244_1.text_.text = var_247_12

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_13 = 23
				local var_247_14 = utf8.len(var_247_12)
				local var_247_15 = var_247_13 <= 0 and var_247_10 or var_247_10 * (var_247_14 / var_247_13)

				if var_247_15 > 0 and var_247_10 < var_247_15 then
					arg_244_1.talkMaxDuration = var_247_15

					if var_247_15 + var_247_9 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_15 + var_247_9
					end
				end

				arg_244_1.text_.text = var_247_12
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_16 = math.max(var_247_10, arg_244_1.talkMaxDuration)

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_16 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_9) / var_247_16

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_9 + var_247_16 and arg_244_1.time_ < var_247_9 + var_247_16 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play112231062 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 112231062
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play112231063(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 0.075

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[7].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:GetWordFromCfg(112231062)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 3
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_8 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_8 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_8

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_8 and arg_248_1.time_ < var_251_0 + var_251_8 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play112231063 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 112231063
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play112231064(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0
			local var_255_1 = 0.7

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_2 = arg_252_1:GetWordFromCfg(112231063)
				local var_255_3 = arg_252_1:FormatText(var_255_2.content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 28
				local var_255_5 = utf8.len(var_255_3)
				local var_255_6 = var_255_4 <= 0 and var_255_1 or var_255_1 * (var_255_5 / var_255_4)

				if var_255_6 > 0 and var_255_1 < var_255_6 then
					arg_252_1.talkMaxDuration = var_255_6

					if var_255_6 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_6 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_7 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_7 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_7

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_7 and arg_252_1.time_ < var_255_0 + var_255_7 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play112231064 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 112231064
		arg_256_1.duration_ = 4.17

		local var_256_0 = {
			ja = 4.166,
			ko = 3.133,
			zh = 2.366,
			en = 3.633
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
				arg_256_0:Play112231065(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1039ui_story"].transform
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.moveOldPos1039ui_story = var_259_0.localPosition
			end

			local var_259_2 = 0.001

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2
				local var_259_4 = Vector3.New(0, -1.01, -5.9)

				var_259_0.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1039ui_story, var_259_4, var_259_3)

				local var_259_5 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_5.x, var_259_5.y, var_259_5.z)

				local var_259_6 = var_259_0.localEulerAngles

				var_259_6.z = 0
				var_259_6.x = 0
				var_259_0.localEulerAngles = var_259_6
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 then
				var_259_0.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_259_7 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_7.x, var_259_7.y, var_259_7.z)

				local var_259_8 = var_259_0.localEulerAngles

				var_259_8.z = 0
				var_259_8.x = 0
				var_259_0.localEulerAngles = var_259_8
			end

			local var_259_9 = arg_256_1.actors_["1039ui_story"]
			local var_259_10 = 0

			if var_259_10 < arg_256_1.time_ and arg_256_1.time_ <= var_259_10 + arg_259_0 and not isNil(var_259_9) and arg_256_1.var_.characterEffect1039ui_story == nil then
				arg_256_1.var_.characterEffect1039ui_story = var_259_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_11 = 0.2

			if var_259_10 <= arg_256_1.time_ and arg_256_1.time_ < var_259_10 + var_259_11 and not isNil(var_259_9) then
				local var_259_12 = (arg_256_1.time_ - var_259_10) / var_259_11

				if arg_256_1.var_.characterEffect1039ui_story and not isNil(var_259_9) then
					arg_256_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_10 + var_259_11 and arg_256_1.time_ < var_259_10 + var_259_11 + arg_259_0 and not isNil(var_259_9) and arg_256_1.var_.characterEffect1039ui_story then
				arg_256_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_259_13 = 0

			if var_259_13 < arg_256_1.time_ and arg_256_1.time_ <= var_259_13 + arg_259_0 then
				arg_256_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			local var_259_14 = 0

			if var_259_14 < arg_256_1.time_ and arg_256_1.time_ <= var_259_14 + arg_259_0 then
				arg_256_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_259_15 = 0
			local var_259_16 = 0.2

			if var_259_15 < arg_256_1.time_ and arg_256_1.time_ <= var_259_15 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_17 = arg_256_1:FormatText(StoryNameCfg[9].name)

				arg_256_1.leftNameTxt_.text = var_259_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_18 = arg_256_1:GetWordFromCfg(112231064)
				local var_259_19 = arg_256_1:FormatText(var_259_18.content)

				arg_256_1.text_.text = var_259_19

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_20 = 8
				local var_259_21 = utf8.len(var_259_19)
				local var_259_22 = var_259_20 <= 0 and var_259_16 or var_259_16 * (var_259_21 / var_259_20)

				if var_259_22 > 0 and var_259_16 < var_259_22 then
					arg_256_1.talkMaxDuration = var_259_22

					if var_259_22 + var_259_15 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_22 + var_259_15
					end
				end

				arg_256_1.text_.text = var_259_19
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231064", "story_v_out_112231.awb") ~= 0 then
					local var_259_23 = manager.audio:GetVoiceLength("story_v_out_112231", "112231064", "story_v_out_112231.awb") / 1000

					if var_259_23 + var_259_15 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_23 + var_259_15
					end

					if var_259_18.prefab_name ~= "" and arg_256_1.actors_[var_259_18.prefab_name] ~= nil then
						local var_259_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_18.prefab_name].transform, "story_v_out_112231", "112231064", "story_v_out_112231.awb")

						arg_256_1:RecordAudio("112231064", var_259_24)
						arg_256_1:RecordAudio("112231064", var_259_24)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_112231", "112231064", "story_v_out_112231.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_112231", "112231064", "story_v_out_112231.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_25 = math.max(var_259_16, arg_256_1.talkMaxDuration)

			if var_259_15 <= arg_256_1.time_ and arg_256_1.time_ < var_259_15 + var_259_25 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_15) / var_259_25

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_15 + var_259_25 and arg_256_1.time_ < var_259_15 + var_259_25 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play112231065 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 112231065
		arg_260_1.duration_ = 2.9

		local var_260_0 = {
			ja = 2.5,
			ko = 2.9,
			zh = 2.666,
			en = 2.233
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
				arg_260_0:Play112231066(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1039ui_story"].transform
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.moveOldPos1039ui_story = var_263_0.localPosition
			end

			local var_263_2 = 0.001

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2
				local var_263_4 = Vector3.New(0, 100, 0)

				var_263_0.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1039ui_story, var_263_4, var_263_3)

				local var_263_5 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_5.x, var_263_5.y, var_263_5.z)

				local var_263_6 = var_263_0.localEulerAngles

				var_263_6.z = 0
				var_263_6.x = 0
				var_263_0.localEulerAngles = var_263_6
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 then
				var_263_0.localPosition = Vector3.New(0, 100, 0)

				local var_263_7 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_7.x, var_263_7.y, var_263_7.z)

				local var_263_8 = var_263_0.localEulerAngles

				var_263_8.z = 0
				var_263_8.x = 0
				var_263_0.localEulerAngles = var_263_8
			end

			local var_263_9 = arg_260_1.actors_["1081ui_story"].transform
			local var_263_10 = 0

			if var_263_10 < arg_260_1.time_ and arg_260_1.time_ <= var_263_10 + arg_263_0 then
				arg_260_1.var_.moveOldPos1081ui_story = var_263_9.localPosition
			end

			local var_263_11 = 0.001

			if var_263_10 <= arg_260_1.time_ and arg_260_1.time_ < var_263_10 + var_263_11 then
				local var_263_12 = (arg_260_1.time_ - var_263_10) / var_263_11
				local var_263_13 = Vector3.New(0, -0.92, -5.8)

				var_263_9.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1081ui_story, var_263_13, var_263_12)

				local var_263_14 = manager.ui.mainCamera.transform.position - var_263_9.position

				var_263_9.forward = Vector3.New(var_263_14.x, var_263_14.y, var_263_14.z)

				local var_263_15 = var_263_9.localEulerAngles

				var_263_15.z = 0
				var_263_15.x = 0
				var_263_9.localEulerAngles = var_263_15
			end

			if arg_260_1.time_ >= var_263_10 + var_263_11 and arg_260_1.time_ < var_263_10 + var_263_11 + arg_263_0 then
				var_263_9.localPosition = Vector3.New(0, -0.92, -5.8)

				local var_263_16 = manager.ui.mainCamera.transform.position - var_263_9.position

				var_263_9.forward = Vector3.New(var_263_16.x, var_263_16.y, var_263_16.z)

				local var_263_17 = var_263_9.localEulerAngles

				var_263_17.z = 0
				var_263_17.x = 0
				var_263_9.localEulerAngles = var_263_17
			end

			local var_263_18 = arg_260_1.actors_["1081ui_story"]
			local var_263_19 = 0

			if var_263_19 < arg_260_1.time_ and arg_260_1.time_ <= var_263_19 + arg_263_0 and not isNil(var_263_18) and arg_260_1.var_.characterEffect1081ui_story == nil then
				arg_260_1.var_.characterEffect1081ui_story = var_263_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_20 = 0.2

			if var_263_19 <= arg_260_1.time_ and arg_260_1.time_ < var_263_19 + var_263_20 and not isNil(var_263_18) then
				local var_263_21 = (arg_260_1.time_ - var_263_19) / var_263_20

				if arg_260_1.var_.characterEffect1081ui_story and not isNil(var_263_18) then
					arg_260_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= var_263_19 + var_263_20 and arg_260_1.time_ < var_263_19 + var_263_20 + arg_263_0 and not isNil(var_263_18) and arg_260_1.var_.characterEffect1081ui_story then
				arg_260_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_263_22 = 0

			if var_263_22 < arg_260_1.time_ and arg_260_1.time_ <= var_263_22 + arg_263_0 then
				arg_260_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			local var_263_23 = 0

			if var_263_23 < arg_260_1.time_ and arg_260_1.time_ <= var_263_23 + arg_263_0 then
				arg_260_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_263_24 = 0
			local var_263_25 = 0.325

			if var_263_24 < arg_260_1.time_ and arg_260_1.time_ <= var_263_24 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_26 = arg_260_1:FormatText(StoryNameCfg[202].name)

				arg_260_1.leftNameTxt_.text = var_263_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_27 = arg_260_1:GetWordFromCfg(112231065)
				local var_263_28 = arg_260_1:FormatText(var_263_27.content)

				arg_260_1.text_.text = var_263_28

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_29 = 13
				local var_263_30 = utf8.len(var_263_28)
				local var_263_31 = var_263_29 <= 0 and var_263_25 or var_263_25 * (var_263_30 / var_263_29)

				if var_263_31 > 0 and var_263_25 < var_263_31 then
					arg_260_1.talkMaxDuration = var_263_31

					if var_263_31 + var_263_24 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_31 + var_263_24
					end
				end

				arg_260_1.text_.text = var_263_28
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231065", "story_v_out_112231.awb") ~= 0 then
					local var_263_32 = manager.audio:GetVoiceLength("story_v_out_112231", "112231065", "story_v_out_112231.awb") / 1000

					if var_263_32 + var_263_24 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_32 + var_263_24
					end

					if var_263_27.prefab_name ~= "" and arg_260_1.actors_[var_263_27.prefab_name] ~= nil then
						local var_263_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_27.prefab_name].transform, "story_v_out_112231", "112231065", "story_v_out_112231.awb")

						arg_260_1:RecordAudio("112231065", var_263_33)
						arg_260_1:RecordAudio("112231065", var_263_33)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_112231", "112231065", "story_v_out_112231.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_112231", "112231065", "story_v_out_112231.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_34 = math.max(var_263_25, arg_260_1.talkMaxDuration)

			if var_263_24 <= arg_260_1.time_ and arg_260_1.time_ < var_263_24 + var_263_34 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_24) / var_263_34

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_24 + var_263_34 and arg_260_1.time_ < var_263_24 + var_263_34 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play112231066 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 112231066
		arg_264_1.duration_ = 2.9

		local var_264_0 = {
			ja = 2,
			ko = 2.9,
			zh = 2.566,
			en = 2.533
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play112231067(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1081ui_story"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos1081ui_story = var_267_0.localPosition
			end

			local var_267_2 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2
				local var_267_4 = Vector3.New(0, 100, 0)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1081ui_story, var_267_4, var_267_3)

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

			local var_267_9 = arg_264_1.actors_["1148ui_story"].transform
			local var_267_10 = 0

			if var_267_10 < arg_264_1.time_ and arg_264_1.time_ <= var_267_10 + arg_267_0 then
				arg_264_1.var_.moveOldPos1148ui_story = var_267_9.localPosition
			end

			local var_267_11 = 0.001

			if var_267_10 <= arg_264_1.time_ and arg_264_1.time_ < var_267_10 + var_267_11 then
				local var_267_12 = (arg_264_1.time_ - var_267_10) / var_267_11
				local var_267_13 = Vector3.New(0, -0.8, -6.2)

				var_267_9.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1148ui_story, var_267_13, var_267_12)

				local var_267_14 = manager.ui.mainCamera.transform.position - var_267_9.position

				var_267_9.forward = Vector3.New(var_267_14.x, var_267_14.y, var_267_14.z)

				local var_267_15 = var_267_9.localEulerAngles

				var_267_15.z = 0
				var_267_15.x = 0
				var_267_9.localEulerAngles = var_267_15
			end

			if arg_264_1.time_ >= var_267_10 + var_267_11 and arg_264_1.time_ < var_267_10 + var_267_11 + arg_267_0 then
				var_267_9.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_267_16 = manager.ui.mainCamera.transform.position - var_267_9.position

				var_267_9.forward = Vector3.New(var_267_16.x, var_267_16.y, var_267_16.z)

				local var_267_17 = var_267_9.localEulerAngles

				var_267_17.z = 0
				var_267_17.x = 0
				var_267_9.localEulerAngles = var_267_17
			end

			local var_267_18 = arg_264_1.actors_["1148ui_story"]
			local var_267_19 = 0

			if var_267_19 < arg_264_1.time_ and arg_264_1.time_ <= var_267_19 + arg_267_0 and not isNil(var_267_18) and arg_264_1.var_.characterEffect1148ui_story == nil then
				arg_264_1.var_.characterEffect1148ui_story = var_267_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_20 = 0.2

			if var_267_19 <= arg_264_1.time_ and arg_264_1.time_ < var_267_19 + var_267_20 and not isNil(var_267_18) then
				local var_267_21 = (arg_264_1.time_ - var_267_19) / var_267_20

				if arg_264_1.var_.characterEffect1148ui_story and not isNil(var_267_18) then
					arg_264_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_19 + var_267_20 and arg_264_1.time_ < var_267_19 + var_267_20 + arg_267_0 and not isNil(var_267_18) and arg_264_1.var_.characterEffect1148ui_story then
				arg_264_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_267_22 = 0

			if var_267_22 < arg_264_1.time_ and arg_264_1.time_ <= var_267_22 + arg_267_0 then
				arg_264_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			local var_267_23 = 0

			if var_267_23 < arg_264_1.time_ and arg_264_1.time_ <= var_267_23 + arg_267_0 then
				arg_264_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_267_24 = 0
			local var_267_25 = 0.375

			if var_267_24 < arg_264_1.time_ and arg_264_1.time_ <= var_267_24 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_26 = arg_264_1:FormatText(StoryNameCfg[8].name)

				arg_264_1.leftNameTxt_.text = var_267_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_27 = arg_264_1:GetWordFromCfg(112231066)
				local var_267_28 = arg_264_1:FormatText(var_267_27.content)

				arg_264_1.text_.text = var_267_28

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_29 = 15
				local var_267_30 = utf8.len(var_267_28)
				local var_267_31 = var_267_29 <= 0 and var_267_25 or var_267_25 * (var_267_30 / var_267_29)

				if var_267_31 > 0 and var_267_25 < var_267_31 then
					arg_264_1.talkMaxDuration = var_267_31

					if var_267_31 + var_267_24 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_31 + var_267_24
					end
				end

				arg_264_1.text_.text = var_267_28
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231066", "story_v_out_112231.awb") ~= 0 then
					local var_267_32 = manager.audio:GetVoiceLength("story_v_out_112231", "112231066", "story_v_out_112231.awb") / 1000

					if var_267_32 + var_267_24 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_32 + var_267_24
					end

					if var_267_27.prefab_name ~= "" and arg_264_1.actors_[var_267_27.prefab_name] ~= nil then
						local var_267_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_27.prefab_name].transform, "story_v_out_112231", "112231066", "story_v_out_112231.awb")

						arg_264_1:RecordAudio("112231066", var_267_33)
						arg_264_1:RecordAudio("112231066", var_267_33)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_112231", "112231066", "story_v_out_112231.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_112231", "112231066", "story_v_out_112231.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_34 = math.max(var_267_25, arg_264_1.talkMaxDuration)

			if var_267_24 <= arg_264_1.time_ and arg_264_1.time_ < var_267_24 + var_267_34 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_24) / var_267_34

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_24 + var_267_34 and arg_264_1.time_ < var_267_24 + var_267_34 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play112231067 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 112231067
		arg_268_1.duration_ = 4.27

		local var_268_0 = {
			ja = 3.933,
			ko = 2.566,
			zh = 3.366,
			en = 4.266
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play112231068(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1148ui_story"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos1148ui_story = var_271_0.localPosition
			end

			local var_271_2 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2
				local var_271_4 = Vector3.New(0, 100, 0)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1148ui_story, var_271_4, var_271_3)

				local var_271_5 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_5.x, var_271_5.y, var_271_5.z)

				local var_271_6 = var_271_0.localEulerAngles

				var_271_6.z = 0
				var_271_6.x = 0
				var_271_0.localEulerAngles = var_271_6
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 then
				var_271_0.localPosition = Vector3.New(0, 100, 0)

				local var_271_7 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_7.x, var_271_7.y, var_271_7.z)

				local var_271_8 = var_271_0.localEulerAngles

				var_271_8.z = 0
				var_271_8.x = 0
				var_271_0.localEulerAngles = var_271_8
			end

			local var_271_9 = arg_268_1.actors_["1084ui_story"].transform
			local var_271_10 = 0

			if var_271_10 < arg_268_1.time_ and arg_268_1.time_ <= var_271_10 + arg_271_0 then
				arg_268_1.var_.moveOldPos1084ui_story = var_271_9.localPosition
			end

			local var_271_11 = 0.001

			if var_271_10 <= arg_268_1.time_ and arg_268_1.time_ < var_271_10 + var_271_11 then
				local var_271_12 = (arg_268_1.time_ - var_271_10) / var_271_11
				local var_271_13 = Vector3.New(0, -0.97, -6)

				var_271_9.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1084ui_story, var_271_13, var_271_12)

				local var_271_14 = manager.ui.mainCamera.transform.position - var_271_9.position

				var_271_9.forward = Vector3.New(var_271_14.x, var_271_14.y, var_271_14.z)

				local var_271_15 = var_271_9.localEulerAngles

				var_271_15.z = 0
				var_271_15.x = 0
				var_271_9.localEulerAngles = var_271_15
			end

			if arg_268_1.time_ >= var_271_10 + var_271_11 and arg_268_1.time_ < var_271_10 + var_271_11 + arg_271_0 then
				var_271_9.localPosition = Vector3.New(0, -0.97, -6)

				local var_271_16 = manager.ui.mainCamera.transform.position - var_271_9.position

				var_271_9.forward = Vector3.New(var_271_16.x, var_271_16.y, var_271_16.z)

				local var_271_17 = var_271_9.localEulerAngles

				var_271_17.z = 0
				var_271_17.x = 0
				var_271_9.localEulerAngles = var_271_17
			end

			local var_271_18 = arg_268_1.actors_["1084ui_story"]
			local var_271_19 = 0

			if var_271_19 < arg_268_1.time_ and arg_268_1.time_ <= var_271_19 + arg_271_0 and not isNil(var_271_18) and arg_268_1.var_.characterEffect1084ui_story == nil then
				arg_268_1.var_.characterEffect1084ui_story = var_271_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_20 = 0.2

			if var_271_19 <= arg_268_1.time_ and arg_268_1.time_ < var_271_19 + var_271_20 and not isNil(var_271_18) then
				local var_271_21 = (arg_268_1.time_ - var_271_19) / var_271_20

				if arg_268_1.var_.characterEffect1084ui_story and not isNil(var_271_18) then
					arg_268_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= var_271_19 + var_271_20 and arg_268_1.time_ < var_271_19 + var_271_20 + arg_271_0 and not isNil(var_271_18) and arg_268_1.var_.characterEffect1084ui_story then
				arg_268_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_271_22 = 0

			if var_271_22 < arg_268_1.time_ and arg_268_1.time_ <= var_271_22 + arg_271_0 then
				arg_268_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_271_23 = 0

			if var_271_23 < arg_268_1.time_ and arg_268_1.time_ <= var_271_23 + arg_271_0 then
				arg_268_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_271_24 = 0
			local var_271_25 = 0.325

			if var_271_24 < arg_268_1.time_ and arg_268_1.time_ <= var_271_24 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_26 = arg_268_1:FormatText(StoryNameCfg[6].name)

				arg_268_1.leftNameTxt_.text = var_271_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_27 = arg_268_1:GetWordFromCfg(112231067)
				local var_271_28 = arg_268_1:FormatText(var_271_27.content)

				arg_268_1.text_.text = var_271_28

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_29 = 13
				local var_271_30 = utf8.len(var_271_28)
				local var_271_31 = var_271_29 <= 0 and var_271_25 or var_271_25 * (var_271_30 / var_271_29)

				if var_271_31 > 0 and var_271_25 < var_271_31 then
					arg_268_1.talkMaxDuration = var_271_31

					if var_271_31 + var_271_24 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_31 + var_271_24
					end
				end

				arg_268_1.text_.text = var_271_28
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231067", "story_v_out_112231.awb") ~= 0 then
					local var_271_32 = manager.audio:GetVoiceLength("story_v_out_112231", "112231067", "story_v_out_112231.awb") / 1000

					if var_271_32 + var_271_24 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_32 + var_271_24
					end

					if var_271_27.prefab_name ~= "" and arg_268_1.actors_[var_271_27.prefab_name] ~= nil then
						local var_271_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_27.prefab_name].transform, "story_v_out_112231", "112231067", "story_v_out_112231.awb")

						arg_268_1:RecordAudio("112231067", var_271_33)
						arg_268_1:RecordAudio("112231067", var_271_33)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_112231", "112231067", "story_v_out_112231.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_112231", "112231067", "story_v_out_112231.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_34 = math.max(var_271_25, arg_268_1.talkMaxDuration)

			if var_271_24 <= arg_268_1.time_ and arg_268_1.time_ < var_271_24 + var_271_34 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_24) / var_271_34

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_24 + var_271_34 and arg_268_1.time_ < var_271_24 + var_271_34 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play112231068 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 112231068
		arg_272_1.duration_ = 6.07

		local var_272_0 = {
			ja = 6.066,
			ko = 3.633,
			zh = 3,
			en = 3.7
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play112231069(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1084ui_story"].transform
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.var_.moveOldPos1084ui_story = var_275_0.localPosition
			end

			local var_275_2 = 0.001

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2
				local var_275_4 = Vector3.New(0, 100, 0)

				var_275_0.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1084ui_story, var_275_4, var_275_3)

				local var_275_5 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_5.x, var_275_5.y, var_275_5.z)

				local var_275_6 = var_275_0.localEulerAngles

				var_275_6.z = 0
				var_275_6.x = 0
				var_275_0.localEulerAngles = var_275_6
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 then
				var_275_0.localPosition = Vector3.New(0, 100, 0)

				local var_275_7 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_7.x, var_275_7.y, var_275_7.z)

				local var_275_8 = var_275_0.localEulerAngles

				var_275_8.z = 0
				var_275_8.x = 0
				var_275_0.localEulerAngles = var_275_8
			end

			local var_275_9 = arg_272_1.actors_["1039ui_story"].transform
			local var_275_10 = 0

			if var_275_10 < arg_272_1.time_ and arg_272_1.time_ <= var_275_10 + arg_275_0 then
				arg_272_1.var_.moveOldPos1039ui_story = var_275_9.localPosition
			end

			local var_275_11 = 0.001

			if var_275_10 <= arg_272_1.time_ and arg_272_1.time_ < var_275_10 + var_275_11 then
				local var_275_12 = (arg_272_1.time_ - var_275_10) / var_275_11
				local var_275_13 = Vector3.New(0, -1.01, -5.9)

				var_275_9.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1039ui_story, var_275_13, var_275_12)

				local var_275_14 = manager.ui.mainCamera.transform.position - var_275_9.position

				var_275_9.forward = Vector3.New(var_275_14.x, var_275_14.y, var_275_14.z)

				local var_275_15 = var_275_9.localEulerAngles

				var_275_15.z = 0
				var_275_15.x = 0
				var_275_9.localEulerAngles = var_275_15
			end

			if arg_272_1.time_ >= var_275_10 + var_275_11 and arg_272_1.time_ < var_275_10 + var_275_11 + arg_275_0 then
				var_275_9.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_275_16 = manager.ui.mainCamera.transform.position - var_275_9.position

				var_275_9.forward = Vector3.New(var_275_16.x, var_275_16.y, var_275_16.z)

				local var_275_17 = var_275_9.localEulerAngles

				var_275_17.z = 0
				var_275_17.x = 0
				var_275_9.localEulerAngles = var_275_17
			end

			local var_275_18 = arg_272_1.actors_["1039ui_story"]
			local var_275_19 = 0

			if var_275_19 < arg_272_1.time_ and arg_272_1.time_ <= var_275_19 + arg_275_0 and not isNil(var_275_18) and arg_272_1.var_.characterEffect1039ui_story == nil then
				arg_272_1.var_.characterEffect1039ui_story = var_275_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_20 = 0.2

			if var_275_19 <= arg_272_1.time_ and arg_272_1.time_ < var_275_19 + var_275_20 and not isNil(var_275_18) then
				local var_275_21 = (arg_272_1.time_ - var_275_19) / var_275_20

				if arg_272_1.var_.characterEffect1039ui_story and not isNil(var_275_18) then
					arg_272_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_19 + var_275_20 and arg_272_1.time_ < var_275_19 + var_275_20 + arg_275_0 and not isNil(var_275_18) and arg_272_1.var_.characterEffect1039ui_story then
				arg_272_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_275_22 = 0

			if var_275_22 < arg_272_1.time_ and arg_272_1.time_ <= var_275_22 + arg_275_0 then
				arg_272_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			local var_275_23 = 0

			if var_275_23 < arg_272_1.time_ and arg_272_1.time_ <= var_275_23 + arg_275_0 then
				arg_272_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_275_24 = 0
			local var_275_25 = 0.15

			if var_275_24 < arg_272_1.time_ and arg_272_1.time_ <= var_275_24 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_26 = arg_272_1:FormatText(StoryNameCfg[9].name)

				arg_272_1.leftNameTxt_.text = var_275_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_27 = arg_272_1:GetWordFromCfg(112231068)
				local var_275_28 = arg_272_1:FormatText(var_275_27.content)

				arg_272_1.text_.text = var_275_28

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_29 = 6
				local var_275_30 = utf8.len(var_275_28)
				local var_275_31 = var_275_29 <= 0 and var_275_25 or var_275_25 * (var_275_30 / var_275_29)

				if var_275_31 > 0 and var_275_25 < var_275_31 then
					arg_272_1.talkMaxDuration = var_275_31

					if var_275_31 + var_275_24 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_31 + var_275_24
					end
				end

				arg_272_1.text_.text = var_275_28
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231068", "story_v_out_112231.awb") ~= 0 then
					local var_275_32 = manager.audio:GetVoiceLength("story_v_out_112231", "112231068", "story_v_out_112231.awb") / 1000

					if var_275_32 + var_275_24 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_32 + var_275_24
					end

					if var_275_27.prefab_name ~= "" and arg_272_1.actors_[var_275_27.prefab_name] ~= nil then
						local var_275_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_27.prefab_name].transform, "story_v_out_112231", "112231068", "story_v_out_112231.awb")

						arg_272_1:RecordAudio("112231068", var_275_33)
						arg_272_1:RecordAudio("112231068", var_275_33)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_112231", "112231068", "story_v_out_112231.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_112231", "112231068", "story_v_out_112231.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_34 = math.max(var_275_25, arg_272_1.talkMaxDuration)

			if var_275_24 <= arg_272_1.time_ and arg_272_1.time_ < var_275_24 + var_275_34 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_24) / var_275_34

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_24 + var_275_34 and arg_272_1.time_ < var_275_24 + var_275_34 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play112231069 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 112231069
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play112231070(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1039ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1039ui_story == nil then
				arg_276_1.var_.characterEffect1039ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.2

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect1039ui_story and not isNil(var_279_0) then
					local var_279_4 = Mathf.Lerp(0, 0.5, var_279_3)

					arg_276_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1039ui_story.fillRatio = var_279_4
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1039ui_story then
				local var_279_5 = 0.5

				arg_276_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1039ui_story.fillRatio = var_279_5
			end

			local var_279_6 = 0
			local var_279_7 = 0.575

			if var_279_6 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_8 = arg_276_1:FormatText(StoryNameCfg[7].name)

				arg_276_1.leftNameTxt_.text = var_279_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_9 = arg_276_1:GetWordFromCfg(112231069)
				local var_279_10 = arg_276_1:FormatText(var_279_9.content)

				arg_276_1.text_.text = var_279_10

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_11 = 23
				local var_279_12 = utf8.len(var_279_10)
				local var_279_13 = var_279_11 <= 0 and var_279_7 or var_279_7 * (var_279_12 / var_279_11)

				if var_279_13 > 0 and var_279_7 < var_279_13 then
					arg_276_1.talkMaxDuration = var_279_13

					if var_279_13 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_13 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_10
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_14 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_14 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_6) / var_279_14

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_6 + var_279_14 and arg_276_1.time_ < var_279_6 + var_279_14 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play112231070 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 112231070
		arg_280_1.duration_ = 4.07

		local var_280_0 = {
			ja = 4.066,
			ko = 3.366,
			zh = 2.633,
			en = 3.2
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play112231071(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1039ui_story"].transform
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.var_.moveOldPos1039ui_story = var_283_0.localPosition
			end

			local var_283_2 = 0.001

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2
				local var_283_4 = Vector3.New(0, 100, 0)

				var_283_0.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1039ui_story, var_283_4, var_283_3)

				local var_283_5 = manager.ui.mainCamera.transform.position - var_283_0.position

				var_283_0.forward = Vector3.New(var_283_5.x, var_283_5.y, var_283_5.z)

				local var_283_6 = var_283_0.localEulerAngles

				var_283_6.z = 0
				var_283_6.x = 0
				var_283_0.localEulerAngles = var_283_6
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 then
				var_283_0.localPosition = Vector3.New(0, 100, 0)

				local var_283_7 = manager.ui.mainCamera.transform.position - var_283_0.position

				var_283_0.forward = Vector3.New(var_283_7.x, var_283_7.y, var_283_7.z)

				local var_283_8 = var_283_0.localEulerAngles

				var_283_8.z = 0
				var_283_8.x = 0
				var_283_0.localEulerAngles = var_283_8
			end

			local var_283_9 = arg_280_1.actors_["1148ui_story"].transform
			local var_283_10 = 0

			if var_283_10 < arg_280_1.time_ and arg_280_1.time_ <= var_283_10 + arg_283_0 then
				arg_280_1.var_.moveOldPos1148ui_story = var_283_9.localPosition
			end

			local var_283_11 = 0.001

			if var_283_10 <= arg_280_1.time_ and arg_280_1.time_ < var_283_10 + var_283_11 then
				local var_283_12 = (arg_280_1.time_ - var_283_10) / var_283_11
				local var_283_13 = Vector3.New(0, -0.8, -6.2)

				var_283_9.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1148ui_story, var_283_13, var_283_12)

				local var_283_14 = manager.ui.mainCamera.transform.position - var_283_9.position

				var_283_9.forward = Vector3.New(var_283_14.x, var_283_14.y, var_283_14.z)

				local var_283_15 = var_283_9.localEulerAngles

				var_283_15.z = 0
				var_283_15.x = 0
				var_283_9.localEulerAngles = var_283_15
			end

			if arg_280_1.time_ >= var_283_10 + var_283_11 and arg_280_1.time_ < var_283_10 + var_283_11 + arg_283_0 then
				var_283_9.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_283_16 = manager.ui.mainCamera.transform.position - var_283_9.position

				var_283_9.forward = Vector3.New(var_283_16.x, var_283_16.y, var_283_16.z)

				local var_283_17 = var_283_9.localEulerAngles

				var_283_17.z = 0
				var_283_17.x = 0
				var_283_9.localEulerAngles = var_283_17
			end

			local var_283_18 = arg_280_1.actors_["1148ui_story"]
			local var_283_19 = 0

			if var_283_19 < arg_280_1.time_ and arg_280_1.time_ <= var_283_19 + arg_283_0 and not isNil(var_283_18) and arg_280_1.var_.characterEffect1148ui_story == nil then
				arg_280_1.var_.characterEffect1148ui_story = var_283_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_20 = 0.2

			if var_283_19 <= arg_280_1.time_ and arg_280_1.time_ < var_283_19 + var_283_20 and not isNil(var_283_18) then
				local var_283_21 = (arg_280_1.time_ - var_283_19) / var_283_20

				if arg_280_1.var_.characterEffect1148ui_story and not isNil(var_283_18) then
					arg_280_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_19 + var_283_20 and arg_280_1.time_ < var_283_19 + var_283_20 + arg_283_0 and not isNil(var_283_18) and arg_280_1.var_.characterEffect1148ui_story then
				arg_280_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_283_22 = 0

			if var_283_22 < arg_280_1.time_ and arg_280_1.time_ <= var_283_22 + arg_283_0 then
				arg_280_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_283_23 = 0

			if var_283_23 < arg_280_1.time_ and arg_280_1.time_ <= var_283_23 + arg_283_0 then
				arg_280_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_283_24 = 0
			local var_283_25 = 0.25

			if var_283_24 < arg_280_1.time_ and arg_280_1.time_ <= var_283_24 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_26 = arg_280_1:FormatText(StoryNameCfg[8].name)

				arg_280_1.leftNameTxt_.text = var_283_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_27 = arg_280_1:GetWordFromCfg(112231070)
				local var_283_28 = arg_280_1:FormatText(var_283_27.content)

				arg_280_1.text_.text = var_283_28

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_29 = 10
				local var_283_30 = utf8.len(var_283_28)
				local var_283_31 = var_283_29 <= 0 and var_283_25 or var_283_25 * (var_283_30 / var_283_29)

				if var_283_31 > 0 and var_283_25 < var_283_31 then
					arg_280_1.talkMaxDuration = var_283_31

					if var_283_31 + var_283_24 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_31 + var_283_24
					end
				end

				arg_280_1.text_.text = var_283_28
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231070", "story_v_out_112231.awb") ~= 0 then
					local var_283_32 = manager.audio:GetVoiceLength("story_v_out_112231", "112231070", "story_v_out_112231.awb") / 1000

					if var_283_32 + var_283_24 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_32 + var_283_24
					end

					if var_283_27.prefab_name ~= "" and arg_280_1.actors_[var_283_27.prefab_name] ~= nil then
						local var_283_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_27.prefab_name].transform, "story_v_out_112231", "112231070", "story_v_out_112231.awb")

						arg_280_1:RecordAudio("112231070", var_283_33)
						arg_280_1:RecordAudio("112231070", var_283_33)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_112231", "112231070", "story_v_out_112231.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_112231", "112231070", "story_v_out_112231.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_34 = math.max(var_283_25, arg_280_1.talkMaxDuration)

			if var_283_24 <= arg_280_1.time_ and arg_280_1.time_ < var_283_24 + var_283_34 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_24) / var_283_34

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_24 + var_283_34 and arg_280_1.time_ < var_283_24 + var_283_34 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play112231071 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 112231071
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play112231072(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1148ui_story"].transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.moveOldPos1148ui_story = var_287_0.localPosition
			end

			local var_287_2 = 0.001

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2
				local var_287_4 = Vector3.New(0, 100, 0)

				var_287_0.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1148ui_story, var_287_4, var_287_3)

				local var_287_5 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_5.x, var_287_5.y, var_287_5.z)

				local var_287_6 = var_287_0.localEulerAngles

				var_287_6.z = 0
				var_287_6.x = 0
				var_287_0.localEulerAngles = var_287_6
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 then
				var_287_0.localPosition = Vector3.New(0, 100, 0)

				local var_287_7 = manager.ui.mainCamera.transform.position - var_287_0.position

				var_287_0.forward = Vector3.New(var_287_7.x, var_287_7.y, var_287_7.z)

				local var_287_8 = var_287_0.localEulerAngles

				var_287_8.z = 0
				var_287_8.x = 0
				var_287_0.localEulerAngles = var_287_8
			end

			local var_287_9 = 0
			local var_287_10 = 0.775

			if var_287_9 < arg_284_1.time_ and arg_284_1.time_ <= var_287_9 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_11 = arg_284_1:GetWordFromCfg(112231071)
				local var_287_12 = arg_284_1:FormatText(var_287_11.content)

				arg_284_1.text_.text = var_287_12

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_13 = 31
				local var_287_14 = utf8.len(var_287_12)
				local var_287_15 = var_287_13 <= 0 and var_287_10 or var_287_10 * (var_287_14 / var_287_13)

				if var_287_15 > 0 and var_287_10 < var_287_15 then
					arg_284_1.talkMaxDuration = var_287_15

					if var_287_15 + var_287_9 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_15 + var_287_9
					end
				end

				arg_284_1.text_.text = var_287_12
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_16 = math.max(var_287_10, arg_284_1.talkMaxDuration)

			if var_287_9 <= arg_284_1.time_ and arg_284_1.time_ < var_287_9 + var_287_16 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_9) / var_287_16

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_9 + var_287_16 and arg_284_1.time_ < var_287_9 + var_287_16 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play112231072 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 112231072
		arg_288_1.duration_ = 13.73

		local var_288_0 = {
			ja = 13.733,
			ko = 10.866,
			zh = 11.066,
			en = 12.133
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play112231073(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1027ui_story"].transform
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.var_.moveOldPos1027ui_story = var_291_0.localPosition
			end

			local var_291_2 = 0.001

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2
				local var_291_4 = Vector3.New(0, -0.81, -5.8)

				var_291_0.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1027ui_story, var_291_4, var_291_3)

				local var_291_5 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_5.x, var_291_5.y, var_291_5.z)

				local var_291_6 = var_291_0.localEulerAngles

				var_291_6.z = 0
				var_291_6.x = 0
				var_291_0.localEulerAngles = var_291_6
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 then
				var_291_0.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_291_7 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_7.x, var_291_7.y, var_291_7.z)

				local var_291_8 = var_291_0.localEulerAngles

				var_291_8.z = 0
				var_291_8.x = 0
				var_291_0.localEulerAngles = var_291_8
			end

			local var_291_9 = arg_288_1.actors_["1027ui_story"]
			local var_291_10 = 0

			if var_291_10 < arg_288_1.time_ and arg_288_1.time_ <= var_291_10 + arg_291_0 and not isNil(var_291_9) and arg_288_1.var_.characterEffect1027ui_story == nil then
				arg_288_1.var_.characterEffect1027ui_story = var_291_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_11 = 0.2

			if var_291_10 <= arg_288_1.time_ and arg_288_1.time_ < var_291_10 + var_291_11 and not isNil(var_291_9) then
				local var_291_12 = (arg_288_1.time_ - var_291_10) / var_291_11

				if arg_288_1.var_.characterEffect1027ui_story and not isNil(var_291_9) then
					arg_288_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_10 + var_291_11 and arg_288_1.time_ < var_291_10 + var_291_11 + arg_291_0 and not isNil(var_291_9) and arg_288_1.var_.characterEffect1027ui_story then
				arg_288_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_291_13 = 0

			if var_291_13 < arg_288_1.time_ and arg_288_1.time_ <= var_291_13 + arg_291_0 then
				arg_288_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_291_14 = 0

			if var_291_14 < arg_288_1.time_ and arg_288_1.time_ <= var_291_14 + arg_291_0 then
				arg_288_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_291_15 = 0
			local var_291_16 = 1.25

			if var_291_15 < arg_288_1.time_ and arg_288_1.time_ <= var_291_15 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_17 = arg_288_1:FormatText(StoryNameCfg[56].name)

				arg_288_1.leftNameTxt_.text = var_291_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_18 = arg_288_1:GetWordFromCfg(112231072)
				local var_291_19 = arg_288_1:FormatText(var_291_18.content)

				arg_288_1.text_.text = var_291_19

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_20 = 50
				local var_291_21 = utf8.len(var_291_19)
				local var_291_22 = var_291_20 <= 0 and var_291_16 or var_291_16 * (var_291_21 / var_291_20)

				if var_291_22 > 0 and var_291_16 < var_291_22 then
					arg_288_1.talkMaxDuration = var_291_22

					if var_291_22 + var_291_15 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_22 + var_291_15
					end
				end

				arg_288_1.text_.text = var_291_19
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231072", "story_v_out_112231.awb") ~= 0 then
					local var_291_23 = manager.audio:GetVoiceLength("story_v_out_112231", "112231072", "story_v_out_112231.awb") / 1000

					if var_291_23 + var_291_15 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_23 + var_291_15
					end

					if var_291_18.prefab_name ~= "" and arg_288_1.actors_[var_291_18.prefab_name] ~= nil then
						local var_291_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_18.prefab_name].transform, "story_v_out_112231", "112231072", "story_v_out_112231.awb")

						arg_288_1:RecordAudio("112231072", var_291_24)
						arg_288_1:RecordAudio("112231072", var_291_24)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_112231", "112231072", "story_v_out_112231.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_112231", "112231072", "story_v_out_112231.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_25 = math.max(var_291_16, arg_288_1.talkMaxDuration)

			if var_291_15 <= arg_288_1.time_ and arg_288_1.time_ < var_291_15 + var_291_25 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_15) / var_291_25

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_15 + var_291_25 and arg_288_1.time_ < var_291_15 + var_291_25 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play112231073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 112231073
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play112231074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1027ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1027ui_story == nil then
				arg_292_1.var_.characterEffect1027ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.2

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect1027ui_story and not isNil(var_295_0) then
					local var_295_4 = Mathf.Lerp(0, 0.5, var_295_3)

					arg_292_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1027ui_story.fillRatio = var_295_4
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1027ui_story then
				local var_295_5 = 0.5

				arg_292_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1027ui_story.fillRatio = var_295_5
			end

			local var_295_6 = 0

			if var_295_6 < arg_292_1.time_ and arg_292_1.time_ <= var_295_6 + arg_295_0 then
				arg_292_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action442")
			end

			local var_295_7 = 0

			if var_295_7 < arg_292_1.time_ and arg_292_1.time_ <= var_295_7 + arg_295_0 then
				arg_292_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_295_8 = 0
			local var_295_9 = 0.7

			if var_295_8 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_10 = arg_292_1:GetWordFromCfg(112231073)
				local var_295_11 = arg_292_1:FormatText(var_295_10.content)

				arg_292_1.text_.text = var_295_11

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_12 = 28
				local var_295_13 = utf8.len(var_295_11)
				local var_295_14 = var_295_12 <= 0 and var_295_9 or var_295_9 * (var_295_13 / var_295_12)

				if var_295_14 > 0 and var_295_9 < var_295_14 then
					arg_292_1.talkMaxDuration = var_295_14

					if var_295_14 + var_295_8 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_14 + var_295_8
					end
				end

				arg_292_1.text_.text = var_295_11
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_15 = math.max(var_295_9, arg_292_1.talkMaxDuration)

			if var_295_8 <= arg_292_1.time_ and arg_292_1.time_ < var_295_8 + var_295_15 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_8) / var_295_15

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_8 + var_295_15 and arg_292_1.time_ < var_295_8 + var_295_15 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play112231074 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 112231074
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play112231075(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 0.075

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_2 = arg_296_1:FormatText(StoryNameCfg[7].name)

				arg_296_1.leftNameTxt_.text = var_299_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_3 = arg_296_1:GetWordFromCfg(112231074)
				local var_299_4 = arg_296_1:FormatText(var_299_3.content)

				arg_296_1.text_.text = var_299_4

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 3
				local var_299_6 = utf8.len(var_299_4)
				local var_299_7 = var_299_5 <= 0 and var_299_1 or var_299_1 * (var_299_6 / var_299_5)

				if var_299_7 > 0 and var_299_1 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_4
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_8 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_8 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_8

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_8 and arg_296_1.time_ < var_299_0 + var_299_8 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play112231075 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 112231075
		arg_300_1.duration_ = 11.6

		local var_300_0 = {
			ja = 11.6,
			ko = 8.7,
			zh = 10,
			en = 10.5
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
				arg_300_0:Play112231076(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["1027ui_story"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect1027ui_story == nil then
				arg_300_1.var_.characterEffect1027ui_story = var_303_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.2

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.characterEffect1027ui_story and not isNil(var_303_0) then
					arg_300_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect1027ui_story then
				arg_300_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_303_4 = 0

			if var_303_4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_303_5 = 0
			local var_303_6 = 0.825

			if var_303_5 < arg_300_1.time_ and arg_300_1.time_ <= var_303_5 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_7 = arg_300_1:FormatText(StoryNameCfg[56].name)

				arg_300_1.leftNameTxt_.text = var_303_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_8 = arg_300_1:GetWordFromCfg(112231075)
				local var_303_9 = arg_300_1:FormatText(var_303_8.content)

				arg_300_1.text_.text = var_303_9

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_10 = 33
				local var_303_11 = utf8.len(var_303_9)
				local var_303_12 = var_303_10 <= 0 and var_303_6 or var_303_6 * (var_303_11 / var_303_10)

				if var_303_12 > 0 and var_303_6 < var_303_12 then
					arg_300_1.talkMaxDuration = var_303_12

					if var_303_12 + var_303_5 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_12 + var_303_5
					end
				end

				arg_300_1.text_.text = var_303_9
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231075", "story_v_out_112231.awb") ~= 0 then
					local var_303_13 = manager.audio:GetVoiceLength("story_v_out_112231", "112231075", "story_v_out_112231.awb") / 1000

					if var_303_13 + var_303_5 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_13 + var_303_5
					end

					if var_303_8.prefab_name ~= "" and arg_300_1.actors_[var_303_8.prefab_name] ~= nil then
						local var_303_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_8.prefab_name].transform, "story_v_out_112231", "112231075", "story_v_out_112231.awb")

						arg_300_1:RecordAudio("112231075", var_303_14)
						arg_300_1:RecordAudio("112231075", var_303_14)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_112231", "112231075", "story_v_out_112231.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_112231", "112231075", "story_v_out_112231.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_15 = math.max(var_303_6, arg_300_1.talkMaxDuration)

			if var_303_5 <= arg_300_1.time_ and arg_300_1.time_ < var_303_5 + var_303_15 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_5) / var_303_15

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_5 + var_303_15 and arg_300_1.time_ < var_303_5 + var_303_15 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play112231076 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 112231076
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play112231077(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1027ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1027ui_story == nil then
				arg_304_1.var_.characterEffect1027ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.2

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect1027ui_story and not isNil(var_307_0) then
					local var_307_4 = Mathf.Lerp(0, 0.5, var_307_3)

					arg_304_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1027ui_story.fillRatio = var_307_4
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1027ui_story then
				local var_307_5 = 0.5

				arg_304_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1027ui_story.fillRatio = var_307_5
			end

			local var_307_6 = 0
			local var_307_7 = 0.775

			if var_307_6 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_8 = arg_304_1:GetWordFromCfg(112231076)
				local var_307_9 = arg_304_1:FormatText(var_307_8.content)

				arg_304_1.text_.text = var_307_9

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_10 = 31
				local var_307_11 = utf8.len(var_307_9)
				local var_307_12 = var_307_10 <= 0 and var_307_7 or var_307_7 * (var_307_11 / var_307_10)

				if var_307_12 > 0 and var_307_7 < var_307_12 then
					arg_304_1.talkMaxDuration = var_307_12

					if var_307_12 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_12 + var_307_6
					end
				end

				arg_304_1.text_.text = var_307_9
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_13 = math.max(var_307_7, arg_304_1.talkMaxDuration)

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_13 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_6) / var_307_13

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_6 + var_307_13 and arg_304_1.time_ < var_307_6 + var_307_13 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play112231077 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 112231077
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play112231078(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 0.95

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_2 = arg_308_1:GetWordFromCfg(112231077)
				local var_311_3 = arg_308_1:FormatText(var_311_2.content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 38
				local var_311_5 = utf8.len(var_311_3)
				local var_311_6 = var_311_4 <= 0 and var_311_1 or var_311_1 * (var_311_5 / var_311_4)

				if var_311_6 > 0 and var_311_1 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_7 and arg_308_1.time_ < var_311_0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play112231078 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 112231078
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play112231079(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 0.275

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

				local var_315_2 = arg_312_1:GetWordFromCfg(112231078)
				local var_315_3 = arg_312_1:FormatText(var_315_2.content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 11
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
	Play112231079 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 112231079
		arg_316_1.duration_ = 4.7

		local var_316_0 = {
			ja = 4.333,
			ko = 2.566,
			zh = 2.733,
			en = 4.7
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
				arg_316_0:Play112231080(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.175

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[9].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(112231079)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 7
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231079", "story_v_out_112231.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231079", "story_v_out_112231.awb") / 1000

					if var_319_8 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_0
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_112231", "112231079", "story_v_out_112231.awb")

						arg_316_1:RecordAudio("112231079", var_319_9)
						arg_316_1:RecordAudio("112231079", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_112231", "112231079", "story_v_out_112231.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_112231", "112231079", "story_v_out_112231.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_10 and arg_316_1.time_ < var_319_0 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play112231080 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 112231080
		arg_320_1.duration_ = 5.73

		local var_320_0 = {
			ja = 3.533,
			ko = 5.733,
			zh = 5.1,
			en = 3.233
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play112231081(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.35

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[6].name)

				arg_320_1.leftNameTxt_.text = var_323_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(112231080)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 14
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231080", "story_v_out_112231.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231080", "story_v_out_112231.awb") / 1000

					if var_323_8 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_0
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_112231", "112231080", "story_v_out_112231.awb")

						arg_320_1:RecordAudio("112231080", var_323_9)
						arg_320_1:RecordAudio("112231080", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_112231", "112231080", "story_v_out_112231.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_112231", "112231080", "story_v_out_112231.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_10 and arg_320_1.time_ < var_323_0 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play112231081 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 112231081
		arg_324_1.duration_ = 4.83

		local var_324_0 = {
			ja = 4.833,
			ko = 3.5,
			zh = 3.4,
			en = 2.8
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play112231082(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.35

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_2 = arg_324_1:FormatText(StoryNameCfg[202].name)

				arg_324_1.leftNameTxt_.text = var_327_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:GetWordFromCfg(112231081)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 14
				local var_327_6 = utf8.len(var_327_4)
				local var_327_7 = var_327_5 <= 0 and var_327_1 or var_327_1 * (var_327_6 / var_327_5)

				if var_327_7 > 0 and var_327_1 < var_327_7 then
					arg_324_1.talkMaxDuration = var_327_7

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231081", "story_v_out_112231.awb") ~= 0 then
					local var_327_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231081", "story_v_out_112231.awb") / 1000

					if var_327_8 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_0
					end

					if var_327_3.prefab_name ~= "" and arg_324_1.actors_[var_327_3.prefab_name] ~= nil then
						local var_327_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_3.prefab_name].transform, "story_v_out_112231", "112231081", "story_v_out_112231.awb")

						arg_324_1:RecordAudio("112231081", var_327_9)
						arg_324_1:RecordAudio("112231081", var_327_9)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_112231", "112231081", "story_v_out_112231.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_112231", "112231081", "story_v_out_112231.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_10 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_10 and arg_324_1.time_ < var_327_0 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play112231082 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 112231082
		arg_328_1.duration_ = 14.03

		local var_328_0 = {
			ja = 14.033,
			ko = 7.566,
			zh = 7.833,
			en = 11.633
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play112231083(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.925

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[8].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:GetWordFromCfg(112231082)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 37
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231082", "story_v_out_112231.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_112231", "112231082", "story_v_out_112231.awb") / 1000

					if var_331_8 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_0
					end

					if var_331_3.prefab_name ~= "" and arg_328_1.actors_[var_331_3.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_3.prefab_name].transform, "story_v_out_112231", "112231082", "story_v_out_112231.awb")

						arg_328_1:RecordAudio("112231082", var_331_9)
						arg_328_1:RecordAudio("112231082", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_112231", "112231082", "story_v_out_112231.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_112231", "112231082", "story_v_out_112231.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_10 and arg_328_1.time_ < var_331_0 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play112231083 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 112231083
		arg_332_1.duration_ = 7.47

		local var_332_0 = {
			ja = 7.466,
			ko = 6.166,
			zh = 5.366,
			en = 6.633
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play112231084(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1027ui_story"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1027ui_story == nil then
				arg_332_1.var_.characterEffect1027ui_story = var_335_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.2

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.characterEffect1027ui_story and not isNil(var_335_0) then
					arg_332_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1027ui_story then
				arg_332_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_335_4 = 0

			if var_335_4 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action423")
			end

			local var_335_5 = 0

			if var_335_5 < arg_332_1.time_ and arg_332_1.time_ <= var_335_5 + arg_335_0 then
				arg_332_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_335_6 = 0
			local var_335_7 = 0.475

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_8 = arg_332_1:FormatText(StoryNameCfg[56].name)

				arg_332_1.leftNameTxt_.text = var_335_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_9 = arg_332_1:GetWordFromCfg(112231083)
				local var_335_10 = arg_332_1:FormatText(var_335_9.content)

				arg_332_1.text_.text = var_335_10

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_11 = 19
				local var_335_12 = utf8.len(var_335_10)
				local var_335_13 = var_335_11 <= 0 and var_335_7 or var_335_7 * (var_335_12 / var_335_11)

				if var_335_13 > 0 and var_335_7 < var_335_13 then
					arg_332_1.talkMaxDuration = var_335_13

					if var_335_13 + var_335_6 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_13 + var_335_6
					end
				end

				arg_332_1.text_.text = var_335_10
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231083", "story_v_out_112231.awb") ~= 0 then
					local var_335_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231083", "story_v_out_112231.awb") / 1000

					if var_335_14 + var_335_6 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_14 + var_335_6
					end

					if var_335_9.prefab_name ~= "" and arg_332_1.actors_[var_335_9.prefab_name] ~= nil then
						local var_335_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_9.prefab_name].transform, "story_v_out_112231", "112231083", "story_v_out_112231.awb")

						arg_332_1:RecordAudio("112231083", var_335_15)
						arg_332_1:RecordAudio("112231083", var_335_15)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_112231", "112231083", "story_v_out_112231.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_112231", "112231083", "story_v_out_112231.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_16 = math.max(var_335_7, arg_332_1.talkMaxDuration)

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_16 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_6) / var_335_16

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_6 + var_335_16 and arg_332_1.time_ < var_335_6 + var_335_16 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play112231084 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 112231084
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play112231085(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1027ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1027ui_story == nil then
				arg_336_1.var_.characterEffect1027ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.2

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect1027ui_story and not isNil(var_339_0) then
					local var_339_4 = Mathf.Lerp(0, 0.5, var_339_3)

					arg_336_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_336_1.var_.characterEffect1027ui_story.fillRatio = var_339_4
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1027ui_story then
				local var_339_5 = 0.5

				arg_336_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_336_1.var_.characterEffect1027ui_story.fillRatio = var_339_5
			end

			local var_339_6 = 0

			if var_339_6 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_2")
			end

			local var_339_7 = 0

			if var_339_7 < arg_336_1.time_ and arg_336_1.time_ <= var_339_7 + arg_339_0 then
				arg_336_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_339_8 = 0
			local var_339_9 = 1.3

			if var_339_8 < arg_336_1.time_ and arg_336_1.time_ <= var_339_8 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_10 = arg_336_1:GetWordFromCfg(112231084)
				local var_339_11 = arg_336_1:FormatText(var_339_10.content)

				arg_336_1.text_.text = var_339_11

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_12 = 52
				local var_339_13 = utf8.len(var_339_11)
				local var_339_14 = var_339_12 <= 0 and var_339_9 or var_339_9 * (var_339_13 / var_339_12)

				if var_339_14 > 0 and var_339_9 < var_339_14 then
					arg_336_1.talkMaxDuration = var_339_14

					if var_339_14 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_14 + var_339_8
					end
				end

				arg_336_1.text_.text = var_339_11
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_15 = math.max(var_339_9, arg_336_1.talkMaxDuration)

			if var_339_8 <= arg_336_1.time_ and arg_336_1.time_ < var_339_8 + var_339_15 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_8) / var_339_15

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_8 + var_339_15 and arg_336_1.time_ < var_339_8 + var_339_15 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play112231085 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 112231085
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play112231086(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 0.45

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_2 = arg_340_1:GetWordFromCfg(112231085)
				local var_343_3 = arg_340_1:FormatText(var_343_2.content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 18
				local var_343_5 = utf8.len(var_343_3)
				local var_343_6 = var_343_4 <= 0 and var_343_1 or var_343_1 * (var_343_5 / var_343_4)

				if var_343_6 > 0 and var_343_1 < var_343_6 then
					arg_340_1.talkMaxDuration = var_343_6

					if var_343_6 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_6 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_3
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_7 and arg_340_1.time_ < var_343_0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play112231086 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 112231086
		arg_344_1.duration_ = 5.7

		local var_344_0 = {
			ja = 5.7,
			ko = 2.8,
			zh = 4,
			en = 4.333
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play112231087(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1027ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1027ui_story == nil then
				arg_344_1.var_.characterEffect1027ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.2

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect1027ui_story and not isNil(var_347_0) then
					arg_344_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1027ui_story then
				arg_344_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_347_4 = 0

			if var_347_4 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			local var_347_5 = 0

			if var_347_5 < arg_344_1.time_ and arg_344_1.time_ <= var_347_5 + arg_347_0 then
				arg_344_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_347_6 = 0
			local var_347_7 = 0.3

			if var_347_6 < arg_344_1.time_ and arg_344_1.time_ <= var_347_6 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_8 = arg_344_1:FormatText(StoryNameCfg[56].name)

				arg_344_1.leftNameTxt_.text = var_347_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_9 = arg_344_1:GetWordFromCfg(112231086)
				local var_347_10 = arg_344_1:FormatText(var_347_9.content)

				arg_344_1.text_.text = var_347_10

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_11 = 12
				local var_347_12 = utf8.len(var_347_10)
				local var_347_13 = var_347_11 <= 0 and var_347_7 or var_347_7 * (var_347_12 / var_347_11)

				if var_347_13 > 0 and var_347_7 < var_347_13 then
					arg_344_1.talkMaxDuration = var_347_13

					if var_347_13 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_6
					end
				end

				arg_344_1.text_.text = var_347_10
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112231", "112231086", "story_v_out_112231.awb") ~= 0 then
					local var_347_14 = manager.audio:GetVoiceLength("story_v_out_112231", "112231086", "story_v_out_112231.awb") / 1000

					if var_347_14 + var_347_6 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_14 + var_347_6
					end

					if var_347_9.prefab_name ~= "" and arg_344_1.actors_[var_347_9.prefab_name] ~= nil then
						local var_347_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_9.prefab_name].transform, "story_v_out_112231", "112231086", "story_v_out_112231.awb")

						arg_344_1:RecordAudio("112231086", var_347_15)
						arg_344_1:RecordAudio("112231086", var_347_15)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_112231", "112231086", "story_v_out_112231.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_112231", "112231086", "story_v_out_112231.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_16 = math.max(var_347_7, arg_344_1.talkMaxDuration)

			if var_347_6 <= arg_344_1.time_ and arg_344_1.time_ < var_347_6 + var_347_16 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_6) / var_347_16

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_6 + var_347_16 and arg_344_1.time_ < var_347_6 + var_347_16 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play112231087 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 112231087
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
			arg_348_1.auto_ = false
		end

		function arg_348_1.playNext_(arg_350_0)
			arg_348_1.onStoryFinished_()
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1027ui_story"].transform
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.var_.moveOldPos1027ui_story = var_351_0.localPosition
			end

			local var_351_2 = 0.001

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2
				local var_351_4 = Vector3.New(0, 100, 0)

				var_351_0.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1027ui_story, var_351_4, var_351_3)

				local var_351_5 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_5.x, var_351_5.y, var_351_5.z)

				local var_351_6 = var_351_0.localEulerAngles

				var_351_6.z = 0
				var_351_6.x = 0
				var_351_0.localEulerAngles = var_351_6
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 then
				var_351_0.localPosition = Vector3.New(0, 100, 0)

				local var_351_7 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_7.x, var_351_7.y, var_351_7.z)

				local var_351_8 = var_351_0.localEulerAngles

				var_351_8.z = 0
				var_351_8.x = 0
				var_351_0.localEulerAngles = var_351_8
			end

			local var_351_9 = 0
			local var_351_10 = 0.75

			if var_351_9 < arg_348_1.time_ and arg_348_1.time_ <= var_351_9 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_11 = arg_348_1:GetWordFromCfg(112231087)
				local var_351_12 = arg_348_1:FormatText(var_351_11.content)

				arg_348_1.text_.text = var_351_12

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_13 = 30
				local var_351_14 = utf8.len(var_351_12)
				local var_351_15 = var_351_13 <= 0 and var_351_10 or var_351_10 * (var_351_14 / var_351_13)

				if var_351_15 > 0 and var_351_10 < var_351_15 then
					arg_348_1.talkMaxDuration = var_351_15

					if var_351_15 + var_351_9 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_15 + var_351_9
					end
				end

				arg_348_1.text_.text = var_351_12
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_16 = math.max(var_351_10, arg_348_1.talkMaxDuration)

			if var_351_9 <= arg_348_1.time_ and arg_348_1.time_ < var_351_9 + var_351_16 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_9) / var_351_16

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_9 + var_351_16 and arg_348_1.time_ < var_351_9 + var_351_16 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H01a"
	},
	voices = {
		"story_v_out_112231.awb"
	}
}
