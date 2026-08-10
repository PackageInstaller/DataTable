return {
	Play324751001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324751001
		arg_1_1.duration_ = 4.73

		local var_1_0 = {
			zh = 4.033,
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
				arg_1_0:Play324751002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2007"

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
				local var_4_5 = arg_1_1.bgs_.ST2007

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
					if iter_4_0 ~= "ST2007" then
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

			local var_4_22 = 0.1
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "effect"

				arg_1_1:AudioAction(var_4_24, var_4_25, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_4_26 = 0
			local var_4_27 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "effect"

				arg_1_1:AudioAction(var_4_28, var_4_29, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_30 = 1
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 2
			local var_4_37 = 0.225

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[1488].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_40 = arg_1_1:GetWordFromCfg(324751001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 9
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751001", "story_v_out_324751.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_324751", "324751001", "story_v_out_324751.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_324751", "324751001", "story_v_out_324751.awb")

						arg_1_1:RecordAudio("324751001", var_4_46)
						arg_1_1:RecordAudio("324751001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324751", "324751001", "story_v_out_324751.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324751", "324751001", "story_v_out_324751.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_36 + 0.3
			local var_4_48 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324751002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324751002
		arg_8_1.duration_ = 4.6

		local var_8_0 = {
			zh = 3.266,
			ja = 4.6
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
				arg_8_0:Play324751003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1036ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1036ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1036ui_story == nil then
				arg_8_1.var_.characterEffect1036ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.200000002980232

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1036ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1036ui_story then
				arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_11_9 = "1037ui_story"

			if arg_8_1.actors_[var_11_9] == nil then
				local var_11_10 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_11_10) then
					local var_11_11 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_8_1.stage_.transform)

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

			local var_11_14 = arg_8_1.actors_["1037ui_story"]
			local var_11_15 = 0

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1037ui_story == nil then
				arg_8_1.var_.characterEffect1037ui_story = var_11_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_16 = 0.200000002980232

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_16 and not isNil(var_11_14) then
				local var_11_17 = (arg_8_1.time_ - var_11_15) / var_11_16

				if arg_8_1.var_.characterEffect1037ui_story and not isNil(var_11_14) then
					local var_11_18 = Mathf.Lerp(0, 0.5, var_11_17)

					arg_8_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1037ui_story.fillRatio = var_11_18
				end
			end

			if arg_8_1.time_ >= var_11_15 + var_11_16 and arg_8_1.time_ < var_11_15 + var_11_16 + arg_11_0 and not isNil(var_11_14) and arg_8_1.var_.characterEffect1037ui_story then
				local var_11_19 = 0.5

				arg_8_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1037ui_story.fillRatio = var_11_19
			end

			local var_11_20 = 0
			local var_11_21 = 0.3

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_22 = arg_8_1:FormatText(StoryNameCfg[1487].name)

				arg_8_1.leftNameTxt_.text = var_11_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_23 = arg_8_1:GetWordFromCfg(324751002)
				local var_11_24 = arg_8_1:FormatText(var_11_23.content)

				arg_8_1.text_.text = var_11_24

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_25 = 12
				local var_11_26 = utf8.len(var_11_24)
				local var_11_27 = var_11_25 <= 0 and var_11_21 or var_11_21 * (var_11_26 / var_11_25)

				if var_11_27 > 0 and var_11_21 < var_11_27 then
					arg_8_1.talkMaxDuration = var_11_27

					if var_11_27 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_27 + var_11_20
					end
				end

				arg_8_1.text_.text = var_11_24
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751002", "story_v_out_324751.awb") ~= 0 then
					local var_11_28 = manager.audio:GetVoiceLength("story_v_out_324751", "324751002", "story_v_out_324751.awb") / 1000

					if var_11_28 + var_11_20 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_28 + var_11_20
					end

					if var_11_23.prefab_name ~= "" and arg_8_1.actors_[var_11_23.prefab_name] ~= nil then
						local var_11_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_23.prefab_name].transform, "story_v_out_324751", "324751002", "story_v_out_324751.awb")

						arg_8_1:RecordAudio("324751002", var_11_29)
						arg_8_1:RecordAudio("324751002", var_11_29)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324751", "324751002", "story_v_out_324751.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324751", "324751002", "story_v_out_324751.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_30 = math.max(var_11_21, arg_8_1.talkMaxDuration)

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_30 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_20) / var_11_30

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_20 + var_11_30 and arg_8_1.time_ < var_11_20 + var_11_30 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324751003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324751003
		arg_12_1.duration_ = 4.2

		local var_12_0 = {
			zh = 3.1,
			ja = 4.2
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
				arg_12_0:Play324751004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1037ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1037ui_story == nil then
				arg_12_1.var_.characterEffect1037ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1037ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1037ui_story then
				arg_12_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_15_4 = arg_12_1.actors_["1036ui_story"]
			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect1036ui_story == nil then
				arg_12_1.var_.characterEffect1036ui_story = var_15_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 and not isNil(var_15_4) then
				local var_15_7 = (arg_12_1.time_ - var_15_5) / var_15_6

				if arg_12_1.var_.characterEffect1036ui_story and not isNil(var_15_4) then
					local var_15_8 = Mathf.Lerp(0, 0.5, var_15_7)

					arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1036ui_story.fillRatio = var_15_8
				end
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 and not isNil(var_15_4) and arg_12_1.var_.characterEffect1036ui_story then
				local var_15_9 = 0.5

				arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1036ui_story.fillRatio = var_15_9
			end

			local var_15_10 = 0
			local var_15_11 = 0.275

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_12 = arg_12_1:FormatText(StoryNameCfg[1488].name)

				arg_12_1.leftNameTxt_.text = var_15_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_13 = arg_12_1:GetWordFromCfg(324751003)
				local var_15_14 = arg_12_1:FormatText(var_15_13.content)

				arg_12_1.text_.text = var_15_14

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 11
				local var_15_16 = utf8.len(var_15_14)
				local var_15_17 = var_15_15 <= 0 and var_15_11 or var_15_11 * (var_15_16 / var_15_15)

				if var_15_17 > 0 and var_15_11 < var_15_17 then
					arg_12_1.talkMaxDuration = var_15_17

					if var_15_17 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_14
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751003", "story_v_out_324751.awb") ~= 0 then
					local var_15_18 = manager.audio:GetVoiceLength("story_v_out_324751", "324751003", "story_v_out_324751.awb") / 1000

					if var_15_18 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_10
					end

					if var_15_13.prefab_name ~= "" and arg_12_1.actors_[var_15_13.prefab_name] ~= nil then
						local var_15_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_13.prefab_name].transform, "story_v_out_324751", "324751003", "story_v_out_324751.awb")

						arg_12_1:RecordAudio("324751003", var_15_19)
						arg_12_1:RecordAudio("324751003", var_15_19)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324751", "324751003", "story_v_out_324751.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324751", "324751003", "story_v_out_324751.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_20 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_20 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_20

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_20 and arg_12_1.time_ < var_15_10 + var_15_20 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324751004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324751004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324751005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1037ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1037ui_story == nil then
				arg_16_1.var_.characterEffect1037ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect1037ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1037ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect1037ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1037ui_story.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 0.925

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:GetWordFromCfg(324751004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_10 = 37
				local var_19_11 = utf8.len(var_19_9)
				local var_19_12 = var_19_10 <= 0 and var_19_7 or var_19_7 * (var_19_11 / var_19_10)

				if var_19_12 > 0 and var_19_7 < var_19_12 then
					arg_16_1.talkMaxDuration = var_19_12

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_13 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_13 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_13

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_13 and arg_16_1.time_ < var_19_6 + var_19_13 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324751005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324751005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324751006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.075

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(324751005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 3
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
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324751006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324751006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324751007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1.5
			local var_27_1 = 1

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				local var_27_2 = "play"
				local var_27_3 = "effect"

				arg_24_1:AudioAction(var_27_2, var_27_3, "se_story_141", "se_story_141_footstep_upstairs", "")
			end

			local var_27_4 = 0
			local var_27_5 = 1.375

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(324751006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_8 = 55
				local var_27_9 = utf8.len(var_27_7)
				local var_27_10 = var_27_8 <= 0 and var_27_5 or var_27_5 * (var_27_9 / var_27_8)

				if var_27_10 > 0 and var_27_5 < var_27_10 then
					arg_24_1.talkMaxDuration = var_27_10

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_11 and arg_24_1.time_ < var_27_4 + var_27_11 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324751007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324751007
		arg_28_1.duration_ = 5.33

		local var_28_0 = {
			zh = 3.233,
			ja = 5.333
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
				arg_28_0:Play324751008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1053ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1053ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["1053ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos1053ui_story = var_31_5.localPosition

				local var_31_7 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_7 then
					var_31_7:EnableDynamicBone(false)
				end
			end

			local var_31_8 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_6) / var_31_8
				local var_31_10 = Vector3.New(0, -1.08, -6)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1053ui_story, var_31_10, var_31_9)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_5.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_5.localEulerAngles = var_31_12
			end

			if arg_28_1.time_ >= var_31_6 + var_31_8 and arg_28_1.time_ < var_31_6 + var_31_8 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(0, -1.08, -6)

				local var_31_13 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_13.x, var_31_13.y, var_31_13.z)

				local var_31_14 = var_31_5.localEulerAngles

				var_31_14.z = 0
				var_31_14.x = 0
				var_31_5.localEulerAngles = var_31_14

				local var_31_15 = GameObjectTools.GetOrAddComponent(var_31_5.gameObject, typeof(DynamicBoneHelper))

				if var_31_15 then
					var_31_15:EnableDynamicBone(true)
				end
			end

			local var_31_16 = arg_28_1.actors_["1053ui_story"]
			local var_31_17 = 0

			if var_31_17 < arg_28_1.time_ and arg_28_1.time_ <= var_31_17 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1053ui_story == nil then
				arg_28_1.var_.characterEffect1053ui_story = var_31_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_18 = 0.200000002980232

			if var_31_17 <= arg_28_1.time_ and arg_28_1.time_ < var_31_17 + var_31_18 and not isNil(var_31_16) then
				local var_31_19 = (arg_28_1.time_ - var_31_17) / var_31_18

				if arg_28_1.var_.characterEffect1053ui_story and not isNil(var_31_16) then
					arg_28_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_17 + var_31_18 and arg_28_1.time_ < var_31_17 + var_31_18 + arg_31_0 and not isNil(var_31_16) and arg_28_1.var_.characterEffect1053ui_story then
				arg_28_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_31_20 = 0

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			local var_31_21 = 0

			if var_31_21 < arg_28_1.time_ and arg_28_1.time_ <= var_31_21 + arg_31_0 then
				arg_28_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_31_22 = 0
			local var_31_23 = 0.325

			if var_31_22 < arg_28_1.time_ and arg_28_1.time_ <= var_31_22 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_24 = arg_28_1:FormatText(StoryNameCfg[472].name)

				arg_28_1.leftNameTxt_.text = var_31_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_25 = arg_28_1:GetWordFromCfg(324751007)
				local var_31_26 = arg_28_1:FormatText(var_31_25.content)

				arg_28_1.text_.text = var_31_26

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_27 = 13
				local var_31_28 = utf8.len(var_31_26)
				local var_31_29 = var_31_27 <= 0 and var_31_23 or var_31_23 * (var_31_28 / var_31_27)

				if var_31_29 > 0 and var_31_23 < var_31_29 then
					arg_28_1.talkMaxDuration = var_31_29

					if var_31_29 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_29 + var_31_22
					end
				end

				arg_28_1.text_.text = var_31_26
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751007", "story_v_out_324751.awb") ~= 0 then
					local var_31_30 = manager.audio:GetVoiceLength("story_v_out_324751", "324751007", "story_v_out_324751.awb") / 1000

					if var_31_30 + var_31_22 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_30 + var_31_22
					end

					if var_31_25.prefab_name ~= "" and arg_28_1.actors_[var_31_25.prefab_name] ~= nil then
						local var_31_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_25.prefab_name].transform, "story_v_out_324751", "324751007", "story_v_out_324751.awb")

						arg_28_1:RecordAudio("324751007", var_31_31)
						arg_28_1:RecordAudio("324751007", var_31_31)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324751", "324751007", "story_v_out_324751.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324751", "324751007", "story_v_out_324751.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_32 = math.max(var_31_23, arg_28_1.talkMaxDuration)

			if var_31_22 <= arg_28_1.time_ and arg_28_1.time_ < var_31_22 + var_31_32 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_22) / var_31_32

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_22 + var_31_32 and arg_28_1.time_ < var_31_22 + var_31_32 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play324751008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324751008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324751009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1053ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1053ui_story == nil then
				arg_32_1.var_.characterEffect1053ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1053ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1053ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1053ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1053ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0
			local var_35_7 = 0.15

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_9 = arg_32_1:GetWordFromCfg(324751008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 6
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_14 and arg_32_1.time_ < var_35_6 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324751009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324751009
		arg_36_1.duration_ = 5.77

		local var_36_0 = {
			zh = 4.1,
			ja = 5.766
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
				arg_36_0:Play324751010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1053ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1053ui_story == nil then
				arg_36_1.var_.characterEffect1053ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1053ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1053ui_story then
				arg_36_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_39_4 = 0
			local var_39_5 = 0.375

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_6 = arg_36_1:FormatText(StoryNameCfg[472].name)

				arg_36_1.leftNameTxt_.text = var_39_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_7 = arg_36_1:GetWordFromCfg(324751009)
				local var_39_8 = arg_36_1:FormatText(var_39_7.content)

				arg_36_1.text_.text = var_39_8

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 15
				local var_39_10 = utf8.len(var_39_8)
				local var_39_11 = var_39_9 <= 0 and var_39_5 or var_39_5 * (var_39_10 / var_39_9)

				if var_39_11 > 0 and var_39_5 < var_39_11 then
					arg_36_1.talkMaxDuration = var_39_11

					if var_39_11 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_8
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751009", "story_v_out_324751.awb") ~= 0 then
					local var_39_12 = manager.audio:GetVoiceLength("story_v_out_324751", "324751009", "story_v_out_324751.awb") / 1000

					if var_39_12 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_4
					end

					if var_39_7.prefab_name ~= "" and arg_36_1.actors_[var_39_7.prefab_name] ~= nil then
						local var_39_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_7.prefab_name].transform, "story_v_out_324751", "324751009", "story_v_out_324751.awb")

						arg_36_1:RecordAudio("324751009", var_39_13)
						arg_36_1:RecordAudio("324751009", var_39_13)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324751", "324751009", "story_v_out_324751.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324751", "324751009", "story_v_out_324751.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_14 and arg_36_1.time_ < var_39_4 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324751010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324751010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324751011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1053ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1053ui_story == nil then
				arg_40_1.var_.characterEffect1053ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1053ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1053ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1053ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1053ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.225

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(324751010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 9
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
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_14 and arg_40_1.time_ < var_43_6 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324751011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324751011
		arg_44_1.duration_ = 5.63

		local var_44_0 = {
			zh = 3.666,
			ja = 5.633
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
				arg_44_0:Play324751012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1053ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1053ui_story == nil then
				arg_44_1.var_.characterEffect1053ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1053ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1053ui_story then
				arg_44_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_47_4 = 0

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_47_6 = 0
			local var_47_7 = 0.375

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[472].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_9 = arg_44_1:GetWordFromCfg(324751011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 15
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751011", "story_v_out_324751.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_324751", "324751011", "story_v_out_324751.awb") / 1000

					if var_47_14 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_6
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_324751", "324751011", "story_v_out_324751.awb")

						arg_44_1:RecordAudio("324751011", var_47_15)
						arg_44_1:RecordAudio("324751011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324751", "324751011", "story_v_out_324751.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324751", "324751011", "story_v_out_324751.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_16 and arg_44_1.time_ < var_47_6 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324751012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324751012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play324751013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1053ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1053ui_story == nil then
				arg_48_1.var_.characterEffect1053ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1053ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1053ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1053ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1053ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 0.225

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_9 = arg_48_1:GetWordFromCfg(324751012)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 9
				local var_51_12 = utf8.len(var_51_10)
				local var_51_13 = var_51_11 <= 0 and var_51_7 or var_51_7 * (var_51_12 / var_51_11)

				if var_51_13 > 0 and var_51_7 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324751013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324751013
		arg_52_1.duration_ = 13.13

		local var_52_0 = {
			zh = 8.133,
			ja = 13.133
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
				arg_52_0:Play324751014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1053ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1053ui_story == nil then
				arg_52_1.var_.characterEffect1053ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1053ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1053ui_story then
				arg_52_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_55_4 = 0
			local var_55_5 = 0.825

			if var_55_4 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_6 = arg_52_1:FormatText(StoryNameCfg[472].name)

				arg_52_1.leftNameTxt_.text = var_55_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_7 = arg_52_1:GetWordFromCfg(324751013)
				local var_55_8 = arg_52_1:FormatText(var_55_7.content)

				arg_52_1.text_.text = var_55_8

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 33
				local var_55_10 = utf8.len(var_55_8)
				local var_55_11 = var_55_9 <= 0 and var_55_5 or var_55_5 * (var_55_10 / var_55_9)

				if var_55_11 > 0 and var_55_5 < var_55_11 then
					arg_52_1.talkMaxDuration = var_55_11

					if var_55_11 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_8
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751013", "story_v_out_324751.awb") ~= 0 then
					local var_55_12 = manager.audio:GetVoiceLength("story_v_out_324751", "324751013", "story_v_out_324751.awb") / 1000

					if var_55_12 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_4
					end

					if var_55_7.prefab_name ~= "" and arg_52_1.actors_[var_55_7.prefab_name] ~= nil then
						local var_55_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_7.prefab_name].transform, "story_v_out_324751", "324751013", "story_v_out_324751.awb")

						arg_52_1:RecordAudio("324751013", var_55_13)
						arg_52_1:RecordAudio("324751013", var_55_13)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324751", "324751013", "story_v_out_324751.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324751", "324751013", "story_v_out_324751.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_14 and arg_52_1.time_ < var_55_4 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324751014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324751014
		arg_56_1.duration_ = 9.93

		local var_56_0 = {
			zh = 4.066,
			ja = 9.933
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
				arg_56_0:Play324751015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_59_2 = 0
			local var_59_3 = 0.45

			if var_59_2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_4 = arg_56_1:FormatText(StoryNameCfg[472].name)

				arg_56_1.leftNameTxt_.text = var_59_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_5 = arg_56_1:GetWordFromCfg(324751014)
				local var_59_6 = arg_56_1:FormatText(var_59_5.content)

				arg_56_1.text_.text = var_59_6

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 18
				local var_59_8 = utf8.len(var_59_6)
				local var_59_9 = var_59_7 <= 0 and var_59_3 or var_59_3 * (var_59_8 / var_59_7)

				if var_59_9 > 0 and var_59_3 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_6
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751014", "story_v_out_324751.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_324751", "324751014", "story_v_out_324751.awb") / 1000

					if var_59_10 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_2
					end

					if var_59_5.prefab_name ~= "" and arg_56_1.actors_[var_59_5.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_5.prefab_name].transform, "story_v_out_324751", "324751014", "story_v_out_324751.awb")

						arg_56_1:RecordAudio("324751014", var_59_11)
						arg_56_1:RecordAudio("324751014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324751", "324751014", "story_v_out_324751.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324751", "324751014", "story_v_out_324751.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_12 and arg_56_1.time_ < var_59_2 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324751015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324751015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324751016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1053ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1053ui_story == nil then
				arg_60_1.var_.characterEffect1053ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1053ui_story and not isNil(var_63_0) then
					local var_63_4 = Mathf.Lerp(0, 0.5, var_63_3)

					arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1053ui_story.fillRatio = var_63_4
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1053ui_story then
				local var_63_5 = 0.5

				arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1053ui_story.fillRatio = var_63_5
			end

			local var_63_6 = 0
			local var_63_7 = 0.425

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_8 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_9 = arg_60_1:GetWordFromCfg(324751015)
				local var_63_10 = arg_60_1:FormatText(var_63_9.content)

				arg_60_1.text_.text = var_63_10

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 17
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
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_14 and arg_60_1.time_ < var_63_6 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play324751016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324751016
		arg_64_1.duration_ = 2

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play324751017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1053ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1053ui_story = var_67_0.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_3 then
				local var_67_4 = (arg_64_1.time_ - var_67_1) / var_67_3
				local var_67_5 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1053ui_story, var_67_5, var_67_4)

				local var_67_6 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_6.x, var_67_6.y, var_67_6.z)

				local var_67_7 = var_67_0.localEulerAngles

				var_67_7.z = 0
				var_67_7.x = 0
				var_67_0.localEulerAngles = var_67_7
			end

			if arg_64_1.time_ >= var_67_1 + var_67_3 and arg_64_1.time_ < var_67_1 + var_67_3 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_8 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_8.x, var_67_8.y, var_67_8.z)

				local var_67_9 = var_67_0.localEulerAngles

				var_67_9.z = 0
				var_67_9.x = 0
				var_67_0.localEulerAngles = var_67_9

				local var_67_10 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_10 then
					var_67_10:EnableDynamicBone(true)
				end
			end

			local var_67_11 = "6148ui_story"

			if arg_64_1.actors_[var_67_11] == nil then
				local var_67_12 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_67_12) then
					local var_67_13 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_64_1.stage_.transform)

					var_67_13.name = var_67_11
					var_67_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_64_1.actors_[var_67_11] = var_67_13

					local var_67_14 = var_67_13:GetComponentInChildren(typeof(CharacterEffect))

					var_67_14.enabled = true

					local var_67_15 = GameObjectTools.GetOrAddComponent(var_67_13, typeof(DynamicBoneHelper))

					if var_67_15 then
						var_67_15:EnableDynamicBone(false)
					end

					arg_64_1:ShowWeapon(var_67_14.transform, false)

					arg_64_1.var_[var_67_11 .. "Animator"] = var_67_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_64_1.var_[var_67_11 .. "Animator"].applyRootMotion = true
					arg_64_1.var_[var_67_11 .. "LipSync"] = var_67_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_67_16 = arg_64_1.actors_["6148ui_story"].transform
			local var_67_17 = 0

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.var_.moveOldPos6148ui_story = var_67_16.localPosition

				local var_67_18 = GameObjectTools.GetOrAddComponent(var_67_16.gameObject, typeof(DynamicBoneHelper))

				if var_67_18 then
					var_67_18:EnableDynamicBone(false)
				end
			end

			local var_67_19 = 0.001

			if var_67_17 <= arg_64_1.time_ and arg_64_1.time_ < var_67_17 + var_67_19 then
				local var_67_20 = (arg_64_1.time_ - var_67_17) / var_67_19
				local var_67_21 = Vector3.New(-0.7, -0.985, -6)

				var_67_16.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos6148ui_story, var_67_21, var_67_20)

				local var_67_22 = manager.ui.mainCamera.transform.position - var_67_16.position

				var_67_16.forward = Vector3.New(var_67_22.x, var_67_22.y, var_67_22.z)

				local var_67_23 = var_67_16.localEulerAngles

				var_67_23.z = 0
				var_67_23.x = 0
				var_67_16.localEulerAngles = var_67_23
			end

			if arg_64_1.time_ >= var_67_17 + var_67_19 and arg_64_1.time_ < var_67_17 + var_67_19 + arg_67_0 then
				var_67_16.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_67_24 = manager.ui.mainCamera.transform.position - var_67_16.position

				var_67_16.forward = Vector3.New(var_67_24.x, var_67_24.y, var_67_24.z)

				local var_67_25 = var_67_16.localEulerAngles

				var_67_25.z = 0
				var_67_25.x = 0
				var_67_16.localEulerAngles = var_67_25

				local var_67_26 = GameObjectTools.GetOrAddComponent(var_67_16.gameObject, typeof(DynamicBoneHelper))

				if var_67_26 then
					var_67_26:EnableDynamicBone(true)
				end
			end

			local var_67_27 = arg_64_1.actors_["6148ui_story"]
			local var_67_28 = 0

			if var_67_28 < arg_64_1.time_ and arg_64_1.time_ <= var_67_28 + arg_67_0 and not isNil(var_67_27) and arg_64_1.var_.characterEffect6148ui_story == nil then
				arg_64_1.var_.characterEffect6148ui_story = var_67_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_29 = 0.200000002980232

			if var_67_28 <= arg_64_1.time_ and arg_64_1.time_ < var_67_28 + var_67_29 and not isNil(var_67_27) then
				local var_67_30 = (arg_64_1.time_ - var_67_28) / var_67_29

				if arg_64_1.var_.characterEffect6148ui_story and not isNil(var_67_27) then
					arg_64_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_28 + var_67_29 and arg_64_1.time_ < var_67_28 + var_67_29 + arg_67_0 and not isNil(var_67_27) and arg_64_1.var_.characterEffect6148ui_story then
				arg_64_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_67_31 = 0

			if var_67_31 < arg_64_1.time_ and arg_64_1.time_ <= var_67_31 + arg_67_0 then
				arg_64_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_67_32 = 0

			if var_67_32 < arg_64_1.time_ and arg_64_1.time_ <= var_67_32 + arg_67_0 then
				arg_64_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_67_33 = 0
			local var_67_34 = 0.1

			if var_67_33 < arg_64_1.time_ and arg_64_1.time_ <= var_67_33 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_35 = arg_64_1:FormatText(StoryNameCfg[1488].name)

				arg_64_1.leftNameTxt_.text = var_67_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_36 = arg_64_1:GetWordFromCfg(324751016)
				local var_67_37 = arg_64_1:FormatText(var_67_36.content)

				arg_64_1.text_.text = var_67_37

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_38 = 4
				local var_67_39 = utf8.len(var_67_37)
				local var_67_40 = var_67_38 <= 0 and var_67_34 or var_67_34 * (var_67_39 / var_67_38)

				if var_67_40 > 0 and var_67_34 < var_67_40 then
					arg_64_1.talkMaxDuration = var_67_40

					if var_67_40 + var_67_33 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_40 + var_67_33
					end
				end

				arg_64_1.text_.text = var_67_37
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751016", "story_v_out_324751.awb") ~= 0 then
					local var_67_41 = manager.audio:GetVoiceLength("story_v_out_324751", "324751016", "story_v_out_324751.awb") / 1000

					if var_67_41 + var_67_33 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_41 + var_67_33
					end

					if var_67_36.prefab_name ~= "" and arg_64_1.actors_[var_67_36.prefab_name] ~= nil then
						local var_67_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_36.prefab_name].transform, "story_v_out_324751", "324751016", "story_v_out_324751.awb")

						arg_64_1:RecordAudio("324751016", var_67_42)
						arg_64_1:RecordAudio("324751016", var_67_42)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_324751", "324751016", "story_v_out_324751.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_324751", "324751016", "story_v_out_324751.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_43 = math.max(var_67_34, arg_64_1.talkMaxDuration)

			if var_67_33 <= arg_64_1.time_ and arg_64_1.time_ < var_67_33 + var_67_43 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_33) / var_67_43

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_33 + var_67_43 and arg_64_1.time_ < var_67_33 + var_67_43 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play324751017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324751017
		arg_68_1.duration_ = 2

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324751018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = "1054ui_story"

			if arg_68_1.actors_[var_71_0] == nil then
				local var_71_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_71_1) then
					local var_71_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_68_1.stage_.transform)

					var_71_2.name = var_71_0
					var_71_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_68_1.actors_[var_71_0] = var_71_2

					local var_71_3 = var_71_2:GetComponentInChildren(typeof(CharacterEffect))

					var_71_3.enabled = true

					local var_71_4 = GameObjectTools.GetOrAddComponent(var_71_2, typeof(DynamicBoneHelper))

					if var_71_4 then
						var_71_4:EnableDynamicBone(false)
					end

					arg_68_1:ShowWeapon(var_71_3.transform, false)

					arg_68_1.var_[var_71_0 .. "Animator"] = var_71_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_68_1.var_[var_71_0 .. "Animator"].applyRootMotion = true
					arg_68_1.var_[var_71_0 .. "LipSync"] = var_71_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_71_5 = arg_68_1.actors_["1054ui_story"].transform
			local var_71_6 = 0

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.var_.moveOldPos1054ui_story = var_71_5.localPosition

				local var_71_7 = GameObjectTools.GetOrAddComponent(var_71_5.gameObject, typeof(DynamicBoneHelper))

				if var_71_7 then
					var_71_7:EnableDynamicBone(false)
				end
			end

			local var_71_8 = 0.001

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_8 then
				local var_71_9 = (arg_68_1.time_ - var_71_6) / var_71_8
				local var_71_10 = Vector3.New(0.7, -0.985, -6)

				var_71_5.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1054ui_story, var_71_10, var_71_9)

				local var_71_11 = manager.ui.mainCamera.transform.position - var_71_5.position

				var_71_5.forward = Vector3.New(var_71_11.x, var_71_11.y, var_71_11.z)

				local var_71_12 = var_71_5.localEulerAngles

				var_71_12.z = 0
				var_71_12.x = 0
				var_71_5.localEulerAngles = var_71_12
			end

			if arg_68_1.time_ >= var_71_6 + var_71_8 and arg_68_1.time_ < var_71_6 + var_71_8 + arg_71_0 then
				var_71_5.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_71_13 = manager.ui.mainCamera.transform.position - var_71_5.position

				var_71_5.forward = Vector3.New(var_71_13.x, var_71_13.y, var_71_13.z)

				local var_71_14 = var_71_5.localEulerAngles

				var_71_14.z = 0
				var_71_14.x = 0
				var_71_5.localEulerAngles = var_71_14

				local var_71_15 = GameObjectTools.GetOrAddComponent(var_71_5.gameObject, typeof(DynamicBoneHelper))

				if var_71_15 then
					var_71_15:EnableDynamicBone(true)
				end
			end

			local var_71_16 = arg_68_1.actors_["1054ui_story"]
			local var_71_17 = 0

			if var_71_17 < arg_68_1.time_ and arg_68_1.time_ <= var_71_17 + arg_71_0 and not isNil(var_71_16) and arg_68_1.var_.characterEffect1054ui_story == nil then
				arg_68_1.var_.characterEffect1054ui_story = var_71_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_18 = 0.200000002980232

			if var_71_17 <= arg_68_1.time_ and arg_68_1.time_ < var_71_17 + var_71_18 and not isNil(var_71_16) then
				local var_71_19 = (arg_68_1.time_ - var_71_17) / var_71_18

				if arg_68_1.var_.characterEffect1054ui_story and not isNil(var_71_16) then
					arg_68_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_17 + var_71_18 and arg_68_1.time_ < var_71_17 + var_71_18 + arg_71_0 and not isNil(var_71_16) and arg_68_1.var_.characterEffect1054ui_story then
				arg_68_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_71_20 = arg_68_1.actors_["6148ui_story"]
			local var_71_21 = 0

			if var_71_21 < arg_68_1.time_ and arg_68_1.time_ <= var_71_21 + arg_71_0 and not isNil(var_71_20) and arg_68_1.var_.characterEffect6148ui_story == nil then
				arg_68_1.var_.characterEffect6148ui_story = var_71_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_22 = 0.200000002980232

			if var_71_21 <= arg_68_1.time_ and arg_68_1.time_ < var_71_21 + var_71_22 and not isNil(var_71_20) then
				local var_71_23 = (arg_68_1.time_ - var_71_21) / var_71_22

				if arg_68_1.var_.characterEffect6148ui_story and not isNil(var_71_20) then
					local var_71_24 = Mathf.Lerp(0, 0.5, var_71_23)

					arg_68_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_68_1.var_.characterEffect6148ui_story.fillRatio = var_71_24
				end
			end

			if arg_68_1.time_ >= var_71_21 + var_71_22 and arg_68_1.time_ < var_71_21 + var_71_22 + arg_71_0 and not isNil(var_71_20) and arg_68_1.var_.characterEffect6148ui_story then
				local var_71_25 = 0.5

				arg_68_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_68_1.var_.characterEffect6148ui_story.fillRatio = var_71_25
			end

			local var_71_26 = 0

			if var_71_26 < arg_68_1.time_ and arg_68_1.time_ <= var_71_26 + arg_71_0 then
				arg_68_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_71_27 = 0

			if var_71_27 < arg_68_1.time_ and arg_68_1.time_ <= var_71_27 + arg_71_0 then
				arg_68_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_71_28 = 0
			local var_71_29 = 0.1

			if var_71_28 < arg_68_1.time_ and arg_68_1.time_ <= var_71_28 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_30 = arg_68_1:FormatText(StoryNameCfg[1487].name)

				arg_68_1.leftNameTxt_.text = var_71_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_31 = arg_68_1:GetWordFromCfg(324751017)
				local var_71_32 = arg_68_1:FormatText(var_71_31.content)

				arg_68_1.text_.text = var_71_32

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_33 = 4
				local var_71_34 = utf8.len(var_71_32)
				local var_71_35 = var_71_33 <= 0 and var_71_29 or var_71_29 * (var_71_34 / var_71_33)

				if var_71_35 > 0 and var_71_29 < var_71_35 then
					arg_68_1.talkMaxDuration = var_71_35

					if var_71_35 + var_71_28 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_35 + var_71_28
					end
				end

				arg_68_1.text_.text = var_71_32
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751017", "story_v_out_324751.awb") ~= 0 then
					local var_71_36 = manager.audio:GetVoiceLength("story_v_out_324751", "324751017", "story_v_out_324751.awb") / 1000

					if var_71_36 + var_71_28 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_36 + var_71_28
					end

					if var_71_31.prefab_name ~= "" and arg_68_1.actors_[var_71_31.prefab_name] ~= nil then
						local var_71_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_31.prefab_name].transform, "story_v_out_324751", "324751017", "story_v_out_324751.awb")

						arg_68_1:RecordAudio("324751017", var_71_37)
						arg_68_1:RecordAudio("324751017", var_71_37)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324751", "324751017", "story_v_out_324751.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324751", "324751017", "story_v_out_324751.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_38 = math.max(var_71_29, arg_68_1.talkMaxDuration)

			if var_71_28 <= arg_68_1.time_ and arg_68_1.time_ < var_71_28 + var_71_38 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_28) / var_71_38

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_28 + var_71_38 and arg_68_1.time_ < var_71_28 + var_71_38 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play324751018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324751018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324751019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1054ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1054ui_story == nil then
				arg_72_1.var_.characterEffect1054ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1054ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1054ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1054ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1054ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.275

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(324751018)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 11
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play324751019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324751019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324751020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["6148ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos6148ui_story = var_79_0.localPosition

				local var_79_2 = GameObjectTools.GetOrAddComponent(var_79_0.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(false)
				end
			end

			local var_79_3 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_3 then
				local var_79_4 = (arg_76_1.time_ - var_79_1) / var_79_3
				local var_79_5 = Vector3.New(0, 100, 0)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos6148ui_story, var_79_5, var_79_4)

				local var_79_6 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_6.x, var_79_6.y, var_79_6.z)

				local var_79_7 = var_79_0.localEulerAngles

				var_79_7.z = 0
				var_79_7.x = 0
				var_79_0.localEulerAngles = var_79_7
			end

			if arg_76_1.time_ >= var_79_1 + var_79_3 and arg_76_1.time_ < var_79_1 + var_79_3 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0, 100, 0)

				local var_79_8 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_8.x, var_79_8.y, var_79_8.z)

				local var_79_9 = var_79_0.localEulerAngles

				var_79_9.z = 0
				var_79_9.x = 0
				var_79_0.localEulerAngles = var_79_9

				local var_79_10 = GameObjectTools.GetOrAddComponent(var_79_0.gameObject, typeof(DynamicBoneHelper))

				if var_79_10 then
					var_79_10:EnableDynamicBone(true)
				end
			end

			local var_79_11 = arg_76_1.actors_["1054ui_story"].transform
			local var_79_12 = 0

			if var_79_12 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 then
				arg_76_1.var_.moveOldPos1054ui_story = var_79_11.localPosition

				local var_79_13 = GameObjectTools.GetOrAddComponent(var_79_11.gameObject, typeof(DynamicBoneHelper))

				if var_79_13 then
					var_79_13:EnableDynamicBone(false)
				end
			end

			local var_79_14 = 0.001

			if var_79_12 <= arg_76_1.time_ and arg_76_1.time_ < var_79_12 + var_79_14 then
				local var_79_15 = (arg_76_1.time_ - var_79_12) / var_79_14
				local var_79_16 = Vector3.New(0, 100, 0)

				var_79_11.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1054ui_story, var_79_16, var_79_15)

				local var_79_17 = manager.ui.mainCamera.transform.position - var_79_11.position

				var_79_11.forward = Vector3.New(var_79_17.x, var_79_17.y, var_79_17.z)

				local var_79_18 = var_79_11.localEulerAngles

				var_79_18.z = 0
				var_79_18.x = 0
				var_79_11.localEulerAngles = var_79_18
			end

			if arg_76_1.time_ >= var_79_12 + var_79_14 and arg_76_1.time_ < var_79_12 + var_79_14 + arg_79_0 then
				var_79_11.localPosition = Vector3.New(0, 100, 0)

				local var_79_19 = manager.ui.mainCamera.transform.position - var_79_11.position

				var_79_11.forward = Vector3.New(var_79_19.x, var_79_19.y, var_79_19.z)

				local var_79_20 = var_79_11.localEulerAngles

				var_79_20.z = 0
				var_79_20.x = 0
				var_79_11.localEulerAngles = var_79_20

				local var_79_21 = GameObjectTools.GetOrAddComponent(var_79_11.gameObject, typeof(DynamicBoneHelper))

				if var_79_21 then
					var_79_21:EnableDynamicBone(true)
				end
			end

			local var_79_22 = 0
			local var_79_23 = 1.25

			if var_79_22 < arg_76_1.time_ and arg_76_1.time_ <= var_79_22 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_24 = arg_76_1:GetWordFromCfg(324751019)
				local var_79_25 = arg_76_1:FormatText(var_79_24.content)

				arg_76_1.text_.text = var_79_25

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_26 = 50
				local var_79_27 = utf8.len(var_79_25)
				local var_79_28 = var_79_26 <= 0 and var_79_23 or var_79_23 * (var_79_27 / var_79_26)

				if var_79_28 > 0 and var_79_23 < var_79_28 then
					arg_76_1.talkMaxDuration = var_79_28

					if var_79_28 + var_79_22 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_28 + var_79_22
					end
				end

				arg_76_1.text_.text = var_79_25
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_29 = math.max(var_79_23, arg_76_1.talkMaxDuration)

			if var_79_22 <= arg_76_1.time_ and arg_76_1.time_ < var_79_22 + var_79_29 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_22) / var_79_29

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_22 + var_79_29 and arg_76_1.time_ < var_79_22 + var_79_29 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play324751020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324751020
		arg_80_1.duration_ = 12.77

		local var_80_0 = {
			zh = 8.133,
			ja = 12.766
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
				arg_80_0:Play324751021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1036ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1036ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1036ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1037ui_story"].transform
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.var_.moveOldPos1037ui_story = var_83_9.localPosition
			end

			local var_83_11 = 0.001

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11
				local var_83_13 = Vector3.New(0, 100, 0)

				var_83_9.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1037ui_story, var_83_13, var_83_12)

				local var_83_14 = manager.ui.mainCamera.transform.position - var_83_9.position

				var_83_9.forward = Vector3.New(var_83_14.x, var_83_14.y, var_83_14.z)

				local var_83_15 = var_83_9.localEulerAngles

				var_83_15.z = 0
				var_83_15.x = 0
				var_83_9.localEulerAngles = var_83_15
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 then
				var_83_9.localPosition = Vector3.New(0, 100, 0)

				local var_83_16 = manager.ui.mainCamera.transform.position - var_83_9.position

				var_83_9.forward = Vector3.New(var_83_16.x, var_83_16.y, var_83_16.z)

				local var_83_17 = var_83_9.localEulerAngles

				var_83_17.z = 0
				var_83_17.x = 0
				var_83_9.localEulerAngles = var_83_17
			end

			local var_83_18 = arg_80_1.actors_["1053ui_story"].transform
			local var_83_19 = 0

			if var_83_19 < arg_80_1.time_ and arg_80_1.time_ <= var_83_19 + arg_83_0 then
				arg_80_1.var_.moveOldPos1053ui_story = var_83_18.localPosition

				local var_83_20 = GameObjectTools.GetOrAddComponent(var_83_18.gameObject, typeof(DynamicBoneHelper))

				if var_83_20 then
					var_83_20:EnableDynamicBone(false)
				end
			end

			local var_83_21 = 0.001

			if var_83_19 <= arg_80_1.time_ and arg_80_1.time_ < var_83_19 + var_83_21 then
				local var_83_22 = (arg_80_1.time_ - var_83_19) / var_83_21
				local var_83_23 = Vector3.New(0, -1.08, -6)

				var_83_18.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1053ui_story, var_83_23, var_83_22)

				local var_83_24 = manager.ui.mainCamera.transform.position - var_83_18.position

				var_83_18.forward = Vector3.New(var_83_24.x, var_83_24.y, var_83_24.z)

				local var_83_25 = var_83_18.localEulerAngles

				var_83_25.z = 0
				var_83_25.x = 0
				var_83_18.localEulerAngles = var_83_25
			end

			if arg_80_1.time_ >= var_83_19 + var_83_21 and arg_80_1.time_ < var_83_19 + var_83_21 + arg_83_0 then
				var_83_18.localPosition = Vector3.New(0, -1.08, -6)

				local var_83_26 = manager.ui.mainCamera.transform.position - var_83_18.position

				var_83_18.forward = Vector3.New(var_83_26.x, var_83_26.y, var_83_26.z)

				local var_83_27 = var_83_18.localEulerAngles

				var_83_27.z = 0
				var_83_27.x = 0
				var_83_18.localEulerAngles = var_83_27

				local var_83_28 = GameObjectTools.GetOrAddComponent(var_83_18.gameObject, typeof(DynamicBoneHelper))

				if var_83_28 then
					var_83_28:EnableDynamicBone(true)
				end
			end

			local var_83_29 = arg_80_1.actors_["1053ui_story"]
			local var_83_30 = 0

			if var_83_30 < arg_80_1.time_ and arg_80_1.time_ <= var_83_30 + arg_83_0 and not isNil(var_83_29) and arg_80_1.var_.characterEffect1053ui_story == nil then
				arg_80_1.var_.characterEffect1053ui_story = var_83_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_31 = 0.200000002980232

			if var_83_30 <= arg_80_1.time_ and arg_80_1.time_ < var_83_30 + var_83_31 and not isNil(var_83_29) then
				local var_83_32 = (arg_80_1.time_ - var_83_30) / var_83_31

				if arg_80_1.var_.characterEffect1053ui_story and not isNil(var_83_29) then
					arg_80_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_30 + var_83_31 and arg_80_1.time_ < var_83_30 + var_83_31 + arg_83_0 and not isNil(var_83_29) and arg_80_1.var_.characterEffect1053ui_story then
				arg_80_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_83_33 = 0

			if var_83_33 < arg_80_1.time_ and arg_80_1.time_ <= var_83_33 + arg_83_0 then
				arg_80_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_2")
			end

			local var_83_34 = 0

			if var_83_34 < arg_80_1.time_ and arg_80_1.time_ <= var_83_34 + arg_83_0 then
				arg_80_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_83_35 = 0
			local var_83_36 = 0.8

			if var_83_35 < arg_80_1.time_ and arg_80_1.time_ <= var_83_35 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_37 = arg_80_1:FormatText(StoryNameCfg[472].name)

				arg_80_1.leftNameTxt_.text = var_83_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_38 = arg_80_1:GetWordFromCfg(324751020)
				local var_83_39 = arg_80_1:FormatText(var_83_38.content)

				arg_80_1.text_.text = var_83_39

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_40 = 32
				local var_83_41 = utf8.len(var_83_39)
				local var_83_42 = var_83_40 <= 0 and var_83_36 or var_83_36 * (var_83_41 / var_83_40)

				if var_83_42 > 0 and var_83_36 < var_83_42 then
					arg_80_1.talkMaxDuration = var_83_42

					if var_83_42 + var_83_35 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_42 + var_83_35
					end
				end

				arg_80_1.text_.text = var_83_39
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751020", "story_v_out_324751.awb") ~= 0 then
					local var_83_43 = manager.audio:GetVoiceLength("story_v_out_324751", "324751020", "story_v_out_324751.awb") / 1000

					if var_83_43 + var_83_35 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_43 + var_83_35
					end

					if var_83_38.prefab_name ~= "" and arg_80_1.actors_[var_83_38.prefab_name] ~= nil then
						local var_83_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_38.prefab_name].transform, "story_v_out_324751", "324751020", "story_v_out_324751.awb")

						arg_80_1:RecordAudio("324751020", var_83_44)
						arg_80_1:RecordAudio("324751020", var_83_44)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_324751", "324751020", "story_v_out_324751.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_324751", "324751020", "story_v_out_324751.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_45 = math.max(var_83_36, arg_80_1.talkMaxDuration)

			if var_83_35 <= arg_80_1.time_ and arg_80_1.time_ < var_83_35 + var_83_45 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_35) / var_83_45

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_35 + var_83_45 and arg_80_1.time_ < var_83_35 + var_83_45 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play324751021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324751021
		arg_84_1.duration_ = 4.6

		local var_84_0 = {
			zh = 3.3,
			ja = 4.6
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
				arg_84_0:Play324751022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.35

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[472].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:GetWordFromCfg(324751021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 14
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751021", "story_v_out_324751.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_324751", "324751021", "story_v_out_324751.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_324751", "324751021", "story_v_out_324751.awb")

						arg_84_1:RecordAudio("324751021", var_87_9)
						arg_84_1:RecordAudio("324751021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324751", "324751021", "story_v_out_324751.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324751", "324751021", "story_v_out_324751.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324751022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324751022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324751023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1053ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1053ui_story == nil then
				arg_88_1.var_.characterEffect1053ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1053ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1053ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1053ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1053ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.075

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_9 = arg_88_1:GetWordFromCfg(324751022)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 3
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play324751023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324751023
		arg_92_1.duration_ = 7.1

		local var_92_0 = {
			zh = 5.333,
			ja = 7.1
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
				arg_92_0:Play324751024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1037ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1037ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0, 100, 0)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1037ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, 100, 0)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = arg_92_1.actors_["6148ui_story"].transform
			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1.var_.moveOldPos6148ui_story = var_95_9.localPosition

				local var_95_11 = GameObjectTools.GetOrAddComponent(var_95_9.gameObject, typeof(DynamicBoneHelper))

				if var_95_11 then
					var_95_11:EnableDynamicBone(false)
				end
			end

			local var_95_12 = 0.001

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_12 then
				local var_95_13 = (arg_92_1.time_ - var_95_10) / var_95_12
				local var_95_14 = Vector3.New(-0.7, -0.985, -6)

				var_95_9.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos6148ui_story, var_95_14, var_95_13)

				local var_95_15 = manager.ui.mainCamera.transform.position - var_95_9.position

				var_95_9.forward = Vector3.New(var_95_15.x, var_95_15.y, var_95_15.z)

				local var_95_16 = var_95_9.localEulerAngles

				var_95_16.z = 0
				var_95_16.x = 0
				var_95_9.localEulerAngles = var_95_16
			end

			if arg_92_1.time_ >= var_95_10 + var_95_12 and arg_92_1.time_ < var_95_10 + var_95_12 + arg_95_0 then
				var_95_9.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_95_17 = manager.ui.mainCamera.transform.position - var_95_9.position

				var_95_9.forward = Vector3.New(var_95_17.x, var_95_17.y, var_95_17.z)

				local var_95_18 = var_95_9.localEulerAngles

				var_95_18.z = 0
				var_95_18.x = 0
				var_95_9.localEulerAngles = var_95_18

				local var_95_19 = GameObjectTools.GetOrAddComponent(var_95_9.gameObject, typeof(DynamicBoneHelper))

				if var_95_19 then
					var_95_19:EnableDynamicBone(true)
				end
			end

			local var_95_20 = arg_92_1.actors_["6148ui_story"]
			local var_95_21 = 0

			if var_95_21 < arg_92_1.time_ and arg_92_1.time_ <= var_95_21 + arg_95_0 and not isNil(var_95_20) and arg_92_1.var_.characterEffect6148ui_story == nil then
				arg_92_1.var_.characterEffect6148ui_story = var_95_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_22 = 0.200000002980232

			if var_95_21 <= arg_92_1.time_ and arg_92_1.time_ < var_95_21 + var_95_22 and not isNil(var_95_20) then
				local var_95_23 = (arg_92_1.time_ - var_95_21) / var_95_22

				if arg_92_1.var_.characterEffect6148ui_story and not isNil(var_95_20) then
					arg_92_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_21 + var_95_22 and arg_92_1.time_ < var_95_21 + var_95_22 + arg_95_0 and not isNil(var_95_20) and arg_92_1.var_.characterEffect6148ui_story then
				arg_92_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_95_24 = 0

			if var_95_24 < arg_92_1.time_ and arg_92_1.time_ <= var_95_24 + arg_95_0 then
				arg_92_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_95_25 = 0

			if var_95_25 < arg_92_1.time_ and arg_92_1.time_ <= var_95_25 + arg_95_0 then
				arg_92_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_95_26 = arg_92_1.actors_["1053ui_story"].transform
			local var_95_27 = 0

			if var_95_27 < arg_92_1.time_ and arg_92_1.time_ <= var_95_27 + arg_95_0 then
				arg_92_1.var_.moveOldPos1053ui_story = var_95_26.localPosition

				local var_95_28 = GameObjectTools.GetOrAddComponent(var_95_26.gameObject, typeof(DynamicBoneHelper))

				if var_95_28 then
					var_95_28:EnableDynamicBone(false)
				end
			end

			local var_95_29 = 0.001

			if var_95_27 <= arg_92_1.time_ and arg_92_1.time_ < var_95_27 + var_95_29 then
				local var_95_30 = (arg_92_1.time_ - var_95_27) / var_95_29
				local var_95_31 = Vector3.New(0, 100, 0)

				var_95_26.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1053ui_story, var_95_31, var_95_30)

				local var_95_32 = manager.ui.mainCamera.transform.position - var_95_26.position

				var_95_26.forward = Vector3.New(var_95_32.x, var_95_32.y, var_95_32.z)

				local var_95_33 = var_95_26.localEulerAngles

				var_95_33.z = 0
				var_95_33.x = 0
				var_95_26.localEulerAngles = var_95_33
			end

			if arg_92_1.time_ >= var_95_27 + var_95_29 and arg_92_1.time_ < var_95_27 + var_95_29 + arg_95_0 then
				var_95_26.localPosition = Vector3.New(0, 100, 0)

				local var_95_34 = manager.ui.mainCamera.transform.position - var_95_26.position

				var_95_26.forward = Vector3.New(var_95_34.x, var_95_34.y, var_95_34.z)

				local var_95_35 = var_95_26.localEulerAngles

				var_95_35.z = 0
				var_95_35.x = 0
				var_95_26.localEulerAngles = var_95_35

				local var_95_36 = GameObjectTools.GetOrAddComponent(var_95_26.gameObject, typeof(DynamicBoneHelper))

				if var_95_36 then
					var_95_36:EnableDynamicBone(true)
				end
			end

			local var_95_37 = 0
			local var_95_38 = 0.625

			if var_95_37 < arg_92_1.time_ and arg_92_1.time_ <= var_95_37 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_39 = arg_92_1:FormatText(StoryNameCfg[1488].name)

				arg_92_1.leftNameTxt_.text = var_95_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_40 = arg_92_1:GetWordFromCfg(324751023)
				local var_95_41 = arg_92_1:FormatText(var_95_40.content)

				arg_92_1.text_.text = var_95_41

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_42 = 25
				local var_95_43 = utf8.len(var_95_41)
				local var_95_44 = var_95_42 <= 0 and var_95_38 or var_95_38 * (var_95_43 / var_95_42)

				if var_95_44 > 0 and var_95_38 < var_95_44 then
					arg_92_1.talkMaxDuration = var_95_44

					if var_95_44 + var_95_37 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_44 + var_95_37
					end
				end

				arg_92_1.text_.text = var_95_41
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751023", "story_v_out_324751.awb") ~= 0 then
					local var_95_45 = manager.audio:GetVoiceLength("story_v_out_324751", "324751023", "story_v_out_324751.awb") / 1000

					if var_95_45 + var_95_37 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_45 + var_95_37
					end

					if var_95_40.prefab_name ~= "" and arg_92_1.actors_[var_95_40.prefab_name] ~= nil then
						local var_95_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_40.prefab_name].transform, "story_v_out_324751", "324751023", "story_v_out_324751.awb")

						arg_92_1:RecordAudio("324751023", var_95_46)
						arg_92_1:RecordAudio("324751023", var_95_46)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_324751", "324751023", "story_v_out_324751.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_324751", "324751023", "story_v_out_324751.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_47 = math.max(var_95_38, arg_92_1.talkMaxDuration)

			if var_95_37 <= arg_92_1.time_ and arg_92_1.time_ < var_95_37 + var_95_47 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_37) / var_95_47

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_37 + var_95_47 and arg_92_1.time_ < var_95_37 + var_95_47 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play324751024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324751024
		arg_96_1.duration_ = 4.87

		local var_96_0 = {
			zh = 3.266,
			ja = 4.866
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
				arg_96_0:Play324751025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1054ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1054ui_story = var_99_0.localPosition

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_0.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end
			end

			local var_99_3 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_3 then
				local var_99_4 = (arg_96_1.time_ - var_99_1) / var_99_3
				local var_99_5 = Vector3.New(0.7, -0.985, -6)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1054ui_story, var_99_5, var_99_4)

				local var_99_6 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_6.x, var_99_6.y, var_99_6.z)

				local var_99_7 = var_99_0.localEulerAngles

				var_99_7.z = 0
				var_99_7.x = 0
				var_99_0.localEulerAngles = var_99_7
			end

			if arg_96_1.time_ >= var_99_1 + var_99_3 and arg_96_1.time_ < var_99_1 + var_99_3 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_99_8 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_8.x, var_99_8.y, var_99_8.z)

				local var_99_9 = var_99_0.localEulerAngles

				var_99_9.z = 0
				var_99_9.x = 0
				var_99_0.localEulerAngles = var_99_9

				local var_99_10 = GameObjectTools.GetOrAddComponent(var_99_0.gameObject, typeof(DynamicBoneHelper))

				if var_99_10 then
					var_99_10:EnableDynamicBone(true)
				end
			end

			local var_99_11 = arg_96_1.actors_["1054ui_story"]
			local var_99_12 = 0

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 and not isNil(var_99_11) and arg_96_1.var_.characterEffect1054ui_story == nil then
				arg_96_1.var_.characterEffect1054ui_story = var_99_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_13 = 0.200000002980232

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_13 and not isNil(var_99_11) then
				local var_99_14 = (arg_96_1.time_ - var_99_12) / var_99_13

				if arg_96_1.var_.characterEffect1054ui_story and not isNil(var_99_11) then
					arg_96_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_12 + var_99_13 and arg_96_1.time_ < var_99_12 + var_99_13 + arg_99_0 and not isNil(var_99_11) and arg_96_1.var_.characterEffect1054ui_story then
				arg_96_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_99_15 = arg_96_1.actors_["6148ui_story"]
			local var_99_16 = 0

			if var_99_16 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 and not isNil(var_99_15) and arg_96_1.var_.characterEffect6148ui_story == nil then
				arg_96_1.var_.characterEffect6148ui_story = var_99_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_17 = 0.200000002980232

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_17 and not isNil(var_99_15) then
				local var_99_18 = (arg_96_1.time_ - var_99_16) / var_99_17

				if arg_96_1.var_.characterEffect6148ui_story and not isNil(var_99_15) then
					local var_99_19 = Mathf.Lerp(0, 0.5, var_99_18)

					arg_96_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_96_1.var_.characterEffect6148ui_story.fillRatio = var_99_19
				end
			end

			if arg_96_1.time_ >= var_99_16 + var_99_17 and arg_96_1.time_ < var_99_16 + var_99_17 + arg_99_0 and not isNil(var_99_15) and arg_96_1.var_.characterEffect6148ui_story then
				local var_99_20 = 0.5

				arg_96_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_96_1.var_.characterEffect6148ui_story.fillRatio = var_99_20
			end

			local var_99_21 = 0

			if var_99_21 < arg_96_1.time_ and arg_96_1.time_ <= var_99_21 + arg_99_0 then
				arg_96_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			local var_99_22 = 0

			if var_99_22 < arg_96_1.time_ and arg_96_1.time_ <= var_99_22 + arg_99_0 then
				arg_96_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_99_23 = 0
			local var_99_24 = 0.375

			if var_99_23 < arg_96_1.time_ and arg_96_1.time_ <= var_99_23 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_25 = arg_96_1:FormatText(StoryNameCfg[1487].name)

				arg_96_1.leftNameTxt_.text = var_99_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_26 = arg_96_1:GetWordFromCfg(324751024)
				local var_99_27 = arg_96_1:FormatText(var_99_26.content)

				arg_96_1.text_.text = var_99_27

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_28 = 15
				local var_99_29 = utf8.len(var_99_27)
				local var_99_30 = var_99_28 <= 0 and var_99_24 or var_99_24 * (var_99_29 / var_99_28)

				if var_99_30 > 0 and var_99_24 < var_99_30 then
					arg_96_1.talkMaxDuration = var_99_30

					if var_99_30 + var_99_23 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_30 + var_99_23
					end
				end

				arg_96_1.text_.text = var_99_27
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751024", "story_v_out_324751.awb") ~= 0 then
					local var_99_31 = manager.audio:GetVoiceLength("story_v_out_324751", "324751024", "story_v_out_324751.awb") / 1000

					if var_99_31 + var_99_23 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_31 + var_99_23
					end

					if var_99_26.prefab_name ~= "" and arg_96_1.actors_[var_99_26.prefab_name] ~= nil then
						local var_99_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_26.prefab_name].transform, "story_v_out_324751", "324751024", "story_v_out_324751.awb")

						arg_96_1:RecordAudio("324751024", var_99_32)
						arg_96_1:RecordAudio("324751024", var_99_32)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_324751", "324751024", "story_v_out_324751.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_324751", "324751024", "story_v_out_324751.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_33 = math.max(var_99_24, arg_96_1.talkMaxDuration)

			if var_99_23 <= arg_96_1.time_ and arg_96_1.time_ < var_99_23 + var_99_33 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_23) / var_99_33

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_23 + var_99_33 and arg_96_1.time_ < var_99_23 + var_99_33 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play324751025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324751025
		arg_100_1.duration_ = 2

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324751026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1053ui_story"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos1053ui_story = var_103_0.localPosition

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_0.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end
			end

			local var_103_3 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_3 then
				local var_103_4 = (arg_100_1.time_ - var_103_1) / var_103_3
				local var_103_5 = Vector3.New(0, -1.08, -6)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1053ui_story, var_103_5, var_103_4)

				local var_103_6 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_6.x, var_103_6.y, var_103_6.z)

				local var_103_7 = var_103_0.localEulerAngles

				var_103_7.z = 0
				var_103_7.x = 0
				var_103_0.localEulerAngles = var_103_7
			end

			if arg_100_1.time_ >= var_103_1 + var_103_3 and arg_100_1.time_ < var_103_1 + var_103_3 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_103_8 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_8.x, var_103_8.y, var_103_8.z)

				local var_103_9 = var_103_0.localEulerAngles

				var_103_9.z = 0
				var_103_9.x = 0
				var_103_0.localEulerAngles = var_103_9

				local var_103_10 = GameObjectTools.GetOrAddComponent(var_103_0.gameObject, typeof(DynamicBoneHelper))

				if var_103_10 then
					var_103_10:EnableDynamicBone(true)
				end
			end

			local var_103_11 = arg_100_1.actors_["1053ui_story"]
			local var_103_12 = 0

			if var_103_12 < arg_100_1.time_ and arg_100_1.time_ <= var_103_12 + arg_103_0 and not isNil(var_103_11) and arg_100_1.var_.characterEffect1053ui_story == nil then
				arg_100_1.var_.characterEffect1053ui_story = var_103_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_13 = 0.200000002980232

			if var_103_12 <= arg_100_1.time_ and arg_100_1.time_ < var_103_12 + var_103_13 and not isNil(var_103_11) then
				local var_103_14 = (arg_100_1.time_ - var_103_12) / var_103_13

				if arg_100_1.var_.characterEffect1053ui_story and not isNil(var_103_11) then
					arg_100_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_12 + var_103_13 and arg_100_1.time_ < var_103_12 + var_103_13 + arg_103_0 and not isNil(var_103_11) and arg_100_1.var_.characterEffect1053ui_story then
				arg_100_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_103_15 = arg_100_1.actors_["1036ui_story"]
			local var_103_16 = 0

			if var_103_16 < arg_100_1.time_ and arg_100_1.time_ <= var_103_16 + arg_103_0 and not isNil(var_103_15) and arg_100_1.var_.characterEffect1036ui_story == nil then
				arg_100_1.var_.characterEffect1036ui_story = var_103_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_17 = 0.200000002980232

			if var_103_16 <= arg_100_1.time_ and arg_100_1.time_ < var_103_16 + var_103_17 and not isNil(var_103_15) then
				local var_103_18 = (arg_100_1.time_ - var_103_16) / var_103_17

				if arg_100_1.var_.characterEffect1036ui_story and not isNil(var_103_15) then
					local var_103_19 = Mathf.Lerp(0, 0.5, var_103_18)

					arg_100_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1036ui_story.fillRatio = var_103_19
				end
			end

			if arg_100_1.time_ >= var_103_16 + var_103_17 and arg_100_1.time_ < var_103_16 + var_103_17 + arg_103_0 and not isNil(var_103_15) and arg_100_1.var_.characterEffect1036ui_story then
				local var_103_20 = 0.5

				arg_100_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1036ui_story.fillRatio = var_103_20
			end

			local var_103_21 = 0

			if var_103_21 < arg_100_1.time_ and arg_100_1.time_ <= var_103_21 + arg_103_0 then
				arg_100_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_1")
			end

			local var_103_22 = 0

			if var_103_22 < arg_100_1.time_ and arg_100_1.time_ <= var_103_22 + arg_103_0 then
				arg_100_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_103_23 = arg_100_1.actors_["6148ui_story"].transform
			local var_103_24 = 0

			if var_103_24 < arg_100_1.time_ and arg_100_1.time_ <= var_103_24 + arg_103_0 then
				arg_100_1.var_.moveOldPos6148ui_story = var_103_23.localPosition

				local var_103_25 = GameObjectTools.GetOrAddComponent(var_103_23.gameObject, typeof(DynamicBoneHelper))

				if var_103_25 then
					var_103_25:EnableDynamicBone(false)
				end
			end

			local var_103_26 = 0.001

			if var_103_24 <= arg_100_1.time_ and arg_100_1.time_ < var_103_24 + var_103_26 then
				local var_103_27 = (arg_100_1.time_ - var_103_24) / var_103_26
				local var_103_28 = Vector3.New(0, 100, 0)

				var_103_23.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos6148ui_story, var_103_28, var_103_27)

				local var_103_29 = manager.ui.mainCamera.transform.position - var_103_23.position

				var_103_23.forward = Vector3.New(var_103_29.x, var_103_29.y, var_103_29.z)

				local var_103_30 = var_103_23.localEulerAngles

				var_103_30.z = 0
				var_103_30.x = 0
				var_103_23.localEulerAngles = var_103_30
			end

			if arg_100_1.time_ >= var_103_24 + var_103_26 and arg_100_1.time_ < var_103_24 + var_103_26 + arg_103_0 then
				var_103_23.localPosition = Vector3.New(0, 100, 0)

				local var_103_31 = manager.ui.mainCamera.transform.position - var_103_23.position

				var_103_23.forward = Vector3.New(var_103_31.x, var_103_31.y, var_103_31.z)

				local var_103_32 = var_103_23.localEulerAngles

				var_103_32.z = 0
				var_103_32.x = 0
				var_103_23.localEulerAngles = var_103_32

				local var_103_33 = GameObjectTools.GetOrAddComponent(var_103_23.gameObject, typeof(DynamicBoneHelper))

				if var_103_33 then
					var_103_33:EnableDynamicBone(true)
				end
			end

			local var_103_34 = arg_100_1.actors_["1054ui_story"].transform
			local var_103_35 = 0

			if var_103_35 < arg_100_1.time_ and arg_100_1.time_ <= var_103_35 + arg_103_0 then
				arg_100_1.var_.moveOldPos1054ui_story = var_103_34.localPosition

				local var_103_36 = GameObjectTools.GetOrAddComponent(var_103_34.gameObject, typeof(DynamicBoneHelper))

				if var_103_36 then
					var_103_36:EnableDynamicBone(false)
				end
			end

			local var_103_37 = 0.001

			if var_103_35 <= arg_100_1.time_ and arg_100_1.time_ < var_103_35 + var_103_37 then
				local var_103_38 = (arg_100_1.time_ - var_103_35) / var_103_37
				local var_103_39 = Vector3.New(0, 100, 0)

				var_103_34.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1054ui_story, var_103_39, var_103_38)

				local var_103_40 = manager.ui.mainCamera.transform.position - var_103_34.position

				var_103_34.forward = Vector3.New(var_103_40.x, var_103_40.y, var_103_40.z)

				local var_103_41 = var_103_34.localEulerAngles

				var_103_41.z = 0
				var_103_41.x = 0
				var_103_34.localEulerAngles = var_103_41
			end

			if arg_100_1.time_ >= var_103_35 + var_103_37 and arg_100_1.time_ < var_103_35 + var_103_37 + arg_103_0 then
				var_103_34.localPosition = Vector3.New(0, 100, 0)

				local var_103_42 = manager.ui.mainCamera.transform.position - var_103_34.position

				var_103_34.forward = Vector3.New(var_103_42.x, var_103_42.y, var_103_42.z)

				local var_103_43 = var_103_34.localEulerAngles

				var_103_43.z = 0
				var_103_43.x = 0
				var_103_34.localEulerAngles = var_103_43

				local var_103_44 = GameObjectTools.GetOrAddComponent(var_103_34.gameObject, typeof(DynamicBoneHelper))

				if var_103_44 then
					var_103_44:EnableDynamicBone(true)
				end
			end

			local var_103_45 = 0
			local var_103_46 = 0.175

			if var_103_45 < arg_100_1.time_ and arg_100_1.time_ <= var_103_45 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_47 = arg_100_1:FormatText(StoryNameCfg[472].name)

				arg_100_1.leftNameTxt_.text = var_103_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_48 = arg_100_1:GetWordFromCfg(324751025)
				local var_103_49 = arg_100_1:FormatText(var_103_48.content)

				arg_100_1.text_.text = var_103_49

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_50 = 7
				local var_103_51 = utf8.len(var_103_49)
				local var_103_52 = var_103_50 <= 0 and var_103_46 or var_103_46 * (var_103_51 / var_103_50)

				if var_103_52 > 0 and var_103_46 < var_103_52 then
					arg_100_1.talkMaxDuration = var_103_52

					if var_103_52 + var_103_45 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_52 + var_103_45
					end
				end

				arg_100_1.text_.text = var_103_49
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751025", "story_v_out_324751.awb") ~= 0 then
					local var_103_53 = manager.audio:GetVoiceLength("story_v_out_324751", "324751025", "story_v_out_324751.awb") / 1000

					if var_103_53 + var_103_45 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_53 + var_103_45
					end

					if var_103_48.prefab_name ~= "" and arg_100_1.actors_[var_103_48.prefab_name] ~= nil then
						local var_103_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_48.prefab_name].transform, "story_v_out_324751", "324751025", "story_v_out_324751.awb")

						arg_100_1:RecordAudio("324751025", var_103_54)
						arg_100_1:RecordAudio("324751025", var_103_54)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_324751", "324751025", "story_v_out_324751.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_324751", "324751025", "story_v_out_324751.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_55 = math.max(var_103_46, arg_100_1.talkMaxDuration)

			if var_103_45 <= arg_100_1.time_ and arg_100_1.time_ < var_103_45 + var_103_55 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_45) / var_103_55

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_45 + var_103_55 and arg_100_1.time_ < var_103_45 + var_103_55 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play324751026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324751026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play324751027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1053ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1053ui_story = var_107_0.localPosition

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end
			end

			local var_107_3 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_3 then
				local var_107_4 = (arg_104_1.time_ - var_107_1) / var_107_3
				local var_107_5 = Vector3.New(0, 100, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1053ui_story, var_107_5, var_107_4)

				local var_107_6 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_6.x, var_107_6.y, var_107_6.z)

				local var_107_7 = var_107_0.localEulerAngles

				var_107_7.z = 0
				var_107_7.x = 0
				var_107_0.localEulerAngles = var_107_7
			end

			if arg_104_1.time_ >= var_107_1 + var_107_3 and arg_104_1.time_ < var_107_1 + var_107_3 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, 100, 0)

				local var_107_8 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_8.x, var_107_8.y, var_107_8.z)

				local var_107_9 = var_107_0.localEulerAngles

				var_107_9.z = 0
				var_107_9.x = 0
				var_107_0.localEulerAngles = var_107_9

				local var_107_10 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_10 then
					var_107_10:EnableDynamicBone(true)
				end
			end

			local var_107_11 = arg_104_1.actors_["1053ui_story"]
			local var_107_12 = 0

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.characterEffect1053ui_story == nil then
				arg_104_1.var_.characterEffect1053ui_story = var_107_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_13 = 0.200000002980232

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_13 and not isNil(var_107_11) then
				local var_107_14 = (arg_104_1.time_ - var_107_12) / var_107_13

				if arg_104_1.var_.characterEffect1053ui_story and not isNil(var_107_11) then
					local var_107_15 = Mathf.Lerp(0, 0.5, var_107_14)

					arg_104_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1053ui_story.fillRatio = var_107_15
				end
			end

			if arg_104_1.time_ >= var_107_12 + var_107_13 and arg_104_1.time_ < var_107_12 + var_107_13 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.characterEffect1053ui_story then
				local var_107_16 = 0.5

				arg_104_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1053ui_story.fillRatio = var_107_16
			end

			local var_107_17 = 0
			local var_107_18 = 0.925

			if var_107_17 < arg_104_1.time_ and arg_104_1.time_ <= var_107_17 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_19 = arg_104_1:GetWordFromCfg(324751026)
				local var_107_20 = arg_104_1:FormatText(var_107_19.content)

				arg_104_1.text_.text = var_107_20

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_21 = 37
				local var_107_22 = utf8.len(var_107_20)
				local var_107_23 = var_107_21 <= 0 and var_107_18 or var_107_18 * (var_107_22 / var_107_21)

				if var_107_23 > 0 and var_107_18 < var_107_23 then
					arg_104_1.talkMaxDuration = var_107_23

					if var_107_23 + var_107_17 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_23 + var_107_17
					end
				end

				arg_104_1.text_.text = var_107_20
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_24 = math.max(var_107_18, arg_104_1.talkMaxDuration)

			if var_107_17 <= arg_104_1.time_ and arg_104_1.time_ < var_107_17 + var_107_24 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_17) / var_107_24

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_17 + var_107_24 and arg_104_1.time_ < var_107_17 + var_107_24 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play324751027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324751027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play324751028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 1.55

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(324751027)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 62
				local var_111_5 = utf8.len(var_111_3)
				local var_111_6 = var_111_4 <= 0 and var_111_1 or var_111_1 * (var_111_5 / var_111_4)

				if var_111_6 > 0 and var_111_1 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_7 and arg_108_1.time_ < var_111_0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play324751028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324751028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324751029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.375

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_2 = arg_112_1:FormatText(StoryNameCfg[7].name)

				arg_112_1.leftNameTxt_.text = var_115_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:GetWordFromCfg(324751028)
				local var_115_4 = arg_112_1:FormatText(var_115_3.content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 15
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
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_8 and arg_112_1.time_ < var_115_0 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play324751029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324751029
		arg_116_1.duration_ = 8.3

		local var_116_0 = {
			zh = 6.2,
			ja = 8.3
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
				arg_116_0:Play324751030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["6148ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos6148ui_story = var_119_0.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_3 then
				local var_119_4 = (arg_116_1.time_ - var_119_1) / var_119_3
				local var_119_5 = Vector3.New(-0.7, -0.985, -6)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos6148ui_story, var_119_5, var_119_4)

				local var_119_6 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_6.x, var_119_6.y, var_119_6.z)

				local var_119_7 = var_119_0.localEulerAngles

				var_119_7.z = 0
				var_119_7.x = 0
				var_119_0.localEulerAngles = var_119_7
			end

			if arg_116_1.time_ >= var_119_1 + var_119_3 and arg_116_1.time_ < var_119_1 + var_119_3 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(-0.7, -0.985, -6)

				local var_119_8 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_8.x, var_119_8.y, var_119_8.z)

				local var_119_9 = var_119_0.localEulerAngles

				var_119_9.z = 0
				var_119_9.x = 0
				var_119_0.localEulerAngles = var_119_9

				local var_119_10 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_10 then
					var_119_10:EnableDynamicBone(true)
				end
			end

			local var_119_11 = arg_116_1.actors_["6148ui_story"]
			local var_119_12 = 0

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 and not isNil(var_119_11) and arg_116_1.var_.characterEffect6148ui_story == nil then
				arg_116_1.var_.characterEffect6148ui_story = var_119_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_13 = 0.200000002980232

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_13 and not isNil(var_119_11) then
				local var_119_14 = (arg_116_1.time_ - var_119_12) / var_119_13

				if arg_116_1.var_.characterEffect6148ui_story and not isNil(var_119_11) then
					arg_116_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_12 + var_119_13 and arg_116_1.time_ < var_119_12 + var_119_13 + arg_119_0 and not isNil(var_119_11) and arg_116_1.var_.characterEffect6148ui_story then
				arg_116_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_119_15 = 0

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_119_16 = 0

			if var_119_16 < arg_116_1.time_ and arg_116_1.time_ <= var_119_16 + arg_119_0 then
				arg_116_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_119_17 = 0
			local var_119_18 = 0.825

			if var_119_17 < arg_116_1.time_ and arg_116_1.time_ <= var_119_17 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_19 = arg_116_1:FormatText(StoryNameCfg[1488].name)

				arg_116_1.leftNameTxt_.text = var_119_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_20 = arg_116_1:GetWordFromCfg(324751029)
				local var_119_21 = arg_116_1:FormatText(var_119_20.content)

				arg_116_1.text_.text = var_119_21

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_22 = 33
				local var_119_23 = utf8.len(var_119_21)
				local var_119_24 = var_119_22 <= 0 and var_119_18 or var_119_18 * (var_119_23 / var_119_22)

				if var_119_24 > 0 and var_119_18 < var_119_24 then
					arg_116_1.talkMaxDuration = var_119_24

					if var_119_24 + var_119_17 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_24 + var_119_17
					end
				end

				arg_116_1.text_.text = var_119_21
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751029", "story_v_out_324751.awb") ~= 0 then
					local var_119_25 = manager.audio:GetVoiceLength("story_v_out_324751", "324751029", "story_v_out_324751.awb") / 1000

					if var_119_25 + var_119_17 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_25 + var_119_17
					end

					if var_119_20.prefab_name ~= "" and arg_116_1.actors_[var_119_20.prefab_name] ~= nil then
						local var_119_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_20.prefab_name].transform, "story_v_out_324751", "324751029", "story_v_out_324751.awb")

						arg_116_1:RecordAudio("324751029", var_119_26)
						arg_116_1:RecordAudio("324751029", var_119_26)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_324751", "324751029", "story_v_out_324751.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_324751", "324751029", "story_v_out_324751.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_27 = math.max(var_119_18, arg_116_1.talkMaxDuration)

			if var_119_17 <= arg_116_1.time_ and arg_116_1.time_ < var_119_17 + var_119_27 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_17) / var_119_27

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_17 + var_119_27 and arg_116_1.time_ < var_119_17 + var_119_27 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play324751030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324751030
		arg_120_1.duration_ = 8.07

		local var_120_0 = {
			zh = 8.066,
			ja = 7.233
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
				arg_120_0:Play324751031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1054ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1054ui_story = var_123_0.localPosition

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end
			end

			local var_123_3 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_3 then
				local var_123_4 = (arg_120_1.time_ - var_123_1) / var_123_3
				local var_123_5 = Vector3.New(0.7, -0.985, -6)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1054ui_story, var_123_5, var_123_4)

				local var_123_6 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_6.x, var_123_6.y, var_123_6.z)

				local var_123_7 = var_123_0.localEulerAngles

				var_123_7.z = 0
				var_123_7.x = 0
				var_123_0.localEulerAngles = var_123_7
			end

			if arg_120_1.time_ >= var_123_1 + var_123_3 and arg_120_1.time_ < var_123_1 + var_123_3 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0.7, -0.985, -6)

				local var_123_8 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_8.x, var_123_8.y, var_123_8.z)

				local var_123_9 = var_123_0.localEulerAngles

				var_123_9.z = 0
				var_123_9.x = 0
				var_123_0.localEulerAngles = var_123_9

				local var_123_10 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_10 then
					var_123_10:EnableDynamicBone(true)
				end
			end

			local var_123_11 = arg_120_1.actors_["1054ui_story"]
			local var_123_12 = 0

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 and not isNil(var_123_11) and arg_120_1.var_.characterEffect1054ui_story == nil then
				arg_120_1.var_.characterEffect1054ui_story = var_123_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_13 = 0.200000002980232

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_13 and not isNil(var_123_11) then
				local var_123_14 = (arg_120_1.time_ - var_123_12) / var_123_13

				if arg_120_1.var_.characterEffect1054ui_story and not isNil(var_123_11) then
					arg_120_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_12 + var_123_13 and arg_120_1.time_ < var_123_12 + var_123_13 + arg_123_0 and not isNil(var_123_11) and arg_120_1.var_.characterEffect1054ui_story then
				arg_120_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_123_15 = arg_120_1.actors_["6148ui_story"]
			local var_123_16 = 0

			if var_123_16 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 and not isNil(var_123_15) and arg_120_1.var_.characterEffect6148ui_story == nil then
				arg_120_1.var_.characterEffect6148ui_story = var_123_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_17 = 0.200000002980232

			if var_123_16 <= arg_120_1.time_ and arg_120_1.time_ < var_123_16 + var_123_17 and not isNil(var_123_15) then
				local var_123_18 = (arg_120_1.time_ - var_123_16) / var_123_17

				if arg_120_1.var_.characterEffect6148ui_story and not isNil(var_123_15) then
					local var_123_19 = Mathf.Lerp(0, 0.5, var_123_18)

					arg_120_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_120_1.var_.characterEffect6148ui_story.fillRatio = var_123_19
				end
			end

			if arg_120_1.time_ >= var_123_16 + var_123_17 and arg_120_1.time_ < var_123_16 + var_123_17 + arg_123_0 and not isNil(var_123_15) and arg_120_1.var_.characterEffect6148ui_story then
				local var_123_20 = 0.5

				arg_120_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_120_1.var_.characterEffect6148ui_story.fillRatio = var_123_20
			end

			local var_123_21 = 0

			if var_123_21 < arg_120_1.time_ and arg_120_1.time_ <= var_123_21 + arg_123_0 then
				arg_120_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action426")
			end

			local var_123_22 = 0

			if var_123_22 < arg_120_1.time_ and arg_120_1.time_ <= var_123_22 + arg_123_0 then
				arg_120_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_123_23 = 0
			local var_123_24 = 0.75

			if var_123_23 < arg_120_1.time_ and arg_120_1.time_ <= var_123_23 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_25 = arg_120_1:FormatText(StoryNameCfg[1487].name)

				arg_120_1.leftNameTxt_.text = var_123_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_26 = arg_120_1:GetWordFromCfg(324751030)
				local var_123_27 = arg_120_1:FormatText(var_123_26.content)

				arg_120_1.text_.text = var_123_27

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_28 = 30
				local var_123_29 = utf8.len(var_123_27)
				local var_123_30 = var_123_28 <= 0 and var_123_24 or var_123_24 * (var_123_29 / var_123_28)

				if var_123_30 > 0 and var_123_24 < var_123_30 then
					arg_120_1.talkMaxDuration = var_123_30

					if var_123_30 + var_123_23 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_30 + var_123_23
					end
				end

				arg_120_1.text_.text = var_123_27
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751030", "story_v_out_324751.awb") ~= 0 then
					local var_123_31 = manager.audio:GetVoiceLength("story_v_out_324751", "324751030", "story_v_out_324751.awb") / 1000

					if var_123_31 + var_123_23 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_31 + var_123_23
					end

					if var_123_26.prefab_name ~= "" and arg_120_1.actors_[var_123_26.prefab_name] ~= nil then
						local var_123_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_26.prefab_name].transform, "story_v_out_324751", "324751030", "story_v_out_324751.awb")

						arg_120_1:RecordAudio("324751030", var_123_32)
						arg_120_1:RecordAudio("324751030", var_123_32)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_324751", "324751030", "story_v_out_324751.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_324751", "324751030", "story_v_out_324751.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_33 = math.max(var_123_24, arg_120_1.talkMaxDuration)

			if var_123_23 <= arg_120_1.time_ and arg_120_1.time_ < var_123_23 + var_123_33 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_23) / var_123_33

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_23 + var_123_33 and arg_120_1.time_ < var_123_23 + var_123_33 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play324751031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324751031
		arg_124_1.duration_ = 4.1

		local var_124_0 = {
			zh = 3.5,
			ja = 4.1
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
				arg_124_0:Play324751032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1054ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1054ui_story == nil then
				arg_124_1.var_.characterEffect1054ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1054ui_story and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1054ui_story.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1054ui_story then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1054ui_story.fillRatio = var_127_5
			end

			local var_127_6 = arg_124_1.actors_["6148ui_story"]
			local var_127_7 = 0

			if var_127_7 < arg_124_1.time_ and arg_124_1.time_ <= var_127_7 + arg_127_0 and not isNil(var_127_6) and arg_124_1.var_.characterEffect6148ui_story == nil then
				arg_124_1.var_.characterEffect6148ui_story = var_127_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_8 = 0.200000002980232

			if var_127_7 <= arg_124_1.time_ and arg_124_1.time_ < var_127_7 + var_127_8 and not isNil(var_127_6) then
				local var_127_9 = (arg_124_1.time_ - var_127_7) / var_127_8

				if arg_124_1.var_.characterEffect6148ui_story and not isNil(var_127_6) then
					arg_124_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_7 + var_127_8 and arg_124_1.time_ < var_127_7 + var_127_8 + arg_127_0 and not isNil(var_127_6) and arg_124_1.var_.characterEffect6148ui_story then
				arg_124_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_127_10 = 0
			local var_127_11 = 0.425

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_12 = arg_124_1:FormatText(StoryNameCfg[1488].name)

				arg_124_1.leftNameTxt_.text = var_127_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_13 = arg_124_1:GetWordFromCfg(324751031)
				local var_127_14 = arg_124_1:FormatText(var_127_13.content)

				arg_124_1.text_.text = var_127_14

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_15 = 17
				local var_127_16 = utf8.len(var_127_14)
				local var_127_17 = var_127_15 <= 0 and var_127_11 or var_127_11 * (var_127_16 / var_127_15)

				if var_127_17 > 0 and var_127_11 < var_127_17 then
					arg_124_1.talkMaxDuration = var_127_17

					if var_127_17 + var_127_10 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_17 + var_127_10
					end
				end

				arg_124_1.text_.text = var_127_14
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751031", "story_v_out_324751.awb") ~= 0 then
					local var_127_18 = manager.audio:GetVoiceLength("story_v_out_324751", "324751031", "story_v_out_324751.awb") / 1000

					if var_127_18 + var_127_10 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_18 + var_127_10
					end

					if var_127_13.prefab_name ~= "" and arg_124_1.actors_[var_127_13.prefab_name] ~= nil then
						local var_127_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_13.prefab_name].transform, "story_v_out_324751", "324751031", "story_v_out_324751.awb")

						arg_124_1:RecordAudio("324751031", var_127_19)
						arg_124_1:RecordAudio("324751031", var_127_19)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_324751", "324751031", "story_v_out_324751.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_324751", "324751031", "story_v_out_324751.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_20 = math.max(var_127_11, arg_124_1.talkMaxDuration)

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_20 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_10) / var_127_20

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_10 + var_127_20 and arg_124_1.time_ < var_127_10 + var_127_20 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play324751032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324751032
		arg_128_1.duration_ = 2.67

		local var_128_0 = {
			zh = 1.999999999999,
			ja = 2.666
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
				arg_128_0:Play324751033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1054ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1054ui_story == nil then
				arg_128_1.var_.characterEffect1054ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect1054ui_story and not isNil(var_131_0) then
					local var_131_4 = Mathf.Lerp(0, 0.5, var_131_3)

					arg_128_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1054ui_story.fillRatio = var_131_4
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect1054ui_story then
				local var_131_5 = 0.5

				arg_128_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1054ui_story.fillRatio = var_131_5
			end

			local var_131_6 = arg_128_1.actors_["6148ui_story"]
			local var_131_7 = 0

			if var_131_7 < arg_128_1.time_ and arg_128_1.time_ <= var_131_7 + arg_131_0 and not isNil(var_131_6) and arg_128_1.var_.characterEffect6148ui_story == nil then
				arg_128_1.var_.characterEffect6148ui_story = var_131_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_8 = 0.200000002980232

			if var_131_7 <= arg_128_1.time_ and arg_128_1.time_ < var_131_7 + var_131_8 and not isNil(var_131_6) then
				local var_131_9 = (arg_128_1.time_ - var_131_7) / var_131_8

				if arg_128_1.var_.characterEffect6148ui_story and not isNil(var_131_6) then
					arg_128_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_7 + var_131_8 and arg_128_1.time_ < var_131_7 + var_131_8 + arg_131_0 and not isNil(var_131_6) and arg_128_1.var_.characterEffect6148ui_story then
				arg_128_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			local var_131_11 = 0
			local var_131_12 = 0.125

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_13 = arg_128_1:FormatText(StoryNameCfg[1487].name)

				arg_128_1.leftNameTxt_.text = var_131_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_14 = arg_128_1:GetWordFromCfg(324751032)
				local var_131_15 = arg_128_1:FormatText(var_131_14.content)

				arg_128_1.text_.text = var_131_15

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_16 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_324751", "324751032", "story_v_out_324751.awb") ~= 0 then
					local var_131_19 = manager.audio:GetVoiceLength("story_v_out_324751", "324751032", "story_v_out_324751.awb") / 1000

					if var_131_19 + var_131_11 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_11
					end

					if var_131_14.prefab_name ~= "" and arg_128_1.actors_[var_131_14.prefab_name] ~= nil then
						local var_131_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_14.prefab_name].transform, "story_v_out_324751", "324751032", "story_v_out_324751.awb")

						arg_128_1:RecordAudio("324751032", var_131_20)
						arg_128_1:RecordAudio("324751032", var_131_20)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324751", "324751032", "story_v_out_324751.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324751", "324751032", "story_v_out_324751.awb")
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
	Play324751033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324751033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324751034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1036ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1036ui_story == nil then
				arg_132_1.var_.characterEffect1036ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1036ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1036ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1036ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1036ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 1.175

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_8 = arg_132_1:GetWordFromCfg(324751033)
				local var_135_9 = arg_132_1:FormatText(var_135_8.content)

				arg_132_1.text_.text = var_135_9

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_10 = 47
				local var_135_11 = utf8.len(var_135_9)
				local var_135_12 = var_135_10 <= 0 and var_135_7 or var_135_7 * (var_135_11 / var_135_10)

				if var_135_12 > 0 and var_135_7 < var_135_12 then
					arg_132_1.talkMaxDuration = var_135_12

					if var_135_12 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_9
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_13 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_13 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_13

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_13 and arg_132_1.time_ < var_135_6 + var_135_13 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play324751034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324751034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
			arg_136_1.auto_ = false
		end

		function arg_136_1.playNext_(arg_138_0)
			arg_136_1.onStoryFinished_()
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.8

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_2 = arg_136_1:GetWordFromCfg(324751034)
				local var_139_3 = arg_136_1:FormatText(var_139_2.content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 32
				local var_139_5 = utf8.len(var_139_3)
				local var_139_6 = var_139_4 <= 0 and var_139_1 or var_139_1 * (var_139_5 / var_139_4)

				if var_139_6 > 0 and var_139_1 < var_139_6 then
					arg_136_1.talkMaxDuration = var_139_6

					if var_139_6 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_6 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_7 and arg_136_1.time_ < var_139_0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2007"
	},
	voices = {
		"story_v_out_324751.awb"
	}
}
