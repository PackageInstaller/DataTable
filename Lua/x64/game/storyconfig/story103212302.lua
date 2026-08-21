return {
	Play321232001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321232001
		arg_1_1.duration_ = 6.53

		local var_1_0 = {
			zh = 6.533,
			ja = 4.6
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
				arg_1_0:Play321232002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.825

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

			local var_4_24 = 0
			local var_4_25 = 0.2

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.4
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_4_0_story_osiris_room", "bgm_activity_4_0_story_osiris_room")

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

			local var_4_36 = 1.8
			local var_4_37 = 0.325

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[37].name)

				arg_1_1.leftNameTxt_.text = var_4_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_40 = arg_1_1:GetWordFromCfg(321232001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232001", "story_v_out_321232.awb") ~= 0 then
					local var_4_45 = manager.audio:GetVoiceLength("story_v_out_321232", "321232001", "story_v_out_321232.awb") / 1000

					if var_4_45 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_36
					end

					if var_4_40.prefab_name ~= "" and arg_1_1.actors_[var_4_40.prefab_name] ~= nil then
						local var_4_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_40.prefab_name].transform, "story_v_out_321232", "321232001", "story_v_out_321232.awb")

						arg_1_1:RecordAudio("321232001", var_4_46)
						arg_1_1:RecordAudio("321232001", var_4_46)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321232", "321232001", "story_v_out_321232.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321232", "321232001", "story_v_out_321232.awb")
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
	Play321232002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321232002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321232003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10131ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "10131ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = arg_9_1.actors_["10131ui_story"]
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10131ui_story == nil then
				arg_9_1.var_.characterEffect10131ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_7 = 0.200000002980232

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 and not isNil(var_12_5) then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7

				if arg_9_1.var_.characterEffect10131ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10131ui_story then
				arg_9_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_12_9 = "1011ui_story"

			if arg_9_1.actors_[var_12_9] == nil then
				local var_12_10 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_12_10) then
					local var_12_11 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_9_1.stage_.transform)

					var_12_11.name = var_12_9
					var_12_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_9] = var_12_11

					local var_12_12 = var_12_11:GetComponentInChildren(typeof(CharacterEffect))

					var_12_12.enabled = true

					local var_12_13 = GameObjectTools.GetOrAddComponent(var_12_11, typeof(DynamicBoneHelper))

					if var_12_13 then
						var_12_13:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_12.transform, false)

					arg_9_1.var_[var_12_9 .. "Animator"] = var_12_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_9 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_9 .. "LipSync"] = var_12_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_14 = arg_9_1.actors_["1011ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1011ui_story == nil then
				arg_9_1.var_.characterEffect1011ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1011ui_story and not isNil(var_12_14) then
					local var_12_18 = Mathf.Lerp(0, 0.5, var_12_17)

					arg_9_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1011ui_story.fillRatio = var_12_18
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1011ui_story then
				local var_12_19 = 0.5

				arg_9_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1011ui_story.fillRatio = var_12_19
			end

			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.cswbg_:SetActive(true)

				local var_12_21 = arg_9_1.cswt_:GetComponent("RectTransform")

				arg_9_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_12_21.offsetMin = Vector2.New(0, 0)
				var_12_21.offsetMax = Vector2.New(0, 0)

				local var_12_22 = arg_9_1:GetWordFromCfg(419132)
				local var_12_23 = arg_9_1:FormatText(var_12_22.content)

				arg_9_1.cswt_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.cswt_)

				arg_9_1.cswt_.fontSize = 120
				arg_9_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_9_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_9_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_12_24 = 0
			local var_12_25 = 0.05

			if var_12_24 < arg_9_1.time_ and arg_9_1.time_ <= var_12_24 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_26 = arg_9_1:FormatText(StoryNameCfg[36].name)

				arg_9_1.leftNameTxt_.text = var_12_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_27 = arg_9_1:GetWordFromCfg(321232002)
				local var_12_28 = arg_9_1:FormatText(var_12_27.content)

				arg_9_1.text_.text = var_12_28

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_29 = 2
				local var_12_30 = utf8.len(var_12_28)
				local var_12_31 = var_12_29 <= 0 and var_12_25 or var_12_25 * (var_12_30 / var_12_29)

				if var_12_31 > 0 and var_12_25 < var_12_31 then
					arg_9_1.talkMaxDuration = var_12_31

					if var_12_31 + var_12_24 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_31 + var_12_24
					end
				end

				arg_9_1.text_.text = var_12_28
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232002", "story_v_out_321232.awb") ~= 0 then
					local var_12_32 = manager.audio:GetVoiceLength("story_v_out_321232", "321232002", "story_v_out_321232.awb") / 1000

					if var_12_32 + var_12_24 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_32 + var_12_24
					end

					if var_12_27.prefab_name ~= "" and arg_9_1.actors_[var_12_27.prefab_name] ~= nil then
						local var_12_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_27.prefab_name].transform, "story_v_out_321232", "321232002", "story_v_out_321232.awb")

						arg_9_1:RecordAudio("321232002", var_12_33)
						arg_9_1:RecordAudio("321232002", var_12_33)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_321232", "321232002", "story_v_out_321232.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_321232", "321232002", "story_v_out_321232.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_34 = math.max(var_12_25, arg_9_1.talkMaxDuration)

			if var_12_24 <= arg_9_1.time_ and arg_9_1.time_ < var_12_24 + var_12_34 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_24) / var_12_34

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_24 + var_12_34 and arg_9_1.time_ < var_12_24 + var_12_34 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play321232003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321232003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321232004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10131ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect10131ui_story == nil then
				arg_13_1.var_.characterEffect10131ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect10131ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10131ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect10131ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10131ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0.7
			local var_16_7 = 1

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				local var_16_8 = "play"
				local var_16_9 = "effect"

				arg_13_1:AudioAction(var_16_8, var_16_9, "se_story_140", "se_story_140_sit_water", "")
			end

			local var_16_10 = 0
			local var_16_11 = 1.025

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(321232003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_14 = 41
				local var_16_15 = utf8.len(var_16_13)
				local var_16_16 = var_16_14 <= 0 and var_16_11 or var_16_11 * (var_16_15 / var_16_14)

				if var_16_16 > 0 and var_16_11 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_17 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_17 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_17

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_17 and arg_13_1.time_ < var_16_10 + var_16_17 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play321232004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321232004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321232005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 1.5

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(321232004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 60
				local var_20_5 = utf8.len(var_20_3)
				local var_20_6 = var_20_4 <= 0 and var_20_1 or var_20_1 * (var_20_5 / var_20_4)

				if var_20_6 > 0 and var_20_1 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_7 and arg_17_1.time_ < var_20_0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play321232005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321232005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321232006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.725

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(321232005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 29
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321232006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321232006
		arg_25_1.duration_ = 10.87

		local var_25_0 = {
			zh = 6,
			ja = 10.866
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
				arg_25_0:Play321232007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1011ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1011ui_story == nil then
				arg_25_1.var_.characterEffect1011ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1011ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1011ui_story then
				arg_25_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_28_4 = 0
			local var_28_5 = 0.45

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_6 = arg_25_1:FormatText(StoryNameCfg[37].name)

				arg_25_1.leftNameTxt_.text = var_28_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(321232006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 18
				local var_28_10 = utf8.len(var_28_8)
				local var_28_11 = var_28_9 <= 0 and var_28_5 or var_28_5 * (var_28_10 / var_28_9)

				if var_28_11 > 0 and var_28_5 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232006", "story_v_out_321232.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_321232", "321232006", "story_v_out_321232.awb") / 1000

					if var_28_12 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_4
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_321232", "321232006", "story_v_out_321232.awb")

						arg_25_1:RecordAudio("321232006", var_28_13)
						arg_25_1:RecordAudio("321232006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321232", "321232006", "story_v_out_321232.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321232", "321232006", "story_v_out_321232.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_14 and arg_25_1.time_ < var_28_4 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321232007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321232007
		arg_29_1.duration_ = 5.27

		local var_29_0 = {
			zh = 5.266,
			ja = 4.866
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
				arg_29_0:Play321232008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.45

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[37].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(321232007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232007", "story_v_out_321232.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_321232", "321232007", "story_v_out_321232.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_321232", "321232007", "story_v_out_321232.awb")

						arg_29_1:RecordAudio("321232007", var_32_9)
						arg_29_1:RecordAudio("321232007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321232", "321232007", "story_v_out_321232.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321232", "321232007", "story_v_out_321232.awb")
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
	Play321232008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321232008
		arg_33_1.duration_ = 2

		local var_33_0 = {
			zh = 2,
			ja = 1.999999999999
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
				arg_33_0:Play321232009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10131ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10131ui_story == nil then
				arg_33_1.var_.characterEffect10131ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10131ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10131ui_story then
				arg_33_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["1011ui_story"]
			local var_36_5 = 0

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1011ui_story == nil then
				arg_33_1.var_.characterEffect1011ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_6 and not isNil(var_36_4) then
				local var_36_7 = (arg_33_1.time_ - var_36_5) / var_36_6

				if arg_33_1.var_.characterEffect1011ui_story and not isNil(var_36_4) then
					local var_36_8 = Mathf.Lerp(0, 0.5, var_36_7)

					arg_33_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1011ui_story.fillRatio = var_36_8
				end
			end

			if arg_33_1.time_ >= var_36_5 + var_36_6 and arg_33_1.time_ < var_36_5 + var_36_6 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1011ui_story then
				local var_36_9 = 0.5

				arg_33_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1011ui_story.fillRatio = var_36_9
			end

			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.cswbg_:SetActive(true)

				local var_36_11 = arg_33_1.cswt_:GetComponent("RectTransform")

				arg_33_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_36_11.offsetMin = Vector2.New(0, 0)
				var_36_11.offsetMax = Vector2.New(0, 0)

				local var_36_12 = arg_33_1:GetWordFromCfg(419133)
				local var_36_13 = arg_33_1:FormatText(var_36_12.content)

				arg_33_1.cswt_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.cswt_)

				arg_33_1.cswt_.fontSize = 120
				arg_33_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_33_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_33_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_36_14 = 0
			local var_36_15 = 0.05

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_16 = arg_33_1:FormatText(StoryNameCfg[36].name)

				arg_33_1.leftNameTxt_.text = var_36_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_17 = arg_33_1:GetWordFromCfg(321232008)
				local var_36_18 = arg_33_1:FormatText(var_36_17.content)

				arg_33_1.text_.text = var_36_18

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_19 = 2
				local var_36_20 = utf8.len(var_36_18)
				local var_36_21 = var_36_19 <= 0 and var_36_15 or var_36_15 * (var_36_20 / var_36_19)

				if var_36_21 > 0 and var_36_15 < var_36_21 then
					arg_33_1.talkMaxDuration = var_36_21

					if var_36_21 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_21 + var_36_14
					end
				end

				arg_33_1.text_.text = var_36_18
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232008", "story_v_out_321232.awb") ~= 0 then
					local var_36_22 = manager.audio:GetVoiceLength("story_v_out_321232", "321232008", "story_v_out_321232.awb") / 1000

					if var_36_22 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_14
					end

					if var_36_17.prefab_name ~= "" and arg_33_1.actors_[var_36_17.prefab_name] ~= nil then
						local var_36_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_17.prefab_name].transform, "story_v_out_321232", "321232008", "story_v_out_321232.awb")

						arg_33_1:RecordAudio("321232008", var_36_23)
						arg_33_1:RecordAudio("321232008", var_36_23)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321232", "321232008", "story_v_out_321232.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321232", "321232008", "story_v_out_321232.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_24 = math.max(var_36_15, arg_33_1.talkMaxDuration)

			if var_36_14 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_24 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_14) / var_36_24

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_14 + var_36_24 and arg_33_1.time_ < var_36_14 + var_36_24 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play321232009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321232009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play321232010(arg_37_1)
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
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10131ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10131ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10131ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.925

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(321232009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 37
				local var_40_11 = utf8.len(var_40_9)
				local var_40_12 = var_40_10 <= 0 and var_40_7 or var_40_7 * (var_40_11 / var_40_10)

				if var_40_12 > 0 and var_40_7 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_13 and arg_37_1.time_ < var_40_6 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play321232010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321232010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play321232011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.35

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(321232010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 54
				local var_44_5 = utf8.len(var_44_3)
				local var_44_6 = var_44_4 <= 0 and var_44_1 or var_44_1 * (var_44_5 / var_44_4)

				if var_44_6 > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_7 and arg_41_1.time_ < var_44_0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play321232011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321232011
		arg_45_1.duration_ = 7.83

		local var_45_0 = {
			zh = 7.83266666666667,
			ja = 6.09966666666667
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
				arg_45_0:Play321232012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1011ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1011ui_story == nil then
				arg_45_1.var_.characterEffect1011ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1011ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1011ui_story then
				arg_45_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.cswbg_:SetActive(true)

				local var_48_5 = arg_45_1.cswt_:GetComponent("RectTransform")

				arg_45_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_48_5.offsetMin = Vector2.New(0, 0)
				var_48_5.offsetMax = Vector2.New(0, 0)

				local var_48_6 = arg_45_1:GetWordFromCfg(419134)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.cswt_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.cswt_)

				arg_45_1.cswt_.fontSize = 120
				arg_45_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_45_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_45_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			local var_48_9 = 1.56666666666667

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_10 = 1.26666666666667
			local var_48_11 = 0.45

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_12 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_12:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_13 = arg_45_1:FormatText(StoryNameCfg[37].name)

				arg_45_1.leftNameTxt_.text = var_48_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_14 = arg_45_1:GetWordFromCfg(321232011)
				local var_48_15 = arg_45_1:FormatText(var_48_14.content)

				arg_45_1.text_.text = var_48_15

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 18
				local var_48_17 = utf8.len(var_48_15)
				local var_48_18 = var_48_16 <= 0 and var_48_11 or var_48_11 * (var_48_17 / var_48_16)

				if var_48_18 > 0 and var_48_11 < var_48_18 then
					arg_45_1.talkMaxDuration = var_48_18
					var_48_10 = var_48_10 + 0.3

					if var_48_18 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_15
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232011", "story_v_out_321232.awb") ~= 0 then
					local var_48_19 = manager.audio:GetVoiceLength("story_v_out_321232", "321232011", "story_v_out_321232.awb") / 1000

					if var_48_19 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_10
					end

					if var_48_14.prefab_name ~= "" and arg_45_1.actors_[var_48_14.prefab_name] ~= nil then
						local var_48_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_14.prefab_name].transform, "story_v_out_321232", "321232011", "story_v_out_321232.awb")

						arg_45_1:RecordAudio("321232011", var_48_20)
						arg_45_1:RecordAudio("321232011", var_48_20)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321232", "321232011", "story_v_out_321232.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321232", "321232011", "story_v_out_321232.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_21 = var_48_10 + 0.3
			local var_48_22 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_21 <= arg_45_1.time_ and arg_45_1.time_ < var_48_21 + var_48_22 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_21) / var_48_22

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_21 + var_48_22 and arg_45_1.time_ < var_48_21 + var_48_22 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play321232012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321232012
		arg_51_1.duration_ = 14.83

		local var_51_0 = {
			zh = 14.833,
			ja = 13.766
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
				arg_51_0:Play321232013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 1.125

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[37].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:GetWordFromCfg(321232012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 45
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232012", "story_v_out_321232.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_321232", "321232012", "story_v_out_321232.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_321232", "321232012", "story_v_out_321232.awb")

						arg_51_1:RecordAudio("321232012", var_54_9)
						arg_51_1:RecordAudio("321232012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_321232", "321232012", "story_v_out_321232.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_321232", "321232012", "story_v_out_321232.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play321232013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321232013
		arg_55_1.duration_ = 2.13

		local var_55_0 = {
			zh = 2,
			ja = 2.133
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play321232014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10131ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect10131ui_story == nil then
				arg_55_1.var_.characterEffect10131ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect10131ui_story and not isNil(var_58_0) then
					arg_55_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect10131ui_story then
				arg_55_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_58_4 = arg_55_1.actors_["1011ui_story"]
			local var_58_5 = 0

			if var_58_5 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect1011ui_story == nil then
				arg_55_1.var_.characterEffect1011ui_story = var_58_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_6 = 0.200000002980232

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_6 and not isNil(var_58_4) then
				local var_58_7 = (arg_55_1.time_ - var_58_5) / var_58_6

				if arg_55_1.var_.characterEffect1011ui_story and not isNil(var_58_4) then
					local var_58_8 = Mathf.Lerp(0, 0.5, var_58_7)

					arg_55_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1011ui_story.fillRatio = var_58_8
				end
			end

			if arg_55_1.time_ >= var_58_5 + var_58_6 and arg_55_1.time_ < var_58_5 + var_58_6 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect1011ui_story then
				local var_58_9 = 0.5

				arg_55_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1011ui_story.fillRatio = var_58_9
			end

			local var_58_10 = 0

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1.cswbg_:SetActive(true)

				local var_58_11 = arg_55_1.cswt_:GetComponent("RectTransform")

				arg_55_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_58_11.offsetMin = Vector2.New(0, 0)
				var_58_11.offsetMax = Vector2.New(0, 0)

				local var_58_12 = arg_55_1:GetWordFromCfg(419135)
				local var_58_13 = arg_55_1:FormatText(var_58_12.content)

				arg_55_1.cswt_.text = var_58_13

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.cswt_)

				arg_55_1.cswt_.fontSize = 120
				arg_55_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_55_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_55_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_58_14 = 0
			local var_58_15 = 0.05

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_16 = arg_55_1:FormatText(StoryNameCfg[36].name)

				arg_55_1.leftNameTxt_.text = var_58_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_17 = arg_55_1:GetWordFromCfg(321232013)
				local var_58_18 = arg_55_1:FormatText(var_58_17.content)

				arg_55_1.text_.text = var_58_18

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_19 = 2
				local var_58_20 = utf8.len(var_58_18)
				local var_58_21 = var_58_19 <= 0 and var_58_15 or var_58_15 * (var_58_20 / var_58_19)

				if var_58_21 > 0 and var_58_15 < var_58_21 then
					arg_55_1.talkMaxDuration = var_58_21

					if var_58_21 + var_58_14 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_21 + var_58_14
					end
				end

				arg_55_1.text_.text = var_58_18
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232013", "story_v_out_321232.awb") ~= 0 then
					local var_58_22 = manager.audio:GetVoiceLength("story_v_out_321232", "321232013", "story_v_out_321232.awb") / 1000

					if var_58_22 + var_58_14 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_14
					end

					if var_58_17.prefab_name ~= "" and arg_55_1.actors_[var_58_17.prefab_name] ~= nil then
						local var_58_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_17.prefab_name].transform, "story_v_out_321232", "321232013", "story_v_out_321232.awb")

						arg_55_1:RecordAudio("321232013", var_58_23)
						arg_55_1:RecordAudio("321232013", var_58_23)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_321232", "321232013", "story_v_out_321232.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_321232", "321232013", "story_v_out_321232.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_24 = math.max(var_58_15, arg_55_1.talkMaxDuration)

			if var_58_14 <= arg_55_1.time_ and arg_55_1.time_ < var_58_14 + var_58_24 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_14) / var_58_24

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_14 + var_58_24 and arg_55_1.time_ < var_58_14 + var_58_24 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play321232014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321232014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play321232015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10131ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect10131ui_story == nil then
				arg_59_1.var_.characterEffect10131ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect10131ui_story and not isNil(var_62_0) then
					local var_62_4 = Mathf.Lerp(0, 0.5, var_62_3)

					arg_59_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10131ui_story.fillRatio = var_62_4
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect10131ui_story then
				local var_62_5 = 0.5

				arg_59_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10131ui_story.fillRatio = var_62_5
			end

			local var_62_6 = 0
			local var_62_7 = 1.225

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_8 = arg_59_1:GetWordFromCfg(321232014)
				local var_62_9 = arg_59_1:FormatText(var_62_8.content)

				arg_59_1.text_.text = var_62_9

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_10 = 49
				local var_62_11 = utf8.len(var_62_9)
				local var_62_12 = var_62_10 <= 0 and var_62_7 or var_62_7 * (var_62_11 / var_62_10)

				if var_62_12 > 0 and var_62_7 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_9
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_13 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_13 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_13

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_13 and arg_59_1.time_ < var_62_6 + var_62_13 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play321232015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321232015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play321232016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.475

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(321232015)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 19
				local var_66_5 = utf8.len(var_66_3)
				local var_66_6 = var_66_4 <= 0 and var_66_1 or var_66_1 * (var_66_5 / var_66_4)

				if var_66_6 > 0 and var_66_1 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_7 and arg_63_1.time_ < var_66_0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play321232016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321232016
		arg_67_1.duration_ = 7.73

		local var_67_0 = {
			zh = 7.733,
			ja = 7.1
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
				arg_67_0:Play321232017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1011ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1011ui_story == nil then
				arg_67_1.var_.characterEffect1011ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect1011ui_story and not isNil(var_70_0) then
					arg_67_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1011ui_story then
				arg_67_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_70_4 = 0

			if var_70_4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.cswbg_:SetActive(true)

				local var_70_5 = arg_67_1.cswt_:GetComponent("RectTransform")

				arg_67_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_70_5.offsetMin = Vector2.New(0, 0)
				var_70_5.offsetMax = Vector2.New(0, 0)

				local var_70_6 = arg_67_1:GetWordFromCfg(419134)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.cswt_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.cswt_)

				arg_67_1.cswt_.fontSize = 120
				arg_67_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_67_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_67_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_70_8 = 0

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			local var_70_9 = 1.325

			if arg_67_1.time_ >= var_70_8 + var_70_9 and arg_67_1.time_ < var_70_8 + var_70_9 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			if arg_67_1.frameCnt_ <= 1 then
				arg_67_1.dialog_:SetActive(false)
			end

			local var_70_10 = 1
			local var_70_11 = 0.325

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				arg_67_1.dialog_:SetActive(true)

				arg_67_1.dialogCg_.alpha = 0

				local var_70_12 = LeanTween.value(arg_67_1.dialog_, 0, 1, 0.3)

				var_70_12:setOnUpdate(LuaHelper.FloatAction(function(arg_71_0)
					arg_67_1.dialogCg_.alpha = arg_71_0
				end))
				var_70_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_67_1.dialog_)
					var_70_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_67_1.duration_ = arg_67_1.duration_ + 0.3

				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_13 = arg_67_1:FormatText(StoryNameCfg[37].name)

				arg_67_1.leftNameTxt_.text = var_70_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_14 = arg_67_1:GetWordFromCfg(321232016)
				local var_70_15 = arg_67_1:FormatText(var_70_14.content)

				arg_67_1.text_.text = var_70_15

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_16 = 13
				local var_70_17 = utf8.len(var_70_15)
				local var_70_18 = var_70_16 <= 0 and var_70_11 or var_70_11 * (var_70_17 / var_70_16)

				if var_70_18 > 0 and var_70_11 < var_70_18 then
					arg_67_1.talkMaxDuration = var_70_18
					var_70_10 = var_70_10 + 0.3

					if var_70_18 + var_70_10 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_18 + var_70_10
					end
				end

				arg_67_1.text_.text = var_70_15
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232016", "story_v_out_321232.awb") ~= 0 then
					local var_70_19 = manager.audio:GetVoiceLength("story_v_out_321232", "321232016", "story_v_out_321232.awb") / 1000

					if var_70_19 + var_70_10 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_19 + var_70_10
					end

					if var_70_14.prefab_name ~= "" and arg_67_1.actors_[var_70_14.prefab_name] ~= nil then
						local var_70_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_14.prefab_name].transform, "story_v_out_321232", "321232016", "story_v_out_321232.awb")

						arg_67_1:RecordAudio("321232016", var_70_20)
						arg_67_1:RecordAudio("321232016", var_70_20)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_321232", "321232016", "story_v_out_321232.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_321232", "321232016", "story_v_out_321232.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_21 = var_70_10 + 0.3
			local var_70_22 = math.max(var_70_11, arg_67_1.talkMaxDuration)

			if var_70_21 <= arg_67_1.time_ and arg_67_1.time_ < var_70_21 + var_70_22 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_21) / var_70_22

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_21 + var_70_22 and arg_67_1.time_ < var_70_21 + var_70_22 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play321232017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321232017
		arg_73_1.duration_ = 3.37

		local var_73_0 = {
			zh = 3.233,
			ja = 3.366
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
				arg_73_0:Play321232018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.2

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[37].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(321232017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 8
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232017", "story_v_out_321232.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_321232", "321232017", "story_v_out_321232.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_321232", "321232017", "story_v_out_321232.awb")

						arg_73_1:RecordAudio("321232017", var_76_9)
						arg_73_1:RecordAudio("321232017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_321232", "321232017", "story_v_out_321232.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_321232", "321232017", "story_v_out_321232.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play321232018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321232018
		arg_77_1.duration_ = 7.83

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play321232019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				local var_80_1 = manager.ui.mainCamera.transform.localPosition
				local var_80_2 = Vector3.New(0, 0, 10) + Vector3.New(var_80_1.x, var_80_1.y, 0)
				local var_80_3 = arg_77_1.bgs_.STblack

				var_80_3.transform.localPosition = var_80_2
				var_80_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_80_4 = var_80_3:GetComponent("SpriteRenderer")

				if var_80_4 and var_80_4.sprite then
					local var_80_5 = (var_80_3.transform.localPosition - var_80_1).z
					local var_80_6 = manager.ui.mainCameraCom_
					local var_80_7 = 2 * var_80_5 * Mathf.Tan(var_80_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_80_8 = var_80_7 * var_80_6.aspect
					local var_80_9 = var_80_4.sprite.bounds.size.x
					local var_80_10 = var_80_4.sprite.bounds.size.y
					local var_80_11 = var_80_8 / var_80_9
					local var_80_12 = var_80_7 / var_80_10
					local var_80_13 = var_80_12 < var_80_11 and var_80_11 or var_80_12

					var_80_3.transform.localScale = Vector3.New(var_80_13, var_80_13, 0)
				end

				for iter_80_0, iter_80_1 in pairs(arg_77_1.bgs_) do
					if iter_80_0 ~= "STblack" then
						iter_80_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_80_14 = arg_77_1.actors_["1011ui_story"]
			local var_80_15 = 2

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect1011ui_story == nil then
				arg_77_1.var_.characterEffect1011ui_story = var_80_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_16 = 0.200000002980232

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_16 and not isNil(var_80_14) then
				local var_80_17 = (arg_77_1.time_ - var_80_15) / var_80_16

				if arg_77_1.var_.characterEffect1011ui_story and not isNil(var_80_14) then
					local var_80_18 = Mathf.Lerp(0, 0.5, var_80_17)

					arg_77_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1011ui_story.fillRatio = var_80_18
				end
			end

			if arg_77_1.time_ >= var_80_15 + var_80_16 and arg_77_1.time_ < var_80_15 + var_80_16 + arg_80_0 and not isNil(var_80_14) and arg_77_1.var_.characterEffect1011ui_story then
				local var_80_19 = 0.5

				arg_77_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1011ui_story.fillRatio = var_80_19
			end

			local var_80_20 = manager.ui.mainCamera.transform
			local var_80_21 = 1.7

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				local var_80_22 = arg_77_1.var_.effectmengbai1
				local var_80_23
				local var_80_24 = var_80_20

				if not var_80_22 then
					var_80_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_out"), var_80_24)
					var_80_22.name = "mengbai1"
					arg_77_1.var_.effectmengbai1 = var_80_22
				else
					var_80_22.transform:SetParent(var_80_24)
				end

				var_80_22.transform.localPosition = Vector3.New(0, 0, -2.6)
				var_80_22.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_80_25 = manager.ui.mainCameraCom_
				local var_80_26 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_80_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_80_27 = var_80_22.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_80_28 = 15
				local var_80_29 = 2 * var_80_28 * Mathf.Tan(var_80_25.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_80_25.aspect
				local var_80_30 = 1
				local var_80_31 = 1.7777777777777777

				if var_80_31 < var_80_25.aspect then
					var_80_30 = var_80_29 / (2 * var_80_28 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_80_31)
				end

				for iter_80_2, iter_80_3 in ipairs(var_80_27) do
					local var_80_32 = iter_80_3.transform.localScale

					iter_80_3.transform.localScale = Vector3.New(var_80_32.x / var_80_26 * var_80_30, var_80_32.y / var_80_26, var_80_32.z)
				end
			end

			local var_80_33 = manager.ui.mainCamera.transform
			local var_80_34 = 4.13333333333333

			if var_80_34 < arg_77_1.time_ and arg_77_1.time_ <= var_80_34 + arg_80_0 then
				local var_80_35 = arg_77_1.var_.effectmengbai1

				if var_80_35 then
					Object.Destroy(var_80_35)

					arg_77_1.var_.effectmengbai1 = nil
				end
			end

			local var_80_36 = 0

			if var_80_36 < arg_77_1.time_ and arg_77_1.time_ <= var_80_36 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_37 = 1

			if var_80_36 <= arg_77_1.time_ and arg_77_1.time_ < var_80_36 + var_80_37 then
				local var_80_38 = (arg_77_1.time_ - var_80_36) / var_80_37
				local var_80_39 = Color.New(1, 1, 1)

				var_80_39.a = Mathf.Lerp(0, 1, var_80_38)
				arg_77_1.mask_.color = var_80_39
			end

			if arg_77_1.time_ >= var_80_36 + var_80_37 and arg_77_1.time_ < var_80_36 + var_80_37 + arg_80_0 then
				local var_80_40 = Color.New(1, 1, 1)

				var_80_40.a = 1
				arg_77_1.mask_.color = var_80_40
			end

			local var_80_41 = 1

			if var_80_41 < arg_77_1.time_ and arg_77_1.time_ <= var_80_41 + arg_80_0 then
				arg_77_1.mask_.enabled = true
				arg_77_1.mask_.raycastTarget = true

				arg_77_1:SetGaussion(false)
			end

			local var_80_42 = 1

			if var_80_41 <= arg_77_1.time_ and arg_77_1.time_ < var_80_41 + var_80_42 then
				local var_80_43 = (arg_77_1.time_ - var_80_41) / var_80_42
				local var_80_44 = Color.New(1, 1, 1)

				var_80_44.a = Mathf.Lerp(1, 0, var_80_43)
				arg_77_1.mask_.color = var_80_44
			end

			if arg_77_1.time_ >= var_80_41 + var_80_42 and arg_77_1.time_ < var_80_41 + var_80_42 + arg_80_0 then
				local var_80_45 = Color.New(1, 1, 1)
				local var_80_46 = 0

				arg_77_1.mask_.enabled = false
				var_80_45.a = var_80_46
				arg_77_1.mask_.color = var_80_45
			end

			local var_80_47 = 1

			if var_80_47 < arg_77_1.time_ and arg_77_1.time_ <= var_80_47 + arg_80_0 then
				arg_77_1.cswbg_:SetActive(false)
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_48 = 2.83333333333333
			local var_80_49 = 0.6

			if var_80_48 < arg_77_1.time_ and arg_77_1.time_ <= var_80_48 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_50 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_50:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_51 = arg_77_1:GetWordFromCfg(321232018)
				local var_80_52 = arg_77_1:FormatText(var_80_51.content)

				arg_77_1.text_.text = var_80_52

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_53 = 24
				local var_80_54 = utf8.len(var_80_52)
				local var_80_55 = var_80_53 <= 0 and var_80_49 or var_80_49 * (var_80_54 / var_80_53)

				if var_80_55 > 0 and var_80_49 < var_80_55 then
					arg_77_1.talkMaxDuration = var_80_55
					var_80_48 = var_80_48 + 0.3

					if var_80_55 + var_80_48 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_55 + var_80_48
					end
				end

				arg_77_1.text_.text = var_80_52
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_56 = var_80_48 + 0.3
			local var_80_57 = math.max(var_80_49, arg_77_1.talkMaxDuration)

			if var_80_56 <= arg_77_1.time_ and arg_77_1.time_ < var_80_56 + var_80_57 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_56) / var_80_57

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_56 + var_80_57 and arg_77_1.time_ < var_80_56 + var_80_57 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321232019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321232019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321232020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.85

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(321232019)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 34
				local var_86_5 = utf8.len(var_86_3)
				local var_86_6 = var_86_4 <= 0 and var_86_1 or var_86_1 * (var_86_5 / var_86_4)

				if var_86_6 > 0 and var_86_1 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_7 and arg_83_1.time_ < var_86_0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play321232020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321232020
		arg_87_1.duration_ = 9.4

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321232021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "MS2108"

			if arg_87_1.bgs_[var_90_0] == nil then
				local var_90_1 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_90_0)
				var_90_1.name = var_90_0
				var_90_1.transform.parent = arg_87_1.stage_.transform
				var_90_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_[var_90_0] = var_90_1
			end

			local var_90_2 = 2

			if var_90_2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				local var_90_3 = manager.ui.mainCamera.transform.localPosition
				local var_90_4 = Vector3.New(0, 0, 10) + Vector3.New(var_90_3.x, var_90_3.y, 0)
				local var_90_5 = arg_87_1.bgs_.MS2108

				var_90_5.transform.localPosition = var_90_4
				var_90_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_6 = var_90_5:GetComponent("SpriteRenderer")

				if var_90_6 and var_90_6.sprite then
					local var_90_7 = (var_90_5.transform.localPosition - var_90_3).z
					local var_90_8 = manager.ui.mainCameraCom_
					local var_90_9 = 2 * var_90_7 * Mathf.Tan(var_90_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_90_10 = var_90_9 * var_90_8.aspect
					local var_90_11 = var_90_6.sprite.bounds.size.x
					local var_90_12 = var_90_6.sprite.bounds.size.y
					local var_90_13 = var_90_10 / var_90_11
					local var_90_14 = var_90_9 / var_90_12
					local var_90_15 = var_90_14 < var_90_13 and var_90_13 or var_90_14

					var_90_5.transform.localScale = Vector3.New(var_90_15, var_90_15, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "MS2108" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_16 = 3.53333333333333

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			local var_90_17 = 0.3

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			local var_90_18 = 0

			if var_90_18 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_19 = 2

			if var_90_18 <= arg_87_1.time_ and arg_87_1.time_ < var_90_18 + var_90_19 then
				local var_90_20 = (arg_87_1.time_ - var_90_18) / var_90_19
				local var_90_21 = Color.New(1, 1, 1)

				var_90_21.a = Mathf.Lerp(0, 1, var_90_20)
				arg_87_1.mask_.color = var_90_21
			end

			if arg_87_1.time_ >= var_90_18 + var_90_19 and arg_87_1.time_ < var_90_18 + var_90_19 + arg_90_0 then
				local var_90_22 = Color.New(1, 1, 1)

				var_90_22.a = 1
				arg_87_1.mask_.color = var_90_22
			end

			local var_90_23 = 2

			if var_90_23 < arg_87_1.time_ and arg_87_1.time_ <= var_90_23 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_24 = 1.53333333333333

			if var_90_23 <= arg_87_1.time_ and arg_87_1.time_ < var_90_23 + var_90_24 then
				local var_90_25 = (arg_87_1.time_ - var_90_23) / var_90_24
				local var_90_26 = Color.New(1, 1, 1)

				var_90_26.a = Mathf.Lerp(1, 0, var_90_25)
				arg_87_1.mask_.color = var_90_26
			end

			if arg_87_1.time_ >= var_90_23 + var_90_24 and arg_87_1.time_ < var_90_23 + var_90_24 + arg_90_0 then
				local var_90_27 = Color.New(1, 1, 1)
				local var_90_28 = 0

				arg_87_1.mask_.enabled = false
				var_90_27.a = var_90_28
				arg_87_1.mask_.color = var_90_27
			end

			local var_90_29 = arg_87_1.bgs_.MS2108.transform
			local var_90_30 = 2

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 then
				arg_87_1.var_.moveOldPosMS2108 = var_90_29.localPosition
			end

			local var_90_31 = 0.001

			if var_90_30 <= arg_87_1.time_ and arg_87_1.time_ < var_90_30 + var_90_31 then
				local var_90_32 = (arg_87_1.time_ - var_90_30) / var_90_31
				local var_90_33 = Vector3.New(0, 2, 0)

				var_90_29.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPosMS2108, var_90_33, var_90_32)
			end

			if arg_87_1.time_ >= var_90_30 + var_90_31 and arg_87_1.time_ < var_90_30 + var_90_31 + arg_90_0 then
				var_90_29.localPosition = Vector3.New(0, 2, 0)
			end

			local var_90_34 = arg_87_1.bgs_.MS2108.transform
			local var_90_35 = 2.01666666666667

			if var_90_35 < arg_87_1.time_ and arg_87_1.time_ <= var_90_35 + arg_90_0 then
				arg_87_1.var_.moveOldPosMS2108 = var_90_34.localPosition
			end

			local var_90_36 = 4.5

			if var_90_35 <= arg_87_1.time_ and arg_87_1.time_ < var_90_35 + var_90_36 then
				local var_90_37 = (arg_87_1.time_ - var_90_35) / var_90_36
				local var_90_38 = Vector3.New(0, 1.5, 3)

				var_90_34.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPosMS2108, var_90_38, var_90_37)
			end

			if arg_87_1.time_ >= var_90_35 + var_90_36 and arg_87_1.time_ < var_90_35 + var_90_36 + arg_90_0 then
				var_90_34.localPosition = Vector3.New(0, 1.5, 3)
			end

			local var_90_39 = 2

			if var_90_39 < arg_87_1.time_ and arg_87_1.time_ <= var_90_39 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			local var_90_40 = 4.6

			if arg_87_1.time_ >= var_90_39 + var_90_40 and arg_87_1.time_ < var_90_39 + var_90_40 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			local var_90_41 = manager.ui.mainCamera.transform
			local var_90_42 = 2.01666666666667

			if var_90_42 < arg_87_1.time_ and arg_87_1.time_ <= var_90_42 + arg_90_0 then
				local var_90_43 = arg_87_1.var_.effectheian1
				local var_90_44
				local var_90_45 = var_90_41

				if not var_90_43 then
					var_90_43 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy_ui"), var_90_45)
					var_90_43.name = "heian1"
					arg_87_1.var_.effectheian1 = var_90_43
				else
					var_90_43.transform:SetParent(var_90_45)
				end

				var_90_43.transform.localPosition = Vector3.New(0, 0, 0)
				var_90_43.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_90_46 = manager.ui.mainCameraCom_
				local var_90_47 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_90_46.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_90_48 = var_90_43.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_90_49 = 15
				local var_90_50 = 2 * var_90_49 * Mathf.Tan(var_90_46.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_90_46.aspect
				local var_90_51 = 1
				local var_90_52 = 1.7777777777777777

				if var_90_52 < var_90_46.aspect then
					var_90_51 = var_90_50 / (2 * var_90_49 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_90_52)
				end

				for iter_90_2, iter_90_3 in ipairs(var_90_48) do
					local var_90_53 = iter_90_3.transform.localScale

					iter_90_3.transform.localScale = Vector3.New(var_90_53.x / var_90_47 * var_90_51, var_90_53.y / var_90_47, var_90_53.z)
				end
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_54 = 4.4
			local var_90_55 = 1.5

			if var_90_54 < arg_87_1.time_ and arg_87_1.time_ <= var_90_54 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_56 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_56:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_57 = arg_87_1:GetWordFromCfg(321232020)
				local var_90_58 = arg_87_1:FormatText(var_90_57.content)

				arg_87_1.text_.text = var_90_58

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_59 = 60
				local var_90_60 = utf8.len(var_90_58)
				local var_90_61 = var_90_59 <= 0 and var_90_55 or var_90_55 * (var_90_60 / var_90_59)

				if var_90_61 > 0 and var_90_55 < var_90_61 then
					arg_87_1.talkMaxDuration = var_90_61
					var_90_54 = var_90_54 + 0.3

					if var_90_61 + var_90_54 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_61 + var_90_54
					end
				end

				arg_87_1.text_.text = var_90_58
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_62 = var_90_54 + 0.3
			local var_90_63 = math.max(var_90_55, arg_87_1.talkMaxDuration)

			if var_90_62 <= arg_87_1.time_ and arg_87_1.time_ < var_90_62 + var_90_63 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_62) / var_90_63

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_62 + var_90_63 and arg_87_1.time_ < var_90_62 + var_90_63 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play321232021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321232021
		arg_93_1.duration_ = 2.5

		local var_93_0 = {
			zh = 2.2,
			ja = 2.5
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
				arg_93_0:Play321232022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1011ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1011ui_story == nil then
				arg_93_1.var_.characterEffect1011ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1011ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1011ui_story then
				arg_93_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			local var_96_5 = 0.733333333333333

			if arg_93_1.time_ >= var_96_4 + var_96_5 and arg_93_1.time_ < var_96_4 + var_96_5 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_6 = 0
			local var_96_7 = 0.2

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[37].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_9 = arg_93_1:GetWordFromCfg(321232021)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 8
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232021", "story_v_out_321232.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_321232", "321232021", "story_v_out_321232.awb") / 1000

					if var_96_14 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_6
					end

					if var_96_9.prefab_name ~= "" and arg_93_1.actors_[var_96_9.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_9.prefab_name].transform, "story_v_out_321232", "321232021", "story_v_out_321232.awb")

						arg_93_1:RecordAudio("321232021", var_96_15)
						arg_93_1:RecordAudio("321232021", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_321232", "321232021", "story_v_out_321232.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_321232", "321232021", "story_v_out_321232.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_16 and arg_93_1.time_ < var_96_6 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play321232022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321232022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play321232023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1011ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1011ui_story == nil then
				arg_97_1.var_.characterEffect1011ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1011ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1011ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1011ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1011ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 1.15

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(321232022)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 46
				local var_100_11 = utf8.len(var_100_9)
				local var_100_12 = var_100_10 <= 0 and var_100_7 or var_100_7 * (var_100_11 / var_100_10)

				if var_100_12 > 0 and var_100_7 < var_100_12 then
					arg_97_1.talkMaxDuration = var_100_12

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_13 and arg_97_1.time_ < var_100_6 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play321232023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321232023
		arg_101_1.duration_ = 1.97

		local var_101_0 = {
			zh = 1.966,
			ja = 1.033
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
				arg_101_0:Play321232024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1011ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1011ui_story == nil then
				arg_101_1.var_.characterEffect1011ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1011ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1011ui_story then
				arg_101_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_104_4 = 0
			local var_104_5 = 0.1

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_6 = arg_101_1:FormatText(StoryNameCfg[37].name)

				arg_101_1.leftNameTxt_.text = var_104_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_7 = arg_101_1:GetWordFromCfg(321232023)
				local var_104_8 = arg_101_1:FormatText(var_104_7.content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 4
				local var_104_10 = utf8.len(var_104_8)
				local var_104_11 = var_104_9 <= 0 and var_104_5 or var_104_5 * (var_104_10 / var_104_9)

				if var_104_11 > 0 and var_104_5 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232023", "story_v_out_321232.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_321232", "321232023", "story_v_out_321232.awb") / 1000

					if var_104_12 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_4
					end

					if var_104_7.prefab_name ~= "" and arg_101_1.actors_[var_104_7.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_7.prefab_name].transform, "story_v_out_321232", "321232023", "story_v_out_321232.awb")

						arg_101_1:RecordAudio("321232023", var_104_13)
						arg_101_1:RecordAudio("321232023", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321232", "321232023", "story_v_out_321232.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321232", "321232023", "story_v_out_321232.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_14 and arg_101_1.time_ < var_104_4 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play321232024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321232024
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play321232025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1011ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1011ui_story == nil then
				arg_105_1.var_.characterEffect1011ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1011ui_story and not isNil(var_108_0) then
					local var_108_4 = Mathf.Lerp(0, 0.5, var_108_3)

					arg_105_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1011ui_story.fillRatio = var_108_4
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1011ui_story then
				local var_108_5 = 0.5

				arg_105_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1011ui_story.fillRatio = var_108_5
			end

			local var_108_6 = 0
			local var_108_7 = 1.1

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(321232024)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 44
				local var_108_11 = utf8.len(var_108_9)
				local var_108_12 = var_108_10 <= 0 and var_108_7 or var_108_7 * (var_108_11 / var_108_10)

				if var_108_12 > 0 and var_108_7 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_13 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_13

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_13 and arg_105_1.time_ < var_108_6 + var_108_13 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play321232025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321232025
		arg_109_1.duration_ = 7.13

		local var_109_0 = {
			zh = 7.133,
			ja = 6.466
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321232026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1011ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1011ui_story == nil then
				arg_109_1.var_.characterEffect1011ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1011ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1011ui_story then
				arg_109_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_112_4 = 0
			local var_112_5 = 0.575

			if var_112_4 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_6 = arg_109_1:FormatText(StoryNameCfg[37].name)

				arg_109_1.leftNameTxt_.text = var_112_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(321232025)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 23
				local var_112_10 = utf8.len(var_112_8)
				local var_112_11 = var_112_9 <= 0 and var_112_5 or var_112_5 * (var_112_10 / var_112_9)

				if var_112_11 > 0 and var_112_5 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232025", "story_v_out_321232.awb") ~= 0 then
					local var_112_12 = manager.audio:GetVoiceLength("story_v_out_321232", "321232025", "story_v_out_321232.awb") / 1000

					if var_112_12 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_4
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_321232", "321232025", "story_v_out_321232.awb")

						arg_109_1:RecordAudio("321232025", var_112_13)
						arg_109_1:RecordAudio("321232025", var_112_13)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_321232", "321232025", "story_v_out_321232.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_321232", "321232025", "story_v_out_321232.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_14 and arg_109_1.time_ < var_112_4 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play321232026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321232026
		arg_113_1.duration_ = 9.4

		local var_113_0 = {
			zh = 9.4,
			ja = 6.2
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
				arg_113_0:Play321232027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.625

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[37].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(321232026)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 25
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232026", "story_v_out_321232.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_321232", "321232026", "story_v_out_321232.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_321232", "321232026", "story_v_out_321232.awb")

						arg_113_1:RecordAudio("321232026", var_116_9)
						arg_113_1:RecordAudio("321232026", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_321232", "321232026", "story_v_out_321232.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_321232", "321232026", "story_v_out_321232.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play321232027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321232027
		arg_117_1.duration_ = 7.3

		local var_117_0 = {
			zh = 7.29966666666667,
			ja = 4.69966666666667
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
				arg_117_0:Play321232028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.5

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				local var_120_1 = manager.ui.mainCamera.transform.localPosition
				local var_120_2 = Vector3.New(0, 0, 10) + Vector3.New(var_120_1.x, var_120_1.y, 0)
				local var_120_3 = arg_117_1.bgs_.STblack

				var_120_3.transform.localPosition = var_120_2
				var_120_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_4 = var_120_3:GetComponent("SpriteRenderer")

				if var_120_4 and var_120_4.sprite then
					local var_120_5 = (var_120_3.transform.localPosition - var_120_1).z
					local var_120_6 = manager.ui.mainCameraCom_
					local var_120_7 = 2 * var_120_5 * Mathf.Tan(var_120_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_120_8 = var_120_7 * var_120_6.aspect
					local var_120_9 = var_120_4.sprite.bounds.size.x
					local var_120_10 = var_120_4.sprite.bounds.size.y
					local var_120_11 = var_120_8 / var_120_9
					local var_120_12 = var_120_7 / var_120_10
					local var_120_13 = var_120_12 < var_120_11 and var_120_11 or var_120_12

					var_120_3.transform.localScale = Vector3.New(var_120_13, var_120_13, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "STblack" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_14 = 3.2

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			local var_120_15 = 0.3

			if arg_117_1.time_ >= var_120_14 + var_120_15 and arg_117_1.time_ < var_120_14 + var_120_15 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_17 = 1.5

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17
				local var_120_19 = Color.New(0, 0, 0)

				var_120_19.a = Mathf.Lerp(0, 1, var_120_18)
				arg_117_1.mask_.color = var_120_19
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 then
				local var_120_20 = Color.New(0, 0, 0)

				var_120_20.a = 1
				arg_117_1.mask_.color = var_120_20
			end

			local var_120_21 = 1.5

			if var_120_21 < arg_117_1.time_ and arg_117_1.time_ <= var_120_21 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_22 = 1.86666666666667

			if var_120_21 <= arg_117_1.time_ and arg_117_1.time_ < var_120_21 + var_120_22 then
				local var_120_23 = (arg_117_1.time_ - var_120_21) / var_120_22
				local var_120_24 = Color.New(0, 0, 0)

				var_120_24.a = Mathf.Lerp(1, 0, var_120_23)
				arg_117_1.mask_.color = var_120_24
			end

			if arg_117_1.time_ >= var_120_21 + var_120_22 and arg_117_1.time_ < var_120_21 + var_120_22 + arg_120_0 then
				local var_120_25 = Color.New(0, 0, 0)
				local var_120_26 = 0

				arg_117_1.mask_.enabled = false
				var_120_25.a = var_120_26
				arg_117_1.mask_.color = var_120_25
			end

			local var_120_27 = manager.ui.mainCamera.transform
			local var_120_28 = 1.5

			if var_120_28 < arg_117_1.time_ and arg_117_1.time_ <= var_120_28 + arg_120_0 then
				local var_120_29 = arg_117_1.var_.effectheian1

				if var_120_29 then
					Object.Destroy(var_120_29)

					arg_117_1.var_.effectheian1 = nil
				end
			end

			local var_120_30 = 1.499999999999

			if var_120_30 < arg_117_1.time_ and arg_117_1.time_ <= var_120_30 + arg_120_0 then
				arg_117_1.cswbg_:SetActive(true)

				local var_120_31 = arg_117_1.cswt_:GetComponent("RectTransform")

				arg_117_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_120_31.offsetMin = Vector2.New(0, 0)
				var_120_31.offsetMax = Vector2.New(0, 0)

				local var_120_32 = arg_117_1:GetWordFromCfg(419137)
				local var_120_33 = arg_117_1:FormatText(var_120_32.content)

				arg_117_1.cswt_.text = var_120_33

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.cswt_)

				arg_117_1.cswt_.fontSize = 120
				arg_117_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_117_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_117_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_34 = 3.16666666666667
			local var_120_35 = 0.2

			if var_120_34 < arg_117_1.time_ and arg_117_1.time_ <= var_120_34 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_36 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_36:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_37 = arg_117_1:FormatText(StoryNameCfg[37].name)

				arg_117_1.leftNameTxt_.text = var_120_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_38 = arg_117_1:GetWordFromCfg(321232027)
				local var_120_39 = arg_117_1:FormatText(var_120_38.content)

				arg_117_1.text_.text = var_120_39

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_40 = 8
				local var_120_41 = utf8.len(var_120_39)
				local var_120_42 = var_120_40 <= 0 and var_120_35 or var_120_35 * (var_120_41 / var_120_40)

				if var_120_42 > 0 and var_120_35 < var_120_42 then
					arg_117_1.talkMaxDuration = var_120_42
					var_120_34 = var_120_34 + 0.3

					if var_120_42 + var_120_34 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_42 + var_120_34
					end
				end

				arg_117_1.text_.text = var_120_39
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232027", "story_v_out_321232.awb") ~= 0 then
					local var_120_43 = manager.audio:GetVoiceLength("story_v_out_321232", "321232027", "story_v_out_321232.awb") / 1000

					if var_120_43 + var_120_34 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_43 + var_120_34
					end

					if var_120_38.prefab_name ~= "" and arg_117_1.actors_[var_120_38.prefab_name] ~= nil then
						local var_120_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_38.prefab_name].transform, "story_v_out_321232", "321232027", "story_v_out_321232.awb")

						arg_117_1:RecordAudio("321232027", var_120_44)
						arg_117_1:RecordAudio("321232027", var_120_44)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321232", "321232027", "story_v_out_321232.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321232", "321232027", "story_v_out_321232.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_45 = var_120_34 + 0.3
			local var_120_46 = math.max(var_120_35, arg_117_1.talkMaxDuration)

			if var_120_45 <= arg_117_1.time_ and arg_117_1.time_ < var_120_45 + var_120_46 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_45) / var_120_46

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_45 + var_120_46 and arg_117_1.time_ < var_120_45 + var_120_46 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play321232028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321232028
		arg_123_1.duration_ = 2.43

		local var_123_0 = {
			zh = 2.233,
			ja = 2.433
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
			arg_123_1.auto_ = false
		end

		function arg_123_1.playNext_(arg_125_0)
			arg_123_1.onStoryFinished_()
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.175

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[37].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(321232028)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 7
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321232", "321232028", "story_v_out_321232.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_321232", "321232028", "story_v_out_321232.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_321232", "321232028", "story_v_out_321232.awb")

						arg_123_1:RecordAudio("321232028", var_126_9)
						arg_123_1:RecordAudio("321232028", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321232", "321232028", "story_v_out_321232.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321232", "321232028", "story_v_out_321232.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/MS2108"
	},
	voices = {
		"story_v_out_321232.awb"
	}
}
