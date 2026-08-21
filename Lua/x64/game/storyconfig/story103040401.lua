return {
	Play304041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304041001
		arg_1_1.duration_ = 5.97

		local var_1_0 = {
			zh = 5.96633333333333,
			ja = 3.16633333333333
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
				arg_1_0:Play304041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "B02d"

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
				local var_4_5 = arg_1_1.bgs_.B02d

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
					if iter_4_0 ~= "B02d" then
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

			local var_4_29 = arg_1_1.actors_["1084ui_story"]
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.200000002980232

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_33 = 0
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "effect"

				arg_1_1:AudioAction(var_4_35, var_4_36, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_4_37 = 0.1
			local var_4_38 = 0.433333333333333

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "effect"

				arg_1_1:AudioAction(var_4_39, var_4_40, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_41 = 0.6
			local var_4_42 = 1

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_47 = 1.83333333333333
			local var_4_48 = 0.375

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_49 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_49:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_50 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_51 = arg_1_1:GetWordFromCfg(304041001)
				local var_4_52 = arg_1_1:FormatText(var_4_51.content)

				arg_1_1.text_.text = var_4_52

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_53 = 15
				local var_4_54 = utf8.len(var_4_52)
				local var_4_55 = var_4_53 <= 0 and var_4_48 or var_4_48 * (var_4_54 / var_4_53)

				if var_4_55 > 0 and var_4_48 < var_4_55 then
					arg_1_1.talkMaxDuration = var_4_55
					var_4_47 = var_4_47 + 0.3

					if var_4_55 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_55 + var_4_47
					end
				end

				arg_1_1.text_.text = var_4_52
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041001", "story_v_out_304041.awb") ~= 0 then
					local var_4_56 = manager.audio:GetVoiceLength("story_v_out_304041", "304041001", "story_v_out_304041.awb") / 1000

					if var_4_56 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_47
					end

					if var_4_51.prefab_name ~= "" and arg_1_1.actors_[var_4_51.prefab_name] ~= nil then
						local var_4_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_51.prefab_name].transform, "story_v_out_304041", "304041001", "story_v_out_304041.awb")

						arg_1_1:RecordAudio("304041001", var_4_57)
						arg_1_1:RecordAudio("304041001", var_4_57)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304041", "304041001", "story_v_out_304041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304041", "304041001", "story_v_out_304041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_58 = var_4_47 + 0.3
			local var_4_59 = math.max(var_4_48, arg_1_1.talkMaxDuration)

			if var_4_58 <= arg_1_1.time_ and arg_1_1.time_ < var_4_58 + var_4_59 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_58) / var_4_59

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_58 + var_4_59 and arg_1_1.time_ < var_4_58 + var_4_59 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304041002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304041003(arg_8_1)
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
			local var_11_7 = 0.8

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

				local var_11_8 = arg_8_1:GetWordFromCfg(304041002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_10 = 27
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
	Play304041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304041003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.25

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

				local var_15_2 = arg_12_1:GetWordFromCfg(304041003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 51
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
	Play304041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304041004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play304041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.825

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(304041004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 33
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_8 and arg_16_1.time_ < var_19_0 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play304041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304041005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play304041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.6

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

				local var_23_3 = arg_20_1:GetWordFromCfg(304041005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 24
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
	Play304041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304041006
		arg_24_1.duration_ = 7.2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play304041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "B01"

			if arg_24_1.bgs_[var_27_0] == nil then
				local var_27_1 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_27_0)
				var_27_1.name = var_27_0
				var_27_1.transform.parent = arg_24_1.stage_.transform
				var_27_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_[var_27_0] = var_27_1
			end

			local var_27_2 = 1.03333333333333

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				local var_27_3 = manager.ui.mainCamera.transform.localPosition
				local var_27_4 = Vector3.New(0, 0, 10) + Vector3.New(var_27_3.x, var_27_3.y, 0)
				local var_27_5 = arg_24_1.bgs_.B01

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
					if iter_27_0 ~= "B01" then
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

			local var_27_19 = 1.03333333333333

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

			local var_27_23 = 1.03333333333333

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_24 = 1.66666666666667

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

			local var_27_29 = 0
			local var_27_30 = 1

			if var_27_29 < arg_24_1.time_ and arg_24_1.time_ <= var_27_29 + arg_27_0 then
				local var_27_31 = "stop"
				local var_27_32 = "effect"

				arg_24_1:AudioAction(var_27_31, var_27_32, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_27_33 = 1.2
			local var_27_34 = 1

			if var_27_33 < arg_24_1.time_ and arg_24_1.time_ <= var_27_33 + arg_27_0 then
				local var_27_35 = "play"
				local var_27_36 = "effect"

				arg_24_1:AudioAction(var_27_35, var_27_36, "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_37 = 2.2
			local var_27_38 = 0.725

			if var_27_37 < arg_24_1.time_ and arg_24_1.time_ <= var_27_37 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_39 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_39:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_40 = arg_24_1:GetWordFromCfg(304041006)
				local var_27_41 = arg_24_1:FormatText(var_27_40.content)

				arg_24_1.text_.text = var_27_41

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_42 = 29
				local var_27_43 = utf8.len(var_27_41)
				local var_27_44 = var_27_42 <= 0 and var_27_38 or var_27_38 * (var_27_43 / var_27_42)

				if var_27_44 > 0 and var_27_38 < var_27_44 then
					arg_24_1.talkMaxDuration = var_27_44
					var_27_37 = var_27_37 + 0.3

					if var_27_44 + var_27_37 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_44 + var_27_37
					end
				end

				arg_24_1.text_.text = var_27_41
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_45 = var_27_37 + 0.3
			local var_27_46 = math.max(var_27_38, arg_24_1.talkMaxDuration)

			if var_27_45 <= arg_24_1.time_ and arg_24_1.time_ < var_27_45 + var_27_46 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_45) / var_27_46

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_45 + var_27_46 and arg_24_1.time_ < var_27_45 + var_27_46 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play304041007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 304041007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play304041008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 1.225

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_2 = arg_30_1:GetWordFromCfg(304041007)
				local var_33_3 = arg_30_1:FormatText(var_33_2.content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 49
				local var_33_5 = utf8.len(var_33_3)
				local var_33_6 = var_33_4 <= 0 and var_33_1 or var_33_1 * (var_33_5 / var_33_4)

				if var_33_6 > 0 and var_33_1 < var_33_6 then
					arg_30_1.talkMaxDuration = var_33_6

					if var_33_6 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_6 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_3
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_7 and arg_30_1.time_ < var_33_0 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play304041008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 304041008
		arg_34_1.duration_ = 10.07

		local var_34_0 = {
			zh = 10.066,
			ja = 1.999999999999
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play304041009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1084ui_story"].transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.moveOldPos1084ui_story = var_37_0.localPosition
			end

			local var_37_2 = 0.001

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2
				local var_37_4 = Vector3.New(-0.7, -0.97, -6)

				var_37_0.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1084ui_story, var_37_4, var_37_3)

				local var_37_5 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_5.x, var_37_5.y, var_37_5.z)

				local var_37_6 = var_37_0.localEulerAngles

				var_37_6.z = 0
				var_37_6.x = 0
				var_37_0.localEulerAngles = var_37_6
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 then
				var_37_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_37_7 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_7.x, var_37_7.y, var_37_7.z)

				local var_37_8 = var_37_0.localEulerAngles

				var_37_8.z = 0
				var_37_8.x = 0
				var_37_0.localEulerAngles = var_37_8
			end

			local var_37_9 = arg_34_1.actors_["1084ui_story"]
			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect1084ui_story == nil then
				arg_34_1.var_.characterEffect1084ui_story = var_37_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_11 = 0.200000002980232

			if var_37_10 <= arg_34_1.time_ and arg_34_1.time_ < var_37_10 + var_37_11 and not isNil(var_37_9) then
				local var_37_12 = (arg_34_1.time_ - var_37_10) / var_37_11

				if arg_34_1.var_.characterEffect1084ui_story and not isNil(var_37_9) then
					arg_34_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_10 + var_37_11 and arg_34_1.time_ < var_37_10 + var_37_11 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect1084ui_story then
				arg_34_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_37_13 = 0

			if var_37_13 < arg_34_1.time_ and arg_34_1.time_ <= var_37_13 + arg_37_0 then
				arg_34_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_37_14 = 0

			if var_37_14 < arg_34_1.time_ and arg_34_1.time_ <= var_37_14 + arg_37_0 then
				arg_34_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_37_15 = 0
			local var_37_16 = 0.975

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_17 = arg_34_1:FormatText(StoryNameCfg[6].name)

				arg_34_1.leftNameTxt_.text = var_37_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_18 = arg_34_1:GetWordFromCfg(304041008)
				local var_37_19 = arg_34_1:FormatText(var_37_18.content)

				arg_34_1.text_.text = var_37_19

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_20 = 39
				local var_37_21 = utf8.len(var_37_19)
				local var_37_22 = var_37_20 <= 0 and var_37_16 or var_37_16 * (var_37_21 / var_37_20)

				if var_37_22 > 0 and var_37_16 < var_37_22 then
					arg_34_1.talkMaxDuration = var_37_22

					if var_37_22 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_22 + var_37_15
					end
				end

				arg_34_1.text_.text = var_37_19
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041008", "story_v_out_304041.awb") ~= 0 then
					local var_37_23 = manager.audio:GetVoiceLength("story_v_out_304041", "304041008", "story_v_out_304041.awb") / 1000

					if var_37_23 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_23 + var_37_15
					end

					if var_37_18.prefab_name ~= "" and arg_34_1.actors_[var_37_18.prefab_name] ~= nil then
						local var_37_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_18.prefab_name].transform, "story_v_out_304041", "304041008", "story_v_out_304041.awb")

						arg_34_1:RecordAudio("304041008", var_37_24)
						arg_34_1:RecordAudio("304041008", var_37_24)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_304041", "304041008", "story_v_out_304041.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_304041", "304041008", "story_v_out_304041.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_25 = math.max(var_37_16, arg_34_1.talkMaxDuration)

			if var_37_15 <= arg_34_1.time_ and arg_34_1.time_ < var_37_15 + var_37_25 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_15) / var_37_25

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_15 + var_37_25 and arg_34_1.time_ < var_37_15 + var_37_25 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play304041009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 304041009
		arg_38_1.duration_ = 5.53

		local var_38_0 = {
			zh = 5.533,
			ja = 5.433
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play304041010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = "1011ui_story"

			if arg_38_1.actors_[var_41_0] == nil then
				local var_41_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_41_1) then
					local var_41_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_38_1.stage_.transform)

					var_41_2.name = var_41_0
					var_41_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_38_1.actors_[var_41_0] = var_41_2

					local var_41_3 = var_41_2:GetComponentInChildren(typeof(CharacterEffect))

					var_41_3.enabled = true

					local var_41_4 = GameObjectTools.GetOrAddComponent(var_41_2, typeof(DynamicBoneHelper))

					if var_41_4 then
						var_41_4:EnableDynamicBone(false)
					end

					arg_38_1:ShowWeapon(var_41_3.transform, false)

					arg_38_1.var_[var_41_0 .. "Animator"] = var_41_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_38_1.var_[var_41_0 .. "Animator"].applyRootMotion = true
					arg_38_1.var_[var_41_0 .. "LipSync"] = var_41_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_41_5 = arg_38_1.actors_["1011ui_story"].transform
			local var_41_6 = 0

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.var_.moveOldPos1011ui_story = var_41_5.localPosition
			end

			local var_41_7 = 0.001

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_7 then
				local var_41_8 = (arg_38_1.time_ - var_41_6) / var_41_7
				local var_41_9 = Vector3.New(0.7, -0.71, -6)

				var_41_5.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1011ui_story, var_41_9, var_41_8)

				local var_41_10 = manager.ui.mainCamera.transform.position - var_41_5.position

				var_41_5.forward = Vector3.New(var_41_10.x, var_41_10.y, var_41_10.z)

				local var_41_11 = var_41_5.localEulerAngles

				var_41_11.z = 0
				var_41_11.x = 0
				var_41_5.localEulerAngles = var_41_11
			end

			if arg_38_1.time_ >= var_41_6 + var_41_7 and arg_38_1.time_ < var_41_6 + var_41_7 + arg_41_0 then
				var_41_5.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_41_12 = manager.ui.mainCamera.transform.position - var_41_5.position

				var_41_5.forward = Vector3.New(var_41_12.x, var_41_12.y, var_41_12.z)

				local var_41_13 = var_41_5.localEulerAngles

				var_41_13.z = 0
				var_41_13.x = 0
				var_41_5.localEulerAngles = var_41_13
			end

			local var_41_14 = arg_38_1.actors_["1011ui_story"]
			local var_41_15 = 0

			if var_41_15 < arg_38_1.time_ and arg_38_1.time_ <= var_41_15 + arg_41_0 and not isNil(var_41_14) and arg_38_1.var_.characterEffect1011ui_story == nil then
				arg_38_1.var_.characterEffect1011ui_story = var_41_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_16 = 0.200000002980232

			if var_41_15 <= arg_38_1.time_ and arg_38_1.time_ < var_41_15 + var_41_16 and not isNil(var_41_14) then
				local var_41_17 = (arg_38_1.time_ - var_41_15) / var_41_16

				if arg_38_1.var_.characterEffect1011ui_story and not isNil(var_41_14) then
					arg_38_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_15 + var_41_16 and arg_38_1.time_ < var_41_15 + var_41_16 + arg_41_0 and not isNil(var_41_14) and arg_38_1.var_.characterEffect1011ui_story then
				arg_38_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_41_18 = arg_38_1.actors_["1084ui_story"]
			local var_41_19 = 0

			if var_41_19 < arg_38_1.time_ and arg_38_1.time_ <= var_41_19 + arg_41_0 and not isNil(var_41_18) and arg_38_1.var_.characterEffect1084ui_story == nil then
				arg_38_1.var_.characterEffect1084ui_story = var_41_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_20 = 0.200000002980232

			if var_41_19 <= arg_38_1.time_ and arg_38_1.time_ < var_41_19 + var_41_20 and not isNil(var_41_18) then
				local var_41_21 = (arg_38_1.time_ - var_41_19) / var_41_20

				if arg_38_1.var_.characterEffect1084ui_story and not isNil(var_41_18) then
					local var_41_22 = Mathf.Lerp(0, 0.5, var_41_21)

					arg_38_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1084ui_story.fillRatio = var_41_22
				end
			end

			if arg_38_1.time_ >= var_41_19 + var_41_20 and arg_38_1.time_ < var_41_19 + var_41_20 + arg_41_0 and not isNil(var_41_18) and arg_38_1.var_.characterEffect1084ui_story then
				local var_41_23 = 0.5

				arg_38_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1084ui_story.fillRatio = var_41_23
			end

			local var_41_24 = 0

			if var_41_24 < arg_38_1.time_ and arg_38_1.time_ <= var_41_24 + arg_41_0 then
				arg_38_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_41_25 = 0

			if var_41_25 < arg_38_1.time_ and arg_38_1.time_ <= var_41_25 + arg_41_0 then
				arg_38_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_41_26 = 0
			local var_41_27 = 0.475

			if var_41_26 < arg_38_1.time_ and arg_38_1.time_ <= var_41_26 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_28 = arg_38_1:FormatText(StoryNameCfg[37].name)

				arg_38_1.leftNameTxt_.text = var_41_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_29 = arg_38_1:GetWordFromCfg(304041009)
				local var_41_30 = arg_38_1:FormatText(var_41_29.content)

				arg_38_1.text_.text = var_41_30

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_31 = 19
				local var_41_32 = utf8.len(var_41_30)
				local var_41_33 = var_41_31 <= 0 and var_41_27 or var_41_27 * (var_41_32 / var_41_31)

				if var_41_33 > 0 and var_41_27 < var_41_33 then
					arg_38_1.talkMaxDuration = var_41_33

					if var_41_33 + var_41_26 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_33 + var_41_26
					end
				end

				arg_38_1.text_.text = var_41_30
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041009", "story_v_out_304041.awb") ~= 0 then
					local var_41_34 = manager.audio:GetVoiceLength("story_v_out_304041", "304041009", "story_v_out_304041.awb") / 1000

					if var_41_34 + var_41_26 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_34 + var_41_26
					end

					if var_41_29.prefab_name ~= "" and arg_38_1.actors_[var_41_29.prefab_name] ~= nil then
						local var_41_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_29.prefab_name].transform, "story_v_out_304041", "304041009", "story_v_out_304041.awb")

						arg_38_1:RecordAudio("304041009", var_41_35)
						arg_38_1:RecordAudio("304041009", var_41_35)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_304041", "304041009", "story_v_out_304041.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_304041", "304041009", "story_v_out_304041.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_36 = math.max(var_41_27, arg_38_1.talkMaxDuration)

			if var_41_26 <= arg_38_1.time_ and arg_38_1.time_ < var_41_26 + var_41_36 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_26) / var_41_36

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_26 + var_41_36 and arg_38_1.time_ < var_41_26 + var_41_36 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play304041010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 304041010
		arg_42_1.duration_ = 7.77

		local var_42_0 = {
			zh = 6.9,
			ja = 7.766
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play304041011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "1019ui_story"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_42_1.stage_.transform)

					var_45_2.name = var_45_0
					var_45_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_42_1.actors_[var_45_0] = var_45_2

					local var_45_3 = var_45_2:GetComponentInChildren(typeof(CharacterEffect))

					var_45_3.enabled = true

					local var_45_4 = GameObjectTools.GetOrAddComponent(var_45_2, typeof(DynamicBoneHelper))

					if var_45_4 then
						var_45_4:EnableDynamicBone(false)
					end

					arg_42_1:ShowWeapon(var_45_3.transform, false)

					arg_42_1.var_[var_45_0 .. "Animator"] = var_45_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_42_1.var_[var_45_0 .. "Animator"].applyRootMotion = true
					arg_42_1.var_[var_45_0 .. "LipSync"] = var_45_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_45_5 = arg_42_1.actors_["1019ui_story"].transform
			local var_45_6 = 0

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.var_.moveOldPos1019ui_story = var_45_5.localPosition
			end

			local var_45_7 = 0.001

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_7 then
				local var_45_8 = (arg_42_1.time_ - var_45_6) / var_45_7
				local var_45_9 = Vector3.New(-0.2, -1.08, -5.9)

				var_45_5.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1019ui_story, var_45_9, var_45_8)

				local var_45_10 = manager.ui.mainCamera.transform.position - var_45_5.position

				var_45_5.forward = Vector3.New(var_45_10.x, var_45_10.y, var_45_10.z)

				local var_45_11 = var_45_5.localEulerAngles

				var_45_11.z = 0
				var_45_11.x = 0
				var_45_5.localEulerAngles = var_45_11
			end

			if arg_42_1.time_ >= var_45_6 + var_45_7 and arg_42_1.time_ < var_45_6 + var_45_7 + arg_45_0 then
				var_45_5.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_45_12 = manager.ui.mainCamera.transform.position - var_45_5.position

				var_45_5.forward = Vector3.New(var_45_12.x, var_45_12.y, var_45_12.z)

				local var_45_13 = var_45_5.localEulerAngles

				var_45_13.z = 0
				var_45_13.x = 0
				var_45_5.localEulerAngles = var_45_13
			end

			local var_45_14 = arg_42_1.actors_["1011ui_story"].transform
			local var_45_15 = 0

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 then
				arg_42_1.var_.moveOldPos1011ui_story = var_45_14.localPosition
			end

			local var_45_16 = 0.001

			if var_45_15 <= arg_42_1.time_ and arg_42_1.time_ < var_45_15 + var_45_16 then
				local var_45_17 = (arg_42_1.time_ - var_45_15) / var_45_16
				local var_45_18 = Vector3.New(0, 100, 0)

				var_45_14.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1011ui_story, var_45_18, var_45_17)

				local var_45_19 = manager.ui.mainCamera.transform.position - var_45_14.position

				var_45_14.forward = Vector3.New(var_45_19.x, var_45_19.y, var_45_19.z)

				local var_45_20 = var_45_14.localEulerAngles

				var_45_20.z = 0
				var_45_20.x = 0
				var_45_14.localEulerAngles = var_45_20
			end

			if arg_42_1.time_ >= var_45_15 + var_45_16 and arg_42_1.time_ < var_45_15 + var_45_16 + arg_45_0 then
				var_45_14.localPosition = Vector3.New(0, 100, 0)

				local var_45_21 = manager.ui.mainCamera.transform.position - var_45_14.position

				var_45_14.forward = Vector3.New(var_45_21.x, var_45_21.y, var_45_21.z)

				local var_45_22 = var_45_14.localEulerAngles

				var_45_22.z = 0
				var_45_22.x = 0
				var_45_14.localEulerAngles = var_45_22
			end

			local var_45_23 = arg_42_1.actors_["1084ui_story"].transform
			local var_45_24 = 0

			if var_45_24 < arg_42_1.time_ and arg_42_1.time_ <= var_45_24 + arg_45_0 then
				arg_42_1.var_.moveOldPos1084ui_story = var_45_23.localPosition
			end

			local var_45_25 = 0.001

			if var_45_24 <= arg_42_1.time_ and arg_42_1.time_ < var_45_24 + var_45_25 then
				local var_45_26 = (arg_42_1.time_ - var_45_24) / var_45_25
				local var_45_27 = Vector3.New(0, 100, 0)

				var_45_23.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1084ui_story, var_45_27, var_45_26)

				local var_45_28 = manager.ui.mainCamera.transform.position - var_45_23.position

				var_45_23.forward = Vector3.New(var_45_28.x, var_45_28.y, var_45_28.z)

				local var_45_29 = var_45_23.localEulerAngles

				var_45_29.z = 0
				var_45_29.x = 0
				var_45_23.localEulerAngles = var_45_29
			end

			if arg_42_1.time_ >= var_45_24 + var_45_25 and arg_42_1.time_ < var_45_24 + var_45_25 + arg_45_0 then
				var_45_23.localPosition = Vector3.New(0, 100, 0)

				local var_45_30 = manager.ui.mainCamera.transform.position - var_45_23.position

				var_45_23.forward = Vector3.New(var_45_30.x, var_45_30.y, var_45_30.z)

				local var_45_31 = var_45_23.localEulerAngles

				var_45_31.z = 0
				var_45_31.x = 0
				var_45_23.localEulerAngles = var_45_31
			end

			local var_45_32 = arg_42_1.actors_["1019ui_story"]
			local var_45_33 = 0

			if var_45_33 < arg_42_1.time_ and arg_42_1.time_ <= var_45_33 + arg_45_0 and not isNil(var_45_32) and arg_42_1.var_.characterEffect1019ui_story == nil then
				arg_42_1.var_.characterEffect1019ui_story = var_45_32:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_34 = 0.200000002980232

			if var_45_33 <= arg_42_1.time_ and arg_42_1.time_ < var_45_33 + var_45_34 and not isNil(var_45_32) then
				local var_45_35 = (arg_42_1.time_ - var_45_33) / var_45_34

				if arg_42_1.var_.characterEffect1019ui_story and not isNil(var_45_32) then
					arg_42_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_33 + var_45_34 and arg_42_1.time_ < var_45_33 + var_45_34 + arg_45_0 and not isNil(var_45_32) and arg_42_1.var_.characterEffect1019ui_story then
				arg_42_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_45_36 = arg_42_1.actors_["1011ui_story"]
			local var_45_37 = 0

			if var_45_37 < arg_42_1.time_ and arg_42_1.time_ <= var_45_37 + arg_45_0 and not isNil(var_45_36) and arg_42_1.var_.characterEffect1011ui_story == nil then
				arg_42_1.var_.characterEffect1011ui_story = var_45_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_38 = 0.200000002980232

			if var_45_37 <= arg_42_1.time_ and arg_42_1.time_ < var_45_37 + var_45_38 and not isNil(var_45_36) then
				local var_45_39 = (arg_42_1.time_ - var_45_37) / var_45_38

				if arg_42_1.var_.characterEffect1011ui_story and not isNil(var_45_36) then
					local var_45_40 = Mathf.Lerp(0, 0.5, var_45_39)

					arg_42_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1011ui_story.fillRatio = var_45_40
				end
			end

			if arg_42_1.time_ >= var_45_37 + var_45_38 and arg_42_1.time_ < var_45_37 + var_45_38 + arg_45_0 and not isNil(var_45_36) and arg_42_1.var_.characterEffect1011ui_story then
				local var_45_41 = 0.5

				arg_42_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1011ui_story.fillRatio = var_45_41
			end

			local var_45_42 = 0

			if var_45_42 < arg_42_1.time_ and arg_42_1.time_ <= var_45_42 + arg_45_0 then
				arg_42_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_45_43 = 0

			if var_45_43 < arg_42_1.time_ and arg_42_1.time_ <= var_45_43 + arg_45_0 then
				arg_42_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_45_44 = 0
			local var_45_45 = 0.875

			if var_45_44 < arg_42_1.time_ and arg_42_1.time_ <= var_45_44 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_46 = arg_42_1:FormatText(StoryNameCfg[13].name)

				arg_42_1.leftNameTxt_.text = var_45_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_47 = arg_42_1:GetWordFromCfg(304041010)
				local var_45_48 = arg_42_1:FormatText(var_45_47.content)

				arg_42_1.text_.text = var_45_48

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_49 = 35
				local var_45_50 = utf8.len(var_45_48)
				local var_45_51 = var_45_49 <= 0 and var_45_45 or var_45_45 * (var_45_50 / var_45_49)

				if var_45_51 > 0 and var_45_45 < var_45_51 then
					arg_42_1.talkMaxDuration = var_45_51

					if var_45_51 + var_45_44 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_51 + var_45_44
					end
				end

				arg_42_1.text_.text = var_45_48
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041010", "story_v_out_304041.awb") ~= 0 then
					local var_45_52 = manager.audio:GetVoiceLength("story_v_out_304041", "304041010", "story_v_out_304041.awb") / 1000

					if var_45_52 + var_45_44 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_52 + var_45_44
					end

					if var_45_47.prefab_name ~= "" and arg_42_1.actors_[var_45_47.prefab_name] ~= nil then
						local var_45_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_47.prefab_name].transform, "story_v_out_304041", "304041010", "story_v_out_304041.awb")

						arg_42_1:RecordAudio("304041010", var_45_53)
						arg_42_1:RecordAudio("304041010", var_45_53)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_304041", "304041010", "story_v_out_304041.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_304041", "304041010", "story_v_out_304041.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_54 = math.max(var_45_45, arg_42_1.talkMaxDuration)

			if var_45_44 <= arg_42_1.time_ and arg_42_1.time_ < var_45_44 + var_45_54 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_44) / var_45_54

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_44 + var_45_54 and arg_42_1.time_ < var_45_44 + var_45_54 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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

		arg_42_1:InitPlayNodeList()
	end,
	Play304041011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 304041011
		arg_46_1.duration_ = 10.67

		local var_46_0 = {
			zh = 7.766,
			ja = 10.666
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
				arg_46_0:Play304041012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 1.075

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_2 = arg_46_1:FormatText(StoryNameCfg[13].name)

				arg_46_1.leftNameTxt_.text = var_49_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:GetWordFromCfg(304041011)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 43
				local var_49_6 = utf8.len(var_49_4)
				local var_49_7 = var_49_5 <= 0 and var_49_1 or var_49_1 * (var_49_6 / var_49_5)

				if var_49_7 > 0 and var_49_1 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041011", "story_v_out_304041.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_304041", "304041011", "story_v_out_304041.awb") / 1000

					if var_49_8 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_0
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_304041", "304041011", "story_v_out_304041.awb")

						arg_46_1:RecordAudio("304041011", var_49_9)
						arg_46_1:RecordAudio("304041011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_304041", "304041011", "story_v_out_304041.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_304041", "304041011", "story_v_out_304041.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_10 and arg_46_1.time_ < var_49_0 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play304041012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 304041012
		arg_50_1.duration_ = 8.1

		local var_50_0 = {
			zh = 6.6,
			ja = 8.1
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
				arg_50_0:Play304041013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_2")
			end

			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_53_2 = 0
			local var_53_3 = 0.775

			if var_53_2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_2 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_4 = arg_50_1:FormatText(StoryNameCfg[13].name)

				arg_50_1.leftNameTxt_.text = var_53_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_5 = arg_50_1:GetWordFromCfg(304041012)
				local var_53_6 = arg_50_1:FormatText(var_53_5.content)

				arg_50_1.text_.text = var_53_6

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_7 = 31
				local var_53_8 = utf8.len(var_53_6)
				local var_53_9 = var_53_7 <= 0 and var_53_3 or var_53_3 * (var_53_8 / var_53_7)

				if var_53_9 > 0 and var_53_3 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_2
					end
				end

				arg_50_1.text_.text = var_53_6
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041012", "story_v_out_304041.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_out_304041", "304041012", "story_v_out_304041.awb") / 1000

					if var_53_10 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_2
					end

					if var_53_5.prefab_name ~= "" and arg_50_1.actors_[var_53_5.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_5.prefab_name].transform, "story_v_out_304041", "304041012", "story_v_out_304041.awb")

						arg_50_1:RecordAudio("304041012", var_53_11)
						arg_50_1:RecordAudio("304041012", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_304041", "304041012", "story_v_out_304041.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_304041", "304041012", "story_v_out_304041.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_3, arg_50_1.talkMaxDuration)

			if var_53_2 <= arg_50_1.time_ and arg_50_1.time_ < var_53_2 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_2) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_2 + var_53_12 and arg_50_1.time_ < var_53_2 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play304041013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 304041013
		arg_54_1.duration_ = 5.03

		local var_54_0 = {
			zh = 5.033,
			ja = 5
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
				arg_54_0:Play304041014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1011ui_story"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1011ui_story = var_57_0.localPosition
			end

			local var_57_2 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2
				local var_57_4 = Vector3.New(0.7, -0.71, -6)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1011ui_story, var_57_4, var_57_3)

				local var_57_5 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_5.x, var_57_5.y, var_57_5.z)

				local var_57_6 = var_57_0.localEulerAngles

				var_57_6.z = 0
				var_57_6.x = 0
				var_57_0.localEulerAngles = var_57_6
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_57_7 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_7.x, var_57_7.y, var_57_7.z)

				local var_57_8 = var_57_0.localEulerAngles

				var_57_8.z = 0
				var_57_8.x = 0
				var_57_0.localEulerAngles = var_57_8
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
					arg_54_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_10 + var_57_11 and arg_54_1.time_ < var_57_10 + var_57_11 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect1011ui_story then
				arg_54_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_57_13 = arg_54_1.actors_["1019ui_story"]
			local var_57_14 = 0

			if var_57_14 < arg_54_1.time_ and arg_54_1.time_ <= var_57_14 + arg_57_0 and not isNil(var_57_13) and arg_54_1.var_.characterEffect1019ui_story == nil then
				arg_54_1.var_.characterEffect1019ui_story = var_57_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_15 = 0.200000002980232

			if var_57_14 <= arg_54_1.time_ and arg_54_1.time_ < var_57_14 + var_57_15 and not isNil(var_57_13) then
				local var_57_16 = (arg_54_1.time_ - var_57_14) / var_57_15

				if arg_54_1.var_.characterEffect1019ui_story and not isNil(var_57_13) then
					local var_57_17 = Mathf.Lerp(0, 0.5, var_57_16)

					arg_54_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1019ui_story.fillRatio = var_57_17
				end
			end

			if arg_54_1.time_ >= var_57_14 + var_57_15 and arg_54_1.time_ < var_57_14 + var_57_15 + arg_57_0 and not isNil(var_57_13) and arg_54_1.var_.characterEffect1019ui_story then
				local var_57_18 = 0.5

				arg_54_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1019ui_story.fillRatio = var_57_18
			end

			local var_57_19 = 0

			if var_57_19 < arg_54_1.time_ and arg_54_1.time_ <= var_57_19 + arg_57_0 then
				arg_54_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action424")
			end

			local var_57_20 = 0

			if var_57_20 < arg_54_1.time_ and arg_54_1.time_ <= var_57_20 + arg_57_0 then
				arg_54_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_57_21 = arg_54_1.actors_["1019ui_story"].transform
			local var_57_22 = 0

			if var_57_22 < arg_54_1.time_ and arg_54_1.time_ <= var_57_22 + arg_57_0 then
				arg_54_1.var_.moveOldPos1019ui_story = var_57_21.localPosition
			end

			local var_57_23 = 0.001

			if var_57_22 <= arg_54_1.time_ and arg_54_1.time_ < var_57_22 + var_57_23 then
				local var_57_24 = (arg_54_1.time_ - var_57_22) / var_57_23
				local var_57_25 = Vector3.New(0, 100, 0)

				var_57_21.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1019ui_story, var_57_25, var_57_24)

				local var_57_26 = manager.ui.mainCamera.transform.position - var_57_21.position

				var_57_21.forward = Vector3.New(var_57_26.x, var_57_26.y, var_57_26.z)

				local var_57_27 = var_57_21.localEulerAngles

				var_57_27.z = 0
				var_57_27.x = 0
				var_57_21.localEulerAngles = var_57_27
			end

			if arg_54_1.time_ >= var_57_22 + var_57_23 and arg_54_1.time_ < var_57_22 + var_57_23 + arg_57_0 then
				var_57_21.localPosition = Vector3.New(0, 100, 0)

				local var_57_28 = manager.ui.mainCamera.transform.position - var_57_21.position

				var_57_21.forward = Vector3.New(var_57_28.x, var_57_28.y, var_57_28.z)

				local var_57_29 = var_57_21.localEulerAngles

				var_57_29.z = 0
				var_57_29.x = 0
				var_57_21.localEulerAngles = var_57_29
			end

			local var_57_30 = 0
			local var_57_31 = 0.425

			if var_57_30 < arg_54_1.time_ and arg_54_1.time_ <= var_57_30 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_32 = arg_54_1:FormatText(StoryNameCfg[37].name)

				arg_54_1.leftNameTxt_.text = var_57_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_33 = arg_54_1:GetWordFromCfg(304041013)
				local var_57_34 = arg_54_1:FormatText(var_57_33.content)

				arg_54_1.text_.text = var_57_34

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_35 = 17
				local var_57_36 = utf8.len(var_57_34)
				local var_57_37 = var_57_35 <= 0 and var_57_31 or var_57_31 * (var_57_36 / var_57_35)

				if var_57_37 > 0 and var_57_31 < var_57_37 then
					arg_54_1.talkMaxDuration = var_57_37

					if var_57_37 + var_57_30 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_37 + var_57_30
					end
				end

				arg_54_1.text_.text = var_57_34
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041013", "story_v_out_304041.awb") ~= 0 then
					local var_57_38 = manager.audio:GetVoiceLength("story_v_out_304041", "304041013", "story_v_out_304041.awb") / 1000

					if var_57_38 + var_57_30 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_38 + var_57_30
					end

					if var_57_33.prefab_name ~= "" and arg_54_1.actors_[var_57_33.prefab_name] ~= nil then
						local var_57_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_33.prefab_name].transform, "story_v_out_304041", "304041013", "story_v_out_304041.awb")

						arg_54_1:RecordAudio("304041013", var_57_39)
						arg_54_1:RecordAudio("304041013", var_57_39)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_304041", "304041013", "story_v_out_304041.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_304041", "304041013", "story_v_out_304041.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_40 = math.max(var_57_31, arg_54_1.talkMaxDuration)

			if var_57_30 <= arg_54_1.time_ and arg_54_1.time_ < var_57_30 + var_57_40 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_30) / var_57_40

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_30 + var_57_40 and arg_54_1.time_ < var_57_30 + var_57_40 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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

		arg_54_1:InitPlayNodeList()
	end,
	Play304041014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 304041014
		arg_58_1.duration_ = 4

		local var_58_0 = {
			zh = 4,
			ja = 1.999999999999
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
				arg_58_0:Play304041015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1084ui_story"].transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.moveOldPos1084ui_story = var_61_0.localPosition
			end

			local var_61_2 = 0.001

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2
				local var_61_4 = Vector3.New(-0.7, -0.97, -6)

				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1084ui_story, var_61_4, var_61_3)

				local var_61_5 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_5.x, var_61_5.y, var_61_5.z)

				local var_61_6 = var_61_0.localEulerAngles

				var_61_6.z = 0
				var_61_6.x = 0
				var_61_0.localEulerAngles = var_61_6
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_61_7 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_7.x, var_61_7.y, var_61_7.z)

				local var_61_8 = var_61_0.localEulerAngles

				var_61_8.z = 0
				var_61_8.x = 0
				var_61_0.localEulerAngles = var_61_8
			end

			local var_61_9 = arg_58_1.actors_["1084ui_story"]
			local var_61_10 = 0

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 and not isNil(var_61_9) and arg_58_1.var_.characterEffect1084ui_story == nil then
				arg_58_1.var_.characterEffect1084ui_story = var_61_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_11 = 0.200000002980232

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_11 and not isNil(var_61_9) then
				local var_61_12 = (arg_58_1.time_ - var_61_10) / var_61_11

				if arg_58_1.var_.characterEffect1084ui_story and not isNil(var_61_9) then
					arg_58_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_10 + var_61_11 and arg_58_1.time_ < var_61_10 + var_61_11 + arg_61_0 and not isNil(var_61_9) and arg_58_1.var_.characterEffect1084ui_story then
				arg_58_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_61_13 = arg_58_1.actors_["1011ui_story"]
			local var_61_14 = 0

			if var_61_14 < arg_58_1.time_ and arg_58_1.time_ <= var_61_14 + arg_61_0 and not isNil(var_61_13) and arg_58_1.var_.characterEffect1011ui_story == nil then
				arg_58_1.var_.characterEffect1011ui_story = var_61_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_15 = 0.200000002980232

			if var_61_14 <= arg_58_1.time_ and arg_58_1.time_ < var_61_14 + var_61_15 and not isNil(var_61_13) then
				local var_61_16 = (arg_58_1.time_ - var_61_14) / var_61_15

				if arg_58_1.var_.characterEffect1011ui_story and not isNil(var_61_13) then
					local var_61_17 = Mathf.Lerp(0, 0.5, var_61_16)

					arg_58_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1011ui_story.fillRatio = var_61_17
				end
			end

			if arg_58_1.time_ >= var_61_14 + var_61_15 and arg_58_1.time_ < var_61_14 + var_61_15 + arg_61_0 and not isNil(var_61_13) and arg_58_1.var_.characterEffect1011ui_story then
				local var_61_18 = 0.5

				arg_58_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1011ui_story.fillRatio = var_61_18
			end

			local var_61_19 = 0

			if var_61_19 < arg_58_1.time_ and arg_58_1.time_ <= var_61_19 + arg_61_0 then
				arg_58_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action446")
			end

			local var_61_20 = 0

			if var_61_20 < arg_58_1.time_ and arg_58_1.time_ <= var_61_20 + arg_61_0 then
				arg_58_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_61_21 = 0
			local var_61_22 = 0.35

			if var_61_21 < arg_58_1.time_ and arg_58_1.time_ <= var_61_21 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_23 = arg_58_1:FormatText(StoryNameCfg[6].name)

				arg_58_1.leftNameTxt_.text = var_61_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_24 = arg_58_1:GetWordFromCfg(304041014)
				local var_61_25 = arg_58_1:FormatText(var_61_24.content)

				arg_58_1.text_.text = var_61_25

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_26 = 14
				local var_61_27 = utf8.len(var_61_25)
				local var_61_28 = var_61_26 <= 0 and var_61_22 or var_61_22 * (var_61_27 / var_61_26)

				if var_61_28 > 0 and var_61_22 < var_61_28 then
					arg_58_1.talkMaxDuration = var_61_28

					if var_61_28 + var_61_21 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_28 + var_61_21
					end
				end

				arg_58_1.text_.text = var_61_25
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041014", "story_v_out_304041.awb") ~= 0 then
					local var_61_29 = manager.audio:GetVoiceLength("story_v_out_304041", "304041014", "story_v_out_304041.awb") / 1000

					if var_61_29 + var_61_21 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_29 + var_61_21
					end

					if var_61_24.prefab_name ~= "" and arg_58_1.actors_[var_61_24.prefab_name] ~= nil then
						local var_61_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_24.prefab_name].transform, "story_v_out_304041", "304041014", "story_v_out_304041.awb")

						arg_58_1:RecordAudio("304041014", var_61_30)
						arg_58_1:RecordAudio("304041014", var_61_30)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_304041", "304041014", "story_v_out_304041.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_304041", "304041014", "story_v_out_304041.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_31 = math.max(var_61_22, arg_58_1.talkMaxDuration)

			if var_61_21 <= arg_58_1.time_ and arg_58_1.time_ < var_61_21 + var_61_31 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_21) / var_61_31

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_21 + var_61_31 and arg_58_1.time_ < var_61_21 + var_61_31 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play304041015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 304041015
		arg_62_1.duration_ = 6.5

		local var_62_0 = {
			zh = 6.5,
			ja = 5
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
				arg_62_0:Play304041016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1019ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1019ui_story == nil then
				arg_62_1.var_.characterEffect1019ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1019ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1019ui_story then
				arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_65_4 = arg_62_1.actors_["1084ui_story"]
			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect1084ui_story == nil then
				arg_62_1.var_.characterEffect1084ui_story = var_65_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_6 = 0.200000002980232

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 and not isNil(var_65_4) then
				local var_65_7 = (arg_62_1.time_ - var_65_5) / var_65_6

				if arg_62_1.var_.characterEffect1084ui_story and not isNil(var_65_4) then
					local var_65_8 = Mathf.Lerp(0, 0.5, var_65_7)

					arg_62_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1084ui_story.fillRatio = var_65_8
				end
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect1084ui_story then
				local var_65_9 = 0.5

				arg_62_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1084ui_story.fillRatio = var_65_9
			end

			local var_65_10 = 0
			local var_65_11 = 0.8

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_12 = arg_62_1:FormatText(StoryNameCfg[13].name)

				arg_62_1.leftNameTxt_.text = var_65_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_13 = arg_62_1:GetWordFromCfg(304041015)
				local var_65_14 = arg_62_1:FormatText(var_65_13.content)

				arg_62_1.text_.text = var_65_14

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_15 = 32
				local var_65_16 = utf8.len(var_65_14)
				local var_65_17 = var_65_15 <= 0 and var_65_11 or var_65_11 * (var_65_16 / var_65_15)

				if var_65_17 > 0 and var_65_11 < var_65_17 then
					arg_62_1.talkMaxDuration = var_65_17

					if var_65_17 + var_65_10 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_17 + var_65_10
					end
				end

				arg_62_1.text_.text = var_65_14
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041015", "story_v_out_304041.awb") ~= 0 then
					local var_65_18 = manager.audio:GetVoiceLength("story_v_out_304041", "304041015", "story_v_out_304041.awb") / 1000

					if var_65_18 + var_65_10 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_18 + var_65_10
					end

					if var_65_13.prefab_name ~= "" and arg_62_1.actors_[var_65_13.prefab_name] ~= nil then
						local var_65_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_13.prefab_name].transform, "story_v_out_304041", "304041015", "story_v_out_304041.awb")

						arg_62_1:RecordAudio("304041015", var_65_19)
						arg_62_1:RecordAudio("304041015", var_65_19)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_304041", "304041015", "story_v_out_304041.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_304041", "304041015", "story_v_out_304041.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_20 = math.max(var_65_11, arg_62_1.talkMaxDuration)

			if var_65_10 <= arg_62_1.time_ and arg_62_1.time_ < var_65_10 + var_65_20 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_10) / var_65_20

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_10 + var_65_20 and arg_62_1.time_ < var_65_10 + var_65_20 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play304041016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 304041016
		arg_66_1.duration_ = 4.5

		local var_66_0 = {
			zh = 4.5,
			ja = 1.999999999999
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
				arg_66_0:Play304041017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1084ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1084ui_story == nil then
				arg_66_1.var_.characterEffect1084ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1084ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1084ui_story then
				arg_66_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["1019ui_story"]
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect1019ui_story == nil then
				arg_66_1.var_.characterEffect1019ui_story = var_69_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.200000002980232

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 and not isNil(var_69_4) then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6

				if arg_66_1.var_.characterEffect1019ui_story and not isNil(var_69_4) then
					local var_69_8 = Mathf.Lerp(0, 0.5, var_69_7)

					arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1019ui_story.fillRatio = var_69_8
				end
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect1019ui_story then
				local var_69_9 = 0.5

				arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1019ui_story.fillRatio = var_69_9
			end

			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4613")
			end

			local var_69_11 = 0

			if var_69_11 < arg_66_1.time_ and arg_66_1.time_ <= var_69_11 + arg_69_0 then
				arg_66_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_69_12 = 0
			local var_69_13 = 0.425

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_14 = arg_66_1:FormatText(StoryNameCfg[6].name)

				arg_66_1.leftNameTxt_.text = var_69_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_15 = arg_66_1:GetWordFromCfg(304041016)
				local var_69_16 = arg_66_1:FormatText(var_69_15.content)

				arg_66_1.text_.text = var_69_16

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_17 = 17
				local var_69_18 = utf8.len(var_69_16)
				local var_69_19 = var_69_17 <= 0 and var_69_13 or var_69_13 * (var_69_18 / var_69_17)

				if var_69_19 > 0 and var_69_13 < var_69_19 then
					arg_66_1.talkMaxDuration = var_69_19

					if var_69_19 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_19 + var_69_12
					end
				end

				arg_66_1.text_.text = var_69_16
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041016", "story_v_out_304041.awb") ~= 0 then
					local var_69_20 = manager.audio:GetVoiceLength("story_v_out_304041", "304041016", "story_v_out_304041.awb") / 1000

					if var_69_20 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_20 + var_69_12
					end

					if var_69_15.prefab_name ~= "" and arg_66_1.actors_[var_69_15.prefab_name] ~= nil then
						local var_69_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_15.prefab_name].transform, "story_v_out_304041", "304041016", "story_v_out_304041.awb")

						arg_66_1:RecordAudio("304041016", var_69_21)
						arg_66_1:RecordAudio("304041016", var_69_21)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_304041", "304041016", "story_v_out_304041.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_304041", "304041016", "story_v_out_304041.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_22 = math.max(var_69_13, arg_66_1.talkMaxDuration)

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_22 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_12) / var_69_22

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_12 + var_69_22 and arg_66_1.time_ < var_69_12 + var_69_22 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play304041017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 304041017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play304041018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1011ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1011ui_story = var_73_0.localPosition
			end

			local var_73_2 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2
				local var_73_4 = Vector3.New(0, 100, 0)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1011ui_story, var_73_4, var_73_3)

				local var_73_5 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_5.x, var_73_5.y, var_73_5.z)

				local var_73_6 = var_73_0.localEulerAngles

				var_73_6.z = 0
				var_73_6.x = 0
				var_73_0.localEulerAngles = var_73_6
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0, 100, 0)

				local var_73_7 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_7.x, var_73_7.y, var_73_7.z)

				local var_73_8 = var_73_0.localEulerAngles

				var_73_8.z = 0
				var_73_8.x = 0
				var_73_0.localEulerAngles = var_73_8
			end

			local var_73_9 = arg_70_1.actors_["1084ui_story"].transform
			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1.var_.moveOldPos1084ui_story = var_73_9.localPosition
			end

			local var_73_11 = 0.001

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_11 then
				local var_73_12 = (arg_70_1.time_ - var_73_10) / var_73_11
				local var_73_13 = Vector3.New(0, 100, 0)

				var_73_9.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1084ui_story, var_73_13, var_73_12)

				local var_73_14 = manager.ui.mainCamera.transform.position - var_73_9.position

				var_73_9.forward = Vector3.New(var_73_14.x, var_73_14.y, var_73_14.z)

				local var_73_15 = var_73_9.localEulerAngles

				var_73_15.z = 0
				var_73_15.x = 0
				var_73_9.localEulerAngles = var_73_15
			end

			if arg_70_1.time_ >= var_73_10 + var_73_11 and arg_70_1.time_ < var_73_10 + var_73_11 + arg_73_0 then
				var_73_9.localPosition = Vector3.New(0, 100, 0)

				local var_73_16 = manager.ui.mainCamera.transform.position - var_73_9.position

				var_73_9.forward = Vector3.New(var_73_16.x, var_73_16.y, var_73_16.z)

				local var_73_17 = var_73_9.localEulerAngles

				var_73_17.z = 0
				var_73_17.x = 0
				var_73_9.localEulerAngles = var_73_17
			end

			local var_73_18 = arg_70_1.actors_["1084ui_story"]
			local var_73_19 = 0

			if var_73_19 < arg_70_1.time_ and arg_70_1.time_ <= var_73_19 + arg_73_0 and not isNil(var_73_18) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = var_73_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_20 = 0.200000002980232

			if var_73_19 <= arg_70_1.time_ and arg_70_1.time_ < var_73_19 + var_73_20 and not isNil(var_73_18) then
				local var_73_21 = (arg_70_1.time_ - var_73_19) / var_73_20

				if arg_70_1.var_.characterEffect1084ui_story and not isNil(var_73_18) then
					local var_73_22 = Mathf.Lerp(0, 0.5, var_73_21)

					arg_70_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1084ui_story.fillRatio = var_73_22
				end
			end

			if arg_70_1.time_ >= var_73_19 + var_73_20 and arg_70_1.time_ < var_73_19 + var_73_20 + arg_73_0 and not isNil(var_73_18) and arg_70_1.var_.characterEffect1084ui_story then
				local var_73_23 = 0.5

				arg_70_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1084ui_story.fillRatio = var_73_23
			end

			local var_73_24 = 0
			local var_73_25 = 0.575

			if var_73_24 < arg_70_1.time_ and arg_70_1.time_ <= var_73_24 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_26 = arg_70_1:GetWordFromCfg(304041017)
				local var_73_27 = arg_70_1:FormatText(var_73_26.content)

				arg_70_1.text_.text = var_73_27

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_28 = 23
				local var_73_29 = utf8.len(var_73_27)
				local var_73_30 = var_73_28 <= 0 and var_73_25 or var_73_25 * (var_73_29 / var_73_28)

				if var_73_30 > 0 and var_73_25 < var_73_30 then
					arg_70_1.talkMaxDuration = var_73_30

					if var_73_30 + var_73_24 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_30 + var_73_24
					end
				end

				arg_70_1.text_.text = var_73_27
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_31 = math.max(var_73_25, arg_70_1.talkMaxDuration)

			if var_73_24 <= arg_70_1.time_ and arg_70_1.time_ < var_73_24 + var_73_31 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_24) / var_73_31

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_24 + var_73_31 and arg_70_1.time_ < var_73_24 + var_73_31 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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

		arg_70_1:InitPlayNodeList()
	end,
	Play304041018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 304041018
		arg_74_1.duration_ = 6.07

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play304041019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = manager.ui.mainCamera.transform
			local var_77_1 = 0.333333333333333

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				local var_77_2 = arg_74_1.var_.effect32424
				local var_77_3
				local var_77_4 = var_77_0

				if not var_77_2 then
					var_77_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), var_77_4)
					var_77_2.name = "32424"
					arg_74_1.var_.effect32424 = var_77_2
				else
					var_77_2.transform:SetParent(var_77_4)
				end

				var_77_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_77_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_77_5 = manager.ui.mainCamera.transform
			local var_77_6 = 2.54850649973378

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				local var_77_7 = arg_74_1.var_.effect32424

				if var_77_7 then
					Object.Destroy(var_77_7)

					arg_74_1.var_.effect32424 = nil
				end
			end

			local var_77_8 = 0

			if var_77_8 < arg_74_1.time_ and arg_74_1.time_ <= var_77_8 + arg_77_0 then
				arg_74_1.allBtn_.enabled = false
			end

			local var_77_9 = 1.55

			if arg_74_1.time_ >= var_77_8 + var_77_9 and arg_74_1.time_ < var_77_8 + var_77_9 + arg_77_0 then
				arg_74_1.allBtn_.enabled = true
			end

			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1.mask_.enabled = true
				arg_74_1.mask_.raycastTarget = true

				arg_74_1:SetGaussion(false)
			end

			local var_77_11 = 0.666666666666667

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_11 then
				local var_77_12 = (arg_74_1.time_ - var_77_10) / var_77_11
				local var_77_13 = Color.New(1, 1, 1)

				var_77_13.a = Mathf.Lerp(1, 0, var_77_12)
				arg_74_1.mask_.color = var_77_13
			end

			if arg_74_1.time_ >= var_77_10 + var_77_11 and arg_74_1.time_ < var_77_10 + var_77_11 + arg_77_0 then
				local var_77_14 = Color.New(1, 1, 1)
				local var_77_15 = 0

				arg_74_1.mask_.enabled = false
				var_77_14.a = var_77_15
				arg_74_1.mask_.color = var_77_14
			end

			local var_77_16 = 0
			local var_77_17 = 1

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				local var_77_18 = "play"
				local var_77_19 = "effect"

				arg_74_1:AudioAction(var_77_18, var_77_19, "se_story_152", "se_story_152_machine", "")
			end

			if arg_74_1.frameCnt_ <= 1 then
				arg_74_1.dialog_:SetActive(false)
			end

			local var_77_20 = 1.07350649973378
			local var_77_21 = 1.475

			if var_77_20 < arg_74_1.time_ and arg_74_1.time_ <= var_77_20 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_22 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_22:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_74_1.dialogCg_.alpha = arg_78_0
				end))
				var_77_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_23 = arg_74_1:GetWordFromCfg(304041018)
				local var_77_24 = arg_74_1:FormatText(var_77_23.content)

				arg_74_1.text_.text = var_77_24

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_25 = 59
				local var_77_26 = utf8.len(var_77_24)
				local var_77_27 = var_77_25 <= 0 and var_77_21 or var_77_21 * (var_77_26 / var_77_25)

				if var_77_27 > 0 and var_77_21 < var_77_27 then
					arg_74_1.talkMaxDuration = var_77_27
					var_77_20 = var_77_20 + 0.3

					if var_77_27 + var_77_20 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_27 + var_77_20
					end
				end

				arg_74_1.text_.text = var_77_24
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_28 = var_77_20 + 0.3
			local var_77_29 = math.max(var_77_21, arg_74_1.talkMaxDuration)

			if var_77_28 <= arg_74_1.time_ and arg_74_1.time_ < var_77_28 + var_77_29 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_28) / var_77_29

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_28 + var_77_29 and arg_74_1.time_ < var_77_28 + var_77_29 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play304041019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 304041019
		arg_80_1.duration_ = 2.7

		local var_80_0 = {
			zh = 2.7,
			ja = 1.833333327372
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
				arg_80_0:Play304041020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.3

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[6].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(304041019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 12
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041019", "story_v_out_304041.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_304041", "304041019", "story_v_out_304041.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_304041", "304041019", "story_v_out_304041.awb")

						arg_80_1:RecordAudio("304041019", var_83_9)
						arg_80_1:RecordAudio("304041019", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_304041", "304041019", "story_v_out_304041.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_304041", "304041019", "story_v_out_304041.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 8,
				className = "StoryShakeNode",
				duration = 0.799999997019768,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG_HEAD,
				offset = Vector3.New(3, 3, 0.1)
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play304041020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 304041020
		arg_84_1.duration_ = 5.67

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play304041021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1084ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1084ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1084ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1084ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1084ui_story.fillRatio = var_87_5
			end

			local var_87_6 = manager.ui.mainCamera.transform
			local var_87_7 = 0.333333333333333

			if var_87_7 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				local var_87_8 = arg_84_1.var_.effectewrw
				local var_87_9
				local var_87_10 = var_87_6

				if not var_87_8 then
					var_87_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_87_10)
					var_87_8.name = "ewrw"
					arg_84_1.var_.effectewrw = var_87_8
				else
					var_87_8.transform:SetParent(var_87_10)
				end

				var_87_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_87_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_87_11 = manager.ui.mainCamera.transform
			local var_87_12 = 1.65828603676831

			if var_87_12 < arg_84_1.time_ and arg_84_1.time_ <= var_87_12 + arg_87_0 then
				local var_87_13 = arg_84_1.var_.effectewrw

				if var_87_13 then
					Object.Destroy(var_87_13)

					arg_84_1.var_.effectewrw = nil
				end
			end

			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1.allBtn_.enabled = false
			end

			local var_87_15 = 1.6

			if arg_84_1.time_ >= var_87_14 + var_87_15 and arg_84_1.time_ < var_87_14 + var_87_15 + arg_87_0 then
				arg_84_1.allBtn_.enabled = true
			end

			local var_87_16 = 0
			local var_87_17 = 1

			if var_87_16 < arg_84_1.time_ and arg_84_1.time_ <= var_87_16 + arg_87_0 then
				local var_87_18 = "play"
				local var_87_19 = "effect"

				arg_84_1:AudioAction(var_87_18, var_87_19, "se_story_4", "se_story_4_arm_1", "")
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_20 = 0.674952703434974
			local var_87_21 = 0.65

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_22 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_22:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_23 = arg_84_1:GetWordFromCfg(304041020)
				local var_87_24 = arg_84_1:FormatText(var_87_23.content)

				arg_84_1.text_.text = var_87_24

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_25 = 26
				local var_87_26 = utf8.len(var_87_24)
				local var_87_27 = var_87_25 <= 0 and var_87_21 or var_87_21 * (var_87_26 / var_87_25)

				if var_87_27 > 0 and var_87_21 < var_87_27 then
					arg_84_1.talkMaxDuration = var_87_27
					var_87_20 = var_87_20 + 0.3

					if var_87_27 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_27 + var_87_20
					end
				end

				arg_84_1.text_.text = var_87_24
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_28 = var_87_20 + 0.3
			local var_87_29 = math.max(var_87_21, arg_84_1.talkMaxDuration)

			if var_87_28 <= arg_84_1.time_ and arg_84_1.time_ < var_87_28 + var_87_29 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_28) / var_87_29

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_28 + var_87_29 and arg_84_1.time_ < var_87_28 + var_87_29 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play304041021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 304041021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play304041022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 1.65

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(304041021)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 66
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play304041022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 304041022
		arg_94_1.duration_ = 4.6

		local var_94_0 = {
			zh = 4.6,
			ja = 1.999999999999
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
				arg_94_0:Play304041023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1084ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1084ui_story == nil then
				arg_94_1.var_.characterEffect1084ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1084ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1084ui_story then
				arg_94_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_97_4 = 0

			if var_97_4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4133")
			end

			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_97_6 = arg_94_1.actors_["1084ui_story"].transform
			local var_97_7 = 0

			if var_97_7 < arg_94_1.time_ and arg_94_1.time_ <= var_97_7 + arg_97_0 then
				arg_94_1.var_.moveOldPos1084ui_story = var_97_6.localPosition
			end

			local var_97_8 = 0.001

			if var_97_7 <= arg_94_1.time_ and arg_94_1.time_ < var_97_7 + var_97_8 then
				local var_97_9 = (arg_94_1.time_ - var_97_7) / var_97_8
				local var_97_10 = Vector3.New(0, -0.97, -6)

				var_97_6.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1084ui_story, var_97_10, var_97_9)

				local var_97_11 = manager.ui.mainCamera.transform.position - var_97_6.position

				var_97_6.forward = Vector3.New(var_97_11.x, var_97_11.y, var_97_11.z)

				local var_97_12 = var_97_6.localEulerAngles

				var_97_12.z = 0
				var_97_12.x = 0
				var_97_6.localEulerAngles = var_97_12
			end

			if arg_94_1.time_ >= var_97_7 + var_97_8 and arg_94_1.time_ < var_97_7 + var_97_8 + arg_97_0 then
				var_97_6.localPosition = Vector3.New(0, -0.97, -6)

				local var_97_13 = manager.ui.mainCamera.transform.position - var_97_6.position

				var_97_6.forward = Vector3.New(var_97_13.x, var_97_13.y, var_97_13.z)

				local var_97_14 = var_97_6.localEulerAngles

				var_97_14.z = 0
				var_97_14.x = 0
				var_97_6.localEulerAngles = var_97_14
			end

			local var_97_15 = 0
			local var_97_16 = 0.4

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_17 = arg_94_1:FormatText(StoryNameCfg[6].name)

				arg_94_1.leftNameTxt_.text = var_97_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_18 = arg_94_1:GetWordFromCfg(304041022)
				local var_97_19 = arg_94_1:FormatText(var_97_18.content)

				arg_94_1.text_.text = var_97_19

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_20 = 16
				local var_97_21 = utf8.len(var_97_19)
				local var_97_22 = var_97_20 <= 0 and var_97_16 or var_97_16 * (var_97_21 / var_97_20)

				if var_97_22 > 0 and var_97_16 < var_97_22 then
					arg_94_1.talkMaxDuration = var_97_22

					if var_97_22 + var_97_15 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_22 + var_97_15
					end
				end

				arg_94_1.text_.text = var_97_19
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041022", "story_v_out_304041.awb") ~= 0 then
					local var_97_23 = manager.audio:GetVoiceLength("story_v_out_304041", "304041022", "story_v_out_304041.awb") / 1000

					if var_97_23 + var_97_15 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_23 + var_97_15
					end

					if var_97_18.prefab_name ~= "" and arg_94_1.actors_[var_97_18.prefab_name] ~= nil then
						local var_97_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_18.prefab_name].transform, "story_v_out_304041", "304041022", "story_v_out_304041.awb")

						arg_94_1:RecordAudio("304041022", var_97_24)
						arg_94_1:RecordAudio("304041022", var_97_24)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_304041", "304041022", "story_v_out_304041.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_304041", "304041022", "story_v_out_304041.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_25 = math.max(var_97_16, arg_94_1.talkMaxDuration)

			if var_97_15 <= arg_94_1.time_ and arg_94_1.time_ < var_97_15 + var_97_25 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_15) / var_97_25

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_15 + var_97_25 and arg_94_1.time_ < var_97_15 + var_97_25 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play304041023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 304041023
		arg_98_1.duration_ = 5.87

		local var_98_0 = {
			zh = 4.366,
			ja = 5.866
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
			arg_98_1.auto_ = false
		end

		function arg_98_1.playNext_(arg_100_0)
			arg_98_1.onStoryFinished_()
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1019ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos1019ui_story = var_101_0.localPosition
			end

			local var_101_2 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2
				local var_101_4 = Vector3.New(-0.2, -1.08, -5.9)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1019ui_story, var_101_4, var_101_3)

				local var_101_5 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_5.x, var_101_5.y, var_101_5.z)

				local var_101_6 = var_101_0.localEulerAngles

				var_101_6.z = 0
				var_101_6.x = 0
				var_101_0.localEulerAngles = var_101_6
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_101_7 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_7.x, var_101_7.y, var_101_7.z)

				local var_101_8 = var_101_0.localEulerAngles

				var_101_8.z = 0
				var_101_8.x = 0
				var_101_0.localEulerAngles = var_101_8
			end

			local var_101_9 = arg_98_1.actors_["1084ui_story"].transform
			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1.var_.moveOldPos1084ui_story = var_101_9.localPosition
			end

			local var_101_11 = 0.001

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_11 then
				local var_101_12 = (arg_98_1.time_ - var_101_10) / var_101_11
				local var_101_13 = Vector3.New(0, 100, 0)

				var_101_9.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1084ui_story, var_101_13, var_101_12)

				local var_101_14 = manager.ui.mainCamera.transform.position - var_101_9.position

				var_101_9.forward = Vector3.New(var_101_14.x, var_101_14.y, var_101_14.z)

				local var_101_15 = var_101_9.localEulerAngles

				var_101_15.z = 0
				var_101_15.x = 0
				var_101_9.localEulerAngles = var_101_15
			end

			if arg_98_1.time_ >= var_101_10 + var_101_11 and arg_98_1.time_ < var_101_10 + var_101_11 + arg_101_0 then
				var_101_9.localPosition = Vector3.New(0, 100, 0)

				local var_101_16 = manager.ui.mainCamera.transform.position - var_101_9.position

				var_101_9.forward = Vector3.New(var_101_16.x, var_101_16.y, var_101_16.z)

				local var_101_17 = var_101_9.localEulerAngles

				var_101_17.z = 0
				var_101_17.x = 0
				var_101_9.localEulerAngles = var_101_17
			end

			local var_101_18 = arg_98_1.actors_["1019ui_story"]
			local var_101_19 = 0

			if var_101_19 < arg_98_1.time_ and arg_98_1.time_ <= var_101_19 + arg_101_0 and not isNil(var_101_18) and arg_98_1.var_.characterEffect1019ui_story == nil then
				arg_98_1.var_.characterEffect1019ui_story = var_101_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_20 = 0.200000002980232

			if var_101_19 <= arg_98_1.time_ and arg_98_1.time_ < var_101_19 + var_101_20 and not isNil(var_101_18) then
				local var_101_21 = (arg_98_1.time_ - var_101_19) / var_101_20

				if arg_98_1.var_.characterEffect1019ui_story and not isNil(var_101_18) then
					arg_98_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_19 + var_101_20 and arg_98_1.time_ < var_101_19 + var_101_20 + arg_101_0 and not isNil(var_101_18) and arg_98_1.var_.characterEffect1019ui_story then
				arg_98_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_101_22 = arg_98_1.actors_["1084ui_story"]
			local var_101_23 = 0

			if var_101_23 < arg_98_1.time_ and arg_98_1.time_ <= var_101_23 + arg_101_0 and not isNil(var_101_22) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_24 = 0.200000002980232

			if var_101_23 <= arg_98_1.time_ and arg_98_1.time_ < var_101_23 + var_101_24 and not isNil(var_101_22) then
				local var_101_25 = (arg_98_1.time_ - var_101_23) / var_101_24

				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_22) then
					local var_101_26 = Mathf.Lerp(0, 0.5, var_101_25)

					arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1084ui_story.fillRatio = var_101_26
				end
			end

			if arg_98_1.time_ >= var_101_23 + var_101_24 and arg_98_1.time_ < var_101_23 + var_101_24 + arg_101_0 and not isNil(var_101_22) and arg_98_1.var_.characterEffect1084ui_story then
				local var_101_27 = 0.5

				arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1084ui_story.fillRatio = var_101_27
			end

			local var_101_28 = 0

			if var_101_28 < arg_98_1.time_ and arg_98_1.time_ <= var_101_28 + arg_101_0 then
				arg_98_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			local var_101_29 = 0

			if var_101_29 < arg_98_1.time_ and arg_98_1.time_ <= var_101_29 + arg_101_0 then
				arg_98_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_101_30 = 0
			local var_101_31 = 0.55

			if var_101_30 < arg_98_1.time_ and arg_98_1.time_ <= var_101_30 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_32 = arg_98_1:FormatText(StoryNameCfg[13].name)

				arg_98_1.leftNameTxt_.text = var_101_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_33 = arg_98_1:GetWordFromCfg(304041023)
				local var_101_34 = arg_98_1:FormatText(var_101_33.content)

				arg_98_1.text_.text = var_101_34

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_35 = 22
				local var_101_36 = utf8.len(var_101_34)
				local var_101_37 = var_101_35 <= 0 and var_101_31 or var_101_31 * (var_101_36 / var_101_35)

				if var_101_37 > 0 and var_101_31 < var_101_37 then
					arg_98_1.talkMaxDuration = var_101_37

					if var_101_37 + var_101_30 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_37 + var_101_30
					end
				end

				arg_98_1.text_.text = var_101_34
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304041", "304041023", "story_v_out_304041.awb") ~= 0 then
					local var_101_38 = manager.audio:GetVoiceLength("story_v_out_304041", "304041023", "story_v_out_304041.awb") / 1000

					if var_101_38 + var_101_30 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_38 + var_101_30
					end

					if var_101_33.prefab_name ~= "" and arg_98_1.actors_[var_101_33.prefab_name] ~= nil then
						local var_101_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_33.prefab_name].transform, "story_v_out_304041", "304041023", "story_v_out_304041.awb")

						arg_98_1:RecordAudio("304041023", var_101_39)
						arg_98_1:RecordAudio("304041023", var_101_39)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_304041", "304041023", "story_v_out_304041.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_304041", "304041023", "story_v_out_304041.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_40 = math.max(var_101_31, arg_98_1.talkMaxDuration)

			if var_101_30 <= arg_98_1.time_ and arg_98_1.time_ < var_101_30 + var_101_40 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_30) / var_101_40

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_30 + var_101_40 and arg_98_1.time_ < var_101_30 + var_101_40 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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

		arg_98_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02d",
		"TextureConfig/Background/B01"
	},
	voices = {
		"story_v_out_304041.awb"
	}
}
