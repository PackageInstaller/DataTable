return {
	Play106111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106111001
		arg_1_1.duration_ = 6.57

		local var_1_0 = {
			ja = 4.49966666666667,
			ko = 6.56666666666667,
			zh = 5.63266666666667,
			en = 4.99966666666667
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
				arg_1_0:Play106111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C02b"

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
				local var_4_5 = arg_1_1.bgs_.C02b

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
					if iter_4_0 ~= "C02b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.C02b
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueC02b = var_4_18.color.a
					arg_1_1.var_.alphaMatValueC02b = var_4_18
				end

				arg_1_1.var_.alphaOldValueC02b = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC02b, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueC02b then
					local var_4_22 = arg_1_1.var_.alphaMatValueC02b.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueC02b.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueC02b then
				local var_4_23 = arg_1_1.var_.alphaMatValueC02b
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0
			local var_4_26 = 1

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_27 = "play"
				local var_4_28 = "music"

				arg_1_1:AudioAction(var_4_27, var_4_28, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_29 = ""
				local var_4_30 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_30 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_30 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_30

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_30
						arg_1_1.bgmTxt2_.text = var_4_30
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

			local var_4_31 = 0

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_32 = 1.76666666666667

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_33 = 1.76666666666667
			local var_4_34 = 0.225

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_35 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_35:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_36 = arg_1_1:FormatText(StoryNameCfg[79].name)

				arg_1_1.leftNameTxt_.text = var_4_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2033")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_37 = arg_1_1:GetWordFromCfg(106111001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 9
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_34 or var_4_34 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_34 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_33 = var_4_33 + 0.3

					if var_4_41 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_33
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111001", "story_v_out_106111.awb") ~= 0 then
					local var_4_42 = manager.audio:GetVoiceLength("story_v_out_106111", "106111001", "story_v_out_106111.awb") / 1000

					if var_4_42 + var_4_33 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_33
					end

					if var_4_37.prefab_name ~= "" and arg_1_1.actors_[var_4_37.prefab_name] ~= nil then
						local var_4_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_37.prefab_name].transform, "story_v_out_106111", "106111001", "story_v_out_106111.awb")

						arg_1_1:RecordAudio("106111001", var_4_43)
						arg_1_1:RecordAudio("106111001", var_4_43)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_106111", "106111001", "story_v_out_106111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_106111", "106111001", "story_v_out_106111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_33 + 0.3
			local var_4_45 = math.max(var_4_34, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play106111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106111002
		arg_8_1.duration_ = 6.93

		local var_8_0 = {
			ja = 4.033,
			ko = 6.933,
			zh = 6,
			en = 6.466
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
				arg_8_0:Play106111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1093ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1093ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1093ui_story == nil then
				arg_8_1.var_.characterEffect1093ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1093ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1093ui_story then
				arg_8_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_11_9 = "2033_tpose"

			if arg_8_1.actors_[var_11_9] == nil then
				local var_11_10 = Asset.Load("Char/" .. "2033_tpose")

				if not isNil(var_11_10) then
					local var_11_11 = Object.Instantiate(Asset.Load("Char/" .. "2033_tpose"), arg_8_1.stage_.transform)

					var_11_11.name = var_11_9
					var_11_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_9] = var_11_11

					local var_11_12 = var_11_11:GetComponentInChildren(typeof(CharacterEffect))

					var_11_12.enabled = true

					local var_11_13 = GameObjectTools.GetOrAddComponent(var_11_11, typeof(DynamicBoneHelper))

					if var_11_13 then
						var_11_13:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_12.transform, false)

					arg_8_1.var_[var_11_9 .. "Animator"] = var_11_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_9 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_9 .. "LipSync"] = var_11_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_14 = arg_8_1.actors_["2033_tpose"].transform
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.var_.moveOldPos2033_tpose = var_11_14.localPosition

				local var_11_16 = GameObjectTools.GetOrAddComponent(var_11_14.gameObject, typeof(DynamicBoneHelper))

				if var_11_16 then
					var_11_16:EnableDynamicBone(false)
				end
			end

			local var_11_17 = 0.001

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_17 then
				local var_11_18 = (arg_8_1.time_ - var_11_15) / var_11_17
				local var_11_19 = Vector3.New(0, 100, 0)

				var_11_14.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos2033_tpose, var_11_19, var_11_18)

				local var_11_20 = manager.ui.mainCamera.transform.position - var_11_14.position

				var_11_14.forward = Vector3.New(var_11_20.x, var_11_20.y, var_11_20.z)

				local var_11_21 = var_11_14.localEulerAngles

				var_11_21.z = 0
				var_11_21.x = 0
				var_11_14.localEulerAngles = var_11_21
			end

			if arg_8_1.time_ >= var_11_15 + var_11_17 and arg_8_1.time_ < var_11_15 + var_11_17 + arg_11_0 then
				var_11_14.localPosition = Vector3.New(0, 100, 0)

				local var_11_22 = manager.ui.mainCamera.transform.position - var_11_14.position

				var_11_14.forward = Vector3.New(var_11_22.x, var_11_22.y, var_11_22.z)

				local var_11_23 = var_11_14.localEulerAngles

				var_11_23.z = 0
				var_11_23.x = 0
				var_11_14.localEulerAngles = var_11_23

				local var_11_24 = GameObjectTools.GetOrAddComponent(var_11_14.gameObject, typeof(DynamicBoneHelper))

				if var_11_24 then
					var_11_24:EnableDynamicBone(true)
				end
			end

			local var_11_25 = arg_8_1.actors_["1093ui_story"].transform
			local var_11_26 = 0

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.var_.moveOldPos1093ui_story = var_11_25.localPosition

				local var_11_27 = "1093ui_story"

				arg_8_1:ShowWeapon(arg_8_1.var_[var_11_27 .. "Animator"].transform, true)
			end

			local var_11_28 = 0.001

			if var_11_26 <= arg_8_1.time_ and arg_8_1.time_ < var_11_26 + var_11_28 then
				local var_11_29 = (arg_8_1.time_ - var_11_26) / var_11_28
				local var_11_30 = Vector3.New(0, -1.11, -5.88)

				var_11_25.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1093ui_story, var_11_30, var_11_29)

				local var_11_31 = manager.ui.mainCamera.transform.position - var_11_25.position

				var_11_25.forward = Vector3.New(var_11_31.x, var_11_31.y, var_11_31.z)

				local var_11_32 = var_11_25.localEulerAngles

				var_11_32.z = 0
				var_11_32.x = 0
				var_11_25.localEulerAngles = var_11_32
			end

			if arg_8_1.time_ >= var_11_26 + var_11_28 and arg_8_1.time_ < var_11_26 + var_11_28 + arg_11_0 then
				var_11_25.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_11_33 = manager.ui.mainCamera.transform.position - var_11_25.position

				var_11_25.forward = Vector3.New(var_11_33.x, var_11_33.y, var_11_33.z)

				local var_11_34 = var_11_25.localEulerAngles

				var_11_34.z = 0
				var_11_34.x = 0
				var_11_25.localEulerAngles = var_11_34
			end

			local var_11_35 = 0

			if var_11_35 < arg_8_1.time_ and arg_8_1.time_ <= var_11_35 + arg_11_0 then
				arg_8_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_1")
			end

			local var_11_36 = 0

			if var_11_36 < arg_8_1.time_ and arg_8_1.time_ <= var_11_36 + arg_11_0 then
				arg_8_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_11_37 = 0
			local var_11_38 = 0.65

			if var_11_37 < arg_8_1.time_ and arg_8_1.time_ <= var_11_37 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_39 = arg_8_1:FormatText(StoryNameCfg[73].name)

				arg_8_1.leftNameTxt_.text = var_11_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_40 = arg_8_1:GetWordFromCfg(106111002)
				local var_11_41 = arg_8_1:FormatText(var_11_40.content)

				arg_8_1.text_.text = var_11_41

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_42 = 26
				local var_11_43 = utf8.len(var_11_41)
				local var_11_44 = var_11_42 <= 0 and var_11_38 or var_11_38 * (var_11_43 / var_11_42)

				if var_11_44 > 0 and var_11_38 < var_11_44 then
					arg_8_1.talkMaxDuration = var_11_44

					if var_11_44 + var_11_37 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_44 + var_11_37
					end
				end

				arg_8_1.text_.text = var_11_41
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111002", "story_v_out_106111.awb") ~= 0 then
					local var_11_45 = manager.audio:GetVoiceLength("story_v_out_106111", "106111002", "story_v_out_106111.awb") / 1000

					if var_11_45 + var_11_37 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_45 + var_11_37
					end

					if var_11_40.prefab_name ~= "" and arg_8_1.actors_[var_11_40.prefab_name] ~= nil then
						local var_11_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_40.prefab_name].transform, "story_v_out_106111", "106111002", "story_v_out_106111.awb")

						arg_8_1:RecordAudio("106111002", var_11_46)
						arg_8_1:RecordAudio("106111002", var_11_46)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_106111", "106111002", "story_v_out_106111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_106111", "106111002", "story_v_out_106111.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_47 = math.max(var_11_38, arg_8_1.talkMaxDuration)

			if var_11_37 <= arg_8_1.time_ and arg_8_1.time_ < var_11_37 + var_11_47 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_37) / var_11_47

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_37 + var_11_47 and arg_8_1.time_ < var_11_37 + var_11_47 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2033_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play106111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106111003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play106111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1093ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1093ui_story == nil then
				arg_12_1.var_.characterEffect1093ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.1

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1093ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1093ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1093ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1093ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 1

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				local var_15_8 = "play"
				local var_15_9 = "effect"

				arg_12_1:AudioAction(var_15_8, var_15_9, "se_story_6", "se_story_6_draw_sword", "")
			end

			local var_15_10 = 0
			local var_15_11 = 0.625

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(106111003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_14 = 25
				local var_15_15 = utf8.len(var_15_13)
				local var_15_16 = var_15_14 <= 0 and var_15_11 or var_15_11 * (var_15_15 / var_15_14)

				if var_15_16 > 0 and var_15_11 < var_15_16 then
					arg_12_1.talkMaxDuration = var_15_16

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_17 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_17 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_17

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_17 and arg_12_1.time_ < var_15_10 + var_15_17 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play106111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106111004
		arg_16_1.duration_ = 8.1

		local var_16_0 = {
			ja = 5.233,
			ko = 6.233,
			zh = 7.6,
			en = 8.1
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
				arg_16_0:Play106111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1093ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1093ui_story == nil then
				arg_16_1.var_.characterEffect1093ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1093ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1093ui_story then
				arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_19_4 = 0

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action494")
			end

			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_19_6 = 0
			local var_19_7 = 0.775

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[73].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_9 = arg_16_1:GetWordFromCfg(106111004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 31
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_7 or var_19_7 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_7 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111004", "story_v_out_106111.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_106111", "106111004", "story_v_out_106111.awb") / 1000

					if var_19_14 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_6
					end

					if var_19_9.prefab_name ~= "" and arg_16_1.actors_[var_19_9.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_9.prefab_name].transform, "story_v_out_106111", "106111004", "story_v_out_106111.awb")

						arg_16_1:RecordAudio("106111004", var_19_15)
						arg_16_1:RecordAudio("106111004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_106111", "106111004", "story_v_out_106111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_106111", "106111004", "story_v_out_106111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_16 and arg_16_1.time_ < var_19_6 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play106111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106111005
		arg_20_1.duration_ = 12.37

		local var_20_0 = {
			ja = 12.366,
			ko = 8.3,
			zh = 7.6,
			en = 7.5
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
				arg_20_0:Play106111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.975

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[73].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:GetWordFromCfg(106111005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111005", "story_v_out_106111.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_106111", "106111005", "story_v_out_106111.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_106111", "106111005", "story_v_out_106111.awb")

						arg_20_1:RecordAudio("106111005", var_23_9)
						arg_20_1:RecordAudio("106111005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106111", "106111005", "story_v_out_106111.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106111", "106111005", "story_v_out_106111.awb")
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
	Play106111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106111006
		arg_24_1.duration_ = 6.63

		local var_24_0 = {
			ja = 6.633,
			ko = 4.433,
			zh = 5.6,
			en = 5.833
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
				arg_24_0:Play106111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1093ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1093ui_story == nil then
				arg_24_1.var_.characterEffect1093ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1093ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1093ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1093ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1093ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.55

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[36].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_9 = arg_24_1:GetWordFromCfg(106111006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 19
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111006", "story_v_out_106111.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_106111", "106111006", "story_v_out_106111.awb") / 1000

					if var_27_14 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_6
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_106111", "106111006", "story_v_out_106111.awb")

						arg_24_1:RecordAudio("106111006", var_27_15)
						arg_24_1:RecordAudio("106111006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_106111", "106111006", "story_v_out_106111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_106111", "106111006", "story_v_out_106111.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_16 and arg_24_1.time_ < var_27_6 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play106111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106111007
		arg_28_1.duration_ = 2

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play106111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1093ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1093ui_story == nil then
				arg_28_1.var_.characterEffect1093ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1093ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1093ui_story then
				arg_28_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action442")
			end

			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_31_6 = 0
			local var_31_7 = 0.075

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[73].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_9 = arg_28_1:GetWordFromCfg(106111007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 3
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111007", "story_v_out_106111.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_106111", "106111007", "story_v_out_106111.awb") / 1000

					if var_31_14 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_6
					end

					if var_31_9.prefab_name ~= "" and arg_28_1.actors_[var_31_9.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_9.prefab_name].transform, "story_v_out_106111", "106111007", "story_v_out_106111.awb")

						arg_28_1:RecordAudio("106111007", var_31_15)
						arg_28_1:RecordAudio("106111007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_106111", "106111007", "story_v_out_106111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_106111", "106111007", "story_v_out_106111.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_16 and arg_28_1.time_ < var_31_6 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play106111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106111008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play106111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1093ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1093ui_story == nil then
				arg_32_1.var_.characterEffect1093ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1093ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1093ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1093ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1093ui_story.fillRatio = var_35_5
			end

			local var_35_6 = arg_32_1.actors_["1093ui_story"].transform
			local var_35_7 = 0

			if var_35_7 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.var_.moveOldPos1093ui_story = var_35_6.localPosition

				local var_35_8 = "1093ui_story"

				arg_32_1:ShowWeapon(arg_32_1.var_[var_35_8 .. "Animator"].transform, true)
			end

			local var_35_9 = 0.001

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_9 then
				local var_35_10 = (arg_32_1.time_ - var_35_7) / var_35_9
				local var_35_11 = Vector3.New(0, 100, 0)

				var_35_6.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1093ui_story, var_35_11, var_35_10)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_6.position

				var_35_6.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_6.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_6.localEulerAngles = var_35_13
			end

			if arg_32_1.time_ >= var_35_7 + var_35_9 and arg_32_1.time_ < var_35_7 + var_35_9 + arg_35_0 then
				var_35_6.localPosition = Vector3.New(0, 100, 0)

				local var_35_14 = manager.ui.mainCamera.transform.position - var_35_6.position

				var_35_6.forward = Vector3.New(var_35_14.x, var_35_14.y, var_35_14.z)

				local var_35_15 = var_35_6.localEulerAngles

				var_35_15.z = 0
				var_35_15.x = 0
				var_35_6.localEulerAngles = var_35_15
			end

			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			local var_35_17 = 0
			local var_35_18 = 1

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				local var_35_19 = "play"
				local var_35_20 = "effect"

				arg_32_1:AudioAction(var_35_19, var_35_20, "se_story_6", "se_story_6_darts", "")
			end

			local var_35_21 = 0
			local var_35_22 = 0.925

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_23 = arg_32_1:GetWordFromCfg(106111008)
				local var_35_24 = arg_32_1:FormatText(var_35_23.content)

				arg_32_1.text_.text = var_35_24

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_25 = 37
				local var_35_26 = utf8.len(var_35_24)
				local var_35_27 = var_35_25 <= 0 and var_35_22 or var_35_22 * (var_35_26 / var_35_25)

				if var_35_27 > 0 and var_35_22 < var_35_27 then
					arg_32_1.talkMaxDuration = var_35_27

					if var_35_27 + var_35_21 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_27 + var_35_21
					end
				end

				arg_32_1.text_.text = var_35_24
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_28 = math.max(var_35_22, arg_32_1.talkMaxDuration)

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_28 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_21) / var_35_28

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_21 + var_35_28 and arg_32_1.time_ < var_35_21 + var_35_28 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play106111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106111009
		arg_36_1.duration_ = 5

		local var_36_0 = {
			ja = 5,
			ko = 4.3,
			zh = 3.833,
			en = 3.533
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
				arg_36_0:Play106111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1093ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1093ui_story == nil then
				arg_36_1.var_.characterEffect1093ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1093ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1093ui_story then
				arg_36_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1093ui_story"].transform
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.var_.moveOldPos1093ui_story = var_39_4.localPosition

				local var_39_6 = "1093ui_story"

				arg_36_1:ShowWeapon(arg_36_1.var_[var_39_6 .. "Animator"].transform, true)
			end

			local var_39_7 = 0.001

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_7 then
				local var_39_8 = (arg_36_1.time_ - var_39_5) / var_39_7
				local var_39_9 = Vector3.New(0, -1.11, -5.88)

				var_39_4.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1093ui_story, var_39_9, var_39_8)

				local var_39_10 = manager.ui.mainCamera.transform.position - var_39_4.position

				var_39_4.forward = Vector3.New(var_39_10.x, var_39_10.y, var_39_10.z)

				local var_39_11 = var_39_4.localEulerAngles

				var_39_11.z = 0
				var_39_11.x = 0
				var_39_4.localEulerAngles = var_39_11
			end

			if arg_36_1.time_ >= var_39_5 + var_39_7 and arg_36_1.time_ < var_39_5 + var_39_7 + arg_39_0 then
				var_39_4.localPosition = Vector3.New(0, -1.11, -5.88)

				local var_39_12 = manager.ui.mainCamera.transform.position - var_39_4.position

				var_39_4.forward = Vector3.New(var_39_12.x, var_39_12.y, var_39_12.z)

				local var_39_13 = var_39_4.localEulerAngles

				var_39_13.z = 0
				var_39_13.x = 0
				var_39_4.localEulerAngles = var_39_13
			end

			local var_39_14 = 0

			if var_39_14 < arg_36_1.time_ and arg_36_1.time_ <= var_39_14 + arg_39_0 then
				arg_36_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_39_15 = 0
			local var_39_16 = 0.475

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_17 = arg_36_1:FormatText(StoryNameCfg[73].name)

				arg_36_1.leftNameTxt_.text = var_39_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_18 = arg_36_1:GetWordFromCfg(106111009)
				local var_39_19 = arg_36_1:FormatText(var_39_18.content)

				arg_36_1.text_.text = var_39_19

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_20 = 19
				local var_39_21 = utf8.len(var_39_19)
				local var_39_22 = var_39_20 <= 0 and var_39_16 or var_39_16 * (var_39_21 / var_39_20)

				if var_39_22 > 0 and var_39_16 < var_39_22 then
					arg_36_1.talkMaxDuration = var_39_22

					if var_39_22 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_22 + var_39_15
					end
				end

				arg_36_1.text_.text = var_39_19
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111009", "story_v_out_106111.awb") ~= 0 then
					local var_39_23 = manager.audio:GetVoiceLength("story_v_out_106111", "106111009", "story_v_out_106111.awb") / 1000

					if var_39_23 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_15
					end

					if var_39_18.prefab_name ~= "" and arg_36_1.actors_[var_39_18.prefab_name] ~= nil then
						local var_39_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_18.prefab_name].transform, "story_v_out_106111", "106111009", "story_v_out_106111.awb")

						arg_36_1:RecordAudio("106111009", var_39_24)
						arg_36_1:RecordAudio("106111009", var_39_24)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_106111", "106111009", "story_v_out_106111.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_106111", "106111009", "story_v_out_106111.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_25 = math.max(var_39_16, arg_36_1.talkMaxDuration)

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_25 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_15) / var_39_25

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_15 + var_39_25 and arg_36_1.time_ < var_39_15 + var_39_25 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play106111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106111010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play106111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1093ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1093ui_story == nil then
				arg_40_1.var_.characterEffect1093ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1093ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1093ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1093ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1093ui_story.fillRatio = var_43_5
			end

			local var_43_6 = arg_40_1.actors_["1093ui_story"].transform
			local var_43_7 = 0

			if var_43_7 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1.var_.moveOldPos1093ui_story = var_43_6.localPosition

				local var_43_8 = "1093ui_story"

				arg_40_1:ShowWeapon(arg_40_1.var_[var_43_8 .. "Animator"].transform, true)
			end

			local var_43_9 = 0.001

			if var_43_7 <= arg_40_1.time_ and arg_40_1.time_ < var_43_7 + var_43_9 then
				local var_43_10 = (arg_40_1.time_ - var_43_7) / var_43_9
				local var_43_11 = Vector3.New(0, 100, 0)

				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1093ui_story, var_43_11, var_43_10)

				local var_43_12 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_12.x, var_43_12.y, var_43_12.z)

				local var_43_13 = var_43_6.localEulerAngles

				var_43_13.z = 0
				var_43_13.x = 0
				var_43_6.localEulerAngles = var_43_13
			end

			if arg_40_1.time_ >= var_43_7 + var_43_9 and arg_40_1.time_ < var_43_7 + var_43_9 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(0, 100, 0)

				local var_43_14 = manager.ui.mainCamera.transform.position - var_43_6.position

				var_43_6.forward = Vector3.New(var_43_14.x, var_43_14.y, var_43_14.z)

				local var_43_15 = var_43_6.localEulerAngles

				var_43_15.z = 0
				var_43_15.x = 0
				var_43_6.localEulerAngles = var_43_15
			end

			local var_43_16 = 0
			local var_43_17 = 0.85

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_18 = arg_40_1:GetWordFromCfg(106111010)
				local var_43_19 = arg_40_1:FormatText(var_43_18.content)

				arg_40_1.text_.text = var_43_19

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_20 = 34
				local var_43_21 = utf8.len(var_43_19)
				local var_43_22 = var_43_20 <= 0 and var_43_17 or var_43_17 * (var_43_21 / var_43_20)

				if var_43_22 > 0 and var_43_17 < var_43_22 then
					arg_40_1.talkMaxDuration = var_43_22

					if var_43_22 + var_43_16 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_22 + var_43_16
					end
				end

				arg_40_1.text_.text = var_43_19
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_23 = math.max(var_43_17, arg_40_1.talkMaxDuration)

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_23 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_16) / var_43_23

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_16 + var_43_23 and arg_40_1.time_ < var_43_16 + var_43_23 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play106111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 106111011
		arg_44_1.duration_ = 10.9

		local var_44_0 = {
			ja = 9.866,
			ko = 9.933,
			zh = 10.9,
			en = 9.966
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
				arg_44_0:Play106111012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.bgs_.C02b.transform
			local var_47_1 = 1.466

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPosC02b = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, -100, 10)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPosC02b, var_47_4, var_47_3)
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, -100, 10)
			end

			local var_47_5 = "S0608"

			if arg_44_1.bgs_[var_47_5] == nil then
				local var_47_6 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_5)
				var_47_6.name = var_47_5
				var_47_6.transform.parent = arg_44_1.stage_.transform
				var_47_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_5] = var_47_6
			end

			local var_47_7 = 1.5

			if var_47_7 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 then
				local var_47_8 = manager.ui.mainCamera.transform.localPosition
				local var_47_9 = Vector3.New(0, 0, 10) + Vector3.New(var_47_8.x, var_47_8.y, 0)
				local var_47_10 = arg_44_1.bgs_.S0608

				var_47_10.transform.localPosition = var_47_9
				var_47_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_11 = var_47_10:GetComponent("SpriteRenderer")

				if var_47_11 and var_47_11.sprite then
					local var_47_12 = (var_47_10.transform.localPosition - var_47_8).z
					local var_47_13 = manager.ui.mainCameraCom_
					local var_47_14 = 2 * var_47_12 * Mathf.Tan(var_47_13.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_15 = var_47_14 * var_47_13.aspect
					local var_47_16 = var_47_11.sprite.bounds.size.x
					local var_47_17 = var_47_11.sprite.bounds.size.y
					local var_47_18 = var_47_15 / var_47_16
					local var_47_19 = var_47_14 / var_47_17
					local var_47_20 = var_47_19 < var_47_18 and var_47_18 or var_47_19

					var_47_10.transform.localScale = Vector3.New(var_47_20, var_47_20, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "S0608" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_21 = arg_44_1.bgs_.C02b
			local var_47_22 = 0

			if var_47_22 < arg_44_1.time_ and arg_44_1.time_ <= var_47_22 + arg_47_0 then
				local var_47_23 = var_47_21:GetComponent("SpriteRenderer")

				if var_47_23 then
					arg_44_1.var_.alphaOldValueC02b = var_47_23.color.a
					arg_44_1.var_.alphaMatValueC02b = var_47_23
				end

				arg_44_1.var_.alphaOldValueC02b = 1
			end

			local var_47_24 = 1.5

			if var_47_22 <= arg_44_1.time_ and arg_44_1.time_ < var_47_22 + var_47_24 then
				local var_47_25 = (arg_44_1.time_ - var_47_22) / var_47_24
				local var_47_26 = Mathf.Lerp(arg_44_1.var_.alphaOldValueC02b, 0, var_47_25)

				if arg_44_1.var_.alphaMatValueC02b then
					local var_47_27 = arg_44_1.var_.alphaMatValueC02b.color

					var_47_27.a = var_47_26
					arg_44_1.var_.alphaMatValueC02b.color = var_47_27
				end
			end

			if arg_44_1.time_ >= var_47_22 + var_47_24 and arg_44_1.time_ < var_47_22 + var_47_24 + arg_47_0 and arg_44_1.var_.alphaMatValueC02b then
				local var_47_28 = arg_44_1.var_.alphaMatValueC02b
				local var_47_29 = var_47_28.color

				var_47_29.a = 0
				var_47_28.color = var_47_29
			end

			local var_47_30 = arg_44_1.bgs_.S0608
			local var_47_31 = 1.5

			if var_47_31 < arg_44_1.time_ and arg_44_1.time_ <= var_47_31 + arg_47_0 then
				local var_47_32 = var_47_30:GetComponent("SpriteRenderer")

				if var_47_32 then
					arg_44_1.var_.alphaOldValueS0608 = var_47_32.color.a
					arg_44_1.var_.alphaMatValueS0608 = var_47_32
				end

				arg_44_1.var_.alphaOldValueS0608 = 0
			end

			local var_47_33 = 1.5

			if var_47_31 <= arg_44_1.time_ and arg_44_1.time_ < var_47_31 + var_47_33 then
				local var_47_34 = (arg_44_1.time_ - var_47_31) / var_47_33
				local var_47_35 = Mathf.Lerp(arg_44_1.var_.alphaOldValueS0608, 1, var_47_34)

				if arg_44_1.var_.alphaMatValueS0608 then
					local var_47_36 = arg_44_1.var_.alphaMatValueS0608.color

					var_47_36.a = var_47_35
					arg_44_1.var_.alphaMatValueS0608.color = var_47_36
				end
			end

			if arg_44_1.time_ >= var_47_31 + var_47_33 and arg_44_1.time_ < var_47_31 + var_47_33 + arg_47_0 and arg_44_1.var_.alphaMatValueS0608 then
				local var_47_37 = arg_44_1.var_.alphaMatValueS0608
				local var_47_38 = var_47_37.color

				var_47_38.a = 1
				var_47_37.color = var_47_38
			end

			local var_47_39 = 0

			if var_47_39 < arg_44_1.time_ and arg_44_1.time_ <= var_47_39 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			local var_47_40 = 3

			if arg_44_1.time_ >= var_47_39 + var_47_40 and arg_44_1.time_ < var_47_39 + var_47_40 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_41 = 3
			local var_47_42 = 0.575

			if var_47_41 < arg_44_1.time_ and arg_44_1.time_ <= var_47_41 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_43 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_43:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_44 = arg_44_1:FormatText(StoryNameCfg[87].name)

				arg_44_1.leftNameTxt_.text = var_47_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_45 = arg_44_1:GetWordFromCfg(106111011)
				local var_47_46 = arg_44_1:FormatText(var_47_45.content)

				arg_44_1.text_.text = var_47_46

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_47 = 22
				local var_47_48 = utf8.len(var_47_46)
				local var_47_49 = var_47_47 <= 0 and var_47_42 or var_47_42 * (var_47_48 / var_47_47)

				if var_47_49 > 0 and var_47_42 < var_47_49 then
					arg_44_1.talkMaxDuration = var_47_49
					var_47_41 = var_47_41 + 0.3

					if var_47_49 + var_47_41 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_49 + var_47_41
					end
				end

				arg_44_1.text_.text = var_47_46
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111011", "story_v_out_106111.awb") ~= 0 then
					local var_47_50 = manager.audio:GetVoiceLength("story_v_out_106111", "106111011", "story_v_out_106111.awb") / 1000

					if var_47_50 + var_47_41 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_50 + var_47_41
					end

					if var_47_45.prefab_name ~= "" and arg_44_1.actors_[var_47_45.prefab_name] ~= nil then
						local var_47_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_45.prefab_name].transform, "story_v_out_106111", "106111011", "story_v_out_106111.awb")

						arg_44_1:RecordAudio("106111011", var_47_51)
						arg_44_1:RecordAudio("106111011", var_47_51)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_106111", "106111011", "story_v_out_106111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_106111", "106111011", "story_v_out_106111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_52 = var_47_41 + 0.3
			local var_47_53 = math.max(var_47_42, arg_44_1.talkMaxDuration)

			if var_47_52 <= arg_44_1.time_ and arg_44_1.time_ < var_47_52 + var_47_53 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_52) / var_47_53

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_52 + var_47_53 and arg_44_1.time_ < var_47_52 + var_47_53 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "C02b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.466,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play106111012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 106111012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play106111013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 1

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				local var_53_2 = "play"
				local var_53_3 = "effect"

				arg_50_1:AudioAction(var_53_2, var_53_3, "se_story_6", "se_story_6_black_fog", "")
			end

			local var_53_4 = 0
			local var_53_5 = 1.025

			if var_53_4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_6 = arg_50_1:GetWordFromCfg(106111012)
				local var_53_7 = arg_50_1:FormatText(var_53_6.content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_8 = 41
				local var_53_9 = utf8.len(var_53_7)
				local var_53_10 = var_53_8 <= 0 and var_53_5 or var_53_5 * (var_53_9 / var_53_8)

				if var_53_10 > 0 and var_53_5 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_4
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_11 = math.max(var_53_5, arg_50_1.talkMaxDuration)

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_11 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_4) / var_53_11

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_4 + var_53_11 and arg_50_1.time_ < var_53_4 + var_53_11 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play106111013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 106111013
		arg_54_1.duration_ = 6.6

		local var_54_0 = {
			ja = 6.6,
			ko = 3.5,
			zh = 3.766,
			en = 5.9
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
				arg_54_0:Play106111014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.475

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[73].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(106111013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 19
				local var_57_6 = utf8.len(var_57_4)
				local var_57_7 = var_57_5 <= 0 and var_57_1 or var_57_1 * (var_57_6 / var_57_5)

				if var_57_7 > 0 and var_57_1 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111013", "story_v_out_106111.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_106111", "106111013", "story_v_out_106111.awb") / 1000

					if var_57_8 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_0
					end

					if var_57_3.prefab_name ~= "" and arg_54_1.actors_[var_57_3.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_3.prefab_name].transform, "story_v_out_106111", "106111013", "story_v_out_106111.awb")

						arg_54_1:RecordAudio("106111013", var_57_9)
						arg_54_1:RecordAudio("106111013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_106111", "106111013", "story_v_out_106111.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_106111", "106111013", "story_v_out_106111.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_10 and arg_54_1.time_ < var_57_0 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play106111014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 106111014
		arg_58_1.duration_ = 8.63

		local var_58_0 = {
			ja = 8.633,
			ko = 6.866,
			zh = 6.2,
			en = 5.4
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
				arg_58_0:Play106111015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.65

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[87].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:GetWordFromCfg(106111014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 24
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111014", "story_v_out_106111.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_106111", "106111014", "story_v_out_106111.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_106111", "106111014", "story_v_out_106111.awb")

						arg_58_1:RecordAudio("106111014", var_61_9)
						arg_58_1:RecordAudio("106111014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_106111", "106111014", "story_v_out_106111.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_106111", "106111014", "story_v_out_106111.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_10 and arg_58_1.time_ < var_61_0 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play106111015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 106111015
		arg_62_1.duration_ = 4.7

		local var_62_0 = {
			ja = 2.966,
			ko = 3.233,
			zh = 4.7,
			en = 3.233
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
				arg_62_0:Play106111016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.35

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[73].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(106111015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 14
				local var_65_6 = utf8.len(var_65_4)
				local var_65_7 = var_65_5 <= 0 and var_65_1 or var_65_1 * (var_65_6 / var_65_5)

				if var_65_7 > 0 and var_65_1 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111015", "story_v_out_106111.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_106111", "106111015", "story_v_out_106111.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_106111", "106111015", "story_v_out_106111.awb")

						arg_62_1:RecordAudio("106111015", var_65_9)
						arg_62_1:RecordAudio("106111015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_106111", "106111015", "story_v_out_106111.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_106111", "106111015", "story_v_out_106111.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_10 and arg_62_1.time_ < var_65_0 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play106111016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 106111016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play106111017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.6

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_2 = arg_66_1:GetWordFromCfg(106111016)
				local var_69_3 = arg_66_1:FormatText(var_69_2.content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 24
				local var_69_5 = utf8.len(var_69_3)
				local var_69_6 = var_69_4 <= 0 and var_69_1 or var_69_1 * (var_69_5 / var_69_4)

				if var_69_6 > 0 and var_69_1 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_7 and arg_66_1.time_ < var_69_0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play106111017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 106111017
		arg_70_1.duration_ = 12.2

		local var_70_0 = {
			ja = 12.2,
			ko = 9.9,
			zh = 10,
			en = 7.766
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
				arg_70_0:Play106111018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = "4014_tpose"

			if arg_70_1.actors_[var_73_0] == nil then
				local var_73_1 = Asset.Load("Char/" .. "4014_tpose")

				if not isNil(var_73_1) then
					local var_73_2 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_70_1.stage_.transform)

					var_73_2.name = var_73_0
					var_73_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_70_1.actors_[var_73_0] = var_73_2

					local var_73_3 = var_73_2:GetComponentInChildren(typeof(CharacterEffect))

					var_73_3.enabled = true

					local var_73_4 = GameObjectTools.GetOrAddComponent(var_73_2, typeof(DynamicBoneHelper))

					if var_73_4 then
						var_73_4:EnableDynamicBone(false)
					end

					arg_70_1:ShowWeapon(var_73_3.transform, false)

					arg_70_1.var_[var_73_0 .. "Animator"] = var_73_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_70_1.var_[var_73_0 .. "Animator"].applyRootMotion = true
					arg_70_1.var_[var_73_0 .. "LipSync"] = var_73_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_73_5 = arg_70_1.actors_["4014_tpose"]
			local var_73_6 = 2

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect4014_tpose == nil then
				arg_70_1.var_.characterEffect4014_tpose = var_73_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_7 = 0.1

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_7 and not isNil(var_73_5) then
				local var_73_8 = (arg_70_1.time_ - var_73_6) / var_73_7

				if arg_70_1.var_.characterEffect4014_tpose and not isNil(var_73_5) then
					arg_70_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_6 + var_73_7 and arg_70_1.time_ < var_73_6 + var_73_7 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect4014_tpose then
				arg_70_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_73_9 = arg_70_1.bgs_.S0608.transform
			local var_73_10 = 1.5

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1.var_.moveOldPosS0608 = var_73_9.localPosition
			end

			local var_73_11 = 0.001

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_11 then
				local var_73_12 = (arg_70_1.time_ - var_73_10) / var_73_11
				local var_73_13 = Vector3.New(0, -100, 10)

				var_73_9.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPosS0608, var_73_13, var_73_12)
			end

			if arg_70_1.time_ >= var_73_10 + var_73_11 and arg_70_1.time_ < var_73_10 + var_73_11 + arg_73_0 then
				var_73_9.localPosition = Vector3.New(0, -100, 10)
			end

			local var_73_14 = 1.5

			if var_73_14 < arg_70_1.time_ and arg_70_1.time_ <= var_73_14 + arg_73_0 then
				local var_73_15 = manager.ui.mainCamera.transform.localPosition
				local var_73_16 = Vector3.New(0, 0, 10) + Vector3.New(var_73_15.x, var_73_15.y, 0)
				local var_73_17 = arg_70_1.bgs_.C02b

				var_73_17.transform.localPosition = var_73_16
				var_73_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_18 = var_73_17:GetComponent("SpriteRenderer")

				if var_73_18 and var_73_18.sprite then
					local var_73_19 = (var_73_17.transform.localPosition - var_73_15).z
					local var_73_20 = manager.ui.mainCameraCom_
					local var_73_21 = 2 * var_73_19 * Mathf.Tan(var_73_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_73_22 = var_73_21 * var_73_20.aspect
					local var_73_23 = var_73_18.sprite.bounds.size.x
					local var_73_24 = var_73_18.sprite.bounds.size.y
					local var_73_25 = var_73_22 / var_73_23
					local var_73_26 = var_73_21 / var_73_24
					local var_73_27 = var_73_26 < var_73_25 and var_73_25 or var_73_26

					var_73_17.transform.localScale = Vector3.New(var_73_27, var_73_27, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "C02b" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_28 = arg_70_1.actors_["4014_tpose"].transform
			local var_73_29 = 2

			if var_73_29 < arg_70_1.time_ and arg_70_1.time_ <= var_73_29 + arg_73_0 then
				arg_70_1.var_.moveOldPos4014_tpose = var_73_28.localPosition

				local var_73_30 = GameObjectTools.GetOrAddComponent(var_73_28.gameObject, typeof(DynamicBoneHelper))

				if var_73_30 then
					var_73_30:EnableDynamicBone(false)
				end
			end

			local var_73_31 = 0.001

			if var_73_29 <= arg_70_1.time_ and arg_70_1.time_ < var_73_29 + var_73_31 then
				local var_73_32 = (arg_70_1.time_ - var_73_29) / var_73_31
				local var_73_33 = Vector3.New(0, -1.95, -4.2)

				var_73_28.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos4014_tpose, var_73_33, var_73_32)

				local var_73_34 = manager.ui.mainCamera.transform.position - var_73_28.position

				var_73_28.forward = Vector3.New(var_73_34.x, var_73_34.y, var_73_34.z)

				local var_73_35 = var_73_28.localEulerAngles

				var_73_35.z = 0
				var_73_35.x = 0
				var_73_28.localEulerAngles = var_73_35
			end

			if arg_70_1.time_ >= var_73_29 + var_73_31 and arg_70_1.time_ < var_73_29 + var_73_31 + arg_73_0 then
				var_73_28.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_73_36 = manager.ui.mainCamera.transform.position - var_73_28.position

				var_73_28.forward = Vector3.New(var_73_36.x, var_73_36.y, var_73_36.z)

				local var_73_37 = var_73_28.localEulerAngles

				var_73_37.z = 0
				var_73_37.x = 0
				var_73_28.localEulerAngles = var_73_37

				local var_73_38 = GameObjectTools.GetOrAddComponent(var_73_28.gameObject, typeof(DynamicBoneHelper))

				if var_73_38 then
					var_73_38:EnableDynamicBone(true)
				end
			end

			local var_73_39 = 2

			if var_73_39 < arg_70_1.time_ and arg_70_1.time_ <= var_73_39 + arg_73_0 then
				arg_70_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_73_40 = arg_70_1.bgs_.C02b
			local var_73_41 = 1.5

			if var_73_41 < arg_70_1.time_ and arg_70_1.time_ <= var_73_41 + arg_73_0 then
				local var_73_42 = var_73_40:GetComponent("SpriteRenderer")

				if var_73_42 then
					arg_70_1.var_.alphaOldValueC02b = var_73_42.color.a
					arg_70_1.var_.alphaMatValueC02b = var_73_42
				end

				arg_70_1.var_.alphaOldValueC02b = 0
			end

			local var_73_43 = 1.5

			if var_73_41 <= arg_70_1.time_ and arg_70_1.time_ < var_73_41 + var_73_43 then
				local var_73_44 = (arg_70_1.time_ - var_73_41) / var_73_43
				local var_73_45 = Mathf.Lerp(arg_70_1.var_.alphaOldValueC02b, 1, var_73_44)

				if arg_70_1.var_.alphaMatValueC02b then
					local var_73_46 = arg_70_1.var_.alphaMatValueC02b.color

					var_73_46.a = var_73_45
					arg_70_1.var_.alphaMatValueC02b.color = var_73_46
				end
			end

			if arg_70_1.time_ >= var_73_41 + var_73_43 and arg_70_1.time_ < var_73_41 + var_73_43 + arg_73_0 and arg_70_1.var_.alphaMatValueC02b then
				local var_73_47 = arg_70_1.var_.alphaMatValueC02b
				local var_73_48 = var_73_47.color

				var_73_48.a = 1
				var_73_47.color = var_73_48
			end

			local var_73_49 = arg_70_1.bgs_.S0608
			local var_73_50 = 0

			if var_73_50 < arg_70_1.time_ and arg_70_1.time_ <= var_73_50 + arg_73_0 then
				local var_73_51 = var_73_49:GetComponent("SpriteRenderer")

				if var_73_51 then
					arg_70_1.var_.alphaOldValueS0608 = var_73_51.color.a
					arg_70_1.var_.alphaMatValueS0608 = var_73_51
				end

				arg_70_1.var_.alphaOldValueS0608 = 1
			end

			local var_73_52 = 1.5

			if var_73_50 <= arg_70_1.time_ and arg_70_1.time_ < var_73_50 + var_73_52 then
				local var_73_53 = (arg_70_1.time_ - var_73_50) / var_73_52
				local var_73_54 = Mathf.Lerp(arg_70_1.var_.alphaOldValueS0608, 0, var_73_53)

				if arg_70_1.var_.alphaMatValueS0608 then
					local var_73_55 = arg_70_1.var_.alphaMatValueS0608.color

					var_73_55.a = var_73_54
					arg_70_1.var_.alphaMatValueS0608.color = var_73_55
				end
			end

			if arg_70_1.time_ >= var_73_50 + var_73_52 and arg_70_1.time_ < var_73_50 + var_73_52 + arg_73_0 and arg_70_1.var_.alphaMatValueS0608 then
				local var_73_56 = arg_70_1.var_.alphaMatValueS0608
				local var_73_57 = var_73_56.color

				var_73_57.a = 0
				var_73_56.color = var_73_57
			end

			local var_73_58 = 0

			if var_73_58 < arg_70_1.time_ and arg_70_1.time_ <= var_73_58 + arg_73_0 then
				arg_70_1.allBtn_.enabled = false
			end

			local var_73_59 = 2

			if arg_70_1.time_ >= var_73_58 + var_73_59 and arg_70_1.time_ < var_73_58 + var_73_59 + arg_73_0 then
				arg_70_1.allBtn_.enabled = true
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_60 = 2
			local var_73_61 = 0.675

			if var_73_60 < arg_70_1.time_ and arg_70_1.time_ <= var_73_60 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_62 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_62:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_63 = arg_70_1:FormatText(StoryNameCfg[87].name)

				arg_70_1.leftNameTxt_.text = var_73_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_64 = arg_70_1:GetWordFromCfg(106111017)
				local var_73_65 = arg_70_1:FormatText(var_73_64.content)

				arg_70_1.text_.text = var_73_65

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_66 = 27
				local var_73_67 = utf8.len(var_73_65)
				local var_73_68 = var_73_66 <= 0 and var_73_61 or var_73_61 * (var_73_67 / var_73_66)

				if var_73_68 > 0 and var_73_61 < var_73_68 then
					arg_70_1.talkMaxDuration = var_73_68
					var_73_60 = var_73_60 + 0.3

					if var_73_68 + var_73_60 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_68 + var_73_60
					end
				end

				arg_70_1.text_.text = var_73_65
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111017", "story_v_out_106111.awb") ~= 0 then
					local var_73_69 = manager.audio:GetVoiceLength("story_v_out_106111", "106111017", "story_v_out_106111.awb") / 1000

					if var_73_69 + var_73_60 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_69 + var_73_60
					end

					if var_73_64.prefab_name ~= "" and arg_70_1.actors_[var_73_64.prefab_name] ~= nil then
						local var_73_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_64.prefab_name].transform, "story_v_out_106111", "106111017", "story_v_out_106111.awb")

						arg_70_1:RecordAudio("106111017", var_73_70)
						arg_70_1:RecordAudio("106111017", var_73_70)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_106111", "106111017", "story_v_out_106111.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_106111", "106111017", "story_v_out_106111.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_71 = var_73_60 + 0.3
			local var_73_72 = math.max(var_73_61, arg_70_1.talkMaxDuration)

			if var_73_71 <= arg_70_1.time_ and arg_70_1.time_ < var_73_71 + var_73_72 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_71) / var_73_72

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_71 + var_73_72 and arg_70_1.time_ < var_73_71 + var_73_72 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0608",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play106111018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 106111018
		arg_76_1.duration_ = 9.23

		local var_76_0 = {
			ja = 9.233,
			ko = 6.1,
			zh = 7.666,
			en = 6.5
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
				arg_76_0:Play106111019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.725

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[87].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_3 = arg_76_1:GetWordFromCfg(106111018)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 29
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106111", "106111018", "story_v_out_106111.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_106111", "106111018", "story_v_out_106111.awb") / 1000

					if var_79_8 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_0
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_106111", "106111018", "story_v_out_106111.awb")

						arg_76_1:RecordAudio("106111018", var_79_9)
						arg_76_1:RecordAudio("106111018", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_106111", "106111018", "story_v_out_106111.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_106111", "106111018", "story_v_out_106111.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_10 and arg_76_1.time_ < var_79_0 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play106111019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 106111019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
			arg_80_1.auto_ = false
		end

		function arg_80_1.playNext_(arg_82_0)
			arg_80_1.onStoryFinished_()
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["4014_tpose"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect4014_tpose == nil then
				arg_80_1.var_.characterEffect4014_tpose = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect4014_tpose and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_80_1.var_.characterEffect4014_tpose.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect4014_tpose then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_80_1.var_.characterEffect4014_tpose.fillRatio = var_83_5
			end

			local var_83_6 = arg_80_1.actors_["4014_tpose"].transform
			local var_83_7 = 0

			if var_83_7 < arg_80_1.time_ and arg_80_1.time_ <= var_83_7 + arg_83_0 then
				arg_80_1.var_.moveOldPos4014_tpose = var_83_6.localPosition

				local var_83_8 = GameObjectTools.GetOrAddComponent(var_83_6.gameObject, typeof(DynamicBoneHelper))

				if var_83_8 then
					var_83_8:EnableDynamicBone(false)
				end
			end

			local var_83_9 = 0.001

			if var_83_7 <= arg_80_1.time_ and arg_80_1.time_ < var_83_7 + var_83_9 then
				local var_83_10 = (arg_80_1.time_ - var_83_7) / var_83_9
				local var_83_11 = Vector3.New(0, 100, 0)

				var_83_6.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos4014_tpose, var_83_11, var_83_10)

				local var_83_12 = manager.ui.mainCamera.transform.position - var_83_6.position

				var_83_6.forward = Vector3.New(var_83_12.x, var_83_12.y, var_83_12.z)

				local var_83_13 = var_83_6.localEulerAngles

				var_83_13.z = 0
				var_83_13.x = 0
				var_83_6.localEulerAngles = var_83_13
			end

			if arg_80_1.time_ >= var_83_7 + var_83_9 and arg_80_1.time_ < var_83_7 + var_83_9 + arg_83_0 then
				var_83_6.localPosition = Vector3.New(0, 100, 0)

				local var_83_14 = manager.ui.mainCamera.transform.position - var_83_6.position

				var_83_6.forward = Vector3.New(var_83_14.x, var_83_14.y, var_83_14.z)

				local var_83_15 = var_83_6.localEulerAngles

				var_83_15.z = 0
				var_83_15.x = 0
				var_83_6.localEulerAngles = var_83_15

				local var_83_16 = GameObjectTools.GetOrAddComponent(var_83_6.gameObject, typeof(DynamicBoneHelper))

				if var_83_16 then
					var_83_16:EnableDynamicBone(true)
				end
			end

			local var_83_17 = 0
			local var_83_18 = 1.425

			if var_83_17 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				local var_83_19 = "play"
				local var_83_20 = "effect"

				arg_80_1:AudioAction(var_83_19, var_83_20, "se_story_6", "se_story_6_summon_monster", "")
			end

			local var_83_21 = 0
			local var_83_22 = 1.425

			if var_83_21 < arg_80_1.time_ and arg_80_1.time_ <= var_83_21 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_23 = arg_80_1:GetWordFromCfg(106111019)
				local var_83_24 = arg_80_1:FormatText(var_83_23.content)

				arg_80_1.text_.text = var_83_24

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_25 = 57
				local var_83_26 = utf8.len(var_83_24)
				local var_83_27 = var_83_25 <= 0 and var_83_22 or var_83_22 * (var_83_26 / var_83_25)

				if var_83_27 > 0 and var_83_22 < var_83_27 then
					arg_80_1.talkMaxDuration = var_83_27

					if var_83_27 + var_83_21 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_27 + var_83_21
					end
				end

				arg_80_1.text_.text = var_83_24
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_28 = math.max(var_83_22, arg_80_1.talkMaxDuration)

			if var_83_21 <= arg_80_1.time_ and arg_80_1.time_ < var_83_21 + var_83_28 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_21) / var_83_28

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_21 + var_83_28 and arg_80_1.time_ < var_83_21 + var_83_28 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C02b",
		"TextureConfig/Background/S0608"
	},
	voices = {
		"story_v_out_106111.awb"
	}
}
