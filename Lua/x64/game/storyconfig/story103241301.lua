return {
	Play324131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324131001
		arg_1_1.duration_ = 4.17

		local var_1_0 = {
			zh = 3.7,
			ja = 4.166
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
				arg_1_0:Play324131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2003"

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
				local var_4_5 = arg_1_1.bgs_.ST2003

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
					if iter_4_0 ~= "ST2003" then
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

			local var_4_24 = "1070ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1070ui_story"]
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1070ui_story == nil then
				arg_1_1.var_.characterEffect1070ui_story = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.200000002980232

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect1070ui_story and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1070ui_story then
				arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_4_33 = 0.1
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "effect"

				arg_1_1:AudioAction(var_4_35, var_4_36, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_4_37 = 0
			local var_4_38 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "effect"

				arg_1_1:AudioAction(var_4_39, var_4_40, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_41 = 1
			local var_4_42 = 1

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_43 = "play"
				local var_4_44 = "music"

				arg_1_1:AudioAction(var_4_43, var_4_44, "bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong.awb")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong")

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

			local var_4_47 = 1.7
			local var_4_48 = 0.15

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

				local var_4_50 = arg_1_1:FormatText(StoryNameCfg[318].name)

				arg_1_1.leftNameTxt_.text = var_4_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_7")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_51 = arg_1_1:GetWordFromCfg(324131001)
				local var_4_52 = arg_1_1:FormatText(var_4_51.content)

				arg_1_1.text_.text = var_4_52

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_53 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131001", "story_v_out_324131.awb") ~= 0 then
					local var_4_56 = manager.audio:GetVoiceLength("story_v_out_324131", "324131001", "story_v_out_324131.awb") / 1000

					if var_4_56 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_47
					end

					if var_4_51.prefab_name ~= "" and arg_1_1.actors_[var_4_51.prefab_name] ~= nil then
						local var_4_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_51.prefab_name].transform, "story_v_out_324131", "324131001", "story_v_out_324131.awb")

						arg_1_1:RecordAudio("324131001", var_4_57)
						arg_1_1:RecordAudio("324131001", var_4_57)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324131", "324131001", "story_v_out_324131.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324131", "324131001", "story_v_out_324131.awb")
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
	Play324131002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324131002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324131003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["1070ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1070ui_story == nil then
				arg_8_1.var_.characterEffect1070ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.200000002980232

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect1070ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1070ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect1070ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1070ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 1.1

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

				local var_11_8 = arg_8_1:GetWordFromCfg(324131002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_10 = 44
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
	Play324131003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324131003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324131004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.7
			local var_15_1 = 1

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				local var_15_2 = "play"
				local var_15_3 = "effect"

				arg_12_1:AudioAction(var_15_2, var_15_3, "se_story_side_1039", "se_story_1039_run", "")
			end

			local var_15_4 = 0
			local var_15_5 = 1.5

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_6 = arg_12_1:GetWordFromCfg(324131003)
				local var_15_7 = arg_12_1:FormatText(var_15_6.content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_8 = 60
				local var_15_9 = utf8.len(var_15_7)
				local var_15_10 = var_15_8 <= 0 and var_15_5 or var_15_5 * (var_15_9 / var_15_8)

				if var_15_10 > 0 and var_15_5 < var_15_10 then
					arg_12_1.talkMaxDuration = var_15_10

					if var_15_10 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_4
					end
				end

				arg_12_1.text_.text = var_15_7
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_11 = math.max(var_15_5, arg_12_1.talkMaxDuration)

			if var_15_4 <= arg_12_1.time_ and arg_12_1.time_ < var_15_4 + var_15_11 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_4) / var_15_11

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_4 + var_15_11 and arg_12_1.time_ < var_15_4 + var_15_11 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324131004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324131004
		arg_16_1.duration_ = 4.13

		local var_16_0 = {
			zh = 3.666,
			ja = 4.133
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
				arg_16_0:Play324131005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["1070ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos1070ui_story = var_19_0.localPosition
			end

			local var_19_2 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2
				local var_19_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1070ui_story, var_19_4, var_19_3)

				local var_19_5 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_5.x, var_19_5.y, var_19_5.z)

				local var_19_6 = var_19_0.localEulerAngles

				var_19_6.z = 0
				var_19_6.x = 0
				var_19_0.localEulerAngles = var_19_6
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_19_7 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_7.x, var_19_7.y, var_19_7.z)

				local var_19_8 = var_19_0.localEulerAngles

				var_19_8.z = 0
				var_19_8.x = 0
				var_19_0.localEulerAngles = var_19_8
			end

			local var_19_9 = arg_16_1.actors_["1070ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1070ui_story == nil then
				arg_16_1.var_.characterEffect1070ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.200000002980232

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect1070ui_story and not isNil(var_19_9) then
					arg_16_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1070ui_story then
				arg_16_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_19_13 = 0

			if var_19_13 < arg_16_1.time_ and arg_16_1.time_ <= var_19_13 + arg_19_0 then
				arg_16_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_19_14 = 0

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_19_15 = 0
			local var_19_16 = 0.25

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_17 = arg_16_1:FormatText(StoryNameCfg[318].name)

				arg_16_1.leftNameTxt_.text = var_19_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:GetWordFromCfg(324131004)
				local var_19_19 = arg_16_1:FormatText(var_19_18.content)

				arg_16_1.text_.text = var_19_19

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131004", "story_v_out_324131.awb") ~= 0 then
					local var_19_23 = manager.audio:GetVoiceLength("story_v_out_324131", "324131004", "story_v_out_324131.awb") / 1000

					if var_19_23 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_23 + var_19_15
					end

					if var_19_18.prefab_name ~= "" and arg_16_1.actors_[var_19_18.prefab_name] ~= nil then
						local var_19_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_18.prefab_name].transform, "story_v_out_324131", "324131004", "story_v_out_324131.awb")

						arg_16_1:RecordAudio("324131004", var_19_24)
						arg_16_1:RecordAudio("324131004", var_19_24)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324131", "324131004", "story_v_out_324131.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324131", "324131004", "story_v_out_324131.awb")
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
				actorName = "1070ui_story",
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
	Play324131005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324131005
		arg_20_1.duration_ = 2.77

		local var_20_0 = {
			zh = 1.999999999999,
			ja = 2.766
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
				arg_20_0:Play324131006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1053ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1053ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["1053ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos1053ui_story = var_23_5.localPosition

				local var_23_7 = GameObjectTools.GetOrAddComponent(var_23_5.gameObject, typeof(DynamicBoneHelper))

				if var_23_7 then
					var_23_7:EnableDynamicBone(false)
				end
			end

			local var_23_8 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_8 then
				local var_23_9 = (arg_20_1.time_ - var_23_6) / var_23_8
				local var_23_10 = Vector3.New(0.7, -1.08, -6)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1053ui_story, var_23_10, var_23_9)

				local var_23_11 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_11.x, var_23_11.y, var_23_11.z)

				local var_23_12 = var_23_5.localEulerAngles

				var_23_12.z = 0
				var_23_12.x = 0
				var_23_5.localEulerAngles = var_23_12
			end

			if arg_20_1.time_ >= var_23_6 + var_23_8 and arg_20_1.time_ < var_23_6 + var_23_8 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_23_13 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_13.x, var_23_13.y, var_23_13.z)

				local var_23_14 = var_23_5.localEulerAngles

				var_23_14.z = 0
				var_23_14.x = 0
				var_23_5.localEulerAngles = var_23_14

				local var_23_15 = GameObjectTools.GetOrAddComponent(var_23_5.gameObject, typeof(DynamicBoneHelper))

				if var_23_15 then
					var_23_15:EnableDynamicBone(true)
				end
			end

			local var_23_16 = arg_20_1.actors_["1053ui_story"]
			local var_23_17 = 0

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1053ui_story == nil then
				arg_20_1.var_.characterEffect1053ui_story = var_23_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_18 = 0.200000002980232

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_18 and not isNil(var_23_16) then
				local var_23_19 = (arg_20_1.time_ - var_23_17) / var_23_18

				if arg_20_1.var_.characterEffect1053ui_story and not isNil(var_23_16) then
					arg_20_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_17 + var_23_18 and arg_20_1.time_ < var_23_17 + var_23_18 + arg_23_0 and not isNil(var_23_16) and arg_20_1.var_.characterEffect1053ui_story then
				arg_20_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_23_20 = arg_20_1.actors_["1070ui_story"]
			local var_23_21 = 0

			if var_23_21 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 and not isNil(var_23_20) and arg_20_1.var_.characterEffect1070ui_story == nil then
				arg_20_1.var_.characterEffect1070ui_story = var_23_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_22 = 0.200000002980232

			if var_23_21 <= arg_20_1.time_ and arg_20_1.time_ < var_23_21 + var_23_22 and not isNil(var_23_20) then
				local var_23_23 = (arg_20_1.time_ - var_23_21) / var_23_22

				if arg_20_1.var_.characterEffect1070ui_story and not isNil(var_23_20) then
					local var_23_24 = Mathf.Lerp(0, 0.5, var_23_23)

					arg_20_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1070ui_story.fillRatio = var_23_24
				end
			end

			if arg_20_1.time_ >= var_23_21 + var_23_22 and arg_20_1.time_ < var_23_21 + var_23_22 + arg_23_0 and not isNil(var_23_20) and arg_20_1.var_.characterEffect1070ui_story then
				local var_23_25 = 0.5

				arg_20_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1070ui_story.fillRatio = var_23_25
			end

			local var_23_26 = 0

			if var_23_26 < arg_20_1.time_ and arg_20_1.time_ <= var_23_26 + arg_23_0 then
				arg_20_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			local var_23_27 = 0

			if var_23_27 < arg_20_1.time_ and arg_20_1.time_ <= var_23_27 + arg_23_0 then
				arg_20_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_28 = 0
			local var_23_29 = 0.175

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_30 = arg_20_1:FormatText(StoryNameCfg[472].name)

				arg_20_1.leftNameTxt_.text = var_23_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_31 = arg_20_1:GetWordFromCfg(324131005)
				local var_23_32 = arg_20_1:FormatText(var_23_31.content)

				arg_20_1.text_.text = var_23_32

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_33 = 7
				local var_23_34 = utf8.len(var_23_32)
				local var_23_35 = var_23_33 <= 0 and var_23_29 or var_23_29 * (var_23_34 / var_23_33)

				if var_23_35 > 0 and var_23_29 < var_23_35 then
					arg_20_1.talkMaxDuration = var_23_35

					if var_23_35 + var_23_28 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_35 + var_23_28
					end
				end

				arg_20_1.text_.text = var_23_32
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131005", "story_v_out_324131.awb") ~= 0 then
					local var_23_36 = manager.audio:GetVoiceLength("story_v_out_324131", "324131005", "story_v_out_324131.awb") / 1000

					if var_23_36 + var_23_28 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_36 + var_23_28
					end

					if var_23_31.prefab_name ~= "" and arg_20_1.actors_[var_23_31.prefab_name] ~= nil then
						local var_23_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_31.prefab_name].transform, "story_v_out_324131", "324131005", "story_v_out_324131.awb")

						arg_20_1:RecordAudio("324131005", var_23_37)
						arg_20_1:RecordAudio("324131005", var_23_37)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324131", "324131005", "story_v_out_324131.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324131", "324131005", "story_v_out_324131.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_38 = math.max(var_23_29, arg_20_1.talkMaxDuration)

			if var_23_28 <= arg_20_1.time_ and arg_20_1.time_ < var_23_28 + var_23_38 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_28) / var_23_38

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_28 + var_23_38 and arg_20_1.time_ < var_23_28 + var_23_38 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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

		arg_20_1:InitPlayNodeList()
	end,
	Play324131006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324131006
		arg_24_1.duration_ = 5.57

		local var_24_0 = {
			zh = 4.633,
			ja = 5.566
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
				arg_24_0:Play324131007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1070ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1070ui_story == nil then
				arg_24_1.var_.characterEffect1070ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1070ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1070ui_story then
				arg_24_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["1053ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1053ui_story == nil then
				arg_24_1.var_.characterEffect1053ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.200000002980232

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect1053ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1053ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect1053ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1053ui_story.fillRatio = var_27_9
			end

			local var_27_10 = 0
			local var_27_11 = 0.35

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_12 = arg_24_1:FormatText(StoryNameCfg[318].name)

				arg_24_1.leftNameTxt_.text = var_27_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_13 = arg_24_1:GetWordFromCfg(324131006)
				local var_27_14 = arg_24_1:FormatText(var_27_13.content)

				arg_24_1.text_.text = var_27_14

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 14
				local var_27_16 = utf8.len(var_27_14)
				local var_27_17 = var_27_15 <= 0 and var_27_11 or var_27_11 * (var_27_16 / var_27_15)

				if var_27_17 > 0 and var_27_11 < var_27_17 then
					arg_24_1.talkMaxDuration = var_27_17

					if var_27_17 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_17 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_14
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131006", "story_v_out_324131.awb") ~= 0 then
					local var_27_18 = manager.audio:GetVoiceLength("story_v_out_324131", "324131006", "story_v_out_324131.awb") / 1000

					if var_27_18 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_10
					end

					if var_27_13.prefab_name ~= "" and arg_24_1.actors_[var_27_13.prefab_name] ~= nil then
						local var_27_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_13.prefab_name].transform, "story_v_out_324131", "324131006", "story_v_out_324131.awb")

						arg_24_1:RecordAudio("324131006", var_27_19)
						arg_24_1:RecordAudio("324131006", var_27_19)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324131", "324131006", "story_v_out_324131.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324131", "324131006", "story_v_out_324131.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_20 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_20 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_20

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_20 and arg_24_1.time_ < var_27_10 + var_27_20 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324131007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324131007
		arg_28_1.duration_ = 12.97

		local var_28_0 = {
			zh = 9.033,
			ja = 12.966
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
				arg_28_0:Play324131008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1053ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1053ui_story == nil then
				arg_28_1.var_.characterEffect1053ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1053ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1053ui_story then
				arg_28_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["1070ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1070ui_story == nil then
				arg_28_1.var_.characterEffect1070ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect1070ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1070ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect1070ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1070ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0
			local var_31_11 = 1

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_12 = arg_28_1:FormatText(StoryNameCfg[472].name)

				arg_28_1.leftNameTxt_.text = var_31_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_13 = arg_28_1:GetWordFromCfg(324131007)
				local var_31_14 = arg_28_1:FormatText(var_31_13.content)

				arg_28_1.text_.text = var_31_14

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 40
				local var_31_16 = utf8.len(var_31_14)
				local var_31_17 = var_31_15 <= 0 and var_31_11 or var_31_11 * (var_31_16 / var_31_15)

				if var_31_17 > 0 and var_31_11 < var_31_17 then
					arg_28_1.talkMaxDuration = var_31_17

					if var_31_17 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_14
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131007", "story_v_out_324131.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_324131", "324131007", "story_v_out_324131.awb") / 1000

					if var_31_18 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_10
					end

					if var_31_13.prefab_name ~= "" and arg_28_1.actors_[var_31_13.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_13.prefab_name].transform, "story_v_out_324131", "324131007", "story_v_out_324131.awb")

						arg_28_1:RecordAudio("324131007", var_31_19)
						arg_28_1:RecordAudio("324131007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324131", "324131007", "story_v_out_324131.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324131", "324131007", "story_v_out_324131.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_20 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_20 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_20

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_20 and arg_28_1.time_ < var_31_10 + var_31_20 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324131008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324131008
		arg_32_1.duration_ = 4.1

		local var_32_0 = {
			zh = 4.1,
			ja = 3.733
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
				arg_32_0:Play324131009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1070ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1070ui_story == nil then
				arg_32_1.var_.characterEffect1070ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1070ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1070ui_story then
				arg_32_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["1053ui_story"]
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1053ui_story == nil then
				arg_32_1.var_.characterEffect1053ui_story = var_35_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 and not isNil(var_35_4) then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6

				if arg_32_1.var_.characterEffect1053ui_story and not isNil(var_35_4) then
					local var_35_8 = Mathf.Lerp(0, 0.5, var_35_7)

					arg_32_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1053ui_story.fillRatio = var_35_8
				end
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 and not isNil(var_35_4) and arg_32_1.var_.characterEffect1053ui_story then
				local var_35_9 = 0.5

				arg_32_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1053ui_story.fillRatio = var_35_9
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_35_11 = 0

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_12 = 0
			local var_35_13 = 0.325

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_14 = arg_32_1:FormatText(StoryNameCfg[318].name)

				arg_32_1.leftNameTxt_.text = var_35_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_15 = arg_32_1:GetWordFromCfg(324131008)
				local var_35_16 = arg_32_1:FormatText(var_35_15.content)

				arg_32_1.text_.text = var_35_16

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131008", "story_v_out_324131.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_324131", "324131008", "story_v_out_324131.awb") / 1000

					if var_35_20 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_12
					end

					if var_35_15.prefab_name ~= "" and arg_32_1.actors_[var_35_15.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_15.prefab_name].transform, "story_v_out_324131", "324131008", "story_v_out_324131.awb")

						arg_32_1:RecordAudio("324131008", var_35_21)
						arg_32_1:RecordAudio("324131008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324131", "324131008", "story_v_out_324131.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324131", "324131008", "story_v_out_324131.awb")
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
	Play324131009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324131009
		arg_36_1.duration_ = 8.5

		local var_36_0 = {
			zh = 4.8,
			ja = 8.5
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
				arg_36_0:Play324131010(arg_36_1)
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

			local var_39_4 = arg_36_1.actors_["1070ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1070ui_story == nil then
				arg_36_1.var_.characterEffect1070ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1070ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1070ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1070ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1070ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_12 = 0
			local var_39_13 = 0.475

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_14 = arg_36_1:FormatText(StoryNameCfg[472].name)

				arg_36_1.leftNameTxt_.text = var_39_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_15 = arg_36_1:GetWordFromCfg(324131009)
				local var_39_16 = arg_36_1:FormatText(var_39_15.content)

				arg_36_1.text_.text = var_39_16

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 19
				local var_39_18 = utf8.len(var_39_16)
				local var_39_19 = var_39_17 <= 0 and var_39_13 or var_39_13 * (var_39_18 / var_39_17)

				if var_39_19 > 0 and var_39_13 < var_39_19 then
					arg_36_1.talkMaxDuration = var_39_19

					if var_39_19 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_16
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131009", "story_v_out_324131.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_324131", "324131009", "story_v_out_324131.awb") / 1000

					if var_39_20 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_12
					end

					if var_39_15.prefab_name ~= "" and arg_36_1.actors_[var_39_15.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_15.prefab_name].transform, "story_v_out_324131", "324131009", "story_v_out_324131.awb")

						arg_36_1:RecordAudio("324131009", var_39_21)
						arg_36_1:RecordAudio("324131009", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324131", "324131009", "story_v_out_324131.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324131", "324131009", "story_v_out_324131.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_22 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_22

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_22 and arg_36_1.time_ < var_39_12 + var_39_22 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324131010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324131010
		arg_40_1.duration_ = 6.17

		local var_40_0 = {
			zh = 4.5,
			ja = 6.166
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
				arg_40_0:Play324131011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1070ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1070ui_story == nil then
				arg_40_1.var_.characterEffect1070ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1070ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1070ui_story then
				arg_40_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1053ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1053ui_story == nil then
				arg_40_1.var_.characterEffect1053ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.200000002980232

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1053ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1053ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1053ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1053ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_12 = 0
			local var_43_13 = 0.55

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[318].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(324131010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 22
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131010", "story_v_out_324131.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_324131", "324131010", "story_v_out_324131.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_324131", "324131010", "story_v_out_324131.awb")

						arg_40_1:RecordAudio("324131010", var_43_21)
						arg_40_1:RecordAudio("324131010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324131", "324131010", "story_v_out_324131.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324131", "324131010", "story_v_out_324131.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324131011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324131011
		arg_44_1.duration_ = 7.83

		local var_44_0 = {
			zh = 4.766,
			ja = 7.833
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
				arg_44_0:Play324131012(arg_44_1)
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

			local var_47_4 = arg_44_1.actors_["1070ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1070ui_story == nil then
				arg_44_1.var_.characterEffect1070ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.200000002980232

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1070ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1070ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1070ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1070ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0
			local var_47_11 = 0.575

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_12 = arg_44_1:FormatText(StoryNameCfg[472].name)

				arg_44_1.leftNameTxt_.text = var_47_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_13 = arg_44_1:GetWordFromCfg(324131011)
				local var_47_14 = arg_44_1:FormatText(var_47_13.content)

				arg_44_1.text_.text = var_47_14

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_15 = 23
				local var_47_16 = utf8.len(var_47_14)
				local var_47_17 = var_47_15 <= 0 and var_47_11 or var_47_11 * (var_47_16 / var_47_15)

				if var_47_17 > 0 and var_47_11 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17

					if var_47_17 + var_47_10 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_10
					end
				end

				arg_44_1.text_.text = var_47_14
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131011", "story_v_out_324131.awb") ~= 0 then
					local var_47_18 = manager.audio:GetVoiceLength("story_v_out_324131", "324131011", "story_v_out_324131.awb") / 1000

					if var_47_18 + var_47_10 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_10
					end

					if var_47_13.prefab_name ~= "" and arg_44_1.actors_[var_47_13.prefab_name] ~= nil then
						local var_47_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_13.prefab_name].transform, "story_v_out_324131", "324131011", "story_v_out_324131.awb")

						arg_44_1:RecordAudio("324131011", var_47_19)
						arg_44_1:RecordAudio("324131011", var_47_19)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324131", "324131011", "story_v_out_324131.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324131", "324131011", "story_v_out_324131.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_20 = math.max(var_47_11, arg_44_1.talkMaxDuration)

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_20 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_10) / var_47_20

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_10 + var_47_20 and arg_44_1.time_ < var_47_10 + var_47_20 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324131012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324131012
		arg_48_1.duration_ = 10.67

		local var_48_0 = {
			zh = 7.933,
			ja = 10.666
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
				arg_48_0:Play324131013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1070ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1070ui_story == nil then
				arg_48_1.var_.characterEffect1070ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1070ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1070ui_story then
				arg_48_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1053ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1053ui_story == nil then
				arg_48_1.var_.characterEffect1053ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1053ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1053ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1053ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1053ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0
			local var_51_11 = 0.85

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_12 = arg_48_1:FormatText(StoryNameCfg[318].name)

				arg_48_1.leftNameTxt_.text = var_51_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_13 = arg_48_1:GetWordFromCfg(324131012)
				local var_51_14 = arg_48_1:FormatText(var_51_13.content)

				arg_48_1.text_.text = var_51_14

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 34
				local var_51_16 = utf8.len(var_51_14)
				local var_51_17 = var_51_15 <= 0 and var_51_11 or var_51_11 * (var_51_16 / var_51_15)

				if var_51_17 > 0 and var_51_11 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_14
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131012", "story_v_out_324131.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_324131", "324131012", "story_v_out_324131.awb") / 1000

					if var_51_18 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_10
					end

					if var_51_13.prefab_name ~= "" and arg_48_1.actors_[var_51_13.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_13.prefab_name].transform, "story_v_out_324131", "324131012", "story_v_out_324131.awb")

						arg_48_1:RecordAudio("324131012", var_51_19)
						arg_48_1:RecordAudio("324131012", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324131", "324131012", "story_v_out_324131.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324131", "324131012", "story_v_out_324131.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_20 and arg_48_1.time_ < var_51_10 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324131013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324131013
		arg_52_1.duration_ = 9.9

		local var_52_0 = {
			zh = 9.9,
			ja = 9.566
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
				arg_52_0:Play324131014(arg_52_1)
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

			local var_55_4 = arg_52_1.actors_["1070ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1070ui_story == nil then
				arg_52_1.var_.characterEffect1070ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.200000002980232

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect1070ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1070ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect1070ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1070ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_55_12 = 0
			local var_55_13 = 0.975

			if var_55_12 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_14 = arg_52_1:FormatText(StoryNameCfg[472].name)

				arg_52_1.leftNameTxt_.text = var_55_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_15 = arg_52_1:GetWordFromCfg(324131013)
				local var_55_16 = arg_52_1:FormatText(var_55_15.content)

				arg_52_1.text_.text = var_55_16

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 39
				local var_55_18 = utf8.len(var_55_16)
				local var_55_19 = var_55_17 <= 0 and var_55_13 or var_55_13 * (var_55_18 / var_55_17)

				if var_55_19 > 0 and var_55_13 < var_55_19 then
					arg_52_1.talkMaxDuration = var_55_19

					if var_55_19 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_16
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131013", "story_v_out_324131.awb") ~= 0 then
					local var_55_20 = manager.audio:GetVoiceLength("story_v_out_324131", "324131013", "story_v_out_324131.awb") / 1000

					if var_55_20 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_12
					end

					if var_55_15.prefab_name ~= "" and arg_52_1.actors_[var_55_15.prefab_name] ~= nil then
						local var_55_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_15.prefab_name].transform, "story_v_out_324131", "324131013", "story_v_out_324131.awb")

						arg_52_1:RecordAudio("324131013", var_55_21)
						arg_52_1:RecordAudio("324131013", var_55_21)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324131", "324131013", "story_v_out_324131.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324131", "324131013", "story_v_out_324131.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_22 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_22 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_12) / var_55_22

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_12 + var_55_22 and arg_52_1.time_ < var_55_12 + var_55_22 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324131014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324131014
		arg_56_1.duration_ = 4.17

		local var_56_0 = {
			zh = 3.9,
			ja = 4.166
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
				arg_56_0:Play324131015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.425

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_2 = arg_56_1:FormatText(StoryNameCfg[472].name)

				arg_56_1.leftNameTxt_.text = var_59_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:GetWordFromCfg(324131014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131014", "story_v_out_324131.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131014", "story_v_out_324131.awb") / 1000

					if var_59_8 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_0
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_324131", "324131014", "story_v_out_324131.awb")

						arg_56_1:RecordAudio("324131014", var_59_9)
						arg_56_1:RecordAudio("324131014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_324131", "324131014", "story_v_out_324131.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_324131", "324131014", "story_v_out_324131.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_10 and arg_56_1.time_ < var_59_0 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play324131015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 324131015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play324131016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1070ui_story"].transform
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.var_.moveOldPos1070ui_story = var_63_0.localPosition
			end

			local var_63_2 = 0.001

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2
				local var_63_4 = Vector3.New(0, 100, 0)

				var_63_0.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1070ui_story, var_63_4, var_63_3)

				local var_63_5 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_5.x, var_63_5.y, var_63_5.z)

				local var_63_6 = var_63_0.localEulerAngles

				var_63_6.z = 0
				var_63_6.x = 0
				var_63_0.localEulerAngles = var_63_6
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 then
				var_63_0.localPosition = Vector3.New(0, 100, 0)

				local var_63_7 = manager.ui.mainCamera.transform.position - var_63_0.position

				var_63_0.forward = Vector3.New(var_63_7.x, var_63_7.y, var_63_7.z)

				local var_63_8 = var_63_0.localEulerAngles

				var_63_8.z = 0
				var_63_8.x = 0
				var_63_0.localEulerAngles = var_63_8
			end

			local var_63_9 = arg_60_1.actors_["1053ui_story"].transform
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.var_.moveOldPos1053ui_story = var_63_9.localPosition

				local var_63_11 = GameObjectTools.GetOrAddComponent(var_63_9.gameObject, typeof(DynamicBoneHelper))

				if var_63_11 then
					var_63_11:EnableDynamicBone(false)
				end
			end

			local var_63_12 = 0.001

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_12 then
				local var_63_13 = (arg_60_1.time_ - var_63_10) / var_63_12
				local var_63_14 = Vector3.New(0, 100, 0)

				var_63_9.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1053ui_story, var_63_14, var_63_13)

				local var_63_15 = manager.ui.mainCamera.transform.position - var_63_9.position

				var_63_9.forward = Vector3.New(var_63_15.x, var_63_15.y, var_63_15.z)

				local var_63_16 = var_63_9.localEulerAngles

				var_63_16.z = 0
				var_63_16.x = 0
				var_63_9.localEulerAngles = var_63_16
			end

			if arg_60_1.time_ >= var_63_10 + var_63_12 and arg_60_1.time_ < var_63_10 + var_63_12 + arg_63_0 then
				var_63_9.localPosition = Vector3.New(0, 100, 0)

				local var_63_17 = manager.ui.mainCamera.transform.position - var_63_9.position

				var_63_9.forward = Vector3.New(var_63_17.x, var_63_17.y, var_63_17.z)

				local var_63_18 = var_63_9.localEulerAngles

				var_63_18.z = 0
				var_63_18.x = 0
				var_63_9.localEulerAngles = var_63_18

				local var_63_19 = GameObjectTools.GetOrAddComponent(var_63_9.gameObject, typeof(DynamicBoneHelper))

				if var_63_19 then
					var_63_19:EnableDynamicBone(true)
				end
			end

			local var_63_20 = arg_60_1.actors_["1053ui_story"]
			local var_63_21 = 0

			if var_63_21 < arg_60_1.time_ and arg_60_1.time_ <= var_63_21 + arg_63_0 and not isNil(var_63_20) and arg_60_1.var_.characterEffect1053ui_story == nil then
				arg_60_1.var_.characterEffect1053ui_story = var_63_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_22 = 0.200000002980232

			if var_63_21 <= arg_60_1.time_ and arg_60_1.time_ < var_63_21 + var_63_22 and not isNil(var_63_20) then
				local var_63_23 = (arg_60_1.time_ - var_63_21) / var_63_22

				if arg_60_1.var_.characterEffect1053ui_story and not isNil(var_63_20) then
					local var_63_24 = Mathf.Lerp(0, 0.5, var_63_23)

					arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1053ui_story.fillRatio = var_63_24
				end
			end

			if arg_60_1.time_ >= var_63_21 + var_63_22 and arg_60_1.time_ < var_63_21 + var_63_22 + arg_63_0 and not isNil(var_63_20) and arg_60_1.var_.characterEffect1053ui_story then
				local var_63_25 = 0.5

				arg_60_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1053ui_story.fillRatio = var_63_25
			end

			local var_63_26 = 0
			local var_63_27 = 1.275

			if var_63_26 < arg_60_1.time_ and arg_60_1.time_ <= var_63_26 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_28 = arg_60_1:GetWordFromCfg(324131015)
				local var_63_29 = arg_60_1:FormatText(var_63_28.content)

				arg_60_1.text_.text = var_63_29

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_30 = 51
				local var_63_31 = utf8.len(var_63_29)
				local var_63_32 = var_63_30 <= 0 and var_63_27 or var_63_27 * (var_63_31 / var_63_30)

				if var_63_32 > 0 and var_63_27 < var_63_32 then
					arg_60_1.talkMaxDuration = var_63_32

					if var_63_32 + var_63_26 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_32 + var_63_26
					end
				end

				arg_60_1.text_.text = var_63_29
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_33 = math.max(var_63_27, arg_60_1.talkMaxDuration)

			if var_63_26 <= arg_60_1.time_ and arg_60_1.time_ < var_63_26 + var_63_33 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_26) / var_63_33

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_26 + var_63_33 and arg_60_1.time_ < var_63_26 + var_63_33 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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

		arg_60_1:InitPlayNodeList()
	end,
	Play324131016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 324131016
		arg_64_1.duration_ = 5.4

		local var_64_0 = {
			zh = 2.833,
			ja = 5.4
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
				arg_64_0:Play324131017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1070ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1070ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1070ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1070ui_story"]
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1070ui_story == nil then
				arg_64_1.var_.characterEffect1070ui_story = var_67_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 and not isNil(var_67_9) then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11

				if arg_64_1.var_.characterEffect1070ui_story and not isNil(var_67_9) then
					arg_64_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1070ui_story then
				arg_64_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_67_13 = 0

			if var_67_13 < arg_64_1.time_ and arg_64_1.time_ <= var_67_13 + arg_67_0 then
				arg_64_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_15 = 0
			local var_67_16 = 0.325

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_17 = arg_64_1:FormatText(StoryNameCfg[318].name)

				arg_64_1.leftNameTxt_.text = var_67_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:GetWordFromCfg(324131016)
				local var_67_19 = arg_64_1:FormatText(var_67_18.content)

				arg_64_1.text_.text = var_67_19

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 13
				local var_67_21 = utf8.len(var_67_19)
				local var_67_22 = var_67_20 <= 0 and var_67_16 or var_67_16 * (var_67_21 / var_67_20)

				if var_67_22 > 0 and var_67_16 < var_67_22 then
					arg_64_1.talkMaxDuration = var_67_22

					if var_67_22 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_22 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_19
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131016", "story_v_out_324131.awb") ~= 0 then
					local var_67_23 = manager.audio:GetVoiceLength("story_v_out_324131", "324131016", "story_v_out_324131.awb") / 1000

					if var_67_23 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_15
					end

					if var_67_18.prefab_name ~= "" and arg_64_1.actors_[var_67_18.prefab_name] ~= nil then
						local var_67_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_18.prefab_name].transform, "story_v_out_324131", "324131016", "story_v_out_324131.awb")

						arg_64_1:RecordAudio("324131016", var_67_24)
						arg_64_1:RecordAudio("324131016", var_67_24)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_324131", "324131016", "story_v_out_324131.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_324131", "324131016", "story_v_out_324131.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_25 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_15) / var_67_25

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_15 + var_67_25 and arg_64_1.time_ < var_67_15 + var_67_25 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play324131017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324131017
		arg_68_1.duration_ = 3.6

		local var_68_0 = {
			zh = 3.533,
			ja = 3.6
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
				arg_68_0:Play324131018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1053ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1053ui_story = var_71_0.localPosition

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end
			end

			local var_71_3 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_3 then
				local var_71_4 = (arg_68_1.time_ - var_71_1) / var_71_3
				local var_71_5 = Vector3.New(0.7, -1.08, -6)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1053ui_story, var_71_5, var_71_4)

				local var_71_6 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_6.x, var_71_6.y, var_71_6.z)

				local var_71_7 = var_71_0.localEulerAngles

				var_71_7.z = 0
				var_71_7.x = 0
				var_71_0.localEulerAngles = var_71_7
			end

			if arg_68_1.time_ >= var_71_1 + var_71_3 and arg_68_1.time_ < var_71_1 + var_71_3 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_71_8 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_8.x, var_71_8.y, var_71_8.z)

				local var_71_9 = var_71_0.localEulerAngles

				var_71_9.z = 0
				var_71_9.x = 0
				var_71_0.localEulerAngles = var_71_9

				local var_71_10 = GameObjectTools.GetOrAddComponent(var_71_0.gameObject, typeof(DynamicBoneHelper))

				if var_71_10 then
					var_71_10:EnableDynamicBone(true)
				end
			end

			local var_71_11 = arg_68_1.actors_["1053ui_story"]
			local var_71_12 = 0

			if var_71_12 < arg_68_1.time_ and arg_68_1.time_ <= var_71_12 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1053ui_story == nil then
				arg_68_1.var_.characterEffect1053ui_story = var_71_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_13 = 0.200000002980232

			if var_71_12 <= arg_68_1.time_ and arg_68_1.time_ < var_71_12 + var_71_13 and not isNil(var_71_11) then
				local var_71_14 = (arg_68_1.time_ - var_71_12) / var_71_13

				if arg_68_1.var_.characterEffect1053ui_story and not isNil(var_71_11) then
					arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_12 + var_71_13 and arg_68_1.time_ < var_71_12 + var_71_13 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1053ui_story then
				arg_68_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_71_15 = arg_68_1.actors_["1070ui_story"]
			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 and not isNil(var_71_15) and arg_68_1.var_.characterEffect1070ui_story == nil then
				arg_68_1.var_.characterEffect1070ui_story = var_71_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_17 = 0.200000002980232

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_17 and not isNil(var_71_15) then
				local var_71_18 = (arg_68_1.time_ - var_71_16) / var_71_17

				if arg_68_1.var_.characterEffect1070ui_story and not isNil(var_71_15) then
					local var_71_19 = Mathf.Lerp(0, 0.5, var_71_18)

					arg_68_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1070ui_story.fillRatio = var_71_19
				end
			end

			if arg_68_1.time_ >= var_71_16 + var_71_17 and arg_68_1.time_ < var_71_16 + var_71_17 + arg_71_0 and not isNil(var_71_15) and arg_68_1.var_.characterEffect1070ui_story then
				local var_71_20 = 0.5

				arg_68_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1070ui_story.fillRatio = var_71_20
			end

			local var_71_21 = 0

			if var_71_21 < arg_68_1.time_ and arg_68_1.time_ <= var_71_21 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action464")
			end

			local var_71_22 = 0

			if var_71_22 < arg_68_1.time_ and arg_68_1.time_ <= var_71_22 + arg_71_0 then
				arg_68_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_71_23 = 0
			local var_71_24 = 0.375

			if var_71_23 < arg_68_1.time_ and arg_68_1.time_ <= var_71_23 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_25 = arg_68_1:FormatText(StoryNameCfg[472].name)

				arg_68_1.leftNameTxt_.text = var_71_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_26 = arg_68_1:GetWordFromCfg(324131017)
				local var_71_27 = arg_68_1:FormatText(var_71_26.content)

				arg_68_1.text_.text = var_71_27

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_28 = 15
				local var_71_29 = utf8.len(var_71_27)
				local var_71_30 = var_71_28 <= 0 and var_71_24 or var_71_24 * (var_71_29 / var_71_28)

				if var_71_30 > 0 and var_71_24 < var_71_30 then
					arg_68_1.talkMaxDuration = var_71_30

					if var_71_30 + var_71_23 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_30 + var_71_23
					end
				end

				arg_68_1.text_.text = var_71_27
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131017", "story_v_out_324131.awb") ~= 0 then
					local var_71_31 = manager.audio:GetVoiceLength("story_v_out_324131", "324131017", "story_v_out_324131.awb") / 1000

					if var_71_31 + var_71_23 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_31 + var_71_23
					end

					if var_71_26.prefab_name ~= "" and arg_68_1.actors_[var_71_26.prefab_name] ~= nil then
						local var_71_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_26.prefab_name].transform, "story_v_out_324131", "324131017", "story_v_out_324131.awb")

						arg_68_1:RecordAudio("324131017", var_71_32)
						arg_68_1:RecordAudio("324131017", var_71_32)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_324131", "324131017", "story_v_out_324131.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_324131", "324131017", "story_v_out_324131.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_33 = math.max(var_71_24, arg_68_1.talkMaxDuration)

			if var_71_23 <= arg_68_1.time_ and arg_68_1.time_ < var_71_23 + var_71_33 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_23) / var_71_33

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_23 + var_71_33 and arg_68_1.time_ < var_71_23 + var_71_33 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play324131018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324131018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324131019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1070ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1070ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(0, 100, 0)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1070ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, 100, 0)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = arg_72_1.actors_["1053ui_story"].transform
			local var_75_10 = 0

			if var_75_10 < arg_72_1.time_ and arg_72_1.time_ <= var_75_10 + arg_75_0 then
				arg_72_1.var_.moveOldPos1053ui_story = var_75_9.localPosition

				local var_75_11 = GameObjectTools.GetOrAddComponent(var_75_9.gameObject, typeof(DynamicBoneHelper))

				if var_75_11 then
					var_75_11:EnableDynamicBone(false)
				end
			end

			local var_75_12 = 0.001

			if var_75_10 <= arg_72_1.time_ and arg_72_1.time_ < var_75_10 + var_75_12 then
				local var_75_13 = (arg_72_1.time_ - var_75_10) / var_75_12
				local var_75_14 = Vector3.New(0, 100, 0)

				var_75_9.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1053ui_story, var_75_14, var_75_13)

				local var_75_15 = manager.ui.mainCamera.transform.position - var_75_9.position

				var_75_9.forward = Vector3.New(var_75_15.x, var_75_15.y, var_75_15.z)

				local var_75_16 = var_75_9.localEulerAngles

				var_75_16.z = 0
				var_75_16.x = 0
				var_75_9.localEulerAngles = var_75_16
			end

			if arg_72_1.time_ >= var_75_10 + var_75_12 and arg_72_1.time_ < var_75_10 + var_75_12 + arg_75_0 then
				var_75_9.localPosition = Vector3.New(0, 100, 0)

				local var_75_17 = manager.ui.mainCamera.transform.position - var_75_9.position

				var_75_9.forward = Vector3.New(var_75_17.x, var_75_17.y, var_75_17.z)

				local var_75_18 = var_75_9.localEulerAngles

				var_75_18.z = 0
				var_75_18.x = 0
				var_75_9.localEulerAngles = var_75_18

				local var_75_19 = GameObjectTools.GetOrAddComponent(var_75_9.gameObject, typeof(DynamicBoneHelper))

				if var_75_19 then
					var_75_19:EnableDynamicBone(true)
				end
			end

			local var_75_20 = arg_72_1.actors_["1053ui_story"]
			local var_75_21 = 0

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 and not isNil(var_75_20) and arg_72_1.var_.characterEffect1053ui_story == nil then
				arg_72_1.var_.characterEffect1053ui_story = var_75_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_22 = 0.200000002980232

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_22 and not isNil(var_75_20) then
				local var_75_23 = (arg_72_1.time_ - var_75_21) / var_75_22

				if arg_72_1.var_.characterEffect1053ui_story and not isNil(var_75_20) then
					local var_75_24 = Mathf.Lerp(0, 0.5, var_75_23)

					arg_72_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1053ui_story.fillRatio = var_75_24
				end
			end

			if arg_72_1.time_ >= var_75_21 + var_75_22 and arg_72_1.time_ < var_75_21 + var_75_22 + arg_75_0 and not isNil(var_75_20) and arg_72_1.var_.characterEffect1053ui_story then
				local var_75_25 = 0.5

				arg_72_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1053ui_story.fillRatio = var_75_25
			end

			local var_75_26 = 0
			local var_75_27 = 0.975

			if var_75_26 < arg_72_1.time_ and arg_72_1.time_ <= var_75_26 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_28 = arg_72_1:GetWordFromCfg(324131018)
				local var_75_29 = arg_72_1:FormatText(var_75_28.content)

				arg_72_1.text_.text = var_75_29

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_30 = 39
				local var_75_31 = utf8.len(var_75_29)
				local var_75_32 = var_75_30 <= 0 and var_75_27 or var_75_27 * (var_75_31 / var_75_30)

				if var_75_32 > 0 and var_75_27 < var_75_32 then
					arg_72_1.talkMaxDuration = var_75_32

					if var_75_32 + var_75_26 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_32 + var_75_26
					end
				end

				arg_72_1.text_.text = var_75_29
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_33 = math.max(var_75_27, arg_72_1.talkMaxDuration)

			if var_75_26 <= arg_72_1.time_ and arg_72_1.time_ < var_75_26 + var_75_33 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_26) / var_75_33

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_26 + var_75_33 and arg_72_1.time_ < var_75_26 + var_75_33 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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

		arg_72_1:InitPlayNodeList()
	end,
	Play324131019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324131019
		arg_76_1.duration_ = 3.03

		local var_76_0 = {
			zh = 2.033,
			ja = 3.033
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
				arg_76_0:Play324131020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1053ui_story"].transform
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.var_.moveOldPos1053ui_story = var_79_0.localPosition

				local var_79_2 = GameObjectTools.GetOrAddComponent(var_79_0.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(false)
				end
			end

			local var_79_3 = 0.001

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_3 then
				local var_79_4 = (arg_76_1.time_ - var_79_1) / var_79_3
				local var_79_5 = Vector3.New(0.7, -1.08, -6)

				var_79_0.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1053ui_story, var_79_5, var_79_4)

				local var_79_6 = manager.ui.mainCamera.transform.position - var_79_0.position

				var_79_0.forward = Vector3.New(var_79_6.x, var_79_6.y, var_79_6.z)

				local var_79_7 = var_79_0.localEulerAngles

				var_79_7.z = 0
				var_79_7.x = 0
				var_79_0.localEulerAngles = var_79_7
			end

			if arg_76_1.time_ >= var_79_1 + var_79_3 and arg_76_1.time_ < var_79_1 + var_79_3 + arg_79_0 then
				var_79_0.localPosition = Vector3.New(0.7, -1.08, -6)

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

			local var_79_11 = arg_76_1.actors_["1053ui_story"]
			local var_79_12 = 0

			if var_79_12 < arg_76_1.time_ and arg_76_1.time_ <= var_79_12 + arg_79_0 and not isNil(var_79_11) and arg_76_1.var_.characterEffect1053ui_story == nil then
				arg_76_1.var_.characterEffect1053ui_story = var_79_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_13 = 0.200000002980232

			if var_79_12 <= arg_76_1.time_ and arg_76_1.time_ < var_79_12 + var_79_13 and not isNil(var_79_11) then
				local var_79_14 = (arg_76_1.time_ - var_79_12) / var_79_13

				if arg_76_1.var_.characterEffect1053ui_story and not isNil(var_79_11) then
					arg_76_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_12 + var_79_13 and arg_76_1.time_ < var_79_12 + var_79_13 + arg_79_0 and not isNil(var_79_11) and arg_76_1.var_.characterEffect1053ui_story then
				arg_76_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_79_15 = 0

			if var_79_15 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action4_2")
			end

			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_79_17 = 0
			local var_79_18 = 0.3

			if var_79_17 < arg_76_1.time_ and arg_76_1.time_ <= var_79_17 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_19 = arg_76_1:FormatText(StoryNameCfg[472].name)

				arg_76_1.leftNameTxt_.text = var_79_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_20 = arg_76_1:GetWordFromCfg(324131019)
				local var_79_21 = arg_76_1:FormatText(var_79_20.content)

				arg_76_1.text_.text = var_79_21

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_22 = 12
				local var_79_23 = utf8.len(var_79_21)
				local var_79_24 = var_79_22 <= 0 and var_79_18 or var_79_18 * (var_79_23 / var_79_22)

				if var_79_24 > 0 and var_79_18 < var_79_24 then
					arg_76_1.talkMaxDuration = var_79_24

					if var_79_24 + var_79_17 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_24 + var_79_17
					end
				end

				arg_76_1.text_.text = var_79_21
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131019", "story_v_out_324131.awb") ~= 0 then
					local var_79_25 = manager.audio:GetVoiceLength("story_v_out_324131", "324131019", "story_v_out_324131.awb") / 1000

					if var_79_25 + var_79_17 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_25 + var_79_17
					end

					if var_79_20.prefab_name ~= "" and arg_76_1.actors_[var_79_20.prefab_name] ~= nil then
						local var_79_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_20.prefab_name].transform, "story_v_out_324131", "324131019", "story_v_out_324131.awb")

						arg_76_1:RecordAudio("324131019", var_79_26)
						arg_76_1:RecordAudio("324131019", var_79_26)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_324131", "324131019", "story_v_out_324131.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_324131", "324131019", "story_v_out_324131.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_27 = math.max(var_79_18, arg_76_1.talkMaxDuration)

			if var_79_17 <= arg_76_1.time_ and arg_76_1.time_ < var_79_17 + var_79_27 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_17) / var_79_27

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_17 + var_79_27 and arg_76_1.time_ < var_79_17 + var_79_27 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play324131020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324131020
		arg_80_1.duration_ = 8.6

		local var_80_0 = {
			zh = 8.6,
			ja = 8.066
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
				arg_80_0:Play324131021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1070ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1070ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1070ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1070ui_story"]
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1070ui_story == nil then
				arg_80_1.var_.characterEffect1070ui_story = var_83_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_11 = 0.200000002980232

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 and not isNil(var_83_9) then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11

				if arg_80_1.var_.characterEffect1070ui_story and not isNil(var_83_9) then
					arg_80_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1070ui_story then
				arg_80_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_83_13 = arg_80_1.actors_["1053ui_story"]
			local var_83_14 = 0

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 and not isNil(var_83_13) and arg_80_1.var_.characterEffect1053ui_story == nil then
				arg_80_1.var_.characterEffect1053ui_story = var_83_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_15 = 0.200000002980232

			if var_83_14 <= arg_80_1.time_ and arg_80_1.time_ < var_83_14 + var_83_15 and not isNil(var_83_13) then
				local var_83_16 = (arg_80_1.time_ - var_83_14) / var_83_15

				if arg_80_1.var_.characterEffect1053ui_story and not isNil(var_83_13) then
					local var_83_17 = Mathf.Lerp(0, 0.5, var_83_16)

					arg_80_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1053ui_story.fillRatio = var_83_17
				end
			end

			if arg_80_1.time_ >= var_83_14 + var_83_15 and arg_80_1.time_ < var_83_14 + var_83_15 + arg_83_0 and not isNil(var_83_13) and arg_80_1.var_.characterEffect1053ui_story then
				local var_83_18 = 0.5

				arg_80_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1053ui_story.fillRatio = var_83_18
			end

			local var_83_19 = 0

			if var_83_19 < arg_80_1.time_ and arg_80_1.time_ <= var_83_19 + arg_83_0 then
				arg_80_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action457")
			end

			local var_83_20 = 0

			if var_83_20 < arg_80_1.time_ and arg_80_1.time_ <= var_83_20 + arg_83_0 then
				arg_80_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_21 = 0
			local var_83_22 = 0.6

			if var_83_21 < arg_80_1.time_ and arg_80_1.time_ <= var_83_21 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_23 = arg_80_1:FormatText(StoryNameCfg[318].name)

				arg_80_1.leftNameTxt_.text = var_83_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_24 = arg_80_1:GetWordFromCfg(324131020)
				local var_83_25 = arg_80_1:FormatText(var_83_24.content)

				arg_80_1.text_.text = var_83_25

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_26 = 24
				local var_83_27 = utf8.len(var_83_25)
				local var_83_28 = var_83_26 <= 0 and var_83_22 or var_83_22 * (var_83_27 / var_83_26)

				if var_83_28 > 0 and var_83_22 < var_83_28 then
					arg_80_1.talkMaxDuration = var_83_28

					if var_83_28 + var_83_21 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_28 + var_83_21
					end
				end

				arg_80_1.text_.text = var_83_25
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131020", "story_v_out_324131.awb") ~= 0 then
					local var_83_29 = manager.audio:GetVoiceLength("story_v_out_324131", "324131020", "story_v_out_324131.awb") / 1000

					if var_83_29 + var_83_21 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_29 + var_83_21
					end

					if var_83_24.prefab_name ~= "" and arg_80_1.actors_[var_83_24.prefab_name] ~= nil then
						local var_83_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_24.prefab_name].transform, "story_v_out_324131", "324131020", "story_v_out_324131.awb")

						arg_80_1:RecordAudio("324131020", var_83_30)
						arg_80_1:RecordAudio("324131020", var_83_30)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_324131", "324131020", "story_v_out_324131.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_324131", "324131020", "story_v_out_324131.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_31 = math.max(var_83_22, arg_80_1.talkMaxDuration)

			if var_83_21 <= arg_80_1.time_ and arg_80_1.time_ < var_83_21 + var_83_31 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_21) / var_83_31

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_21 + var_83_31 and arg_80_1.time_ < var_83_21 + var_83_31 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play324131021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324131021
		arg_84_1.duration_ = 11.03

		local var_84_0 = {
			zh = 10.8,
			ja = 11.033
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
				arg_84_0:Play324131022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1053ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1053ui_story == nil then
				arg_84_1.var_.characterEffect1053ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1053ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1053ui_story then
				arg_84_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["1070ui_story"]
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1070ui_story == nil then
				arg_84_1.var_.characterEffect1070ui_story = var_87_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.200000002980232

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 and not isNil(var_87_4) then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6

				if arg_84_1.var_.characterEffect1070ui_story and not isNil(var_87_4) then
					local var_87_8 = Mathf.Lerp(0, 0.5, var_87_7)

					arg_84_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1070ui_story.fillRatio = var_87_8
				end
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 and not isNil(var_87_4) and arg_84_1.var_.characterEffect1070ui_story then
				local var_87_9 = 0.5

				arg_84_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1070ui_story.fillRatio = var_87_9
			end

			local var_87_10 = 0
			local var_87_11 = 1.05

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_12 = arg_84_1:FormatText(StoryNameCfg[472].name)

				arg_84_1.leftNameTxt_.text = var_87_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_13 = arg_84_1:GetWordFromCfg(324131021)
				local var_87_14 = arg_84_1:FormatText(var_87_13.content)

				arg_84_1.text_.text = var_87_14

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_15 = 42
				local var_87_16 = utf8.len(var_87_14)
				local var_87_17 = var_87_15 <= 0 and var_87_11 or var_87_11 * (var_87_16 / var_87_15)

				if var_87_17 > 0 and var_87_11 < var_87_17 then
					arg_84_1.talkMaxDuration = var_87_17

					if var_87_17 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_17 + var_87_10
					end
				end

				arg_84_1.text_.text = var_87_14
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131021", "story_v_out_324131.awb") ~= 0 then
					local var_87_18 = manager.audio:GetVoiceLength("story_v_out_324131", "324131021", "story_v_out_324131.awb") / 1000

					if var_87_18 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_18 + var_87_10
					end

					if var_87_13.prefab_name ~= "" and arg_84_1.actors_[var_87_13.prefab_name] ~= nil then
						local var_87_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_13.prefab_name].transform, "story_v_out_324131", "324131021", "story_v_out_324131.awb")

						arg_84_1:RecordAudio("324131021", var_87_19)
						arg_84_1:RecordAudio("324131021", var_87_19)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324131", "324131021", "story_v_out_324131.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324131", "324131021", "story_v_out_324131.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_20 = math.max(var_87_11, arg_84_1.talkMaxDuration)

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_20 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_10) / var_87_20

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_10 + var_87_20 and arg_84_1.time_ < var_87_10 + var_87_20 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324131022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324131022
		arg_88_1.duration_ = 8.23

		local var_88_0 = {
			zh = 8.233,
			ja = 6.933
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
				arg_88_0:Play324131023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.8

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[472].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_3 = arg_88_1:GetWordFromCfg(324131022)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 32
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131022", "story_v_out_324131.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131022", "story_v_out_324131.awb") / 1000

					if var_91_8 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_0
					end

					if var_91_3.prefab_name ~= "" and arg_88_1.actors_[var_91_3.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_3.prefab_name].transform, "story_v_out_324131", "324131022", "story_v_out_324131.awb")

						arg_88_1:RecordAudio("324131022", var_91_9)
						arg_88_1:RecordAudio("324131022", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_324131", "324131022", "story_v_out_324131.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_324131", "324131022", "story_v_out_324131.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_10 and arg_88_1.time_ < var_91_0 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play324131023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324131023
		arg_92_1.duration_ = 4.8

		local var_92_0 = {
			zh = 4.2,
			ja = 4.8
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
				arg_92_0:Play324131024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1070ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1070ui_story == nil then
				arg_92_1.var_.characterEffect1070ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1070ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1070ui_story then
				arg_92_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["1053ui_story"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1053ui_story == nil then
				arg_92_1.var_.characterEffect1053ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.200000002980232

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect1053ui_story and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1053ui_story.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1053ui_story then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1053ui_story.fillRatio = var_95_9
			end

			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_95_11 = 0

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_95_12 = 0
			local var_95_13 = 0.475

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_14 = arg_92_1:FormatText(StoryNameCfg[318].name)

				arg_92_1.leftNameTxt_.text = var_95_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_15 = arg_92_1:GetWordFromCfg(324131023)
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

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131023", "story_v_out_324131.awb") ~= 0 then
					local var_95_20 = manager.audio:GetVoiceLength("story_v_out_324131", "324131023", "story_v_out_324131.awb") / 1000

					if var_95_20 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_20 + var_95_12
					end

					if var_95_15.prefab_name ~= "" and arg_92_1.actors_[var_95_15.prefab_name] ~= nil then
						local var_95_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_15.prefab_name].transform, "story_v_out_324131", "324131023", "story_v_out_324131.awb")

						arg_92_1:RecordAudio("324131023", var_95_21)
						arg_92_1:RecordAudio("324131023", var_95_21)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_324131", "324131023", "story_v_out_324131.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_324131", "324131023", "story_v_out_324131.awb")
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
	Play324131024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324131024
		arg_96_1.duration_ = 4.13

		local var_96_0 = {
			zh = 4,
			ja = 4.133
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
				arg_96_0:Play324131025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1053ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1053ui_story == nil then
				arg_96_1.var_.characterEffect1053ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1053ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1053ui_story then
				arg_96_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["1070ui_story"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1070ui_story == nil then
				arg_96_1.var_.characterEffect1070ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.200000002980232

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect1070ui_story and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1070ui_story.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1070ui_story then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1070ui_story.fillRatio = var_99_9
			end

			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action7_1")
			end

			local var_99_11 = 0

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_99_12 = 0
			local var_99_13 = 0.325

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_14 = arg_96_1:FormatText(StoryNameCfg[472].name)

				arg_96_1.leftNameTxt_.text = var_99_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_15 = arg_96_1:GetWordFromCfg(324131024)
				local var_99_16 = arg_96_1:FormatText(var_99_15.content)

				arg_96_1.text_.text = var_99_16

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_17 = 13
				local var_99_18 = utf8.len(var_99_16)
				local var_99_19 = var_99_17 <= 0 and var_99_13 or var_99_13 * (var_99_18 / var_99_17)

				if var_99_19 > 0 and var_99_13 < var_99_19 then
					arg_96_1.talkMaxDuration = var_99_19

					if var_99_19 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_12
					end
				end

				arg_96_1.text_.text = var_99_16
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131024", "story_v_out_324131.awb") ~= 0 then
					local var_99_20 = manager.audio:GetVoiceLength("story_v_out_324131", "324131024", "story_v_out_324131.awb") / 1000

					if var_99_20 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_20 + var_99_12
					end

					if var_99_15.prefab_name ~= "" and arg_96_1.actors_[var_99_15.prefab_name] ~= nil then
						local var_99_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_15.prefab_name].transform, "story_v_out_324131", "324131024", "story_v_out_324131.awb")

						arg_96_1:RecordAudio("324131024", var_99_21)
						arg_96_1:RecordAudio("324131024", var_99_21)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_324131", "324131024", "story_v_out_324131.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_324131", "324131024", "story_v_out_324131.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_22 = math.max(var_99_13, arg_96_1.talkMaxDuration)

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_22 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_12) / var_99_22

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_12 + var_99_22 and arg_96_1.time_ < var_99_12 + var_99_22 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play324131025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324131025
		arg_100_1.duration_ = 10.1

		local var_100_0 = {
			zh = 9,
			ja = 10.1
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
				arg_100_0:Play324131026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1070ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1070ui_story == nil then
				arg_100_1.var_.characterEffect1070ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1070ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1070ui_story then
				arg_100_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["1053ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1053ui_story == nil then
				arg_100_1.var_.characterEffect1053ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.200000002980232

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect1053ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1053ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect1053ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1053ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0
			local var_103_11 = 1.15

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_12 = arg_100_1:FormatText(StoryNameCfg[318].name)

				arg_100_1.leftNameTxt_.text = var_103_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_13 = arg_100_1:GetWordFromCfg(324131025)
				local var_103_14 = arg_100_1:FormatText(var_103_13.content)

				arg_100_1.text_.text = var_103_14

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_15 = 46
				local var_103_16 = utf8.len(var_103_14)
				local var_103_17 = var_103_15 <= 0 and var_103_11 or var_103_11 * (var_103_16 / var_103_15)

				if var_103_17 > 0 and var_103_11 < var_103_17 then
					arg_100_1.talkMaxDuration = var_103_17

					if var_103_17 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_17 + var_103_10
					end
				end

				arg_100_1.text_.text = var_103_14
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131025", "story_v_out_324131.awb") ~= 0 then
					local var_103_18 = manager.audio:GetVoiceLength("story_v_out_324131", "324131025", "story_v_out_324131.awb") / 1000

					if var_103_18 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_18 + var_103_10
					end

					if var_103_13.prefab_name ~= "" and arg_100_1.actors_[var_103_13.prefab_name] ~= nil then
						local var_103_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_13.prefab_name].transform, "story_v_out_324131", "324131025", "story_v_out_324131.awb")

						arg_100_1:RecordAudio("324131025", var_103_19)
						arg_100_1:RecordAudio("324131025", var_103_19)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_324131", "324131025", "story_v_out_324131.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_324131", "324131025", "story_v_out_324131.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_20 = math.max(var_103_11, arg_100_1.talkMaxDuration)

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_20 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_10) / var_103_20

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_10 + var_103_20 and arg_100_1.time_ < var_103_10 + var_103_20 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play324131026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324131026
		arg_104_1.duration_ = 22.27

		local var_104_0 = {
			zh = 14.033,
			ja = 22.266
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
				arg_104_0:Play324131027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 1.525

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[318].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_3 = arg_104_1:GetWordFromCfg(324131026)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 61
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131026", "story_v_out_324131.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131026", "story_v_out_324131.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_324131", "324131026", "story_v_out_324131.awb")

						arg_104_1:RecordAudio("324131026", var_107_9)
						arg_104_1:RecordAudio("324131026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_324131", "324131026", "story_v_out_324131.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_324131", "324131026", "story_v_out_324131.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play324131027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324131027
		arg_108_1.duration_ = 16.07

		local var_108_0 = {
			zh = 11.766,
			ja = 16.066
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
				arg_108_0:Play324131028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_111_2 = 0
			local var_111_3 = 0.95

			if var_111_2 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_4 = arg_108_1:FormatText(StoryNameCfg[318].name)

				arg_108_1.leftNameTxt_.text = var_111_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_5 = arg_108_1:GetWordFromCfg(324131027)
				local var_111_6 = arg_108_1:FormatText(var_111_5.content)

				arg_108_1.text_.text = var_111_6

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 38
				local var_111_8 = utf8.len(var_111_6)
				local var_111_9 = var_111_7 <= 0 and var_111_3 or var_111_3 * (var_111_8 / var_111_7)

				if var_111_9 > 0 and var_111_3 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_6
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131027", "story_v_out_324131.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131027", "story_v_out_324131.awb") / 1000

					if var_111_10 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_2
					end

					if var_111_5.prefab_name ~= "" and arg_108_1.actors_[var_111_5.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_5.prefab_name].transform, "story_v_out_324131", "324131027", "story_v_out_324131.awb")

						arg_108_1:RecordAudio("324131027", var_111_11)
						arg_108_1:RecordAudio("324131027", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_324131", "324131027", "story_v_out_324131.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_324131", "324131027", "story_v_out_324131.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_12 and arg_108_1.time_ < var_111_2 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play324131028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324131028
		arg_112_1.duration_ = 2

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324131029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1053ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1053ui_story == nil then
				arg_112_1.var_.characterEffect1053ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1053ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1053ui_story then
				arg_112_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_115_4 = arg_112_1.actors_["1070ui_story"]
			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1070ui_story == nil then
				arg_112_1.var_.characterEffect1070ui_story = var_115_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_6 = 0.200000002980232

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_6 and not isNil(var_115_4) then
				local var_115_7 = (arg_112_1.time_ - var_115_5) / var_115_6

				if arg_112_1.var_.characterEffect1070ui_story and not isNil(var_115_4) then
					local var_115_8 = Mathf.Lerp(0, 0.5, var_115_7)

					arg_112_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1070ui_story.fillRatio = var_115_8
				end
			end

			if arg_112_1.time_ >= var_115_5 + var_115_6 and arg_112_1.time_ < var_115_5 + var_115_6 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1070ui_story then
				local var_115_9 = 0.5

				arg_112_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1070ui_story.fillRatio = var_115_9
			end

			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action476")
			end

			local var_115_11 = 0

			if var_115_11 < arg_112_1.time_ and arg_112_1.time_ <= var_115_11 + arg_115_0 then
				arg_112_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_115_12 = 0
			local var_115_13 = 0.05

			if var_115_12 < arg_112_1.time_ and arg_112_1.time_ <= var_115_12 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_14 = arg_112_1:FormatText(StoryNameCfg[472].name)

				arg_112_1.leftNameTxt_.text = var_115_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_15 = arg_112_1:GetWordFromCfg(324131028)
				local var_115_16 = arg_112_1:FormatText(var_115_15.content)

				arg_112_1.text_.text = var_115_16

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_17 = 2
				local var_115_18 = utf8.len(var_115_16)
				local var_115_19 = var_115_17 <= 0 and var_115_13 or var_115_13 * (var_115_18 / var_115_17)

				if var_115_19 > 0 and var_115_13 < var_115_19 then
					arg_112_1.talkMaxDuration = var_115_19

					if var_115_19 + var_115_12 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_19 + var_115_12
					end
				end

				arg_112_1.text_.text = var_115_16
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131028", "story_v_out_324131.awb") ~= 0 then
					local var_115_20 = manager.audio:GetVoiceLength("story_v_out_324131", "324131028", "story_v_out_324131.awb") / 1000

					if var_115_20 + var_115_12 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_20 + var_115_12
					end

					if var_115_15.prefab_name ~= "" and arg_112_1.actors_[var_115_15.prefab_name] ~= nil then
						local var_115_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_15.prefab_name].transform, "story_v_out_324131", "324131028", "story_v_out_324131.awb")

						arg_112_1:RecordAudio("324131028", var_115_21)
						arg_112_1:RecordAudio("324131028", var_115_21)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_324131", "324131028", "story_v_out_324131.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_324131", "324131028", "story_v_out_324131.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_22 = math.max(var_115_13, arg_112_1.talkMaxDuration)

			if var_115_12 <= arg_112_1.time_ and arg_112_1.time_ < var_115_12 + var_115_22 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_12) / var_115_22

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_12 + var_115_22 and arg_112_1.time_ < var_115_12 + var_115_22 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play324131029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324131029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play324131030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1070ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1070ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(0, 100, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1070ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, 100, 0)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["1053ui_story"].transform
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1.var_.moveOldPos1053ui_story = var_119_9.localPosition

				local var_119_11 = GameObjectTools.GetOrAddComponent(var_119_9.gameObject, typeof(DynamicBoneHelper))

				if var_119_11 then
					var_119_11:EnableDynamicBone(false)
				end
			end

			local var_119_12 = 0.001

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_12 then
				local var_119_13 = (arg_116_1.time_ - var_119_10) / var_119_12
				local var_119_14 = Vector3.New(0, 100, 0)

				var_119_9.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1053ui_story, var_119_14, var_119_13)

				local var_119_15 = manager.ui.mainCamera.transform.position - var_119_9.position

				var_119_9.forward = Vector3.New(var_119_15.x, var_119_15.y, var_119_15.z)

				local var_119_16 = var_119_9.localEulerAngles

				var_119_16.z = 0
				var_119_16.x = 0
				var_119_9.localEulerAngles = var_119_16
			end

			if arg_116_1.time_ >= var_119_10 + var_119_12 and arg_116_1.time_ < var_119_10 + var_119_12 + arg_119_0 then
				var_119_9.localPosition = Vector3.New(0, 100, 0)

				local var_119_17 = manager.ui.mainCamera.transform.position - var_119_9.position

				var_119_9.forward = Vector3.New(var_119_17.x, var_119_17.y, var_119_17.z)

				local var_119_18 = var_119_9.localEulerAngles

				var_119_18.z = 0
				var_119_18.x = 0
				var_119_9.localEulerAngles = var_119_18

				local var_119_19 = GameObjectTools.GetOrAddComponent(var_119_9.gameObject, typeof(DynamicBoneHelper))

				if var_119_19 then
					var_119_19:EnableDynamicBone(true)
				end
			end

			local var_119_20 = arg_116_1.actors_["1053ui_story"]
			local var_119_21 = 0

			if var_119_21 < arg_116_1.time_ and arg_116_1.time_ <= var_119_21 + arg_119_0 and not isNil(var_119_20) and arg_116_1.var_.characterEffect1053ui_story == nil then
				arg_116_1.var_.characterEffect1053ui_story = var_119_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_22 = 0.200000002980232

			if var_119_21 <= arg_116_1.time_ and arg_116_1.time_ < var_119_21 + var_119_22 and not isNil(var_119_20) then
				local var_119_23 = (arg_116_1.time_ - var_119_21) / var_119_22

				if arg_116_1.var_.characterEffect1053ui_story and not isNil(var_119_20) then
					local var_119_24 = Mathf.Lerp(0, 0.5, var_119_23)

					arg_116_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1053ui_story.fillRatio = var_119_24
				end
			end

			if arg_116_1.time_ >= var_119_21 + var_119_22 and arg_116_1.time_ < var_119_21 + var_119_22 + arg_119_0 and not isNil(var_119_20) and arg_116_1.var_.characterEffect1053ui_story then
				local var_119_25 = 0.5

				arg_116_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1053ui_story.fillRatio = var_119_25
			end

			local var_119_26 = 0
			local var_119_27 = 0.925

			if var_119_26 < arg_116_1.time_ and arg_116_1.time_ <= var_119_26 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_28 = arg_116_1:GetWordFromCfg(324131029)
				local var_119_29 = arg_116_1:FormatText(var_119_28.content)

				arg_116_1.text_.text = var_119_29

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_30 = 37
				local var_119_31 = utf8.len(var_119_29)
				local var_119_32 = var_119_30 <= 0 and var_119_27 or var_119_27 * (var_119_31 / var_119_30)

				if var_119_32 > 0 and var_119_27 < var_119_32 then
					arg_116_1.talkMaxDuration = var_119_32

					if var_119_32 + var_119_26 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_32 + var_119_26
					end
				end

				arg_116_1.text_.text = var_119_29
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_33 = math.max(var_119_27, arg_116_1.talkMaxDuration)

			if var_119_26 <= arg_116_1.time_ and arg_116_1.time_ < var_119_26 + var_119_33 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_26) / var_119_33

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_26 + var_119_33 and arg_116_1.time_ < var_119_26 + var_119_33 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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

		arg_116_1:InitPlayNodeList()
	end,
	Play324131030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324131030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play324131031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.4
			local var_123_1 = 1

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				local var_123_2 = "play"
				local var_123_3 = "effect"

				arg_120_1:AudioAction(var_123_2, var_123_3, "se_story_120", "se_story_120_clap", "")
			end

			local var_123_4 = 0.4
			local var_123_5 = 1

			if var_123_4 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				local var_123_6 = "play"
				local var_123_7 = "effect"

				arg_120_1:AudioAction(var_123_6, var_123_7, "se_story_141", "se_story_141_footstep_walk02", "")
			end

			local var_123_8 = 0
			local var_123_9 = 0.75

			if var_123_8 < arg_120_1.time_ and arg_120_1.time_ <= var_123_8 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_10 = arg_120_1:GetWordFromCfg(324131030)
				local var_123_11 = arg_120_1:FormatText(var_123_10.content)

				arg_120_1.text_.text = var_123_11

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_12 = 30
				local var_123_13 = utf8.len(var_123_11)
				local var_123_14 = var_123_12 <= 0 and var_123_9 or var_123_9 * (var_123_13 / var_123_12)

				if var_123_14 > 0 and var_123_9 < var_123_14 then
					arg_120_1.talkMaxDuration = var_123_14

					if var_123_14 + var_123_8 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_8
					end
				end

				arg_120_1.text_.text = var_123_11
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_15 = math.max(var_123_9, arg_120_1.talkMaxDuration)

			if var_123_8 <= arg_120_1.time_ and arg_120_1.time_ < var_123_8 + var_123_15 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_8) / var_123_15

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_8 + var_123_15 and arg_120_1.time_ < var_123_8 + var_123_15 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play324131031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324131031
		arg_124_1.duration_ = 11.23

		local var_124_0 = {
			zh = 7.5,
			ja = 11.233
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
				arg_124_0:Play324131032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1053ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1053ui_story = var_127_0.localPosition

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end
			end

			local var_127_3 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_3 then
				local var_127_4 = (arg_124_1.time_ - var_127_1) / var_127_3
				local var_127_5 = Vector3.New(0.7, -1.08, -6)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1053ui_story, var_127_5, var_127_4)

				local var_127_6 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_6.x, var_127_6.y, var_127_6.z)

				local var_127_7 = var_127_0.localEulerAngles

				var_127_7.z = 0
				var_127_7.x = 0
				var_127_0.localEulerAngles = var_127_7
			end

			if arg_124_1.time_ >= var_127_1 + var_127_3 and arg_124_1.time_ < var_127_1 + var_127_3 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_127_8 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_8.x, var_127_8.y, var_127_8.z)

				local var_127_9 = var_127_0.localEulerAngles

				var_127_9.z = 0
				var_127_9.x = 0
				var_127_0.localEulerAngles = var_127_9

				local var_127_10 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_10 then
					var_127_10:EnableDynamicBone(true)
				end
			end

			local var_127_11 = arg_124_1.actors_["1053ui_story"]
			local var_127_12 = 0

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect1053ui_story == nil then
				arg_124_1.var_.characterEffect1053ui_story = var_127_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_13 = 0.200000002980232

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_13 and not isNil(var_127_11) then
				local var_127_14 = (arg_124_1.time_ - var_127_12) / var_127_13

				if arg_124_1.var_.characterEffect1053ui_story and not isNil(var_127_11) then
					arg_124_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_12 + var_127_13 and arg_124_1.time_ < var_127_12 + var_127_13 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect1053ui_story then
				arg_124_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_127_15 = 0

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action465")
			end

			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_127_17 = 0
			local var_127_18 = 0.725

			if var_127_17 < arg_124_1.time_ and arg_124_1.time_ <= var_127_17 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_19 = arg_124_1:FormatText(StoryNameCfg[472].name)

				arg_124_1.leftNameTxt_.text = var_127_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_20 = arg_124_1:GetWordFromCfg(324131031)
				local var_127_21 = arg_124_1:FormatText(var_127_20.content)

				arg_124_1.text_.text = var_127_21

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_22 = 29
				local var_127_23 = utf8.len(var_127_21)
				local var_127_24 = var_127_22 <= 0 and var_127_18 or var_127_18 * (var_127_23 / var_127_22)

				if var_127_24 > 0 and var_127_18 < var_127_24 then
					arg_124_1.talkMaxDuration = var_127_24

					if var_127_24 + var_127_17 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_24 + var_127_17
					end
				end

				arg_124_1.text_.text = var_127_21
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131031", "story_v_out_324131.awb") ~= 0 then
					local var_127_25 = manager.audio:GetVoiceLength("story_v_out_324131", "324131031", "story_v_out_324131.awb") / 1000

					if var_127_25 + var_127_17 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_25 + var_127_17
					end

					if var_127_20.prefab_name ~= "" and arg_124_1.actors_[var_127_20.prefab_name] ~= nil then
						local var_127_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_20.prefab_name].transform, "story_v_out_324131", "324131031", "story_v_out_324131.awb")

						arg_124_1:RecordAudio("324131031", var_127_26)
						arg_124_1:RecordAudio("324131031", var_127_26)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_324131", "324131031", "story_v_out_324131.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_324131", "324131031", "story_v_out_324131.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_27 = math.max(var_127_18, arg_124_1.talkMaxDuration)

			if var_127_17 <= arg_124_1.time_ and arg_124_1.time_ < var_127_17 + var_127_27 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_17) / var_127_27

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_17 + var_127_27 and arg_124_1.time_ < var_127_17 + var_127_27 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play324131032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324131032
		arg_128_1.duration_ = 10.13

		local var_128_0 = {
			zh = 10.133,
			ja = 9.8
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
				arg_128_0:Play324131033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1070ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1070ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1070ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["1070ui_story"]
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1070ui_story == nil then
				arg_128_1.var_.characterEffect1070ui_story = var_131_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_11 = 0.200000002980232

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 and not isNil(var_131_9) then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11

				if arg_128_1.var_.characterEffect1070ui_story and not isNil(var_131_9) then
					arg_128_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1070ui_story then
				arg_128_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_131_13 = arg_128_1.actors_["1053ui_story"]
			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 and not isNil(var_131_13) and arg_128_1.var_.characterEffect1053ui_story == nil then
				arg_128_1.var_.characterEffect1053ui_story = var_131_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_15 = 0.200000002980232

			if var_131_14 <= arg_128_1.time_ and arg_128_1.time_ < var_131_14 + var_131_15 and not isNil(var_131_13) then
				local var_131_16 = (arg_128_1.time_ - var_131_14) / var_131_15

				if arg_128_1.var_.characterEffect1053ui_story and not isNil(var_131_13) then
					local var_131_17 = Mathf.Lerp(0, 0.5, var_131_16)

					arg_128_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1053ui_story.fillRatio = var_131_17
				end
			end

			if arg_128_1.time_ >= var_131_14 + var_131_15 and arg_128_1.time_ < var_131_14 + var_131_15 + arg_131_0 and not isNil(var_131_13) and arg_128_1.var_.characterEffect1053ui_story then
				local var_131_18 = 0.5

				arg_128_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1053ui_story.fillRatio = var_131_18
			end

			local var_131_19 = 0

			if var_131_19 < arg_128_1.time_ and arg_128_1.time_ <= var_131_19 + arg_131_0 then
				arg_128_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action446")
			end

			local var_131_20 = 0

			if var_131_20 < arg_128_1.time_ and arg_128_1.time_ <= var_131_20 + arg_131_0 then
				arg_128_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_131_21 = 0
			local var_131_22 = 1.025

			if var_131_21 < arg_128_1.time_ and arg_128_1.time_ <= var_131_21 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_23 = arg_128_1:FormatText(StoryNameCfg[318].name)

				arg_128_1.leftNameTxt_.text = var_131_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_24 = arg_128_1:GetWordFromCfg(324131032)
				local var_131_25 = arg_128_1:FormatText(var_131_24.content)

				arg_128_1.text_.text = var_131_25

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_26 = 41
				local var_131_27 = utf8.len(var_131_25)
				local var_131_28 = var_131_26 <= 0 and var_131_22 or var_131_22 * (var_131_27 / var_131_26)

				if var_131_28 > 0 and var_131_22 < var_131_28 then
					arg_128_1.talkMaxDuration = var_131_28

					if var_131_28 + var_131_21 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_28 + var_131_21
					end
				end

				arg_128_1.text_.text = var_131_25
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131032", "story_v_out_324131.awb") ~= 0 then
					local var_131_29 = manager.audio:GetVoiceLength("story_v_out_324131", "324131032", "story_v_out_324131.awb") / 1000

					if var_131_29 + var_131_21 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_29 + var_131_21
					end

					if var_131_24.prefab_name ~= "" and arg_128_1.actors_[var_131_24.prefab_name] ~= nil then
						local var_131_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_24.prefab_name].transform, "story_v_out_324131", "324131032", "story_v_out_324131.awb")

						arg_128_1:RecordAudio("324131032", var_131_30)
						arg_128_1:RecordAudio("324131032", var_131_30)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324131", "324131032", "story_v_out_324131.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324131", "324131032", "story_v_out_324131.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_31 = math.max(var_131_22, arg_128_1.talkMaxDuration)

			if var_131_21 <= arg_128_1.time_ and arg_128_1.time_ < var_131_21 + var_131_31 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_21) / var_131_31

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_21 + var_131_31 and arg_128_1.time_ < var_131_21 + var_131_31 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play324131033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324131033
		arg_132_1.duration_ = 9

		local var_132_0 = {
			zh = 8.233,
			ja = 9
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
				arg_132_0:Play324131034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.825

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[318].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(324131033)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 33
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131033", "story_v_out_324131.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131033", "story_v_out_324131.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_324131", "324131033", "story_v_out_324131.awb")

						arg_132_1:RecordAudio("324131033", var_135_9)
						arg_132_1:RecordAudio("324131033", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_324131", "324131033", "story_v_out_324131.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_324131", "324131033", "story_v_out_324131.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play324131034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324131034
		arg_136_1.duration_ = 3.17

		local var_136_0 = {
			zh = 2.6,
			ja = 3.166
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
				arg_136_0:Play324131035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1053ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1053ui_story == nil then
				arg_136_1.var_.characterEffect1053ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1053ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1053ui_story then
				arg_136_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["1070ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1070ui_story == nil then
				arg_136_1.var_.characterEffect1070ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.200000002980232

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect1070ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1070ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1070ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1070ui_story.fillRatio = var_139_9
			end

			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			local var_139_11 = 0
			local var_139_12 = 0.225

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_13 = arg_136_1:FormatText(StoryNameCfg[472].name)

				arg_136_1.leftNameTxt_.text = var_139_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_14 = arg_136_1:GetWordFromCfg(324131034)
				local var_139_15 = arg_136_1:FormatText(var_139_14.content)

				arg_136_1.text_.text = var_139_15

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_16 = 9
				local var_139_17 = utf8.len(var_139_15)
				local var_139_18 = var_139_16 <= 0 and var_139_12 or var_139_12 * (var_139_17 / var_139_16)

				if var_139_18 > 0 and var_139_12 < var_139_18 then
					arg_136_1.talkMaxDuration = var_139_18

					if var_139_18 + var_139_11 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_18 + var_139_11
					end
				end

				arg_136_1.text_.text = var_139_15
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131034", "story_v_out_324131.awb") ~= 0 then
					local var_139_19 = manager.audio:GetVoiceLength("story_v_out_324131", "324131034", "story_v_out_324131.awb") / 1000

					if var_139_19 + var_139_11 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_19 + var_139_11
					end

					if var_139_14.prefab_name ~= "" and arg_136_1.actors_[var_139_14.prefab_name] ~= nil then
						local var_139_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_14.prefab_name].transform, "story_v_out_324131", "324131034", "story_v_out_324131.awb")

						arg_136_1:RecordAudio("324131034", var_139_20)
						arg_136_1:RecordAudio("324131034", var_139_20)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_324131", "324131034", "story_v_out_324131.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_324131", "324131034", "story_v_out_324131.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_21 = math.max(var_139_12, arg_136_1.talkMaxDuration)

			if var_139_11 <= arg_136_1.time_ and arg_136_1.time_ < var_139_11 + var_139_21 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_11) / var_139_21

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_11 + var_139_21 and arg_136_1.time_ < var_139_11 + var_139_21 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play324131035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324131035
		arg_140_1.duration_ = 17.2

		local var_140_0 = {
			zh = 11.466,
			ja = 17.2
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
				arg_140_0:Play324131036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1070ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1070ui_story == nil then
				arg_140_1.var_.characterEffect1070ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1070ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1070ui_story then
				arg_140_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_143_4 = arg_140_1.actors_["1053ui_story"]
			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1053ui_story == nil then
				arg_140_1.var_.characterEffect1053ui_story = var_143_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.200000002980232

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 and not isNil(var_143_4) then
				local var_143_7 = (arg_140_1.time_ - var_143_5) / var_143_6

				if arg_140_1.var_.characterEffect1053ui_story and not isNil(var_143_4) then
					local var_143_8 = Mathf.Lerp(0, 0.5, var_143_7)

					arg_140_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1053ui_story.fillRatio = var_143_8
				end
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect1053ui_story then
				local var_143_9 = 0.5

				arg_140_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1053ui_story.fillRatio = var_143_9
			end

			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_143_11 = 0
			local var_143_12 = 1.175

			if var_143_11 < arg_140_1.time_ and arg_140_1.time_ <= var_143_11 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_13 = arg_140_1:FormatText(StoryNameCfg[318].name)

				arg_140_1.leftNameTxt_.text = var_143_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_14 = arg_140_1:GetWordFromCfg(324131035)
				local var_143_15 = arg_140_1:FormatText(var_143_14.content)

				arg_140_1.text_.text = var_143_15

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_16 = 47
				local var_143_17 = utf8.len(var_143_15)
				local var_143_18 = var_143_16 <= 0 and var_143_12 or var_143_12 * (var_143_17 / var_143_16)

				if var_143_18 > 0 and var_143_12 < var_143_18 then
					arg_140_1.talkMaxDuration = var_143_18

					if var_143_18 + var_143_11 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_18 + var_143_11
					end
				end

				arg_140_1.text_.text = var_143_15
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131035", "story_v_out_324131.awb") ~= 0 then
					local var_143_19 = manager.audio:GetVoiceLength("story_v_out_324131", "324131035", "story_v_out_324131.awb") / 1000

					if var_143_19 + var_143_11 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_11
					end

					if var_143_14.prefab_name ~= "" and arg_140_1.actors_[var_143_14.prefab_name] ~= nil then
						local var_143_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_14.prefab_name].transform, "story_v_out_324131", "324131035", "story_v_out_324131.awb")

						arg_140_1:RecordAudio("324131035", var_143_20)
						arg_140_1:RecordAudio("324131035", var_143_20)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_324131", "324131035", "story_v_out_324131.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_324131", "324131035", "story_v_out_324131.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_21 = math.max(var_143_12, arg_140_1.talkMaxDuration)

			if var_143_11 <= arg_140_1.time_ and arg_140_1.time_ < var_143_11 + var_143_21 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_11) / var_143_21

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_11 + var_143_21 and arg_140_1.time_ < var_143_11 + var_143_21 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play324131036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324131036
		arg_144_1.duration_ = 5.4

		local var_144_0 = {
			zh = 3.033,
			ja = 5.4
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play324131037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.225

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[318].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_3 = arg_144_1:GetWordFromCfg(324131036)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 9
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131036", "story_v_out_324131.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131036", "story_v_out_324131.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_324131", "324131036", "story_v_out_324131.awb")

						arg_144_1:RecordAudio("324131036", var_147_9)
						arg_144_1:RecordAudio("324131036", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_324131", "324131036", "story_v_out_324131.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_324131", "324131036", "story_v_out_324131.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play324131037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324131037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324131038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1070ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1070ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1070ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, 100, 0)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["1053ui_story"].transform
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1.var_.moveOldPos1053ui_story = var_151_9.localPosition

				local var_151_11 = GameObjectTools.GetOrAddComponent(var_151_9.gameObject, typeof(DynamicBoneHelper))

				if var_151_11 then
					var_151_11:EnableDynamicBone(false)
				end
			end

			local var_151_12 = 0.001

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_12 then
				local var_151_13 = (arg_148_1.time_ - var_151_10) / var_151_12
				local var_151_14 = Vector3.New(0, 100, 0)

				var_151_9.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1053ui_story, var_151_14, var_151_13)

				local var_151_15 = manager.ui.mainCamera.transform.position - var_151_9.position

				var_151_9.forward = Vector3.New(var_151_15.x, var_151_15.y, var_151_15.z)

				local var_151_16 = var_151_9.localEulerAngles

				var_151_16.z = 0
				var_151_16.x = 0
				var_151_9.localEulerAngles = var_151_16
			end

			if arg_148_1.time_ >= var_151_10 + var_151_12 and arg_148_1.time_ < var_151_10 + var_151_12 + arg_151_0 then
				var_151_9.localPosition = Vector3.New(0, 100, 0)

				local var_151_17 = manager.ui.mainCamera.transform.position - var_151_9.position

				var_151_9.forward = Vector3.New(var_151_17.x, var_151_17.y, var_151_17.z)

				local var_151_18 = var_151_9.localEulerAngles

				var_151_18.z = 0
				var_151_18.x = 0
				var_151_9.localEulerAngles = var_151_18

				local var_151_19 = GameObjectTools.GetOrAddComponent(var_151_9.gameObject, typeof(DynamicBoneHelper))

				if var_151_19 then
					var_151_19:EnableDynamicBone(true)
				end
			end

			local var_151_20 = arg_148_1.actors_["1070ui_story"]
			local var_151_21 = 0

			if var_151_21 < arg_148_1.time_ and arg_148_1.time_ <= var_151_21 + arg_151_0 and not isNil(var_151_20) and arg_148_1.var_.characterEffect1070ui_story == nil then
				arg_148_1.var_.characterEffect1070ui_story = var_151_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_22 = 0.200000002980232

			if var_151_21 <= arg_148_1.time_ and arg_148_1.time_ < var_151_21 + var_151_22 and not isNil(var_151_20) then
				local var_151_23 = (arg_148_1.time_ - var_151_21) / var_151_22

				if arg_148_1.var_.characterEffect1070ui_story and not isNil(var_151_20) then
					local var_151_24 = Mathf.Lerp(0, 0.5, var_151_23)

					arg_148_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1070ui_story.fillRatio = var_151_24
				end
			end

			if arg_148_1.time_ >= var_151_21 + var_151_22 and arg_148_1.time_ < var_151_21 + var_151_22 + arg_151_0 and not isNil(var_151_20) and arg_148_1.var_.characterEffect1070ui_story then
				local var_151_25 = 0.5

				arg_148_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1070ui_story.fillRatio = var_151_25
			end

			local var_151_26 = 0
			local var_151_27 = 0.825

			if var_151_26 < arg_148_1.time_ and arg_148_1.time_ <= var_151_26 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_28 = arg_148_1:GetWordFromCfg(324131037)
				local var_151_29 = arg_148_1:FormatText(var_151_28.content)

				arg_148_1.text_.text = var_151_29

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_30 = 33
				local var_151_31 = utf8.len(var_151_29)
				local var_151_32 = var_151_30 <= 0 and var_151_27 or var_151_27 * (var_151_31 / var_151_30)

				if var_151_32 > 0 and var_151_27 < var_151_32 then
					arg_148_1.talkMaxDuration = var_151_32

					if var_151_32 + var_151_26 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_32 + var_151_26
					end
				end

				arg_148_1.text_.text = var_151_29
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_33 = math.max(var_151_27, arg_148_1.talkMaxDuration)

			if var_151_26 <= arg_148_1.time_ and arg_148_1.time_ < var_151_26 + var_151_33 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_26) / var_151_33

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_26 + var_151_33 and arg_148_1.time_ < var_151_26 + var_151_33 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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

		arg_148_1:InitPlayNodeList()
	end,
	Play324131038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324131038
		arg_152_1.duration_ = 11.6

		local var_152_0 = {
			zh = 9.3,
			ja = 11.6
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
				arg_152_0:Play324131039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1070ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos1070ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(0, -0.95, -6.05)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1070ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["1070ui_story"]
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1070ui_story == nil then
				arg_152_1.var_.characterEffect1070ui_story = var_155_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_11 = 0.200000002980232

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 and not isNil(var_155_9) then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11

				if arg_152_1.var_.characterEffect1070ui_story and not isNil(var_155_9) then
					arg_152_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 and not isNil(var_155_9) and arg_152_1.var_.characterEffect1070ui_story then
				arg_152_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_155_13 = 0

			if var_155_13 < arg_152_1.time_ and arg_152_1.time_ <= var_155_13 + arg_155_0 then
				arg_152_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_155_14 = 0

			if var_155_14 < arg_152_1.time_ and arg_152_1.time_ <= var_155_14 + arg_155_0 then
				arg_152_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_155_15 = 0
			local var_155_16 = 1.1

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[318].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(324131038)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131038", "story_v_out_324131.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_out_324131", "324131038", "story_v_out_324131.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_out_324131", "324131038", "story_v_out_324131.awb")

						arg_152_1:RecordAudio("324131038", var_155_24)
						arg_152_1:RecordAudio("324131038", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324131", "324131038", "story_v_out_324131.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324131", "324131038", "story_v_out_324131.awb")
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
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play324131039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324131039
		arg_156_1.duration_ = 11.93

		local var_156_0 = {
			zh = 11.933,
			ja = 9.333
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324131040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 1.275

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[318].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:GetWordFromCfg(324131039)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 51
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131039", "story_v_out_324131.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131039", "story_v_out_324131.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_324131", "324131039", "story_v_out_324131.awb")

						arg_156_1:RecordAudio("324131039", var_159_9)
						arg_156_1:RecordAudio("324131039", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_324131", "324131039", "story_v_out_324131.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_324131", "324131039", "story_v_out_324131.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_10 and arg_156_1.time_ < var_159_0 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play324131040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324131040
		arg_160_1.duration_ = 12.53

		local var_160_0 = {
			zh = 11.9,
			ja = 12.533
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
				arg_160_0:Play324131041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 1.25

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[318].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:GetWordFromCfg(324131040)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 50
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131040", "story_v_out_324131.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131040", "story_v_out_324131.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_324131", "324131040", "story_v_out_324131.awb")

						arg_160_1:RecordAudio("324131040", var_163_9)
						arg_160_1:RecordAudio("324131040", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_324131", "324131040", "story_v_out_324131.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_324131", "324131040", "story_v_out_324131.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play324131041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324131041
		arg_164_1.duration_ = 11.4

		local var_164_0 = {
			zh = 11.4,
			ja = 9.433
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
				arg_164_0:Play324131042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_167_2 = 0
			local var_167_3 = 1.15

			if var_167_2 < arg_164_1.time_ and arg_164_1.time_ <= var_167_2 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_4 = arg_164_1:FormatText(StoryNameCfg[318].name)

				arg_164_1.leftNameTxt_.text = var_167_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_5 = arg_164_1:GetWordFromCfg(324131041)
				local var_167_6 = arg_164_1:FormatText(var_167_5.content)

				arg_164_1.text_.text = var_167_6

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_7 = 46
				local var_167_8 = utf8.len(var_167_6)
				local var_167_9 = var_167_7 <= 0 and var_167_3 or var_167_3 * (var_167_8 / var_167_7)

				if var_167_9 > 0 and var_167_3 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_2
					end
				end

				arg_164_1.text_.text = var_167_6
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131041", "story_v_out_324131.awb") ~= 0 then
					local var_167_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131041", "story_v_out_324131.awb") / 1000

					if var_167_10 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_2
					end

					if var_167_5.prefab_name ~= "" and arg_164_1.actors_[var_167_5.prefab_name] ~= nil then
						local var_167_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_5.prefab_name].transform, "story_v_out_324131", "324131041", "story_v_out_324131.awb")

						arg_164_1:RecordAudio("324131041", var_167_11)
						arg_164_1:RecordAudio("324131041", var_167_11)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_324131", "324131041", "story_v_out_324131.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_324131", "324131041", "story_v_out_324131.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_12 = math.max(var_167_3, arg_164_1.talkMaxDuration)

			if var_167_2 <= arg_164_1.time_ and arg_164_1.time_ < var_167_2 + var_167_12 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_2) / var_167_12

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_2 + var_167_12 and arg_164_1.time_ < var_167_2 + var_167_12 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play324131042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324131042
		arg_168_1.duration_ = 6.4

		local var_168_0 = {
			zh = 4.3,
			ja = 6.4
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
				arg_168_0:Play324131043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1070ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1070ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(0, 100, 0)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1070ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0, 100, 0)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = arg_168_1.actors_["1053ui_story"].transform
			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 then
				arg_168_1.var_.moveOldPos1053ui_story = var_171_9.localPosition

				local var_171_11 = GameObjectTools.GetOrAddComponent(var_171_9.gameObject, typeof(DynamicBoneHelper))

				if var_171_11 then
					var_171_11:EnableDynamicBone(false)
				end
			end

			local var_171_12 = 0.001

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_12 then
				local var_171_13 = (arg_168_1.time_ - var_171_10) / var_171_12
				local var_171_14 = Vector3.New(0, -1.08, -6)

				var_171_9.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1053ui_story, var_171_14, var_171_13)

				local var_171_15 = manager.ui.mainCamera.transform.position - var_171_9.position

				var_171_9.forward = Vector3.New(var_171_15.x, var_171_15.y, var_171_15.z)

				local var_171_16 = var_171_9.localEulerAngles

				var_171_16.z = 0
				var_171_16.x = 0
				var_171_9.localEulerAngles = var_171_16
			end

			if arg_168_1.time_ >= var_171_10 + var_171_12 and arg_168_1.time_ < var_171_10 + var_171_12 + arg_171_0 then
				var_171_9.localPosition = Vector3.New(0, -1.08, -6)

				local var_171_17 = manager.ui.mainCamera.transform.position - var_171_9.position

				var_171_9.forward = Vector3.New(var_171_17.x, var_171_17.y, var_171_17.z)

				local var_171_18 = var_171_9.localEulerAngles

				var_171_18.z = 0
				var_171_18.x = 0
				var_171_9.localEulerAngles = var_171_18

				local var_171_19 = GameObjectTools.GetOrAddComponent(var_171_9.gameObject, typeof(DynamicBoneHelper))

				if var_171_19 then
					var_171_19:EnableDynamicBone(true)
				end
			end

			local var_171_20 = arg_168_1.actors_["1053ui_story"]
			local var_171_21 = 0

			if var_171_21 < arg_168_1.time_ and arg_168_1.time_ <= var_171_21 + arg_171_0 and not isNil(var_171_20) and arg_168_1.var_.characterEffect1053ui_story == nil then
				arg_168_1.var_.characterEffect1053ui_story = var_171_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_22 = 0.200000002980232

			if var_171_21 <= arg_168_1.time_ and arg_168_1.time_ < var_171_21 + var_171_22 and not isNil(var_171_20) then
				local var_171_23 = (arg_168_1.time_ - var_171_21) / var_171_22

				if arg_168_1.var_.characterEffect1053ui_story and not isNil(var_171_20) then
					arg_168_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_21 + var_171_22 and arg_168_1.time_ < var_171_21 + var_171_22 + arg_171_0 and not isNil(var_171_20) and arg_168_1.var_.characterEffect1053ui_story then
				arg_168_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_171_24 = arg_168_1.actors_["1070ui_story"]
			local var_171_25 = 0

			if var_171_25 < arg_168_1.time_ and arg_168_1.time_ <= var_171_25 + arg_171_0 and not isNil(var_171_24) and arg_168_1.var_.characterEffect1070ui_story == nil then
				arg_168_1.var_.characterEffect1070ui_story = var_171_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_26 = 0.200000002980232

			if var_171_25 <= arg_168_1.time_ and arg_168_1.time_ < var_171_25 + var_171_26 and not isNil(var_171_24) then
				local var_171_27 = (arg_168_1.time_ - var_171_25) / var_171_26

				if arg_168_1.var_.characterEffect1070ui_story and not isNil(var_171_24) then
					local var_171_28 = Mathf.Lerp(0, 0.5, var_171_27)

					arg_168_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1070ui_story.fillRatio = var_171_28
				end
			end

			if arg_168_1.time_ >= var_171_25 + var_171_26 and arg_168_1.time_ < var_171_25 + var_171_26 + arg_171_0 and not isNil(var_171_24) and arg_168_1.var_.characterEffect1070ui_story then
				local var_171_29 = 0.5

				arg_168_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1070ui_story.fillRatio = var_171_29
			end

			local var_171_30 = 0

			if var_171_30 < arg_168_1.time_ and arg_168_1.time_ <= var_171_30 + arg_171_0 then
				arg_168_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_171_31 = 0

			if var_171_31 < arg_168_1.time_ and arg_168_1.time_ <= var_171_31 + arg_171_0 then
				arg_168_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_171_32 = 0
			local var_171_33 = 0.475

			if var_171_32 < arg_168_1.time_ and arg_168_1.time_ <= var_171_32 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_34 = arg_168_1:FormatText(StoryNameCfg[472].name)

				arg_168_1.leftNameTxt_.text = var_171_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_35 = arg_168_1:GetWordFromCfg(324131042)
				local var_171_36 = arg_168_1:FormatText(var_171_35.content)

				arg_168_1.text_.text = var_171_36

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_37 = 19
				local var_171_38 = utf8.len(var_171_36)
				local var_171_39 = var_171_37 <= 0 and var_171_33 or var_171_33 * (var_171_38 / var_171_37)

				if var_171_39 > 0 and var_171_33 < var_171_39 then
					arg_168_1.talkMaxDuration = var_171_39

					if var_171_39 + var_171_32 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_39 + var_171_32
					end
				end

				arg_168_1.text_.text = var_171_36
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131042", "story_v_out_324131.awb") ~= 0 then
					local var_171_40 = manager.audio:GetVoiceLength("story_v_out_324131", "324131042", "story_v_out_324131.awb") / 1000

					if var_171_40 + var_171_32 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_40 + var_171_32
					end

					if var_171_35.prefab_name ~= "" and arg_168_1.actors_[var_171_35.prefab_name] ~= nil then
						local var_171_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_35.prefab_name].transform, "story_v_out_324131", "324131042", "story_v_out_324131.awb")

						arg_168_1:RecordAudio("324131042", var_171_41)
						arg_168_1:RecordAudio("324131042", var_171_41)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_324131", "324131042", "story_v_out_324131.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_324131", "324131042", "story_v_out_324131.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_42 = math.max(var_171_33, arg_168_1.talkMaxDuration)

			if var_171_32 <= arg_168_1.time_ and arg_168_1.time_ < var_171_32 + var_171_42 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_32) / var_171_42

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_32 + var_171_42 and arg_168_1.time_ < var_171_32 + var_171_42 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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

		arg_168_1:InitPlayNodeList()
	end,
	Play324131043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324131043
		arg_172_1.duration_ = 15.07

		local var_172_0 = {
			zh = 11.066,
			ja = 15.066
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
				arg_172_0:Play324131044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1070ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos1070ui_story = var_175_0.localPosition
			end

			local var_175_2 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2
				local var_175_4 = Vector3.New(0, -0.95, -6.05)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1070ui_story, var_175_4, var_175_3)

				local var_175_5 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_5.x, var_175_5.y, var_175_5.z)

				local var_175_6 = var_175_0.localEulerAngles

				var_175_6.z = 0
				var_175_6.x = 0
				var_175_0.localEulerAngles = var_175_6
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_175_7 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_7.x, var_175_7.y, var_175_7.z)

				local var_175_8 = var_175_0.localEulerAngles

				var_175_8.z = 0
				var_175_8.x = 0
				var_175_0.localEulerAngles = var_175_8
			end

			local var_175_9 = arg_172_1.actors_["1053ui_story"].transform
			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1.var_.moveOldPos1053ui_story = var_175_9.localPosition

				local var_175_11 = GameObjectTools.GetOrAddComponent(var_175_9.gameObject, typeof(DynamicBoneHelper))

				if var_175_11 then
					var_175_11:EnableDynamicBone(false)
				end
			end

			local var_175_12 = 0.001

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_12 then
				local var_175_13 = (arg_172_1.time_ - var_175_10) / var_175_12
				local var_175_14 = Vector3.New(0, 100, 0)

				var_175_9.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1053ui_story, var_175_14, var_175_13)

				local var_175_15 = manager.ui.mainCamera.transform.position - var_175_9.position

				var_175_9.forward = Vector3.New(var_175_15.x, var_175_15.y, var_175_15.z)

				local var_175_16 = var_175_9.localEulerAngles

				var_175_16.z = 0
				var_175_16.x = 0
				var_175_9.localEulerAngles = var_175_16
			end

			if arg_172_1.time_ >= var_175_10 + var_175_12 and arg_172_1.time_ < var_175_10 + var_175_12 + arg_175_0 then
				var_175_9.localPosition = Vector3.New(0, 100, 0)

				local var_175_17 = manager.ui.mainCamera.transform.position - var_175_9.position

				var_175_9.forward = Vector3.New(var_175_17.x, var_175_17.y, var_175_17.z)

				local var_175_18 = var_175_9.localEulerAngles

				var_175_18.z = 0
				var_175_18.x = 0
				var_175_9.localEulerAngles = var_175_18

				local var_175_19 = GameObjectTools.GetOrAddComponent(var_175_9.gameObject, typeof(DynamicBoneHelper))

				if var_175_19 then
					var_175_19:EnableDynamicBone(true)
				end
			end

			local var_175_20 = arg_172_1.actors_["1070ui_story"]
			local var_175_21 = 0

			if var_175_21 < arg_172_1.time_ and arg_172_1.time_ <= var_175_21 + arg_175_0 and not isNil(var_175_20) and arg_172_1.var_.characterEffect1070ui_story == nil then
				arg_172_1.var_.characterEffect1070ui_story = var_175_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_22 = 0.200000002980232

			if var_175_21 <= arg_172_1.time_ and arg_172_1.time_ < var_175_21 + var_175_22 and not isNil(var_175_20) then
				local var_175_23 = (arg_172_1.time_ - var_175_21) / var_175_22

				if arg_172_1.var_.characterEffect1070ui_story and not isNil(var_175_20) then
					arg_172_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_21 + var_175_22 and arg_172_1.time_ < var_175_21 + var_175_22 + arg_175_0 and not isNil(var_175_20) and arg_172_1.var_.characterEffect1070ui_story then
				arg_172_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_175_24 = arg_172_1.actors_["1053ui_story"]
			local var_175_25 = 0

			if var_175_25 < arg_172_1.time_ and arg_172_1.time_ <= var_175_25 + arg_175_0 and not isNil(var_175_24) and arg_172_1.var_.characterEffect1053ui_story == nil then
				arg_172_1.var_.characterEffect1053ui_story = var_175_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_26 = 0.200000002980232

			if var_175_25 <= arg_172_1.time_ and arg_172_1.time_ < var_175_25 + var_175_26 and not isNil(var_175_24) then
				local var_175_27 = (arg_172_1.time_ - var_175_25) / var_175_26

				if arg_172_1.var_.characterEffect1053ui_story and not isNil(var_175_24) then
					local var_175_28 = Mathf.Lerp(0, 0.5, var_175_27)

					arg_172_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1053ui_story.fillRatio = var_175_28
				end
			end

			if arg_172_1.time_ >= var_175_25 + var_175_26 and arg_172_1.time_ < var_175_25 + var_175_26 + arg_175_0 and not isNil(var_175_24) and arg_172_1.var_.characterEffect1053ui_story then
				local var_175_29 = 0.5

				arg_172_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1053ui_story.fillRatio = var_175_29
			end

			local var_175_30 = 0

			if var_175_30 < arg_172_1.time_ and arg_172_1.time_ <= var_175_30 + arg_175_0 then
				arg_172_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_175_31 = 0

			if var_175_31 < arg_172_1.time_ and arg_172_1.time_ <= var_175_31 + arg_175_0 then
				arg_172_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_175_32 = 0
			local var_175_33 = 1.2

			if var_175_32 < arg_172_1.time_ and arg_172_1.time_ <= var_175_32 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_34 = arg_172_1:FormatText(StoryNameCfg[318].name)

				arg_172_1.leftNameTxt_.text = var_175_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_35 = arg_172_1:GetWordFromCfg(324131043)
				local var_175_36 = arg_172_1:FormatText(var_175_35.content)

				arg_172_1.text_.text = var_175_36

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_37 = 48
				local var_175_38 = utf8.len(var_175_36)
				local var_175_39 = var_175_37 <= 0 and var_175_33 or var_175_33 * (var_175_38 / var_175_37)

				if var_175_39 > 0 and var_175_33 < var_175_39 then
					arg_172_1.talkMaxDuration = var_175_39

					if var_175_39 + var_175_32 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_39 + var_175_32
					end
				end

				arg_172_1.text_.text = var_175_36
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131043", "story_v_out_324131.awb") ~= 0 then
					local var_175_40 = manager.audio:GetVoiceLength("story_v_out_324131", "324131043", "story_v_out_324131.awb") / 1000

					if var_175_40 + var_175_32 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_40 + var_175_32
					end

					if var_175_35.prefab_name ~= "" and arg_172_1.actors_[var_175_35.prefab_name] ~= nil then
						local var_175_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_35.prefab_name].transform, "story_v_out_324131", "324131043", "story_v_out_324131.awb")

						arg_172_1:RecordAudio("324131043", var_175_41)
						arg_172_1:RecordAudio("324131043", var_175_41)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_324131", "324131043", "story_v_out_324131.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_324131", "324131043", "story_v_out_324131.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_42 = math.max(var_175_33, arg_172_1.talkMaxDuration)

			if var_175_32 <= arg_172_1.time_ and arg_172_1.time_ < var_175_32 + var_175_42 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_32) / var_175_42

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_32 + var_175_42 and arg_172_1.time_ < var_175_32 + var_175_42 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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

		arg_172_1:InitPlayNodeList()
	end,
	Play324131044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 324131044
		arg_176_1.duration_ = 12.73

		local var_176_0 = {
			zh = 11.566,
			ja = 12.733
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
				arg_176_0:Play324131045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 1.325

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[318].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_3 = arg_176_1:GetWordFromCfg(324131044)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 53
				local var_179_6 = utf8.len(var_179_4)
				local var_179_7 = var_179_5 <= 0 and var_179_1 or var_179_1 * (var_179_6 / var_179_5)

				if var_179_7 > 0 and var_179_1 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131044", "story_v_out_324131.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131044", "story_v_out_324131.awb") / 1000

					if var_179_8 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_0
					end

					if var_179_3.prefab_name ~= "" and arg_176_1.actors_[var_179_3.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_3.prefab_name].transform, "story_v_out_324131", "324131044", "story_v_out_324131.awb")

						arg_176_1:RecordAudio("324131044", var_179_9)
						arg_176_1:RecordAudio("324131044", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_324131", "324131044", "story_v_out_324131.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_324131", "324131044", "story_v_out_324131.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_10 and arg_176_1.time_ < var_179_0 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play324131045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 324131045
		arg_180_1.duration_ = 8.8

		local var_180_0 = {
			zh = 8.8,
			ja = 8.433
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
				arg_180_0:Play324131046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_183_2 = 0
			local var_183_3 = 0.65

			if var_183_2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_4 = arg_180_1:FormatText(StoryNameCfg[318].name)

				arg_180_1.leftNameTxt_.text = var_183_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_5 = arg_180_1:GetWordFromCfg(324131045)
				local var_183_6 = arg_180_1:FormatText(var_183_5.content)

				arg_180_1.text_.text = var_183_6

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131045", "story_v_out_324131.awb") ~= 0 then
					local var_183_10 = manager.audio:GetVoiceLength("story_v_out_324131", "324131045", "story_v_out_324131.awb") / 1000

					if var_183_10 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_2
					end

					if var_183_5.prefab_name ~= "" and arg_180_1.actors_[var_183_5.prefab_name] ~= nil then
						local var_183_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_5.prefab_name].transform, "story_v_out_324131", "324131045", "story_v_out_324131.awb")

						arg_180_1:RecordAudio("324131045", var_183_11)
						arg_180_1:RecordAudio("324131045", var_183_11)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_324131", "324131045", "story_v_out_324131.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_324131", "324131045", "story_v_out_324131.awb")
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
	Play324131046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 324131046
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play324131047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1070ui_story"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos1070ui_story = var_187_0.localPosition
			end

			local var_187_2 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2
				local var_187_4 = Vector3.New(0, 100, 0)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1070ui_story, var_187_4, var_187_3)

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

			local var_187_9 = arg_184_1.actors_["1070ui_story"]
			local var_187_10 = 0

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 and not isNil(var_187_9) and arg_184_1.var_.characterEffect1070ui_story == nil then
				arg_184_1.var_.characterEffect1070ui_story = var_187_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_11 = 0.200000002980232

			if var_187_10 <= arg_184_1.time_ and arg_184_1.time_ < var_187_10 + var_187_11 and not isNil(var_187_9) then
				local var_187_12 = (arg_184_1.time_ - var_187_10) / var_187_11

				if arg_184_1.var_.characterEffect1070ui_story and not isNil(var_187_9) then
					local var_187_13 = Mathf.Lerp(0, 0.5, var_187_12)

					arg_184_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1070ui_story.fillRatio = var_187_13
				end
			end

			if arg_184_1.time_ >= var_187_10 + var_187_11 and arg_184_1.time_ < var_187_10 + var_187_11 + arg_187_0 and not isNil(var_187_9) and arg_184_1.var_.characterEffect1070ui_story then
				local var_187_14 = 0.5

				arg_184_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1070ui_story.fillRatio = var_187_14
			end

			local var_187_15 = 0
			local var_187_16 = 0.6

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_17 = arg_184_1:GetWordFromCfg(324131046)
				local var_187_18 = arg_184_1:FormatText(var_187_17.content)

				arg_184_1.text_.text = var_187_18

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_19 = 24
				local var_187_20 = utf8.len(var_187_18)
				local var_187_21 = var_187_19 <= 0 and var_187_16 or var_187_16 * (var_187_20 / var_187_19)

				if var_187_21 > 0 and var_187_16 < var_187_21 then
					arg_184_1.talkMaxDuration = var_187_21

					if var_187_21 + var_187_15 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_21 + var_187_15
					end
				end

				arg_184_1.text_.text = var_187_18
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_22 = math.max(var_187_16, arg_184_1.talkMaxDuration)

			if var_187_15 <= arg_184_1.time_ and arg_184_1.time_ < var_187_15 + var_187_22 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_15) / var_187_22

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_15 + var_187_22 and arg_184_1.time_ < var_187_15 + var_187_22 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play324131047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 324131047
		arg_188_1.duration_ = 7.87

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play324131048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = "J22f"

			if arg_188_1.bgs_[var_191_0] == nil then
				local var_191_1 = Object.Instantiate(arg_188_1.paintGo_)

				var_191_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_191_0)
				var_191_1.name = var_191_0
				var_191_1.transform.parent = arg_188_1.stage_.transform
				var_191_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.bgs_[var_191_0] = var_191_1
			end

			local var_191_2 = 1.46666666666567

			if var_191_2 < arg_188_1.time_ and arg_188_1.time_ <= var_191_2 + arg_191_0 then
				local var_191_3 = manager.ui.mainCamera.transform.localPosition
				local var_191_4 = Vector3.New(0, 0, 10) + Vector3.New(var_191_3.x, var_191_3.y, 0)
				local var_191_5 = arg_188_1.bgs_.J22f

				var_191_5.transform.localPosition = var_191_4
				var_191_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_191_6 = var_191_5:GetComponent("SpriteRenderer")

				if var_191_6 and var_191_6.sprite then
					local var_191_7 = (var_191_5.transform.localPosition - var_191_3).z
					local var_191_8 = manager.ui.mainCameraCom_
					local var_191_9 = 2 * var_191_7 * Mathf.Tan(var_191_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_191_10 = var_191_9 * var_191_8.aspect
					local var_191_11 = var_191_6.sprite.bounds.size.x
					local var_191_12 = var_191_6.sprite.bounds.size.y
					local var_191_13 = var_191_10 / var_191_11
					local var_191_14 = var_191_9 / var_191_12
					local var_191_15 = var_191_14 < var_191_13 and var_191_13 or var_191_14

					var_191_5.transform.localScale = Vector3.New(var_191_15, var_191_15, 0)
				end

				for iter_191_0, iter_191_1 in pairs(arg_188_1.bgs_) do
					if iter_191_0 ~= "J22f" then
						iter_191_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_191_16 = 0.466666666666667

			if var_191_16 < arg_188_1.time_ and arg_188_1.time_ <= var_191_16 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			local var_191_17 = 0.3

			if arg_188_1.time_ >= var_191_16 + var_191_17 and arg_188_1.time_ < var_191_16 + var_191_17 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end

			local var_191_18 = 0

			if var_191_18 < arg_188_1.time_ and arg_188_1.time_ <= var_191_18 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_19 = 1.46666666666667

			if var_191_18 <= arg_188_1.time_ and arg_188_1.time_ < var_191_18 + var_191_19 then
				local var_191_20 = (arg_188_1.time_ - var_191_18) / var_191_19
				local var_191_21 = Color.New(0, 0, 0)

				var_191_21.a = Mathf.Lerp(0, 1, var_191_20)
				arg_188_1.mask_.color = var_191_21
			end

			if arg_188_1.time_ >= var_191_18 + var_191_19 and arg_188_1.time_ < var_191_18 + var_191_19 + arg_191_0 then
				local var_191_22 = Color.New(0, 0, 0)

				var_191_22.a = 1
				arg_188_1.mask_.color = var_191_22
			end

			local var_191_23 = 1.46666666666667

			if var_191_23 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_24 = 2

			if var_191_23 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_24 then
				local var_191_25 = (arg_188_1.time_ - var_191_23) / var_191_24
				local var_191_26 = Color.New(0, 0, 0)

				var_191_26.a = Mathf.Lerp(1, 0, var_191_25)
				arg_188_1.mask_.color = var_191_26
			end

			if arg_188_1.time_ >= var_191_23 + var_191_24 and arg_188_1.time_ < var_191_23 + var_191_24 + arg_191_0 then
				local var_191_27 = Color.New(0, 0, 0)
				local var_191_28 = 0

				arg_188_1.mask_.enabled = false
				var_191_27.a = var_191_28
				arg_188_1.mask_.color = var_191_27
			end

			local var_191_29 = 1.46666666666567

			arg_188_1.isInRecall_ = true

			if var_191_29 < arg_188_1.time_ and arg_188_1.time_ <= var_191_29 + arg_191_0 then
				arg_188_1.screenFilterGo_:SetActive(true)

				arg_188_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_188_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_188_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_191_2, iter_191_3 in pairs(arg_188_1.actors_) do
					local var_191_30 = iter_191_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_191_4, iter_191_5 in ipairs(var_191_30) do
						if iter_191_5.color.r > 0.51 then
							iter_191_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_191_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_191_31 = 0.0166666666666667

			if var_191_29 <= arg_188_1.time_ and arg_188_1.time_ < var_191_29 + var_191_31 then
				local var_191_32 = (arg_188_1.time_ - var_191_29) / var_191_31

				arg_188_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_191_32)
			end

			if arg_188_1.time_ >= var_191_29 + var_191_31 and arg_188_1.time_ < var_191_29 + var_191_31 + arg_191_0 then
				arg_188_1.screenFilterEffect_.weight = 1
			end

			local var_191_33 = 1.2
			local var_191_34 = 1

			if var_191_33 < arg_188_1.time_ and arg_188_1.time_ <= var_191_33 + arg_191_0 then
				local var_191_35 = "play"
				local var_191_36 = "effect"

				arg_188_1:AudioAction(var_191_35, var_191_36, "se_story_148", "se_story_148_amb_lost_city", "")
			end

			if arg_188_1.frameCnt_ <= 1 then
				arg_188_1.dialog_:SetActive(false)
			end

			local var_191_37 = 2.86666666666667
			local var_191_38 = 0.425

			if var_191_37 < arg_188_1.time_ and arg_188_1.time_ <= var_191_37 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				arg_188_1.dialog_:SetActive(true)

				arg_188_1.dialogCg_.alpha = 0

				local var_191_39 = LeanTween.value(arg_188_1.dialog_, 0, 1, 0.3)

				var_191_39:setOnUpdate(LuaHelper.FloatAction(function(arg_192_0)
					arg_188_1.dialogCg_.alpha = arg_192_0
				end))
				var_191_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_188_1.dialog_)
					var_191_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_188_1.duration_ = arg_188_1.duration_ + 0.3

				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_40 = arg_188_1:FormatText(StoryNameCfg[7].name)

				arg_188_1.leftNameTxt_.text = var_191_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_188_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_191_41 = arg_188_1:GetWordFromCfg(324131047)
				local var_191_42 = arg_188_1:FormatText(var_191_41.content)

				arg_188_1.text_.text = var_191_42

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_43 = 17
				local var_191_44 = utf8.len(var_191_42)
				local var_191_45 = var_191_43 <= 0 and var_191_38 or var_191_38 * (var_191_44 / var_191_43)

				if var_191_45 > 0 and var_191_38 < var_191_45 then
					arg_188_1.talkMaxDuration = var_191_45
					var_191_37 = var_191_37 + 0.3

					if var_191_45 + var_191_37 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_45 + var_191_37
					end
				end

				arg_188_1.text_.text = var_191_42
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_46 = var_191_37 + 0.3
			local var_191_47 = math.max(var_191_38, arg_188_1.talkMaxDuration)

			if var_191_46 <= arg_188_1.time_ and arg_188_1.time_ < var_191_46 + var_191_47 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_46) / var_191_47

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_46 + var_191_47 and arg_188_1.time_ < var_191_46 + var_191_47 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play324131048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 324131048
		arg_194_1.duration_ = 11.4

		local var_194_0 = {
			zh = 9.29933333333333,
			ja = 11.3993333333333
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play324131049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 1.76666666666667

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				local var_197_1 = manager.ui.mainCamera.transform.localPosition
				local var_197_2 = Vector3.New(0, 0, 10) + Vector3.New(var_197_1.x, var_197_1.y, 0)
				local var_197_3 = arg_194_1.bgs_.ST2003

				var_197_3.transform.localPosition = var_197_2
				var_197_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_197_4 = var_197_3:GetComponent("SpriteRenderer")

				if var_197_4 and var_197_4.sprite then
					local var_197_5 = (var_197_3.transform.localPosition - var_197_1).z
					local var_197_6 = manager.ui.mainCameraCom_
					local var_197_7 = 2 * var_197_5 * Mathf.Tan(var_197_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_197_8 = var_197_7 * var_197_6.aspect
					local var_197_9 = var_197_4.sprite.bounds.size.x
					local var_197_10 = var_197_4.sprite.bounds.size.y
					local var_197_11 = var_197_8 / var_197_9
					local var_197_12 = var_197_7 / var_197_10
					local var_197_13 = var_197_12 < var_197_11 and var_197_11 or var_197_12

					var_197_3.transform.localScale = Vector3.New(var_197_13, var_197_13, 0)
				end

				for iter_197_0, iter_197_1 in pairs(arg_194_1.bgs_) do
					if iter_197_0 ~= "ST2003" then
						iter_197_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_197_14 = 1.76666666666667

			if var_197_14 < arg_194_1.time_ and arg_194_1.time_ <= var_197_14 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			local var_197_15 = 0.3

			if arg_194_1.time_ >= var_197_14 + var_197_15 and arg_194_1.time_ < var_197_14 + var_197_15 + arg_197_0 then
				arg_194_1.allBtn_.enabled = true
			end

			local var_197_16 = 0

			if var_197_16 < arg_194_1.time_ and arg_194_1.time_ <= var_197_16 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_17 = 1.76666666666667

			if var_197_16 <= arg_194_1.time_ and arg_194_1.time_ < var_197_16 + var_197_17 then
				local var_197_18 = (arg_194_1.time_ - var_197_16) / var_197_17
				local var_197_19 = Color.New(0, 0, 0)

				var_197_19.a = Mathf.Lerp(0, 1, var_197_18)
				arg_194_1.mask_.color = var_197_19
			end

			if arg_194_1.time_ >= var_197_16 + var_197_17 and arg_194_1.time_ < var_197_16 + var_197_17 + arg_197_0 then
				local var_197_20 = Color.New(0, 0, 0)

				var_197_20.a = 1
				arg_194_1.mask_.color = var_197_20
			end

			local var_197_21 = 1.76666666666667

			if var_197_21 < arg_194_1.time_ and arg_194_1.time_ <= var_197_21 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_22 = 2

			if var_197_21 <= arg_194_1.time_ and arg_194_1.time_ < var_197_21 + var_197_22 then
				local var_197_23 = (arg_194_1.time_ - var_197_21) / var_197_22
				local var_197_24 = Color.New(0, 0, 0)

				var_197_24.a = Mathf.Lerp(1, 0, var_197_23)
				arg_194_1.mask_.color = var_197_24
			end

			if arg_194_1.time_ >= var_197_21 + var_197_22 and arg_194_1.time_ < var_197_21 + var_197_22 + arg_197_0 then
				local var_197_25 = Color.New(0, 0, 0)
				local var_197_26 = 0

				arg_194_1.mask_.enabled = false
				var_197_25.a = var_197_26
				arg_194_1.mask_.color = var_197_25
			end

			local var_197_27 = arg_194_1.actors_["1070ui_story"].transform
			local var_197_28 = 3.13333333333333

			if var_197_28 < arg_194_1.time_ and arg_194_1.time_ <= var_197_28 + arg_197_0 then
				arg_194_1.var_.moveOldPos1070ui_story = var_197_27.localPosition
			end

			local var_197_29 = 0.001

			if var_197_28 <= arg_194_1.time_ and arg_194_1.time_ < var_197_28 + var_197_29 then
				local var_197_30 = (arg_194_1.time_ - var_197_28) / var_197_29
				local var_197_31 = Vector3.New(0, -0.95, -6.05)

				var_197_27.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1070ui_story, var_197_31, var_197_30)

				local var_197_32 = manager.ui.mainCamera.transform.position - var_197_27.position

				var_197_27.forward = Vector3.New(var_197_32.x, var_197_32.y, var_197_32.z)

				local var_197_33 = var_197_27.localEulerAngles

				var_197_33.z = 0
				var_197_33.x = 0
				var_197_27.localEulerAngles = var_197_33
			end

			if arg_194_1.time_ >= var_197_28 + var_197_29 and arg_194_1.time_ < var_197_28 + var_197_29 + arg_197_0 then
				var_197_27.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_197_34 = manager.ui.mainCamera.transform.position - var_197_27.position

				var_197_27.forward = Vector3.New(var_197_34.x, var_197_34.y, var_197_34.z)

				local var_197_35 = var_197_27.localEulerAngles

				var_197_35.z = 0
				var_197_35.x = 0
				var_197_27.localEulerAngles = var_197_35
			end

			local var_197_36 = arg_194_1.actors_["1070ui_story"]
			local var_197_37 = 3.13333333333333

			if var_197_37 < arg_194_1.time_ and arg_194_1.time_ <= var_197_37 + arg_197_0 and not isNil(var_197_36) and arg_194_1.var_.characterEffect1070ui_story == nil then
				arg_194_1.var_.characterEffect1070ui_story = var_197_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_38 = 0.200000002980232

			if var_197_37 <= arg_194_1.time_ and arg_194_1.time_ < var_197_37 + var_197_38 and not isNil(var_197_36) then
				local var_197_39 = (arg_194_1.time_ - var_197_37) / var_197_38

				if arg_194_1.var_.characterEffect1070ui_story and not isNil(var_197_36) then
					arg_194_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_37 + var_197_38 and arg_194_1.time_ < var_197_37 + var_197_38 + arg_197_0 and not isNil(var_197_36) and arg_194_1.var_.characterEffect1070ui_story then
				arg_194_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_197_40 = 3.13333333333333

			if var_197_40 < arg_194_1.time_ and arg_194_1.time_ <= var_197_40 + arg_197_0 then
				arg_194_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_197_41 = 3.13333333333333

			if var_197_41 < arg_194_1.time_ and arg_194_1.time_ <= var_197_41 + arg_197_0 then
				arg_194_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_197_42 = 1.76666666666667

			arg_194_1.isInRecall_ = false

			if var_197_42 < arg_194_1.time_ and arg_194_1.time_ <= var_197_42 + arg_197_0 then
				arg_194_1.screenFilterGo_:SetActive(false)

				for iter_197_2, iter_197_3 in pairs(arg_194_1.actors_) do
					local var_197_43 = iter_197_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_197_4, iter_197_5 in ipairs(var_197_43) do
						if iter_197_5.color.r > 0.51 then
							iter_197_5.color = Color.New(1, 1, 1)
						else
							iter_197_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_197_44 = 0.0166666666666667

			if var_197_42 <= arg_194_1.time_ and arg_194_1.time_ < var_197_42 + var_197_44 then
				local var_197_45 = (arg_194_1.time_ - var_197_42) / var_197_44

				arg_194_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_197_45)
			end

			if arg_194_1.time_ >= var_197_42 + var_197_44 and arg_194_1.time_ < var_197_42 + var_197_44 + arg_197_0 then
				arg_194_1.screenFilterEffect_.weight = 0
			end

			local var_197_46 = 1.2
			local var_197_47 = 1

			if var_197_46 < arg_194_1.time_ and arg_194_1.time_ <= var_197_46 + arg_197_0 then
				local var_197_48 = "play"
				local var_197_49 = "effect"

				arg_194_1:AudioAction(var_197_48, var_197_49, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_197_50 = 0.1
			local var_197_51 = 1

			if var_197_50 < arg_194_1.time_ and arg_194_1.time_ <= var_197_50 + arg_197_0 then
				local var_197_52 = "stop"
				local var_197_53 = "effect"

				arg_194_1:AudioAction(var_197_52, var_197_53, "se_story_148", "se_story_148_amb_lost_city", "")
			end

			if arg_194_1.frameCnt_ <= 1 then
				arg_194_1.dialog_:SetActive(false)
			end

			local var_197_54 = 3.43333333333333
			local var_197_55 = 0.7

			if var_197_54 < arg_194_1.time_ and arg_194_1.time_ <= var_197_54 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0

				arg_194_1.dialog_:SetActive(true)

				arg_194_1.dialogCg_.alpha = 0

				local var_197_56 = LeanTween.value(arg_194_1.dialog_, 0, 1, 0.3)

				var_197_56:setOnUpdate(LuaHelper.FloatAction(function(arg_198_0)
					arg_194_1.dialogCg_.alpha = arg_198_0
				end))
				var_197_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_194_1.dialog_)
					var_197_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_194_1.duration_ = arg_194_1.duration_ + 0.3

				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_57 = arg_194_1:FormatText(StoryNameCfg[318].name)

				arg_194_1.leftNameTxt_.text = var_197_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_58 = arg_194_1:GetWordFromCfg(324131048)
				local var_197_59 = arg_194_1:FormatText(var_197_58.content)

				arg_194_1.text_.text = var_197_59

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_60 = 28
				local var_197_61 = utf8.len(var_197_59)
				local var_197_62 = var_197_60 <= 0 and var_197_55 or var_197_55 * (var_197_61 / var_197_60)

				if var_197_62 > 0 and var_197_55 < var_197_62 then
					arg_194_1.talkMaxDuration = var_197_62
					var_197_54 = var_197_54 + 0.3

					if var_197_62 + var_197_54 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_62 + var_197_54
					end
				end

				arg_194_1.text_.text = var_197_59
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131048", "story_v_out_324131.awb") ~= 0 then
					local var_197_63 = manager.audio:GetVoiceLength("story_v_out_324131", "324131048", "story_v_out_324131.awb") / 1000

					if var_197_63 + var_197_54 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_63 + var_197_54
					end

					if var_197_58.prefab_name ~= "" and arg_194_1.actors_[var_197_58.prefab_name] ~= nil then
						local var_197_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_58.prefab_name].transform, "story_v_out_324131", "324131048", "story_v_out_324131.awb")

						arg_194_1:RecordAudio("324131048", var_197_64)
						arg_194_1:RecordAudio("324131048", var_197_64)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_324131", "324131048", "story_v_out_324131.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_324131", "324131048", "story_v_out_324131.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_65 = var_197_54 + 0.3
			local var_197_66 = math.max(var_197_55, arg_194_1.talkMaxDuration)

			if var_197_65 <= arg_194_1.time_ and arg_194_1.time_ < var_197_65 + var_197_66 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_65) / var_197_66

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_65 + var_197_66 and arg_194_1.time_ < var_197_65 + var_197_66 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.13333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play324131049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324131049
		arg_200_1.duration_ = 3

		local var_200_0 = {
			zh = 2.566,
			ja = 3
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
				arg_200_0:Play324131050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.2

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[318].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_3 = arg_200_1:GetWordFromCfg(324131049)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131049", "story_v_out_324131.awb") ~= 0 then
					local var_203_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131049", "story_v_out_324131.awb") / 1000

					if var_203_8 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_8 + var_203_0
					end

					if var_203_3.prefab_name ~= "" and arg_200_1.actors_[var_203_3.prefab_name] ~= nil then
						local var_203_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_3.prefab_name].transform, "story_v_out_324131", "324131049", "story_v_out_324131.awb")

						arg_200_1:RecordAudio("324131049", var_203_9)
						arg_200_1:RecordAudio("324131049", var_203_9)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_324131", "324131049", "story_v_out_324131.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_324131", "324131049", "story_v_out_324131.awb")
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
	Play324131050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324131050
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play324131051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1070ui_story"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos1070ui_story = var_207_0.localPosition
			end

			local var_207_2 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2
				local var_207_4 = Vector3.New(0, 100, 0)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1070ui_story, var_207_4, var_207_3)

				local var_207_5 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_5.x, var_207_5.y, var_207_5.z)

				local var_207_6 = var_207_0.localEulerAngles

				var_207_6.z = 0
				var_207_6.x = 0
				var_207_0.localEulerAngles = var_207_6
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(0, 100, 0)

				local var_207_7 = manager.ui.mainCamera.transform.position - var_207_0.position

				var_207_0.forward = Vector3.New(var_207_7.x, var_207_7.y, var_207_7.z)

				local var_207_8 = var_207_0.localEulerAngles

				var_207_8.z = 0
				var_207_8.x = 0
				var_207_0.localEulerAngles = var_207_8
			end

			local var_207_9 = arg_204_1.actors_["1070ui_story"]
			local var_207_10 = 0

			if var_207_10 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 and not isNil(var_207_9) and arg_204_1.var_.characterEffect1070ui_story == nil then
				arg_204_1.var_.characterEffect1070ui_story = var_207_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_11 = 0.200000002980232

			if var_207_10 <= arg_204_1.time_ and arg_204_1.time_ < var_207_10 + var_207_11 and not isNil(var_207_9) then
				local var_207_12 = (arg_204_1.time_ - var_207_10) / var_207_11

				if arg_204_1.var_.characterEffect1070ui_story and not isNil(var_207_9) then
					local var_207_13 = Mathf.Lerp(0, 0.5, var_207_12)

					arg_204_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1070ui_story.fillRatio = var_207_13
				end
			end

			if arg_204_1.time_ >= var_207_10 + var_207_11 and arg_204_1.time_ < var_207_10 + var_207_11 + arg_207_0 and not isNil(var_207_9) and arg_204_1.var_.characterEffect1070ui_story then
				local var_207_14 = 0.5

				arg_204_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1070ui_story.fillRatio = var_207_14
			end

			local var_207_15 = 0
			local var_207_16 = 1.175

			if var_207_15 < arg_204_1.time_ and arg_204_1.time_ <= var_207_15 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_17 = arg_204_1:GetWordFromCfg(324131050)
				local var_207_18 = arg_204_1:FormatText(var_207_17.content)

				arg_204_1.text_.text = var_207_18

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_19 = 47
				local var_207_20 = utf8.len(var_207_18)
				local var_207_21 = var_207_19 <= 0 and var_207_16 or var_207_16 * (var_207_20 / var_207_19)

				if var_207_21 > 0 and var_207_16 < var_207_21 then
					arg_204_1.talkMaxDuration = var_207_21

					if var_207_21 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_21 + var_207_15
					end
				end

				arg_204_1.text_.text = var_207_18
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_22 = math.max(var_207_16, arg_204_1.talkMaxDuration)

			if var_207_15 <= arg_204_1.time_ and arg_204_1.time_ < var_207_15 + var_207_22 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_15) / var_207_22

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_15 + var_207_22 and arg_204_1.time_ < var_207_15 + var_207_22 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play324131051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324131051
		arg_208_1.duration_ = 11.4

		local var_208_0 = {
			zh = 6.8,
			ja = 11.4
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
				arg_208_0:Play324131052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1053ui_story"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos1053ui_story = var_211_0.localPosition

				local var_211_2 = GameObjectTools.GetOrAddComponent(var_211_0.gameObject, typeof(DynamicBoneHelper))

				if var_211_2 then
					var_211_2:EnableDynamicBone(false)
				end
			end

			local var_211_3 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_3 then
				local var_211_4 = (arg_208_1.time_ - var_211_1) / var_211_3
				local var_211_5 = Vector3.New(0, -1.08, -6)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1053ui_story, var_211_5, var_211_4)

				local var_211_6 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_6.x, var_211_6.y, var_211_6.z)

				local var_211_7 = var_211_0.localEulerAngles

				var_211_7.z = 0
				var_211_7.x = 0
				var_211_0.localEulerAngles = var_211_7
			end

			if arg_208_1.time_ >= var_211_1 + var_211_3 and arg_208_1.time_ < var_211_1 + var_211_3 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_211_8 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_8.x, var_211_8.y, var_211_8.z)

				local var_211_9 = var_211_0.localEulerAngles

				var_211_9.z = 0
				var_211_9.x = 0
				var_211_0.localEulerAngles = var_211_9

				local var_211_10 = GameObjectTools.GetOrAddComponent(var_211_0.gameObject, typeof(DynamicBoneHelper))

				if var_211_10 then
					var_211_10:EnableDynamicBone(true)
				end
			end

			local var_211_11 = arg_208_1.actors_["1053ui_story"]
			local var_211_12 = 0

			if var_211_12 < arg_208_1.time_ and arg_208_1.time_ <= var_211_12 + arg_211_0 and not isNil(var_211_11) and arg_208_1.var_.characterEffect1053ui_story == nil then
				arg_208_1.var_.characterEffect1053ui_story = var_211_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_13 = 0.200000002980232

			if var_211_12 <= arg_208_1.time_ and arg_208_1.time_ < var_211_12 + var_211_13 and not isNil(var_211_11) then
				local var_211_14 = (arg_208_1.time_ - var_211_12) / var_211_13

				if arg_208_1.var_.characterEffect1053ui_story and not isNil(var_211_11) then
					arg_208_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_12 + var_211_13 and arg_208_1.time_ < var_211_12 + var_211_13 + arg_211_0 and not isNil(var_211_11) and arg_208_1.var_.characterEffect1053ui_story then
				arg_208_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_211_15 = 0

			if var_211_15 < arg_208_1.time_ and arg_208_1.time_ <= var_211_15 + arg_211_0 then
				arg_208_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_1")
			end

			local var_211_16 = 0

			if var_211_16 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 then
				arg_208_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_211_17 = 0
			local var_211_18 = 0.6

			if var_211_17 < arg_208_1.time_ and arg_208_1.time_ <= var_211_17 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_19 = arg_208_1:FormatText(StoryNameCfg[472].name)

				arg_208_1.leftNameTxt_.text = var_211_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_20 = arg_208_1:GetWordFromCfg(324131051)
				local var_211_21 = arg_208_1:FormatText(var_211_20.content)

				arg_208_1.text_.text = var_211_21

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_22 = 24
				local var_211_23 = utf8.len(var_211_21)
				local var_211_24 = var_211_22 <= 0 and var_211_18 or var_211_18 * (var_211_23 / var_211_22)

				if var_211_24 > 0 and var_211_18 < var_211_24 then
					arg_208_1.talkMaxDuration = var_211_24

					if var_211_24 + var_211_17 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_24 + var_211_17
					end
				end

				arg_208_1.text_.text = var_211_21
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131051", "story_v_out_324131.awb") ~= 0 then
					local var_211_25 = manager.audio:GetVoiceLength("story_v_out_324131", "324131051", "story_v_out_324131.awb") / 1000

					if var_211_25 + var_211_17 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_25 + var_211_17
					end

					if var_211_20.prefab_name ~= "" and arg_208_1.actors_[var_211_20.prefab_name] ~= nil then
						local var_211_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_20.prefab_name].transform, "story_v_out_324131", "324131051", "story_v_out_324131.awb")

						arg_208_1:RecordAudio("324131051", var_211_26)
						arg_208_1:RecordAudio("324131051", var_211_26)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_324131", "324131051", "story_v_out_324131.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_324131", "324131051", "story_v_out_324131.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_27 = math.max(var_211_18, arg_208_1.talkMaxDuration)

			if var_211_17 <= arg_208_1.time_ and arg_208_1.time_ < var_211_17 + var_211_27 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_17) / var_211_27

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_17 + var_211_27 and arg_208_1.time_ < var_211_17 + var_211_27 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
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

		arg_208_1:InitPlayNodeList()
	end,
	Play324131052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324131052
		arg_212_1.duration_ = 5.23

		local var_212_0 = {
			zh = 4.866,
			ja = 5.233
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play324131053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 0.425

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[472].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_3 = arg_212_1:GetWordFromCfg(324131052)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 17
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131052", "story_v_out_324131.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131052", "story_v_out_324131.awb") / 1000

					if var_215_8 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_0
					end

					if var_215_3.prefab_name ~= "" and arg_212_1.actors_[var_215_3.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_3.prefab_name].transform, "story_v_out_324131", "324131052", "story_v_out_324131.awb")

						arg_212_1:RecordAudio("324131052", var_215_9)
						arg_212_1:RecordAudio("324131052", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_324131", "324131052", "story_v_out_324131.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_324131", "324131052", "story_v_out_324131.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_10 and arg_212_1.time_ < var_215_0 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play324131053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324131053
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play324131054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1053ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos1053ui_story = var_219_0.localPosition

				local var_219_2 = GameObjectTools.GetOrAddComponent(var_219_0.gameObject, typeof(DynamicBoneHelper))

				if var_219_2 then
					var_219_2:EnableDynamicBone(false)
				end
			end

			local var_219_3 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_3 then
				local var_219_4 = (arg_216_1.time_ - var_219_1) / var_219_3
				local var_219_5 = Vector3.New(0, 100, 0)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1053ui_story, var_219_5, var_219_4)

				local var_219_6 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_6.x, var_219_6.y, var_219_6.z)

				local var_219_7 = var_219_0.localEulerAngles

				var_219_7.z = 0
				var_219_7.x = 0
				var_219_0.localEulerAngles = var_219_7
			end

			if arg_216_1.time_ >= var_219_1 + var_219_3 and arg_216_1.time_ < var_219_1 + var_219_3 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, 100, 0)

				local var_219_8 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_8.x, var_219_8.y, var_219_8.z)

				local var_219_9 = var_219_0.localEulerAngles

				var_219_9.z = 0
				var_219_9.x = 0
				var_219_0.localEulerAngles = var_219_9

				local var_219_10 = GameObjectTools.GetOrAddComponent(var_219_0.gameObject, typeof(DynamicBoneHelper))

				if var_219_10 then
					var_219_10:EnableDynamicBone(true)
				end
			end

			local var_219_11 = arg_216_1.actors_["1053ui_story"]
			local var_219_12 = 0

			if var_219_12 < arg_216_1.time_ and arg_216_1.time_ <= var_219_12 + arg_219_0 and not isNil(var_219_11) and arg_216_1.var_.characterEffect1053ui_story == nil then
				arg_216_1.var_.characterEffect1053ui_story = var_219_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_13 = 0.200000002980232

			if var_219_12 <= arg_216_1.time_ and arg_216_1.time_ < var_219_12 + var_219_13 and not isNil(var_219_11) then
				local var_219_14 = (arg_216_1.time_ - var_219_12) / var_219_13

				if arg_216_1.var_.characterEffect1053ui_story and not isNil(var_219_11) then
					local var_219_15 = Mathf.Lerp(0, 0.5, var_219_14)

					arg_216_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1053ui_story.fillRatio = var_219_15
				end
			end

			if arg_216_1.time_ >= var_219_12 + var_219_13 and arg_216_1.time_ < var_219_12 + var_219_13 + arg_219_0 and not isNil(var_219_11) and arg_216_1.var_.characterEffect1053ui_story then
				local var_219_16 = 0.5

				arg_216_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1053ui_story.fillRatio = var_219_16
			end

			local var_219_17 = 0
			local var_219_18 = 1.45

			if var_219_17 < arg_216_1.time_ and arg_216_1.time_ <= var_219_17 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_19 = arg_216_1:GetWordFromCfg(324131053)
				local var_219_20 = arg_216_1:FormatText(var_219_19.content)

				arg_216_1.text_.text = var_219_20

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_21 = 58
				local var_219_22 = utf8.len(var_219_20)
				local var_219_23 = var_219_21 <= 0 and var_219_18 or var_219_18 * (var_219_22 / var_219_21)

				if var_219_23 > 0 and var_219_18 < var_219_23 then
					arg_216_1.talkMaxDuration = var_219_23

					if var_219_23 + var_219_17 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_23 + var_219_17
					end
				end

				arg_216_1.text_.text = var_219_20
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_24 = math.max(var_219_18, arg_216_1.talkMaxDuration)

			if var_219_17 <= arg_216_1.time_ and arg_216_1.time_ < var_219_17 + var_219_24 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_17) / var_219_24

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_17 + var_219_24 and arg_216_1.time_ < var_219_17 + var_219_24 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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

		arg_216_1:InitPlayNodeList()
	end,
	Play324131054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324131054
		arg_220_1.duration_ = 4.17

		local var_220_0 = {
			zh = 4.166,
			ja = 3
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
				arg_220_0:Play324131055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1070ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos1070ui_story = var_223_0.localPosition
			end

			local var_223_2 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2
				local var_223_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1070ui_story, var_223_4, var_223_3)

				local var_223_5 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_5.x, var_223_5.y, var_223_5.z)

				local var_223_6 = var_223_0.localEulerAngles

				var_223_6.z = 0
				var_223_6.x = 0
				var_223_0.localEulerAngles = var_223_6
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_223_7 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_7.x, var_223_7.y, var_223_7.z)

				local var_223_8 = var_223_0.localEulerAngles

				var_223_8.z = 0
				var_223_8.x = 0
				var_223_0.localEulerAngles = var_223_8
			end

			local var_223_9 = arg_220_1.actors_["1070ui_story"]
			local var_223_10 = 0

			if var_223_10 < arg_220_1.time_ and arg_220_1.time_ <= var_223_10 + arg_223_0 and not isNil(var_223_9) and arg_220_1.var_.characterEffect1070ui_story == nil then
				arg_220_1.var_.characterEffect1070ui_story = var_223_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_11 = 0.200000002980232

			if var_223_10 <= arg_220_1.time_ and arg_220_1.time_ < var_223_10 + var_223_11 and not isNil(var_223_9) then
				local var_223_12 = (arg_220_1.time_ - var_223_10) / var_223_11

				if arg_220_1.var_.characterEffect1070ui_story and not isNil(var_223_9) then
					arg_220_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_10 + var_223_11 and arg_220_1.time_ < var_223_10 + var_223_11 + arg_223_0 and not isNil(var_223_9) and arg_220_1.var_.characterEffect1070ui_story then
				arg_220_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_223_13 = 0

			if var_223_13 < arg_220_1.time_ and arg_220_1.time_ <= var_223_13 + arg_223_0 then
				arg_220_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			local var_223_14 = 0

			if var_223_14 < arg_220_1.time_ and arg_220_1.time_ <= var_223_14 + arg_223_0 then
				arg_220_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_223_15 = 0
			local var_223_16 = 0.225

			if var_223_15 < arg_220_1.time_ and arg_220_1.time_ <= var_223_15 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_17 = arg_220_1:FormatText(StoryNameCfg[318].name)

				arg_220_1.leftNameTxt_.text = var_223_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_18 = arg_220_1:GetWordFromCfg(324131054)
				local var_223_19 = arg_220_1:FormatText(var_223_18.content)

				arg_220_1.text_.text = var_223_19

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_20 = 9
				local var_223_21 = utf8.len(var_223_19)
				local var_223_22 = var_223_20 <= 0 and var_223_16 or var_223_16 * (var_223_21 / var_223_20)

				if var_223_22 > 0 and var_223_16 < var_223_22 then
					arg_220_1.talkMaxDuration = var_223_22

					if var_223_22 + var_223_15 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_22 + var_223_15
					end
				end

				arg_220_1.text_.text = var_223_19
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131054", "story_v_out_324131.awb") ~= 0 then
					local var_223_23 = manager.audio:GetVoiceLength("story_v_out_324131", "324131054", "story_v_out_324131.awb") / 1000

					if var_223_23 + var_223_15 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_23 + var_223_15
					end

					if var_223_18.prefab_name ~= "" and arg_220_1.actors_[var_223_18.prefab_name] ~= nil then
						local var_223_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_18.prefab_name].transform, "story_v_out_324131", "324131054", "story_v_out_324131.awb")

						arg_220_1:RecordAudio("324131054", var_223_24)
						arg_220_1:RecordAudio("324131054", var_223_24)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_324131", "324131054", "story_v_out_324131.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_324131", "324131054", "story_v_out_324131.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_25 = math.max(var_223_16, arg_220_1.talkMaxDuration)

			if var_223_15 <= arg_220_1.time_ and arg_220_1.time_ < var_223_15 + var_223_25 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_15) / var_223_25

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_15 + var_223_25 and arg_220_1.time_ < var_223_15 + var_223_25 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play324131055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324131055
		arg_224_1.duration_ = 3.67

		local var_224_0 = {
			zh = 1.999999999999,
			ja = 3.666
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play324131056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1053ui_story"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos1053ui_story = var_227_0.localPosition

				local var_227_2 = GameObjectTools.GetOrAddComponent(var_227_0.gameObject, typeof(DynamicBoneHelper))

				if var_227_2 then
					var_227_2:EnableDynamicBone(false)
				end
			end

			local var_227_3 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_3 then
				local var_227_4 = (arg_224_1.time_ - var_227_1) / var_227_3
				local var_227_5 = Vector3.New(0.7, -1.08, -6)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1053ui_story, var_227_5, var_227_4)

				local var_227_6 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_6.x, var_227_6.y, var_227_6.z)

				local var_227_7 = var_227_0.localEulerAngles

				var_227_7.z = 0
				var_227_7.x = 0
				var_227_0.localEulerAngles = var_227_7
			end

			if arg_224_1.time_ >= var_227_1 + var_227_3 and arg_224_1.time_ < var_227_1 + var_227_3 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_227_8 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_8.x, var_227_8.y, var_227_8.z)

				local var_227_9 = var_227_0.localEulerAngles

				var_227_9.z = 0
				var_227_9.x = 0
				var_227_0.localEulerAngles = var_227_9

				local var_227_10 = GameObjectTools.GetOrAddComponent(var_227_0.gameObject, typeof(DynamicBoneHelper))

				if var_227_10 then
					var_227_10:EnableDynamicBone(true)
				end
			end

			local var_227_11 = arg_224_1.actors_["1053ui_story"]
			local var_227_12 = 0

			if var_227_12 < arg_224_1.time_ and arg_224_1.time_ <= var_227_12 + arg_227_0 and not isNil(var_227_11) and arg_224_1.var_.characterEffect1053ui_story == nil then
				arg_224_1.var_.characterEffect1053ui_story = var_227_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_13 = 0.200000002980232

			if var_227_12 <= arg_224_1.time_ and arg_224_1.time_ < var_227_12 + var_227_13 and not isNil(var_227_11) then
				local var_227_14 = (arg_224_1.time_ - var_227_12) / var_227_13

				if arg_224_1.var_.characterEffect1053ui_story and not isNil(var_227_11) then
					arg_224_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_12 + var_227_13 and arg_224_1.time_ < var_227_12 + var_227_13 + arg_227_0 and not isNil(var_227_11) and arg_224_1.var_.characterEffect1053ui_story then
				arg_224_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_227_15 = arg_224_1.actors_["1070ui_story"]
			local var_227_16 = 0

			if var_227_16 < arg_224_1.time_ and arg_224_1.time_ <= var_227_16 + arg_227_0 and not isNil(var_227_15) and arg_224_1.var_.characterEffect1070ui_story == nil then
				arg_224_1.var_.characterEffect1070ui_story = var_227_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_17 = 0.200000002980232

			if var_227_16 <= arg_224_1.time_ and arg_224_1.time_ < var_227_16 + var_227_17 and not isNil(var_227_15) then
				local var_227_18 = (arg_224_1.time_ - var_227_16) / var_227_17

				if arg_224_1.var_.characterEffect1070ui_story and not isNil(var_227_15) then
					local var_227_19 = Mathf.Lerp(0, 0.5, var_227_18)

					arg_224_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1070ui_story.fillRatio = var_227_19
				end
			end

			if arg_224_1.time_ >= var_227_16 + var_227_17 and arg_224_1.time_ < var_227_16 + var_227_17 + arg_227_0 and not isNil(var_227_15) and arg_224_1.var_.characterEffect1070ui_story then
				local var_227_20 = 0.5

				arg_224_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1070ui_story.fillRatio = var_227_20
			end

			local var_227_21 = 0

			if var_227_21 < arg_224_1.time_ and arg_224_1.time_ <= var_227_21 + arg_227_0 then
				arg_224_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_2")
			end

			local var_227_22 = 0

			if var_227_22 < arg_224_1.time_ and arg_224_1.time_ <= var_227_22 + arg_227_0 then
				arg_224_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_227_23 = 0
			local var_227_24 = 0.175

			if var_227_23 < arg_224_1.time_ and arg_224_1.time_ <= var_227_23 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_25 = arg_224_1:FormatText(StoryNameCfg[472].name)

				arg_224_1.leftNameTxt_.text = var_227_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_26 = arg_224_1:GetWordFromCfg(324131055)
				local var_227_27 = arg_224_1:FormatText(var_227_26.content)

				arg_224_1.text_.text = var_227_27

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_28 = 7
				local var_227_29 = utf8.len(var_227_27)
				local var_227_30 = var_227_28 <= 0 and var_227_24 or var_227_24 * (var_227_29 / var_227_28)

				if var_227_30 > 0 and var_227_24 < var_227_30 then
					arg_224_1.talkMaxDuration = var_227_30

					if var_227_30 + var_227_23 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_30 + var_227_23
					end
				end

				arg_224_1.text_.text = var_227_27
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131055", "story_v_out_324131.awb") ~= 0 then
					local var_227_31 = manager.audio:GetVoiceLength("story_v_out_324131", "324131055", "story_v_out_324131.awb") / 1000

					if var_227_31 + var_227_23 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_31 + var_227_23
					end

					if var_227_26.prefab_name ~= "" and arg_224_1.actors_[var_227_26.prefab_name] ~= nil then
						local var_227_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_26.prefab_name].transform, "story_v_out_324131", "324131055", "story_v_out_324131.awb")

						arg_224_1:RecordAudio("324131055", var_227_32)
						arg_224_1:RecordAudio("324131055", var_227_32)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_324131", "324131055", "story_v_out_324131.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_324131", "324131055", "story_v_out_324131.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_33 = math.max(var_227_24, arg_224_1.talkMaxDuration)

			if var_227_23 <= arg_224_1.time_ and arg_224_1.time_ < var_227_23 + var_227_33 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_23) / var_227_33

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_23 + var_227_33 and arg_224_1.time_ < var_227_23 + var_227_33 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
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

		arg_224_1:InitPlayNodeList()
	end,
	Play324131056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324131056
		arg_228_1.duration_ = 5.13

		local var_228_0 = {
			zh = 4.433,
			ja = 5.133
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
				arg_228_0:Play324131057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1070ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1070ui_story == nil then
				arg_228_1.var_.characterEffect1070ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect1070ui_story and not isNil(var_231_0) then
					arg_228_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1070ui_story then
				arg_228_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_231_4 = arg_228_1.actors_["1053ui_story"]
			local var_231_5 = 0

			if var_231_5 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect1053ui_story == nil then
				arg_228_1.var_.characterEffect1053ui_story = var_231_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_6 = 0.200000002980232

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_6 and not isNil(var_231_4) then
				local var_231_7 = (arg_228_1.time_ - var_231_5) / var_231_6

				if arg_228_1.var_.characterEffect1053ui_story and not isNil(var_231_4) then
					local var_231_8 = Mathf.Lerp(0, 0.5, var_231_7)

					arg_228_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1053ui_story.fillRatio = var_231_8
				end
			end

			if arg_228_1.time_ >= var_231_5 + var_231_6 and arg_228_1.time_ < var_231_5 + var_231_6 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect1053ui_story then
				local var_231_9 = 0.5

				arg_228_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1053ui_story.fillRatio = var_231_9
			end

			local var_231_10 = 0
			local var_231_11 = 0.325

			if var_231_10 < arg_228_1.time_ and arg_228_1.time_ <= var_231_10 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_12 = arg_228_1:FormatText(StoryNameCfg[318].name)

				arg_228_1.leftNameTxt_.text = var_231_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_13 = arg_228_1:GetWordFromCfg(324131056)
				local var_231_14 = arg_228_1:FormatText(var_231_13.content)

				arg_228_1.text_.text = var_231_14

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_15 = 13
				local var_231_16 = utf8.len(var_231_14)
				local var_231_17 = var_231_15 <= 0 and var_231_11 or var_231_11 * (var_231_16 / var_231_15)

				if var_231_17 > 0 and var_231_11 < var_231_17 then
					arg_228_1.talkMaxDuration = var_231_17

					if var_231_17 + var_231_10 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_17 + var_231_10
					end
				end

				arg_228_1.text_.text = var_231_14
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131056", "story_v_out_324131.awb") ~= 0 then
					local var_231_18 = manager.audio:GetVoiceLength("story_v_out_324131", "324131056", "story_v_out_324131.awb") / 1000

					if var_231_18 + var_231_10 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_18 + var_231_10
					end

					if var_231_13.prefab_name ~= "" and arg_228_1.actors_[var_231_13.prefab_name] ~= nil then
						local var_231_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_13.prefab_name].transform, "story_v_out_324131", "324131056", "story_v_out_324131.awb")

						arg_228_1:RecordAudio("324131056", var_231_19)
						arg_228_1:RecordAudio("324131056", var_231_19)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_324131", "324131056", "story_v_out_324131.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_324131", "324131056", "story_v_out_324131.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_20 = math.max(var_231_11, arg_228_1.talkMaxDuration)

			if var_231_10 <= arg_228_1.time_ and arg_228_1.time_ < var_231_10 + var_231_20 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_10) / var_231_20

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_10 + var_231_20 and arg_228_1.time_ < var_231_10 + var_231_20 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play324131057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324131057
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play324131058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1070ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos1070ui_story = var_235_0.localPosition
			end

			local var_235_2 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2
				local var_235_4 = Vector3.New(0, 100, 0)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1070ui_story, var_235_4, var_235_3)

				local var_235_5 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_5.x, var_235_5.y, var_235_5.z)

				local var_235_6 = var_235_0.localEulerAngles

				var_235_6.z = 0
				var_235_6.x = 0
				var_235_0.localEulerAngles = var_235_6
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, 100, 0)

				local var_235_7 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_7.x, var_235_7.y, var_235_7.z)

				local var_235_8 = var_235_0.localEulerAngles

				var_235_8.z = 0
				var_235_8.x = 0
				var_235_0.localEulerAngles = var_235_8
			end

			local var_235_9 = arg_232_1.actors_["1053ui_story"].transform
			local var_235_10 = 0

			if var_235_10 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 then
				arg_232_1.var_.moveOldPos1053ui_story = var_235_9.localPosition

				local var_235_11 = GameObjectTools.GetOrAddComponent(var_235_9.gameObject, typeof(DynamicBoneHelper))

				if var_235_11 then
					var_235_11:EnableDynamicBone(false)
				end
			end

			local var_235_12 = 0.001

			if var_235_10 <= arg_232_1.time_ and arg_232_1.time_ < var_235_10 + var_235_12 then
				local var_235_13 = (arg_232_1.time_ - var_235_10) / var_235_12
				local var_235_14 = Vector3.New(0, 100, 0)

				var_235_9.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1053ui_story, var_235_14, var_235_13)

				local var_235_15 = manager.ui.mainCamera.transform.position - var_235_9.position

				var_235_9.forward = Vector3.New(var_235_15.x, var_235_15.y, var_235_15.z)

				local var_235_16 = var_235_9.localEulerAngles

				var_235_16.z = 0
				var_235_16.x = 0
				var_235_9.localEulerAngles = var_235_16
			end

			if arg_232_1.time_ >= var_235_10 + var_235_12 and arg_232_1.time_ < var_235_10 + var_235_12 + arg_235_0 then
				var_235_9.localPosition = Vector3.New(0, 100, 0)

				local var_235_17 = manager.ui.mainCamera.transform.position - var_235_9.position

				var_235_9.forward = Vector3.New(var_235_17.x, var_235_17.y, var_235_17.z)

				local var_235_18 = var_235_9.localEulerAngles

				var_235_18.z = 0
				var_235_18.x = 0
				var_235_9.localEulerAngles = var_235_18

				local var_235_19 = GameObjectTools.GetOrAddComponent(var_235_9.gameObject, typeof(DynamicBoneHelper))

				if var_235_19 then
					var_235_19:EnableDynamicBone(true)
				end
			end

			local var_235_20 = arg_232_1.actors_["1070ui_story"]
			local var_235_21 = 0

			if var_235_21 < arg_232_1.time_ and arg_232_1.time_ <= var_235_21 + arg_235_0 and not isNil(var_235_20) and arg_232_1.var_.characterEffect1070ui_story == nil then
				arg_232_1.var_.characterEffect1070ui_story = var_235_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_22 = 0.200000002980232

			if var_235_21 <= arg_232_1.time_ and arg_232_1.time_ < var_235_21 + var_235_22 and not isNil(var_235_20) then
				local var_235_23 = (arg_232_1.time_ - var_235_21) / var_235_22

				if arg_232_1.var_.characterEffect1070ui_story and not isNil(var_235_20) then
					local var_235_24 = Mathf.Lerp(0, 0.5, var_235_23)

					arg_232_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1070ui_story.fillRatio = var_235_24
				end
			end

			if arg_232_1.time_ >= var_235_21 + var_235_22 and arg_232_1.time_ < var_235_21 + var_235_22 + arg_235_0 and not isNil(var_235_20) and arg_232_1.var_.characterEffect1070ui_story then
				local var_235_25 = 0.5

				arg_232_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1070ui_story.fillRatio = var_235_25
			end

			local var_235_26 = 0
			local var_235_27 = 0.825

			if var_235_26 < arg_232_1.time_ and arg_232_1.time_ <= var_235_26 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_28 = arg_232_1:GetWordFromCfg(324131057)
				local var_235_29 = arg_232_1:FormatText(var_235_28.content)

				arg_232_1.text_.text = var_235_29

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_30 = 33
				local var_235_31 = utf8.len(var_235_29)
				local var_235_32 = var_235_30 <= 0 and var_235_27 or var_235_27 * (var_235_31 / var_235_30)

				if var_235_32 > 0 and var_235_27 < var_235_32 then
					arg_232_1.talkMaxDuration = var_235_32

					if var_235_32 + var_235_26 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_32 + var_235_26
					end
				end

				arg_232_1.text_.text = var_235_29
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_33 = math.max(var_235_27, arg_232_1.talkMaxDuration)

			if var_235_26 <= arg_232_1.time_ and arg_232_1.time_ < var_235_26 + var_235_33 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_26) / var_235_33

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_26 + var_235_33 and arg_232_1.time_ < var_235_26 + var_235_33 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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

		arg_232_1:InitPlayNodeList()
	end,
	Play324131058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324131058
		arg_236_1.duration_ = 8.37

		local var_236_0 = {
			zh = 7.333,
			ja = 8.366
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
				arg_236_0:Play324131059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1053ui_story"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos1053ui_story = var_239_0.localPosition

				local var_239_2 = GameObjectTools.GetOrAddComponent(var_239_0.gameObject, typeof(DynamicBoneHelper))

				if var_239_2 then
					var_239_2:EnableDynamicBone(false)
				end
			end

			local var_239_3 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_3 then
				local var_239_4 = (arg_236_1.time_ - var_239_1) / var_239_3
				local var_239_5 = Vector3.New(0.7, -1.08, -6)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1053ui_story, var_239_5, var_239_4)

				local var_239_6 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_6.x, var_239_6.y, var_239_6.z)

				local var_239_7 = var_239_0.localEulerAngles

				var_239_7.z = 0
				var_239_7.x = 0
				var_239_0.localEulerAngles = var_239_7
			end

			if arg_236_1.time_ >= var_239_1 + var_239_3 and arg_236_1.time_ < var_239_1 + var_239_3 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_239_8 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_8.x, var_239_8.y, var_239_8.z)

				local var_239_9 = var_239_0.localEulerAngles

				var_239_9.z = 0
				var_239_9.x = 0
				var_239_0.localEulerAngles = var_239_9

				local var_239_10 = GameObjectTools.GetOrAddComponent(var_239_0.gameObject, typeof(DynamicBoneHelper))

				if var_239_10 then
					var_239_10:EnableDynamicBone(true)
				end
			end

			local var_239_11 = arg_236_1.actors_["1053ui_story"]
			local var_239_12 = 0

			if var_239_12 < arg_236_1.time_ and arg_236_1.time_ <= var_239_12 + arg_239_0 and not isNil(var_239_11) and arg_236_1.var_.characterEffect1053ui_story == nil then
				arg_236_1.var_.characterEffect1053ui_story = var_239_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_13 = 0.200000002980232

			if var_239_12 <= arg_236_1.time_ and arg_236_1.time_ < var_239_12 + var_239_13 and not isNil(var_239_11) then
				local var_239_14 = (arg_236_1.time_ - var_239_12) / var_239_13

				if arg_236_1.var_.characterEffect1053ui_story and not isNil(var_239_11) then
					arg_236_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_12 + var_239_13 and arg_236_1.time_ < var_239_12 + var_239_13 + arg_239_0 and not isNil(var_239_11) and arg_236_1.var_.characterEffect1053ui_story then
				arg_236_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_239_15 = 0

			if var_239_15 < arg_236_1.time_ and arg_236_1.time_ <= var_239_15 + arg_239_0 then
				arg_236_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_1")
			end

			local var_239_16 = 0

			if var_239_16 < arg_236_1.time_ and arg_236_1.time_ <= var_239_16 + arg_239_0 then
				arg_236_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_239_17 = 0
			local var_239_18 = 0.725

			if var_239_17 < arg_236_1.time_ and arg_236_1.time_ <= var_239_17 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_19 = arg_236_1:FormatText(StoryNameCfg[472].name)

				arg_236_1.leftNameTxt_.text = var_239_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_20 = arg_236_1:GetWordFromCfg(324131058)
				local var_239_21 = arg_236_1:FormatText(var_239_20.content)

				arg_236_1.text_.text = var_239_21

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_22 = 29
				local var_239_23 = utf8.len(var_239_21)
				local var_239_24 = var_239_22 <= 0 and var_239_18 or var_239_18 * (var_239_23 / var_239_22)

				if var_239_24 > 0 and var_239_18 < var_239_24 then
					arg_236_1.talkMaxDuration = var_239_24

					if var_239_24 + var_239_17 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_24 + var_239_17
					end
				end

				arg_236_1.text_.text = var_239_21
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131058", "story_v_out_324131.awb") ~= 0 then
					local var_239_25 = manager.audio:GetVoiceLength("story_v_out_324131", "324131058", "story_v_out_324131.awb") / 1000

					if var_239_25 + var_239_17 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_25 + var_239_17
					end

					if var_239_20.prefab_name ~= "" and arg_236_1.actors_[var_239_20.prefab_name] ~= nil then
						local var_239_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_20.prefab_name].transform, "story_v_out_324131", "324131058", "story_v_out_324131.awb")

						arg_236_1:RecordAudio("324131058", var_239_26)
						arg_236_1:RecordAudio("324131058", var_239_26)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_324131", "324131058", "story_v_out_324131.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_324131", "324131058", "story_v_out_324131.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_27 = math.max(var_239_18, arg_236_1.talkMaxDuration)

			if var_239_17 <= arg_236_1.time_ and arg_236_1.time_ < var_239_17 + var_239_27 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_17) / var_239_27

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_17 + var_239_27 and arg_236_1.time_ < var_239_17 + var_239_27 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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

		arg_236_1:InitPlayNodeList()
	end,
	Play324131059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324131059
		arg_240_1.duration_ = 9.13

		local var_240_0 = {
			zh = 6.8,
			ja = 9.133
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
				arg_240_0:Play324131060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1070ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos1070ui_story = var_243_0.localPosition
			end

			local var_243_2 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2
				local var_243_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1070ui_story, var_243_4, var_243_3)

				local var_243_5 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_5.x, var_243_5.y, var_243_5.z)

				local var_243_6 = var_243_0.localEulerAngles

				var_243_6.z = 0
				var_243_6.x = 0
				var_243_0.localEulerAngles = var_243_6
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_243_7 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_7.x, var_243_7.y, var_243_7.z)

				local var_243_8 = var_243_0.localEulerAngles

				var_243_8.z = 0
				var_243_8.x = 0
				var_243_0.localEulerAngles = var_243_8
			end

			local var_243_9 = arg_240_1.actors_["1070ui_story"]
			local var_243_10 = 0

			if var_243_10 < arg_240_1.time_ and arg_240_1.time_ <= var_243_10 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect1070ui_story == nil then
				arg_240_1.var_.characterEffect1070ui_story = var_243_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_11 = 0.200000002980232

			if var_243_10 <= arg_240_1.time_ and arg_240_1.time_ < var_243_10 + var_243_11 and not isNil(var_243_9) then
				local var_243_12 = (arg_240_1.time_ - var_243_10) / var_243_11

				if arg_240_1.var_.characterEffect1070ui_story and not isNil(var_243_9) then
					arg_240_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_10 + var_243_11 and arg_240_1.time_ < var_243_10 + var_243_11 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect1070ui_story then
				arg_240_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_243_13 = arg_240_1.actors_["1053ui_story"]
			local var_243_14 = 0

			if var_243_14 < arg_240_1.time_ and arg_240_1.time_ <= var_243_14 + arg_243_0 and not isNil(var_243_13) and arg_240_1.var_.characterEffect1053ui_story == nil then
				arg_240_1.var_.characterEffect1053ui_story = var_243_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_15 = 0.200000002980232

			if var_243_14 <= arg_240_1.time_ and arg_240_1.time_ < var_243_14 + var_243_15 and not isNil(var_243_13) then
				local var_243_16 = (arg_240_1.time_ - var_243_14) / var_243_15

				if arg_240_1.var_.characterEffect1053ui_story and not isNil(var_243_13) then
					local var_243_17 = Mathf.Lerp(0, 0.5, var_243_16)

					arg_240_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1053ui_story.fillRatio = var_243_17
				end
			end

			if arg_240_1.time_ >= var_243_14 + var_243_15 and arg_240_1.time_ < var_243_14 + var_243_15 + arg_243_0 and not isNil(var_243_13) and arg_240_1.var_.characterEffect1053ui_story then
				local var_243_18 = 0.5

				arg_240_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1053ui_story.fillRatio = var_243_18
			end

			local var_243_19 = 0

			if var_243_19 < arg_240_1.time_ and arg_240_1.time_ <= var_243_19 + arg_243_0 then
				arg_240_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_2")
			end

			local var_243_20 = 0
			local var_243_21 = 0.5

			if var_243_20 < arg_240_1.time_ and arg_240_1.time_ <= var_243_20 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_22 = arg_240_1:FormatText(StoryNameCfg[318].name)

				arg_240_1.leftNameTxt_.text = var_243_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_23 = arg_240_1:GetWordFromCfg(324131059)
				local var_243_24 = arg_240_1:FormatText(var_243_23.content)

				arg_240_1.text_.text = var_243_24

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_25 = 20
				local var_243_26 = utf8.len(var_243_24)
				local var_243_27 = var_243_25 <= 0 and var_243_21 or var_243_21 * (var_243_26 / var_243_25)

				if var_243_27 > 0 and var_243_21 < var_243_27 then
					arg_240_1.talkMaxDuration = var_243_27

					if var_243_27 + var_243_20 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_27 + var_243_20
					end
				end

				arg_240_1.text_.text = var_243_24
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131059", "story_v_out_324131.awb") ~= 0 then
					local var_243_28 = manager.audio:GetVoiceLength("story_v_out_324131", "324131059", "story_v_out_324131.awb") / 1000

					if var_243_28 + var_243_20 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_28 + var_243_20
					end

					if var_243_23.prefab_name ~= "" and arg_240_1.actors_[var_243_23.prefab_name] ~= nil then
						local var_243_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_23.prefab_name].transform, "story_v_out_324131", "324131059", "story_v_out_324131.awb")

						arg_240_1:RecordAudio("324131059", var_243_29)
						arg_240_1:RecordAudio("324131059", var_243_29)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_324131", "324131059", "story_v_out_324131.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_324131", "324131059", "story_v_out_324131.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_30 = math.max(var_243_21, arg_240_1.talkMaxDuration)

			if var_243_20 <= arg_240_1.time_ and arg_240_1.time_ < var_243_20 + var_243_30 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_20) / var_243_30

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_20 + var_243_30 and arg_240_1.time_ < var_243_20 + var_243_30 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play324131060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324131060
		arg_244_1.duration_ = 8.07

		local var_244_0 = {
			zh = 5.7,
			ja = 8.066
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324131061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1053ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1053ui_story == nil then
				arg_244_1.var_.characterEffect1053ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect1053ui_story and not isNil(var_247_0) then
					arg_244_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1053ui_story then
				arg_244_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_247_4 = arg_244_1.actors_["1070ui_story"]
			local var_247_5 = 0

			if var_247_5 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect1070ui_story == nil then
				arg_244_1.var_.characterEffect1070ui_story = var_247_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_6 = 0.200000002980232

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_6 and not isNil(var_247_4) then
				local var_247_7 = (arg_244_1.time_ - var_247_5) / var_247_6

				if arg_244_1.var_.characterEffect1070ui_story and not isNil(var_247_4) then
					local var_247_8 = Mathf.Lerp(0, 0.5, var_247_7)

					arg_244_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1070ui_story.fillRatio = var_247_8
				end
			end

			if arg_244_1.time_ >= var_247_5 + var_247_6 and arg_244_1.time_ < var_247_5 + var_247_6 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect1070ui_story then
				local var_247_9 = 0.5

				arg_244_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1070ui_story.fillRatio = var_247_9
			end

			local var_247_10 = 0
			local var_247_11 = 0.575

			if var_247_10 < arg_244_1.time_ and arg_244_1.time_ <= var_247_10 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_12 = arg_244_1:FormatText(StoryNameCfg[472].name)

				arg_244_1.leftNameTxt_.text = var_247_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_13 = arg_244_1:GetWordFromCfg(324131060)
				local var_247_14 = arg_244_1:FormatText(var_247_13.content)

				arg_244_1.text_.text = var_247_14

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_15 = 23
				local var_247_16 = utf8.len(var_247_14)
				local var_247_17 = var_247_15 <= 0 and var_247_11 or var_247_11 * (var_247_16 / var_247_15)

				if var_247_17 > 0 and var_247_11 < var_247_17 then
					arg_244_1.talkMaxDuration = var_247_17

					if var_247_17 + var_247_10 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_17 + var_247_10
					end
				end

				arg_244_1.text_.text = var_247_14
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131060", "story_v_out_324131.awb") ~= 0 then
					local var_247_18 = manager.audio:GetVoiceLength("story_v_out_324131", "324131060", "story_v_out_324131.awb") / 1000

					if var_247_18 + var_247_10 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_18 + var_247_10
					end

					if var_247_13.prefab_name ~= "" and arg_244_1.actors_[var_247_13.prefab_name] ~= nil then
						local var_247_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_13.prefab_name].transform, "story_v_out_324131", "324131060", "story_v_out_324131.awb")

						arg_244_1:RecordAudio("324131060", var_247_19)
						arg_244_1:RecordAudio("324131060", var_247_19)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_324131", "324131060", "story_v_out_324131.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_324131", "324131060", "story_v_out_324131.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_20 = math.max(var_247_11, arg_244_1.talkMaxDuration)

			if var_247_10 <= arg_244_1.time_ and arg_244_1.time_ < var_247_10 + var_247_20 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_10) / var_247_20

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_10 + var_247_20 and arg_244_1.time_ < var_247_10 + var_247_20 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play324131061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324131061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324131062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1070ui_story"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos1070ui_story = var_251_0.localPosition
			end

			local var_251_2 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2
				local var_251_4 = Vector3.New(0, 100, 0)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1070ui_story, var_251_4, var_251_3)

				local var_251_5 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_5.x, var_251_5.y, var_251_5.z)

				local var_251_6 = var_251_0.localEulerAngles

				var_251_6.z = 0
				var_251_6.x = 0
				var_251_0.localEulerAngles = var_251_6
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0, 100, 0)

				local var_251_7 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_7.x, var_251_7.y, var_251_7.z)

				local var_251_8 = var_251_0.localEulerAngles

				var_251_8.z = 0
				var_251_8.x = 0
				var_251_0.localEulerAngles = var_251_8
			end

			local var_251_9 = arg_248_1.actors_["1053ui_story"].transform
			local var_251_10 = 0

			if var_251_10 < arg_248_1.time_ and arg_248_1.time_ <= var_251_10 + arg_251_0 then
				arg_248_1.var_.moveOldPos1053ui_story = var_251_9.localPosition

				local var_251_11 = GameObjectTools.GetOrAddComponent(var_251_9.gameObject, typeof(DynamicBoneHelper))

				if var_251_11 then
					var_251_11:EnableDynamicBone(false)
				end
			end

			local var_251_12 = 0.001

			if var_251_10 <= arg_248_1.time_ and arg_248_1.time_ < var_251_10 + var_251_12 then
				local var_251_13 = (arg_248_1.time_ - var_251_10) / var_251_12
				local var_251_14 = Vector3.New(0, 100, 0)

				var_251_9.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1053ui_story, var_251_14, var_251_13)

				local var_251_15 = manager.ui.mainCamera.transform.position - var_251_9.position

				var_251_9.forward = Vector3.New(var_251_15.x, var_251_15.y, var_251_15.z)

				local var_251_16 = var_251_9.localEulerAngles

				var_251_16.z = 0
				var_251_16.x = 0
				var_251_9.localEulerAngles = var_251_16
			end

			if arg_248_1.time_ >= var_251_10 + var_251_12 and arg_248_1.time_ < var_251_10 + var_251_12 + arg_251_0 then
				var_251_9.localPosition = Vector3.New(0, 100, 0)

				local var_251_17 = manager.ui.mainCamera.transform.position - var_251_9.position

				var_251_9.forward = Vector3.New(var_251_17.x, var_251_17.y, var_251_17.z)

				local var_251_18 = var_251_9.localEulerAngles

				var_251_18.z = 0
				var_251_18.x = 0
				var_251_9.localEulerAngles = var_251_18

				local var_251_19 = GameObjectTools.GetOrAddComponent(var_251_9.gameObject, typeof(DynamicBoneHelper))

				if var_251_19 then
					var_251_19:EnableDynamicBone(true)
				end
			end

			local var_251_20 = arg_248_1.actors_["1053ui_story"]
			local var_251_21 = 0

			if var_251_21 < arg_248_1.time_ and arg_248_1.time_ <= var_251_21 + arg_251_0 and not isNil(var_251_20) and arg_248_1.var_.characterEffect1053ui_story == nil then
				arg_248_1.var_.characterEffect1053ui_story = var_251_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_22 = 0.200000002980232

			if var_251_21 <= arg_248_1.time_ and arg_248_1.time_ < var_251_21 + var_251_22 and not isNil(var_251_20) then
				local var_251_23 = (arg_248_1.time_ - var_251_21) / var_251_22

				if arg_248_1.var_.characterEffect1053ui_story and not isNil(var_251_20) then
					local var_251_24 = Mathf.Lerp(0, 0.5, var_251_23)

					arg_248_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1053ui_story.fillRatio = var_251_24
				end
			end

			if arg_248_1.time_ >= var_251_21 + var_251_22 and arg_248_1.time_ < var_251_21 + var_251_22 + arg_251_0 and not isNil(var_251_20) and arg_248_1.var_.characterEffect1053ui_story then
				local var_251_25 = 0.5

				arg_248_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1053ui_story.fillRatio = var_251_25
			end

			local var_251_26 = 0.4
			local var_251_27 = 1

			if var_251_26 < arg_248_1.time_ and arg_248_1.time_ <= var_251_26 + arg_251_0 then
				local var_251_28 = "play"
				local var_251_29 = "effect"

				arg_248_1:AudioAction(var_251_28, var_251_29, "se_story_150", "se_story_150_box01", "")
			end

			local var_251_30 = 0
			local var_251_31 = 1.1

			if var_251_30 < arg_248_1.time_ and arg_248_1.time_ <= var_251_30 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_32 = arg_248_1:GetWordFromCfg(324131061)
				local var_251_33 = arg_248_1:FormatText(var_251_32.content)

				arg_248_1.text_.text = var_251_33

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_34 = 44
				local var_251_35 = utf8.len(var_251_33)
				local var_251_36 = var_251_34 <= 0 and var_251_31 or var_251_31 * (var_251_35 / var_251_34)

				if var_251_36 > 0 and var_251_31 < var_251_36 then
					arg_248_1.talkMaxDuration = var_251_36

					if var_251_36 + var_251_30 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_36 + var_251_30
					end
				end

				arg_248_1.text_.text = var_251_33
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_37 = math.max(var_251_31, arg_248_1.talkMaxDuration)

			if var_251_30 <= arg_248_1.time_ and arg_248_1.time_ < var_251_30 + var_251_37 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_30) / var_251_37

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_30 + var_251_37 and arg_248_1.time_ < var_251_30 + var_251_37 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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

		arg_248_1:InitPlayNodeList()
	end,
	Play324131062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324131062
		arg_252_1.duration_ = 2

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324131063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1053ui_story"].transform
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.var_.moveOldPos1053ui_story = var_255_0.localPosition

				local var_255_2 = GameObjectTools.GetOrAddComponent(var_255_0.gameObject, typeof(DynamicBoneHelper))

				if var_255_2 then
					var_255_2:EnableDynamicBone(false)
				end
			end

			local var_255_3 = 0.001

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_3 then
				local var_255_4 = (arg_252_1.time_ - var_255_1) / var_255_3
				local var_255_5 = Vector3.New(0, -1.08, -6)

				var_255_0.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1053ui_story, var_255_5, var_255_4)

				local var_255_6 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_6.x, var_255_6.y, var_255_6.z)

				local var_255_7 = var_255_0.localEulerAngles

				var_255_7.z = 0
				var_255_7.x = 0
				var_255_0.localEulerAngles = var_255_7
			end

			if arg_252_1.time_ >= var_255_1 + var_255_3 and arg_252_1.time_ < var_255_1 + var_255_3 + arg_255_0 then
				var_255_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_255_8 = manager.ui.mainCamera.transform.position - var_255_0.position

				var_255_0.forward = Vector3.New(var_255_8.x, var_255_8.y, var_255_8.z)

				local var_255_9 = var_255_0.localEulerAngles

				var_255_9.z = 0
				var_255_9.x = 0
				var_255_0.localEulerAngles = var_255_9

				local var_255_10 = GameObjectTools.GetOrAddComponent(var_255_0.gameObject, typeof(DynamicBoneHelper))

				if var_255_10 then
					var_255_10:EnableDynamicBone(true)
				end
			end

			local var_255_11 = arg_252_1.actors_["1053ui_story"]
			local var_255_12 = 0

			if var_255_12 < arg_252_1.time_ and arg_252_1.time_ <= var_255_12 + arg_255_0 and not isNil(var_255_11) and arg_252_1.var_.characterEffect1053ui_story == nil then
				arg_252_1.var_.characterEffect1053ui_story = var_255_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_13 = 0.200000002980232

			if var_255_12 <= arg_252_1.time_ and arg_252_1.time_ < var_255_12 + var_255_13 and not isNil(var_255_11) then
				local var_255_14 = (arg_252_1.time_ - var_255_12) / var_255_13

				if arg_252_1.var_.characterEffect1053ui_story and not isNil(var_255_11) then
					arg_252_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_12 + var_255_13 and arg_252_1.time_ < var_255_12 + var_255_13 + arg_255_0 and not isNil(var_255_11) and arg_252_1.var_.characterEffect1053ui_story then
				arg_252_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_255_15 = 0

			if var_255_15 < arg_252_1.time_ and arg_252_1.time_ <= var_255_15 + arg_255_0 then
				arg_252_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			local var_255_16 = 0

			if var_255_16 < arg_252_1.time_ and arg_252_1.time_ <= var_255_16 + arg_255_0 then
				arg_252_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_255_17 = 0
			local var_255_18 = 0.15

			if var_255_17 < arg_252_1.time_ and arg_252_1.time_ <= var_255_17 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_19 = arg_252_1:FormatText(StoryNameCfg[472].name)

				arg_252_1.leftNameTxt_.text = var_255_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_20 = arg_252_1:GetWordFromCfg(324131062)
				local var_255_21 = arg_252_1:FormatText(var_255_20.content)

				arg_252_1.text_.text = var_255_21

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_22 = 6
				local var_255_23 = utf8.len(var_255_21)
				local var_255_24 = var_255_22 <= 0 and var_255_18 or var_255_18 * (var_255_23 / var_255_22)

				if var_255_24 > 0 and var_255_18 < var_255_24 then
					arg_252_1.talkMaxDuration = var_255_24

					if var_255_24 + var_255_17 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_24 + var_255_17
					end
				end

				arg_252_1.text_.text = var_255_21
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131062", "story_v_out_324131.awb") ~= 0 then
					local var_255_25 = manager.audio:GetVoiceLength("story_v_out_324131", "324131062", "story_v_out_324131.awb") / 1000

					if var_255_25 + var_255_17 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_25 + var_255_17
					end

					if var_255_20.prefab_name ~= "" and arg_252_1.actors_[var_255_20.prefab_name] ~= nil then
						local var_255_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_20.prefab_name].transform, "story_v_out_324131", "324131062", "story_v_out_324131.awb")

						arg_252_1:RecordAudio("324131062", var_255_26)
						arg_252_1:RecordAudio("324131062", var_255_26)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_324131", "324131062", "story_v_out_324131.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_324131", "324131062", "story_v_out_324131.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_27 = math.max(var_255_18, arg_252_1.talkMaxDuration)

			if var_255_17 <= arg_252_1.time_ and arg_252_1.time_ < var_255_17 + var_255_27 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_17) / var_255_27

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_17 + var_255_27 and arg_252_1.time_ < var_255_17 + var_255_27 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
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

		arg_252_1:InitPlayNodeList()
	end,
	Play324131063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 324131063
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play324131064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1053ui_story"].transform
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.moveOldPos1053ui_story = var_259_0.localPosition

				local var_259_2 = GameObjectTools.GetOrAddComponent(var_259_0.gameObject, typeof(DynamicBoneHelper))

				if var_259_2 then
					var_259_2:EnableDynamicBone(false)
				end
			end

			local var_259_3 = 0.001

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_3 then
				local var_259_4 = (arg_256_1.time_ - var_259_1) / var_259_3
				local var_259_5 = Vector3.New(0, 100, 0)

				var_259_0.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1053ui_story, var_259_5, var_259_4)

				local var_259_6 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_6.x, var_259_6.y, var_259_6.z)

				local var_259_7 = var_259_0.localEulerAngles

				var_259_7.z = 0
				var_259_7.x = 0
				var_259_0.localEulerAngles = var_259_7
			end

			if arg_256_1.time_ >= var_259_1 + var_259_3 and arg_256_1.time_ < var_259_1 + var_259_3 + arg_259_0 then
				var_259_0.localPosition = Vector3.New(0, 100, 0)

				local var_259_8 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_8.x, var_259_8.y, var_259_8.z)

				local var_259_9 = var_259_0.localEulerAngles

				var_259_9.z = 0
				var_259_9.x = 0
				var_259_0.localEulerAngles = var_259_9

				local var_259_10 = GameObjectTools.GetOrAddComponent(var_259_0.gameObject, typeof(DynamicBoneHelper))

				if var_259_10 then
					var_259_10:EnableDynamicBone(true)
				end
			end

			local var_259_11 = arg_256_1.actors_["1053ui_story"]
			local var_259_12 = 0

			if var_259_12 < arg_256_1.time_ and arg_256_1.time_ <= var_259_12 + arg_259_0 and not isNil(var_259_11) and arg_256_1.var_.characterEffect1053ui_story == nil then
				arg_256_1.var_.characterEffect1053ui_story = var_259_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_13 = 0.200000002980232

			if var_259_12 <= arg_256_1.time_ and arg_256_1.time_ < var_259_12 + var_259_13 and not isNil(var_259_11) then
				local var_259_14 = (arg_256_1.time_ - var_259_12) / var_259_13

				if arg_256_1.var_.characterEffect1053ui_story and not isNil(var_259_11) then
					local var_259_15 = Mathf.Lerp(0, 0.5, var_259_14)

					arg_256_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1053ui_story.fillRatio = var_259_15
				end
			end

			if arg_256_1.time_ >= var_259_12 + var_259_13 and arg_256_1.time_ < var_259_12 + var_259_13 + arg_259_0 and not isNil(var_259_11) and arg_256_1.var_.characterEffect1053ui_story then
				local var_259_16 = 0.5

				arg_256_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1053ui_story.fillRatio = var_259_16
			end

			local var_259_17 = 0.4
			local var_259_18 = 1

			if var_259_17 < arg_256_1.time_ and arg_256_1.time_ <= var_259_17 + arg_259_0 then
				local var_259_19 = "play"
				local var_259_20 = "effect"

				arg_256_1:AudioAction(var_259_19, var_259_20, "se_story_150", "se_story_150_box02", "")
			end

			local var_259_21 = 0
			local var_259_22 = 0.975

			if var_259_21 < arg_256_1.time_ and arg_256_1.time_ <= var_259_21 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_23 = arg_256_1:GetWordFromCfg(324131063)
				local var_259_24 = arg_256_1:FormatText(var_259_23.content)

				arg_256_1.text_.text = var_259_24

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_25 = 39
				local var_259_26 = utf8.len(var_259_24)
				local var_259_27 = var_259_25 <= 0 and var_259_22 or var_259_22 * (var_259_26 / var_259_25)

				if var_259_27 > 0 and var_259_22 < var_259_27 then
					arg_256_1.talkMaxDuration = var_259_27

					if var_259_27 + var_259_21 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_27 + var_259_21
					end
				end

				arg_256_1.text_.text = var_259_24
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_28 = math.max(var_259_22, arg_256_1.talkMaxDuration)

			if var_259_21 <= arg_256_1.time_ and arg_256_1.time_ < var_259_21 + var_259_28 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_21) / var_259_28

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_21 + var_259_28 and arg_256_1.time_ < var_259_21 + var_259_28 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
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

		arg_256_1:InitPlayNodeList()
	end,
	Play324131064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 324131064
		arg_260_1.duration_ = 4.77

		local var_260_0 = {
			zh = 4.766,
			ja = 2.733
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
				arg_260_0:Play324131065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1070ui_story"].transform
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.moveOldPos1070ui_story = var_263_0.localPosition
			end

			local var_263_2 = 0.001

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2
				local var_263_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_263_0.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1070ui_story, var_263_4, var_263_3)

				local var_263_5 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_5.x, var_263_5.y, var_263_5.z)

				local var_263_6 = var_263_0.localEulerAngles

				var_263_6.z = 0
				var_263_6.x = 0
				var_263_0.localEulerAngles = var_263_6
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 then
				var_263_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_263_7 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_7.x, var_263_7.y, var_263_7.z)

				local var_263_8 = var_263_0.localEulerAngles

				var_263_8.z = 0
				var_263_8.x = 0
				var_263_0.localEulerAngles = var_263_8
			end

			local var_263_9 = arg_260_1.actors_["1070ui_story"]
			local var_263_10 = 0

			if var_263_10 < arg_260_1.time_ and arg_260_1.time_ <= var_263_10 + arg_263_0 and not isNil(var_263_9) and arg_260_1.var_.characterEffect1070ui_story == nil then
				arg_260_1.var_.characterEffect1070ui_story = var_263_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_11 = 0.200000002980232

			if var_263_10 <= arg_260_1.time_ and arg_260_1.time_ < var_263_10 + var_263_11 and not isNil(var_263_9) then
				local var_263_12 = (arg_260_1.time_ - var_263_10) / var_263_11

				if arg_260_1.var_.characterEffect1070ui_story and not isNil(var_263_9) then
					arg_260_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= var_263_10 + var_263_11 and arg_260_1.time_ < var_263_10 + var_263_11 + arg_263_0 and not isNil(var_263_9) and arg_260_1.var_.characterEffect1070ui_story then
				arg_260_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_263_13 = 0

			if var_263_13 < arg_260_1.time_ and arg_260_1.time_ <= var_263_13 + arg_263_0 then
				arg_260_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_263_14 = 0

			if var_263_14 < arg_260_1.time_ and arg_260_1.time_ <= var_263_14 + arg_263_0 then
				arg_260_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_263_15 = 0
			local var_263_16 = 0.175

			if var_263_15 < arg_260_1.time_ and arg_260_1.time_ <= var_263_15 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_17 = arg_260_1:FormatText(StoryNameCfg[318].name)

				arg_260_1.leftNameTxt_.text = var_263_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_18 = arg_260_1:GetWordFromCfg(324131064)
				local var_263_19 = arg_260_1:FormatText(var_263_18.content)

				arg_260_1.text_.text = var_263_19

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_20 = 7
				local var_263_21 = utf8.len(var_263_19)
				local var_263_22 = var_263_20 <= 0 and var_263_16 or var_263_16 * (var_263_21 / var_263_20)

				if var_263_22 > 0 and var_263_16 < var_263_22 then
					arg_260_1.talkMaxDuration = var_263_22

					if var_263_22 + var_263_15 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_22 + var_263_15
					end
				end

				arg_260_1.text_.text = var_263_19
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131064", "story_v_out_324131.awb") ~= 0 then
					local var_263_23 = manager.audio:GetVoiceLength("story_v_out_324131", "324131064", "story_v_out_324131.awb") / 1000

					if var_263_23 + var_263_15 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_23 + var_263_15
					end

					if var_263_18.prefab_name ~= "" and arg_260_1.actors_[var_263_18.prefab_name] ~= nil then
						local var_263_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_18.prefab_name].transform, "story_v_out_324131", "324131064", "story_v_out_324131.awb")

						arg_260_1:RecordAudio("324131064", var_263_24)
						arg_260_1:RecordAudio("324131064", var_263_24)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_324131", "324131064", "story_v_out_324131.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_324131", "324131064", "story_v_out_324131.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_25 = math.max(var_263_16, arg_260_1.talkMaxDuration)

			if var_263_15 <= arg_260_1.time_ and arg_260_1.time_ < var_263_15 + var_263_25 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_15) / var_263_25

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_15 + var_263_25 and arg_260_1.time_ < var_263_15 + var_263_25 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play324131065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 324131065
		arg_264_1.duration_ = 4.9

		local var_264_0 = {
			zh = 4.466,
			ja = 4.9
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
				arg_264_0:Play324131066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["1053ui_story"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos1053ui_story = var_267_0.localPosition

				local var_267_2 = GameObjectTools.GetOrAddComponent(var_267_0.gameObject, typeof(DynamicBoneHelper))

				if var_267_2 then
					var_267_2:EnableDynamicBone(false)
				end
			end

			local var_267_3 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_3 then
				local var_267_4 = (arg_264_1.time_ - var_267_1) / var_267_3
				local var_267_5 = Vector3.New(0.7, -1.08, -6)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1053ui_story, var_267_5, var_267_4)

				local var_267_6 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_6.x, var_267_6.y, var_267_6.z)

				local var_267_7 = var_267_0.localEulerAngles

				var_267_7.z = 0
				var_267_7.x = 0
				var_267_0.localEulerAngles = var_267_7
			end

			if arg_264_1.time_ >= var_267_1 + var_267_3 and arg_264_1.time_ < var_267_1 + var_267_3 + arg_267_0 then
				var_267_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_267_8 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_8.x, var_267_8.y, var_267_8.z)

				local var_267_9 = var_267_0.localEulerAngles

				var_267_9.z = 0
				var_267_9.x = 0
				var_267_0.localEulerAngles = var_267_9

				local var_267_10 = GameObjectTools.GetOrAddComponent(var_267_0.gameObject, typeof(DynamicBoneHelper))

				if var_267_10 then
					var_267_10:EnableDynamicBone(true)
				end
			end

			local var_267_11 = arg_264_1.actors_["1053ui_story"]
			local var_267_12 = 0

			if var_267_12 < arg_264_1.time_ and arg_264_1.time_ <= var_267_12 + arg_267_0 and not isNil(var_267_11) and arg_264_1.var_.characterEffect1053ui_story == nil then
				arg_264_1.var_.characterEffect1053ui_story = var_267_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_13 = 0.200000002980232

			if var_267_12 <= arg_264_1.time_ and arg_264_1.time_ < var_267_12 + var_267_13 and not isNil(var_267_11) then
				local var_267_14 = (arg_264_1.time_ - var_267_12) / var_267_13

				if arg_264_1.var_.characterEffect1053ui_story and not isNil(var_267_11) then
					arg_264_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_12 + var_267_13 and arg_264_1.time_ < var_267_12 + var_267_13 + arg_267_0 and not isNil(var_267_11) and arg_264_1.var_.characterEffect1053ui_story then
				arg_264_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_267_15 = arg_264_1.actors_["1070ui_story"]
			local var_267_16 = 0

			if var_267_16 < arg_264_1.time_ and arg_264_1.time_ <= var_267_16 + arg_267_0 and not isNil(var_267_15) and arg_264_1.var_.characterEffect1070ui_story == nil then
				arg_264_1.var_.characterEffect1070ui_story = var_267_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_17 = 0.200000002980232

			if var_267_16 <= arg_264_1.time_ and arg_264_1.time_ < var_267_16 + var_267_17 and not isNil(var_267_15) then
				local var_267_18 = (arg_264_1.time_ - var_267_16) / var_267_17

				if arg_264_1.var_.characterEffect1070ui_story and not isNil(var_267_15) then
					local var_267_19 = Mathf.Lerp(0, 0.5, var_267_18)

					arg_264_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1070ui_story.fillRatio = var_267_19
				end
			end

			if arg_264_1.time_ >= var_267_16 + var_267_17 and arg_264_1.time_ < var_267_16 + var_267_17 + arg_267_0 and not isNil(var_267_15) and arg_264_1.var_.characterEffect1070ui_story then
				local var_267_20 = 0.5

				arg_264_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1070ui_story.fillRatio = var_267_20
			end

			local var_267_21 = 0
			local var_267_22 = 0.525

			if var_267_21 < arg_264_1.time_ and arg_264_1.time_ <= var_267_21 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_23 = arg_264_1:FormatText(StoryNameCfg[472].name)

				arg_264_1.leftNameTxt_.text = var_267_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_24 = arg_264_1:GetWordFromCfg(324131065)
				local var_267_25 = arg_264_1:FormatText(var_267_24.content)

				arg_264_1.text_.text = var_267_25

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_26 = 21
				local var_267_27 = utf8.len(var_267_25)
				local var_267_28 = var_267_26 <= 0 and var_267_22 or var_267_22 * (var_267_27 / var_267_26)

				if var_267_28 > 0 and var_267_22 < var_267_28 then
					arg_264_1.talkMaxDuration = var_267_28

					if var_267_28 + var_267_21 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_28 + var_267_21
					end
				end

				arg_264_1.text_.text = var_267_25
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131065", "story_v_out_324131.awb") ~= 0 then
					local var_267_29 = manager.audio:GetVoiceLength("story_v_out_324131", "324131065", "story_v_out_324131.awb") / 1000

					if var_267_29 + var_267_21 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_29 + var_267_21
					end

					if var_267_24.prefab_name ~= "" and arg_264_1.actors_[var_267_24.prefab_name] ~= nil then
						local var_267_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_24.prefab_name].transform, "story_v_out_324131", "324131065", "story_v_out_324131.awb")

						arg_264_1:RecordAudio("324131065", var_267_30)
						arg_264_1:RecordAudio("324131065", var_267_30)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_324131", "324131065", "story_v_out_324131.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_324131", "324131065", "story_v_out_324131.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_31 = math.max(var_267_22, arg_264_1.talkMaxDuration)

			if var_267_21 <= arg_264_1.time_ and arg_264_1.time_ < var_267_21 + var_267_31 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_21) / var_267_31

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_21 + var_267_31 and arg_264_1.time_ < var_267_21 + var_267_31 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
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

		arg_264_1:InitPlayNodeList()
	end,
	Play324131066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 324131066
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play324131067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["1070ui_story"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos1070ui_story = var_271_0.localPosition
			end

			local var_271_2 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2
				local var_271_4 = Vector3.New(0, 100, 0)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1070ui_story, var_271_4, var_271_3)

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

			local var_271_9 = arg_268_1.actors_["1053ui_story"].transform
			local var_271_10 = 0

			if var_271_10 < arg_268_1.time_ and arg_268_1.time_ <= var_271_10 + arg_271_0 then
				arg_268_1.var_.moveOldPos1053ui_story = var_271_9.localPosition

				local var_271_11 = GameObjectTools.GetOrAddComponent(var_271_9.gameObject, typeof(DynamicBoneHelper))

				if var_271_11 then
					var_271_11:EnableDynamicBone(false)
				end
			end

			local var_271_12 = 0.001

			if var_271_10 <= arg_268_1.time_ and arg_268_1.time_ < var_271_10 + var_271_12 then
				local var_271_13 = (arg_268_1.time_ - var_271_10) / var_271_12
				local var_271_14 = Vector3.New(0, 100, 0)

				var_271_9.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1053ui_story, var_271_14, var_271_13)

				local var_271_15 = manager.ui.mainCamera.transform.position - var_271_9.position

				var_271_9.forward = Vector3.New(var_271_15.x, var_271_15.y, var_271_15.z)

				local var_271_16 = var_271_9.localEulerAngles

				var_271_16.z = 0
				var_271_16.x = 0
				var_271_9.localEulerAngles = var_271_16
			end

			if arg_268_1.time_ >= var_271_10 + var_271_12 and arg_268_1.time_ < var_271_10 + var_271_12 + arg_271_0 then
				var_271_9.localPosition = Vector3.New(0, 100, 0)

				local var_271_17 = manager.ui.mainCamera.transform.position - var_271_9.position

				var_271_9.forward = Vector3.New(var_271_17.x, var_271_17.y, var_271_17.z)

				local var_271_18 = var_271_9.localEulerAngles

				var_271_18.z = 0
				var_271_18.x = 0
				var_271_9.localEulerAngles = var_271_18

				local var_271_19 = GameObjectTools.GetOrAddComponent(var_271_9.gameObject, typeof(DynamicBoneHelper))

				if var_271_19 then
					var_271_19:EnableDynamicBone(true)
				end
			end

			local var_271_20 = arg_268_1.actors_["1053ui_story"]
			local var_271_21 = 0

			if var_271_21 < arg_268_1.time_ and arg_268_1.time_ <= var_271_21 + arg_271_0 and not isNil(var_271_20) and arg_268_1.var_.characterEffect1053ui_story == nil then
				arg_268_1.var_.characterEffect1053ui_story = var_271_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_22 = 0.200000002980232

			if var_271_21 <= arg_268_1.time_ and arg_268_1.time_ < var_271_21 + var_271_22 and not isNil(var_271_20) then
				local var_271_23 = (arg_268_1.time_ - var_271_21) / var_271_22

				if arg_268_1.var_.characterEffect1053ui_story and not isNil(var_271_20) then
					local var_271_24 = Mathf.Lerp(0, 0.5, var_271_23)

					arg_268_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1053ui_story.fillRatio = var_271_24
				end
			end

			if arg_268_1.time_ >= var_271_21 + var_271_22 and arg_268_1.time_ < var_271_21 + var_271_22 + arg_271_0 and not isNil(var_271_20) and arg_268_1.var_.characterEffect1053ui_story then
				local var_271_25 = 0.5

				arg_268_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1053ui_story.fillRatio = var_271_25
			end

			local var_271_26 = 0
			local var_271_27 = 1.2

			if var_271_26 < arg_268_1.time_ and arg_268_1.time_ <= var_271_26 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_28 = arg_268_1:GetWordFromCfg(324131066)
				local var_271_29 = arg_268_1:FormatText(var_271_28.content)

				arg_268_1.text_.text = var_271_29

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_30 = 48
				local var_271_31 = utf8.len(var_271_29)
				local var_271_32 = var_271_30 <= 0 and var_271_27 or var_271_27 * (var_271_31 / var_271_30)

				if var_271_32 > 0 and var_271_27 < var_271_32 then
					arg_268_1.talkMaxDuration = var_271_32

					if var_271_32 + var_271_26 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_32 + var_271_26
					end
				end

				arg_268_1.text_.text = var_271_29
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_33 = math.max(var_271_27, arg_268_1.talkMaxDuration)

			if var_271_26 <= arg_268_1.time_ and arg_268_1.time_ < var_271_26 + var_271_33 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_26) / var_271_33

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_26 + var_271_33 and arg_268_1.time_ < var_271_26 + var_271_33 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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

		arg_268_1:InitPlayNodeList()
	end,
	Play324131067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 324131067
		arg_272_1.duration_ = 6.13

		local var_272_0 = {
			zh = 4.466,
			ja = 6.133
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
				arg_272_0:Play324131068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["1070ui_story"].transform
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.var_.moveOldPos1070ui_story = var_275_0.localPosition
			end

			local var_275_2 = 0.001

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2
				local var_275_4 = Vector3.New(-0.7, -0.95, -6.05)

				var_275_0.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1070ui_story, var_275_4, var_275_3)

				local var_275_5 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_5.x, var_275_5.y, var_275_5.z)

				local var_275_6 = var_275_0.localEulerAngles

				var_275_6.z = 0
				var_275_6.x = 0
				var_275_0.localEulerAngles = var_275_6
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 then
				var_275_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_275_7 = manager.ui.mainCamera.transform.position - var_275_0.position

				var_275_0.forward = Vector3.New(var_275_7.x, var_275_7.y, var_275_7.z)

				local var_275_8 = var_275_0.localEulerAngles

				var_275_8.z = 0
				var_275_8.x = 0
				var_275_0.localEulerAngles = var_275_8
			end

			local var_275_9 = arg_272_1.actors_["1070ui_story"]
			local var_275_10 = 0

			if var_275_10 < arg_272_1.time_ and arg_272_1.time_ <= var_275_10 + arg_275_0 and not isNil(var_275_9) and arg_272_1.var_.characterEffect1070ui_story == nil then
				arg_272_1.var_.characterEffect1070ui_story = var_275_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_11 = 0.200000002980232

			if var_275_10 <= arg_272_1.time_ and arg_272_1.time_ < var_275_10 + var_275_11 and not isNil(var_275_9) then
				local var_275_12 = (arg_272_1.time_ - var_275_10) / var_275_11

				if arg_272_1.var_.characterEffect1070ui_story and not isNil(var_275_9) then
					arg_272_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_10 + var_275_11 and arg_272_1.time_ < var_275_10 + var_275_11 + arg_275_0 and not isNil(var_275_9) and arg_272_1.var_.characterEffect1070ui_story then
				arg_272_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_275_13 = 0

			if var_275_13 < arg_272_1.time_ and arg_272_1.time_ <= var_275_13 + arg_275_0 then
				arg_272_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action437")
			end

			local var_275_14 = 0

			if var_275_14 < arg_272_1.time_ and arg_272_1.time_ <= var_275_14 + arg_275_0 then
				arg_272_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_275_15 = 0
			local var_275_16 = 0.525

			if var_275_15 < arg_272_1.time_ and arg_272_1.time_ <= var_275_15 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_17 = arg_272_1:FormatText(StoryNameCfg[318].name)

				arg_272_1.leftNameTxt_.text = var_275_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_18 = arg_272_1:GetWordFromCfg(324131067)
				local var_275_19 = arg_272_1:FormatText(var_275_18.content)

				arg_272_1.text_.text = var_275_19

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_20 = 21
				local var_275_21 = utf8.len(var_275_19)
				local var_275_22 = var_275_20 <= 0 and var_275_16 or var_275_16 * (var_275_21 / var_275_20)

				if var_275_22 > 0 and var_275_16 < var_275_22 then
					arg_272_1.talkMaxDuration = var_275_22

					if var_275_22 + var_275_15 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_22 + var_275_15
					end
				end

				arg_272_1.text_.text = var_275_19
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131067", "story_v_out_324131.awb") ~= 0 then
					local var_275_23 = manager.audio:GetVoiceLength("story_v_out_324131", "324131067", "story_v_out_324131.awb") / 1000

					if var_275_23 + var_275_15 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_23 + var_275_15
					end

					if var_275_18.prefab_name ~= "" and arg_272_1.actors_[var_275_18.prefab_name] ~= nil then
						local var_275_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_18.prefab_name].transform, "story_v_out_324131", "324131067", "story_v_out_324131.awb")

						arg_272_1:RecordAudio("324131067", var_275_24)
						arg_272_1:RecordAudio("324131067", var_275_24)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_324131", "324131067", "story_v_out_324131.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_324131", "324131067", "story_v_out_324131.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_25 = math.max(var_275_16, arg_272_1.talkMaxDuration)

			if var_275_15 <= arg_272_1.time_ and arg_272_1.time_ < var_275_15 + var_275_25 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_15) / var_275_25

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_15 + var_275_25 and arg_272_1.time_ < var_275_15 + var_275_25 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play324131068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 324131068
		arg_276_1.duration_ = 6.1

		local var_276_0 = {
			zh = 5.866,
			ja = 6.1
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play324131069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1053ui_story"].transform
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.var_.moveOldPos1053ui_story = var_279_0.localPosition

				local var_279_2 = GameObjectTools.GetOrAddComponent(var_279_0.gameObject, typeof(DynamicBoneHelper))

				if var_279_2 then
					var_279_2:EnableDynamicBone(false)
				end
			end

			local var_279_3 = 0.001

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_3 then
				local var_279_4 = (arg_276_1.time_ - var_279_1) / var_279_3
				local var_279_5 = Vector3.New(0.7, -1.08, -6)

				var_279_0.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1053ui_story, var_279_5, var_279_4)

				local var_279_6 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_6.x, var_279_6.y, var_279_6.z)

				local var_279_7 = var_279_0.localEulerAngles

				var_279_7.z = 0
				var_279_7.x = 0
				var_279_0.localEulerAngles = var_279_7
			end

			if arg_276_1.time_ >= var_279_1 + var_279_3 and arg_276_1.time_ < var_279_1 + var_279_3 + arg_279_0 then
				var_279_0.localPosition = Vector3.New(0.7, -1.08, -6)

				local var_279_8 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_8.x, var_279_8.y, var_279_8.z)

				local var_279_9 = var_279_0.localEulerAngles

				var_279_9.z = 0
				var_279_9.x = 0
				var_279_0.localEulerAngles = var_279_9

				local var_279_10 = GameObjectTools.GetOrAddComponent(var_279_0.gameObject, typeof(DynamicBoneHelper))

				if var_279_10 then
					var_279_10:EnableDynamicBone(true)
				end
			end

			local var_279_11 = arg_276_1.actors_["1053ui_story"]
			local var_279_12 = 0

			if var_279_12 < arg_276_1.time_ and arg_276_1.time_ <= var_279_12 + arg_279_0 and not isNil(var_279_11) and arg_276_1.var_.characterEffect1053ui_story == nil then
				arg_276_1.var_.characterEffect1053ui_story = var_279_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_13 = 0.200000002980232

			if var_279_12 <= arg_276_1.time_ and arg_276_1.time_ < var_279_12 + var_279_13 and not isNil(var_279_11) then
				local var_279_14 = (arg_276_1.time_ - var_279_12) / var_279_13

				if arg_276_1.var_.characterEffect1053ui_story and not isNil(var_279_11) then
					arg_276_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= var_279_12 + var_279_13 and arg_276_1.time_ < var_279_12 + var_279_13 + arg_279_0 and not isNil(var_279_11) and arg_276_1.var_.characterEffect1053ui_story then
				arg_276_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_279_15 = arg_276_1.actors_["1070ui_story"]
			local var_279_16 = 0

			if var_279_16 < arg_276_1.time_ and arg_276_1.time_ <= var_279_16 + arg_279_0 and not isNil(var_279_15) and arg_276_1.var_.characterEffect1070ui_story == nil then
				arg_276_1.var_.characterEffect1070ui_story = var_279_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_17 = 0.200000002980232

			if var_279_16 <= arg_276_1.time_ and arg_276_1.time_ < var_279_16 + var_279_17 and not isNil(var_279_15) then
				local var_279_18 = (arg_276_1.time_ - var_279_16) / var_279_17

				if arg_276_1.var_.characterEffect1070ui_story and not isNil(var_279_15) then
					local var_279_19 = Mathf.Lerp(0, 0.5, var_279_18)

					arg_276_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1070ui_story.fillRatio = var_279_19
				end
			end

			if arg_276_1.time_ >= var_279_16 + var_279_17 and arg_276_1.time_ < var_279_16 + var_279_17 + arg_279_0 and not isNil(var_279_15) and arg_276_1.var_.characterEffect1070ui_story then
				local var_279_20 = 0.5

				arg_276_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1070ui_story.fillRatio = var_279_20
			end

			local var_279_21 = 0

			if var_279_21 < arg_276_1.time_ and arg_276_1.time_ <= var_279_21 + arg_279_0 then
				arg_276_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			local var_279_22 = 0

			if var_279_22 < arg_276_1.time_ and arg_276_1.time_ <= var_279_22 + arg_279_0 then
				arg_276_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_279_23 = 0
			local var_279_24 = 0.525

			if var_279_23 < arg_276_1.time_ and arg_276_1.time_ <= var_279_23 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_25 = arg_276_1:FormatText(StoryNameCfg[472].name)

				arg_276_1.leftNameTxt_.text = var_279_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_26 = arg_276_1:GetWordFromCfg(324131068)
				local var_279_27 = arg_276_1:FormatText(var_279_26.content)

				arg_276_1.text_.text = var_279_27

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_28 = 21
				local var_279_29 = utf8.len(var_279_27)
				local var_279_30 = var_279_28 <= 0 and var_279_24 or var_279_24 * (var_279_29 / var_279_28)

				if var_279_30 > 0 and var_279_24 < var_279_30 then
					arg_276_1.talkMaxDuration = var_279_30

					if var_279_30 + var_279_23 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_30 + var_279_23
					end
				end

				arg_276_1.text_.text = var_279_27
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131068", "story_v_out_324131.awb") ~= 0 then
					local var_279_31 = manager.audio:GetVoiceLength("story_v_out_324131", "324131068", "story_v_out_324131.awb") / 1000

					if var_279_31 + var_279_23 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_31 + var_279_23
					end

					if var_279_26.prefab_name ~= "" and arg_276_1.actors_[var_279_26.prefab_name] ~= nil then
						local var_279_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_26.prefab_name].transform, "story_v_out_324131", "324131068", "story_v_out_324131.awb")

						arg_276_1:RecordAudio("324131068", var_279_32)
						arg_276_1:RecordAudio("324131068", var_279_32)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_324131", "324131068", "story_v_out_324131.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_324131", "324131068", "story_v_out_324131.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_33 = math.max(var_279_24, arg_276_1.talkMaxDuration)

			if var_279_23 <= arg_276_1.time_ and arg_276_1.time_ < var_279_23 + var_279_33 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_23) / var_279_33

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_23 + var_279_33 and arg_276_1.time_ < var_279_23 + var_279_33 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
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

		arg_276_1:InitPlayNodeList()
	end,
	Play324131069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 324131069
		arg_280_1.duration_ = 8

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play324131070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = "STblack"

			if arg_280_1.bgs_[var_283_0] == nil then
				local var_283_1 = Object.Instantiate(arg_280_1.paintGo_)

				var_283_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_283_0)
				var_283_1.name = var_283_0
				var_283_1.transform.parent = arg_280_1.stage_.transform
				var_283_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_280_1.bgs_[var_283_0] = var_283_1
			end

			local var_283_2 = 1.46666666666667

			if var_283_2 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				local var_283_3 = manager.ui.mainCamera.transform.localPosition
				local var_283_4 = Vector3.New(0, 0, 10) + Vector3.New(var_283_3.x, var_283_3.y, 0)
				local var_283_5 = arg_280_1.bgs_.STblack

				var_283_5.transform.localPosition = var_283_4
				var_283_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_283_6 = var_283_5:GetComponent("SpriteRenderer")

				if var_283_6 and var_283_6.sprite then
					local var_283_7 = (var_283_5.transform.localPosition - var_283_3).z
					local var_283_8 = manager.ui.mainCameraCom_
					local var_283_9 = 2 * var_283_7 * Mathf.Tan(var_283_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_283_10 = var_283_9 * var_283_8.aspect
					local var_283_11 = var_283_6.sprite.bounds.size.x
					local var_283_12 = var_283_6.sprite.bounds.size.y
					local var_283_13 = var_283_10 / var_283_11
					local var_283_14 = var_283_9 / var_283_12
					local var_283_15 = var_283_14 < var_283_13 and var_283_13 or var_283_14

					var_283_5.transform.localScale = Vector3.New(var_283_15, var_283_15, 0)
				end

				for iter_283_0, iter_283_1 in pairs(arg_280_1.bgs_) do
					if iter_283_0 ~= "STblack" then
						iter_283_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_283_16 = 1.46666666666667

			if var_283_16 < arg_280_1.time_ and arg_280_1.time_ <= var_283_16 + arg_283_0 then
				arg_280_1.allBtn_.enabled = false
			end

			local var_283_17 = 0.3

			if arg_280_1.time_ >= var_283_16 + var_283_17 and arg_280_1.time_ < var_283_16 + var_283_17 + arg_283_0 then
				arg_280_1.allBtn_.enabled = true
			end

			local var_283_18 = 0

			if var_283_18 < arg_280_1.time_ and arg_280_1.time_ <= var_283_18 + arg_283_0 then
				arg_280_1.mask_.enabled = true
				arg_280_1.mask_.raycastTarget = true

				arg_280_1:SetGaussion(false)
			end

			local var_283_19 = 1.46666666666667

			if var_283_18 <= arg_280_1.time_ and arg_280_1.time_ < var_283_18 + var_283_19 then
				local var_283_20 = (arg_280_1.time_ - var_283_18) / var_283_19
				local var_283_21 = Color.New(0, 0, 0)

				var_283_21.a = Mathf.Lerp(0, 1, var_283_20)
				arg_280_1.mask_.color = var_283_21
			end

			if arg_280_1.time_ >= var_283_18 + var_283_19 and arg_280_1.time_ < var_283_18 + var_283_19 + arg_283_0 then
				local var_283_22 = Color.New(0, 0, 0)

				var_283_22.a = 1
				arg_280_1.mask_.color = var_283_22
			end

			local var_283_23 = 1.46666666666667

			if var_283_23 < arg_280_1.time_ and arg_280_1.time_ <= var_283_23 + arg_283_0 then
				arg_280_1.mask_.enabled = true
				arg_280_1.mask_.raycastTarget = true

				arg_280_1:SetGaussion(false)
			end

			local var_283_24 = 2

			if var_283_23 <= arg_280_1.time_ and arg_280_1.time_ < var_283_23 + var_283_24 then
				local var_283_25 = (arg_280_1.time_ - var_283_23) / var_283_24
				local var_283_26 = Color.New(0, 0, 0)

				var_283_26.a = Mathf.Lerp(1, 0, var_283_25)
				arg_280_1.mask_.color = var_283_26
			end

			if arg_280_1.time_ >= var_283_23 + var_283_24 and arg_280_1.time_ < var_283_23 + var_283_24 + arg_283_0 then
				local var_283_27 = Color.New(0, 0, 0)
				local var_283_28 = 0

				arg_280_1.mask_.enabled = false
				var_283_27.a = var_283_28
				arg_280_1.mask_.color = var_283_27
			end

			local var_283_29 = arg_280_1.actors_["1070ui_story"].transform
			local var_283_30 = 1.46666666666667

			if var_283_30 < arg_280_1.time_ and arg_280_1.time_ <= var_283_30 + arg_283_0 then
				arg_280_1.var_.moveOldPos1070ui_story = var_283_29.localPosition
			end

			local var_283_31 = 0.001

			if var_283_30 <= arg_280_1.time_ and arg_280_1.time_ < var_283_30 + var_283_31 then
				local var_283_32 = (arg_280_1.time_ - var_283_30) / var_283_31
				local var_283_33 = Vector3.New(0, 100, 0)

				var_283_29.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1070ui_story, var_283_33, var_283_32)

				local var_283_34 = manager.ui.mainCamera.transform.position - var_283_29.position

				var_283_29.forward = Vector3.New(var_283_34.x, var_283_34.y, var_283_34.z)

				local var_283_35 = var_283_29.localEulerAngles

				var_283_35.z = 0
				var_283_35.x = 0
				var_283_29.localEulerAngles = var_283_35
			end

			if arg_280_1.time_ >= var_283_30 + var_283_31 and arg_280_1.time_ < var_283_30 + var_283_31 + arg_283_0 then
				var_283_29.localPosition = Vector3.New(0, 100, 0)

				local var_283_36 = manager.ui.mainCamera.transform.position - var_283_29.position

				var_283_29.forward = Vector3.New(var_283_36.x, var_283_36.y, var_283_36.z)

				local var_283_37 = var_283_29.localEulerAngles

				var_283_37.z = 0
				var_283_37.x = 0
				var_283_29.localEulerAngles = var_283_37
			end

			local var_283_38 = arg_280_1.actors_["1053ui_story"].transform
			local var_283_39 = 1.46666666666667

			if var_283_39 < arg_280_1.time_ and arg_280_1.time_ <= var_283_39 + arg_283_0 then
				arg_280_1.var_.moveOldPos1053ui_story = var_283_38.localPosition

				local var_283_40 = GameObjectTools.GetOrAddComponent(var_283_38.gameObject, typeof(DynamicBoneHelper))

				if var_283_40 then
					var_283_40:EnableDynamicBone(false)
				end
			end

			local var_283_41 = 0.001

			if var_283_39 <= arg_280_1.time_ and arg_280_1.time_ < var_283_39 + var_283_41 then
				local var_283_42 = (arg_280_1.time_ - var_283_39) / var_283_41
				local var_283_43 = Vector3.New(0, 100, 0)

				var_283_38.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1053ui_story, var_283_43, var_283_42)

				local var_283_44 = manager.ui.mainCamera.transform.position - var_283_38.position

				var_283_38.forward = Vector3.New(var_283_44.x, var_283_44.y, var_283_44.z)

				local var_283_45 = var_283_38.localEulerAngles

				var_283_45.z = 0
				var_283_45.x = 0
				var_283_38.localEulerAngles = var_283_45
			end

			if arg_280_1.time_ >= var_283_39 + var_283_41 and arg_280_1.time_ < var_283_39 + var_283_41 + arg_283_0 then
				var_283_38.localPosition = Vector3.New(0, 100, 0)

				local var_283_46 = manager.ui.mainCamera.transform.position - var_283_38.position

				var_283_38.forward = Vector3.New(var_283_46.x, var_283_46.y, var_283_46.z)

				local var_283_47 = var_283_38.localEulerAngles

				var_283_47.z = 0
				var_283_47.x = 0
				var_283_38.localEulerAngles = var_283_47

				local var_283_48 = GameObjectTools.GetOrAddComponent(var_283_38.gameObject, typeof(DynamicBoneHelper))

				if var_283_48 then
					var_283_48:EnableDynamicBone(true)
				end
			end

			local var_283_49 = arg_280_1.actors_["1053ui_story"]
			local var_283_50 = 1.46666666666667

			if var_283_50 < arg_280_1.time_ and arg_280_1.time_ <= var_283_50 + arg_283_0 and not isNil(var_283_49) and arg_280_1.var_.characterEffect1053ui_story == nil then
				arg_280_1.var_.characterEffect1053ui_story = var_283_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_51 = 0.200000002980232

			if var_283_50 <= arg_280_1.time_ and arg_280_1.time_ < var_283_50 + var_283_51 and not isNil(var_283_49) then
				local var_283_52 = (arg_280_1.time_ - var_283_50) / var_283_51

				if arg_280_1.var_.characterEffect1053ui_story and not isNil(var_283_49) then
					local var_283_53 = Mathf.Lerp(0, 0.5, var_283_52)

					arg_280_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1053ui_story.fillRatio = var_283_53
				end
			end

			if arg_280_1.time_ >= var_283_50 + var_283_51 and arg_280_1.time_ < var_283_50 + var_283_51 + arg_283_0 and not isNil(var_283_49) and arg_280_1.var_.characterEffect1053ui_story then
				local var_283_54 = 0.5

				arg_280_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1053ui_story.fillRatio = var_283_54
			end

			if arg_280_1.frameCnt_ <= 1 then
				arg_280_1.dialog_:SetActive(false)
			end

			local var_283_55 = 3
			local var_283_56 = 0.125

			if var_283_55 < arg_280_1.time_ and arg_280_1.time_ <= var_283_55 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0

				arg_280_1.dialog_:SetActive(true)

				arg_280_1.dialogCg_.alpha = 0

				local var_283_57 = LeanTween.value(arg_280_1.dialog_, 0, 1, 0.3)

				var_283_57:setOnUpdate(LuaHelper.FloatAction(function(arg_284_0)
					arg_280_1.dialogCg_.alpha = arg_284_0
				end))
				var_283_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_280_1.dialog_)
					var_283_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_280_1.duration_ = arg_280_1.duration_ + 0.3

				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_58 = arg_280_1:GetWordFromCfg(324131069)
				local var_283_59 = arg_280_1:FormatText(var_283_58.content)

				arg_280_1.text_.text = var_283_59

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_60 = 5
				local var_283_61 = utf8.len(var_283_59)
				local var_283_62 = var_283_60 <= 0 and var_283_56 or var_283_56 * (var_283_61 / var_283_60)

				if var_283_62 > 0 and var_283_56 < var_283_62 then
					arg_280_1.talkMaxDuration = var_283_62
					var_283_55 = var_283_55 + 0.3

					if var_283_62 + var_283_55 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_62 + var_283_55
					end
				end

				arg_280_1.text_.text = var_283_59
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_63 = var_283_55 + 0.3
			local var_283_64 = math.max(var_283_56, arg_280_1.talkMaxDuration)

			if var_283_63 <= arg_280_1.time_ and arg_280_1.time_ < var_283_63 + var_283_64 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_63) / var_283_64

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_63 + var_283_64 and arg_280_1.time_ < var_283_63 + var_283_64 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play324131070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 324131070
		arg_286_1.duration_ = 7.5

		local var_286_0 = {
			zh = 5.93300000298023,
			ja = 7.50000000298023
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
				arg_286_0:Play324131071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				local var_289_1 = manager.ui.mainCamera.transform.localPosition
				local var_289_2 = Vector3.New(0, 0, 10) + Vector3.New(var_289_1.x, var_289_1.y, 0)
				local var_289_3 = arg_286_1.bgs_.ST2003

				var_289_3.transform.localPosition = var_289_2
				var_289_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_4 = var_289_3:GetComponent("SpriteRenderer")

				if var_289_4 and var_289_4.sprite then
					local var_289_5 = (var_289_3.transform.localPosition - var_289_1).z
					local var_289_6 = manager.ui.mainCameraCom_
					local var_289_7 = 2 * var_289_5 * Mathf.Tan(var_289_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_289_8 = var_289_7 * var_289_6.aspect
					local var_289_9 = var_289_4.sprite.bounds.size.x
					local var_289_10 = var_289_4.sprite.bounds.size.y
					local var_289_11 = var_289_8 / var_289_9
					local var_289_12 = var_289_7 / var_289_10
					local var_289_13 = var_289_12 < var_289_11 and var_289_11 or var_289_12

					var_289_3.transform.localScale = Vector3.New(var_289_13, var_289_13, 0)
				end

				for iter_289_0, iter_289_1 in pairs(arg_286_1.bgs_) do
					if iter_289_0 ~= "ST2003" then
						iter_289_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_14 = 0

			if var_289_14 < arg_286_1.time_ and arg_286_1.time_ <= var_289_14 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			local var_289_15 = 0.3

			if arg_286_1.time_ >= var_289_14 + var_289_15 and arg_286_1.time_ < var_289_14 + var_289_15 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end

			local var_289_16 = 0

			if var_289_16 < arg_286_1.time_ and arg_286_1.time_ <= var_289_16 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_17 = 2

			if var_289_16 <= arg_286_1.time_ and arg_286_1.time_ < var_289_16 + var_289_17 then
				local var_289_18 = (arg_286_1.time_ - var_289_16) / var_289_17
				local var_289_19 = Color.New(0, 0, 0)

				var_289_19.a = Mathf.Lerp(1, 0, var_289_18)
				arg_286_1.mask_.color = var_289_19
			end

			if arg_286_1.time_ >= var_289_16 + var_289_17 and arg_286_1.time_ < var_289_16 + var_289_17 + arg_289_0 then
				local var_289_20 = Color.New(0, 0, 0)
				local var_289_21 = 0

				arg_286_1.mask_.enabled = false
				var_289_20.a = var_289_21
				arg_286_1.mask_.color = var_289_20
			end

			local var_289_22 = "1170ui_story"

			if arg_286_1.actors_[var_289_22] == nil then
				local var_289_23 = Asset.Load("Char/" .. "1170ui_story")

				if not isNil(var_289_23) then
					local var_289_24 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_286_1.stage_.transform)

					var_289_24.name = var_289_22
					var_289_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_286_1.actors_[var_289_22] = var_289_24

					local var_289_25 = var_289_24:GetComponentInChildren(typeof(CharacterEffect))

					var_289_25.enabled = true

					local var_289_26 = GameObjectTools.GetOrAddComponent(var_289_24, typeof(DynamicBoneHelper))

					if var_289_26 then
						var_289_26:EnableDynamicBone(false)
					end

					arg_286_1:ShowWeapon(var_289_25.transform, false)

					arg_286_1.var_[var_289_22 .. "Animator"] = var_289_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_286_1.var_[var_289_22 .. "Animator"].applyRootMotion = true
					arg_286_1.var_[var_289_22 .. "LipSync"] = var_289_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_289_27 = arg_286_1.actors_["1170ui_story"].transform
			local var_289_28 = 1.8

			if var_289_28 < arg_286_1.time_ and arg_286_1.time_ <= var_289_28 + arg_289_0 then
				arg_286_1.var_.moveOldPos1170ui_story = var_289_27.localPosition

				local var_289_29 = GameObjectTools.GetOrAddComponent(var_289_27.gameObject, typeof(DynamicBoneHelper))

				if var_289_29 then
					var_289_29:EnableDynamicBone(false)
				end
			end

			local var_289_30 = 0.001

			if var_289_28 <= arg_286_1.time_ and arg_286_1.time_ < var_289_28 + var_289_30 then
				local var_289_31 = (arg_286_1.time_ - var_289_28) / var_289_30
				local var_289_32 = Vector3.New(0.03, -0.95, -6.08)

				var_289_27.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1170ui_story, var_289_32, var_289_31)

				local var_289_33 = manager.ui.mainCamera.transform.position - var_289_27.position

				var_289_27.forward = Vector3.New(var_289_33.x, var_289_33.y, var_289_33.z)

				local var_289_34 = var_289_27.localEulerAngles

				var_289_34.z = 0
				var_289_34.x = 0
				var_289_27.localEulerAngles = var_289_34
			end

			if arg_286_1.time_ >= var_289_28 + var_289_30 and arg_286_1.time_ < var_289_28 + var_289_30 + arg_289_0 then
				var_289_27.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_289_35 = manager.ui.mainCamera.transform.position - var_289_27.position

				var_289_27.forward = Vector3.New(var_289_35.x, var_289_35.y, var_289_35.z)

				local var_289_36 = var_289_27.localEulerAngles

				var_289_36.z = 0
				var_289_36.x = 0
				var_289_27.localEulerAngles = var_289_36

				local var_289_37 = GameObjectTools.GetOrAddComponent(var_289_27.gameObject, typeof(DynamicBoneHelper))

				if var_289_37 then
					var_289_37:EnableDynamicBone(true)
				end
			end

			local var_289_38 = arg_286_1.actors_["1170ui_story"]
			local var_289_39 = 1.8

			if var_289_39 < arg_286_1.time_ and arg_286_1.time_ <= var_289_39 + arg_289_0 and not isNil(var_289_38) and arg_286_1.var_.characterEffect1170ui_story == nil then
				arg_286_1.var_.characterEffect1170ui_story = var_289_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_40 = 0.200000002980232

			if var_289_39 <= arg_286_1.time_ and arg_286_1.time_ < var_289_39 + var_289_40 and not isNil(var_289_38) then
				local var_289_41 = (arg_286_1.time_ - var_289_39) / var_289_40

				if arg_286_1.var_.characterEffect1170ui_story and not isNil(var_289_38) then
					arg_286_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= var_289_39 + var_289_40 and arg_286_1.time_ < var_289_39 + var_289_40 + arg_289_0 and not isNil(var_289_38) and arg_286_1.var_.characterEffect1170ui_story then
				arg_286_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_289_42 = 1.8

			if var_289_42 < arg_286_1.time_ and arg_286_1.time_ <= var_289_42 + arg_289_0 then
				arg_286_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			local var_289_43 = 1.8

			if var_289_43 < arg_286_1.time_ and arg_286_1.time_ <= var_289_43 + arg_289_0 then
				arg_286_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_289_44 = 1.2
			local var_289_45 = 1

			if var_289_44 < arg_286_1.time_ and arg_286_1.time_ <= var_289_44 + arg_289_0 then
				local var_289_46 = "play"
				local var_289_47 = "effect"

				arg_286_1:AudioAction(var_289_46, var_289_47, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_289_48 = 0.1
			local var_289_49 = 1

			if var_289_48 < arg_286_1.time_ and arg_286_1.time_ <= var_289_48 + arg_289_0 then
				local var_289_50 = "stop"
				local var_289_51 = "effect"

				arg_286_1:AudioAction(var_289_50, var_289_51, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_286_1.frameCnt_ <= 1 then
				arg_286_1.dialog_:SetActive(false)
			end

			local var_289_52 = 2.00000000298023
			local var_289_53 = 0.45

			if var_289_52 < arg_286_1.time_ and arg_286_1.time_ <= var_289_52 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				arg_286_1.dialog_:SetActive(true)

				arg_286_1.dialogCg_.alpha = 0

				local var_289_54 = LeanTween.value(arg_286_1.dialog_, 0, 1, 0.3)

				var_289_54:setOnUpdate(LuaHelper.FloatAction(function(arg_290_0)
					arg_286_1.dialogCg_.alpha = arg_290_0
				end))
				var_289_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_286_1.dialog_)
					var_289_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_286_1.duration_ = arg_286_1.duration_ + 0.3

				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_55 = arg_286_1:FormatText(StoryNameCfg[318].name)

				arg_286_1.leftNameTxt_.text = var_289_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_56 = arg_286_1:GetWordFromCfg(324131070)
				local var_289_57 = arg_286_1:FormatText(var_289_56.content)

				arg_286_1.text_.text = var_289_57

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_58 = 18
				local var_289_59 = utf8.len(var_289_57)
				local var_289_60 = var_289_58 <= 0 and var_289_53 or var_289_53 * (var_289_59 / var_289_58)

				if var_289_60 > 0 and var_289_53 < var_289_60 then
					arg_286_1.talkMaxDuration = var_289_60
					var_289_52 = var_289_52 + 0.3

					if var_289_60 + var_289_52 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_60 + var_289_52
					end
				end

				arg_286_1.text_.text = var_289_57
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131070", "story_v_out_324131.awb") ~= 0 then
					local var_289_61 = manager.audio:GetVoiceLength("story_v_out_324131", "324131070", "story_v_out_324131.awb") / 1000

					if var_289_61 + var_289_52 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_61 + var_289_52
					end

					if var_289_56.prefab_name ~= "" and arg_286_1.actors_[var_289_56.prefab_name] ~= nil then
						local var_289_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_56.prefab_name].transform, "story_v_out_324131", "324131070", "story_v_out_324131.awb")

						arg_286_1:RecordAudio("324131070", var_289_62)
						arg_286_1:RecordAudio("324131070", var_289_62)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_324131", "324131070", "story_v_out_324131.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_324131", "324131070", "story_v_out_324131.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_63 = var_289_52 + 0.3
			local var_289_64 = math.max(var_289_53, arg_286_1.talkMaxDuration)

			if var_289_63 <= arg_286_1.time_ and arg_286_1.time_ < var_289_63 + var_289_64 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_63) / var_289_64

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_63 + var_289_64 and arg_286_1.time_ < var_289_63 + var_289_64 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play324131071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 324131071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play324131072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1170ui_story"].transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.var_.moveOldPos1170ui_story = var_295_0.localPosition

				local var_295_2 = GameObjectTools.GetOrAddComponent(var_295_0.gameObject, typeof(DynamicBoneHelper))

				if var_295_2 then
					var_295_2:EnableDynamicBone(false)
				end
			end

			local var_295_3 = 0.001

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_3 then
				local var_295_4 = (arg_292_1.time_ - var_295_1) / var_295_3
				local var_295_5 = Vector3.New(0, 100, 0)

				var_295_0.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1170ui_story, var_295_5, var_295_4)

				local var_295_6 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_6.x, var_295_6.y, var_295_6.z)

				local var_295_7 = var_295_0.localEulerAngles

				var_295_7.z = 0
				var_295_7.x = 0
				var_295_0.localEulerAngles = var_295_7
			end

			if arg_292_1.time_ >= var_295_1 + var_295_3 and arg_292_1.time_ < var_295_1 + var_295_3 + arg_295_0 then
				var_295_0.localPosition = Vector3.New(0, 100, 0)

				local var_295_8 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_8.x, var_295_8.y, var_295_8.z)

				local var_295_9 = var_295_0.localEulerAngles

				var_295_9.z = 0
				var_295_9.x = 0
				var_295_0.localEulerAngles = var_295_9

				local var_295_10 = GameObjectTools.GetOrAddComponent(var_295_0.gameObject, typeof(DynamicBoneHelper))

				if var_295_10 then
					var_295_10:EnableDynamicBone(true)
				end
			end

			local var_295_11 = "1056ui_story"

			if arg_292_1.actors_[var_295_11] == nil then
				local var_295_12 = Asset.Load("Char/" .. "1056ui_story")

				if not isNil(var_295_12) then
					local var_295_13 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_292_1.stage_.transform)

					var_295_13.name = var_295_11
					var_295_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_292_1.actors_[var_295_11] = var_295_13

					local var_295_14 = var_295_13:GetComponentInChildren(typeof(CharacterEffect))

					var_295_14.enabled = true

					local var_295_15 = GameObjectTools.GetOrAddComponent(var_295_13, typeof(DynamicBoneHelper))

					if var_295_15 then
						var_295_15:EnableDynamicBone(false)
					end

					arg_292_1:ShowWeapon(var_295_14.transform, false)

					arg_292_1.var_[var_295_11 .. "Animator"] = var_295_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_292_1.var_[var_295_11 .. "Animator"].applyRootMotion = true
					arg_292_1.var_[var_295_11 .. "LipSync"] = var_295_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_295_16 = arg_292_1.actors_["1056ui_story"]
			local var_295_17 = 0

			if var_295_17 < arg_292_1.time_ and arg_292_1.time_ <= var_295_17 + arg_295_0 and not isNil(var_295_16) and arg_292_1.var_.characterEffect1056ui_story == nil then
				arg_292_1.var_.characterEffect1056ui_story = var_295_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_18 = 0.200000002980232

			if var_295_17 <= arg_292_1.time_ and arg_292_1.time_ < var_295_17 + var_295_18 and not isNil(var_295_16) then
				local var_295_19 = (arg_292_1.time_ - var_295_17) / var_295_18

				if arg_292_1.var_.characterEffect1056ui_story and not isNil(var_295_16) then
					local var_295_20 = Mathf.Lerp(0, 0.5, var_295_19)

					arg_292_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1056ui_story.fillRatio = var_295_20
				end
			end

			if arg_292_1.time_ >= var_295_17 + var_295_18 and arg_292_1.time_ < var_295_17 + var_295_18 + arg_295_0 and not isNil(var_295_16) and arg_292_1.var_.characterEffect1056ui_story then
				local var_295_21 = 0.5

				arg_292_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1056ui_story.fillRatio = var_295_21
			end

			local var_295_22 = arg_292_1.actors_["1170ui_story"]
			local var_295_23 = 0

			if var_295_23 < arg_292_1.time_ and arg_292_1.time_ <= var_295_23 + arg_295_0 and not isNil(var_295_22) and arg_292_1.var_.characterEffect1170ui_story == nil then
				arg_292_1.var_.characterEffect1170ui_story = var_295_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_24 = 0.200000002980232

			if var_295_23 <= arg_292_1.time_ and arg_292_1.time_ < var_295_23 + var_295_24 and not isNil(var_295_22) then
				local var_295_25 = (arg_292_1.time_ - var_295_23) / var_295_24

				if arg_292_1.var_.characterEffect1170ui_story and not isNil(var_295_22) then
					arg_292_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= var_295_23 + var_295_24 and arg_292_1.time_ < var_295_23 + var_295_24 + arg_295_0 and not isNil(var_295_22) and arg_292_1.var_.characterEffect1170ui_story then
				arg_292_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_295_26 = 0
			local var_295_27 = 1.2

			if var_295_26 < arg_292_1.time_ and arg_292_1.time_ <= var_295_26 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_28 = arg_292_1:GetWordFromCfg(324131071)
				local var_295_29 = arg_292_1:FormatText(var_295_28.content)

				arg_292_1.text_.text = var_295_29

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_30 = 48
				local var_295_31 = utf8.len(var_295_29)
				local var_295_32 = var_295_30 <= 0 and var_295_27 or var_295_27 * (var_295_31 / var_295_30)

				if var_295_32 > 0 and var_295_27 < var_295_32 then
					arg_292_1.talkMaxDuration = var_295_32

					if var_295_32 + var_295_26 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_32 + var_295_26
					end
				end

				arg_292_1.text_.text = var_295_29
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_33 = math.max(var_295_27, arg_292_1.talkMaxDuration)

			if var_295_26 <= arg_292_1.time_ and arg_292_1.time_ < var_295_26 + var_295_33 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_26) / var_295_33

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_26 + var_295_33 and arg_292_1.time_ < var_295_26 + var_295_33 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play324131072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 324131072
		arg_296_1.duration_ = 6.3

		local var_296_0 = {
			zh = 4.733,
			ja = 6.3
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play324131073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1053ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos1053ui_story = var_299_0.localPosition

				local var_299_2 = GameObjectTools.GetOrAddComponent(var_299_0.gameObject, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(false)
				end
			end

			local var_299_3 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_3 then
				local var_299_4 = (arg_296_1.time_ - var_299_1) / var_299_3
				local var_299_5 = Vector3.New(0, -1.08, -6)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1053ui_story, var_299_5, var_299_4)

				local var_299_6 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_6.x, var_299_6.y, var_299_6.z)

				local var_299_7 = var_299_0.localEulerAngles

				var_299_7.z = 0
				var_299_7.x = 0
				var_299_0.localEulerAngles = var_299_7
			end

			if arg_296_1.time_ >= var_299_1 + var_299_3 and arg_296_1.time_ < var_299_1 + var_299_3 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_299_8 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_8.x, var_299_8.y, var_299_8.z)

				local var_299_9 = var_299_0.localEulerAngles

				var_299_9.z = 0
				var_299_9.x = 0
				var_299_0.localEulerAngles = var_299_9

				local var_299_10 = GameObjectTools.GetOrAddComponent(var_299_0.gameObject, typeof(DynamicBoneHelper))

				if var_299_10 then
					var_299_10:EnableDynamicBone(true)
				end
			end

			local var_299_11 = arg_296_1.actors_["1053ui_story"]
			local var_299_12 = 0

			if var_299_12 < arg_296_1.time_ and arg_296_1.time_ <= var_299_12 + arg_299_0 and not isNil(var_299_11) and arg_296_1.var_.characterEffect1053ui_story == nil then
				arg_296_1.var_.characterEffect1053ui_story = var_299_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_13 = 0.200000002980232

			if var_299_12 <= arg_296_1.time_ and arg_296_1.time_ < var_299_12 + var_299_13 and not isNil(var_299_11) then
				local var_299_14 = (arg_296_1.time_ - var_299_12) / var_299_13

				if arg_296_1.var_.characterEffect1053ui_story and not isNil(var_299_11) then
					arg_296_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_12 + var_299_13 and arg_296_1.time_ < var_299_12 + var_299_13 + arg_299_0 and not isNil(var_299_11) and arg_296_1.var_.characterEffect1053ui_story then
				arg_296_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_299_15 = 0

			if var_299_15 < arg_296_1.time_ and arg_296_1.time_ <= var_299_15 + arg_299_0 then
				arg_296_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_2")
			end

			local var_299_16 = 0

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				arg_296_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_299_17 = 0
			local var_299_18 = 0.525

			if var_299_17 < arg_296_1.time_ and arg_296_1.time_ <= var_299_17 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_19 = arg_296_1:FormatText(StoryNameCfg[472].name)

				arg_296_1.leftNameTxt_.text = var_299_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_20 = arg_296_1:GetWordFromCfg(324131072)
				local var_299_21 = arg_296_1:FormatText(var_299_20.content)

				arg_296_1.text_.text = var_299_21

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_22 = 21
				local var_299_23 = utf8.len(var_299_21)
				local var_299_24 = var_299_22 <= 0 and var_299_18 or var_299_18 * (var_299_23 / var_299_22)

				if var_299_24 > 0 and var_299_18 < var_299_24 then
					arg_296_1.talkMaxDuration = var_299_24

					if var_299_24 + var_299_17 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_24 + var_299_17
					end
				end

				arg_296_1.text_.text = var_299_21
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131072", "story_v_out_324131.awb") ~= 0 then
					local var_299_25 = manager.audio:GetVoiceLength("story_v_out_324131", "324131072", "story_v_out_324131.awb") / 1000

					if var_299_25 + var_299_17 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_25 + var_299_17
					end

					if var_299_20.prefab_name ~= "" and arg_296_1.actors_[var_299_20.prefab_name] ~= nil then
						local var_299_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_20.prefab_name].transform, "story_v_out_324131", "324131072", "story_v_out_324131.awb")

						arg_296_1:RecordAudio("324131072", var_299_26)
						arg_296_1:RecordAudio("324131072", var_299_26)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_324131", "324131072", "story_v_out_324131.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_324131", "324131072", "story_v_out_324131.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_27 = math.max(var_299_18, arg_296_1.talkMaxDuration)

			if var_299_17 <= arg_296_1.time_ and arg_296_1.time_ < var_299_17 + var_299_27 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_17) / var_299_27

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_17 + var_299_27 and arg_296_1.time_ < var_299_17 + var_299_27 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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

		arg_296_1:InitPlayNodeList()
	end,
	Play324131073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 324131073
		arg_300_1.duration_ = 6.87

		local var_300_0 = {
			zh = 3.4,
			ja = 6.866
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
				arg_300_0:Play324131074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.4

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_2 = arg_300_1:FormatText(StoryNameCfg[472].name)

				arg_300_1.leftNameTxt_.text = var_303_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_3 = arg_300_1:GetWordFromCfg(324131073)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 16
				local var_303_6 = utf8.len(var_303_4)
				local var_303_7 = var_303_5 <= 0 and var_303_1 or var_303_1 * (var_303_6 / var_303_5)

				if var_303_7 > 0 and var_303_1 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131073", "story_v_out_324131.awb") ~= 0 then
					local var_303_8 = manager.audio:GetVoiceLength("story_v_out_324131", "324131073", "story_v_out_324131.awb") / 1000

					if var_303_8 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_0
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_324131", "324131073", "story_v_out_324131.awb")

						arg_300_1:RecordAudio("324131073", var_303_9)
						arg_300_1:RecordAudio("324131073", var_303_9)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_324131", "324131073", "story_v_out_324131.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_324131", "324131073", "story_v_out_324131.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_10 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_10 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_10

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_10 and arg_300_1.time_ < var_303_0 + var_303_10 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play324131074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 324131074
		arg_304_1.duration_ = 2.3

		local var_304_0 = {
			zh = 2.3,
			ja = 2.233
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play324131075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1170ui_story"].transform
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.var_.moveOldPos1170ui_story = var_307_0.localPosition

				local var_307_2 = GameObjectTools.GetOrAddComponent(var_307_0.gameObject, typeof(DynamicBoneHelper))

				if var_307_2 then
					var_307_2:EnableDynamicBone(false)
				end
			end

			local var_307_3 = 0.001

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_3 then
				local var_307_4 = (arg_304_1.time_ - var_307_1) / var_307_3
				local var_307_5 = Vector3.New(0.74, -0.95, -6.08)

				var_307_0.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1170ui_story, var_307_5, var_307_4)

				local var_307_6 = manager.ui.mainCamera.transform.position - var_307_0.position

				var_307_0.forward = Vector3.New(var_307_6.x, var_307_6.y, var_307_6.z)

				local var_307_7 = var_307_0.localEulerAngles

				var_307_7.z = 0
				var_307_7.x = 0
				var_307_0.localEulerAngles = var_307_7
			end

			if arg_304_1.time_ >= var_307_1 + var_307_3 and arg_304_1.time_ < var_307_1 + var_307_3 + arg_307_0 then
				var_307_0.localPosition = Vector3.New(0.74, -0.95, -6.08)

				local var_307_8 = manager.ui.mainCamera.transform.position - var_307_0.position

				var_307_0.forward = Vector3.New(var_307_8.x, var_307_8.y, var_307_8.z)

				local var_307_9 = var_307_0.localEulerAngles

				var_307_9.z = 0
				var_307_9.x = 0
				var_307_0.localEulerAngles = var_307_9

				local var_307_10 = GameObjectTools.GetOrAddComponent(var_307_0.gameObject, typeof(DynamicBoneHelper))

				if var_307_10 then
					var_307_10:EnableDynamicBone(true)
				end
			end

			local var_307_11 = arg_304_1.actors_["1053ui_story"].transform
			local var_307_12 = 0

			if var_307_12 < arg_304_1.time_ and arg_304_1.time_ <= var_307_12 + arg_307_0 then
				arg_304_1.var_.moveOldPos1053ui_story = var_307_11.localPosition

				local var_307_13 = GameObjectTools.GetOrAddComponent(var_307_11.gameObject, typeof(DynamicBoneHelper))

				if var_307_13 then
					var_307_13:EnableDynamicBone(false)
				end
			end

			local var_307_14 = 0.001

			if var_307_12 <= arg_304_1.time_ and arg_304_1.time_ < var_307_12 + var_307_14 then
				local var_307_15 = (arg_304_1.time_ - var_307_12) / var_307_14
				local var_307_16 = Vector3.New(-0.7, -1.08, -6)

				var_307_11.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1053ui_story, var_307_16, var_307_15)

				local var_307_17 = manager.ui.mainCamera.transform.position - var_307_11.position

				var_307_11.forward = Vector3.New(var_307_17.x, var_307_17.y, var_307_17.z)

				local var_307_18 = var_307_11.localEulerAngles

				var_307_18.z = 0
				var_307_18.x = 0
				var_307_11.localEulerAngles = var_307_18
			end

			if arg_304_1.time_ >= var_307_12 + var_307_14 and arg_304_1.time_ < var_307_12 + var_307_14 + arg_307_0 then
				var_307_11.localPosition = Vector3.New(-0.7, -1.08, -6)

				local var_307_19 = manager.ui.mainCamera.transform.position - var_307_11.position

				var_307_11.forward = Vector3.New(var_307_19.x, var_307_19.y, var_307_19.z)

				local var_307_20 = var_307_11.localEulerAngles

				var_307_20.z = 0
				var_307_20.x = 0
				var_307_11.localEulerAngles = var_307_20

				local var_307_21 = GameObjectTools.GetOrAddComponent(var_307_11.gameObject, typeof(DynamicBoneHelper))

				if var_307_21 then
					var_307_21:EnableDynamicBone(true)
				end
			end

			local var_307_22 = arg_304_1.actors_["1056ui_story"]
			local var_307_23 = 0

			if var_307_23 < arg_304_1.time_ and arg_304_1.time_ <= var_307_23 + arg_307_0 and not isNil(var_307_22) and arg_304_1.var_.characterEffect1056ui_story == nil then
				arg_304_1.var_.characterEffect1056ui_story = var_307_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_24 = 0.200000002980232

			if var_307_23 <= arg_304_1.time_ and arg_304_1.time_ < var_307_23 + var_307_24 and not isNil(var_307_22) then
				local var_307_25 = (arg_304_1.time_ - var_307_23) / var_307_24

				if arg_304_1.var_.characterEffect1056ui_story and not isNil(var_307_22) then
					arg_304_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= var_307_23 + var_307_24 and arg_304_1.time_ < var_307_23 + var_307_24 + arg_307_0 and not isNil(var_307_22) and arg_304_1.var_.characterEffect1056ui_story then
				arg_304_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_307_26 = arg_304_1.actors_["1053ui_story"]
			local var_307_27 = 0

			if var_307_27 < arg_304_1.time_ and arg_304_1.time_ <= var_307_27 + arg_307_0 and not isNil(var_307_26) and arg_304_1.var_.characterEffect1053ui_story == nil then
				arg_304_1.var_.characterEffect1053ui_story = var_307_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_28 = 0.200000002980232

			if var_307_27 <= arg_304_1.time_ and arg_304_1.time_ < var_307_27 + var_307_28 and not isNil(var_307_26) then
				local var_307_29 = (arg_304_1.time_ - var_307_27) / var_307_28

				if arg_304_1.var_.characterEffect1053ui_story and not isNil(var_307_26) then
					local var_307_30 = Mathf.Lerp(0, 0.5, var_307_29)

					arg_304_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1053ui_story.fillRatio = var_307_30
				end
			end

			if arg_304_1.time_ >= var_307_27 + var_307_28 and arg_304_1.time_ < var_307_27 + var_307_28 + arg_307_0 and not isNil(var_307_26) and arg_304_1.var_.characterEffect1053ui_story then
				local var_307_31 = 0.5

				arg_304_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1053ui_story.fillRatio = var_307_31
			end

			local var_307_32 = 0

			if var_307_32 < arg_304_1.time_ and arg_304_1.time_ <= var_307_32 + arg_307_0 then
				arg_304_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action437")
			end

			local var_307_33 = 0
			local var_307_34 = 0.1

			if var_307_33 < arg_304_1.time_ and arg_304_1.time_ <= var_307_33 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_35 = arg_304_1:FormatText(StoryNameCfg[318].name)

				arg_304_1.leftNameTxt_.text = var_307_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_36 = arg_304_1:GetWordFromCfg(324131074)
				local var_307_37 = arg_304_1:FormatText(var_307_36.content)

				arg_304_1.text_.text = var_307_37

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_38 = 4
				local var_307_39 = utf8.len(var_307_37)
				local var_307_40 = var_307_38 <= 0 and var_307_34 or var_307_34 * (var_307_39 / var_307_38)

				if var_307_40 > 0 and var_307_34 < var_307_40 then
					arg_304_1.talkMaxDuration = var_307_40

					if var_307_40 + var_307_33 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_40 + var_307_33
					end
				end

				arg_304_1.text_.text = var_307_37
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131074", "story_v_out_324131.awb") ~= 0 then
					local var_307_41 = manager.audio:GetVoiceLength("story_v_out_324131", "324131074", "story_v_out_324131.awb") / 1000

					if var_307_41 + var_307_33 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_41 + var_307_33
					end

					if var_307_36.prefab_name ~= "" and arg_304_1.actors_[var_307_36.prefab_name] ~= nil then
						local var_307_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_36.prefab_name].transform, "story_v_out_324131", "324131074", "story_v_out_324131.awb")

						arg_304_1:RecordAudio("324131074", var_307_42)
						arg_304_1:RecordAudio("324131074", var_307_42)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_324131", "324131074", "story_v_out_324131.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_324131", "324131074", "story_v_out_324131.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_43 = math.max(var_307_34, arg_304_1.talkMaxDuration)

			if var_307_33 <= arg_304_1.time_ and arg_304_1.time_ < var_307_33 + var_307_43 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_33) / var_307_43

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_33 + var_307_43 and arg_304_1.time_ < var_307_33 + var_307_43 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
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

		arg_304_1:InitPlayNodeList()
	end,
	Play324131075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 324131075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play324131076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1170ui_story"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1170ui_story == nil then
				arg_308_1.var_.characterEffect1170ui_story = var_311_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.characterEffect1170ui_story and not isNil(var_311_0) then
					local var_311_4 = Mathf.Lerp(0, 0.5, var_311_3)

					arg_308_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1170ui_story.fillRatio = var_311_4
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect1170ui_story then
				local var_311_5 = 0.5

				arg_308_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1170ui_story.fillRatio = var_311_5
			end

			local var_311_6 = 0
			local var_311_7 = 0.7

			if var_311_6 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_8 = arg_308_1:GetWordFromCfg(324131075)
				local var_311_9 = arg_308_1:FormatText(var_311_8.content)

				arg_308_1.text_.text = var_311_9

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_10 = 28
				local var_311_11 = utf8.len(var_311_9)
				local var_311_12 = var_311_10 <= 0 and var_311_7 or var_311_7 * (var_311_11 / var_311_10)

				if var_311_12 > 0 and var_311_7 < var_311_12 then
					arg_308_1.talkMaxDuration = var_311_12

					if var_311_12 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_12 + var_311_6
					end
				end

				arg_308_1.text_.text = var_311_9
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_13 = math.max(var_311_7, arg_308_1.talkMaxDuration)

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_13 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_6) / var_311_13

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_6 + var_311_13 and arg_308_1.time_ < var_311_6 + var_311_13 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play324131076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 324131076
		arg_312_1.duration_ = 3.5

		local var_312_0 = {
			zh = 2.766,
			ja = 3.5
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play324131077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1053ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos1053ui_story = var_315_0.localPosition

				local var_315_2 = GameObjectTools.GetOrAddComponent(var_315_0.gameObject, typeof(DynamicBoneHelper))

				if var_315_2 then
					var_315_2:EnableDynamicBone(false)
				end
			end

			local var_315_3 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_3 then
				local var_315_4 = (arg_312_1.time_ - var_315_1) / var_315_3
				local var_315_5 = Vector3.New(-0.7, -1.08, -6)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1053ui_story, var_315_5, var_315_4)

				local var_315_6 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_6.x, var_315_6.y, var_315_6.z)

				local var_315_7 = var_315_0.localEulerAngles

				var_315_7.z = 0
				var_315_7.x = 0
				var_315_0.localEulerAngles = var_315_7
			end

			if arg_312_1.time_ >= var_315_1 + var_315_3 and arg_312_1.time_ < var_315_1 + var_315_3 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(-0.7, -1.08, -6)

				local var_315_8 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_8.x, var_315_8.y, var_315_8.z)

				local var_315_9 = var_315_0.localEulerAngles

				var_315_9.z = 0
				var_315_9.x = 0
				var_315_0.localEulerAngles = var_315_9

				local var_315_10 = GameObjectTools.GetOrAddComponent(var_315_0.gameObject, typeof(DynamicBoneHelper))

				if var_315_10 then
					var_315_10:EnableDynamicBone(true)
				end
			end

			local var_315_11 = arg_312_1.actors_["1053ui_story"]
			local var_315_12 = 0

			if var_315_12 < arg_312_1.time_ and arg_312_1.time_ <= var_315_12 + arg_315_0 and not isNil(var_315_11) and arg_312_1.var_.characterEffect1053ui_story == nil then
				arg_312_1.var_.characterEffect1053ui_story = var_315_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_13 = 0.200000002980232

			if var_315_12 <= arg_312_1.time_ and arg_312_1.time_ < var_315_12 + var_315_13 and not isNil(var_315_11) then
				local var_315_14 = (arg_312_1.time_ - var_315_12) / var_315_13

				if arg_312_1.var_.characterEffect1053ui_story and not isNil(var_315_11) then
					arg_312_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_12 + var_315_13 and arg_312_1.time_ < var_315_12 + var_315_13 + arg_315_0 and not isNil(var_315_11) and arg_312_1.var_.characterEffect1053ui_story then
				arg_312_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_315_15 = 0
			local var_315_16 = 0.2

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_17 = arg_312_1:FormatText(StoryNameCfg[472].name)

				arg_312_1.leftNameTxt_.text = var_315_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_18 = arg_312_1:GetWordFromCfg(324131076)
				local var_315_19 = arg_312_1:FormatText(var_315_18.content)

				arg_312_1.text_.text = var_315_19

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_20 = 8
				local var_315_21 = utf8.len(var_315_19)
				local var_315_22 = var_315_20 <= 0 and var_315_16 or var_315_16 * (var_315_21 / var_315_20)

				if var_315_22 > 0 and var_315_16 < var_315_22 then
					arg_312_1.talkMaxDuration = var_315_22

					if var_315_22 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_22 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_19
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131076", "story_v_out_324131.awb") ~= 0 then
					local var_315_23 = manager.audio:GetVoiceLength("story_v_out_324131", "324131076", "story_v_out_324131.awb") / 1000

					if var_315_23 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_23 + var_315_15
					end

					if var_315_18.prefab_name ~= "" and arg_312_1.actors_[var_315_18.prefab_name] ~= nil then
						local var_315_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_18.prefab_name].transform, "story_v_out_324131", "324131076", "story_v_out_324131.awb")

						arg_312_1:RecordAudio("324131076", var_315_24)
						arg_312_1:RecordAudio("324131076", var_315_24)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_324131", "324131076", "story_v_out_324131.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_324131", "324131076", "story_v_out_324131.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_25 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 <= arg_312_1.time_ and arg_312_1.time_ < var_315_15 + var_315_25 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_15) / var_315_25

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_15 + var_315_25 and arg_312_1.time_ < var_315_15 + var_315_25 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
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

		arg_312_1:InitPlayNodeList()
	end,
	Play324131077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 324131077
		arg_316_1.duration_ = 5.53

		local var_316_0 = {
			zh = 3.4,
			ja = 5.533
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
			arg_316_1.auto_ = false
		end

		function arg_316_1.playNext_(arg_318_0)
			arg_316_1.onStoryFinished_()
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["1170ui_story"].transform
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.var_.moveOldPos1170ui_story = var_319_0.localPosition

				local var_319_2 = GameObjectTools.GetOrAddComponent(var_319_0.gameObject, typeof(DynamicBoneHelper))

				if var_319_2 then
					var_319_2:EnableDynamicBone(false)
				end
			end

			local var_319_3 = 0.001

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_3 then
				local var_319_4 = (arg_316_1.time_ - var_319_1) / var_319_3
				local var_319_5 = Vector3.New(0.74, -0.95, -6.08)

				var_319_0.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1170ui_story, var_319_5, var_319_4)

				local var_319_6 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_6.x, var_319_6.y, var_319_6.z)

				local var_319_7 = var_319_0.localEulerAngles

				var_319_7.z = 0
				var_319_7.x = 0
				var_319_0.localEulerAngles = var_319_7
			end

			if arg_316_1.time_ >= var_319_1 + var_319_3 and arg_316_1.time_ < var_319_1 + var_319_3 + arg_319_0 then
				var_319_0.localPosition = Vector3.New(0.74, -0.95, -6.08)

				local var_319_8 = manager.ui.mainCamera.transform.position - var_319_0.position

				var_319_0.forward = Vector3.New(var_319_8.x, var_319_8.y, var_319_8.z)

				local var_319_9 = var_319_0.localEulerAngles

				var_319_9.z = 0
				var_319_9.x = 0
				var_319_0.localEulerAngles = var_319_9

				local var_319_10 = GameObjectTools.GetOrAddComponent(var_319_0.gameObject, typeof(DynamicBoneHelper))

				if var_319_10 then
					var_319_10:EnableDynamicBone(true)
				end
			end

			local var_319_11 = arg_316_1.actors_["1170ui_story"]
			local var_319_12 = 0

			if var_319_12 < arg_316_1.time_ and arg_316_1.time_ <= var_319_12 + arg_319_0 and not isNil(var_319_11) and arg_316_1.var_.characterEffect1170ui_story == nil then
				arg_316_1.var_.characterEffect1170ui_story = var_319_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_13 = 0.200000002980232

			if var_319_12 <= arg_316_1.time_ and arg_316_1.time_ < var_319_12 + var_319_13 and not isNil(var_319_11) then
				local var_319_14 = (arg_316_1.time_ - var_319_12) / var_319_13

				if arg_316_1.var_.characterEffect1170ui_story and not isNil(var_319_11) then
					arg_316_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_12 + var_319_13 and arg_316_1.time_ < var_319_12 + var_319_13 + arg_319_0 and not isNil(var_319_11) and arg_316_1.var_.characterEffect1170ui_story then
				arg_316_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_319_15 = arg_316_1.actors_["1053ui_story"]
			local var_319_16 = 0

			if var_319_16 < arg_316_1.time_ and arg_316_1.time_ <= var_319_16 + arg_319_0 and not isNil(var_319_15) and arg_316_1.var_.characterEffect1053ui_story == nil then
				arg_316_1.var_.characterEffect1053ui_story = var_319_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_17 = 0.200000002980232

			if var_319_16 <= arg_316_1.time_ and arg_316_1.time_ < var_319_16 + var_319_17 and not isNil(var_319_15) then
				local var_319_18 = (arg_316_1.time_ - var_319_16) / var_319_17

				if arg_316_1.var_.characterEffect1053ui_story and not isNil(var_319_15) then
					local var_319_19 = Mathf.Lerp(0, 0.5, var_319_18)

					arg_316_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1053ui_story.fillRatio = var_319_19
				end
			end

			if arg_316_1.time_ >= var_319_16 + var_319_17 and arg_316_1.time_ < var_319_16 + var_319_17 + arg_319_0 and not isNil(var_319_15) and arg_316_1.var_.characterEffect1053ui_story then
				local var_319_20 = 0.5

				arg_316_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1053ui_story.fillRatio = var_319_20
			end

			local var_319_21 = 0

			if var_319_21 < arg_316_1.time_ and arg_316_1.time_ <= var_319_21 + arg_319_0 then
				arg_316_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_2")
			end

			local var_319_22 = 0
			local var_319_23 = 0.425

			if var_319_22 < arg_316_1.time_ and arg_316_1.time_ <= var_319_22 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_24 = arg_316_1:FormatText(StoryNameCfg[318].name)

				arg_316_1.leftNameTxt_.text = var_319_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_25 = arg_316_1:GetWordFromCfg(324131077)
				local var_319_26 = arg_316_1:FormatText(var_319_25.content)

				arg_316_1.text_.text = var_319_26

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_27 = 17
				local var_319_28 = utf8.len(var_319_26)
				local var_319_29 = var_319_27 <= 0 and var_319_23 or var_319_23 * (var_319_28 / var_319_27)

				if var_319_29 > 0 and var_319_23 < var_319_29 then
					arg_316_1.talkMaxDuration = var_319_29

					if var_319_29 + var_319_22 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_29 + var_319_22
					end
				end

				arg_316_1.text_.text = var_319_26
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324131", "324131077", "story_v_out_324131.awb") ~= 0 then
					local var_319_30 = manager.audio:GetVoiceLength("story_v_out_324131", "324131077", "story_v_out_324131.awb") / 1000

					if var_319_30 + var_319_22 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_30 + var_319_22
					end

					if var_319_25.prefab_name ~= "" and arg_316_1.actors_[var_319_25.prefab_name] ~= nil then
						local var_319_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_25.prefab_name].transform, "story_v_out_324131", "324131077", "story_v_out_324131.awb")

						arg_316_1:RecordAudio("324131077", var_319_31)
						arg_316_1:RecordAudio("324131077", var_319_31)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_324131", "324131077", "story_v_out_324131.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_324131", "324131077", "story_v_out_324131.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_32 = math.max(var_319_23, arg_316_1.talkMaxDuration)

			if var_319_22 <= arg_316_1.time_ and arg_316_1.time_ < var_319_22 + var_319_32 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_22) / var_319_32

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_22 + var_319_32 and arg_316_1.time_ < var_319_22 + var_319_32 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2003",
		"TextureConfig/Background/J22f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_324131.awb"
	}
}
