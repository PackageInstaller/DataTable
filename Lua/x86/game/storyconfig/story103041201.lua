return {
	Play304121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304121001
		arg_1_1.duration_ = 7.01

		local var_1_0 = {
			zh = 4.140999999999,
			ja = 7.007999999999
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
				arg_1_0:Play304121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B06c"

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
				local var_4_5 = arg_1_1.bgs_.B06c

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
					if iter_4_0 ~= "B06c" then
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

			local var_4_24 = "3009ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "3009ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["3009ui_story"]
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect3009ui_story == nil then
				arg_1_1.var_.characterEffect3009ui_story = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.200000002980232

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect3009ui_story and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect3009ui_story then
				arg_1_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_4_33 = 0.3
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "effect"

				arg_1_1:AudioAction(var_4_35, var_4_36, "se_story_122_03", "se_story_122_03_swordhit", "")
			end

			local var_4_37 = 0.2
			local var_4_38 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "effect"

				arg_1_1:AudioAction(var_4_39, var_4_40, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_4_41 = 1
			local var_4_42 = 1

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_46 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_46 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_46

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_46
						arg_1_1.bgmTxt2_.text = var_4_46
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

			local var_4_47 = 0
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "effect"

				arg_1_1:AudioAction(var_4_49, var_4_50, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_51 = 1.674999999999
			local var_4_52 = 0.325

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

				local var_4_54 = arg_1_1:FormatText(StoryNameCfg[43].name)

				arg_1_1.leftNameTxt_.text = var_4_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3009")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_55 = arg_1_1:GetWordFromCfg(304121001)
				local var_4_56 = arg_1_1:FormatText(var_4_55.content)

				arg_1_1.text_.text = var_4_56

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_57 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121001", "story_v_out_304121.awb") ~= 0 then
					local var_4_60 = manager.audio:GetVoiceLength("story_v_out_304121", "304121001", "story_v_out_304121.awb") / 1000

					if var_4_60 + var_4_51 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_51
					end

					if var_4_55.prefab_name ~= "" and arg_1_1.actors_[var_4_55.prefab_name] ~= nil then
						local var_4_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_55.prefab_name].transform, "story_v_out_304121", "304121001", "story_v_out_304121.awb")

						arg_1_1:RecordAudio("304121001", var_4_61)
						arg_1_1:RecordAudio("304121001", var_4_61)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304121", "304121001", "story_v_out_304121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304121", "304121001", "story_v_out_304121.awb")
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

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304121002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304121002
		arg_8_1.duration_ = 5.07

		local var_8_0 = {
			zh = 5.066,
			ja = 4.233
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
				arg_8_0:Play304121003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "3008ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["3008ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect3008ui_story == nil then
				arg_8_1.var_.characterEffect3008ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.200000002980232

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect3008ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect3008ui_story then
				arg_8_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["3009ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect3009ui_story == nil then
				arg_8_1.var_.characterEffect3009ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.200000002980232

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect3009ui_story and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_8_1.var_.characterEffect3009ui_story.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect3009ui_story then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_8_1.var_.characterEffect3009ui_story.fillRatio = var_11_14
			end

			local var_11_15 = 0
			local var_11_16 = 0.775

			if var_11_15 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_17 = arg_8_1:FormatText(StoryNameCfg[20].name)

				arg_8_1.leftNameTxt_.text = var_11_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_18 = arg_8_1:GetWordFromCfg(304121002)
				local var_11_19 = arg_8_1:FormatText(var_11_18.content)

				arg_8_1.text_.text = var_11_19

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_20 = 31
				local var_11_21 = utf8.len(var_11_19)
				local var_11_22 = var_11_20 <= 0 and var_11_16 or var_11_16 * (var_11_21 / var_11_20)

				if var_11_22 > 0 and var_11_16 < var_11_22 then
					arg_8_1.talkMaxDuration = var_11_22

					if var_11_22 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_22 + var_11_15
					end
				end

				arg_8_1.text_.text = var_11_19
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121002", "story_v_out_304121.awb") ~= 0 then
					local var_11_23 = manager.audio:GetVoiceLength("story_v_out_304121", "304121002", "story_v_out_304121.awb") / 1000

					if var_11_23 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_23 + var_11_15
					end

					if var_11_18.prefab_name ~= "" and arg_8_1.actors_[var_11_18.prefab_name] ~= nil then
						local var_11_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_18.prefab_name].transform, "story_v_out_304121", "304121002", "story_v_out_304121.awb")

						arg_8_1:RecordAudio("304121002", var_11_24)
						arg_8_1:RecordAudio("304121002", var_11_24)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_304121", "304121002", "story_v_out_304121.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_304121", "304121002", "story_v_out_304121.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_25 = math.max(var_11_16, arg_8_1.talkMaxDuration)

			if var_11_15 <= arg_8_1.time_ and arg_8_1.time_ < var_11_15 + var_11_25 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_15) / var_11_25

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_15 + var_11_25 and arg_8_1.time_ < var_11_15 + var_11_25 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play304121003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304121003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304121004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["3008ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect3008ui_story == nil then
				arg_12_1.var_.characterEffect3008ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect3008ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_12_1.var_.characterEffect3008ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect3008ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_12_1.var_.characterEffect3008ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 1.725

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:GetWordFromCfg(304121003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 69
				local var_15_11 = utf8.len(var_15_9)
				local var_15_12 = var_15_10 <= 0 and var_15_7 or var_15_7 * (var_15_11 / var_15_10)

				if var_15_12 > 0 and var_15_7 < var_15_12 then
					arg_12_1.talkMaxDuration = var_15_12

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_13 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_13 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_13

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_13 and arg_12_1.time_ < var_15_6 + var_15_13 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play304121004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304121004
		arg_16_1.duration_ = 3.6

		local var_16_0 = {
			zh = 2.566,
			ja = 3.6
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
				arg_16_0:Play304121005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1019ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1019ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_5.localPosition
			end

			local var_19_7 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7
				local var_19_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, var_19_9, var_19_8)

				local var_19_10 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_10.x, var_19_10.y, var_19_10.z)

				local var_19_11 = var_19_5.localEulerAngles

				var_19_11.z = 0
				var_19_11.x = 0
				var_19_5.localEulerAngles = var_19_11
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_5.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_5.localEulerAngles = var_19_13
			end

			local var_19_14 = arg_16_1.actors_["1019ui_story"]
			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_16 = 0.200000002980232

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_16 and not isNil(var_19_14) then
				local var_19_17 = (arg_16_1.time_ - var_19_15) / var_19_16

				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_14) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_15 + var_19_16 and arg_16_1.time_ < var_19_15 + var_19_16 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_20 = 0
			local var_19_21 = 0.3

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_22 = arg_16_1:FormatText(StoryNameCfg[13].name)

				arg_16_1.leftNameTxt_.text = var_19_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_23 = arg_16_1:GetWordFromCfg(304121004)
				local var_19_24 = arg_16_1:FormatText(var_19_23.content)

				arg_16_1.text_.text = var_19_24

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_25 = 12
				local var_19_26 = utf8.len(var_19_24)
				local var_19_27 = var_19_25 <= 0 and var_19_21 or var_19_21 * (var_19_26 / var_19_25)

				if var_19_27 > 0 and var_19_21 < var_19_27 then
					arg_16_1.talkMaxDuration = var_19_27

					if var_19_27 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_27 + var_19_20
					end
				end

				arg_16_1.text_.text = var_19_24
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121004", "story_v_out_304121.awb") ~= 0 then
					local var_19_28 = manager.audio:GetVoiceLength("story_v_out_304121", "304121004", "story_v_out_304121.awb") / 1000

					if var_19_28 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_20
					end

					if var_19_23.prefab_name ~= "" and arg_16_1.actors_[var_19_23.prefab_name] ~= nil then
						local var_19_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_23.prefab_name].transform, "story_v_out_304121", "304121004", "story_v_out_304121.awb")

						arg_16_1:RecordAudio("304121004", var_19_29)
						arg_16_1:RecordAudio("304121004", var_19_29)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304121", "304121004", "story_v_out_304121.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304121", "304121004", "story_v_out_304121.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_30 = math.max(var_19_21, arg_16_1.talkMaxDuration)

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_30 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_20) / var_19_30

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_20 + var_19_30 and arg_16_1.time_ < var_19_20 + var_19_30 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304121005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304121005
		arg_20_1.duration_ = 7.47

		local var_20_0 = {
			zh = 4.9,
			ja = 7.466
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
				arg_20_0:Play304121006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["3008ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos3008ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(-1.04, -1.51, -4.3)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3008ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(-1.04, -1.51, -4.3)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = arg_20_1.actors_["1019ui_story"].transform
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_9.localPosition
			end

			local var_23_11 = 0.001

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11
				local var_23_13 = Vector3.New(0, 100, 0)

				var_23_9.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, var_23_13, var_23_12)

				local var_23_14 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_14.x, var_23_14.y, var_23_14.z)

				local var_23_15 = var_23_9.localEulerAngles

				var_23_15.z = 0
				var_23_15.x = 0
				var_23_9.localEulerAngles = var_23_15
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 then
				var_23_9.localPosition = Vector3.New(0, 100, 0)

				local var_23_16 = manager.ui.mainCamera.transform.position - var_23_9.position

				var_23_9.forward = Vector3.New(var_23_16.x, var_23_16.y, var_23_16.z)

				local var_23_17 = var_23_9.localEulerAngles

				var_23_17.z = 0
				var_23_17.x = 0
				var_23_9.localEulerAngles = var_23_17
			end

			local var_23_18 = arg_20_1.actors_["3008ui_story"]
			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 and not isNil(var_23_18) and arg_20_1.var_.characterEffect3008ui_story == nil then
				arg_20_1.var_.characterEffect3008ui_story = var_23_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_20 = 0.200000002980232

			if var_23_19 <= arg_20_1.time_ and arg_20_1.time_ < var_23_19 + var_23_20 and not isNil(var_23_18) then
				local var_23_21 = (arg_20_1.time_ - var_23_19) / var_23_20

				if arg_20_1.var_.characterEffect3008ui_story and not isNil(var_23_18) then
					arg_20_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_19 + var_23_20 and arg_20_1.time_ < var_23_19 + var_23_20 + arg_23_0 and not isNil(var_23_18) and arg_20_1.var_.characterEffect3008ui_story then
				arg_20_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_23_22 = arg_20_1.actors_["1019ui_story"]
			local var_23_23 = 0

			if var_23_23 < arg_20_1.time_ and arg_20_1.time_ <= var_23_23 + arg_23_0 and not isNil(var_23_22) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_24 = 0.200000002980232

			if var_23_23 <= arg_20_1.time_ and arg_20_1.time_ < var_23_23 + var_23_24 and not isNil(var_23_22) then
				local var_23_25 = (arg_20_1.time_ - var_23_23) / var_23_24

				if arg_20_1.var_.characterEffect1019ui_story and not isNil(var_23_22) then
					local var_23_26 = Mathf.Lerp(0, 0.5, var_23_25)

					arg_20_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1019ui_story.fillRatio = var_23_26
				end
			end

			if arg_20_1.time_ >= var_23_23 + var_23_24 and arg_20_1.time_ < var_23_23 + var_23_24 + arg_23_0 and not isNil(var_23_22) and arg_20_1.var_.characterEffect1019ui_story then
				local var_23_27 = 0.5

				arg_20_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1019ui_story.fillRatio = var_23_27
			end

			local var_23_28 = 0

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 then
				arg_20_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_23_29 = 0

			if var_23_29 < arg_20_1.time_ and arg_20_1.time_ <= var_23_29 + arg_23_0 then
				arg_20_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_23_30 = 0
			local var_23_31 = 0.375

			if var_23_30 < arg_20_1.time_ and arg_20_1.time_ <= var_23_30 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_32 = arg_20_1:FormatText(StoryNameCfg[20].name)

				arg_20_1.leftNameTxt_.text = var_23_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_33 = arg_20_1:GetWordFromCfg(304121005)
				local var_23_34 = arg_20_1:FormatText(var_23_33.content)

				arg_20_1.text_.text = var_23_34

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_35 = 15
				local var_23_36 = utf8.len(var_23_34)
				local var_23_37 = var_23_35 <= 0 and var_23_31 or var_23_31 * (var_23_36 / var_23_35)

				if var_23_37 > 0 and var_23_31 < var_23_37 then
					arg_20_1.talkMaxDuration = var_23_37

					if var_23_37 + var_23_30 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_37 + var_23_30
					end
				end

				arg_20_1.text_.text = var_23_34
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121005", "story_v_out_304121.awb") ~= 0 then
					local var_23_38 = manager.audio:GetVoiceLength("story_v_out_304121", "304121005", "story_v_out_304121.awb") / 1000

					if var_23_38 + var_23_30 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_38 + var_23_30
					end

					if var_23_33.prefab_name ~= "" and arg_20_1.actors_[var_23_33.prefab_name] ~= nil then
						local var_23_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_33.prefab_name].transform, "story_v_out_304121", "304121005", "story_v_out_304121.awb")

						arg_20_1:RecordAudio("304121005", var_23_39)
						arg_20_1:RecordAudio("304121005", var_23_39)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304121", "304121005", "story_v_out_304121.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304121", "304121005", "story_v_out_304121.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_40 = math.max(var_23_31, arg_20_1.talkMaxDuration)

			if var_23_30 <= arg_20_1.time_ and arg_20_1.time_ < var_23_30 + var_23_40 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_30) / var_23_40

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_30 + var_23_40 and arg_20_1.time_ < var_23_30 + var_23_40 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play304121006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304121006
		arg_24_1.duration_ = 7.27

		local var_24_0 = {
			zh = 3.8,
			ja = 7.266
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
				arg_24_0:Play304121007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "4010ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["4010ui_story"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos4010ui_story = var_27_5.localPosition
			end

			local var_27_7 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_7 then
				local var_27_8 = (arg_24_1.time_ - var_27_6) / var_27_7
				local var_27_9 = Vector3.New(0.7, -1.59, -5.2)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos4010ui_story, var_27_9, var_27_8)

				local var_27_10 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_10.x, var_27_10.y, var_27_10.z)

				local var_27_11 = var_27_5.localEulerAngles

				var_27_11.z = 0
				var_27_11.x = 0
				var_27_5.localEulerAngles = var_27_11
			end

			if arg_24_1.time_ >= var_27_6 + var_27_7 and arg_24_1.time_ < var_27_6 + var_27_7 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_27_12 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_12.x, var_27_12.y, var_27_12.z)

				local var_27_13 = var_27_5.localEulerAngles

				var_27_13.z = 0
				var_27_13.x = 0
				var_27_5.localEulerAngles = var_27_13
			end

			local var_27_14 = arg_24_1.actors_["4010ui_story"]
			local var_27_15 = 0

			if var_27_15 < arg_24_1.time_ and arg_24_1.time_ <= var_27_15 + arg_27_0 and not isNil(var_27_14) and arg_24_1.var_.characterEffect4010ui_story == nil then
				arg_24_1.var_.characterEffect4010ui_story = var_27_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_16 = 0.200000002980232

			if var_27_15 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_16 and not isNil(var_27_14) then
				local var_27_17 = (arg_24_1.time_ - var_27_15) / var_27_16

				if arg_24_1.var_.characterEffect4010ui_story and not isNil(var_27_14) then
					arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_15 + var_27_16 and arg_24_1.time_ < var_27_15 + var_27_16 + arg_27_0 and not isNil(var_27_14) and arg_24_1.var_.characterEffect4010ui_story then
				arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_27_18 = arg_24_1.actors_["3008ui_story"]
			local var_27_19 = 0

			if var_27_19 < arg_24_1.time_ and arg_24_1.time_ <= var_27_19 + arg_27_0 and not isNil(var_27_18) and arg_24_1.var_.characterEffect3008ui_story == nil then
				arg_24_1.var_.characterEffect3008ui_story = var_27_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_20 = 0.200000002980232

			if var_27_19 <= arg_24_1.time_ and arg_24_1.time_ < var_27_19 + var_27_20 and not isNil(var_27_18) then
				local var_27_21 = (arg_24_1.time_ - var_27_19) / var_27_20

				if arg_24_1.var_.characterEffect3008ui_story and not isNil(var_27_18) then
					local var_27_22 = Mathf.Lerp(0, 0.5, var_27_21)

					arg_24_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_24_1.var_.characterEffect3008ui_story.fillRatio = var_27_22
				end
			end

			if arg_24_1.time_ >= var_27_19 + var_27_20 and arg_24_1.time_ < var_27_19 + var_27_20 + arg_27_0 and not isNil(var_27_18) and arg_24_1.var_.characterEffect3008ui_story then
				local var_27_23 = 0.5

				arg_24_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_24_1.var_.characterEffect3008ui_story.fillRatio = var_27_23
			end

			local var_27_24 = 0

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 then
				arg_24_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_27_25 = 0

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_26 = 0
			local var_27_27 = 0.425

			if var_27_26 < arg_24_1.time_ and arg_24_1.time_ <= var_27_26 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_28 = arg_24_1:FormatText(StoryNameCfg[42].name)

				arg_24_1.leftNameTxt_.text = var_27_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_29 = arg_24_1:GetWordFromCfg(304121006)
				local var_27_30 = arg_24_1:FormatText(var_27_29.content)

				arg_24_1.text_.text = var_27_30

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_31 = 17
				local var_27_32 = utf8.len(var_27_30)
				local var_27_33 = var_27_31 <= 0 and var_27_27 or var_27_27 * (var_27_32 / var_27_31)

				if var_27_33 > 0 and var_27_27 < var_27_33 then
					arg_24_1.talkMaxDuration = var_27_33

					if var_27_33 + var_27_26 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_33 + var_27_26
					end
				end

				arg_24_1.text_.text = var_27_30
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121006", "story_v_out_304121.awb") ~= 0 then
					local var_27_34 = manager.audio:GetVoiceLength("story_v_out_304121", "304121006", "story_v_out_304121.awb") / 1000

					if var_27_34 + var_27_26 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_34 + var_27_26
					end

					if var_27_29.prefab_name ~= "" and arg_24_1.actors_[var_27_29.prefab_name] ~= nil then
						local var_27_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_29.prefab_name].transform, "story_v_out_304121", "304121006", "story_v_out_304121.awb")

						arg_24_1:RecordAudio("304121006", var_27_35)
						arg_24_1:RecordAudio("304121006", var_27_35)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304121", "304121006", "story_v_out_304121.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304121", "304121006", "story_v_out_304121.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_36 = math.max(var_27_27, arg_24_1.talkMaxDuration)

			if var_27_26 <= arg_24_1.time_ and arg_24_1.time_ < var_27_26 + var_27_36 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_26) / var_27_36

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_26 + var_27_36 and arg_24_1.time_ < var_27_26 + var_27_36 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play304121007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304121007
		arg_28_1.duration_ = 6.37

		local var_28_0 = {
			zh = 4,
			ja = 6.366
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
				arg_28_0:Play304121008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["3008ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect3008ui_story then
				arg_28_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["4010ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect4010ui_story == nil then
				arg_28_1.var_.characterEffect4010ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect4010ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_28_1.var_.characterEffect4010ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect4010ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_28_1.var_.characterEffect4010ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_2")
			end

			local var_31_11 = 0

			if var_31_11 < arg_28_1.time_ and arg_28_1.time_ <= var_31_11 + arg_31_0 then
				arg_28_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_31_12 = 0
			local var_31_13 = 0.525

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_14 = arg_28_1:FormatText(StoryNameCfg[20].name)

				arg_28_1.leftNameTxt_.text = var_31_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_15 = arg_28_1:GetWordFromCfg(304121007)
				local var_31_16 = arg_28_1:FormatText(var_31_15.content)

				arg_28_1.text_.text = var_31_16

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121007", "story_v_out_304121.awb") ~= 0 then
					local var_31_20 = manager.audio:GetVoiceLength("story_v_out_304121", "304121007", "story_v_out_304121.awb") / 1000

					if var_31_20 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_20 + var_31_12
					end

					if var_31_15.prefab_name ~= "" and arg_28_1.actors_[var_31_15.prefab_name] ~= nil then
						local var_31_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_15.prefab_name].transform, "story_v_out_304121", "304121007", "story_v_out_304121.awb")

						arg_28_1:RecordAudio("304121007", var_31_21)
						arg_28_1:RecordAudio("304121007", var_31_21)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304121", "304121007", "story_v_out_304121.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304121", "304121007", "story_v_out_304121.awb")
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
	Play304121008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304121008
		arg_32_1.duration_ = 9.3

		local var_32_0 = {
			zh = 6,
			ja = 9.3
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
				arg_32_0:Play304121009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["4010ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect4010ui_story == nil then
				arg_32_1.var_.characterEffect4010ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect4010ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect4010ui_story then
				arg_32_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["3008ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3008ui_story == nil then
				arg_32_1.var_.characterEffect3008ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect3008ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_32_1.var_.characterEffect3008ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect3008ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_32_1.var_.characterEffect3008ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_12 = 0
			local var_35_13 = 0.7

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_14 = arg_32_1:FormatText(StoryNameCfg[42].name)

				arg_32_1.leftNameTxt_.text = var_35_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_15 = arg_32_1:GetWordFromCfg(304121008)
				local var_35_16 = arg_32_1:FormatText(var_35_15.content)

				arg_32_1.text_.text = var_35_16

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121008", "story_v_out_304121.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_304121", "304121008", "story_v_out_304121.awb") / 1000

					if var_35_20 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_12
					end

					if var_35_15.prefab_name ~= "" and arg_32_1.actors_[var_35_15.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_15.prefab_name].transform, "story_v_out_304121", "304121008", "story_v_out_304121.awb")

						arg_32_1:RecordAudio("304121008", var_35_21)
						arg_32_1:RecordAudio("304121008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304121", "304121008", "story_v_out_304121.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304121", "304121008", "story_v_out_304121.awb")
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
	Play304121009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304121009
		arg_36_1.duration_ = 3.9

		local var_36_0 = {
			zh = 2.4,
			ja = 3.9
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
				arg_36_0:Play304121010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["3009ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect3009ui_story == nil then
				arg_36_1.var_.characterEffect3009ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect3009ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect3009ui_story then
				arg_36_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["4010ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect4010ui_story == nil then
				arg_36_1.var_.characterEffect4010ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect4010ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_36_1.var_.characterEffect4010ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect4010ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_36_1.var_.characterEffect4010ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0
			local var_39_11 = 0.225

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_12 = arg_36_1:FormatText(StoryNameCfg[43].name)

				arg_36_1.leftNameTxt_.text = var_39_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3009")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_13 = arg_36_1:GetWordFromCfg(304121009)
				local var_39_14 = arg_36_1:FormatText(var_39_13.content)

				arg_36_1.text_.text = var_39_14

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 9
				local var_39_16 = utf8.len(var_39_14)
				local var_39_17 = var_39_15 <= 0 and var_39_11 or var_39_11 * (var_39_16 / var_39_15)

				if var_39_17 > 0 and var_39_11 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_14
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121009", "story_v_out_304121.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_304121", "304121009", "story_v_out_304121.awb") / 1000

					if var_39_18 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_10
					end

					if var_39_13.prefab_name ~= "" and arg_36_1.actors_[var_39_13.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_13.prefab_name].transform, "story_v_out_304121", "304121009", "story_v_out_304121.awb")

						arg_36_1:RecordAudio("304121009", var_39_19)
						arg_36_1:RecordAudio("304121009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304121", "304121009", "story_v_out_304121.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304121", "304121009", "story_v_out_304121.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_20 and arg_36_1.time_ < var_39_10 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304121010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304121010
		arg_40_1.duration_ = 8.4

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play304121011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "S0204"

			if arg_40_1.bgs_[var_43_0] == nil then
				local var_43_1 = Object.Instantiate(arg_40_1.paintGo_)

				var_43_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_43_0)
				var_43_1.name = var_43_0
				var_43_1.transform.parent = arg_40_1.stage_.transform
				var_43_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.bgs_[var_43_0] = var_43_1
			end

			local var_43_2 = 1.999999999999

			if var_43_2 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				local var_43_3 = manager.ui.mainCamera.transform.localPosition
				local var_43_4 = Vector3.New(0, 0, 10) + Vector3.New(var_43_3.x, var_43_3.y, 0)
				local var_43_5 = arg_40_1.bgs_.S0204

				var_43_5.transform.localPosition = var_43_4
				var_43_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_43_6 = var_43_5:GetComponent("SpriteRenderer")

				if var_43_6 and var_43_6.sprite then
					local var_43_7 = (var_43_5.transform.localPosition - var_43_3).z
					local var_43_8 = manager.ui.mainCameraCom_
					local var_43_9 = 2 * var_43_7 * Mathf.Tan(var_43_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_43_10 = var_43_9 * var_43_8.aspect
					local var_43_11 = var_43_6.sprite.bounds.size.x
					local var_43_12 = var_43_6.sprite.bounds.size.y
					local var_43_13 = var_43_10 / var_43_11
					local var_43_14 = var_43_9 / var_43_12
					local var_43_15 = var_43_14 < var_43_13 and var_43_13 or var_43_14

					var_43_5.transform.localScale = Vector3.New(var_43_15, var_43_15, 0)
				end

				for iter_43_0, iter_43_1 in pairs(arg_40_1.bgs_) do
					if iter_43_0 ~= "S0204" then
						iter_43_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_43_16 = 1.999999999999

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			local var_43_17 = 0.3

			if arg_40_1.time_ >= var_43_16 + var_43_17 and arg_40_1.time_ < var_43_16 + var_43_17 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			local var_43_18 = 0

			if var_43_18 < arg_40_1.time_ and arg_40_1.time_ <= var_43_18 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_19 = 2

			if var_43_18 <= arg_40_1.time_ and arg_40_1.time_ < var_43_18 + var_43_19 then
				local var_43_20 = (arg_40_1.time_ - var_43_18) / var_43_19
				local var_43_21 = Color.New(0, 0, 0)

				var_43_21.a = Mathf.Lerp(0, 1, var_43_20)
				arg_40_1.mask_.color = var_43_21
			end

			if arg_40_1.time_ >= var_43_18 + var_43_19 and arg_40_1.time_ < var_43_18 + var_43_19 + arg_43_0 then
				local var_43_22 = Color.New(0, 0, 0)

				var_43_22.a = 1
				arg_40_1.mask_.color = var_43_22
			end

			local var_43_23 = 1.999999999999

			if var_43_23 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_24 = 2

			if var_43_23 <= arg_40_1.time_ and arg_40_1.time_ < var_43_23 + var_43_24 then
				local var_43_25 = (arg_40_1.time_ - var_43_23) / var_43_24
				local var_43_26 = Color.New(0, 0, 0)

				var_43_26.a = Mathf.Lerp(1, 0, var_43_25)
				arg_40_1.mask_.color = var_43_26
			end

			if arg_40_1.time_ >= var_43_23 + var_43_24 and arg_40_1.time_ < var_43_23 + var_43_24 + arg_43_0 then
				local var_43_27 = Color.New(0, 0, 0)
				local var_43_28 = 0

				arg_40_1.mask_.enabled = false
				var_43_27.a = var_43_28
				arg_40_1.mask_.color = var_43_27
			end

			local var_43_29 = arg_40_1.actors_["4010ui_story"].transform
			local var_43_30 = 1.999999999999

			if var_43_30 < arg_40_1.time_ and arg_40_1.time_ <= var_43_30 + arg_43_0 then
				arg_40_1.var_.moveOldPos4010ui_story = var_43_29.localPosition
			end

			local var_43_31 = 0.001

			if var_43_30 <= arg_40_1.time_ and arg_40_1.time_ < var_43_30 + var_43_31 then
				local var_43_32 = (arg_40_1.time_ - var_43_30) / var_43_31
				local var_43_33 = Vector3.New(0, 100, 0)

				var_43_29.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos4010ui_story, var_43_33, var_43_32)

				local var_43_34 = manager.ui.mainCamera.transform.position - var_43_29.position

				var_43_29.forward = Vector3.New(var_43_34.x, var_43_34.y, var_43_34.z)

				local var_43_35 = var_43_29.localEulerAngles

				var_43_35.z = 0
				var_43_35.x = 0
				var_43_29.localEulerAngles = var_43_35
			end

			if arg_40_1.time_ >= var_43_30 + var_43_31 and arg_40_1.time_ < var_43_30 + var_43_31 + arg_43_0 then
				var_43_29.localPosition = Vector3.New(0, 100, 0)

				local var_43_36 = manager.ui.mainCamera.transform.position - var_43_29.position

				var_43_29.forward = Vector3.New(var_43_36.x, var_43_36.y, var_43_36.z)

				local var_43_37 = var_43_29.localEulerAngles

				var_43_37.z = 0
				var_43_37.x = 0
				var_43_29.localEulerAngles = var_43_37
			end

			local var_43_38 = arg_40_1.actors_["3008ui_story"].transform
			local var_43_39 = 1.999999999999

			if var_43_39 < arg_40_1.time_ and arg_40_1.time_ <= var_43_39 + arg_43_0 then
				arg_40_1.var_.moveOldPos3008ui_story = var_43_38.localPosition
			end

			local var_43_40 = 0.001

			if var_43_39 <= arg_40_1.time_ and arg_40_1.time_ < var_43_39 + var_43_40 then
				local var_43_41 = (arg_40_1.time_ - var_43_39) / var_43_40
				local var_43_42 = Vector3.New(0, 100, 0)

				var_43_38.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos3008ui_story, var_43_42, var_43_41)

				local var_43_43 = manager.ui.mainCamera.transform.position - var_43_38.position

				var_43_38.forward = Vector3.New(var_43_43.x, var_43_43.y, var_43_43.z)

				local var_43_44 = var_43_38.localEulerAngles

				var_43_44.z = 0
				var_43_44.x = 0
				var_43_38.localEulerAngles = var_43_44
			end

			if arg_40_1.time_ >= var_43_39 + var_43_40 and arg_40_1.time_ < var_43_39 + var_43_40 + arg_43_0 then
				var_43_38.localPosition = Vector3.New(0, 100, 0)

				local var_43_45 = manager.ui.mainCamera.transform.position - var_43_38.position

				var_43_38.forward = Vector3.New(var_43_45.x, var_43_45.y, var_43_45.z)

				local var_43_46 = var_43_38.localEulerAngles

				var_43_46.z = 0
				var_43_46.x = 0
				var_43_38.localEulerAngles = var_43_46
			end

			local var_43_47 = arg_40_1.actors_["3009ui_story"]
			local var_43_48 = 1.999999999999

			if var_43_48 < arg_40_1.time_ and arg_40_1.time_ <= var_43_48 + arg_43_0 and not isNil(var_43_47) and arg_40_1.var_.characterEffect3009ui_story == nil then
				arg_40_1.var_.characterEffect3009ui_story = var_43_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_49 = 0.200000002980232

			if var_43_48 <= arg_40_1.time_ and arg_40_1.time_ < var_43_48 + var_43_49 and not isNil(var_43_47) then
				local var_43_50 = (arg_40_1.time_ - var_43_48) / var_43_49

				if arg_40_1.var_.characterEffect3009ui_story and not isNil(var_43_47) then
					local var_43_51 = Mathf.Lerp(0, 0.5, var_43_50)

					arg_40_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_40_1.var_.characterEffect3009ui_story.fillRatio = var_43_51
				end
			end

			if arg_40_1.time_ >= var_43_48 + var_43_49 and arg_40_1.time_ < var_43_48 + var_43_49 + arg_43_0 and not isNil(var_43_47) and arg_40_1.var_.characterEffect3009ui_story then
				local var_43_52 = 0.5

				arg_40_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_40_1.var_.characterEffect3009ui_story.fillRatio = var_43_52
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_53 = 3.4
			local var_43_54 = 0.8

			if var_43_53 < arg_40_1.time_ and arg_40_1.time_ <= var_43_53 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_55 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_55:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_56 = arg_40_1:GetWordFromCfg(304121010)
				local var_43_57 = arg_40_1:FormatText(var_43_56.content)

				arg_40_1.text_.text = var_43_57

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_58 = 32
				local var_43_59 = utf8.len(var_43_57)
				local var_43_60 = var_43_58 <= 0 and var_43_54 or var_43_54 * (var_43_59 / var_43_58)

				if var_43_60 > 0 and var_43_54 < var_43_60 then
					arg_40_1.talkMaxDuration = var_43_60
					var_43_53 = var_43_53 + 0.3

					if var_43_60 + var_43_53 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_60 + var_43_53
					end
				end

				arg_40_1.text_.text = var_43_57
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_61 = var_43_53 + 0.3
			local var_43_62 = math.max(var_43_54, arg_40_1.talkMaxDuration)

			if var_43_61 <= arg_40_1.time_ and arg_40_1.time_ < var_43_61 + var_43_62 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_61) / var_43_62

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_61 + var_43_62 and arg_40_1.time_ < var_43_61 + var_43_62 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play304121011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 304121011
		arg_46_1.duration_ = 11.87

		local var_46_0 = {
			zh = 10.166,
			ja = 11.866
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play304121012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["4010ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect4010ui_story == nil then
				arg_46_1.var_.characterEffect4010ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect4010ui_story and not isNil(var_49_0) then
					arg_46_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect4010ui_story then
				arg_46_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_49_4 = 0
			local var_49_5 = 1.15

			if var_49_4 < arg_46_1.time_ and arg_46_1.time_ <= var_49_4 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_6 = arg_46_1:FormatText(StoryNameCfg[42].name)

				arg_46_1.leftNameTxt_.text = var_49_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:GetWordFromCfg(304121011)
				local var_49_8 = arg_46_1:FormatText(var_49_7.content)

				arg_46_1.text_.text = var_49_8

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_9 = 46
				local var_49_10 = utf8.len(var_49_8)
				local var_49_11 = var_49_9 <= 0 and var_49_5 or var_49_5 * (var_49_10 / var_49_9)

				if var_49_11 > 0 and var_49_5 < var_49_11 then
					arg_46_1.talkMaxDuration = var_49_11

					if var_49_11 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_11 + var_49_4
					end
				end

				arg_46_1.text_.text = var_49_8
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121011", "story_v_out_304121.awb") ~= 0 then
					local var_49_12 = manager.audio:GetVoiceLength("story_v_out_304121", "304121011", "story_v_out_304121.awb") / 1000

					if var_49_12 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_4
					end

					if var_49_7.prefab_name ~= "" and arg_46_1.actors_[var_49_7.prefab_name] ~= nil then
						local var_49_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_7.prefab_name].transform, "story_v_out_304121", "304121011", "story_v_out_304121.awb")

						arg_46_1:RecordAudio("304121011", var_49_13)
						arg_46_1:RecordAudio("304121011", var_49_13)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_304121", "304121011", "story_v_out_304121.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_304121", "304121011", "story_v_out_304121.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_14 = math.max(var_49_5, arg_46_1.talkMaxDuration)

			if var_49_4 <= arg_46_1.time_ and arg_46_1.time_ < var_49_4 + var_49_14 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_4) / var_49_14

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_4 + var_49_14 and arg_46_1.time_ < var_49_4 + var_49_14 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play304121012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 304121012
		arg_50_1.duration_ = 1.5

		local var_50_0 = {
			zh = 1.5,
			ja = 1.466
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play304121013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.125

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[37].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011_split_5")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_3 = arg_50_1:GetWordFromCfg(304121012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 5
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121012", "story_v_out_304121.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_out_304121", "304121012", "story_v_out_304121.awb") / 1000

					if var_53_8 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_0
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_304121", "304121012", "story_v_out_304121.awb")

						arg_50_1:RecordAudio("304121012", var_53_9)
						arg_50_1:RecordAudio("304121012", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_304121", "304121012", "story_v_out_304121.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_304121", "304121012", "story_v_out_304121.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_10 and arg_50_1.time_ < var_53_0 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play304121013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 304121013
		arg_54_1.duration_ = 15.13

		local var_54_0 = {
			zh = 10.733,
			ja = 15.133
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
				arg_54_0:Play304121014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["4010ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect4010ui_story == nil then
				arg_54_1.var_.characterEffect4010ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect4010ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect4010ui_story then
				arg_54_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_57_4 = "1011ui_story"

			if arg_54_1.actors_[var_57_4] == nil then
				local var_57_5 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_57_5) then
					local var_57_6 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_54_1.stage_.transform)

					var_57_6.name = var_57_4
					var_57_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_54_1.actors_[var_57_4] = var_57_6

					local var_57_7 = var_57_6:GetComponentInChildren(typeof(CharacterEffect))

					var_57_7.enabled = true

					local var_57_8 = GameObjectTools.GetOrAddComponent(var_57_6, typeof(DynamicBoneHelper))

					if var_57_8 then
						var_57_8:EnableDynamicBone(false)
					end

					arg_54_1:ShowWeapon(var_57_7.transform, false)

					arg_54_1.var_[var_57_4 .. "Animator"] = var_57_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_54_1.var_[var_57_4 .. "Animator"].applyRootMotion = true
					arg_54_1.var_[var_57_4 .. "LipSync"] = var_57_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_57_9 = arg_54_1.actors_["1011ui_story"]
			local var_57_10 = 0

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect1011ui_story == nil then
				arg_54_1.var_.characterEffect1011ui_story = var_57_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_11 = 0.200000002980232

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_11 and not isNil(var_57_9) then
				local var_57_12 = (arg_54_1.time_ - var_57_10) / var_57_11

				if arg_54_1.var_.characterEffect1011ui_story and not isNil(var_57_9) then
					local var_57_13 = Mathf.Lerp(0, 0.5, var_57_12)

					arg_54_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1011ui_story.fillRatio = var_57_13
				end
			end

			if arg_54_1.time_ >= var_57_10 + var_57_11 and arg_54_1.time_ < var_57_10 + var_57_11 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect1011ui_story then
				local var_57_14 = 0.5

				arg_54_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1011ui_story.fillRatio = var_57_14
			end

			local var_57_15 = 0
			local var_57_16 = 1.325

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_17 = arg_54_1:FormatText(StoryNameCfg[42].name)

				arg_54_1.leftNameTxt_.text = var_57_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_18 = arg_54_1:GetWordFromCfg(304121013)
				local var_57_19 = arg_54_1:FormatText(var_57_18.content)

				arg_54_1.text_.text = var_57_19

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_20 = 53
				local var_57_21 = utf8.len(var_57_19)
				local var_57_22 = var_57_20 <= 0 and var_57_16 or var_57_16 * (var_57_21 / var_57_20)

				if var_57_22 > 0 and var_57_16 < var_57_22 then
					arg_54_1.talkMaxDuration = var_57_22

					if var_57_22 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_22 + var_57_15
					end
				end

				arg_54_1.text_.text = var_57_19
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121013", "story_v_out_304121.awb") ~= 0 then
					local var_57_23 = manager.audio:GetVoiceLength("story_v_out_304121", "304121013", "story_v_out_304121.awb") / 1000

					if var_57_23 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_23 + var_57_15
					end

					if var_57_18.prefab_name ~= "" and arg_54_1.actors_[var_57_18.prefab_name] ~= nil then
						local var_57_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_18.prefab_name].transform, "story_v_out_304121", "304121013", "story_v_out_304121.awb")

						arg_54_1:RecordAudio("304121013", var_57_24)
						arg_54_1:RecordAudio("304121013", var_57_24)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_304121", "304121013", "story_v_out_304121.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_304121", "304121013", "story_v_out_304121.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_25 = math.max(var_57_16, arg_54_1.talkMaxDuration)

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_25 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_15) / var_57_25

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_15 + var_57_25 and arg_54_1.time_ < var_57_15 + var_57_25 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play304121014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 304121014
		arg_58_1.duration_ = 14.17

		local var_58_0 = {
			zh = 11.6,
			ja = 14.166
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
				arg_58_0:Play304121015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 1.175

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[42].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:GetWordFromCfg(304121014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121014", "story_v_out_304121.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_304121", "304121014", "story_v_out_304121.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_304121", "304121014", "story_v_out_304121.awb")

						arg_58_1:RecordAudio("304121014", var_61_9)
						arg_58_1:RecordAudio("304121014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_304121", "304121014", "story_v_out_304121.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_304121", "304121014", "story_v_out_304121.awb")
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
	Play304121015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 304121015
		arg_62_1.duration_ = 6.6

		local var_62_0 = {
			zh = 6.6,
			ja = 5.5
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
				arg_62_0:Play304121016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.625

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[42].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_3 = arg_62_1:GetWordFromCfg(304121015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121015", "story_v_out_304121.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_304121", "304121015", "story_v_out_304121.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_304121", "304121015", "story_v_out_304121.awb")

						arg_62_1:RecordAudio("304121015", var_65_9)
						arg_62_1:RecordAudio("304121015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_304121", "304121015", "story_v_out_304121.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_304121", "304121015", "story_v_out_304121.awb")
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
	Play304121016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 304121016
		arg_66_1.duration_ = 8.43

		local var_66_0 = {
			zh = 8.433,
			ja = 8.233
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play304121017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 1.025

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[42].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:GetWordFromCfg(304121016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 41
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121016", "story_v_out_304121.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_304121", "304121016", "story_v_out_304121.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_304121", "304121016", "story_v_out_304121.awb")

						arg_66_1:RecordAudio("304121016", var_69_9)
						arg_66_1:RecordAudio("304121016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_304121", "304121016", "story_v_out_304121.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_304121", "304121016", "story_v_out_304121.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play304121017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 304121017
		arg_70_1.duration_ = 6.27

		local var_70_0 = {
			zh = 6.266,
			ja = 1.333
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
				arg_70_0:Play304121018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = "1084ui_story"

			if arg_70_1.actors_[var_73_0] == nil then
				local var_73_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_73_1) then
					local var_73_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_70_1.stage_.transform)

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

			local var_73_5 = arg_70_1.actors_["1084ui_story"]
			local var_73_6 = 0

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = var_73_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_7 = 0.200000002980232

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_7 and not isNil(var_73_5) then
				local var_73_8 = (arg_70_1.time_ - var_73_6) / var_73_7

				if arg_70_1.var_.characterEffect1084ui_story and not isNil(var_73_5) then
					arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_6 + var_73_7 and arg_70_1.time_ < var_73_6 + var_73_7 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect1084ui_story then
				arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_73_9 = arg_70_1.actors_["4010ui_story"]
			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 and not isNil(var_73_9) and arg_70_1.var_.characterEffect4010ui_story == nil then
				arg_70_1.var_.characterEffect4010ui_story = var_73_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_11 = 0.200000002980232

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_11 and not isNil(var_73_9) then
				local var_73_12 = (arg_70_1.time_ - var_73_10) / var_73_11

				if arg_70_1.var_.characterEffect4010ui_story and not isNil(var_73_9) then
					local var_73_13 = Mathf.Lerp(0, 0.5, var_73_12)

					arg_70_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_70_1.var_.characterEffect4010ui_story.fillRatio = var_73_13
				end
			end

			if arg_70_1.time_ >= var_73_10 + var_73_11 and arg_70_1.time_ < var_73_10 + var_73_11 + arg_73_0 and not isNil(var_73_9) and arg_70_1.var_.characterEffect4010ui_story then
				local var_73_14 = 0.5

				arg_70_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_70_1.var_.characterEffect4010ui_story.fillRatio = var_73_14
			end

			local var_73_15 = 0
			local var_73_16 = 0.6

			if var_73_15 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_17 = arg_70_1:FormatText(StoryNameCfg[6].name)

				arg_70_1.leftNameTxt_.text = var_73_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_18 = arg_70_1:GetWordFromCfg(304121017)
				local var_73_19 = arg_70_1:FormatText(var_73_18.content)

				arg_70_1.text_.text = var_73_19

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_20 = 24
				local var_73_21 = utf8.len(var_73_19)
				local var_73_22 = var_73_20 <= 0 and var_73_16 or var_73_16 * (var_73_21 / var_73_20)

				if var_73_22 > 0 and var_73_16 < var_73_22 then
					arg_70_1.talkMaxDuration = var_73_22

					if var_73_22 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_22 + var_73_15
					end
				end

				arg_70_1.text_.text = var_73_19
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121017", "story_v_out_304121.awb") ~= 0 then
					local var_73_23 = manager.audio:GetVoiceLength("story_v_out_304121", "304121017", "story_v_out_304121.awb") / 1000

					if var_73_23 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_23 + var_73_15
					end

					if var_73_18.prefab_name ~= "" and arg_70_1.actors_[var_73_18.prefab_name] ~= nil then
						local var_73_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_18.prefab_name].transform, "story_v_out_304121", "304121017", "story_v_out_304121.awb")

						arg_70_1:RecordAudio("304121017", var_73_24)
						arg_70_1:RecordAudio("304121017", var_73_24)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_304121", "304121017", "story_v_out_304121.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_304121", "304121017", "story_v_out_304121.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_25 = math.max(var_73_16, arg_70_1.talkMaxDuration)

			if var_73_15 <= arg_70_1.time_ and arg_70_1.time_ < var_73_15 + var_73_25 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_15) / var_73_25

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_15 + var_73_25 and arg_70_1.time_ < var_73_15 + var_73_25 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play304121018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 304121018
		arg_74_1.duration_ = 9.1

		local var_74_0 = {
			zh = 9.1,
			ja = 7.166
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play304121019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["4010ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect4010ui_story == nil then
				arg_74_1.var_.characterEffect4010ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect4010ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect4010ui_story then
				arg_74_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_77_4 = arg_74_1.actors_["1084ui_story"]
			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect1084ui_story == nil then
				arg_74_1.var_.characterEffect1084ui_story = var_77_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_6 = 0.200000002980232

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 and not isNil(var_77_4) then
				local var_77_7 = (arg_74_1.time_ - var_77_5) / var_77_6

				if arg_74_1.var_.characterEffect1084ui_story and not isNil(var_77_4) then
					local var_77_8 = Mathf.Lerp(0, 0.5, var_77_7)

					arg_74_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1084ui_story.fillRatio = var_77_8
				end
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect1084ui_story then
				local var_77_9 = 0.5

				arg_74_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1084ui_story.fillRatio = var_77_9
			end

			local var_77_10 = 0
			local var_77_11 = 1.025

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_12 = arg_74_1:FormatText(StoryNameCfg[42].name)

				arg_74_1.leftNameTxt_.text = var_77_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_13 = arg_74_1:GetWordFromCfg(304121018)
				local var_77_14 = arg_74_1:FormatText(var_77_13.content)

				arg_74_1.text_.text = var_77_14

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_15 = 39
				local var_77_16 = utf8.len(var_77_14)
				local var_77_17 = var_77_15 <= 0 and var_77_11 or var_77_11 * (var_77_16 / var_77_15)

				if var_77_17 > 0 and var_77_11 < var_77_17 then
					arg_74_1.talkMaxDuration = var_77_17

					if var_77_17 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_17 + var_77_10
					end
				end

				arg_74_1.text_.text = var_77_14
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121018", "story_v_out_304121.awb") ~= 0 then
					local var_77_18 = manager.audio:GetVoiceLength("story_v_out_304121", "304121018", "story_v_out_304121.awb") / 1000

					if var_77_18 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_18 + var_77_10
					end

					if var_77_13.prefab_name ~= "" and arg_74_1.actors_[var_77_13.prefab_name] ~= nil then
						local var_77_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_13.prefab_name].transform, "story_v_out_304121", "304121018", "story_v_out_304121.awb")

						arg_74_1:RecordAudio("304121018", var_77_19)
						arg_74_1:RecordAudio("304121018", var_77_19)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_304121", "304121018", "story_v_out_304121.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_304121", "304121018", "story_v_out_304121.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_20 = math.max(var_77_11, arg_74_1.talkMaxDuration)

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_20 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_10) / var_77_20

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_10 + var_77_20 and arg_74_1.time_ < var_77_10 + var_77_20 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play304121019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 304121019
		arg_78_1.duration_ = 12.73

		local var_78_0 = {
			zh = 7.466,
			ja = 12.733
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play304121020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.725

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[42].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(304121019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 29
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121019", "story_v_out_304121.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_304121", "304121019", "story_v_out_304121.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_304121", "304121019", "story_v_out_304121.awb")

						arg_78_1:RecordAudio("304121019", var_81_9)
						arg_78_1:RecordAudio("304121019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_304121", "304121019", "story_v_out_304121.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_304121", "304121019", "story_v_out_304121.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play304121020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 304121020
		arg_82_1.duration_ = 3.77

		local var_82_0 = {
			zh = 3.766,
			ja = 1.333
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play304121021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1084ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1084ui_story == nil then
				arg_82_1.var_.characterEffect1084ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect1084ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect1084ui_story then
				arg_82_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["4010ui_story"]
			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect4010ui_story == nil then
				arg_82_1.var_.characterEffect4010ui_story = var_85_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_6 = 0.200000002980232

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_6 and not isNil(var_85_4) then
				local var_85_7 = (arg_82_1.time_ - var_85_5) / var_85_6

				if arg_82_1.var_.characterEffect4010ui_story and not isNil(var_85_4) then
					local var_85_8 = Mathf.Lerp(0, 0.5, var_85_7)

					arg_82_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_82_1.var_.characterEffect4010ui_story.fillRatio = var_85_8
				end
			end

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect4010ui_story then
				local var_85_9 = 0.5

				arg_82_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_82_1.var_.characterEffect4010ui_story.fillRatio = var_85_9
			end

			local var_85_10 = 0
			local var_85_11 = 0.3

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_12 = arg_82_1:FormatText(StoryNameCfg[6].name)

				arg_82_1.leftNameTxt_.text = var_85_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_13 = arg_82_1:GetWordFromCfg(304121020)
				local var_85_14 = arg_82_1:FormatText(var_85_13.content)

				arg_82_1.text_.text = var_85_14

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_15 = 12
				local var_85_16 = utf8.len(var_85_14)
				local var_85_17 = var_85_15 <= 0 and var_85_11 or var_85_11 * (var_85_16 / var_85_15)

				if var_85_17 > 0 and var_85_11 < var_85_17 then
					arg_82_1.talkMaxDuration = var_85_17

					if var_85_17 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_17 + var_85_10
					end
				end

				arg_82_1.text_.text = var_85_14
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121020", "story_v_out_304121.awb") ~= 0 then
					local var_85_18 = manager.audio:GetVoiceLength("story_v_out_304121", "304121020", "story_v_out_304121.awb") / 1000

					if var_85_18 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_18 + var_85_10
					end

					if var_85_13.prefab_name ~= "" and arg_82_1.actors_[var_85_13.prefab_name] ~= nil then
						local var_85_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_13.prefab_name].transform, "story_v_out_304121", "304121020", "story_v_out_304121.awb")

						arg_82_1:RecordAudio("304121020", var_85_19)
						arg_82_1:RecordAudio("304121020", var_85_19)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_304121", "304121020", "story_v_out_304121.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_304121", "304121020", "story_v_out_304121.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_20 = math.max(var_85_11, arg_82_1.talkMaxDuration)

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_20 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_10) / var_85_20

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_10 + var_85_20 and arg_82_1.time_ < var_85_10 + var_85_20 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play304121021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 304121021
		arg_86_1.duration_ = 16

		local var_86_0 = {
			zh = 10.333,
			ja = 16
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play304121022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["4010ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect4010ui_story == nil then
				arg_86_1.var_.characterEffect4010ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect4010ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect4010ui_story then
				arg_86_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["1084ui_story"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.200000002980232

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect1084ui_story and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1084ui_story.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect1084ui_story then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1084ui_story.fillRatio = var_89_9
			end

			local var_89_10 = 0
			local var_89_11 = 1.175

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_12 = arg_86_1:FormatText(StoryNameCfg[42].name)

				arg_86_1.leftNameTxt_.text = var_89_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_13 = arg_86_1:GetWordFromCfg(304121021)
				local var_89_14 = arg_86_1:FormatText(var_89_13.content)

				arg_86_1.text_.text = var_89_14

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_15 = 47
				local var_89_16 = utf8.len(var_89_14)
				local var_89_17 = var_89_15 <= 0 and var_89_11 or var_89_11 * (var_89_16 / var_89_15)

				if var_89_17 > 0 and var_89_11 < var_89_17 then
					arg_86_1.talkMaxDuration = var_89_17

					if var_89_17 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_17 + var_89_10
					end
				end

				arg_86_1.text_.text = var_89_14
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121021", "story_v_out_304121.awb") ~= 0 then
					local var_89_18 = manager.audio:GetVoiceLength("story_v_out_304121", "304121021", "story_v_out_304121.awb") / 1000

					if var_89_18 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_18 + var_89_10
					end

					if var_89_13.prefab_name ~= "" and arg_86_1.actors_[var_89_13.prefab_name] ~= nil then
						local var_89_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_13.prefab_name].transform, "story_v_out_304121", "304121021", "story_v_out_304121.awb")

						arg_86_1:RecordAudio("304121021", var_89_19)
						arg_86_1:RecordAudio("304121021", var_89_19)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_304121", "304121021", "story_v_out_304121.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_304121", "304121021", "story_v_out_304121.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_20 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_20 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_10) / var_89_20

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_10 + var_89_20 and arg_86_1.time_ < var_89_10 + var_89_20 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play304121022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 304121022
		arg_90_1.duration_ = 7.7

		local var_90_0 = {
			zh = 7.7,
			ja = 4.933
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play304121023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 0.925

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_2 = arg_90_1:FormatText(StoryNameCfg[42].name)

				arg_90_1.leftNameTxt_.text = var_93_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:GetWordFromCfg(304121022)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 36
				local var_93_6 = utf8.len(var_93_4)
				local var_93_7 = var_93_5 <= 0 and var_93_1 or var_93_1 * (var_93_6 / var_93_5)

				if var_93_7 > 0 and var_93_1 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121022", "story_v_out_304121.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_304121", "304121022", "story_v_out_304121.awb") / 1000

					if var_93_8 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_0
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_304121", "304121022", "story_v_out_304121.awb")

						arg_90_1:RecordAudio("304121022", var_93_9)
						arg_90_1:RecordAudio("304121022", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_304121", "304121022", "story_v_out_304121.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_304121", "304121022", "story_v_out_304121.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_10 and arg_90_1.time_ < var_93_0 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play304121023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 304121023
		arg_94_1.duration_ = 10.53

		local var_94_0 = {
			zh = 9.933,
			ja = 10.533
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play304121024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.175

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[42].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(304121023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 47
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121023", "story_v_out_304121.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_304121", "304121023", "story_v_out_304121.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_304121", "304121023", "story_v_out_304121.awb")

						arg_94_1:RecordAudio("304121023", var_97_9)
						arg_94_1:RecordAudio("304121023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_304121", "304121023", "story_v_out_304121.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_304121", "304121023", "story_v_out_304121.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play304121024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 304121024
		arg_98_1.duration_ = 4.9

		local var_98_0 = {
			zh = 4.733,
			ja = 4.9
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play304121025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.375

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[42].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(304121024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 15
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121024", "story_v_out_304121.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_304121", "304121024", "story_v_out_304121.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_304121", "304121024", "story_v_out_304121.awb")

						arg_98_1:RecordAudio("304121024", var_101_9)
						arg_98_1:RecordAudio("304121024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_304121", "304121024", "story_v_out_304121.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_304121", "304121024", "story_v_out_304121.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play304121025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 304121025
		arg_102_1.duration_ = 4.87

		local var_102_0 = {
			zh = 4.866,
			ja = 1.333
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play304121026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1084ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1084ui_story == nil then
				arg_102_1.var_.characterEffect1084ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1084ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1084ui_story then
				arg_102_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["4010ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect4010ui_story == nil then
				arg_102_1.var_.characterEffect4010ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.200000002980232

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect4010ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_102_1.var_.characterEffect4010ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect4010ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_102_1.var_.characterEffect4010ui_story.fillRatio = var_105_9
			end

			local var_105_10 = 0
			local var_105_11 = 0.525

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_12 = arg_102_1:FormatText(StoryNameCfg[6].name)

				arg_102_1.leftNameTxt_.text = var_105_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_13 = arg_102_1:GetWordFromCfg(304121025)
				local var_105_14 = arg_102_1:FormatText(var_105_13.content)

				arg_102_1.text_.text = var_105_14

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_15 = 21
				local var_105_16 = utf8.len(var_105_14)
				local var_105_17 = var_105_15 <= 0 and var_105_11 or var_105_11 * (var_105_16 / var_105_15)

				if var_105_17 > 0 and var_105_11 < var_105_17 then
					arg_102_1.talkMaxDuration = var_105_17

					if var_105_17 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_17 + var_105_10
					end
				end

				arg_102_1.text_.text = var_105_14
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121025", "story_v_out_304121.awb") ~= 0 then
					local var_105_18 = manager.audio:GetVoiceLength("story_v_out_304121", "304121025", "story_v_out_304121.awb") / 1000

					if var_105_18 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_18 + var_105_10
					end

					if var_105_13.prefab_name ~= "" and arg_102_1.actors_[var_105_13.prefab_name] ~= nil then
						local var_105_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_13.prefab_name].transform, "story_v_out_304121", "304121025", "story_v_out_304121.awb")

						arg_102_1:RecordAudio("304121025", var_105_19)
						arg_102_1:RecordAudio("304121025", var_105_19)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_304121", "304121025", "story_v_out_304121.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_304121", "304121025", "story_v_out_304121.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_20 = math.max(var_105_11, arg_102_1.talkMaxDuration)

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_20 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_10) / var_105_20

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_10 + var_105_20 and arg_102_1.time_ < var_105_10 + var_105_20 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play304121026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 304121026
		arg_106_1.duration_ = 8.23

		local var_106_0 = {
			zh = 6.266,
			ja = 8.233
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play304121027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.725

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[13].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(304121026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 29
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121026", "story_v_out_304121.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_304121", "304121026", "story_v_out_304121.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_304121", "304121026", "story_v_out_304121.awb")

						arg_106_1:RecordAudio("304121026", var_109_9)
						arg_106_1:RecordAudio("304121026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_304121", "304121026", "story_v_out_304121.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_304121", "304121026", "story_v_out_304121.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play304121027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 304121027
		arg_110_1.duration_ = 9.3

		local var_110_0 = {
			zh = 8.833,
			ja = 9.3
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play304121028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 1.1

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[13].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(304121027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 44
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121027", "story_v_out_304121.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_304121", "304121027", "story_v_out_304121.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_304121", "304121027", "story_v_out_304121.awb")

						arg_110_1:RecordAudio("304121027", var_113_9)
						arg_110_1:RecordAudio("304121027", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_304121", "304121027", "story_v_out_304121.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_304121", "304121027", "story_v_out_304121.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play304121028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 304121028
		arg_114_1.duration_ = 3.6

		local var_114_0 = {
			zh = 3.6,
			ja = 1.333
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play304121029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1084ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1084ui_story == nil then
				arg_114_1.var_.characterEffect1084ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1084ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1084ui_story then
				arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["1019ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1019ui_story == nil then
				arg_114_1.var_.characterEffect1019ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect1019ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1019ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1019ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1019ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0
			local var_117_11 = 0.375

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_12 = arg_114_1:FormatText(StoryNameCfg[6].name)

				arg_114_1.leftNameTxt_.text = var_117_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_13 = arg_114_1:GetWordFromCfg(304121028)
				local var_117_14 = arg_114_1:FormatText(var_117_13.content)

				arg_114_1.text_.text = var_117_14

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_15 = 15
				local var_117_16 = utf8.len(var_117_14)
				local var_117_17 = var_117_15 <= 0 and var_117_11 or var_117_11 * (var_117_16 / var_117_15)

				if var_117_17 > 0 and var_117_11 < var_117_17 then
					arg_114_1.talkMaxDuration = var_117_17

					if var_117_17 + var_117_10 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_17 + var_117_10
					end
				end

				arg_114_1.text_.text = var_117_14
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121028", "story_v_out_304121.awb") ~= 0 then
					local var_117_18 = manager.audio:GetVoiceLength("story_v_out_304121", "304121028", "story_v_out_304121.awb") / 1000

					if var_117_18 + var_117_10 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_18 + var_117_10
					end

					if var_117_13.prefab_name ~= "" and arg_114_1.actors_[var_117_13.prefab_name] ~= nil then
						local var_117_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_13.prefab_name].transform, "story_v_out_304121", "304121028", "story_v_out_304121.awb")

						arg_114_1:RecordAudio("304121028", var_117_19)
						arg_114_1:RecordAudio("304121028", var_117_19)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_304121", "304121028", "story_v_out_304121.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_304121", "304121028", "story_v_out_304121.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_20 = math.max(var_117_11, arg_114_1.talkMaxDuration)

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_20 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_10) / var_117_20

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_10 + var_117_20 and arg_114_1.time_ < var_117_10 + var_117_20 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play304121029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 304121029
		arg_118_1.duration_ = 10.07

		local var_118_0 = {
			zh = 8.166,
			ja = 10.066
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play304121030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["4010ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect4010ui_story == nil then
				arg_118_1.var_.characterEffect4010ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect4010ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect4010ui_story then
				arg_118_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["1084ui_story"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.200000002980232

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1084ui_story.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1084ui_story then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1084ui_story.fillRatio = var_121_9
			end

			local var_121_10 = 0
			local var_121_11 = 0.8

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_12 = arg_118_1:FormatText(StoryNameCfg[42].name)

				arg_118_1.leftNameTxt_.text = var_121_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_13 = arg_118_1:GetWordFromCfg(304121029)
				local var_121_14 = arg_118_1:FormatText(var_121_13.content)

				arg_118_1.text_.text = var_121_14

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_15 = 32
				local var_121_16 = utf8.len(var_121_14)
				local var_121_17 = var_121_15 <= 0 and var_121_11 or var_121_11 * (var_121_16 / var_121_15)

				if var_121_17 > 0 and var_121_11 < var_121_17 then
					arg_118_1.talkMaxDuration = var_121_17

					if var_121_17 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_17 + var_121_10
					end
				end

				arg_118_1.text_.text = var_121_14
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121029", "story_v_out_304121.awb") ~= 0 then
					local var_121_18 = manager.audio:GetVoiceLength("story_v_out_304121", "304121029", "story_v_out_304121.awb") / 1000

					if var_121_18 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_18 + var_121_10
					end

					if var_121_13.prefab_name ~= "" and arg_118_1.actors_[var_121_13.prefab_name] ~= nil then
						local var_121_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_13.prefab_name].transform, "story_v_out_304121", "304121029", "story_v_out_304121.awb")

						arg_118_1:RecordAudio("304121029", var_121_19)
						arg_118_1:RecordAudio("304121029", var_121_19)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_304121", "304121029", "story_v_out_304121.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_304121", "304121029", "story_v_out_304121.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_20 = math.max(var_121_11, arg_118_1.talkMaxDuration)

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_20 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_10) / var_121_20

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_10 + var_121_20 and arg_118_1.time_ < var_121_10 + var_121_20 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play304121030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 304121030
		arg_122_1.duration_ = 6

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play304121031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["4010ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect4010ui_story == nil then
				arg_122_1.var_.characterEffect4010ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect4010ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_122_1.var_.characterEffect4010ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect4010ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_122_1.var_.characterEffect4010ui_story.fillRatio = var_125_5
			end

			local var_125_6 = arg_122_1.bgs_.S0204.transform
			local var_125_7 = 0

			if var_125_7 < arg_122_1.time_ and arg_122_1.time_ <= var_125_7 + arg_125_0 then
				arg_122_1.var_.moveOldPosS0204 = var_125_6.localPosition
			end

			local var_125_8 = 2

			if var_125_7 <= arg_122_1.time_ and arg_122_1.time_ < var_125_7 + var_125_8 then
				local var_125_9 = (arg_122_1.time_ - var_125_7) / var_125_8
				local var_125_10 = Vector3.New(0, 0.56, 8)

				var_125_6.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPosS0204, var_125_10, var_125_9)
			end

			if arg_122_1.time_ >= var_125_7 + var_125_8 and arg_122_1.time_ < var_125_7 + var_125_8 + arg_125_0 then
				var_125_6.localPosition = Vector3.New(0, 0.56, 8)
			end

			local var_125_11 = 0

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 then
				arg_122_1.allBtn_.enabled = false
			end

			local var_125_12 = 1.53333333333333

			if arg_122_1.time_ >= var_125_11 + var_125_12 and arg_122_1.time_ < var_125_11 + var_125_12 + arg_125_0 then
				arg_122_1.allBtn_.enabled = true
			end

			if arg_122_1.frameCnt_ <= 1 then
				arg_122_1.dialog_:SetActive(false)
			end

			local var_125_13 = 1
			local var_125_14 = 0.875

			if var_125_13 < arg_122_1.time_ and arg_122_1.time_ <= var_125_13 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0

				arg_122_1.dialog_:SetActive(true)

				arg_122_1.dialogCg_.alpha = 0

				local var_125_15 = LeanTween.value(arg_122_1.dialog_, 0, 1, 0.3)

				var_125_15:setOnUpdate(LuaHelper.FloatAction(function(arg_126_0)
					arg_122_1.dialogCg_.alpha = arg_126_0
				end))
				var_125_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_122_1.dialog_)
					var_125_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_122_1.duration_ = arg_122_1.duration_ + 0.3

				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_16 = arg_122_1:GetWordFromCfg(304121030)
				local var_125_17 = arg_122_1:FormatText(var_125_16.content)

				arg_122_1.text_.text = var_125_17

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_18 = 35
				local var_125_19 = utf8.len(var_125_17)
				local var_125_20 = var_125_18 <= 0 and var_125_14 or var_125_14 * (var_125_19 / var_125_18)

				if var_125_20 > 0 and var_125_14 < var_125_20 then
					arg_122_1.talkMaxDuration = var_125_20
					var_125_13 = var_125_13 + 0.3

					if var_125_20 + var_125_13 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_20 + var_125_13
					end
				end

				arg_122_1.text_.text = var_125_17
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_21 = var_125_13 + 0.3
			local var_125_22 = math.max(var_125_14, arg_122_1.talkMaxDuration)

			if var_125_21 <= arg_122_1.time_ and arg_122_1.time_ < var_125_21 + var_125_22 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_21) / var_125_22

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_21 + var_125_22 and arg_122_1.time_ < var_125_21 + var_125_22 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "S0204",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0.56, 8),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play304121031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 304121031
		arg_128_1.duration_ = 2.77

		local var_128_0 = {
			zh = 2.766,
			ja = 2.566
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
			arg_128_1.auto_ = false
		end

		function arg_128_1.playNext_(arg_130_0)
			arg_128_1.onStoryFinished_()
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["4010ui_story"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect4010ui_story == nil then
				arg_128_1.var_.characterEffect4010ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect4010ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect4010ui_story then
				arg_128_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_131_4 = 0
			local var_131_5 = 0.175

			if var_131_4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_6 = arg_128_1:FormatText(StoryNameCfg[42].name)

				arg_128_1.leftNameTxt_.text = var_131_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:GetWordFromCfg(304121031)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 7
				local var_131_10 = utf8.len(var_131_8)
				local var_131_11 = var_131_9 <= 0 and var_131_5 or var_131_5 * (var_131_10 / var_131_9)

				if var_131_11 > 0 and var_131_5 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304121", "304121031", "story_v_out_304121.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_out_304121", "304121031", "story_v_out_304121.awb") / 1000

					if var_131_12 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_4
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_304121", "304121031", "story_v_out_304121.awb")

						arg_128_1:RecordAudio("304121031", var_131_13)
						arg_128_1:RecordAudio("304121031", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_304121", "304121031", "story_v_out_304121.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_304121", "304121031", "story_v_out_304121.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_14 and arg_128_1.time_ < var_131_4 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B06c",
		"TextureConfig/Background/S0204"
	},
	voices = {
		"story_v_out_304121.awb"
	}
}
