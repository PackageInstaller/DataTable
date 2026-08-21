return {
	Play324531001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324531001
		arg_1_1.duration_ = 5.5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324531002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J27g"

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
				local var_4_5 = arg_1_1.bgs_.J27g

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
					if iter_4_0 ~= "J27g" then
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

			local var_4_24 = "10170ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10170ui_story"]
			local var_4_30 = 1.999999999999

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect10170ui_story == nil then
				arg_1_1.var_.characterEffect10170ui_story = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.2

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect10170ui_story and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect10170ui_story then
				arg_1_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_4_33 = 0.1
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "effect"

				arg_1_1:AudioAction(var_4_35, var_4_36, "se_story_150", "se_story_150_huatian", "")
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

				arg_1_1:AudioAction(var_4_43, var_4_44, "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian.awb")

				local var_4_45 = ""
				local var_4_46 = manager.audio:GetAudioName("bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian")

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

			local var_4_47 = 2
			local var_4_48 = 0.3

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

				local var_4_50 = arg_1_1:FormatText(StoryNameCfg[1450].name)

				arg_1_1.leftNameTxt_.text = var_4_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_51 = arg_1_1:GetWordFromCfg(324531001)
				local var_4_52 = arg_1_1:FormatText(var_4_51.content)

				arg_1_1.text_.text = var_4_52

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_53 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531001", "story_v_out_324531.awb") ~= 0 then
					local var_4_56 = manager.audio:GetVoiceLength("story_v_out_324531", "324531001", "story_v_out_324531.awb") / 1000

					if var_4_56 + var_4_47 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_47
					end

					if var_4_51.prefab_name ~= "" and arg_1_1.actors_[var_4_51.prefab_name] ~= nil then
						local var_4_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_51.prefab_name].transform, "story_v_out_324531", "324531001", "story_v_out_324531.awb")

						arg_1_1:RecordAudio("324531001", var_4_57)
						arg_1_1:RecordAudio("324531001", var_4_57)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324531", "324531001", "story_v_out_324531.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324531", "324531001", "story_v_out_324531.awb")
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
	Play324531002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324531002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324531003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10170ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect10170ui_story == nil then
				arg_8_1.var_.characterEffect10170ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.200000002980232

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect10170ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10170ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect10170ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10170ui_story.fillRatio = var_11_5
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

				local var_11_8 = arg_8_1:GetWordFromCfg(324531002)
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
	Play324531003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324531003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324531004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.675

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(324531003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 27
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_8 and arg_12_1.time_ < var_15_0 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324531004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324531004
		arg_16_1.duration_ = 3.27

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324531005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10170ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos10170ui_story = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, -1.03, -6.05)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10170ui_story, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_19_8 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_8.x, var_19_8.y, var_19_8.z)

				local var_19_9 = var_19_0.localEulerAngles

				var_19_9.z = 0
				var_19_9.x = 0
				var_19_0.localEulerAngles = var_19_9

				local var_19_10 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_10 then
					var_19_10:EnableDynamicBone(true)
				end
			end

			local var_19_11 = arg_16_1.actors_["10170ui_story"]
			local var_19_12 = 0

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect10170ui_story == nil then
				arg_16_1.var_.characterEffect10170ui_story = var_19_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_13 = 0.200000002980232

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_13 and not isNil(var_19_11) then
				local var_19_14 = (arg_16_1.time_ - var_19_12) / var_19_13

				if arg_16_1.var_.characterEffect10170ui_story and not isNil(var_19_11) then
					arg_16_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_12 + var_19_13 and arg_16_1.time_ < var_19_12 + var_19_13 + arg_19_0 and not isNil(var_19_11) and arg_16_1.var_.characterEffect10170ui_story then
				arg_16_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_19_17 = 0
			local var_19_18 = 0.375

			if var_19_17 < arg_16_1.time_ and arg_16_1.time_ <= var_19_17 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_19 = arg_16_1:FormatText(StoryNameCfg[1450].name)

				arg_16_1.leftNameTxt_.text = var_19_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_20 = arg_16_1:GetWordFromCfg(324531004)
				local var_19_21 = arg_16_1:FormatText(var_19_20.content)

				arg_16_1.text_.text = var_19_21

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_22 = 15
				local var_19_23 = utf8.len(var_19_21)
				local var_19_24 = var_19_22 <= 0 and var_19_18 or var_19_18 * (var_19_23 / var_19_22)

				if var_19_24 > 0 and var_19_18 < var_19_24 then
					arg_16_1.talkMaxDuration = var_19_24

					if var_19_24 + var_19_17 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_24 + var_19_17
					end
				end

				arg_16_1.text_.text = var_19_21
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531004", "story_v_out_324531.awb") ~= 0 then
					local var_19_25 = manager.audio:GetVoiceLength("story_v_out_324531", "324531004", "story_v_out_324531.awb") / 1000

					if var_19_25 + var_19_17 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_25 + var_19_17
					end

					if var_19_20.prefab_name ~= "" and arg_16_1.actors_[var_19_20.prefab_name] ~= nil then
						local var_19_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_20.prefab_name].transform, "story_v_out_324531", "324531004", "story_v_out_324531.awb")

						arg_16_1:RecordAudio("324531004", var_19_26)
						arg_16_1:RecordAudio("324531004", var_19_26)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324531", "324531004", "story_v_out_324531.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324531", "324531004", "story_v_out_324531.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_27 = math.max(var_19_18, arg_16_1.talkMaxDuration)

			if var_19_17 <= arg_16_1.time_ and arg_16_1.time_ < var_19_17 + var_19_27 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_17) / var_19_27

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_17 + var_19_27 and arg_16_1.time_ < var_19_17 + var_19_27 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play324531005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324531005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324531006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["10170ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10170ui_story == nil then
				arg_20_1.var_.characterEffect10170ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect10170ui_story and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10170ui_story.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect10170ui_story then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10170ui_story.fillRatio = var_23_5
			end

			local var_23_6 = 0
			local var_23_7 = 0.375

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_8 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_8

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

				local var_23_9 = arg_20_1:GetWordFromCfg(324531005)
				local var_23_10 = arg_20_1:FormatText(var_23_9.content)

				arg_20_1.text_.text = var_23_10

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 15
				local var_23_12 = utf8.len(var_23_10)
				local var_23_13 = var_23_11 <= 0 and var_23_7 or var_23_7 * (var_23_12 / var_23_11)

				if var_23_13 > 0 and var_23_7 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_10
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324531006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324531006
		arg_24_1.duration_ = 6.77

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324531007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10170ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10170ui_story == nil then
				arg_24_1.var_.characterEffect10170ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect10170ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10170ui_story then
				arg_24_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_27_4 = 0
			local var_27_5 = 0.6

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_6 = arg_24_1:FormatText(StoryNameCfg[1450].name)

				arg_24_1.leftNameTxt_.text = var_27_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_7 = arg_24_1:GetWordFromCfg(324531006)
				local var_27_8 = arg_24_1:FormatText(var_27_7.content)

				arg_24_1.text_.text = var_27_8

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 24
				local var_27_10 = utf8.len(var_27_8)
				local var_27_11 = var_27_9 <= 0 and var_27_5 or var_27_5 * (var_27_10 / var_27_9)

				if var_27_11 > 0 and var_27_5 < var_27_11 then
					arg_24_1.talkMaxDuration = var_27_11

					if var_27_11 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_8
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531006", "story_v_out_324531.awb") ~= 0 then
					local var_27_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531006", "story_v_out_324531.awb") / 1000

					if var_27_12 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_4
					end

					if var_27_7.prefab_name ~= "" and arg_24_1.actors_[var_27_7.prefab_name] ~= nil then
						local var_27_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_7.prefab_name].transform, "story_v_out_324531", "324531006", "story_v_out_324531.awb")

						arg_24_1:RecordAudio("324531006", var_27_13)
						arg_24_1:RecordAudio("324531006", var_27_13)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324531", "324531006", "story_v_out_324531.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324531", "324531006", "story_v_out_324531.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_14 and arg_24_1.time_ < var_27_4 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324531007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324531007
		arg_28_1.duration_ = 3.87

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324531008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action15_1")
			end

			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_31_2 = 0
			local var_31_3 = 0.4

			if var_31_2 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_4 = arg_28_1:FormatText(StoryNameCfg[1450].name)

				arg_28_1.leftNameTxt_.text = var_31_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_5 = arg_28_1:GetWordFromCfg(324531007)
				local var_31_6 = arg_28_1:FormatText(var_31_5.content)

				arg_28_1.text_.text = var_31_6

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 16
				local var_31_8 = utf8.len(var_31_6)
				local var_31_9 = var_31_7 <= 0 and var_31_3 or var_31_3 * (var_31_8 / var_31_7)

				if var_31_9 > 0 and var_31_3 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_6
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531007", "story_v_out_324531.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_324531", "324531007", "story_v_out_324531.awb") / 1000

					if var_31_10 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_2
					end

					if var_31_5.prefab_name ~= "" and arg_28_1.actors_[var_31_5.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_5.prefab_name].transform, "story_v_out_324531", "324531007", "story_v_out_324531.awb")

						arg_28_1:RecordAudio("324531007", var_31_11)
						arg_28_1:RecordAudio("324531007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324531", "324531007", "story_v_out_324531.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324531", "324531007", "story_v_out_324531.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_12 and arg_28_1.time_ < var_31_2 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324531008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324531008
		arg_32_1.duration_ = 6.5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324531009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "ST2007"

			if arg_32_1.bgs_[var_35_0] == nil then
				local var_35_1 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_35_0)
				var_35_1.name = var_35_0
				var_35_1.transform.parent = arg_32_1.stage_.transform
				var_35_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_[var_35_0] = var_35_1
			end

			local var_35_2 = 0.733333333333333

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				local var_35_3 = manager.ui.mainCamera.transform.localPosition
				local var_35_4 = Vector3.New(0, 0, 10) + Vector3.New(var_35_3.x, var_35_3.y, 0)
				local var_35_5 = arg_32_1.bgs_.ST2007

				var_35_5.transform.localPosition = var_35_4
				var_35_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_6 = var_35_5:GetComponent("SpriteRenderer")

				if var_35_6 and var_35_6.sprite then
					local var_35_7 = (var_35_5.transform.localPosition - var_35_3).z
					local var_35_8 = manager.ui.mainCameraCom_
					local var_35_9 = 2 * var_35_7 * Mathf.Tan(var_35_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_35_10 = var_35_9 * var_35_8.aspect
					local var_35_11 = var_35_6.sprite.bounds.size.x
					local var_35_12 = var_35_6.sprite.bounds.size.y
					local var_35_13 = var_35_10 / var_35_11
					local var_35_14 = var_35_9 / var_35_12
					local var_35_15 = var_35_14 < var_35_13 and var_35_13 or var_35_14

					var_35_5.transform.localScale = Vector3.New(var_35_15, var_35_15, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "ST2007" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_16 = 0.733333333333333

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			local var_35_17 = 0.3

			if arg_32_1.time_ >= var_35_16 + var_35_17 and arg_32_1.time_ < var_35_16 + var_35_17 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			local var_35_18 = arg_32_1.actors_["10170ui_story"].transform
			local var_35_19 = 0

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1.var_.moveOldPos10170ui_story = var_35_18.localPosition

				local var_35_20 = GameObjectTools.GetOrAddComponent(var_35_18.gameObject, typeof(DynamicBoneHelper))

				if var_35_20 then
					var_35_20:EnableDynamicBone(false)
				end
			end

			local var_35_21 = 0.001

			if var_35_19 <= arg_32_1.time_ and arg_32_1.time_ < var_35_19 + var_35_21 then
				local var_35_22 = (arg_32_1.time_ - var_35_19) / var_35_21
				local var_35_23 = Vector3.New(0, 100, 0)

				var_35_18.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10170ui_story, var_35_23, var_35_22)

				local var_35_24 = manager.ui.mainCamera.transform.position - var_35_18.position

				var_35_18.forward = Vector3.New(var_35_24.x, var_35_24.y, var_35_24.z)

				local var_35_25 = var_35_18.localEulerAngles

				var_35_25.z = 0
				var_35_25.x = 0
				var_35_18.localEulerAngles = var_35_25
			end

			if arg_32_1.time_ >= var_35_19 + var_35_21 and arg_32_1.time_ < var_35_19 + var_35_21 + arg_35_0 then
				var_35_18.localPosition = Vector3.New(0, 100, 0)

				local var_35_26 = manager.ui.mainCamera.transform.position - var_35_18.position

				var_35_18.forward = Vector3.New(var_35_26.x, var_35_26.y, var_35_26.z)

				local var_35_27 = var_35_18.localEulerAngles

				var_35_27.z = 0
				var_35_27.x = 0
				var_35_18.localEulerAngles = var_35_27

				local var_35_28 = GameObjectTools.GetOrAddComponent(var_35_18.gameObject, typeof(DynamicBoneHelper))

				if var_35_28 then
					var_35_28:EnableDynamicBone(true)
				end
			end

			local var_35_29 = arg_32_1.actors_["10170ui_story"]
			local var_35_30 = 0

			if var_35_30 < arg_32_1.time_ and arg_32_1.time_ <= var_35_30 + arg_35_0 and not isNil(var_35_29) and arg_32_1.var_.characterEffect10170ui_story == nil then
				arg_32_1.var_.characterEffect10170ui_story = var_35_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_31 = 0.200000002980232

			if var_35_30 <= arg_32_1.time_ and arg_32_1.time_ < var_35_30 + var_35_31 and not isNil(var_35_29) then
				local var_35_32 = (arg_32_1.time_ - var_35_30) / var_35_31

				if arg_32_1.var_.characterEffect10170ui_story and not isNil(var_35_29) then
					local var_35_33 = Mathf.Lerp(0, 0.5, var_35_32)

					arg_32_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_32_1.var_.characterEffect10170ui_story.fillRatio = var_35_33
				end
			end

			if arg_32_1.time_ >= var_35_30 + var_35_31 and arg_32_1.time_ < var_35_30 + var_35_31 + arg_35_0 and not isNil(var_35_29) and arg_32_1.var_.characterEffect10170ui_story then
				local var_35_34 = 0.5

				arg_32_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_32_1.var_.characterEffect10170ui_story.fillRatio = var_35_34
			end

			local var_35_35 = manager.ui.mainCamera.transform
			local var_35_36 = 0

			if var_35_36 < arg_32_1.time_ and arg_32_1.time_ <= var_35_36 + arg_35_0 then
				local var_35_37 = arg_32_1.var_.effecthoutuzhuanchang1
				local var_35_38
				local var_35_39 = var_35_35

				if not var_35_37 then
					var_35_37 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_35_39)
					var_35_37.name = "houtuzhuanchang1"
					arg_32_1.var_.effecthoutuzhuanchang1 = var_35_37
				else
					var_35_37.transform:SetParent(var_35_39)
				end

				var_35_37.transform.localPosition = Vector3.New(0, 0, 0)
				var_35_37.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_35_40 = 1.2
			local var_35_41 = 1

			if var_35_40 < arg_32_1.time_ and arg_32_1.time_ <= var_35_40 + arg_35_0 then
				local var_35_42 = "play"
				local var_35_43 = "effect"

				arg_32_1:AudioAction(var_35_42, var_35_43, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_35_44 = 0.1
			local var_35_45 = 1

			if var_35_44 < arg_32_1.time_ and arg_32_1.time_ <= var_35_44 + arg_35_0 then
				local var_35_46 = "stop"
				local var_35_47 = "effect"

				arg_32_1:AudioAction(var_35_46, var_35_47, "se_story_150", "se_story_150_huatian", "")
			end

			local var_35_48 = 0
			local var_35_49 = 1

			if var_35_48 < arg_32_1.time_ and arg_32_1.time_ <= var_35_48 + arg_35_0 then
				local var_35_50 = "play"
				local var_35_51 = "effect"

				arg_32_1:AudioAction(var_35_50, var_35_51, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_35_52 = 1
			local var_35_53 = 1

			if var_35_52 < arg_32_1.time_ and arg_32_1.time_ <= var_35_52 + arg_35_0 then
				local var_35_54 = "play"
				local var_35_55 = "music"

				arg_32_1:AudioAction(var_35_54, var_35_55, "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_35_56 = ""
				local var_35_57 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

				if var_35_57 ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_57 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_57

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_57
						arg_32_1.bgmTxt2_.text = var_35_57
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_58 = 1.5
			local var_35_59 = 1.35

			if var_35_58 < arg_32_1.time_ and arg_32_1.time_ <= var_35_58 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_60 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_60:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_32_1.dialogCg_.alpha = arg_37_0
				end))
				var_35_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_61 = arg_32_1:GetWordFromCfg(324531008)
				local var_35_62 = arg_32_1:FormatText(var_35_61.content)

				arg_32_1.text_.text = var_35_62

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_63 = 54
				local var_35_64 = utf8.len(var_35_62)
				local var_35_65 = var_35_63 <= 0 and var_35_59 or var_35_59 * (var_35_64 / var_35_63)

				if var_35_65 > 0 and var_35_59 < var_35_65 then
					arg_32_1.talkMaxDuration = var_35_65
					var_35_58 = var_35_58 + 0.3

					if var_35_65 + var_35_58 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_65 + var_35_58
					end
				end

				arg_32_1.text_.text = var_35_62
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_66 = var_35_58 + 0.3
			local var_35_67 = math.max(var_35_59, arg_32_1.talkMaxDuration)

			if var_35_66 <= arg_32_1.time_ and arg_32_1.time_ < var_35_66 + var_35_67 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_66) / var_35_67

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_66 + var_35_67 and arg_32_1.time_ < var_35_66 + var_35_67 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play324531009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 324531009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play324531010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 0.975

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_2 = arg_39_1:GetWordFromCfg(324531009)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 39
				local var_42_5 = utf8.len(var_42_3)
				local var_42_6 = var_42_4 <= 0 and var_42_1 or var_42_1 * (var_42_5 / var_42_4)

				if var_42_6 > 0 and var_42_1 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_7 and arg_39_1.time_ < var_42_0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play324531010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 324531010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play324531011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0
			local var_46_1 = 0.3

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_2 = arg_43_1:FormatText(StoryNameCfg[7].name)

				arg_43_1.leftNameTxt_.text = var_46_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(324531010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 12
				local var_46_6 = utf8.len(var_46_4)
				local var_46_7 = var_46_5 <= 0 and var_46_1 or var_46_1 * (var_46_6 / var_46_5)

				if var_46_7 > 0 and var_46_1 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_8 = math.max(var_46_1, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_8 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_0) / var_46_8

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_8 and arg_43_1.time_ < var_46_0 + var_46_8 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play324531011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 324531011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play324531012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 1.65

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

				local var_50_2 = arg_47_1:GetWordFromCfg(324531011)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 66
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
	Play324531012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 324531012
		arg_51_1.duration_ = 2

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play324531013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["10170ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos10170ui_story = var_54_0.localPosition

				local var_54_2 = GameObjectTools.GetOrAddComponent(var_54_0.gameObject, typeof(DynamicBoneHelper))

				if var_54_2 then
					var_54_2:EnableDynamicBone(false)
				end
			end

			local var_54_3 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_3 then
				local var_54_4 = (arg_51_1.time_ - var_54_1) / var_54_3
				local var_54_5 = Vector3.New(0, -1.03, -6.05)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10170ui_story, var_54_5, var_54_4)

				local var_54_6 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_6.x, var_54_6.y, var_54_6.z)

				local var_54_7 = var_54_0.localEulerAngles

				var_54_7.z = 0
				var_54_7.x = 0
				var_54_0.localEulerAngles = var_54_7
			end

			if arg_51_1.time_ >= var_54_1 + var_54_3 and arg_51_1.time_ < var_54_1 + var_54_3 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_54_8 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_8.x, var_54_8.y, var_54_8.z)

				local var_54_9 = var_54_0.localEulerAngles

				var_54_9.z = 0
				var_54_9.x = 0
				var_54_0.localEulerAngles = var_54_9

				local var_54_10 = GameObjectTools.GetOrAddComponent(var_54_0.gameObject, typeof(DynamicBoneHelper))

				if var_54_10 then
					var_54_10:EnableDynamicBone(true)
				end
			end

			local var_54_11 = arg_51_1.actors_["10170ui_story"]
			local var_54_12 = 0

			if var_54_12 < arg_51_1.time_ and arg_51_1.time_ <= var_54_12 + arg_54_0 and not isNil(var_54_11) and arg_51_1.var_.characterEffect10170ui_story == nil then
				arg_51_1.var_.characterEffect10170ui_story = var_54_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_13 = 0.200000002980232

			if var_54_12 <= arg_51_1.time_ and arg_51_1.time_ < var_54_12 + var_54_13 and not isNil(var_54_11) then
				local var_54_14 = (arg_51_1.time_ - var_54_12) / var_54_13

				if arg_51_1.var_.characterEffect10170ui_story and not isNil(var_54_11) then
					arg_51_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_12 + var_54_13 and arg_51_1.time_ < var_54_12 + var_54_13 + arg_54_0 and not isNil(var_54_11) and arg_51_1.var_.characterEffect10170ui_story then
				arg_51_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_54_15 = 0

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_54_16 = 0

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_54_17 = 0
			local var_54_18 = 0.15

			if var_54_17 < arg_51_1.time_ and arg_51_1.time_ <= var_54_17 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_19 = arg_51_1:FormatText(StoryNameCfg[1450].name)

				arg_51_1.leftNameTxt_.text = var_54_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_20 = arg_51_1:GetWordFromCfg(324531012)
				local var_54_21 = arg_51_1:FormatText(var_54_20.content)

				arg_51_1.text_.text = var_54_21

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_22 = 6
				local var_54_23 = utf8.len(var_54_21)
				local var_54_24 = var_54_22 <= 0 and var_54_18 or var_54_18 * (var_54_23 / var_54_22)

				if var_54_24 > 0 and var_54_18 < var_54_24 then
					arg_51_1.talkMaxDuration = var_54_24

					if var_54_24 + var_54_17 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_24 + var_54_17
					end
				end

				arg_51_1.text_.text = var_54_21
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531012", "story_v_out_324531.awb") ~= 0 then
					local var_54_25 = manager.audio:GetVoiceLength("story_v_out_324531", "324531012", "story_v_out_324531.awb") / 1000

					if var_54_25 + var_54_17 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_25 + var_54_17
					end

					if var_54_20.prefab_name ~= "" and arg_51_1.actors_[var_54_20.prefab_name] ~= nil then
						local var_54_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_20.prefab_name].transform, "story_v_out_324531", "324531012", "story_v_out_324531.awb")

						arg_51_1:RecordAudio("324531012", var_54_26)
						arg_51_1:RecordAudio("324531012", var_54_26)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_324531", "324531012", "story_v_out_324531.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_324531", "324531012", "story_v_out_324531.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_27 = math.max(var_54_18, arg_51_1.talkMaxDuration)

			if var_54_17 <= arg_51_1.time_ and arg_51_1.time_ < var_54_17 + var_54_27 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_17) / var_54_27

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_17 + var_54_27 and arg_51_1.time_ < var_54_17 + var_54_27 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play324531013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 324531013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play324531014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10170ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect10170ui_story == nil then
				arg_55_1.var_.characterEffect10170ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect10170ui_story and not isNil(var_58_0) then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10170ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect10170ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10170ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0
			local var_58_7 = 0.225

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

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_9 = arg_55_1:GetWordFromCfg(324531013)
				local var_58_10 = arg_55_1:FormatText(var_58_9.content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 9
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
	Play324531014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 324531014
		arg_59_1.duration_ = 1.23

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play324531015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["10170ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect10170ui_story == nil then
				arg_59_1.var_.characterEffect10170ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect10170ui_story and not isNil(var_62_0) then
					arg_59_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect10170ui_story then
				arg_59_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_62_4 = 0
			local var_62_5 = 0.125

			if var_62_4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_6 = arg_59_1:FormatText(StoryNameCfg[1450].name)

				arg_59_1.leftNameTxt_.text = var_62_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_7 = arg_59_1:GetWordFromCfg(324531014)
				local var_62_8 = arg_59_1:FormatText(var_62_7.content)

				arg_59_1.text_.text = var_62_8

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 5
				local var_62_10 = utf8.len(var_62_8)
				local var_62_11 = var_62_9 <= 0 and var_62_5 or var_62_5 * (var_62_10 / var_62_9)

				if var_62_11 > 0 and var_62_5 < var_62_11 then
					arg_59_1.talkMaxDuration = var_62_11

					if var_62_11 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_11 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_8
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531014", "story_v_out_324531.awb") ~= 0 then
					local var_62_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531014", "story_v_out_324531.awb") / 1000

					if var_62_12 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_4
					end

					if var_62_7.prefab_name ~= "" and arg_59_1.actors_[var_62_7.prefab_name] ~= nil then
						local var_62_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_7.prefab_name].transform, "story_v_out_324531", "324531014", "story_v_out_324531.awb")

						arg_59_1:RecordAudio("324531014", var_62_13)
						arg_59_1:RecordAudio("324531014", var_62_13)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_324531", "324531014", "story_v_out_324531.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_324531", "324531014", "story_v_out_324531.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_14 and arg_59_1.time_ < var_62_4 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play324531015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 324531015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play324531016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10170ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10170ui_story == nil then
				arg_63_1.var_.characterEffect10170ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect10170ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10170ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect10170ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10170ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.55

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[7].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_9 = arg_63_1:GetWordFromCfg(324531015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 22
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play324531016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 324531016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play324531017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 1.5

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(324531016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 60
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_8 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_8 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_8

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_8 and arg_67_1.time_ < var_70_0 + var_70_8 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play324531017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 324531017
		arg_71_1.duration_ = 2.5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play324531018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10170ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10170ui_story == nil then
				arg_71_1.var_.characterEffect10170ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect10170ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10170ui_story then
				arg_71_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_74_4 = 0

			if var_74_4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_1")
			end

			local var_74_5 = 0

			if var_74_5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_74_6 = 0
			local var_74_7 = 0.225

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_8 = arg_71_1:FormatText(StoryNameCfg[1450].name)

				arg_71_1.leftNameTxt_.text = var_74_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_9 = arg_71_1:GetWordFromCfg(324531017)
				local var_74_10 = arg_71_1:FormatText(var_74_9.content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 9
				local var_74_12 = utf8.len(var_74_10)
				local var_74_13 = var_74_11 <= 0 and var_74_7 or var_74_7 * (var_74_12 / var_74_11)

				if var_74_13 > 0 and var_74_7 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531017", "story_v_out_324531.awb") ~= 0 then
					local var_74_14 = manager.audio:GetVoiceLength("story_v_out_324531", "324531017", "story_v_out_324531.awb") / 1000

					if var_74_14 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_6
					end

					if var_74_9.prefab_name ~= "" and arg_71_1.actors_[var_74_9.prefab_name] ~= nil then
						local var_74_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_9.prefab_name].transform, "story_v_out_324531", "324531017", "story_v_out_324531.awb")

						arg_71_1:RecordAudio("324531017", var_74_15)
						arg_71_1:RecordAudio("324531017", var_74_15)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_324531", "324531017", "story_v_out_324531.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_324531", "324531017", "story_v_out_324531.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_16 and arg_71_1.time_ < var_74_6 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play324531018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 324531018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play324531019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10170ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect10170ui_story == nil then
				arg_75_1.var_.characterEffect10170ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect10170ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10170ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect10170ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10170ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 0.125

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_8 = arg_75_1:FormatText(StoryNameCfg[7].name)

				arg_75_1.leftNameTxt_.text = var_78_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_9 = arg_75_1:GetWordFromCfg(324531018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 5
				local var_78_12 = utf8.len(var_78_10)
				local var_78_13 = var_78_11 <= 0 and var_78_7 or var_78_7 * (var_78_12 / var_78_11)

				if var_78_13 > 0 and var_78_7 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_14 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_14

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_14 and arg_75_1.time_ < var_78_6 + var_78_14 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play324531019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 324531019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play324531020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10170ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos10170ui_story = var_82_0.localPosition

				local var_82_2 = GameObjectTools.GetOrAddComponent(var_82_0.gameObject, typeof(DynamicBoneHelper))

				if var_82_2 then
					var_82_2:EnableDynamicBone(false)
				end
			end

			local var_82_3 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_3 then
				local var_82_4 = (arg_79_1.time_ - var_82_1) / var_82_3
				local var_82_5 = Vector3.New(0, 100, 0)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10170ui_story, var_82_5, var_82_4)

				local var_82_6 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_6.x, var_82_6.y, var_82_6.z)

				local var_82_7 = var_82_0.localEulerAngles

				var_82_7.z = 0
				var_82_7.x = 0
				var_82_0.localEulerAngles = var_82_7
			end

			if arg_79_1.time_ >= var_82_1 + var_82_3 and arg_79_1.time_ < var_82_1 + var_82_3 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, 100, 0)

				local var_82_8 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_8.x, var_82_8.y, var_82_8.z)

				local var_82_9 = var_82_0.localEulerAngles

				var_82_9.z = 0
				var_82_9.x = 0
				var_82_0.localEulerAngles = var_82_9

				local var_82_10 = GameObjectTools.GetOrAddComponent(var_82_0.gameObject, typeof(DynamicBoneHelper))

				if var_82_10 then
					var_82_10:EnableDynamicBone(true)
				end
			end

			local var_82_11 = 0
			local var_82_12 = 1.4

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_13 = arg_79_1:GetWordFromCfg(324531019)
				local var_82_14 = arg_79_1:FormatText(var_82_13.content)

				arg_79_1.text_.text = var_82_14

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_15 = 56
				local var_82_16 = utf8.len(var_82_14)
				local var_82_17 = var_82_15 <= 0 and var_82_12 or var_82_12 * (var_82_16 / var_82_15)

				if var_82_17 > 0 and var_82_12 < var_82_17 then
					arg_79_1.talkMaxDuration = var_82_17

					if var_82_17 + var_82_11 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_17 + var_82_11
					end
				end

				arg_79_1.text_.text = var_82_14
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_18 = math.max(var_82_12, arg_79_1.talkMaxDuration)

			if var_82_11 <= arg_79_1.time_ and arg_79_1.time_ < var_82_11 + var_82_18 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_11) / var_82_18

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_11 + var_82_18 and arg_79_1.time_ < var_82_11 + var_82_18 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play324531020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 324531020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play324531021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.05

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[7].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(324531020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 2
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_8 and arg_83_1.time_ < var_86_0 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play324531021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 324531021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play324531022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.1
			local var_90_1 = 1

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				local var_90_2 = "play"
				local var_90_3 = "effect"

				arg_87_1:AudioAction(var_90_2, var_90_3, "se_story_1311", "se_story_1311_paper", "")
			end

			local var_90_4 = 0
			local var_90_5 = 1.7

			if var_90_4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(324531021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_8 = 68
				local var_90_9 = utf8.len(var_90_7)
				local var_90_10 = var_90_8 <= 0 and var_90_5 or var_90_5 * (var_90_9 / var_90_8)

				if var_90_10 > 0 and var_90_5 < var_90_10 then
					arg_87_1.talkMaxDuration = var_90_10

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_11 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_11 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_11

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_11 and arg_87_1.time_ < var_90_4 + var_90_11 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play324531022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 324531022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play324531023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.45

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(324531022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 18
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_8 and arg_91_1.time_ < var_94_0 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play324531023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 324531023
		arg_95_1.duration_ = 2

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play324531024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10170ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10170ui_story = var_98_0.localPosition

				local var_98_2 = GameObjectTools.GetOrAddComponent(var_98_0.gameObject, typeof(DynamicBoneHelper))

				if var_98_2 then
					var_98_2:EnableDynamicBone(false)
				end
			end

			local var_98_3 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_3 then
				local var_98_4 = (arg_95_1.time_ - var_98_1) / var_98_3
				local var_98_5 = Vector3.New(0, -1.03, -6.05)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10170ui_story, var_98_5, var_98_4)

				local var_98_6 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_6.x, var_98_6.y, var_98_6.z)

				local var_98_7 = var_98_0.localEulerAngles

				var_98_7.z = 0
				var_98_7.x = 0
				var_98_0.localEulerAngles = var_98_7
			end

			if arg_95_1.time_ >= var_98_1 + var_98_3 and arg_95_1.time_ < var_98_1 + var_98_3 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_98_8 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_8.x, var_98_8.y, var_98_8.z)

				local var_98_9 = var_98_0.localEulerAngles

				var_98_9.z = 0
				var_98_9.x = 0
				var_98_0.localEulerAngles = var_98_9

				local var_98_10 = GameObjectTools.GetOrAddComponent(var_98_0.gameObject, typeof(DynamicBoneHelper))

				if var_98_10 then
					var_98_10:EnableDynamicBone(true)
				end
			end

			local var_98_11 = arg_95_1.actors_["10170ui_story"]
			local var_98_12 = 0

			if var_98_12 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 and not isNil(var_98_11) and arg_95_1.var_.characterEffect10170ui_story == nil then
				arg_95_1.var_.characterEffect10170ui_story = var_98_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_13 = 0.200000002980232

			if var_98_12 <= arg_95_1.time_ and arg_95_1.time_ < var_98_12 + var_98_13 and not isNil(var_98_11) then
				local var_98_14 = (arg_95_1.time_ - var_98_12) / var_98_13

				if arg_95_1.var_.characterEffect10170ui_story and not isNil(var_98_11) then
					arg_95_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_12 + var_98_13 and arg_95_1.time_ < var_98_12 + var_98_13 + arg_98_0 and not isNil(var_98_11) and arg_95_1.var_.characterEffect10170ui_story then
				arg_95_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_98_15 = 0

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action2_2")
			end

			local var_98_16 = 0

			if var_98_16 < arg_95_1.time_ and arg_95_1.time_ <= var_98_16 + arg_98_0 then
				arg_95_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_98_17 = 0
			local var_98_18 = 0.125

			if var_98_17 < arg_95_1.time_ and arg_95_1.time_ <= var_98_17 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_19 = arg_95_1:FormatText(StoryNameCfg[1450].name)

				arg_95_1.leftNameTxt_.text = var_98_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_20 = arg_95_1:GetWordFromCfg(324531023)
				local var_98_21 = arg_95_1:FormatText(var_98_20.content)

				arg_95_1.text_.text = var_98_21

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_22 = 5
				local var_98_23 = utf8.len(var_98_21)
				local var_98_24 = var_98_22 <= 0 and var_98_18 or var_98_18 * (var_98_23 / var_98_22)

				if var_98_24 > 0 and var_98_18 < var_98_24 then
					arg_95_1.talkMaxDuration = var_98_24

					if var_98_24 + var_98_17 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_24 + var_98_17
					end
				end

				arg_95_1.text_.text = var_98_21
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531023", "story_v_out_324531.awb") ~= 0 then
					local var_98_25 = manager.audio:GetVoiceLength("story_v_out_324531", "324531023", "story_v_out_324531.awb") / 1000

					if var_98_25 + var_98_17 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_25 + var_98_17
					end

					if var_98_20.prefab_name ~= "" and arg_95_1.actors_[var_98_20.prefab_name] ~= nil then
						local var_98_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_20.prefab_name].transform, "story_v_out_324531", "324531023", "story_v_out_324531.awb")

						arg_95_1:RecordAudio("324531023", var_98_26)
						arg_95_1:RecordAudio("324531023", var_98_26)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_324531", "324531023", "story_v_out_324531.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_324531", "324531023", "story_v_out_324531.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_27 = math.max(var_98_18, arg_95_1.talkMaxDuration)

			if var_98_17 <= arg_95_1.time_ and arg_95_1.time_ < var_98_17 + var_98_27 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_17) / var_98_27

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_17 + var_98_27 and arg_95_1.time_ < var_98_17 + var_98_27 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play324531024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 324531024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play324531025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10170ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect10170ui_story == nil then
				arg_99_1.var_.characterEffect10170ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect10170ui_story and not isNil(var_102_0) then
					local var_102_4 = Mathf.Lerp(0, 0.5, var_102_3)

					arg_99_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10170ui_story.fillRatio = var_102_4
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect10170ui_story then
				local var_102_5 = 0.5

				arg_99_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10170ui_story.fillRatio = var_102_5
			end

			local var_102_6 = 0
			local var_102_7 = 0.15

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_8 = arg_99_1:FormatText(StoryNameCfg[7].name)

				arg_99_1.leftNameTxt_.text = var_102_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_9 = arg_99_1:GetWordFromCfg(324531024)
				local var_102_10 = arg_99_1:FormatText(var_102_9.content)

				arg_99_1.text_.text = var_102_10

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 6
				local var_102_12 = utf8.len(var_102_10)
				local var_102_13 = var_102_11 <= 0 and var_102_7 or var_102_7 * (var_102_12 / var_102_11)

				if var_102_13 > 0 and var_102_7 < var_102_13 then
					arg_99_1.talkMaxDuration = var_102_13

					if var_102_13 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_10
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_14 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_14 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_14

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_14 and arg_99_1.time_ < var_102_6 + var_102_14 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play324531025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 324531025
		arg_103_1.duration_ = 2

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play324531026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["10170ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10170ui_story == nil then
				arg_103_1.var_.characterEffect10170ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect10170ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect10170ui_story then
				arg_103_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_106_4 = 0

			if var_106_4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_106_5 = 0

			if var_106_5 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_106_6 = 0
			local var_106_7 = 0.125

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_8 = arg_103_1:FormatText(StoryNameCfg[1450].name)

				arg_103_1.leftNameTxt_.text = var_106_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_9 = arg_103_1:GetWordFromCfg(324531025)
				local var_106_10 = arg_103_1:FormatText(var_106_9.content)

				arg_103_1.text_.text = var_106_10

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_11 = 5
				local var_106_12 = utf8.len(var_106_10)
				local var_106_13 = var_106_11 <= 0 and var_106_7 or var_106_7 * (var_106_12 / var_106_11)

				if var_106_13 > 0 and var_106_7 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_10
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531025", "story_v_out_324531.awb") ~= 0 then
					local var_106_14 = manager.audio:GetVoiceLength("story_v_out_324531", "324531025", "story_v_out_324531.awb") / 1000

					if var_106_14 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_6
					end

					if var_106_9.prefab_name ~= "" and arg_103_1.actors_[var_106_9.prefab_name] ~= nil then
						local var_106_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_9.prefab_name].transform, "story_v_out_324531", "324531025", "story_v_out_324531.awb")

						arg_103_1:RecordAudio("324531025", var_106_15)
						arg_103_1:RecordAudio("324531025", var_106_15)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_324531", "324531025", "story_v_out_324531.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_324531", "324531025", "story_v_out_324531.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_16 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_16 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_16

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_16 and arg_103_1.time_ < var_106_6 + var_106_16 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play324531026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 324531026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play324531027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10170ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10170ui_story = var_110_0.localPosition

				local var_110_2 = GameObjectTools.GetOrAddComponent(var_110_0.gameObject, typeof(DynamicBoneHelper))

				if var_110_2 then
					var_110_2:EnableDynamicBone(false)
				end
			end

			local var_110_3 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_3 then
				local var_110_4 = (arg_107_1.time_ - var_110_1) / var_110_3
				local var_110_5 = Vector3.New(0, 100, 0)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10170ui_story, var_110_5, var_110_4)

				local var_110_6 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_6.x, var_110_6.y, var_110_6.z)

				local var_110_7 = var_110_0.localEulerAngles

				var_110_7.z = 0
				var_110_7.x = 0
				var_110_0.localEulerAngles = var_110_7
			end

			if arg_107_1.time_ >= var_110_1 + var_110_3 and arg_107_1.time_ < var_110_1 + var_110_3 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_110_11 = arg_107_1.actors_["10170ui_story"]
			local var_110_12 = 0

			if var_110_12 < arg_107_1.time_ and arg_107_1.time_ <= var_110_12 + arg_110_0 and not isNil(var_110_11) and arg_107_1.var_.characterEffect10170ui_story == nil then
				arg_107_1.var_.characterEffect10170ui_story = var_110_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_13 = 0.200000002980232

			if var_110_12 <= arg_107_1.time_ and arg_107_1.time_ < var_110_12 + var_110_13 and not isNil(var_110_11) then
				local var_110_14 = (arg_107_1.time_ - var_110_12) / var_110_13

				if arg_107_1.var_.characterEffect10170ui_story and not isNil(var_110_11) then
					local var_110_15 = Mathf.Lerp(0, 0.5, var_110_14)

					arg_107_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_107_1.var_.characterEffect10170ui_story.fillRatio = var_110_15
				end
			end

			if arg_107_1.time_ >= var_110_12 + var_110_13 and arg_107_1.time_ < var_110_12 + var_110_13 + arg_110_0 and not isNil(var_110_11) and arg_107_1.var_.characterEffect10170ui_story then
				local var_110_16 = 0.5

				arg_107_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_107_1.var_.characterEffect10170ui_story.fillRatio = var_110_16
			end

			local var_110_17 = 0.5
			local var_110_18 = 1

			if var_110_17 < arg_107_1.time_ and arg_107_1.time_ <= var_110_17 + arg_110_0 then
				local var_110_19 = "play"
				local var_110_20 = "effect"

				arg_107_1:AudioAction(var_110_19, var_110_20, "se_story_122_03", "se_story_122_03_page", "")
			end

			local var_110_21 = 0
			local var_110_22 = 0.85

			if var_110_21 < arg_107_1.time_ and arg_107_1.time_ <= var_110_21 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_23 = arg_107_1:GetWordFromCfg(324531026)
				local var_110_24 = arg_107_1:FormatText(var_110_23.content)

				arg_107_1.text_.text = var_110_24

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_25 = 34
				local var_110_26 = utf8.len(var_110_24)
				local var_110_27 = var_110_25 <= 0 and var_110_22 or var_110_22 * (var_110_26 / var_110_25)

				if var_110_27 > 0 and var_110_22 < var_110_27 then
					arg_107_1.talkMaxDuration = var_110_27

					if var_110_27 + var_110_21 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_27 + var_110_21
					end
				end

				arg_107_1.text_.text = var_110_24
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_28 = math.max(var_110_22, arg_107_1.talkMaxDuration)

			if var_110_21 <= arg_107_1.time_ and arg_107_1.time_ < var_110_21 + var_110_28 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_21) / var_110_28

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_21 + var_110_28 and arg_107_1.time_ < var_110_21 + var_110_28 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play324531027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 324531027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play324531028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.425

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_2 = arg_111_1:FormatText(StoryNameCfg[7].name)

				arg_111_1.leftNameTxt_.text = var_114_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(324531027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 17
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
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_8 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_8 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_8

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_8 and arg_111_1.time_ < var_114_0 + var_114_8 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play324531028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 324531028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play324531029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.45

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

				local var_118_2 = arg_115_1:GetWordFromCfg(324531028)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 18
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
	Play324531029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 324531029
		arg_119_1.duration_ = 7

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play324531030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "ST2008"

			if arg_119_1.bgs_[var_122_0] == nil then
				local var_122_1 = Object.Instantiate(arg_119_1.paintGo_)

				var_122_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_122_0)
				var_122_1.name = var_122_0
				var_122_1.transform.parent = arg_119_1.stage_.transform
				var_122_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.bgs_[var_122_0] = var_122_1
			end

			local var_122_2 = 1

			if var_122_2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				local var_122_3 = manager.ui.mainCamera.transform.localPosition
				local var_122_4 = Vector3.New(0, 0, 10) + Vector3.New(var_122_3.x, var_122_3.y, 0)
				local var_122_5 = arg_119_1.bgs_.ST2008

				var_122_5.transform.localPosition = var_122_4
				var_122_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_6 = var_122_5:GetComponent("SpriteRenderer")

				if var_122_6 and var_122_6.sprite then
					local var_122_7 = (var_122_5.transform.localPosition - var_122_3).z
					local var_122_8 = manager.ui.mainCameraCom_
					local var_122_9 = 2 * var_122_7 * Mathf.Tan(var_122_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_122_10 = var_122_9 * var_122_8.aspect
					local var_122_11 = var_122_6.sprite.bounds.size.x
					local var_122_12 = var_122_6.sprite.bounds.size.y
					local var_122_13 = var_122_10 / var_122_11
					local var_122_14 = var_122_9 / var_122_12
					local var_122_15 = var_122_14 < var_122_13 and var_122_13 or var_122_14

					var_122_5.transform.localScale = Vector3.New(var_122_15, var_122_15, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "ST2008" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_16 = 1

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			local var_122_17 = 0.3

			if arg_119_1.time_ >= var_122_16 + var_122_17 and arg_119_1.time_ < var_122_16 + var_122_17 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			local var_122_18 = manager.ui.mainCamera.transform
			local var_122_19 = 0

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 then
				local var_122_20 = arg_119_1.var_.effecthoutuzhuanchang1
				local var_122_21
				local var_122_22 = var_122_18

				if not var_122_20 then
					var_122_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_122_22)
					var_122_20.name = "houtuzhuanchang1"
					arg_119_1.var_.effecthoutuzhuanchang1 = var_122_20
				else
					var_122_20.transform:SetParent(var_122_22)
				end

				var_122_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_122_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_122_23 = 1.7777777777777777
				local var_122_24 = Screen.width / Screen.height
				local var_122_25 = var_122_24 / var_122_23
				local var_122_26 = Mathf.Max(var_122_23 / var_122_24, 1)

				var_122_20.transform.localScale = Vector3.New(var_122_20.transform.localScale.x * var_122_25, var_122_20.transform.localScale.y * var_122_26, var_122_20.transform.localScale.z)
			end

			local var_122_27 = manager.ui.mainCamera.transform
			local var_122_28 = 2.2

			if var_122_28 < arg_119_1.time_ and arg_119_1.time_ <= var_122_28 + arg_122_0 then
				local var_122_29 = arg_119_1.var_.effecthoutuzhuanchang1

				if var_122_29 then
					Object.Destroy(var_122_29)

					arg_119_1.var_.effecthoutuzhuanchang1 = nil
				end
			end

			local var_122_30 = 1.2
			local var_122_31 = 1

			if var_122_30 < arg_119_1.time_ and arg_119_1.time_ <= var_122_30 + arg_122_0 then
				local var_122_32 = "play"
				local var_122_33 = "effect"

				arg_119_1:AudioAction(var_122_32, var_122_33, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_122_34 = 0.1
			local var_122_35 = 1

			if var_122_34 < arg_119_1.time_ and arg_119_1.time_ <= var_122_34 + arg_122_0 then
				local var_122_36 = "stop"
				local var_122_37 = "effect"

				arg_119_1:AudioAction(var_122_36, var_122_37, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_122_38 = 0.0333333333333333

			if var_122_38 < arg_119_1.time_ and arg_119_1.time_ <= var_122_38 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			local var_122_39 = 1.96666666666667

			if arg_119_1.time_ >= var_122_38 + var_122_39 and arg_119_1.time_ < var_122_38 + var_122_39 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_40 = 2
			local var_122_41 = 0.175

			if var_122_40 < arg_119_1.time_ and arg_119_1.time_ <= var_122_40 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_42 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_42:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_43 = arg_119_1:FormatText(StoryNameCfg[7].name)

				arg_119_1.leftNameTxt_.text = var_122_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_44 = arg_119_1:GetWordFromCfg(324531029)
				local var_122_45 = arg_119_1:FormatText(var_122_44.content)

				arg_119_1.text_.text = var_122_45

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_46 = 7
				local var_122_47 = utf8.len(var_122_45)
				local var_122_48 = var_122_46 <= 0 and var_122_41 or var_122_41 * (var_122_47 / var_122_46)

				if var_122_48 > 0 and var_122_41 < var_122_48 then
					arg_119_1.talkMaxDuration = var_122_48
					var_122_40 = var_122_40 + 0.3

					if var_122_48 + var_122_40 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_48 + var_122_40
					end
				end

				arg_119_1.text_.text = var_122_45
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_49 = var_122_40 + 0.3
			local var_122_50 = math.max(var_122_41, arg_119_1.talkMaxDuration)

			if var_122_49 <= arg_119_1.time_ and arg_119_1.time_ < var_122_49 + var_122_50 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_49) / var_122_50

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_49 + var_122_50 and arg_119_1.time_ < var_122_49 + var_122_50 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play324531030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 324531030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play324531031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.85

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(324531030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 34
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play324531031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 324531031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play324531032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 1.375

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

				local var_132_2 = arg_129_1:GetWordFromCfg(324531031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 55
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
	Play324531032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 324531032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play324531033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.175

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[7].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(324531032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 7
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play324531033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 324531033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play324531034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.825

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(324531033)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 33
				local var_140_5 = utf8.len(var_140_3)
				local var_140_6 = var_140_4 <= 0 and var_140_1 or var_140_1 * (var_140_5 / var_140_4)

				if var_140_6 > 0 and var_140_1 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_7 and arg_137_1.time_ < var_140_0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play324531034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 324531034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play324531035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 1.625

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(324531034)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 65
				local var_144_5 = utf8.len(var_144_3)
				local var_144_6 = var_144_4 <= 0 and var_144_1 or var_144_1 * (var_144_5 / var_144_4)

				if var_144_6 > 0 and var_144_1 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_7 and arg_141_1.time_ < var_144_0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play324531035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 324531035
		arg_145_1.duration_ = 2

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play324531036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10170ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10170ui_story = var_148_0.localPosition

				local var_148_2 = GameObjectTools.GetOrAddComponent(var_148_0.gameObject, typeof(DynamicBoneHelper))

				if var_148_2 then
					var_148_2:EnableDynamicBone(false)
				end
			end

			local var_148_3 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_3 then
				local var_148_4 = (arg_145_1.time_ - var_148_1) / var_148_3
				local var_148_5 = Vector3.New(0, -1.03, -6.05)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10170ui_story, var_148_5, var_148_4)

				local var_148_6 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_6.x, var_148_6.y, var_148_6.z)

				local var_148_7 = var_148_0.localEulerAngles

				var_148_7.z = 0
				var_148_7.x = 0
				var_148_0.localEulerAngles = var_148_7
			end

			if arg_145_1.time_ >= var_148_1 + var_148_3 and arg_145_1.time_ < var_148_1 + var_148_3 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_148_8 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_8.x, var_148_8.y, var_148_8.z)

				local var_148_9 = var_148_0.localEulerAngles

				var_148_9.z = 0
				var_148_9.x = 0
				var_148_0.localEulerAngles = var_148_9

				local var_148_10 = GameObjectTools.GetOrAddComponent(var_148_0.gameObject, typeof(DynamicBoneHelper))

				if var_148_10 then
					var_148_10:EnableDynamicBone(true)
				end
			end

			local var_148_11 = arg_145_1.actors_["10170ui_story"]
			local var_148_12 = 0

			if var_148_12 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 and not isNil(var_148_11) and arg_145_1.var_.characterEffect10170ui_story == nil then
				arg_145_1.var_.characterEffect10170ui_story = var_148_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_13 = 0.200000002980232

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_13 and not isNil(var_148_11) then
				local var_148_14 = (arg_145_1.time_ - var_148_12) / var_148_13

				if arg_145_1.var_.characterEffect10170ui_story and not isNil(var_148_11) then
					arg_145_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_12 + var_148_13 and arg_145_1.time_ < var_148_12 + var_148_13 + arg_148_0 and not isNil(var_148_11) and arg_145_1.var_.characterEffect10170ui_story then
				arg_145_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_148_15 = 0

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action29_1")
			end

			local var_148_16 = 0

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 then
				arg_145_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_17 = 0
			local var_148_18 = 0.075

			if var_148_17 < arg_145_1.time_ and arg_145_1.time_ <= var_148_17 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_19 = arg_145_1:FormatText(StoryNameCfg[1450].name)

				arg_145_1.leftNameTxt_.text = var_148_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_20 = arg_145_1:GetWordFromCfg(324531035)
				local var_148_21 = arg_145_1:FormatText(var_148_20.content)

				arg_145_1.text_.text = var_148_21

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_22 = 3
				local var_148_23 = utf8.len(var_148_21)
				local var_148_24 = var_148_22 <= 0 and var_148_18 or var_148_18 * (var_148_23 / var_148_22)

				if var_148_24 > 0 and var_148_18 < var_148_24 then
					arg_145_1.talkMaxDuration = var_148_24

					if var_148_24 + var_148_17 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_24 + var_148_17
					end
				end

				arg_145_1.text_.text = var_148_21
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531035", "story_v_out_324531.awb") ~= 0 then
					local var_148_25 = manager.audio:GetVoiceLength("story_v_out_324531", "324531035", "story_v_out_324531.awb") / 1000

					if var_148_25 + var_148_17 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_25 + var_148_17
					end

					if var_148_20.prefab_name ~= "" and arg_145_1.actors_[var_148_20.prefab_name] ~= nil then
						local var_148_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_20.prefab_name].transform, "story_v_out_324531", "324531035", "story_v_out_324531.awb")

						arg_145_1:RecordAudio("324531035", var_148_26)
						arg_145_1:RecordAudio("324531035", var_148_26)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_324531", "324531035", "story_v_out_324531.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_324531", "324531035", "story_v_out_324531.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_27 = math.max(var_148_18, arg_145_1.talkMaxDuration)

			if var_148_17 <= arg_145_1.time_ and arg_145_1.time_ < var_148_17 + var_148_27 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_17) / var_148_27

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_17 + var_148_27 and arg_145_1.time_ < var_148_17 + var_148_27 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play324531036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 324531036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play324531037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10170ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10170ui_story == nil then
				arg_149_1.var_.characterEffect10170ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect10170ui_story and not isNil(var_152_0) then
					local var_152_4 = Mathf.Lerp(0, 0.5, var_152_3)

					arg_149_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10170ui_story.fillRatio = var_152_4
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10170ui_story then
				local var_152_5 = 0.5

				arg_149_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10170ui_story.fillRatio = var_152_5
			end

			local var_152_6 = 0
			local var_152_7 = 0.575

			if var_152_6 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_8 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_9 = arg_149_1:GetWordFromCfg(324531036)
				local var_152_10 = arg_149_1:FormatText(var_152_9.content)

				arg_149_1.text_.text = var_152_10

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 23
				local var_152_12 = utf8.len(var_152_10)
				local var_152_13 = var_152_11 <= 0 and var_152_7 or var_152_7 * (var_152_12 / var_152_11)

				if var_152_13 > 0 and var_152_7 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_10
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play324531037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 324531037
		arg_153_1.duration_ = 2

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play324531038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10170ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10170ui_story == nil then
				arg_153_1.var_.characterEffect10170ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect10170ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10170ui_story then
				arg_153_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_156_4 = 0

			if var_156_4 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action29_2")
			end

			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_156_6 = 0
			local var_156_7 = 0.175

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_8 = arg_153_1:FormatText(StoryNameCfg[1450].name)

				arg_153_1.leftNameTxt_.text = var_156_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_9 = arg_153_1:GetWordFromCfg(324531037)
				local var_156_10 = arg_153_1:FormatText(var_156_9.content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 7
				local var_156_12 = utf8.len(var_156_10)
				local var_156_13 = var_156_11 <= 0 and var_156_7 or var_156_7 * (var_156_12 / var_156_11)

				if var_156_13 > 0 and var_156_7 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531037", "story_v_out_324531.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_324531", "324531037", "story_v_out_324531.awb") / 1000

					if var_156_14 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_6
					end

					if var_156_9.prefab_name ~= "" and arg_153_1.actors_[var_156_9.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_9.prefab_name].transform, "story_v_out_324531", "324531037", "story_v_out_324531.awb")

						arg_153_1:RecordAudio("324531037", var_156_15)
						arg_153_1:RecordAudio("324531037", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_324531", "324531037", "story_v_out_324531.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_324531", "324531037", "story_v_out_324531.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_16 and arg_153_1.time_ < var_156_6 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play324531038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 324531038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play324531039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10170ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10170ui_story == nil then
				arg_157_1.var_.characterEffect10170ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect10170ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10170ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10170ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10170ui_story.fillRatio = var_160_5
			end

			local var_160_6 = 0
			local var_160_7 = 1.075

			if var_160_6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_8 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_9 = arg_157_1:GetWordFromCfg(324531038)
				local var_160_10 = arg_157_1:FormatText(var_160_9.content)

				arg_157_1.text_.text = var_160_10

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_11 = 43
				local var_160_12 = utf8.len(var_160_10)
				local var_160_13 = var_160_11 <= 0 and var_160_7 or var_160_7 * (var_160_12 / var_160_11)

				if var_160_13 > 0 and var_160_7 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_10
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_14 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_14 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_14

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_14 and arg_157_1.time_ < var_160_6 + var_160_14 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play324531039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 324531039
		arg_161_1.duration_ = 3.3

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play324531040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10170ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect10170ui_story == nil then
				arg_161_1.var_.characterEffect10170ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect10170ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect10170ui_story then
				arg_161_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_164_4 = 0

			if var_164_4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_164_6 = 0
			local var_164_7 = 0.375

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[1450].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_9 = arg_161_1:GetWordFromCfg(324531039)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 15
				local var_164_12 = utf8.len(var_164_10)
				local var_164_13 = var_164_11 <= 0 and var_164_7 or var_164_7 * (var_164_12 / var_164_11)

				if var_164_13 > 0 and var_164_7 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_10
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531039", "story_v_out_324531.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_324531", "324531039", "story_v_out_324531.awb") / 1000

					if var_164_14 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_6
					end

					if var_164_9.prefab_name ~= "" and arg_161_1.actors_[var_164_9.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_9.prefab_name].transform, "story_v_out_324531", "324531039", "story_v_out_324531.awb")

						arg_161_1:RecordAudio("324531039", var_164_15)
						arg_161_1:RecordAudio("324531039", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_324531", "324531039", "story_v_out_324531.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_324531", "324531039", "story_v_out_324531.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_16 and arg_161_1.time_ < var_164_6 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play324531040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 324531040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play324531041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10170ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10170ui_story == nil then
				arg_165_1.var_.characterEffect10170ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect10170ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10170ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect10170ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10170ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 0.375

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

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_9 = arg_165_1:GetWordFromCfg(324531040)
				local var_168_10 = arg_165_1:FormatText(var_168_9.content)

				arg_165_1.text_.text = var_168_10

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 15
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
	Play324531041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 324531041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play324531042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10170ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10170ui_story = var_172_0.localPosition

				local var_172_2 = GameObjectTools.GetOrAddComponent(var_172_0.gameObject, typeof(DynamicBoneHelper))

				if var_172_2 then
					var_172_2:EnableDynamicBone(false)
				end
			end

			local var_172_3 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_3 then
				local var_172_4 = (arg_169_1.time_ - var_172_1) / var_172_3
				local var_172_5 = Vector3.New(0, 100, 0)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10170ui_story, var_172_5, var_172_4)

				local var_172_6 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_6.x, var_172_6.y, var_172_6.z)

				local var_172_7 = var_172_0.localEulerAngles

				var_172_7.z = 0
				var_172_7.x = 0
				var_172_0.localEulerAngles = var_172_7
			end

			if arg_169_1.time_ >= var_172_1 + var_172_3 and arg_169_1.time_ < var_172_1 + var_172_3 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, 100, 0)

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

			local var_172_11 = 0.4
			local var_172_12 = 1

			if var_172_11 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				local var_172_13 = "play"
				local var_172_14 = "effect"

				arg_169_1:AudioAction(var_172_13, var_172_14, "se_story_145", "se_story_145_footstep02", "")
			end

			local var_172_15 = 0
			local var_172_16 = 1.35

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_17 = arg_169_1:GetWordFromCfg(324531041)
				local var_172_18 = arg_169_1:FormatText(var_172_17.content)

				arg_169_1.text_.text = var_172_18

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_19 = 54
				local var_172_20 = utf8.len(var_172_18)
				local var_172_21 = var_172_19 <= 0 and var_172_16 or var_172_16 * (var_172_20 / var_172_19)

				if var_172_21 > 0 and var_172_16 < var_172_21 then
					arg_169_1.talkMaxDuration = var_172_21

					if var_172_21 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_21 + var_172_15
					end
				end

				arg_169_1.text_.text = var_172_18
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_22 = math.max(var_172_16, arg_169_1.talkMaxDuration)

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_22 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_15) / var_172_22

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_15 + var_172_22 and arg_169_1.time_ < var_172_15 + var_172_22 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play324531042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 324531042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play324531043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.15

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[7].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:GetWordFromCfg(324531042)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 6
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play324531043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 324531043
		arg_177_1.duration_ = 1

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play324531044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10170ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10170ui_story == nil then
				arg_177_1.var_.characterEffect10170ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect10170ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect10170ui_story then
				arg_177_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_180_4 = 0
			local var_180_5 = 1

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				local var_180_6 = "play"
				local var_180_7 = "effect"

				arg_177_1:AudioAction(var_180_6, var_180_7, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_180_8 = 0
			local var_180_9 = 0.05

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_10 = arg_177_1:FormatText(StoryNameCfg[1450].name)

				arg_177_1.leftNameTxt_.text = var_180_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_11 = arg_177_1:GetWordFromCfg(324531043)
				local var_180_12 = arg_177_1:FormatText(var_180_11.content)

				arg_177_1.text_.text = var_180_12

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_13 = 2
				local var_180_14 = utf8.len(var_180_12)
				local var_180_15 = var_180_13 <= 0 and var_180_9 or var_180_9 * (var_180_14 / var_180_13)

				if var_180_15 > 0 and var_180_9 < var_180_15 then
					arg_177_1.talkMaxDuration = var_180_15

					if var_180_15 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_12
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531043", "story_v_out_324531.awb") ~= 0 then
					local var_180_16 = manager.audio:GetVoiceLength("story_v_out_324531", "324531043", "story_v_out_324531.awb") / 1000

					if var_180_16 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_16 + var_180_8
					end

					if var_180_11.prefab_name ~= "" and arg_177_1.actors_[var_180_11.prefab_name] ~= nil then
						local var_180_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_11.prefab_name].transform, "story_v_out_324531", "324531043", "story_v_out_324531.awb")

						arg_177_1:RecordAudio("324531043", var_180_17)
						arg_177_1:RecordAudio("324531043", var_180_17)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_324531", "324531043", "story_v_out_324531.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_324531", "324531043", "story_v_out_324531.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_18 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_18 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_18

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_18 and arg_177_1.time_ < var_180_8 + var_180_18 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play324531044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 324531044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play324531045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10170ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10170ui_story == nil then
				arg_181_1.var_.characterEffect10170ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect10170ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10170ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10170ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10170ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.95

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(324531044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 38
				local var_184_11 = utf8.len(var_184_9)
				local var_184_12 = var_184_10 <= 0 and var_184_7 or var_184_7 * (var_184_11 / var_184_10)

				if var_184_12 > 0 and var_184_7 < var_184_12 then
					arg_181_1.talkMaxDuration = var_184_12

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_13 and arg_181_1.time_ < var_184_6 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play324531045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 324531045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play324531046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.375

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(324531045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 15
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play324531046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 324531046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play324531047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.3
			local var_192_1 = 1

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				local var_192_2 = "play"
				local var_192_3 = "effect"

				arg_189_1:AudioAction(var_192_2, var_192_3, "se_story_140", "se_story_140_camera_ui01", "")
			end

			local var_192_4 = 0
			local var_192_5 = 0.575

			if var_192_4 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(324531046)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_8 = 23
				local var_192_9 = utf8.len(var_192_7)
				local var_192_10 = var_192_8 <= 0 and var_192_5 or var_192_5 * (var_192_9 / var_192_8)

				if var_192_10 > 0 and var_192_5 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_11 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_11 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_11

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_11 and arg_189_1.time_ < var_192_4 + var_192_11 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play324531047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 324531047
		arg_193_1.duration_ = 7.7

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play324531048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = manager.ui.mainCamera.transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				local var_196_2 = arg_193_1.var_.effect321313
				local var_196_3
				local var_196_4 = var_196_0

				if not var_196_2 then
					var_196_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_datablock_white"), var_196_4)
					var_196_2.name = "321313"
					arg_193_1.var_.effect321313 = var_196_2
				else
					var_196_2.transform:SetParent(var_196_4)
				end

				var_196_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_196_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_196_5 = 0

			if var_196_5 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.allBtn_.enabled = false
			end

			local var_196_6 = 3.23333333333333

			if arg_193_1.time_ >= var_196_5 + var_196_6 and arg_193_1.time_ < var_196_5 + var_196_6 + arg_196_0 then
				arg_193_1.allBtn_.enabled = true
			end

			local var_196_7 = 0.5
			local var_196_8 = 1

			if var_196_7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 then
				local var_196_9 = "play"
				local var_196_10 = "effect"

				arg_193_1:AudioAction(var_196_9, var_196_10, "se_story_1211", "se_story_1211_energy02", "")
			end

			local var_196_11 = "STwhite"

			if arg_193_1.bgs_[var_196_11] == nil then
				local var_196_12 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_196_11)
				var_196_12.name = var_196_11
				var_196_12.transform.parent = arg_193_1.stage_.transform
				var_196_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_[var_196_11] = var_196_12
			end

			local var_196_13 = 1.74186629382893

			if var_196_13 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				local var_196_14 = manager.ui.mainCamera.transform.localPosition
				local var_196_15 = Vector3.New(0, 0, 10) + Vector3.New(var_196_14.x, var_196_14.y, 0)
				local var_196_16 = arg_193_1.bgs_.STwhite

				var_196_16.transform.localPosition = var_196_15
				var_196_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_17 = var_196_16:GetComponent("SpriteRenderer")

				if var_196_17 and var_196_17.sprite then
					local var_196_18 = (var_196_16.transform.localPosition - var_196_14).z
					local var_196_19 = manager.ui.mainCameraCom_
					local var_196_20 = 2 * var_196_18 * Mathf.Tan(var_196_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_196_21 = var_196_20 * var_196_19.aspect
					local var_196_22 = var_196_17.sprite.bounds.size.x
					local var_196_23 = var_196_17.sprite.bounds.size.y
					local var_196_24 = var_196_21 / var_196_22
					local var_196_25 = var_196_20 / var_196_23
					local var_196_26 = var_196_25 < var_196_24 and var_196_24 or var_196_25

					var_196_16.transform.localScale = Vector3.New(var_196_26, var_196_26, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "STwhite" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_27 = 2.7
			local var_196_28 = 1.525

			if var_196_27 < arg_193_1.time_ and arg_193_1.time_ <= var_196_27 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_29 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_29:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_30 = arg_193_1:GetWordFromCfg(324531047)
				local var_196_31 = arg_193_1:FormatText(var_196_30.content)

				arg_193_1.text_.text = var_196_31

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_32 = 61
				local var_196_33 = utf8.len(var_196_31)
				local var_196_34 = var_196_32 <= 0 and var_196_28 or var_196_28 * (var_196_33 / var_196_32)

				if var_196_34 > 0 and var_196_28 < var_196_34 then
					arg_193_1.talkMaxDuration = var_196_34
					var_196_27 = var_196_27 + 0.3

					if var_196_34 + var_196_27 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_34 + var_196_27
					end
				end

				arg_193_1.text_.text = var_196_31
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_35 = var_196_27 + 0.3
			local var_196_36 = math.max(var_196_28, arg_193_1.talkMaxDuration)

			if var_196_35 <= arg_193_1.time_ and arg_193_1.time_ < var_196_35 + var_196_36 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_35) / var_196_36

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_35 + var_196_36 and arg_193_1.time_ < var_196_35 + var_196_36 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play324531048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 324531048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play324531049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 1.5

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_2 = arg_199_1:GetWordFromCfg(324531048)
				local var_202_3 = arg_199_1:FormatText(var_202_2.content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 60
				local var_202_5 = utf8.len(var_202_3)
				local var_202_6 = var_202_4 <= 0 and var_202_1 or var_202_1 * (var_202_5 / var_202_4)

				if var_202_6 > 0 and var_202_1 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_7 and arg_199_1.time_ < var_202_0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play324531049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 324531049
		arg_203_1.duration_ = 7.78

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play324531050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = "J25f"

			if arg_203_1.bgs_[var_206_0] == nil then
				local var_206_1 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_0)
				var_206_1.name = var_206_0
				var_206_1.transform.parent = arg_203_1.stage_.transform
				var_206_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_0] = var_206_1
			end

			local var_206_2 = 1.16666666666667

			if var_206_2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				local var_206_3 = manager.ui.mainCamera.transform.localPosition
				local var_206_4 = Vector3.New(0, 0, 10) + Vector3.New(var_206_3.x, var_206_3.y, 0)
				local var_206_5 = arg_203_1.bgs_.J25f

				var_206_5.transform.localPosition = var_206_4
				var_206_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_6 = var_206_5:GetComponent("SpriteRenderer")

				if var_206_6 and var_206_6.sprite then
					local var_206_7 = (var_206_5.transform.localPosition - var_206_3).z
					local var_206_8 = manager.ui.mainCameraCom_
					local var_206_9 = 2 * var_206_7 * Mathf.Tan(var_206_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_10 = var_206_9 * var_206_8.aspect
					local var_206_11 = var_206_6.sprite.bounds.size.x
					local var_206_12 = var_206_6.sprite.bounds.size.y
					local var_206_13 = var_206_10 / var_206_11
					local var_206_14 = var_206_9 / var_206_12
					local var_206_15 = var_206_14 < var_206_13 and var_206_13 or var_206_14

					var_206_5.transform.localScale = Vector3.New(var_206_15, var_206_15, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "J25f" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_16 = 1.16666666666667

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			local var_206_17 = 0.3

			if arg_203_1.time_ >= var_206_16 + var_206_17 and arg_203_1.time_ < var_206_16 + var_206_17 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_18 = 0

			if var_206_18 < arg_203_1.time_ and arg_203_1.time_ <= var_206_18 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_19 = 1.16666666666667

			if var_206_18 <= arg_203_1.time_ and arg_203_1.time_ < var_206_18 + var_206_19 then
				local var_206_20 = (arg_203_1.time_ - var_206_18) / var_206_19
				local var_206_21 = Color.New(0, 0, 0)

				var_206_21.a = Mathf.Lerp(0, 1, var_206_20)
				arg_203_1.mask_.color = var_206_21
			end

			if arg_203_1.time_ >= var_206_18 + var_206_19 and arg_203_1.time_ < var_206_18 + var_206_19 + arg_206_0 then
				local var_206_22 = Color.New(0, 0, 0)

				var_206_22.a = 1
				arg_203_1.mask_.color = var_206_22
			end

			local var_206_23 = 1.16666666666667

			if var_206_23 < arg_203_1.time_ and arg_203_1.time_ <= var_206_23 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_24 = 2

			if var_206_23 <= arg_203_1.time_ and arg_203_1.time_ < var_206_23 + var_206_24 then
				local var_206_25 = (arg_203_1.time_ - var_206_23) / var_206_24
				local var_206_26 = Color.New(0, 0, 0)

				var_206_26.a = Mathf.Lerp(1, 0, var_206_25)
				arg_203_1.mask_.color = var_206_26
			end

			if arg_203_1.time_ >= var_206_23 + var_206_24 and arg_203_1.time_ < var_206_23 + var_206_24 + arg_206_0 then
				local var_206_27 = Color.New(0, 0, 0)
				local var_206_28 = 0

				arg_203_1.mask_.enabled = false
				var_206_27.a = var_206_28
				arg_203_1.mask_.color = var_206_27
			end

			local var_206_29 = 1.2
			local var_206_30 = 1

			if var_206_29 < arg_203_1.time_ and arg_203_1.time_ <= var_206_29 + arg_206_0 then
				local var_206_31 = "play"
				local var_206_32 = "effect"

				arg_203_1:AudioAction(var_206_31, var_206_32, "se_story_143", "se_story_143_amb_dark", "")
			end

			local var_206_33 = 0.1
			local var_206_34 = 1

			if var_206_33 < arg_203_1.time_ and arg_203_1.time_ <= var_206_33 + arg_206_0 then
				local var_206_35 = "stop"
				local var_206_36 = "effect"

				arg_203_1:AudioAction(var_206_35, var_206_36, "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			local var_206_37 = 0
			local var_206_38 = 1

			if var_206_37 < arg_203_1.time_ and arg_203_1.time_ <= var_206_37 + arg_206_0 then
				local var_206_39 = "play"
				local var_206_40 = "music"

				arg_203_1:AudioAction(var_206_39, var_206_40, "bgm_activity_4_8_story_taixu", "bgm_activity_4_8_story_taixu", "bgm_activity_4_8_story_taixu.awb")

				local var_206_41 = ""
				local var_206_42 = manager.audio:GetAudioName("bgm_activity_4_8_story_taixu", "bgm_activity_4_8_story_taixu")

				if var_206_42 ~= "" then
					if arg_203_1.bgmTxt_.text ~= var_206_42 and arg_203_1.bgmTxt_.text ~= "" then
						if arg_203_1.bgmTxt2_.text ~= "" then
							arg_203_1.bgmTxt_.text = arg_203_1.bgmTxt2_.text
						end

						arg_203_1.bgmTxt2_.text = var_206_42

						arg_203_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_203_1.bgmTxt_.text = var_206_42
						arg_203_1.bgmTxt2_.text = var_206_42
					end

					if arg_203_1.bgmTimer then
						arg_203_1.bgmTimer:Stop()

						arg_203_1.bgmTimer = nil
					end

					if arg_203_1.settingData.show_music_name == 1 then
						arg_203_1.musicController:SetSelectedState("show")
						arg_203_1.musicAnimator_:Play("open", 0, 0)

						if arg_203_1.settingData.music_time ~= 0 then
							arg_203_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_203_1.settingData.music_time), function()
								if arg_203_1 == nil or isNil(arg_203_1.bgmTxt_) then
									return
								end

								arg_203_1.musicController:SetSelectedState("hide")
								arg_203_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_43 = 2.776894797571
			local var_206_44 = 0.125

			if var_206_43 < arg_203_1.time_ and arg_203_1.time_ <= var_206_43 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_45 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_45:setOnUpdate(LuaHelper.FloatAction(function(arg_208_0)
					arg_203_1.dialogCg_.alpha = arg_208_0
				end))
				var_206_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_46 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_47 = arg_203_1:GetWordFromCfg(324531049)
				local var_206_48 = arg_203_1:FormatText(var_206_47.content)

				arg_203_1.text_.text = var_206_48

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_49 = 5
				local var_206_50 = utf8.len(var_206_48)
				local var_206_51 = var_206_49 <= 0 and var_206_44 or var_206_44 * (var_206_50 / var_206_49)

				if var_206_51 > 0 and var_206_44 < var_206_51 then
					arg_203_1.talkMaxDuration = var_206_51
					var_206_43 = var_206_43 + 0.3

					if var_206_51 + var_206_43 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_51 + var_206_43
					end
				end

				arg_203_1.text_.text = var_206_48
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_52 = var_206_43 + 0.3
			local var_206_53 = math.max(var_206_44, arg_203_1.talkMaxDuration)

			if var_206_52 <= arg_203_1.time_ and arg_203_1.time_ < var_206_52 + var_206_53 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_52) / var_206_53

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_52 + var_206_53 and arg_203_1.time_ < var_206_52 + var_206_53 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play324531050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 324531050
		arg_210_1.duration_ = 1.17

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play324531051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10170ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos10170ui_story = var_213_0.localPosition

				local var_213_2 = GameObjectTools.GetOrAddComponent(var_213_0.gameObject, typeof(DynamicBoneHelper))

				if var_213_2 then
					var_213_2:EnableDynamicBone(false)
				end
			end

			local var_213_3 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_3 then
				local var_213_4 = (arg_210_1.time_ - var_213_1) / var_213_3
				local var_213_5 = Vector3.New(0, -1.03, -6.05)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10170ui_story, var_213_5, var_213_4)

				local var_213_6 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_6.x, var_213_6.y, var_213_6.z)

				local var_213_7 = var_213_0.localEulerAngles

				var_213_7.z = 0
				var_213_7.x = 0
				var_213_0.localEulerAngles = var_213_7
			end

			if arg_210_1.time_ >= var_213_1 + var_213_3 and arg_210_1.time_ < var_213_1 + var_213_3 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_213_8 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_8.x, var_213_8.y, var_213_8.z)

				local var_213_9 = var_213_0.localEulerAngles

				var_213_9.z = 0
				var_213_9.x = 0
				var_213_0.localEulerAngles = var_213_9

				local var_213_10 = GameObjectTools.GetOrAddComponent(var_213_0.gameObject, typeof(DynamicBoneHelper))

				if var_213_10 then
					var_213_10:EnableDynamicBone(true)
				end
			end

			local var_213_11 = arg_210_1.actors_["10170ui_story"]
			local var_213_12 = 0

			if var_213_12 < arg_210_1.time_ and arg_210_1.time_ <= var_213_12 + arg_213_0 and not isNil(var_213_11) and arg_210_1.var_.characterEffect10170ui_story == nil then
				arg_210_1.var_.characterEffect10170ui_story = var_213_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_13 = 0.200000002980232

			if var_213_12 <= arg_210_1.time_ and arg_210_1.time_ < var_213_12 + var_213_13 and not isNil(var_213_11) then
				local var_213_14 = (arg_210_1.time_ - var_213_12) / var_213_13

				if arg_210_1.var_.characterEffect10170ui_story and not isNil(var_213_11) then
					arg_210_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_12 + var_213_13 and arg_210_1.time_ < var_213_12 + var_213_13 + arg_213_0 and not isNil(var_213_11) and arg_210_1.var_.characterEffect10170ui_story then
				arg_210_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_213_15 = 0

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			local var_213_16 = 0

			if var_213_16 < arg_210_1.time_ and arg_210_1.time_ <= var_213_16 + arg_213_0 then
				arg_210_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_213_17 = 0
			local var_213_18 = 0.1

			if var_213_17 < arg_210_1.time_ and arg_210_1.time_ <= var_213_17 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_19 = arg_210_1:FormatText(StoryNameCfg[1450].name)

				arg_210_1.leftNameTxt_.text = var_213_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_20 = arg_210_1:GetWordFromCfg(324531050)
				local var_213_21 = arg_210_1:FormatText(var_213_20.content)

				arg_210_1.text_.text = var_213_21

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_22 = 4
				local var_213_23 = utf8.len(var_213_21)
				local var_213_24 = var_213_22 <= 0 and var_213_18 or var_213_18 * (var_213_23 / var_213_22)

				if var_213_24 > 0 and var_213_18 < var_213_24 then
					arg_210_1.talkMaxDuration = var_213_24

					if var_213_24 + var_213_17 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_24 + var_213_17
					end
				end

				arg_210_1.text_.text = var_213_21
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531050", "story_v_out_324531.awb") ~= 0 then
					local var_213_25 = manager.audio:GetVoiceLength("story_v_out_324531", "324531050", "story_v_out_324531.awb") / 1000

					if var_213_25 + var_213_17 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_25 + var_213_17
					end

					if var_213_20.prefab_name ~= "" and arg_210_1.actors_[var_213_20.prefab_name] ~= nil then
						local var_213_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_20.prefab_name].transform, "story_v_out_324531", "324531050", "story_v_out_324531.awb")

						arg_210_1:RecordAudio("324531050", var_213_26)
						arg_210_1:RecordAudio("324531050", var_213_26)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_324531", "324531050", "story_v_out_324531.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_324531", "324531050", "story_v_out_324531.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_27 = math.max(var_213_18, arg_210_1.talkMaxDuration)

			if var_213_17 <= arg_210_1.time_ and arg_210_1.time_ < var_213_17 + var_213_27 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_17) / var_213_27

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_17 + var_213_27 and arg_210_1.time_ < var_213_17 + var_213_27 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play324531051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 324531051
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play324531052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10170ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect10170ui_story == nil then
				arg_214_1.var_.characterEffect10170ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect10170ui_story and not isNil(var_217_0) then
					local var_217_4 = Mathf.Lerp(0, 0.5, var_217_3)

					arg_214_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_214_1.var_.characterEffect10170ui_story.fillRatio = var_217_4
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect10170ui_story then
				local var_217_5 = 0.5

				arg_214_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_214_1.var_.characterEffect10170ui_story.fillRatio = var_217_5
			end

			local var_217_6 = 0
			local var_217_7 = 0.625

			if var_217_6 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_8 = arg_214_1:FormatText(StoryNameCfg[7].name)

				arg_214_1.leftNameTxt_.text = var_217_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_9 = arg_214_1:GetWordFromCfg(324531051)
				local var_217_10 = arg_214_1:FormatText(var_217_9.content)

				arg_214_1.text_.text = var_217_10

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 25
				local var_217_12 = utf8.len(var_217_10)
				local var_217_13 = var_217_11 <= 0 and var_217_7 or var_217_7 * (var_217_12 / var_217_11)

				if var_217_13 > 0 and var_217_7 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_10
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_14 and arg_214_1.time_ < var_217_6 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play324531052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 324531052
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play324531053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.575

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[7].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_3 = arg_218_1:GetWordFromCfg(324531052)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 23
				local var_221_6 = utf8.len(var_221_4)
				local var_221_7 = var_221_5 <= 0 and var_221_1 or var_221_1 * (var_221_6 / var_221_5)

				if var_221_7 > 0 and var_221_1 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_8 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_8 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_8

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_8 and arg_218_1.time_ < var_221_0 + var_221_8 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play324531053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 324531053
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play324531054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10170ui_story"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos10170ui_story = var_225_0.localPosition

				local var_225_2 = GameObjectTools.GetOrAddComponent(var_225_0.gameObject, typeof(DynamicBoneHelper))

				if var_225_2 then
					var_225_2:EnableDynamicBone(false)
				end
			end

			local var_225_3 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_3 then
				local var_225_4 = (arg_222_1.time_ - var_225_1) / var_225_3
				local var_225_5 = Vector3.New(0, 100, 0)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10170ui_story, var_225_5, var_225_4)

				local var_225_6 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_6.x, var_225_6.y, var_225_6.z)

				local var_225_7 = var_225_0.localEulerAngles

				var_225_7.z = 0
				var_225_7.x = 0
				var_225_0.localEulerAngles = var_225_7
			end

			if arg_222_1.time_ >= var_225_1 + var_225_3 and arg_222_1.time_ < var_225_1 + var_225_3 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(0, 100, 0)

				local var_225_8 = manager.ui.mainCamera.transform.position - var_225_0.position

				var_225_0.forward = Vector3.New(var_225_8.x, var_225_8.y, var_225_8.z)

				local var_225_9 = var_225_0.localEulerAngles

				var_225_9.z = 0
				var_225_9.x = 0
				var_225_0.localEulerAngles = var_225_9

				local var_225_10 = GameObjectTools.GetOrAddComponent(var_225_0.gameObject, typeof(DynamicBoneHelper))

				if var_225_10 then
					var_225_10:EnableDynamicBone(true)
				end
			end

			local var_225_11 = 0
			local var_225_12 = 1.275

			if var_225_11 < arg_222_1.time_ and arg_222_1.time_ <= var_225_11 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_13 = arg_222_1:GetWordFromCfg(324531053)
				local var_225_14 = arg_222_1:FormatText(var_225_13.content)

				arg_222_1.text_.text = var_225_14

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_15 = 51
				local var_225_16 = utf8.len(var_225_14)
				local var_225_17 = var_225_15 <= 0 and var_225_12 or var_225_12 * (var_225_16 / var_225_15)

				if var_225_17 > 0 and var_225_12 < var_225_17 then
					arg_222_1.talkMaxDuration = var_225_17

					if var_225_17 + var_225_11 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_17 + var_225_11
					end
				end

				arg_222_1.text_.text = var_225_14
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_18 = math.max(var_225_12, arg_222_1.talkMaxDuration)

			if var_225_11 <= arg_222_1.time_ and arg_222_1.time_ < var_225_11 + var_225_18 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_11) / var_225_18

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_11 + var_225_18 and arg_222_1.time_ < var_225_11 + var_225_18 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play324531054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 324531054
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play324531055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.975

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_2 = arg_226_1:GetWordFromCfg(324531054)
				local var_229_3 = arg_226_1:FormatText(var_229_2.content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 39
				local var_229_5 = utf8.len(var_229_3)
				local var_229_6 = var_229_4 <= 0 and var_229_1 or var_229_1 * (var_229_5 / var_229_4)

				if var_229_6 > 0 and var_229_1 < var_229_6 then
					arg_226_1.talkMaxDuration = var_229_6

					if var_229_6 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_7 and arg_226_1.time_ < var_229_0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play324531055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 324531055
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play324531056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.2
			local var_233_1 = 1

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				local var_233_2 = "play"
				local var_233_3 = "effect"

				arg_230_1:AudioAction(var_233_2, var_233_3, "se_story_141", "se_story_141_energy", "")
			end

			local var_233_4 = 0
			local var_233_5 = 1.625

			if var_233_4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_6 = arg_230_1:GetWordFromCfg(324531055)
				local var_233_7 = arg_230_1:FormatText(var_233_6.content)

				arg_230_1.text_.text = var_233_7

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_8 = 65
				local var_233_9 = utf8.len(var_233_7)
				local var_233_10 = var_233_8 <= 0 and var_233_5 or var_233_5 * (var_233_9 / var_233_8)

				if var_233_10 > 0 and var_233_5 < var_233_10 then
					arg_230_1.talkMaxDuration = var_233_10

					if var_233_10 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_7
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_11 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_11 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_4) / var_233_11

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_4 + var_233_11 and arg_230_1.time_ < var_233_4 + var_233_11 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play324531056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 324531056
		arg_234_1.duration_ = 7.87

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play324531057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = "MS2406"

			if arg_234_1.bgs_[var_237_0] == nil then
				local var_237_1 = Object.Instantiate(arg_234_1.paintGo_)

				var_237_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_237_0)
				var_237_1.name = var_237_0
				var_237_1.transform.parent = arg_234_1.stage_.transform
				var_237_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.bgs_[var_237_0] = var_237_1
			end

			local var_237_2 = 1.2

			if var_237_2 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				local var_237_3 = manager.ui.mainCamera.transform.localPosition
				local var_237_4 = Vector3.New(0, 0, 10) + Vector3.New(var_237_3.x, var_237_3.y, 0)
				local var_237_5 = arg_234_1.bgs_.MS2406

				var_237_5.transform.localPosition = var_237_4
				var_237_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_6 = var_237_5:GetComponent("SpriteRenderer")

				if var_237_6 and var_237_6.sprite then
					local var_237_7 = (var_237_5.transform.localPosition - var_237_3).z
					local var_237_8 = manager.ui.mainCameraCom_
					local var_237_9 = 2 * var_237_7 * Mathf.Tan(var_237_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_237_10 = var_237_9 * var_237_8.aspect
					local var_237_11 = var_237_6.sprite.bounds.size.x
					local var_237_12 = var_237_6.sprite.bounds.size.y
					local var_237_13 = var_237_10 / var_237_11
					local var_237_14 = var_237_9 / var_237_12
					local var_237_15 = var_237_14 < var_237_13 and var_237_13 or var_237_14

					var_237_5.transform.localScale = Vector3.New(var_237_15, var_237_15, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "MS2406" then
						iter_237_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_237_16 = 1.23333333333333

			if var_237_16 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			local var_237_17 = 0.3

			if arg_234_1.time_ >= var_237_16 + var_237_17 and arg_234_1.time_ < var_237_16 + var_237_17 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			local var_237_18 = 0

			if var_237_18 < arg_234_1.time_ and arg_234_1.time_ <= var_237_18 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_19 = 1.23333333333333

			if var_237_18 <= arg_234_1.time_ and arg_234_1.time_ < var_237_18 + var_237_19 then
				local var_237_20 = (arg_234_1.time_ - var_237_18) / var_237_19
				local var_237_21 = Color.New(0, 0, 0)

				var_237_21.a = Mathf.Lerp(0, 1, var_237_20)
				arg_234_1.mask_.color = var_237_21
			end

			if arg_234_1.time_ >= var_237_18 + var_237_19 and arg_234_1.time_ < var_237_18 + var_237_19 + arg_237_0 then
				local var_237_22 = Color.New(0, 0, 0)

				var_237_22.a = 1
				arg_234_1.mask_.color = var_237_22
			end

			local var_237_23 = 1.23333333333333

			if var_237_23 < arg_234_1.time_ and arg_234_1.time_ <= var_237_23 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_24 = 2

			if var_237_23 <= arg_234_1.time_ and arg_234_1.time_ < var_237_23 + var_237_24 then
				local var_237_25 = (arg_234_1.time_ - var_237_23) / var_237_24
				local var_237_26 = Color.New(0, 0, 0)

				var_237_26.a = Mathf.Lerp(1, 0, var_237_25)
				arg_234_1.mask_.color = var_237_26
			end

			if arg_234_1.time_ >= var_237_23 + var_237_24 and arg_234_1.time_ < var_237_23 + var_237_24 + arg_237_0 then
				local var_237_27 = Color.New(0, 0, 0)
				local var_237_28 = 0

				arg_234_1.mask_.enabled = false
				var_237_27.a = var_237_28
				arg_234_1.mask_.color = var_237_27
			end

			local var_237_29 = arg_234_1.bgs_.MS2406.transform
			local var_237_30 = 1.2

			if var_237_30 < arg_234_1.time_ and arg_234_1.time_ <= var_237_30 + arg_237_0 then
				arg_234_1.var_.moveOldPosMS2406 = var_237_29.localPosition
			end

			local var_237_31 = 2.25

			if var_237_30 <= arg_234_1.time_ and arg_234_1.time_ < var_237_30 + var_237_31 then
				local var_237_32 = (arg_234_1.time_ - var_237_30) / var_237_31
				local var_237_33 = Vector3.New(0, 1, 9.5)

				var_237_29.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPosMS2406, var_237_33, var_237_32)
			end

			if arg_234_1.time_ >= var_237_30 + var_237_31 and arg_234_1.time_ < var_237_30 + var_237_31 + arg_237_0 then
				var_237_29.localPosition = Vector3.New(0, 1, 9.5)
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_34 = 2.86666666666667
			local var_237_35 = 1.6

			if var_237_34 < arg_234_1.time_ and arg_234_1.time_ <= var_237_34 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_36 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_36:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_234_1.dialogCg_.alpha = arg_238_0
				end))
				var_237_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_37 = arg_234_1:GetWordFromCfg(324531056)
				local var_237_38 = arg_234_1:FormatText(var_237_37.content)

				arg_234_1.text_.text = var_237_38

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_39 = 64
				local var_237_40 = utf8.len(var_237_38)
				local var_237_41 = var_237_39 <= 0 and var_237_35 or var_237_35 * (var_237_40 / var_237_39)

				if var_237_41 > 0 and var_237_35 < var_237_41 then
					arg_234_1.talkMaxDuration = var_237_41
					var_237_34 = var_237_34 + 0.3

					if var_237_41 + var_237_34 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_41 + var_237_34
					end
				end

				arg_234_1.text_.text = var_237_38
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_42 = var_237_34 + 0.3
			local var_237_43 = math.max(var_237_35, arg_234_1.talkMaxDuration)

			if var_237_42 <= arg_234_1.time_ and arg_234_1.time_ < var_237_42 + var_237_43 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_42) / var_237_43

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_42 + var_237_43 and arg_234_1.time_ < var_237_42 + var_237_43 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2406",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.25,
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 7),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play324531057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324531057
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play324531058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 1.125

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(324531057)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 45
				local var_243_5 = utf8.len(var_243_3)
				local var_243_6 = var_243_4 <= 0 and var_243_1 or var_243_1 * (var_243_5 / var_243_4)

				if var_243_6 > 0 and var_243_1 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_7 and arg_240_1.time_ < var_243_0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play324531058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324531058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324531059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0
			local var_247_1 = 0.85

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_2 = arg_244_1:GetWordFromCfg(324531058)
				local var_247_3 = arg_244_1:FormatText(var_247_2.content)

				arg_244_1.text_.text = var_247_3

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 34
				local var_247_5 = utf8.len(var_247_3)
				local var_247_6 = var_247_4 <= 0 and var_247_1 or var_247_1 * (var_247_5 / var_247_4)

				if var_247_6 > 0 and var_247_1 < var_247_6 then
					arg_244_1.talkMaxDuration = var_247_6

					if var_247_6 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_6 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_3
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_7 and arg_244_1.time_ < var_247_0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play324531059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324531059
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324531060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 1.6

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_2 = arg_248_1:GetWordFromCfg(324531059)
				local var_251_3 = arg_248_1:FormatText(var_251_2.content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 64
				local var_251_5 = utf8.len(var_251_3)
				local var_251_6 = var_251_4 <= 0 and var_251_1 or var_251_1 * (var_251_5 / var_251_4)

				if var_251_6 > 0 and var_251_1 < var_251_6 then
					arg_248_1.talkMaxDuration = var_251_6

					if var_251_6 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_6 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_7 and arg_248_1.time_ < var_251_0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play324531060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324531060
		arg_252_1.duration_ = 1.7

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324531061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10170ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10170ui_story == nil then
				arg_252_1.var_.characterEffect10170ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect10170ui_story and not isNil(var_255_0) then
					arg_252_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10170ui_story then
				arg_252_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_255_4 = 0
			local var_255_5 = 0.175

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_6 = arg_252_1:FormatText(StoryNameCfg[1450].name)

				arg_252_1.leftNameTxt_.text = var_255_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_7 = arg_252_1:GetWordFromCfg(324531060)
				local var_255_8 = arg_252_1:FormatText(var_255_7.content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_9 = 7
				local var_255_10 = utf8.len(var_255_8)
				local var_255_11 = var_255_9 <= 0 and var_255_5 or var_255_5 * (var_255_10 / var_255_9)

				if var_255_11 > 0 and var_255_5 < var_255_11 then
					arg_252_1.talkMaxDuration = var_255_11

					if var_255_11 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_4
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531060", "story_v_out_324531.awb") ~= 0 then
					local var_255_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531060", "story_v_out_324531.awb") / 1000

					if var_255_12 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_4
					end

					if var_255_7.prefab_name ~= "" and arg_252_1.actors_[var_255_7.prefab_name] ~= nil then
						local var_255_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_7.prefab_name].transform, "story_v_out_324531", "324531060", "story_v_out_324531.awb")

						arg_252_1:RecordAudio("324531060", var_255_13)
						arg_252_1:RecordAudio("324531060", var_255_13)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_324531", "324531060", "story_v_out_324531.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_324531", "324531060", "story_v_out_324531.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_5, arg_252_1.talkMaxDuration)

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_4) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_4 + var_255_14 and arg_252_1.time_ < var_255_4 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play324531061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 324531061
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play324531062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10170ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect10170ui_story == nil then
				arg_256_1.var_.characterEffect10170ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect10170ui_story and not isNil(var_259_0) then
					local var_259_4 = Mathf.Lerp(0, 0.5, var_259_3)

					arg_256_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_256_1.var_.characterEffect10170ui_story.fillRatio = var_259_4
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect10170ui_story then
				local var_259_5 = 0.5

				arg_256_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_256_1.var_.characterEffect10170ui_story.fillRatio = var_259_5
			end

			local var_259_6 = 0
			local var_259_7 = 0.3

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_8 = arg_256_1:FormatText(StoryNameCfg[7].name)

				arg_256_1.leftNameTxt_.text = var_259_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_9 = arg_256_1:GetWordFromCfg(324531061)
				local var_259_10 = arg_256_1:FormatText(var_259_9.content)

				arg_256_1.text_.text = var_259_10

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_11 = 12
				local var_259_12 = utf8.len(var_259_10)
				local var_259_13 = var_259_11 <= 0 and var_259_7 or var_259_7 * (var_259_12 / var_259_11)

				if var_259_13 > 0 and var_259_7 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13

					if var_259_13 + var_259_6 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_6
					end
				end

				arg_256_1.text_.text = var_259_10
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_14 = math.max(var_259_7, arg_256_1.talkMaxDuration)

			if var_259_6 <= arg_256_1.time_ and arg_256_1.time_ < var_259_6 + var_259_14 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_6) / var_259_14

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_6 + var_259_14 and arg_256_1.time_ < var_259_6 + var_259_14 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play324531062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 324531062
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play324531063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.45

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[7].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_3 = arg_260_1:GetWordFromCfg(324531062)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 18
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_8 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_8 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_8

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_8 and arg_260_1.time_ < var_263_0 + var_263_8 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play324531063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 324531063
		arg_264_1.duration_ = 1.63

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play324531064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["10170ui_story"]
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect10170ui_story == nil then
				arg_264_1.var_.characterEffect10170ui_story = var_267_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 and not isNil(var_267_0) then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / var_267_2

				if arg_264_1.var_.characterEffect10170ui_story and not isNil(var_267_0) then
					arg_264_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 and not isNil(var_267_0) and arg_264_1.var_.characterEffect10170ui_story then
				arg_264_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_267_4 = 0
			local var_267_5 = 0.2

			if var_267_4 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_6 = arg_264_1:FormatText(StoryNameCfg[1450].name)

				arg_264_1.leftNameTxt_.text = var_267_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_7 = arg_264_1:GetWordFromCfg(324531063)
				local var_267_8 = arg_264_1:FormatText(var_267_7.content)

				arg_264_1.text_.text = var_267_8

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_9 = 8
				local var_267_10 = utf8.len(var_267_8)
				local var_267_11 = var_267_9 <= 0 and var_267_5 or var_267_5 * (var_267_10 / var_267_9)

				if var_267_11 > 0 and var_267_5 < var_267_11 then
					arg_264_1.talkMaxDuration = var_267_11

					if var_267_11 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_4
					end
				end

				arg_264_1.text_.text = var_267_8
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531063", "story_v_out_324531.awb") ~= 0 then
					local var_267_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531063", "story_v_out_324531.awb") / 1000

					if var_267_12 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_12 + var_267_4
					end

					if var_267_7.prefab_name ~= "" and arg_264_1.actors_[var_267_7.prefab_name] ~= nil then
						local var_267_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_7.prefab_name].transform, "story_v_out_324531", "324531063", "story_v_out_324531.awb")

						arg_264_1:RecordAudio("324531063", var_267_13)
						arg_264_1:RecordAudio("324531063", var_267_13)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_324531", "324531063", "story_v_out_324531.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_324531", "324531063", "story_v_out_324531.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_14 = math.max(var_267_5, arg_264_1.talkMaxDuration)

			if var_267_4 <= arg_264_1.time_ and arg_264_1.time_ < var_267_4 + var_267_14 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_4) / var_267_14

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_4 + var_267_14 and arg_264_1.time_ < var_267_4 + var_267_14 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play324531064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 324531064
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play324531065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["10170ui_story"]
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect10170ui_story == nil then
				arg_268_1.var_.characterEffect10170ui_story = var_271_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.200000002980232

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 and not isNil(var_271_0) then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2

				if arg_268_1.var_.characterEffect10170ui_story and not isNil(var_271_0) then
					local var_271_4 = Mathf.Lerp(0, 0.5, var_271_3)

					arg_268_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_268_1.var_.characterEffect10170ui_story.fillRatio = var_271_4
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect10170ui_story then
				local var_271_5 = 0.5

				arg_268_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_268_1.var_.characterEffect10170ui_story.fillRatio = var_271_5
			end

			local var_271_6 = 0
			local var_271_7 = 0.25

			if var_271_6 < arg_268_1.time_ and arg_268_1.time_ <= var_271_6 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_8 = arg_268_1:FormatText(StoryNameCfg[7].name)

				arg_268_1.leftNameTxt_.text = var_271_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_9 = arg_268_1:GetWordFromCfg(324531064)
				local var_271_10 = arg_268_1:FormatText(var_271_9.content)

				arg_268_1.text_.text = var_271_10

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_11 = 10
				local var_271_12 = utf8.len(var_271_10)
				local var_271_13 = var_271_11 <= 0 and var_271_7 or var_271_7 * (var_271_12 / var_271_11)

				if var_271_13 > 0 and var_271_7 < var_271_13 then
					arg_268_1.talkMaxDuration = var_271_13

					if var_271_13 + var_271_6 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_13 + var_271_6
					end
				end

				arg_268_1.text_.text = var_271_10
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_14 = math.max(var_271_7, arg_268_1.talkMaxDuration)

			if var_271_6 <= arg_268_1.time_ and arg_268_1.time_ < var_271_6 + var_271_14 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_6) / var_271_14

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_6 + var_271_14 and arg_268_1.time_ < var_271_6 + var_271_14 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play324531065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 324531065
		arg_272_1.duration_ = 2.53

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play324531066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["10170ui_story"]
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect10170ui_story == nil then
				arg_272_1.var_.characterEffect10170ui_story = var_275_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_2 and not isNil(var_275_0) then
				local var_275_3 = (arg_272_1.time_ - var_275_1) / var_275_2

				if arg_272_1.var_.characterEffect10170ui_story and not isNil(var_275_0) then
					arg_272_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= var_275_1 + var_275_2 and arg_272_1.time_ < var_275_1 + var_275_2 + arg_275_0 and not isNil(var_275_0) and arg_272_1.var_.characterEffect10170ui_story then
				arg_272_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_275_4 = 0
			local var_275_5 = 0.2

			if var_275_4 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_6 = arg_272_1:FormatText(StoryNameCfg[1450].name)

				arg_272_1.leftNameTxt_.text = var_275_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_7 = arg_272_1:GetWordFromCfg(324531065)
				local var_275_8 = arg_272_1:FormatText(var_275_7.content)

				arg_272_1.text_.text = var_275_8

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_9 = 8
				local var_275_10 = utf8.len(var_275_8)
				local var_275_11 = var_275_9 <= 0 and var_275_5 or var_275_5 * (var_275_10 / var_275_9)

				if var_275_11 > 0 and var_275_5 < var_275_11 then
					arg_272_1.talkMaxDuration = var_275_11

					if var_275_11 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_11 + var_275_4
					end
				end

				arg_272_1.text_.text = var_275_8
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531065", "story_v_out_324531.awb") ~= 0 then
					local var_275_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531065", "story_v_out_324531.awb") / 1000

					if var_275_12 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_12 + var_275_4
					end

					if var_275_7.prefab_name ~= "" and arg_272_1.actors_[var_275_7.prefab_name] ~= nil then
						local var_275_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_7.prefab_name].transform, "story_v_out_324531", "324531065", "story_v_out_324531.awb")

						arg_272_1:RecordAudio("324531065", var_275_13)
						arg_272_1:RecordAudio("324531065", var_275_13)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_324531", "324531065", "story_v_out_324531.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_324531", "324531065", "story_v_out_324531.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_14 = math.max(var_275_5, arg_272_1.talkMaxDuration)

			if var_275_4 <= arg_272_1.time_ and arg_272_1.time_ < var_275_4 + var_275_14 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_4) / var_275_14

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_4 + var_275_14 and arg_272_1.time_ < var_275_4 + var_275_14 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play324531066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 324531066
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play324531067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10170ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect10170ui_story == nil then
				arg_276_1.var_.characterEffect10170ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect10170ui_story and not isNil(var_279_0) then
					local var_279_4 = Mathf.Lerp(0, 0.5, var_279_3)

					arg_276_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_276_1.var_.characterEffect10170ui_story.fillRatio = var_279_4
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect10170ui_story then
				local var_279_5 = 0.5

				arg_276_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_276_1.var_.characterEffect10170ui_story.fillRatio = var_279_5
			end

			local var_279_6 = 0
			local var_279_7 = 1.35

			if var_279_6 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_8 = arg_276_1:GetWordFromCfg(324531066)
				local var_279_9 = arg_276_1:FormatText(var_279_8.content)

				arg_276_1.text_.text = var_279_9

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_10 = 54
				local var_279_11 = utf8.len(var_279_9)
				local var_279_12 = var_279_10 <= 0 and var_279_7 or var_279_7 * (var_279_11 / var_279_10)

				if var_279_12 > 0 and var_279_7 < var_279_12 then
					arg_276_1.talkMaxDuration = var_279_12

					if var_279_12 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_12 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_9
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_13 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_13 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_6) / var_279_13

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_6 + var_279_13 and arg_276_1.time_ < var_279_6 + var_279_13 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play324531067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 324531067
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play324531068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 0.625

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_2 = arg_280_1:FormatText(StoryNameCfg[7].name)

				arg_280_1.leftNameTxt_.text = var_283_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_3 = arg_280_1:GetWordFromCfg(324531067)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 25
				local var_283_6 = utf8.len(var_283_4)
				local var_283_7 = var_283_5 <= 0 and var_283_1 or var_283_1 * (var_283_6 / var_283_5)

				if var_283_7 > 0 and var_283_1 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_8 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_8 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_8

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_8 and arg_280_1.time_ < var_283_0 + var_283_8 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play324531068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 324531068
		arg_284_1.duration_ = 1.33

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play324531069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["10170ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect10170ui_story == nil then
				arg_284_1.var_.characterEffect10170ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect10170ui_story and not isNil(var_287_0) then
					arg_284_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect10170ui_story then
				arg_284_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_287_4 = 0
			local var_287_5 = 0.125

			if var_287_4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_6 = arg_284_1:FormatText(StoryNameCfg[1450].name)

				arg_284_1.leftNameTxt_.text = var_287_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_7 = arg_284_1:GetWordFromCfg(324531068)
				local var_287_8 = arg_284_1:FormatText(var_287_7.content)

				arg_284_1.text_.text = var_287_8

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_9 = 5
				local var_287_10 = utf8.len(var_287_8)
				local var_287_11 = var_287_9 <= 0 and var_287_5 or var_287_5 * (var_287_10 / var_287_9)

				if var_287_11 > 0 and var_287_5 < var_287_11 then
					arg_284_1.talkMaxDuration = var_287_11

					if var_287_11 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_11 + var_287_4
					end
				end

				arg_284_1.text_.text = var_287_8
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531068", "story_v_out_324531.awb") ~= 0 then
					local var_287_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531068", "story_v_out_324531.awb") / 1000

					if var_287_12 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_12 + var_287_4
					end

					if var_287_7.prefab_name ~= "" and arg_284_1.actors_[var_287_7.prefab_name] ~= nil then
						local var_287_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_7.prefab_name].transform, "story_v_out_324531", "324531068", "story_v_out_324531.awb")

						arg_284_1:RecordAudio("324531068", var_287_13)
						arg_284_1:RecordAudio("324531068", var_287_13)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_324531", "324531068", "story_v_out_324531.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_324531", "324531068", "story_v_out_324531.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_14 = math.max(var_287_5, arg_284_1.talkMaxDuration)

			if var_287_4 <= arg_284_1.time_ and arg_284_1.time_ < var_287_4 + var_287_14 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_4) / var_287_14

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_4 + var_287_14 and arg_284_1.time_ < var_287_4 + var_287_14 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play324531069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 324531069
		arg_288_1.duration_ = 6.67

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play324531070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["10170ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect10170ui_story == nil then
				arg_288_1.var_.characterEffect10170ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect10170ui_story and not isNil(var_291_0) then
					local var_291_4 = Mathf.Lerp(0, 0.5, var_291_3)

					arg_288_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_288_1.var_.characterEffect10170ui_story.fillRatio = var_291_4
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect10170ui_story then
				local var_291_5 = 0.5

				arg_288_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_288_1.var_.characterEffect10170ui_story.fillRatio = var_291_5
			end

			local var_291_6 = arg_288_1.bgs_.MS2406.transform
			local var_291_7 = 0

			if var_291_7 < arg_288_1.time_ and arg_288_1.time_ <= var_291_7 + arg_291_0 then
				arg_288_1.var_.moveOldPosMS2406 = var_291_6.localPosition
			end

			local var_291_8 = 2.2

			if var_291_7 <= arg_288_1.time_ and arg_288_1.time_ < var_291_7 + var_291_8 then
				local var_291_9 = (arg_288_1.time_ - var_291_7) / var_291_8
				local var_291_10 = Vector3.New(0, 0.39, 7)

				var_291_6.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPosMS2406, var_291_10, var_291_9)
			end

			if arg_288_1.time_ >= var_291_7 + var_291_8 and arg_288_1.time_ < var_291_7 + var_291_8 + arg_291_0 then
				var_291_6.localPosition = Vector3.New(0, 0.39, 7)
			end

			local var_291_11 = 0

			if var_291_11 < arg_288_1.time_ and arg_288_1.time_ <= var_291_11 + arg_291_0 then
				arg_288_1.allBtn_.enabled = false
			end

			local var_291_12 = 2.1

			if arg_288_1.time_ >= var_291_11 + var_291_12 and arg_288_1.time_ < var_291_11 + var_291_12 + arg_291_0 then
				arg_288_1.allBtn_.enabled = true
			end

			local var_291_13 = 0.5
			local var_291_14 = 1

			if var_291_13 < arg_288_1.time_ and arg_288_1.time_ <= var_291_13 + arg_291_0 then
				local var_291_15 = "play"
				local var_291_16 = "effect"

				arg_288_1:AudioAction(var_291_15, var_291_16, "se_story_1310", "se_story_1310_footstep01", "")
			end

			if arg_288_1.frameCnt_ <= 1 then
				arg_288_1.dialog_:SetActive(false)
			end

			local var_291_17 = 1.66666666666667
			local var_291_18 = 1.275

			if var_291_17 < arg_288_1.time_ and arg_288_1.time_ <= var_291_17 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0

				arg_288_1.dialog_:SetActive(true)

				arg_288_1.dialogCg_.alpha = 0

				local var_291_19 = LeanTween.value(arg_288_1.dialog_, 0, 1, 0.3)

				var_291_19:setOnUpdate(LuaHelper.FloatAction(function(arg_292_0)
					arg_288_1.dialogCg_.alpha = arg_292_0
				end))
				var_291_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_288_1.dialog_)
					var_291_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_288_1.duration_ = arg_288_1.duration_ + 0.3

				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_20 = arg_288_1:GetWordFromCfg(324531069)
				local var_291_21 = arg_288_1:FormatText(var_291_20.content)

				arg_288_1.text_.text = var_291_21

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_22 = 51
				local var_291_23 = utf8.len(var_291_21)
				local var_291_24 = var_291_22 <= 0 and var_291_18 or var_291_18 * (var_291_23 / var_291_22)

				if var_291_24 > 0 and var_291_18 < var_291_24 then
					arg_288_1.talkMaxDuration = var_291_24
					var_291_17 = var_291_17 + 0.3

					if var_291_24 + var_291_17 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_24 + var_291_17
					end
				end

				arg_288_1.text_.text = var_291_21
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_25 = var_291_17 + 0.3
			local var_291_26 = math.max(var_291_18, arg_288_1.talkMaxDuration)

			if var_291_25 <= arg_288_1.time_ and arg_288_1.time_ < var_291_25 + var_291_26 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_25) / var_291_26

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_25 + var_291_26 and arg_288_1.time_ < var_291_25 + var_291_26 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2406",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 0.39, 7),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play324531070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 324531070
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play324531071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.65

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

				local var_297_2 = arg_294_1:GetWordFromCfg(324531070)
				local var_297_3 = arg_294_1:FormatText(var_297_2.content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 26
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
	Play324531071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 324531071
		arg_298_1.duration_ = 4.37

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play324531072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["10170ui_story"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect10170ui_story == nil then
				arg_298_1.var_.characterEffect10170ui_story = var_301_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.200000002980232

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.characterEffect10170ui_story and not isNil(var_301_0) then
					arg_298_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.characterEffect10170ui_story then
				arg_298_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_301_4 = 0
			local var_301_5 = 0.55

			if var_301_4 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_6 = arg_298_1:FormatText(StoryNameCfg[1450].name)

				arg_298_1.leftNameTxt_.text = var_301_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_7 = arg_298_1:GetWordFromCfg(324531071)
				local var_301_8 = arg_298_1:FormatText(var_301_7.content)

				arg_298_1.text_.text = var_301_8

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_9 = 22
				local var_301_10 = utf8.len(var_301_8)
				local var_301_11 = var_301_9 <= 0 and var_301_5 or var_301_5 * (var_301_10 / var_301_9)

				if var_301_11 > 0 and var_301_5 < var_301_11 then
					arg_298_1.talkMaxDuration = var_301_11

					if var_301_11 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_11 + var_301_4
					end
				end

				arg_298_1.text_.text = var_301_8
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531071", "story_v_out_324531.awb") ~= 0 then
					local var_301_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531071", "story_v_out_324531.awb") / 1000

					if var_301_12 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_12 + var_301_4
					end

					if var_301_7.prefab_name ~= "" and arg_298_1.actors_[var_301_7.prefab_name] ~= nil then
						local var_301_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_7.prefab_name].transform, "story_v_out_324531", "324531071", "story_v_out_324531.awb")

						arg_298_1:RecordAudio("324531071", var_301_13)
						arg_298_1:RecordAudio("324531071", var_301_13)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_324531", "324531071", "story_v_out_324531.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_324531", "324531071", "story_v_out_324531.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_14 = math.max(var_301_5, arg_298_1.talkMaxDuration)

			if var_301_4 <= arg_298_1.time_ and arg_298_1.time_ < var_301_4 + var_301_14 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_4) / var_301_14

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_4 + var_301_14 and arg_298_1.time_ < var_301_4 + var_301_14 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play324531072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 324531072
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play324531073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["10170ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect10170ui_story == nil then
				arg_302_1.var_.characterEffect10170ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect10170ui_story and not isNil(var_305_0) then
					local var_305_4 = Mathf.Lerp(0, 0.5, var_305_3)

					arg_302_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_302_1.var_.characterEffect10170ui_story.fillRatio = var_305_4
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect10170ui_story then
				local var_305_5 = 0.5

				arg_302_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_302_1.var_.characterEffect10170ui_story.fillRatio = var_305_5
			end

			local var_305_6 = 0
			local var_305_7 = 0.3

			if var_305_6 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_8 = arg_302_1:FormatText(StoryNameCfg[7].name)

				arg_302_1.leftNameTxt_.text = var_305_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_9 = arg_302_1:GetWordFromCfg(324531072)
				local var_305_10 = arg_302_1:FormatText(var_305_9.content)

				arg_302_1.text_.text = var_305_10

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_11 = 12
				local var_305_12 = utf8.len(var_305_10)
				local var_305_13 = var_305_11 <= 0 and var_305_7 or var_305_7 * (var_305_12 / var_305_11)

				if var_305_13 > 0 and var_305_7 < var_305_13 then
					arg_302_1.talkMaxDuration = var_305_13

					if var_305_13 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_6
					end
				end

				arg_302_1.text_.text = var_305_10
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_14 = math.max(var_305_7, arg_302_1.talkMaxDuration)

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_14 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_6) / var_305_14

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_6 + var_305_14 and arg_302_1.time_ < var_305_6 + var_305_14 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play324531073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 324531073
		arg_306_1.duration_ = 5.13

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play324531074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["10170ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect10170ui_story == nil then
				arg_306_1.var_.characterEffect10170ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect10170ui_story and not isNil(var_309_0) then
					arg_306_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect10170ui_story then
				arg_306_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_309_4 = 0
			local var_309_5 = 0.5

			if var_309_4 < arg_306_1.time_ and arg_306_1.time_ <= var_309_4 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_6 = arg_306_1:FormatText(StoryNameCfg[1450].name)

				arg_306_1.leftNameTxt_.text = var_309_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_7 = arg_306_1:GetWordFromCfg(324531073)
				local var_309_8 = arg_306_1:FormatText(var_309_7.content)

				arg_306_1.text_.text = var_309_8

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_9 = 20
				local var_309_10 = utf8.len(var_309_8)
				local var_309_11 = var_309_9 <= 0 and var_309_5 or var_309_5 * (var_309_10 / var_309_9)

				if var_309_11 > 0 and var_309_5 < var_309_11 then
					arg_306_1.talkMaxDuration = var_309_11

					if var_309_11 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_11 + var_309_4
					end
				end

				arg_306_1.text_.text = var_309_8
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531073", "story_v_out_324531.awb") ~= 0 then
					local var_309_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531073", "story_v_out_324531.awb") / 1000

					if var_309_12 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_12 + var_309_4
					end

					if var_309_7.prefab_name ~= "" and arg_306_1.actors_[var_309_7.prefab_name] ~= nil then
						local var_309_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_7.prefab_name].transform, "story_v_out_324531", "324531073", "story_v_out_324531.awb")

						arg_306_1:RecordAudio("324531073", var_309_13)
						arg_306_1:RecordAudio("324531073", var_309_13)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_324531", "324531073", "story_v_out_324531.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_324531", "324531073", "story_v_out_324531.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_14 = math.max(var_309_5, arg_306_1.talkMaxDuration)

			if var_309_4 <= arg_306_1.time_ and arg_306_1.time_ < var_309_4 + var_309_14 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_4) / var_309_14

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_4 + var_309_14 and arg_306_1.time_ < var_309_4 + var_309_14 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play324531074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 324531074
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play324531075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["10170ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect10170ui_story == nil then
				arg_310_1.var_.characterEffect10170ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect10170ui_story and not isNil(var_313_0) then
					local var_313_4 = Mathf.Lerp(0, 0.5, var_313_3)

					arg_310_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_310_1.var_.characterEffect10170ui_story.fillRatio = var_313_4
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect10170ui_story then
				local var_313_5 = 0.5

				arg_310_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_310_1.var_.characterEffect10170ui_story.fillRatio = var_313_5
			end

			local var_313_6 = 0
			local var_313_7 = 0.825

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_8 = arg_310_1:FormatText(StoryNameCfg[7].name)

				arg_310_1.leftNameTxt_.text = var_313_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_9 = arg_310_1:GetWordFromCfg(324531074)
				local var_313_10 = arg_310_1:FormatText(var_313_9.content)

				arg_310_1.text_.text = var_313_10

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_11 = 33
				local var_313_12 = utf8.len(var_313_10)
				local var_313_13 = var_313_11 <= 0 and var_313_7 or var_313_7 * (var_313_12 / var_313_11)

				if var_313_13 > 0 and var_313_7 < var_313_13 then
					arg_310_1.talkMaxDuration = var_313_13

					if var_313_13 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_13 + var_313_6
					end
				end

				arg_310_1.text_.text = var_313_10
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_14 = math.max(var_313_7, arg_310_1.talkMaxDuration)

			if var_313_6 <= arg_310_1.time_ and arg_310_1.time_ < var_313_6 + var_313_14 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_6) / var_313_14

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_6 + var_313_14 and arg_310_1.time_ < var_313_6 + var_313_14 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play324531075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 324531075
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play324531076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 0.8

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_2 = arg_314_1:GetWordFromCfg(324531075)
				local var_317_3 = arg_314_1:FormatText(var_317_2.content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 32
				local var_317_5 = utf8.len(var_317_3)
				local var_317_6 = var_317_4 <= 0 and var_317_1 or var_317_1 * (var_317_5 / var_317_4)

				if var_317_6 > 0 and var_317_1 < var_317_6 then
					arg_314_1.talkMaxDuration = var_317_6

					if var_317_6 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_7 and arg_314_1.time_ < var_317_0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play324531076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 324531076
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play324531077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 0.1

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[7].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_3 = arg_318_1:GetWordFromCfg(324531076)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 4
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
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_8 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_8 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_8

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_8 and arg_318_1.time_ < var_321_0 + var_321_8 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play324531077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 324531077
		arg_322_1.duration_ = 2.93

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play324531078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["10170ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect10170ui_story == nil then
				arg_322_1.var_.characterEffect10170ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect10170ui_story and not isNil(var_325_0) then
					arg_322_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect10170ui_story then
				arg_322_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_325_4 = 0
			local var_325_5 = 0.325

			if var_325_4 < arg_322_1.time_ and arg_322_1.time_ <= var_325_4 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_6 = arg_322_1:FormatText(StoryNameCfg[1450].name)

				arg_322_1.leftNameTxt_.text = var_325_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_7 = arg_322_1:GetWordFromCfg(324531077)
				local var_325_8 = arg_322_1:FormatText(var_325_7.content)

				arg_322_1.text_.text = var_325_8

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 13
				local var_325_10 = utf8.len(var_325_8)
				local var_325_11 = var_325_9 <= 0 and var_325_5 or var_325_5 * (var_325_10 / var_325_9)

				if var_325_11 > 0 and var_325_5 < var_325_11 then
					arg_322_1.talkMaxDuration = var_325_11

					if var_325_11 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_11 + var_325_4
					end
				end

				arg_322_1.text_.text = var_325_8
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531077", "story_v_out_324531.awb") ~= 0 then
					local var_325_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531077", "story_v_out_324531.awb") / 1000

					if var_325_12 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_12 + var_325_4
					end

					if var_325_7.prefab_name ~= "" and arg_322_1.actors_[var_325_7.prefab_name] ~= nil then
						local var_325_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_7.prefab_name].transform, "story_v_out_324531", "324531077", "story_v_out_324531.awb")

						arg_322_1:RecordAudio("324531077", var_325_13)
						arg_322_1:RecordAudio("324531077", var_325_13)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_324531", "324531077", "story_v_out_324531.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_324531", "324531077", "story_v_out_324531.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_14 = math.max(var_325_5, arg_322_1.talkMaxDuration)

			if var_325_4 <= arg_322_1.time_ and arg_322_1.time_ < var_325_4 + var_325_14 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_4) / var_325_14

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_4 + var_325_14 and arg_322_1.time_ < var_325_4 + var_325_14 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play324531078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 324531078
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play324531079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["10170ui_story"]
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect10170ui_story == nil then
				arg_326_1.var_.characterEffect10170ui_story = var_329_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 and not isNil(var_329_0) then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2

				if arg_326_1.var_.characterEffect10170ui_story and not isNil(var_329_0) then
					local var_329_4 = Mathf.Lerp(0, 0.5, var_329_3)

					arg_326_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_326_1.var_.characterEffect10170ui_story.fillRatio = var_329_4
				end
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 and not isNil(var_329_0) and arg_326_1.var_.characterEffect10170ui_story then
				local var_329_5 = 0.5

				arg_326_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_326_1.var_.characterEffect10170ui_story.fillRatio = var_329_5
			end

			local var_329_6 = 0
			local var_329_7 = 0.1

			if var_329_6 < arg_326_1.time_ and arg_326_1.time_ <= var_329_6 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_8 = arg_326_1:FormatText(StoryNameCfg[7].name)

				arg_326_1.leftNameTxt_.text = var_329_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_9 = arg_326_1:GetWordFromCfg(324531078)
				local var_329_10 = arg_326_1:FormatText(var_329_9.content)

				arg_326_1.text_.text = var_329_10

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_11 = 4
				local var_329_12 = utf8.len(var_329_10)
				local var_329_13 = var_329_11 <= 0 and var_329_7 or var_329_7 * (var_329_12 / var_329_11)

				if var_329_13 > 0 and var_329_7 < var_329_13 then
					arg_326_1.talkMaxDuration = var_329_13

					if var_329_13 + var_329_6 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_13 + var_329_6
					end
				end

				arg_326_1.text_.text = var_329_10
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_14 = math.max(var_329_7, arg_326_1.talkMaxDuration)

			if var_329_6 <= arg_326_1.time_ and arg_326_1.time_ < var_329_6 + var_329_14 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_6) / var_329_14

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_6 + var_329_14 and arg_326_1.time_ < var_329_6 + var_329_14 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play324531079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 324531079
		arg_330_1.duration_ = 3.17

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play324531080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["10170ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect10170ui_story == nil then
				arg_330_1.var_.characterEffect10170ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect10170ui_story and not isNil(var_333_0) then
					arg_330_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect10170ui_story then
				arg_330_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_333_4 = 0
			local var_333_5 = 0.3

			if var_333_4 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_6 = arg_330_1:FormatText(StoryNameCfg[1450].name)

				arg_330_1.leftNameTxt_.text = var_333_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_7 = arg_330_1:GetWordFromCfg(324531079)
				local var_333_8 = arg_330_1:FormatText(var_333_7.content)

				arg_330_1.text_.text = var_333_8

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_9 = 12
				local var_333_10 = utf8.len(var_333_8)
				local var_333_11 = var_333_9 <= 0 and var_333_5 or var_333_5 * (var_333_10 / var_333_9)

				if var_333_11 > 0 and var_333_5 < var_333_11 then
					arg_330_1.talkMaxDuration = var_333_11

					if var_333_11 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_11 + var_333_4
					end
				end

				arg_330_1.text_.text = var_333_8
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531079", "story_v_out_324531.awb") ~= 0 then
					local var_333_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531079", "story_v_out_324531.awb") / 1000

					if var_333_12 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_12 + var_333_4
					end

					if var_333_7.prefab_name ~= "" and arg_330_1.actors_[var_333_7.prefab_name] ~= nil then
						local var_333_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_7.prefab_name].transform, "story_v_out_324531", "324531079", "story_v_out_324531.awb")

						arg_330_1:RecordAudio("324531079", var_333_13)
						arg_330_1:RecordAudio("324531079", var_333_13)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_324531", "324531079", "story_v_out_324531.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_324531", "324531079", "story_v_out_324531.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_14 = math.max(var_333_5, arg_330_1.talkMaxDuration)

			if var_333_4 <= arg_330_1.time_ and arg_330_1.time_ < var_333_4 + var_333_14 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_4) / var_333_14

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_4 + var_333_14 and arg_330_1.time_ < var_333_4 + var_333_14 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play324531080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 324531080
		arg_334_1.duration_ = 7.97

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play324531081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = "MS2406a"

			if arg_334_1.bgs_[var_337_0] == nil then
				local var_337_1 = Object.Instantiate(arg_334_1.paintGo_)

				var_337_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_337_0)
				var_337_1.name = var_337_0
				var_337_1.transform.parent = arg_334_1.stage_.transform
				var_337_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.bgs_[var_337_0] = var_337_1
			end

			local var_337_2 = 1.2

			if var_337_2 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				local var_337_3 = manager.ui.mainCamera.transform.localPosition
				local var_337_4 = Vector3.New(0, 0, 10) + Vector3.New(var_337_3.x, var_337_3.y, 0)
				local var_337_5 = arg_334_1.bgs_.MS2406a

				var_337_5.transform.localPosition = var_337_4
				var_337_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_337_6 = var_337_5:GetComponent("SpriteRenderer")

				if var_337_6 and var_337_6.sprite then
					local var_337_7 = (var_337_5.transform.localPosition - var_337_3).z
					local var_337_8 = manager.ui.mainCameraCom_
					local var_337_9 = 2 * var_337_7 * Mathf.Tan(var_337_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_337_10 = var_337_9 * var_337_8.aspect
					local var_337_11 = var_337_6.sprite.bounds.size.x
					local var_337_12 = var_337_6.sprite.bounds.size.y
					local var_337_13 = var_337_10 / var_337_11
					local var_337_14 = var_337_9 / var_337_12
					local var_337_15 = var_337_14 < var_337_13 and var_337_13 or var_337_14

					var_337_5.transform.localScale = Vector3.New(var_337_15, var_337_15, 0)
				end

				for iter_337_0, iter_337_1 in pairs(arg_334_1.bgs_) do
					if iter_337_0 ~= "MS2406a" then
						iter_337_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_337_16 = manager.ui.mainCamera.transform
			local var_337_17 = 0

			if var_337_17 < arg_334_1.time_ and arg_334_1.time_ <= var_337_17 + arg_337_0 then
				local var_337_18 = arg_334_1.var_.effect32313
				local var_337_19
				local var_337_20 = var_337_16

				if not var_337_18 then
					var_337_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_337_20)
					var_337_18.name = "32313"
					arg_334_1.var_.effect32313 = var_337_18
				else
					var_337_18.transform:SetParent(var_337_20)
				end

				var_337_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_337_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_337_21 = 1.7777777777777777
				local var_337_22 = Screen.width / Screen.height
				local var_337_23 = var_337_22 / var_337_21
				local var_337_24 = Mathf.Max(var_337_21 / var_337_22, 1)

				var_337_18.transform.localScale = Vector3.New(var_337_18.transform.localScale.x * var_337_23, var_337_18.transform.localScale.y * var_337_24, var_337_18.transform.localScale.z)
			end

			local var_337_25 = manager.ui.mainCamera.transform
			local var_337_26 = 1.2

			if var_337_26 < arg_334_1.time_ and arg_334_1.time_ <= var_337_26 + arg_337_0 then
				local var_337_27 = arg_334_1.var_.effect32313

				if var_337_27 then
					Object.Destroy(var_337_27)

					arg_334_1.var_.effect32313 = nil
				end
			end

			local var_337_28 = manager.ui.mainCamera.transform
			local var_337_29 = 1.2

			if var_337_29 < arg_334_1.time_ and arg_334_1.time_ <= var_337_29 + arg_337_0 then
				local var_337_30 = arg_334_1.var_.effect21313
				local var_337_31
				local var_337_32 = var_337_28

				if not var_337_30 then
					var_337_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_337_32)
					var_337_30.name = "21313"
					arg_334_1.var_.effect21313 = var_337_30
				else
					var_337_30.transform:SetParent(var_337_32)
				end

				var_337_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_337_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_337_33 = 1.7777777777777777
				local var_337_34 = Screen.width / Screen.height
				local var_337_35 = var_337_34 / var_337_33
				local var_337_36 = Mathf.Max(var_337_33 / var_337_34, 1)

				var_337_30.transform.localScale = Vector3.New(var_337_30.transform.localScale.x * var_337_35, var_337_30.transform.localScale.y * var_337_36, var_337_30.transform.localScale.z)
			end

			local var_337_37 = manager.ui.mainCamera.transform
			local var_337_38 = 1.7

			if var_337_38 < arg_334_1.time_ and arg_334_1.time_ <= var_337_38 + arg_337_0 then
				local var_337_39 = arg_334_1.var_.effect21313

				if var_337_39 then
					Object.Destroy(var_337_39)

					arg_334_1.var_.effect21313 = nil
				end
			end

			local var_337_40 = 0

			if var_337_40 < arg_334_1.time_ and arg_334_1.time_ <= var_337_40 + arg_337_0 then
				arg_334_1.allBtn_.enabled = false
			end

			local var_337_41 = 3.2

			if arg_334_1.time_ >= var_337_40 + var_337_41 and arg_334_1.time_ < var_337_40 + var_337_41 + arg_337_0 then
				arg_334_1.allBtn_.enabled = true
			end

			if arg_334_1.frameCnt_ <= 1 then
				arg_334_1.dialog_:SetActive(false)
			end

			local var_337_42 = 2.96666666666667
			local var_337_43 = 1.225

			if var_337_42 < arg_334_1.time_ and arg_334_1.time_ <= var_337_42 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0

				arg_334_1.dialog_:SetActive(true)

				arg_334_1.dialogCg_.alpha = 0

				local var_337_44 = LeanTween.value(arg_334_1.dialog_, 0, 1, 0.3)

				var_337_44:setOnUpdate(LuaHelper.FloatAction(function(arg_338_0)
					arg_334_1.dialogCg_.alpha = arg_338_0
				end))
				var_337_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_334_1.dialog_)
					var_337_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_334_1.duration_ = arg_334_1.duration_ + 0.3

				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_45 = arg_334_1:GetWordFromCfg(324531080)
				local var_337_46 = arg_334_1:FormatText(var_337_45.content)

				arg_334_1.text_.text = var_337_46

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_47 = 49
				local var_337_48 = utf8.len(var_337_46)
				local var_337_49 = var_337_47 <= 0 and var_337_43 or var_337_43 * (var_337_48 / var_337_47)

				if var_337_49 > 0 and var_337_43 < var_337_49 then
					arg_334_1.talkMaxDuration = var_337_49
					var_337_42 = var_337_42 + 0.3

					if var_337_49 + var_337_42 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_49 + var_337_42
					end
				end

				arg_334_1.text_.text = var_337_46
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_50 = var_337_42 + 0.3
			local var_337_51 = math.max(var_337_43, arg_334_1.talkMaxDuration)

			if var_337_50 <= arg_334_1.time_ and arg_334_1.time_ < var_337_50 + var_337_51 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_50) / var_337_51

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_50 + var_337_51 and arg_334_1.time_ < var_337_50 + var_337_51 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play324531081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 324531081
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play324531082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 1.125

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

				local var_343_2 = arg_340_1:GetWordFromCfg(324531081)
				local var_343_3 = arg_340_1:FormatText(var_343_2.content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 45
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
	Play324531082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 324531082
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play324531083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 1.275

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_2 = arg_344_1:GetWordFromCfg(324531082)
				local var_347_3 = arg_344_1:FormatText(var_347_2.content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 51
				local var_347_5 = utf8.len(var_347_3)
				local var_347_6 = var_347_4 <= 0 and var_347_1 or var_347_1 * (var_347_5 / var_347_4)

				if var_347_6 > 0 and var_347_1 < var_347_6 then
					arg_344_1.talkMaxDuration = var_347_6

					if var_347_6 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_7 and arg_344_1.time_ < var_347_0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play324531083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 324531083
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play324531084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.35

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[7].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:GetWordFromCfg(324531083)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 14
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_8 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_8 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_8

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_8 and arg_348_1.time_ < var_351_0 + var_351_8 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play324531084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 324531084
		arg_352_1.duration_ = 2.9

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play324531085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["10170ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect10170ui_story == nil then
				arg_352_1.var_.characterEffect10170ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect10170ui_story and not isNil(var_355_0) then
					arg_352_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect10170ui_story then
				arg_352_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_355_4 = 0
			local var_355_5 = 0.325

			if var_355_4 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_6 = arg_352_1:FormatText(StoryNameCfg[1450].name)

				arg_352_1.leftNameTxt_.text = var_355_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_7 = arg_352_1:GetWordFromCfg(324531084)
				local var_355_8 = arg_352_1:FormatText(var_355_7.content)

				arg_352_1.text_.text = var_355_8

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_9 = 13
				local var_355_10 = utf8.len(var_355_8)
				local var_355_11 = var_355_9 <= 0 and var_355_5 or var_355_5 * (var_355_10 / var_355_9)

				if var_355_11 > 0 and var_355_5 < var_355_11 then
					arg_352_1.talkMaxDuration = var_355_11

					if var_355_11 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_11 + var_355_4
					end
				end

				arg_352_1.text_.text = var_355_8
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531084", "story_v_out_324531.awb") ~= 0 then
					local var_355_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531084", "story_v_out_324531.awb") / 1000

					if var_355_12 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_12 + var_355_4
					end

					if var_355_7.prefab_name ~= "" and arg_352_1.actors_[var_355_7.prefab_name] ~= nil then
						local var_355_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_7.prefab_name].transform, "story_v_out_324531", "324531084", "story_v_out_324531.awb")

						arg_352_1:RecordAudio("324531084", var_355_13)
						arg_352_1:RecordAudio("324531084", var_355_13)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_324531", "324531084", "story_v_out_324531.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_324531", "324531084", "story_v_out_324531.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_14 = math.max(var_355_5, arg_352_1.talkMaxDuration)

			if var_355_4 <= arg_352_1.time_ and arg_352_1.time_ < var_355_4 + var_355_14 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_4) / var_355_14

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_4 + var_355_14 and arg_352_1.time_ < var_355_4 + var_355_14 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play324531085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 324531085
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play324531086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["10170ui_story"]
			local var_359_1 = 0

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect10170ui_story == nil then
				arg_356_1.var_.characterEffect10170ui_story = var_359_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.200000002980232

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.characterEffect10170ui_story and not isNil(var_359_0) then
					local var_359_4 = Mathf.Lerp(0, 0.5, var_359_3)

					arg_356_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_356_1.var_.characterEffect10170ui_story.fillRatio = var_359_4
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.characterEffect10170ui_story then
				local var_359_5 = 0.5

				arg_356_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_356_1.var_.characterEffect10170ui_story.fillRatio = var_359_5
			end

			local var_359_6 = 0
			local var_359_7 = 1.375

			if var_359_6 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_8 = arg_356_1:GetWordFromCfg(324531085)
				local var_359_9 = arg_356_1:FormatText(var_359_8.content)

				arg_356_1.text_.text = var_359_9

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_10 = 55
				local var_359_11 = utf8.len(var_359_9)
				local var_359_12 = var_359_10 <= 0 and var_359_7 or var_359_7 * (var_359_11 / var_359_10)

				if var_359_12 > 0 and var_359_7 < var_359_12 then
					arg_356_1.talkMaxDuration = var_359_12

					if var_359_12 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_12 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_9
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_13 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_13 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_13

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_13 and arg_356_1.time_ < var_359_6 + var_359_13 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play324531086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 324531086
		arg_360_1.duration_ = 1.1

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play324531087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["10170ui_story"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10170ui_story == nil then
				arg_360_1.var_.characterEffect10170ui_story = var_363_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.characterEffect10170ui_story and not isNil(var_363_0) then
					arg_360_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.characterEffect10170ui_story then
				arg_360_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_363_4 = 0
			local var_363_5 = 0.075

			if var_363_4 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_6 = arg_360_1:FormatText(StoryNameCfg[1450].name)

				arg_360_1.leftNameTxt_.text = var_363_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_7 = arg_360_1:GetWordFromCfg(324531086)
				local var_363_8 = arg_360_1:FormatText(var_363_7.content)

				arg_360_1.text_.text = var_363_8

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 3
				local var_363_10 = utf8.len(var_363_8)
				local var_363_11 = var_363_9 <= 0 and var_363_5 or var_363_5 * (var_363_10 / var_363_9)

				if var_363_11 > 0 and var_363_5 < var_363_11 then
					arg_360_1.talkMaxDuration = var_363_11

					if var_363_11 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_11 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_8
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531086", "story_v_out_324531.awb") ~= 0 then
					local var_363_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531086", "story_v_out_324531.awb") / 1000

					if var_363_12 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_12 + var_363_4
					end

					if var_363_7.prefab_name ~= "" and arg_360_1.actors_[var_363_7.prefab_name] ~= nil then
						local var_363_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_7.prefab_name].transform, "story_v_out_324531", "324531086", "story_v_out_324531.awb")

						arg_360_1:RecordAudio("324531086", var_363_13)
						arg_360_1:RecordAudio("324531086", var_363_13)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_324531", "324531086", "story_v_out_324531.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_324531", "324531086", "story_v_out_324531.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_14 = math.max(var_363_5, arg_360_1.talkMaxDuration)

			if var_363_4 <= arg_360_1.time_ and arg_360_1.time_ < var_363_4 + var_363_14 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_4) / var_363_14

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_4 + var_363_14 and arg_360_1.time_ < var_363_4 + var_363_14 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play324531087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 324531087
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play324531088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["10170ui_story"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10170ui_story == nil then
				arg_364_1.var_.characterEffect10170ui_story = var_367_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.characterEffect10170ui_story and not isNil(var_367_0) then
					local var_367_4 = Mathf.Lerp(0, 0.5, var_367_3)

					arg_364_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_364_1.var_.characterEffect10170ui_story.fillRatio = var_367_4
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect10170ui_story then
				local var_367_5 = 0.5

				arg_364_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_364_1.var_.characterEffect10170ui_story.fillRatio = var_367_5
			end

			local var_367_6 = 0
			local var_367_7 = 0.125

			if var_367_6 < arg_364_1.time_ and arg_364_1.time_ <= var_367_6 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_8 = arg_364_1:FormatText(StoryNameCfg[7].name)

				arg_364_1.leftNameTxt_.text = var_367_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_9 = arg_364_1:GetWordFromCfg(324531087)
				local var_367_10 = arg_364_1:FormatText(var_367_9.content)

				arg_364_1.text_.text = var_367_10

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_11 = 5
				local var_367_12 = utf8.len(var_367_10)
				local var_367_13 = var_367_11 <= 0 and var_367_7 or var_367_7 * (var_367_12 / var_367_11)

				if var_367_13 > 0 and var_367_7 < var_367_13 then
					arg_364_1.talkMaxDuration = var_367_13

					if var_367_13 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_13 + var_367_6
					end
				end

				arg_364_1.text_.text = var_367_10
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_14 = math.max(var_367_7, arg_364_1.talkMaxDuration)

			if var_367_6 <= arg_364_1.time_ and arg_364_1.time_ < var_367_6 + var_367_14 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_6) / var_367_14

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_6 + var_367_14 and arg_364_1.time_ < var_367_6 + var_367_14 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play324531088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 324531088
		arg_368_1.duration_ = 1.5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play324531089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = arg_368_1.actors_["10170ui_story"]
			local var_371_1 = 0

			if var_371_1 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10170ui_story == nil then
				arg_368_1.var_.characterEffect10170ui_story = var_371_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_2 and not isNil(var_371_0) then
				local var_371_3 = (arg_368_1.time_ - var_371_1) / var_371_2

				if arg_368_1.var_.characterEffect10170ui_story and not isNil(var_371_0) then
					arg_368_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= var_371_1 + var_371_2 and arg_368_1.time_ < var_371_1 + var_371_2 + arg_371_0 and not isNil(var_371_0) and arg_368_1.var_.characterEffect10170ui_story then
				arg_368_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_371_4 = 0
			local var_371_5 = 0.125

			if var_371_4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_6 = arg_368_1:FormatText(StoryNameCfg[1450].name)

				arg_368_1.leftNameTxt_.text = var_371_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_7 = arg_368_1:GetWordFromCfg(324531088)
				local var_371_8 = arg_368_1:FormatText(var_371_7.content)

				arg_368_1.text_.text = var_371_8

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_9 = 5
				local var_371_10 = utf8.len(var_371_8)
				local var_371_11 = var_371_9 <= 0 and var_371_5 or var_371_5 * (var_371_10 / var_371_9)

				if var_371_11 > 0 and var_371_5 < var_371_11 then
					arg_368_1.talkMaxDuration = var_371_11

					if var_371_11 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_11 + var_371_4
					end
				end

				arg_368_1.text_.text = var_371_8
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531088", "story_v_out_324531.awb") ~= 0 then
					local var_371_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531088", "story_v_out_324531.awb") / 1000

					if var_371_12 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_12 + var_371_4
					end

					if var_371_7.prefab_name ~= "" and arg_368_1.actors_[var_371_7.prefab_name] ~= nil then
						local var_371_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_7.prefab_name].transform, "story_v_out_324531", "324531088", "story_v_out_324531.awb")

						arg_368_1:RecordAudio("324531088", var_371_13)
						arg_368_1:RecordAudio("324531088", var_371_13)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_324531", "324531088", "story_v_out_324531.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_324531", "324531088", "story_v_out_324531.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_14 = math.max(var_371_5, arg_368_1.talkMaxDuration)

			if var_371_4 <= arg_368_1.time_ and arg_368_1.time_ < var_371_4 + var_371_14 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_4) / var_371_14

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_4 + var_371_14 and arg_368_1.time_ < var_371_4 + var_371_14 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play324531089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 324531089
		arg_372_1.duration_ = 5.8

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play324531090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["10170ui_story"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10170ui_story == nil then
				arg_372_1.var_.characterEffect10170ui_story = var_375_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.characterEffect10170ui_story and not isNil(var_375_0) then
					local var_375_4 = Mathf.Lerp(0, 0.5, var_375_3)

					arg_372_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_372_1.var_.characterEffect10170ui_story.fillRatio = var_375_4
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.characterEffect10170ui_story then
				local var_375_5 = 0.5

				arg_372_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_372_1.var_.characterEffect10170ui_story.fillRatio = var_375_5
			end

			local var_375_6 = arg_372_1.bgs_.MS2406a.transform
			local var_375_7 = 0

			if var_375_7 < arg_372_1.time_ and arg_372_1.time_ <= var_375_7 + arg_375_0 then
				arg_372_1.var_.moveOldPosMS2406a = var_375_6.localPosition
			end

			local var_375_8 = 0.200000002980232

			if var_375_7 <= arg_372_1.time_ and arg_372_1.time_ < var_375_7 + var_375_8 then
				local var_375_9 = (arg_372_1.time_ - var_375_7) / var_375_8
				local var_375_10 = Vector3.New(0, 0.31, 5)

				var_375_6.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPosMS2406a, var_375_10, var_375_9)
			end

			if arg_372_1.time_ >= var_375_7 + var_375_8 and arg_372_1.time_ < var_375_7 + var_375_8 + arg_375_0 then
				var_375_6.localPosition = Vector3.New(0, 0.31, 5)
			end

			local var_375_11 = manager.ui.mainCamera.transform
			local var_375_12 = 0

			if var_375_12 < arg_372_1.time_ and arg_372_1.time_ <= var_375_12 + arg_375_0 then
				local var_375_13 = arg_372_1.var_.effecteqweqe
				local var_375_14
				local var_375_15 = var_375_11

				if not var_375_13 then
					var_375_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), var_375_15)
					var_375_13.name = "eqweqe"
					arg_372_1.var_.effecteqweqe = var_375_13
				else
					var_375_13.transform:SetParent(var_375_15)
				end

				var_375_13.transform.localPosition = Vector3.New(0, 0, -4.04)
				var_375_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_375_16 = 0

			if var_375_16 < arg_372_1.time_ and arg_372_1.time_ <= var_375_16 + arg_375_0 then
				arg_372_1.allBtn_.enabled = false
			end

			local var_375_17 = 2.1

			if arg_372_1.time_ >= var_375_16 + var_375_17 and arg_372_1.time_ < var_375_16 + var_375_17 + arg_375_0 then
				arg_372_1.allBtn_.enabled = true
			end

			local var_375_18 = 0.1
			local var_375_19 = 1

			if var_375_18 < arg_372_1.time_ and arg_372_1.time_ <= var_375_18 + arg_375_0 then
				local var_375_20 = "play"
				local var_375_21 = "effect"

				arg_372_1:AudioAction(var_375_20, var_375_21, "se_story_148", "se_story_148_box01", "")
			end

			local var_375_22 = 1
			local var_375_23 = 1

			if var_375_22 < arg_372_1.time_ and arg_372_1.time_ <= var_375_22 + arg_375_0 then
				local var_375_24 = "play"
				local var_375_25 = "effect"

				arg_372_1:AudioAction(var_375_24, var_375_25, "se_story_148", "se_story_148_sword06", "")
			end

			if arg_372_1.frameCnt_ <= 1 then
				arg_372_1.dialog_:SetActive(false)
			end

			local var_375_26 = 0.8
			local var_375_27 = 0.975

			if var_375_26 < arg_372_1.time_ and arg_372_1.time_ <= var_375_26 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0

				arg_372_1.dialog_:SetActive(true)

				arg_372_1.dialogCg_.alpha = 0

				local var_375_28 = LeanTween.value(arg_372_1.dialog_, 0, 1, 0.3)

				var_375_28:setOnUpdate(LuaHelper.FloatAction(function(arg_376_0)
					arg_372_1.dialogCg_.alpha = arg_376_0
				end))
				var_375_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_372_1.dialog_)
					var_375_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_372_1.duration_ = arg_372_1.duration_ + 0.3

				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_29 = arg_372_1:GetWordFromCfg(324531089)
				local var_375_30 = arg_372_1:FormatText(var_375_29.content)

				arg_372_1.text_.text = var_375_30

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_31 = 39
				local var_375_32 = utf8.len(var_375_30)
				local var_375_33 = var_375_31 <= 0 and var_375_27 or var_375_27 * (var_375_32 / var_375_31)

				if var_375_33 > 0 and var_375_27 < var_375_33 then
					arg_372_1.talkMaxDuration = var_375_33
					var_375_26 = var_375_26 + 0.3

					if var_375_33 + var_375_26 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_33 + var_375_26
					end
				end

				arg_372_1.text_.text = var_375_30
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_34 = var_375_26 + 0.3
			local var_375_35 = math.max(var_375_27, arg_372_1.talkMaxDuration)

			if var_375_34 <= arg_372_1.time_ and arg_372_1.time_ < var_375_34 + var_375_35 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_34) / var_375_35

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_34 + var_375_35 and arg_372_1.time_ < var_375_34 + var_375_35 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2406a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.200000002980232,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0.31, 5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play324531090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 324531090
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play324531091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 1.225

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_2 = arg_378_1:GetWordFromCfg(324531090)
				local var_381_3 = arg_378_1:FormatText(var_381_2.content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 49
				local var_381_5 = utf8.len(var_381_3)
				local var_381_6 = var_381_4 <= 0 and var_381_1 or var_381_1 * (var_381_5 / var_381_4)

				if var_381_6 > 0 and var_381_1 < var_381_6 then
					arg_378_1.talkMaxDuration = var_381_6

					if var_381_6 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_7 and arg_378_1.time_ < var_381_0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play324531091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 324531091
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play324531092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0.5
			local var_385_1 = 1

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				local var_385_2 = "play"
				local var_385_3 = "effect"

				arg_382_1:AudioAction(var_385_2, var_385_3, "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_385_4 = 0
			local var_385_5 = 1.3

			if var_385_4 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_6 = arg_382_1:GetWordFromCfg(324531091)
				local var_385_7 = arg_382_1:FormatText(var_385_6.content)

				arg_382_1.text_.text = var_385_7

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_8 = 52
				local var_385_9 = utf8.len(var_385_7)
				local var_385_10 = var_385_8 <= 0 and var_385_5 or var_385_5 * (var_385_9 / var_385_8)

				if var_385_10 > 0 and var_385_5 < var_385_10 then
					arg_382_1.talkMaxDuration = var_385_10

					if var_385_10 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_10 + var_385_4
					end
				end

				arg_382_1.text_.text = var_385_7
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_11 = math.max(var_385_5, arg_382_1.talkMaxDuration)

			if var_385_4 <= arg_382_1.time_ and arg_382_1.time_ < var_385_4 + var_385_11 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_4) / var_385_11

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_4 + var_385_11 and arg_382_1.time_ < var_385_4 + var_385_11 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play324531092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 324531092
		arg_386_1.duration_ = 6.67

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play324531093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = manager.ui.mainCamera.transform
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				local var_389_2 = arg_386_1.var_.effecteqweqe

				if var_389_2 then
					Object.Destroy(var_389_2)

					arg_386_1.var_.effecteqweqe = nil
				end
			end

			local var_389_3 = manager.ui.mainCamera.transform
			local var_389_4 = 0.366666666666667

			if var_389_4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				local var_389_5 = arg_386_1.var_.effect231
				local var_389_6
				local var_389_7 = var_389_3

				if not var_389_5 then
					var_389_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_389_7)
					var_389_5.name = "231"
					arg_386_1.var_.effect231 = var_389_5
				else
					var_389_5.transform:SetParent(var_389_7)
				end

				var_389_5.transform.localPosition = Vector3.New(0, 0, -0.09)
				var_389_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_389_8 = 0

			if var_389_8 < arg_386_1.time_ and arg_386_1.time_ <= var_389_8 + arg_389_0 then
				arg_386_1.mask_.enabled = true
				arg_386_1.mask_.raycastTarget = true

				arg_386_1:SetGaussion(false)
			end

			local var_389_9 = 0.766666666666667

			if var_389_8 <= arg_386_1.time_ and arg_386_1.time_ < var_389_8 + var_389_9 then
				local var_389_10 = (arg_386_1.time_ - var_389_8) / var_389_9
				local var_389_11 = Color.New(1, 1, 1)

				var_389_11.a = Mathf.Lerp(1, 0, var_389_10)
				arg_386_1.mask_.color = var_389_11
			end

			if arg_386_1.time_ >= var_389_8 + var_389_9 and arg_386_1.time_ < var_389_8 + var_389_9 + arg_389_0 then
				local var_389_12 = Color.New(1, 1, 1)
				local var_389_13 = 0

				arg_386_1.mask_.enabled = false
				var_389_12.a = var_389_13
				arg_386_1.mask_.color = var_389_12
			end

			local var_389_14 = 0

			if var_389_14 < arg_386_1.time_ and arg_386_1.time_ <= var_389_14 + arg_389_0 then
				arg_386_1.allBtn_.enabled = false
			end

			local var_389_15 = 2.23333333333333

			if arg_386_1.time_ >= var_389_14 + var_389_15 and arg_386_1.time_ < var_389_14 + var_389_15 + arg_389_0 then
				arg_386_1.allBtn_.enabled = true
			end

			if arg_386_1.frameCnt_ <= 1 then
				arg_386_1.dialog_:SetActive(false)
			end

			local var_389_16 = 1.66666666666667
			local var_389_17 = 0.8

			if var_389_16 < arg_386_1.time_ and arg_386_1.time_ <= var_389_16 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0

				arg_386_1.dialog_:SetActive(true)

				arg_386_1.dialogCg_.alpha = 0

				local var_389_18 = LeanTween.value(arg_386_1.dialog_, 0, 1, 0.3)

				var_389_18:setOnUpdate(LuaHelper.FloatAction(function(arg_390_0)
					arg_386_1.dialogCg_.alpha = arg_390_0
				end))
				var_389_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_386_1.dialog_)
					var_389_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_386_1.duration_ = arg_386_1.duration_ + 0.3

				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_19 = arg_386_1:GetWordFromCfg(324531092)
				local var_389_20 = arg_386_1:FormatText(var_389_19.content)

				arg_386_1.text_.text = var_389_20

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_21 = 32
				local var_389_22 = utf8.len(var_389_20)
				local var_389_23 = var_389_21 <= 0 and var_389_17 or var_389_17 * (var_389_22 / var_389_21)

				if var_389_23 > 0 and var_389_17 < var_389_23 then
					arg_386_1.talkMaxDuration = var_389_23
					var_389_16 = var_389_16 + 0.3

					if var_389_23 + var_389_16 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_23 + var_389_16
					end
				end

				arg_386_1.text_.text = var_389_20
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_24 = var_389_16 + 0.3
			local var_389_25 = math.max(var_389_17, arg_386_1.talkMaxDuration)

			if var_389_24 <= arg_386_1.time_ and arg_386_1.time_ < var_389_24 + var_389_25 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_24) / var_389_25

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_24 + var_389_25 and arg_386_1.time_ < var_389_24 + var_389_25 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play324531093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 324531093
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play324531094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 0.375

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_2 = arg_392_1:FormatText(StoryNameCfg[7].name)

				arg_392_1.leftNameTxt_.text = var_395_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_3 = arg_392_1:GetWordFromCfg(324531093)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 15
				local var_395_6 = utf8.len(var_395_4)
				local var_395_7 = var_395_5 <= 0 and var_395_1 or var_395_1 * (var_395_6 / var_395_5)

				if var_395_7 > 0 and var_395_1 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_0
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_8 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_8 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_8

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_8 and arg_392_1.time_ < var_395_0 + var_395_8 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play324531094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 324531094
		arg_396_1.duration_ = 3.43

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play324531095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["10170ui_story"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect10170ui_story == nil then
				arg_396_1.var_.characterEffect10170ui_story = var_399_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_2 = 0.200000002980232

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.characterEffect10170ui_story and not isNil(var_399_0) then
					arg_396_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.characterEffect10170ui_story then
				arg_396_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_399_4 = 0
			local var_399_5 = 0.375

			if var_399_4 < arg_396_1.time_ and arg_396_1.time_ <= var_399_4 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_6 = arg_396_1:FormatText(StoryNameCfg[1450].name)

				arg_396_1.leftNameTxt_.text = var_399_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_7 = arg_396_1:GetWordFromCfg(324531094)
				local var_399_8 = arg_396_1:FormatText(var_399_7.content)

				arg_396_1.text_.text = var_399_8

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_9 = 15
				local var_399_10 = utf8.len(var_399_8)
				local var_399_11 = var_399_9 <= 0 and var_399_5 or var_399_5 * (var_399_10 / var_399_9)

				if var_399_11 > 0 and var_399_5 < var_399_11 then
					arg_396_1.talkMaxDuration = var_399_11

					if var_399_11 + var_399_4 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_11 + var_399_4
					end
				end

				arg_396_1.text_.text = var_399_8
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531094", "story_v_out_324531.awb") ~= 0 then
					local var_399_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531094", "story_v_out_324531.awb") / 1000

					if var_399_12 + var_399_4 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_12 + var_399_4
					end

					if var_399_7.prefab_name ~= "" and arg_396_1.actors_[var_399_7.prefab_name] ~= nil then
						local var_399_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_7.prefab_name].transform, "story_v_out_324531", "324531094", "story_v_out_324531.awb")

						arg_396_1:RecordAudio("324531094", var_399_13)
						arg_396_1:RecordAudio("324531094", var_399_13)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_324531", "324531094", "story_v_out_324531.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_324531", "324531094", "story_v_out_324531.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_14 = math.max(var_399_5, arg_396_1.talkMaxDuration)

			if var_399_4 <= arg_396_1.time_ and arg_396_1.time_ < var_399_4 + var_399_14 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_4) / var_399_14

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_4 + var_399_14 and arg_396_1.time_ < var_399_4 + var_399_14 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play324531095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 324531095
		arg_400_1.duration_ = 2.6

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play324531096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0
			local var_403_1 = 0.25

			if var_403_0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_2 = arg_400_1:FormatText(StoryNameCfg[1450].name)

				arg_400_1.leftNameTxt_.text = var_403_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_3 = arg_400_1:GetWordFromCfg(324531095)
				local var_403_4 = arg_400_1:FormatText(var_403_3.content)

				arg_400_1.text_.text = var_403_4

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 10
				local var_403_6 = utf8.len(var_403_4)
				local var_403_7 = var_403_5 <= 0 and var_403_1 or var_403_1 * (var_403_6 / var_403_5)

				if var_403_7 > 0 and var_403_1 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_0
					end
				end

				arg_400_1.text_.text = var_403_4
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531095", "story_v_out_324531.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_324531", "324531095", "story_v_out_324531.awb") / 1000

					if var_403_8 + var_403_0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_0
					end

					if var_403_3.prefab_name ~= "" and arg_400_1.actors_[var_403_3.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_3.prefab_name].transform, "story_v_out_324531", "324531095", "story_v_out_324531.awb")

						arg_400_1:RecordAudio("324531095", var_403_9)
						arg_400_1:RecordAudio("324531095", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_324531", "324531095", "story_v_out_324531.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_324531", "324531095", "story_v_out_324531.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_1, arg_400_1.talkMaxDuration)

			if var_403_0 <= arg_400_1.time_ and arg_400_1.time_ < var_403_0 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_0) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_0 + var_403_10 and arg_400_1.time_ < var_403_0 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play324531096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 324531096
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play324531097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["10170ui_story"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect10170ui_story == nil then
				arg_404_1.var_.characterEffect10170ui_story = var_407_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.characterEffect10170ui_story and not isNil(var_407_0) then
					local var_407_4 = Mathf.Lerp(0, 0.5, var_407_3)

					arg_404_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_404_1.var_.characterEffect10170ui_story.fillRatio = var_407_4
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.characterEffect10170ui_story then
				local var_407_5 = 0.5

				arg_404_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_404_1.var_.characterEffect10170ui_story.fillRatio = var_407_5
			end

			local var_407_6 = 0
			local var_407_7 = 0.075

			if var_407_6 < arg_404_1.time_ and arg_404_1.time_ <= var_407_6 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_8 = arg_404_1:FormatText(StoryNameCfg[7].name)

				arg_404_1.leftNameTxt_.text = var_407_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_9 = arg_404_1:GetWordFromCfg(324531096)
				local var_407_10 = arg_404_1:FormatText(var_407_9.content)

				arg_404_1.text_.text = var_407_10

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_11 = 3
				local var_407_12 = utf8.len(var_407_10)
				local var_407_13 = var_407_11 <= 0 and var_407_7 or var_407_7 * (var_407_12 / var_407_11)

				if var_407_13 > 0 and var_407_7 < var_407_13 then
					arg_404_1.talkMaxDuration = var_407_13

					if var_407_13 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_13 + var_407_6
					end
				end

				arg_404_1.text_.text = var_407_10
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_14 = math.max(var_407_7, arg_404_1.talkMaxDuration)

			if var_407_6 <= arg_404_1.time_ and arg_404_1.time_ < var_407_6 + var_407_14 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_6) / var_407_14

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_6 + var_407_14 and arg_404_1.time_ < var_407_6 + var_407_14 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play324531097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 324531097
		arg_408_1.duration_ = 6

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play324531098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.bgs_.MS2406a.transform
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.var_.moveOldPosMS2406a = var_411_0.localPosition
			end

			local var_411_2 = 2.03333333333333

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2
				local var_411_4 = Vector3.New(0, 1, 8)

				var_411_0.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPosMS2406a, var_411_4, var_411_3)
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 then
				var_411_0.localPosition = Vector3.New(0, 1, 8)
			end

			local var_411_5 = 0

			if var_411_5 < arg_408_1.time_ and arg_408_1.time_ <= var_411_5 + arg_411_0 then
				arg_408_1.allBtn_.enabled = false
			end

			local var_411_6 = 1.625

			if arg_408_1.time_ >= var_411_5 + var_411_6 and arg_408_1.time_ < var_411_5 + var_411_6 + arg_411_0 then
				arg_408_1.allBtn_.enabled = true
			end

			if arg_408_1.frameCnt_ <= 1 then
				arg_408_1.dialog_:SetActive(false)
			end

			local var_411_7 = 1
			local var_411_8 = 0.825

			if var_411_7 < arg_408_1.time_ and arg_408_1.time_ <= var_411_7 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0

				arg_408_1.dialog_:SetActive(true)

				arg_408_1.dialogCg_.alpha = 0

				local var_411_9 = LeanTween.value(arg_408_1.dialog_, 0, 1, 0.3)

				var_411_9:setOnUpdate(LuaHelper.FloatAction(function(arg_412_0)
					arg_408_1.dialogCg_.alpha = arg_412_0
				end))
				var_411_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_408_1.dialog_)
					var_411_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_408_1.duration_ = arg_408_1.duration_ + 0.3

				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_10 = arg_408_1:GetWordFromCfg(324531097)
				local var_411_11 = arg_408_1:FormatText(var_411_10.content)

				arg_408_1.text_.text = var_411_11

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_12 = 33
				local var_411_13 = utf8.len(var_411_11)
				local var_411_14 = var_411_12 <= 0 and var_411_8 or var_411_8 * (var_411_13 / var_411_12)

				if var_411_14 > 0 and var_411_8 < var_411_14 then
					arg_408_1.talkMaxDuration = var_411_14
					var_411_7 = var_411_7 + 0.3

					if var_411_14 + var_411_7 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_14 + var_411_7
					end
				end

				arg_408_1.text_.text = var_411_11
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_15 = var_411_7 + 0.3
			local var_411_16 = math.max(var_411_8, arg_408_1.talkMaxDuration)

			if var_411_15 <= arg_408_1.time_ and arg_408_1.time_ < var_411_15 + var_411_16 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_15) / var_411_16

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_15 + var_411_16 and arg_408_1.time_ < var_411_15 + var_411_16 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2406a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.03333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0.31, 5),
					endPos = Vector3.New(0, 1, 8),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play324531098 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 324531098
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play324531099(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 1.075

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[7].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_3 = arg_414_1:GetWordFromCfg(324531098)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 43
				local var_417_6 = utf8.len(var_417_4)
				local var_417_7 = var_417_5 <= 0 and var_417_1 or var_417_1 * (var_417_6 / var_417_5)

				if var_417_7 > 0 and var_417_1 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_8 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_8 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_8

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_8 and arg_414_1.time_ < var_417_0 + var_417_8 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play324531099 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 324531099
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play324531100(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 1.15

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

				local var_421_2 = arg_418_1:GetWordFromCfg(324531099)
				local var_421_3 = arg_418_1:FormatText(var_421_2.content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 46
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
	Play324531100 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 324531100
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play324531101(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0
			local var_425_1 = 1

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_2 = arg_422_1:GetWordFromCfg(324531100)
				local var_425_3 = arg_422_1:FormatText(var_425_2.content)

				arg_422_1.text_.text = var_425_3

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 40
				local var_425_5 = utf8.len(var_425_3)
				local var_425_6 = var_425_4 <= 0 and var_425_1 or var_425_1 * (var_425_5 / var_425_4)

				if var_425_6 > 0 and var_425_1 < var_425_6 then
					arg_422_1.talkMaxDuration = var_425_6

					if var_425_6 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_3
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_7 and arg_422_1.time_ < var_425_0 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play324531101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 324531101
		arg_426_1.duration_ = 1.43

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play324531102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["10170ui_story"]
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect10170ui_story == nil then
				arg_426_1.var_.characterEffect10170ui_story = var_429_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.200000002980232

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 and not isNil(var_429_0) then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2

				if arg_426_1.var_.characterEffect10170ui_story and not isNil(var_429_0) then
					arg_426_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect10170ui_story then
				arg_426_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_429_4 = 0
			local var_429_5 = 0.15

			if var_429_4 < arg_426_1.time_ and arg_426_1.time_ <= var_429_4 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_6 = arg_426_1:FormatText(StoryNameCfg[1450].name)

				arg_426_1.leftNameTxt_.text = var_429_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_7 = arg_426_1:GetWordFromCfg(324531101)
				local var_429_8 = arg_426_1:FormatText(var_429_7.content)

				arg_426_1.text_.text = var_429_8

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_9 = 6
				local var_429_10 = utf8.len(var_429_8)
				local var_429_11 = var_429_9 <= 0 and var_429_5 or var_429_5 * (var_429_10 / var_429_9)

				if var_429_11 > 0 and var_429_5 < var_429_11 then
					arg_426_1.talkMaxDuration = var_429_11

					if var_429_11 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_11 + var_429_4
					end
				end

				arg_426_1.text_.text = var_429_8
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531101", "story_v_out_324531.awb") ~= 0 then
					local var_429_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531101", "story_v_out_324531.awb") / 1000

					if var_429_12 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_12 + var_429_4
					end

					if var_429_7.prefab_name ~= "" and arg_426_1.actors_[var_429_7.prefab_name] ~= nil then
						local var_429_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_7.prefab_name].transform, "story_v_out_324531", "324531101", "story_v_out_324531.awb")

						arg_426_1:RecordAudio("324531101", var_429_13)
						arg_426_1:RecordAudio("324531101", var_429_13)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_324531", "324531101", "story_v_out_324531.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_324531", "324531101", "story_v_out_324531.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_14 = math.max(var_429_5, arg_426_1.talkMaxDuration)

			if var_429_4 <= arg_426_1.time_ and arg_426_1.time_ < var_429_4 + var_429_14 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_4) / var_429_14

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_4 + var_429_14 and arg_426_1.time_ < var_429_4 + var_429_14 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play324531102 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 324531102
		arg_430_1.duration_ = 1

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"

			SetActive(arg_430_1.choicesGo_, true)

			for iter_431_0, iter_431_1 in ipairs(arg_430_1.choices_) do
				local var_431_0 = iter_431_0 <= 3

				SetActive(iter_431_1.go, var_431_0)
			end

			arg_430_1.choices_[1].txt.text = arg_430_1:FormatText(StoryChoiceCfg[1615].name)
			arg_430_1.choices_[2].txt.text = arg_430_1:FormatText(StoryChoiceCfg[1616].name)
			arg_430_1.choices_[3].txt.text = arg_430_1:FormatText(StoryChoiceCfg[1617].name)
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play324531103(arg_430_1)
			end

			if arg_432_0 == 2 then
				arg_430_0:Play324531106(arg_430_1)
			end

			if arg_432_0 == 3 then
				arg_430_0:Play324531108(arg_430_1)
			end

			arg_430_1:RecordChoiceLog(324531102, 1615, 1616, 1617)
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["10170ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect10170ui_story == nil then
				arg_430_1.var_.characterEffect10170ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect10170ui_story and not isNil(var_433_0) then
					local var_433_4 = Mathf.Lerp(0, 0.5, var_433_3)

					arg_430_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_430_1.var_.characterEffect10170ui_story.fillRatio = var_433_4
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect10170ui_story then
				local var_433_5 = 0.5

				arg_430_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_430_1.var_.characterEffect10170ui_story.fillRatio = var_433_5
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play324531103 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 324531103
		arg_434_1.duration_ = 1.2

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play324531104(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["10170ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect10170ui_story == nil then
				arg_434_1.var_.characterEffect10170ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect10170ui_story and not isNil(var_437_0) then
					arg_434_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect10170ui_story then
				arg_434_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_437_4 = 0
			local var_437_5 = 0.1

			if var_437_4 < arg_434_1.time_ and arg_434_1.time_ <= var_437_4 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_6 = arg_434_1:FormatText(StoryNameCfg[1450].name)

				arg_434_1.leftNameTxt_.text = var_437_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_7 = arg_434_1:GetWordFromCfg(324531103)
				local var_437_8 = arg_434_1:FormatText(var_437_7.content)

				arg_434_1.text_.text = var_437_8

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_9 = 4
				local var_437_10 = utf8.len(var_437_8)
				local var_437_11 = var_437_9 <= 0 and var_437_5 or var_437_5 * (var_437_10 / var_437_9)

				if var_437_11 > 0 and var_437_5 < var_437_11 then
					arg_434_1.talkMaxDuration = var_437_11

					if var_437_11 + var_437_4 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_11 + var_437_4
					end
				end

				arg_434_1.text_.text = var_437_8
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531103", "story_v_out_324531.awb") ~= 0 then
					local var_437_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531103", "story_v_out_324531.awb") / 1000

					if var_437_12 + var_437_4 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_12 + var_437_4
					end

					if var_437_7.prefab_name ~= "" and arg_434_1.actors_[var_437_7.prefab_name] ~= nil then
						local var_437_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_7.prefab_name].transform, "story_v_out_324531", "324531103", "story_v_out_324531.awb")

						arg_434_1:RecordAudio("324531103", var_437_13)
						arg_434_1:RecordAudio("324531103", var_437_13)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_324531", "324531103", "story_v_out_324531.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_324531", "324531103", "story_v_out_324531.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_14 = math.max(var_437_5, arg_434_1.talkMaxDuration)

			if var_437_4 <= arg_434_1.time_ and arg_434_1.time_ < var_437_4 + var_437_14 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_4) / var_437_14

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_4 + var_437_14 and arg_434_1.time_ < var_437_4 + var_437_14 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play324531104 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 324531104
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play324531105(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["10170ui_story"]
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect10170ui_story == nil then
				arg_438_1.var_.characterEffect10170ui_story = var_441_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 and not isNil(var_441_0) then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2

				if arg_438_1.var_.characterEffect10170ui_story and not isNil(var_441_0) then
					local var_441_4 = Mathf.Lerp(0, 0.5, var_441_3)

					arg_438_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_438_1.var_.characterEffect10170ui_story.fillRatio = var_441_4
				end
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 and not isNil(var_441_0) and arg_438_1.var_.characterEffect10170ui_story then
				local var_441_5 = 0.5

				arg_438_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_438_1.var_.characterEffect10170ui_story.fillRatio = var_441_5
			end

			local var_441_6 = 0
			local var_441_7 = 0.7

			if var_441_6 < arg_438_1.time_ and arg_438_1.time_ <= var_441_6 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_8 = arg_438_1:FormatText(StoryNameCfg[7].name)

				arg_438_1.leftNameTxt_.text = var_441_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_9 = arg_438_1:GetWordFromCfg(324531104)
				local var_441_10 = arg_438_1:FormatText(var_441_9.content)

				arg_438_1.text_.text = var_441_10

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_11 = 28
				local var_441_12 = utf8.len(var_441_10)
				local var_441_13 = var_441_11 <= 0 and var_441_7 or var_441_7 * (var_441_12 / var_441_11)

				if var_441_13 > 0 and var_441_7 < var_441_13 then
					arg_438_1.talkMaxDuration = var_441_13

					if var_441_13 + var_441_6 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_13 + var_441_6
					end
				end

				arg_438_1.text_.text = var_441_10
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_14 = math.max(var_441_7, arg_438_1.talkMaxDuration)

			if var_441_6 <= arg_438_1.time_ and arg_438_1.time_ < var_441_6 + var_441_14 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_6) / var_441_14

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_6 + var_441_14 and arg_438_1.time_ < var_441_6 + var_441_14 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play324531105 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 324531105
		arg_442_1.duration_ = 5

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play324531110(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0
			local var_445_1 = 0.725

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_2 = arg_442_1:FormatText(StoryNameCfg[7].name)

				arg_442_1.leftNameTxt_.text = var_445_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_3 = arg_442_1:GetWordFromCfg(324531105)
				local var_445_4 = arg_442_1:FormatText(var_445_3.content)

				arg_442_1.text_.text = var_445_4

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 29
				local var_445_6 = utf8.len(var_445_4)
				local var_445_7 = var_445_5 <= 0 and var_445_1 or var_445_1 * (var_445_6 / var_445_5)

				if var_445_7 > 0 and var_445_1 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_4
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)
				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_8 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_8 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_8

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_8 and arg_442_1.time_ < var_445_0 + var_445_8 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play324531110 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 324531110
		arg_446_1.duration_ = 1.3

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play324531111(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["10170ui_story"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect10170ui_story == nil then
				arg_446_1.var_.characterEffect10170ui_story = var_449_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.characterEffect10170ui_story and not isNil(var_449_0) then
					arg_446_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.characterEffect10170ui_story then
				arg_446_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_449_4 = 0
			local var_449_5 = 0.125

			if var_449_4 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_6 = arg_446_1:FormatText(StoryNameCfg[1450].name)

				arg_446_1.leftNameTxt_.text = var_449_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_7 = arg_446_1:GetWordFromCfg(324531110)
				local var_449_8 = arg_446_1:FormatText(var_449_7.content)

				arg_446_1.text_.text = var_449_8

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_9 = 5
				local var_449_10 = utf8.len(var_449_8)
				local var_449_11 = var_449_9 <= 0 and var_449_5 or var_449_5 * (var_449_10 / var_449_9)

				if var_449_11 > 0 and var_449_5 < var_449_11 then
					arg_446_1.talkMaxDuration = var_449_11

					if var_449_11 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_11 + var_449_4
					end
				end

				arg_446_1.text_.text = var_449_8
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531110", "story_v_out_324531.awb") ~= 0 then
					local var_449_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531110", "story_v_out_324531.awb") / 1000

					if var_449_12 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_12 + var_449_4
					end

					if var_449_7.prefab_name ~= "" and arg_446_1.actors_[var_449_7.prefab_name] ~= nil then
						local var_449_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_7.prefab_name].transform, "story_v_out_324531", "324531110", "story_v_out_324531.awb")

						arg_446_1:RecordAudio("324531110", var_449_13)
						arg_446_1:RecordAudio("324531110", var_449_13)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_324531", "324531110", "story_v_out_324531.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_324531", "324531110", "story_v_out_324531.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_14 = math.max(var_449_5, arg_446_1.talkMaxDuration)

			if var_449_4 <= arg_446_1.time_ and arg_446_1.time_ < var_449_4 + var_449_14 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_4) / var_449_14

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_4 + var_449_14 and arg_446_1.time_ < var_449_4 + var_449_14 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play324531111 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 324531111
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play324531112(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["10170ui_story"]
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.characterEffect10170ui_story == nil then
				arg_450_1.var_.characterEffect10170ui_story = var_453_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_2 = 0.200000002980232

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 and not isNil(var_453_0) then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2

				if arg_450_1.var_.characterEffect10170ui_story and not isNil(var_453_0) then
					local var_453_4 = Mathf.Lerp(0, 0.5, var_453_3)

					arg_450_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_450_1.var_.characterEffect10170ui_story.fillRatio = var_453_4
				end
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.characterEffect10170ui_story then
				local var_453_5 = 0.5

				arg_450_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_450_1.var_.characterEffect10170ui_story.fillRatio = var_453_5
			end

			local var_453_6 = 0
			local var_453_7 = 0.05

			if var_453_6 < arg_450_1.time_ and arg_450_1.time_ <= var_453_6 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_8 = arg_450_1:FormatText(StoryNameCfg[7].name)

				arg_450_1.leftNameTxt_.text = var_453_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_9 = arg_450_1:GetWordFromCfg(324531111)
				local var_453_10 = arg_450_1:FormatText(var_453_9.content)

				arg_450_1.text_.text = var_453_10

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_11 = 2
				local var_453_12 = utf8.len(var_453_10)
				local var_453_13 = var_453_11 <= 0 and var_453_7 or var_453_7 * (var_453_12 / var_453_11)

				if var_453_13 > 0 and var_453_7 < var_453_13 then
					arg_450_1.talkMaxDuration = var_453_13

					if var_453_13 + var_453_6 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_13 + var_453_6
					end
				end

				arg_450_1.text_.text = var_453_10
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_14 = math.max(var_453_7, arg_450_1.talkMaxDuration)

			if var_453_6 <= arg_450_1.time_ and arg_450_1.time_ < var_453_6 + var_453_14 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_6) / var_453_14

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_6 + var_453_14 and arg_450_1.time_ < var_453_6 + var_453_14 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play324531112 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 324531112
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play324531113(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0
			local var_457_1 = 1.1

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

				local var_457_2 = arg_454_1:GetWordFromCfg(324531112)
				local var_457_3 = arg_454_1:FormatText(var_457_2.content)

				arg_454_1.text_.text = var_457_3

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_4 = 44
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
	Play324531113 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 324531113
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play324531114(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 0
			local var_461_1 = 0.775

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_2 = arg_458_1:GetWordFromCfg(324531113)
				local var_461_3 = arg_458_1:FormatText(var_461_2.content)

				arg_458_1.text_.text = var_461_3

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_4 = 31
				local var_461_5 = utf8.len(var_461_3)
				local var_461_6 = var_461_4 <= 0 and var_461_1 or var_461_1 * (var_461_5 / var_461_4)

				if var_461_6 > 0 and var_461_1 < var_461_6 then
					arg_458_1.talkMaxDuration = var_461_6

					if var_461_6 + var_461_0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_6 + var_461_0
					end
				end

				arg_458_1.text_.text = var_461_3
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_7 = math.max(var_461_1, arg_458_1.talkMaxDuration)

			if var_461_0 <= arg_458_1.time_ and arg_458_1.time_ < var_461_0 + var_461_7 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_0) / var_461_7

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_0 + var_461_7 and arg_458_1.time_ < var_461_0 + var_461_7 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play324531114 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 324531114
		arg_462_1.duration_ = 1.37

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play324531115(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["10170ui_story"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect10170ui_story == nil then
				arg_462_1.var_.characterEffect10170ui_story = var_465_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.200000002980232

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.characterEffect10170ui_story and not isNil(var_465_0) then
					arg_462_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect10170ui_story then
				arg_462_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_465_4 = 0
			local var_465_5 = 0.125

			if var_465_4 < arg_462_1.time_ and arg_462_1.time_ <= var_465_4 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_6 = arg_462_1:FormatText(StoryNameCfg[1450].name)

				arg_462_1.leftNameTxt_.text = var_465_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_7 = arg_462_1:GetWordFromCfg(324531114)
				local var_465_8 = arg_462_1:FormatText(var_465_7.content)

				arg_462_1.text_.text = var_465_8

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_9 = 5
				local var_465_10 = utf8.len(var_465_8)
				local var_465_11 = var_465_9 <= 0 and var_465_5 or var_465_5 * (var_465_10 / var_465_9)

				if var_465_11 > 0 and var_465_5 < var_465_11 then
					arg_462_1.talkMaxDuration = var_465_11

					if var_465_11 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_11 + var_465_4
					end
				end

				arg_462_1.text_.text = var_465_8
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531114", "story_v_out_324531.awb") ~= 0 then
					local var_465_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531114", "story_v_out_324531.awb") / 1000

					if var_465_12 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_12 + var_465_4
					end

					if var_465_7.prefab_name ~= "" and arg_462_1.actors_[var_465_7.prefab_name] ~= nil then
						local var_465_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_7.prefab_name].transform, "story_v_out_324531", "324531114", "story_v_out_324531.awb")

						arg_462_1:RecordAudio("324531114", var_465_13)
						arg_462_1:RecordAudio("324531114", var_465_13)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_out_324531", "324531114", "story_v_out_324531.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_out_324531", "324531114", "story_v_out_324531.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_14 = math.max(var_465_5, arg_462_1.talkMaxDuration)

			if var_465_4 <= arg_462_1.time_ and arg_462_1.time_ < var_465_4 + var_465_14 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_4) / var_465_14

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_4 + var_465_14 and arg_462_1.time_ < var_465_4 + var_465_14 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play324531115 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 324531115
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play324531116(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["10170ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect10170ui_story == nil then
				arg_466_1.var_.characterEffect10170ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect10170ui_story and not isNil(var_469_0) then
					local var_469_4 = Mathf.Lerp(0, 0.5, var_469_3)

					arg_466_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_466_1.var_.characterEffect10170ui_story.fillRatio = var_469_4
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect10170ui_story then
				local var_469_5 = 0.5

				arg_466_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_466_1.var_.characterEffect10170ui_story.fillRatio = var_469_5
			end

			local var_469_6 = 0
			local var_469_7 = 0.625

			if var_469_6 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_8 = arg_466_1:FormatText(StoryNameCfg[7].name)

				arg_466_1.leftNameTxt_.text = var_469_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_9 = arg_466_1:GetWordFromCfg(324531115)
				local var_469_10 = arg_466_1:FormatText(var_469_9.content)

				arg_466_1.text_.text = var_469_10

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_11 = 25
				local var_469_12 = utf8.len(var_469_10)
				local var_469_13 = var_469_11 <= 0 and var_469_7 or var_469_7 * (var_469_12 / var_469_11)

				if var_469_13 > 0 and var_469_7 < var_469_13 then
					arg_466_1.talkMaxDuration = var_469_13

					if var_469_13 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_13 + var_469_6
					end
				end

				arg_466_1.text_.text = var_469_10
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_14 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_14 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_14

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_14 and arg_466_1.time_ < var_469_6 + var_469_14 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play324531116 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 324531116
		arg_470_1.duration_ = 3.53

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play324531117(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["10170ui_story"]
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect10170ui_story == nil then
				arg_470_1.var_.characterEffect10170ui_story = var_473_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 and not isNil(var_473_0) then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2

				if arg_470_1.var_.characterEffect10170ui_story and not isNil(var_473_0) then
					arg_470_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect10170ui_story then
				arg_470_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_473_4 = 0
			local var_473_5 = 0.475

			if var_473_4 < arg_470_1.time_ and arg_470_1.time_ <= var_473_4 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_6 = arg_470_1:FormatText(StoryNameCfg[1450].name)

				arg_470_1.leftNameTxt_.text = var_473_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_7 = arg_470_1:GetWordFromCfg(324531116)
				local var_473_8 = arg_470_1:FormatText(var_473_7.content)

				arg_470_1.text_.text = var_473_8

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_9 = 19
				local var_473_10 = utf8.len(var_473_8)
				local var_473_11 = var_473_9 <= 0 and var_473_5 or var_473_5 * (var_473_10 / var_473_9)

				if var_473_11 > 0 and var_473_5 < var_473_11 then
					arg_470_1.talkMaxDuration = var_473_11

					if var_473_11 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_11 + var_473_4
					end
				end

				arg_470_1.text_.text = var_473_8
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531116", "story_v_out_324531.awb") ~= 0 then
					local var_473_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531116", "story_v_out_324531.awb") / 1000

					if var_473_12 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_12 + var_473_4
					end

					if var_473_7.prefab_name ~= "" and arg_470_1.actors_[var_473_7.prefab_name] ~= nil then
						local var_473_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_7.prefab_name].transform, "story_v_out_324531", "324531116", "story_v_out_324531.awb")

						arg_470_1:RecordAudio("324531116", var_473_13)
						arg_470_1:RecordAudio("324531116", var_473_13)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_324531", "324531116", "story_v_out_324531.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_324531", "324531116", "story_v_out_324531.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_14 = math.max(var_473_5, arg_470_1.talkMaxDuration)

			if var_473_4 <= arg_470_1.time_ and arg_470_1.time_ < var_473_4 + var_473_14 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_4) / var_473_14

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_4 + var_473_14 and arg_470_1.time_ < var_473_4 + var_473_14 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play324531117 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 324531117
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play324531118(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["10170ui_story"]
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect10170ui_story == nil then
				arg_474_1.var_.characterEffect10170ui_story = var_477_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 and not isNil(var_477_0) then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2

				if arg_474_1.var_.characterEffect10170ui_story and not isNil(var_477_0) then
					local var_477_4 = Mathf.Lerp(0, 0.5, var_477_3)

					arg_474_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_474_1.var_.characterEffect10170ui_story.fillRatio = var_477_4
				end
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect10170ui_story then
				local var_477_5 = 0.5

				arg_474_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_474_1.var_.characterEffect10170ui_story.fillRatio = var_477_5
			end

			local var_477_6 = 0
			local var_477_7 = 0.425

			if var_477_6 < arg_474_1.time_ and arg_474_1.time_ <= var_477_6 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_8 = arg_474_1:FormatText(StoryNameCfg[7].name)

				arg_474_1.leftNameTxt_.text = var_477_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_9 = arg_474_1:GetWordFromCfg(324531117)
				local var_477_10 = arg_474_1:FormatText(var_477_9.content)

				arg_474_1.text_.text = var_477_10

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_11 = 17
				local var_477_12 = utf8.len(var_477_10)
				local var_477_13 = var_477_11 <= 0 and var_477_7 or var_477_7 * (var_477_12 / var_477_11)

				if var_477_13 > 0 and var_477_7 < var_477_13 then
					arg_474_1.talkMaxDuration = var_477_13

					if var_477_13 + var_477_6 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_13 + var_477_6
					end
				end

				arg_474_1.text_.text = var_477_10
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_14 = math.max(var_477_7, arg_474_1.talkMaxDuration)

			if var_477_6 <= arg_474_1.time_ and arg_474_1.time_ < var_477_6 + var_477_14 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_6) / var_477_14

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_6 + var_477_14 and arg_474_1.time_ < var_477_6 + var_477_14 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play324531118 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 324531118
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play324531119(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 0.9

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_2 = arg_478_1:GetWordFromCfg(324531118)
				local var_481_3 = arg_478_1:FormatText(var_481_2.content)

				arg_478_1.text_.text = var_481_3

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_4 = 36
				local var_481_5 = utf8.len(var_481_3)
				local var_481_6 = var_481_4 <= 0 and var_481_1 or var_481_1 * (var_481_5 / var_481_4)

				if var_481_6 > 0 and var_481_1 < var_481_6 then
					arg_478_1.talkMaxDuration = var_481_6

					if var_481_6 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_6 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_3
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_7 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_7 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_7

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_7 and arg_478_1.time_ < var_481_0 + var_481_7 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play324531119 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 324531119
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play324531120(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.55

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[7].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_3 = arg_482_1:GetWordFromCfg(324531119)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 22
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_8 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_8 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_8

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_8 and arg_482_1.time_ < var_485_0 + var_485_8 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play324531120 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 324531120
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play324531121(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 0.8

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_2 = arg_486_1:GetWordFromCfg(324531120)
				local var_489_3 = arg_486_1:FormatText(var_489_2.content)

				arg_486_1.text_.text = var_489_3

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_4 = 32
				local var_489_5 = utf8.len(var_489_3)
				local var_489_6 = var_489_4 <= 0 and var_489_1 or var_489_1 * (var_489_5 / var_489_4)

				if var_489_6 > 0 and var_489_1 < var_489_6 then
					arg_486_1.talkMaxDuration = var_489_6

					if var_489_6 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_6 + var_489_0
					end
				end

				arg_486_1.text_.text = var_489_3
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_7 and arg_486_1.time_ < var_489_0 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play324531121 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 324531121
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play324531122(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0
			local var_493_1 = 1.225

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, false)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_2 = arg_490_1:GetWordFromCfg(324531121)
				local var_493_3 = arg_490_1:FormatText(var_493_2.content)

				arg_490_1.text_.text = var_493_3

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_4 = 49
				local var_493_5 = utf8.len(var_493_3)
				local var_493_6 = var_493_4 <= 0 and var_493_1 or var_493_1 * (var_493_5 / var_493_4)

				if var_493_6 > 0 and var_493_1 < var_493_6 then
					arg_490_1.talkMaxDuration = var_493_6

					if var_493_6 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_6 + var_493_0
					end
				end

				arg_490_1.text_.text = var_493_3
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_7 = math.max(var_493_1, arg_490_1.talkMaxDuration)

			if var_493_0 <= arg_490_1.time_ and arg_490_1.time_ < var_493_0 + var_493_7 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_0) / var_493_7

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_0 + var_493_7 and arg_490_1.time_ < var_493_0 + var_493_7 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play324531122 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 324531122
		arg_494_1.duration_ = 3.13

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play324531123(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["10170ui_story"]
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect10170ui_story == nil then
				arg_494_1.var_.characterEffect10170ui_story = var_497_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.200000002980232

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 and not isNil(var_497_0) then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2

				if arg_494_1.var_.characterEffect10170ui_story and not isNil(var_497_0) then
					arg_494_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect10170ui_story then
				arg_494_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_497_4 = 0
			local var_497_5 = 0.275

			if var_497_4 < arg_494_1.time_ and arg_494_1.time_ <= var_497_4 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_6 = arg_494_1:FormatText(StoryNameCfg[1450].name)

				arg_494_1.leftNameTxt_.text = var_497_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_7 = arg_494_1:GetWordFromCfg(324531122)
				local var_497_8 = arg_494_1:FormatText(var_497_7.content)

				arg_494_1.text_.text = var_497_8

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_9 = 11
				local var_497_10 = utf8.len(var_497_8)
				local var_497_11 = var_497_9 <= 0 and var_497_5 or var_497_5 * (var_497_10 / var_497_9)

				if var_497_11 > 0 and var_497_5 < var_497_11 then
					arg_494_1.talkMaxDuration = var_497_11

					if var_497_11 + var_497_4 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_11 + var_497_4
					end
				end

				arg_494_1.text_.text = var_497_8
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531122", "story_v_out_324531.awb") ~= 0 then
					local var_497_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531122", "story_v_out_324531.awb") / 1000

					if var_497_12 + var_497_4 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_12 + var_497_4
					end

					if var_497_7.prefab_name ~= "" and arg_494_1.actors_[var_497_7.prefab_name] ~= nil then
						local var_497_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_7.prefab_name].transform, "story_v_out_324531", "324531122", "story_v_out_324531.awb")

						arg_494_1:RecordAudio("324531122", var_497_13)
						arg_494_1:RecordAudio("324531122", var_497_13)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_324531", "324531122", "story_v_out_324531.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_324531", "324531122", "story_v_out_324531.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_14 = math.max(var_497_5, arg_494_1.talkMaxDuration)

			if var_497_4 <= arg_494_1.time_ and arg_494_1.time_ < var_497_4 + var_497_14 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_4) / var_497_14

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_4 + var_497_14 and arg_494_1.time_ < var_497_4 + var_497_14 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play324531123 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 324531123
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play324531124(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["10170ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect10170ui_story == nil then
				arg_498_1.var_.characterEffect10170ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect10170ui_story and not isNil(var_501_0) then
					local var_501_4 = Mathf.Lerp(0, 0.5, var_501_3)

					arg_498_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_498_1.var_.characterEffect10170ui_story.fillRatio = var_501_4
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect10170ui_story then
				local var_501_5 = 0.5

				arg_498_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_498_1.var_.characterEffect10170ui_story.fillRatio = var_501_5
			end

			local var_501_6 = 0
			local var_501_7 = 0.6

			if var_501_6 < arg_498_1.time_ and arg_498_1.time_ <= var_501_6 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_8 = arg_498_1:FormatText(StoryNameCfg[7].name)

				arg_498_1.leftNameTxt_.text = var_501_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_9 = arg_498_1:GetWordFromCfg(324531123)
				local var_501_10 = arg_498_1:FormatText(var_501_9.content)

				arg_498_1.text_.text = var_501_10

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_11 = 24
				local var_501_12 = utf8.len(var_501_10)
				local var_501_13 = var_501_11 <= 0 and var_501_7 or var_501_7 * (var_501_12 / var_501_11)

				if var_501_13 > 0 and var_501_7 < var_501_13 then
					arg_498_1.talkMaxDuration = var_501_13

					if var_501_13 + var_501_6 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_13 + var_501_6
					end
				end

				arg_498_1.text_.text = var_501_10
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_14 = math.max(var_501_7, arg_498_1.talkMaxDuration)

			if var_501_6 <= arg_498_1.time_ and arg_498_1.time_ < var_501_6 + var_501_14 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_6) / var_501_14

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_6 + var_501_14 and arg_498_1.time_ < var_501_6 + var_501_14 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play324531124 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 324531124
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play324531125(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0
			local var_505_1 = 1.05

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_2 = arg_502_1:GetWordFromCfg(324531124)
				local var_505_3 = arg_502_1:FormatText(var_505_2.content)

				arg_502_1.text_.text = var_505_3

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_4 = 42
				local var_505_5 = utf8.len(var_505_3)
				local var_505_6 = var_505_4 <= 0 and var_505_1 or var_505_1 * (var_505_5 / var_505_4)

				if var_505_6 > 0 and var_505_1 < var_505_6 then
					arg_502_1.talkMaxDuration = var_505_6

					if var_505_6 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_6 + var_505_0
					end
				end

				arg_502_1.text_.text = var_505_3
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_7 = math.max(var_505_1, arg_502_1.talkMaxDuration)

			if var_505_0 <= arg_502_1.time_ and arg_502_1.time_ < var_505_0 + var_505_7 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_0) / var_505_7

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_0 + var_505_7 and arg_502_1.time_ < var_505_0 + var_505_7 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play324531125 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 324531125
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play324531126(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0
			local var_509_1 = 1.225

			if var_509_0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_2 = arg_506_1:GetWordFromCfg(324531125)
				local var_509_3 = arg_506_1:FormatText(var_509_2.content)

				arg_506_1.text_.text = var_509_3

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_4 = 49
				local var_509_5 = utf8.len(var_509_3)
				local var_509_6 = var_509_4 <= 0 and var_509_1 or var_509_1 * (var_509_5 / var_509_4)

				if var_509_6 > 0 and var_509_1 < var_509_6 then
					arg_506_1.talkMaxDuration = var_509_6

					if var_509_6 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_6 + var_509_0
					end
				end

				arg_506_1.text_.text = var_509_3
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_7 = math.max(var_509_1, arg_506_1.talkMaxDuration)

			if var_509_0 <= arg_506_1.time_ and arg_506_1.time_ < var_509_0 + var_509_7 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_0) / var_509_7

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_0 + var_509_7 and arg_506_1.time_ < var_509_0 + var_509_7 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play324531126 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 324531126
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play324531127(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0
			local var_513_1 = 1.1

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

				local var_513_2 = arg_510_1:GetWordFromCfg(324531126)
				local var_513_3 = arg_510_1:FormatText(var_513_2.content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_4 = 44
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
	Play324531127 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 324531127
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play324531128(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0
			local var_517_1 = 0.15

			if var_517_0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_2 = arg_514_1:FormatText(StoryNameCfg[7].name)

				arg_514_1.leftNameTxt_.text = var_517_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_3 = arg_514_1:GetWordFromCfg(324531127)
				local var_517_4 = arg_514_1:FormatText(var_517_3.content)

				arg_514_1.text_.text = var_517_4

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_5 = 6
				local var_517_6 = utf8.len(var_517_4)
				local var_517_7 = var_517_5 <= 0 and var_517_1 or var_517_1 * (var_517_6 / var_517_5)

				if var_517_7 > 0 and var_517_1 < var_517_7 then
					arg_514_1.talkMaxDuration = var_517_7

					if var_517_7 + var_517_0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_7 + var_517_0
					end
				end

				arg_514_1.text_.text = var_517_4
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_8 = math.max(var_517_1, arg_514_1.talkMaxDuration)

			if var_517_0 <= arg_514_1.time_ and arg_514_1.time_ < var_517_0 + var_517_8 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_0) / var_517_8

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_0 + var_517_8 and arg_514_1.time_ < var_517_0 + var_517_8 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play324531128 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 324531128
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play324531129(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0.4
			local var_521_1 = 1

			if var_521_0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_0 + arg_521_0 then
				local var_521_2 = "play"
				local var_521_3 = "effect"

				arg_518_1:AudioAction(var_521_2, var_521_3, "se_story_150", "se_story_150_dragon", "")
			end

			local var_521_4 = 0
			local var_521_5 = 1.35

			if var_521_4 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_6 = arg_518_1:GetWordFromCfg(324531128)
				local var_521_7 = arg_518_1:FormatText(var_521_6.content)

				arg_518_1.text_.text = var_521_7

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_8 = 54
				local var_521_9 = utf8.len(var_521_7)
				local var_521_10 = var_521_8 <= 0 and var_521_5 or var_521_5 * (var_521_9 / var_521_8)

				if var_521_10 > 0 and var_521_5 < var_521_10 then
					arg_518_1.talkMaxDuration = var_521_10

					if var_521_10 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_10 + var_521_4
					end
				end

				arg_518_1.text_.text = var_521_7
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_11 = math.max(var_521_5, arg_518_1.talkMaxDuration)

			if var_521_4 <= arg_518_1.time_ and arg_518_1.time_ < var_521_4 + var_521_11 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_4) / var_521_11

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_4 + var_521_11 and arg_518_1.time_ < var_521_4 + var_521_11 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play324531129 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 324531129
		arg_522_1.duration_ = 7.97

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play324531130(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = "MS2406b"

			if arg_522_1.bgs_[var_525_0] == nil then
				local var_525_1 = Object.Instantiate(arg_522_1.paintGo_)

				var_525_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_525_0)
				var_525_1.name = var_525_0
				var_525_1.transform.parent = arg_522_1.stage_.transform
				var_525_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_522_1.bgs_[var_525_0] = var_525_1
			end

			local var_525_2 = 1.3

			if var_525_2 < arg_522_1.time_ and arg_522_1.time_ <= var_525_2 + arg_525_0 then
				local var_525_3 = manager.ui.mainCamera.transform.localPosition
				local var_525_4 = Vector3.New(0, 0, 10) + Vector3.New(var_525_3.x, var_525_3.y, 0)
				local var_525_5 = arg_522_1.bgs_.MS2406b

				var_525_5.transform.localPosition = var_525_4
				var_525_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_525_6 = var_525_5:GetComponent("SpriteRenderer")

				if var_525_6 and var_525_6.sprite then
					local var_525_7 = (var_525_5.transform.localPosition - var_525_3).z
					local var_525_8 = manager.ui.mainCameraCom_
					local var_525_9 = 2 * var_525_7 * Mathf.Tan(var_525_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_525_10 = var_525_9 * var_525_8.aspect
					local var_525_11 = var_525_6.sprite.bounds.size.x
					local var_525_12 = var_525_6.sprite.bounds.size.y
					local var_525_13 = var_525_10 / var_525_11
					local var_525_14 = var_525_9 / var_525_12
					local var_525_15 = var_525_14 < var_525_13 and var_525_13 or var_525_14

					var_525_5.transform.localScale = Vector3.New(var_525_15, var_525_15, 0)
				end

				for iter_525_0, iter_525_1 in pairs(arg_522_1.bgs_) do
					if iter_525_0 ~= "MS2406b" then
						iter_525_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_525_16 = 1.33333333333333

			if var_525_16 < arg_522_1.time_ and arg_522_1.time_ <= var_525_16 + arg_525_0 then
				arg_522_1.allBtn_.enabled = false
			end

			local var_525_17 = 0.3

			if arg_522_1.time_ >= var_525_16 + var_525_17 and arg_522_1.time_ < var_525_16 + var_525_17 + arg_525_0 then
				arg_522_1.allBtn_.enabled = true
			end

			local var_525_18 = 0

			if var_525_18 < arg_522_1.time_ and arg_522_1.time_ <= var_525_18 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_19 = 1.33333333333333

			if var_525_18 <= arg_522_1.time_ and arg_522_1.time_ < var_525_18 + var_525_19 then
				local var_525_20 = (arg_522_1.time_ - var_525_18) / var_525_19
				local var_525_21 = Color.New(0, 0, 0)

				var_525_21.a = Mathf.Lerp(0, 1, var_525_20)
				arg_522_1.mask_.color = var_525_21
			end

			if arg_522_1.time_ >= var_525_18 + var_525_19 and arg_522_1.time_ < var_525_18 + var_525_19 + arg_525_0 then
				local var_525_22 = Color.New(0, 0, 0)

				var_525_22.a = 1
				arg_522_1.mask_.color = var_525_22
			end

			local var_525_23 = 1.33333333333333

			if var_525_23 < arg_522_1.time_ and arg_522_1.time_ <= var_525_23 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_24 = 1.1

			if var_525_23 <= arg_522_1.time_ and arg_522_1.time_ < var_525_23 + var_525_24 then
				local var_525_25 = (arg_522_1.time_ - var_525_23) / var_525_24
				local var_525_26 = Color.New(0, 0, 0)

				var_525_26.a = Mathf.Lerp(1, 0, var_525_25)
				arg_522_1.mask_.color = var_525_26
			end

			if arg_522_1.time_ >= var_525_23 + var_525_24 and arg_522_1.time_ < var_525_23 + var_525_24 + arg_525_0 then
				local var_525_27 = Color.New(0, 0, 0)
				local var_525_28 = 0

				arg_522_1.mask_.enabled = false
				var_525_27.a = var_525_28
				arg_522_1.mask_.color = var_525_27
			end

			local var_525_29 = arg_522_1.bgs_.MS2406b.transform
			local var_525_30 = 1.33333333333333

			if var_525_30 < arg_522_1.time_ and arg_522_1.time_ <= var_525_30 + arg_525_0 then
				arg_522_1.var_.moveOldPosMS2406b = var_525_29.localPosition
			end

			local var_525_31 = 1.83333333333333

			if var_525_30 <= arg_522_1.time_ and arg_522_1.time_ < var_525_30 + var_525_31 then
				local var_525_32 = (arg_522_1.time_ - var_525_30) / var_525_31
				local var_525_33 = Vector3.New(0, 0.06, 4.68)

				var_525_29.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPosMS2406b, var_525_33, var_525_32)
			end

			if arg_522_1.time_ >= var_525_30 + var_525_31 and arg_522_1.time_ < var_525_30 + var_525_31 + arg_525_0 then
				var_525_29.localPosition = Vector3.New(0, 0.06, 4.68)
			end

			if arg_522_1.frameCnt_ <= 1 then
				arg_522_1.dialog_:SetActive(false)
			end

			local var_525_34 = 2.96666666666667
			local var_525_35 = 1.525

			if var_525_34 < arg_522_1.time_ and arg_522_1.time_ <= var_525_34 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0

				arg_522_1.dialog_:SetActive(true)

				arg_522_1.dialogCg_.alpha = 0

				local var_525_36 = LeanTween.value(arg_522_1.dialog_, 0, 1, 0.3)

				var_525_36:setOnUpdate(LuaHelper.FloatAction(function(arg_526_0)
					arg_522_1.dialogCg_.alpha = arg_526_0
				end))
				var_525_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_522_1.dialog_)
					var_525_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_522_1.duration_ = arg_522_1.duration_ + 0.3

				SetActive(arg_522_1.leftNameGo_, false)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_37 = arg_522_1:GetWordFromCfg(324531129)
				local var_525_38 = arg_522_1:FormatText(var_525_37.content)

				arg_522_1.text_.text = var_525_38

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_39 = 61
				local var_525_40 = utf8.len(var_525_38)
				local var_525_41 = var_525_39 <= 0 and var_525_35 or var_525_35 * (var_525_40 / var_525_39)

				if var_525_41 > 0 and var_525_35 < var_525_41 then
					arg_522_1.talkMaxDuration = var_525_41
					var_525_34 = var_525_34 + 0.3

					if var_525_41 + var_525_34 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_41 + var_525_34
					end
				end

				arg_522_1.text_.text = var_525_38
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_42 = var_525_34 + 0.3
			local var_525_43 = math.max(var_525_35, arg_522_1.talkMaxDuration)

			if var_525_42 <= arg_522_1.time_ and arg_522_1.time_ < var_525_42 + var_525_43 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_42) / var_525_43

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_42 + var_525_43 and arg_522_1.time_ < var_525_42 + var_525_43 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2406b",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.83333333333333,
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.45, 5.39),
					endPos = Vector3.New(0, 0.06, 4.68),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play324531130 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 324531130
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play324531131(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 0.75

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_2 = arg_528_1:GetWordFromCfg(324531130)
				local var_531_3 = arg_528_1:FormatText(var_531_2.content)

				arg_528_1.text_.text = var_531_3

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_4 = 30
				local var_531_5 = utf8.len(var_531_3)
				local var_531_6 = var_531_4 <= 0 and var_531_1 or var_531_1 * (var_531_5 / var_531_4)

				if var_531_6 > 0 and var_531_1 < var_531_6 then
					arg_528_1.talkMaxDuration = var_531_6

					if var_531_6 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_6 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_3
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_7 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_7 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_7

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_7 and arg_528_1.time_ < var_531_0 + var_531_7 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play324531131 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 324531131
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play324531132(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 2.225

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_2 = arg_532_1:GetWordFromCfg(324531131)
				local var_535_3 = arg_532_1:FormatText(var_535_2.content)

				arg_532_1.text_.text = var_535_3

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_4 = 89
				local var_535_5 = utf8.len(var_535_3)
				local var_535_6 = var_535_4 <= 0 and var_535_1 or var_535_1 * (var_535_5 / var_535_4)

				if var_535_6 > 0 and var_535_1 < var_535_6 then
					arg_532_1.talkMaxDuration = var_535_6

					if var_535_6 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_6 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_3
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_7 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_7 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_7

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_7 and arg_532_1.time_ < var_535_0 + var_535_7 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play324531132 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 324531132
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play324531133(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0
			local var_539_1 = 1.125

			if var_539_0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_2 = arg_536_1:GetWordFromCfg(324531132)
				local var_539_3 = arg_536_1:FormatText(var_539_2.content)

				arg_536_1.text_.text = var_539_3

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_4 = 45
				local var_539_5 = utf8.len(var_539_3)
				local var_539_6 = var_539_4 <= 0 and var_539_1 or var_539_1 * (var_539_5 / var_539_4)

				if var_539_6 > 0 and var_539_1 < var_539_6 then
					arg_536_1.talkMaxDuration = var_539_6

					if var_539_6 + var_539_0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_6 + var_539_0
					end
				end

				arg_536_1.text_.text = var_539_3
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_7 = math.max(var_539_1, arg_536_1.talkMaxDuration)

			if var_539_0 <= arg_536_1.time_ and arg_536_1.time_ < var_539_0 + var_539_7 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_0) / var_539_7

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_0 + var_539_7 and arg_536_1.time_ < var_539_0 + var_539_7 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play324531133 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 324531133
		arg_540_1.duration_ = 5.87

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play324531134(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = "MS2406c"

			if arg_540_1.bgs_[var_543_0] == nil then
				local var_543_1 = Object.Instantiate(arg_540_1.paintGo_)

				var_543_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_543_0)
				var_543_1.name = var_543_0
				var_543_1.transform.parent = arg_540_1.stage_.transform
				var_543_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_540_1.bgs_[var_543_0] = var_543_1
			end

			local var_543_2 = 0.233333333333333

			if var_543_2 < arg_540_1.time_ and arg_540_1.time_ <= var_543_2 + arg_543_0 then
				local var_543_3 = manager.ui.mainCamera.transform.localPosition
				local var_543_4 = Vector3.New(0, 0, 10) + Vector3.New(var_543_3.x, var_543_3.y, 0)
				local var_543_5 = arg_540_1.bgs_.MS2406c

				var_543_5.transform.localPosition = var_543_4
				var_543_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_543_6 = var_543_5:GetComponent("SpriteRenderer")

				if var_543_6 and var_543_6.sprite then
					local var_543_7 = (var_543_5.transform.localPosition - var_543_3).z
					local var_543_8 = manager.ui.mainCameraCom_
					local var_543_9 = 2 * var_543_7 * Mathf.Tan(var_543_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_543_10 = var_543_9 * var_543_8.aspect
					local var_543_11 = var_543_6.sprite.bounds.size.x
					local var_543_12 = var_543_6.sprite.bounds.size.y
					local var_543_13 = var_543_10 / var_543_11
					local var_543_14 = var_543_9 / var_543_12
					local var_543_15 = var_543_14 < var_543_13 and var_543_13 or var_543_14

					var_543_5.transform.localScale = Vector3.New(var_543_15, var_543_15, 0)
				end

				for iter_543_0, iter_543_1 in pairs(arg_540_1.bgs_) do
					if iter_543_0 ~= "MS2406c" then
						iter_543_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_543_16 = 0.233333333333333

			if var_543_16 < arg_540_1.time_ and arg_540_1.time_ <= var_543_16 + arg_543_0 then
				arg_540_1.allBtn_.enabled = false
			end

			local var_543_17 = 0.3

			if arg_540_1.time_ >= var_543_16 + var_543_17 and arg_540_1.time_ < var_543_16 + var_543_17 + arg_543_0 then
				arg_540_1.allBtn_.enabled = true
			end

			local var_543_18 = 0

			if var_543_18 < arg_540_1.time_ and arg_540_1.time_ <= var_543_18 + arg_543_0 then
				arg_540_1.mask_.enabled = true
				arg_540_1.mask_.raycastTarget = true

				arg_540_1:SetGaussion(false)
			end

			local var_543_19 = 0.233333333333333

			if var_543_18 <= arg_540_1.time_ and arg_540_1.time_ < var_543_18 + var_543_19 then
				local var_543_20 = (arg_540_1.time_ - var_543_18) / var_543_19
				local var_543_21 = Color.New(1, 1, 1)

				var_543_21.a = Mathf.Lerp(0, 1, var_543_20)
				arg_540_1.mask_.color = var_543_21
			end

			if arg_540_1.time_ >= var_543_18 + var_543_19 and arg_540_1.time_ < var_543_18 + var_543_19 + arg_543_0 then
				local var_543_22 = Color.New(1, 1, 1)

				var_543_22.a = 1
				arg_540_1.mask_.color = var_543_22
			end

			local var_543_23 = 0.233333333333333

			if var_543_23 < arg_540_1.time_ and arg_540_1.time_ <= var_543_23 + arg_543_0 then
				arg_540_1.mask_.enabled = true
				arg_540_1.mask_.raycastTarget = true

				arg_540_1:SetGaussion(false)
			end

			local var_543_24 = 0.476577664787571

			if var_543_23 <= arg_540_1.time_ and arg_540_1.time_ < var_543_23 + var_543_24 then
				local var_543_25 = (arg_540_1.time_ - var_543_23) / var_543_24
				local var_543_26 = Color.New(1, 1, 1)

				var_543_26.a = Mathf.Lerp(1, 0, var_543_25)
				arg_540_1.mask_.color = var_543_26
			end

			if arg_540_1.time_ >= var_543_23 + var_543_24 and arg_540_1.time_ < var_543_23 + var_543_24 + arg_543_0 then
				local var_543_27 = Color.New(1, 1, 1)
				local var_543_28 = 0

				arg_540_1.mask_.enabled = false
				var_543_27.a = var_543_28
				arg_540_1.mask_.color = var_543_27
			end

			local var_543_29 = 0.4
			local var_543_30 = 1

			if var_543_29 < arg_540_1.time_ and arg_540_1.time_ <= var_543_29 + arg_543_0 then
				local var_543_31 = "play"
				local var_543_32 = "effect"

				arg_540_1:AudioAction(var_543_31, var_543_32, "se_story_150", "se_story_150_break", "")
			end

			local var_543_33 = manager.ui.mainCamera.transform
			local var_543_34 = 0.709910998120904

			if var_543_34 < arg_540_1.time_ and arg_540_1.time_ <= var_543_34 + arg_543_0 then
				local var_543_35 = arg_540_1.var_.effect234edf
				local var_543_36
				local var_543_37 = var_543_33

				if not var_543_35 then
					var_543_35 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_543_37)
					var_543_35.name = "234edf"
					arg_540_1.var_.effect234edf = var_543_35
				else
					var_543_35.transform:SetParent(var_543_37)
				end

				var_543_35.transform.localPosition = Vector3.New(0, 0, 0)
				var_543_35.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_540_1.frameCnt_ <= 1 then
				arg_540_1.dialog_:SetActive(false)
			end

			local var_543_38 = 0.866666666666667
			local var_543_39 = 1.675

			if var_543_38 < arg_540_1.time_ and arg_540_1.time_ <= var_543_38 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0

				arg_540_1.dialog_:SetActive(true)

				arg_540_1.dialogCg_.alpha = 0

				local var_543_40 = LeanTween.value(arg_540_1.dialog_, 0, 1, 0.3)

				var_543_40:setOnUpdate(LuaHelper.FloatAction(function(arg_544_0)
					arg_540_1.dialogCg_.alpha = arg_544_0
				end))
				var_543_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_540_1.dialog_)
					var_543_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_540_1.duration_ = arg_540_1.duration_ + 0.3

				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_41 = arg_540_1:GetWordFromCfg(324531133)
				local var_543_42 = arg_540_1:FormatText(var_543_41.content)

				arg_540_1.text_.text = var_543_42

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_43 = 67
				local var_543_44 = utf8.len(var_543_42)
				local var_543_45 = var_543_43 <= 0 and var_543_39 or var_543_39 * (var_543_44 / var_543_43)

				if var_543_45 > 0 and var_543_39 < var_543_45 then
					arg_540_1.talkMaxDuration = var_543_45
					var_543_38 = var_543_38 + 0.3

					if var_543_45 + var_543_38 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_45 + var_543_38
					end
				end

				arg_540_1.text_.text = var_543_42
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_46 = var_543_38 + 0.3
			local var_543_47 = math.max(var_543_39, arg_540_1.talkMaxDuration)

			if var_543_46 <= arg_540_1.time_ and arg_540_1.time_ < var_543_46 + var_543_47 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_46) / var_543_47

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_46 + var_543_47 and arg_540_1.time_ < var_543_46 + var_543_47 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play324531134 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 324531134
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play324531135(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = manager.ui.mainCamera.transform
			local var_549_1 = 0

			if var_549_1 < arg_546_1.time_ and arg_546_1.time_ <= var_549_1 + arg_549_0 then
				local var_549_2 = arg_546_1.var_.effect234edf

				if var_549_2 then
					Object.Destroy(var_549_2)

					arg_546_1.var_.effect234edf = nil
				end
			end

			local var_549_3 = 0
			local var_549_4 = 0.1

			if var_549_3 < arg_546_1.time_ and arg_546_1.time_ <= var_549_3 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_5 = arg_546_1:FormatText(StoryNameCfg[7].name)

				arg_546_1.leftNameTxt_.text = var_549_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_6 = arg_546_1:GetWordFromCfg(324531134)
				local var_549_7 = arg_546_1:FormatText(var_549_6.content)

				arg_546_1.text_.text = var_549_7

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_8 = 4
				local var_549_9 = utf8.len(var_549_7)
				local var_549_10 = var_549_8 <= 0 and var_549_4 or var_549_4 * (var_549_9 / var_549_8)

				if var_549_10 > 0 and var_549_4 < var_549_10 then
					arg_546_1.talkMaxDuration = var_549_10

					if var_549_10 + var_549_3 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_10 + var_549_3
					end
				end

				arg_546_1.text_.text = var_549_7
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_11 = math.max(var_549_4, arg_546_1.talkMaxDuration)

			if var_549_3 <= arg_546_1.time_ and arg_546_1.time_ < var_549_3 + var_549_11 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_3) / var_549_11

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_3 + var_549_11 and arg_546_1.time_ < var_549_3 + var_549_11 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play324531135 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 324531135
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play324531136(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0
			local var_553_1 = 1.3

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

				local var_553_2 = arg_550_1:GetWordFromCfg(324531135)
				local var_553_3 = arg_550_1:FormatText(var_553_2.content)

				arg_550_1.text_.text = var_553_3

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_4 = 52
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
	Play324531136 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 324531136
		arg_554_1.duration_ = 6.43

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
			arg_554_1.auto_ = false
		end

		function arg_554_1.playNext_(arg_556_0)
			arg_554_1.onStoryFinished_()
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				local var_557_1 = manager.ui.mainCamera.transform.localPosition
				local var_557_2 = Vector3.New(0, 0, 10) + Vector3.New(var_557_1.x, var_557_1.y, 0)
				local var_557_3 = arg_554_1.bgs_.MS2406

				var_557_3.transform.localPosition = var_557_2
				var_557_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_557_4 = var_557_3:GetComponent("SpriteRenderer")

				if var_557_4 and var_557_4.sprite then
					local var_557_5 = (var_557_3.transform.localPosition - var_557_1).z
					local var_557_6 = manager.ui.mainCameraCom_
					local var_557_7 = 2 * var_557_5 * Mathf.Tan(var_557_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_557_8 = var_557_7 * var_557_6.aspect
					local var_557_9 = var_557_4.sprite.bounds.size.x
					local var_557_10 = var_557_4.sprite.bounds.size.y
					local var_557_11 = var_557_8 / var_557_9
					local var_557_12 = var_557_7 / var_557_10
					local var_557_13 = var_557_12 < var_557_11 and var_557_11 or var_557_12

					var_557_3.transform.localScale = Vector3.New(var_557_13, var_557_13, 0)
				end

				for iter_557_0, iter_557_1 in pairs(arg_554_1.bgs_) do
					if iter_557_0 ~= "MS2406" then
						iter_557_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_557_14 = 0

			if var_557_14 < arg_554_1.time_ and arg_554_1.time_ <= var_557_14 + arg_557_0 then
				arg_554_1.allBtn_.enabled = false
			end

			local var_557_15 = 0.3

			if arg_554_1.time_ >= var_557_14 + var_557_15 and arg_554_1.time_ < var_557_14 + var_557_15 + arg_557_0 then
				arg_554_1.allBtn_.enabled = true
			end

			local var_557_16 = 0

			if var_557_16 < arg_554_1.time_ and arg_554_1.time_ <= var_557_16 + arg_557_0 then
				arg_554_1.mask_.enabled = true
				arg_554_1.mask_.raycastTarget = true

				arg_554_1:SetGaussion(false)
			end

			local var_557_17 = 2

			if var_557_16 <= arg_554_1.time_ and arg_554_1.time_ < var_557_16 + var_557_17 then
				local var_557_18 = (arg_554_1.time_ - var_557_16) / var_557_17
				local var_557_19 = Color.New(0, 0, 0)

				var_557_19.a = Mathf.Lerp(1, 0, var_557_18)
				arg_554_1.mask_.color = var_557_19
			end

			if arg_554_1.time_ >= var_557_16 + var_557_17 and arg_554_1.time_ < var_557_16 + var_557_17 + arg_557_0 then
				local var_557_20 = Color.New(0, 0, 0)
				local var_557_21 = 0

				arg_554_1.mask_.enabled = false
				var_557_20.a = var_557_21
				arg_554_1.mask_.color = var_557_20
			end

			if arg_554_1.frameCnt_ <= 1 then
				arg_554_1.dialog_:SetActive(false)
			end

			local var_557_22 = 1.43333333333333
			local var_557_23 = 1.125

			if var_557_22 < arg_554_1.time_ and arg_554_1.time_ <= var_557_22 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0

				arg_554_1.dialog_:SetActive(true)

				arg_554_1.dialogCg_.alpha = 0

				local var_557_24 = LeanTween.value(arg_554_1.dialog_, 0, 1, 0.3)

				var_557_24:setOnUpdate(LuaHelper.FloatAction(function(arg_558_0)
					arg_554_1.dialogCg_.alpha = arg_558_0
				end))
				var_557_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_554_1.dialog_)
					var_557_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_554_1.duration_ = arg_554_1.duration_ + 0.3

				SetActive(arg_554_1.leftNameGo_, false)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_25 = arg_554_1:GetWordFromCfg(324531136)
				local var_557_26 = arg_554_1:FormatText(var_557_25.content)

				arg_554_1.text_.text = var_557_26

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_27 = 45
				local var_557_28 = utf8.len(var_557_26)
				local var_557_29 = var_557_27 <= 0 and var_557_23 or var_557_23 * (var_557_28 / var_557_27)

				if var_557_29 > 0 and var_557_23 < var_557_29 then
					arg_554_1.talkMaxDuration = var_557_29
					var_557_22 = var_557_22 + 0.3

					if var_557_29 + var_557_22 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_29 + var_557_22
					end
				end

				arg_554_1.text_.text = var_557_26
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)
				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_30 = var_557_22 + 0.3
			local var_557_31 = math.max(var_557_23, arg_554_1.talkMaxDuration)

			if var_557_30 <= arg_554_1.time_ and arg_554_1.time_ < var_557_30 + var_557_31 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_30) / var_557_31

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_30 + var_557_31 and arg_554_1.time_ < var_557_30 + var_557_31 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play324531106 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 324531106
		arg_560_1.duration_ = 4.23

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play324531107(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = arg_560_1.actors_["10170ui_story"]
			local var_563_1 = 0

			if var_563_1 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.characterEffect10170ui_story == nil then
				arg_560_1.var_.characterEffect10170ui_story = var_563_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_2 = 0.200000002980232

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_2 and not isNil(var_563_0) then
				local var_563_3 = (arg_560_1.time_ - var_563_1) / var_563_2

				if arg_560_1.var_.characterEffect10170ui_story and not isNil(var_563_0) then
					arg_560_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_560_1.time_ >= var_563_1 + var_563_2 and arg_560_1.time_ < var_563_1 + var_563_2 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.characterEffect10170ui_story then
				arg_560_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_563_4 = 0
			local var_563_5 = 0.5

			if var_563_4 < arg_560_1.time_ and arg_560_1.time_ <= var_563_4 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_6 = arg_560_1:FormatText(StoryNameCfg[1450].name)

				arg_560_1.leftNameTxt_.text = var_563_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_7 = arg_560_1:GetWordFromCfg(324531106)
				local var_563_8 = arg_560_1:FormatText(var_563_7.content)

				arg_560_1.text_.text = var_563_8

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_9 = 20
				local var_563_10 = utf8.len(var_563_8)
				local var_563_11 = var_563_9 <= 0 and var_563_5 or var_563_5 * (var_563_10 / var_563_9)

				if var_563_11 > 0 and var_563_5 < var_563_11 then
					arg_560_1.talkMaxDuration = var_563_11

					if var_563_11 + var_563_4 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_11 + var_563_4
					end
				end

				arg_560_1.text_.text = var_563_8
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531106", "story_v_out_324531.awb") ~= 0 then
					local var_563_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531106", "story_v_out_324531.awb") / 1000

					if var_563_12 + var_563_4 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_12 + var_563_4
					end

					if var_563_7.prefab_name ~= "" and arg_560_1.actors_[var_563_7.prefab_name] ~= nil then
						local var_563_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_7.prefab_name].transform, "story_v_out_324531", "324531106", "story_v_out_324531.awb")

						arg_560_1:RecordAudio("324531106", var_563_13)
						arg_560_1:RecordAudio("324531106", var_563_13)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_324531", "324531106", "story_v_out_324531.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_324531", "324531106", "story_v_out_324531.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_14 = math.max(var_563_5, arg_560_1.talkMaxDuration)

			if var_563_4 <= arg_560_1.time_ and arg_560_1.time_ < var_563_4 + var_563_14 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_4) / var_563_14

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_4 + var_563_14 and arg_560_1.time_ < var_563_4 + var_563_14 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play324531107 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 324531107
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play324531110(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = arg_564_1.actors_["10170ui_story"]
			local var_567_1 = 0

			if var_567_1 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.characterEffect10170ui_story == nil then
				arg_564_1.var_.characterEffect10170ui_story = var_567_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_2 = 0.200000002980232

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_2 and not isNil(var_567_0) then
				local var_567_3 = (arg_564_1.time_ - var_567_1) / var_567_2

				if arg_564_1.var_.characterEffect10170ui_story and not isNil(var_567_0) then
					local var_567_4 = Mathf.Lerp(0, 0.5, var_567_3)

					arg_564_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_564_1.var_.characterEffect10170ui_story.fillRatio = var_567_4
				end
			end

			if arg_564_1.time_ >= var_567_1 + var_567_2 and arg_564_1.time_ < var_567_1 + var_567_2 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.characterEffect10170ui_story then
				local var_567_5 = 0.5

				arg_564_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_564_1.var_.characterEffect10170ui_story.fillRatio = var_567_5
			end

			local var_567_6 = 0
			local var_567_7 = 0.725

			if var_567_6 < arg_564_1.time_ and arg_564_1.time_ <= var_567_6 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				local var_567_8 = arg_564_1:FormatText(StoryNameCfg[7].name)

				arg_564_1.leftNameTxt_.text = var_567_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_9 = arg_564_1:GetWordFromCfg(324531107)
				local var_567_10 = arg_564_1:FormatText(var_567_9.content)

				arg_564_1.text_.text = var_567_10

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_11 = 29
				local var_567_12 = utf8.len(var_567_10)
				local var_567_13 = var_567_11 <= 0 and var_567_7 or var_567_7 * (var_567_12 / var_567_11)

				if var_567_13 > 0 and var_567_7 < var_567_13 then
					arg_564_1.talkMaxDuration = var_567_13

					if var_567_13 + var_567_6 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_13 + var_567_6
					end
				end

				arg_564_1.text_.text = var_567_10
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_14 = math.max(var_567_7, arg_564_1.talkMaxDuration)

			if var_567_6 <= arg_564_1.time_ and arg_564_1.time_ < var_567_6 + var_567_14 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_6) / var_567_14

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_6 + var_567_14 and arg_564_1.time_ < var_567_6 + var_567_14 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play324531108 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 324531108
		arg_568_1.duration_ = 1.6

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play324531109(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = arg_568_1.actors_["10170ui_story"]
			local var_571_1 = 0

			if var_571_1 < arg_568_1.time_ and arg_568_1.time_ <= var_571_1 + arg_571_0 and not isNil(var_571_0) and arg_568_1.var_.characterEffect10170ui_story == nil then
				arg_568_1.var_.characterEffect10170ui_story = var_571_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_571_2 = 0.200000002980232

			if var_571_1 <= arg_568_1.time_ and arg_568_1.time_ < var_571_1 + var_571_2 and not isNil(var_571_0) then
				local var_571_3 = (arg_568_1.time_ - var_571_1) / var_571_2

				if arg_568_1.var_.characterEffect10170ui_story and not isNil(var_571_0) then
					arg_568_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_568_1.time_ >= var_571_1 + var_571_2 and arg_568_1.time_ < var_571_1 + var_571_2 + arg_571_0 and not isNil(var_571_0) and arg_568_1.var_.characterEffect10170ui_story then
				arg_568_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_571_4 = 0
			local var_571_5 = 0.175

			if var_571_4 < arg_568_1.time_ and arg_568_1.time_ <= var_571_4 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				local var_571_6 = arg_568_1:FormatText(StoryNameCfg[1450].name)

				arg_568_1.leftNameTxt_.text = var_571_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_7 = arg_568_1:GetWordFromCfg(324531108)
				local var_571_8 = arg_568_1:FormatText(var_571_7.content)

				arg_568_1.text_.text = var_571_8

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_9 = 7
				local var_571_10 = utf8.len(var_571_8)
				local var_571_11 = var_571_9 <= 0 and var_571_5 or var_571_5 * (var_571_10 / var_571_9)

				if var_571_11 > 0 and var_571_5 < var_571_11 then
					arg_568_1.talkMaxDuration = var_571_11

					if var_571_11 + var_571_4 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_11 + var_571_4
					end
				end

				arg_568_1.text_.text = var_571_8
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324531", "324531108", "story_v_out_324531.awb") ~= 0 then
					local var_571_12 = manager.audio:GetVoiceLength("story_v_out_324531", "324531108", "story_v_out_324531.awb") / 1000

					if var_571_12 + var_571_4 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_12 + var_571_4
					end

					if var_571_7.prefab_name ~= "" and arg_568_1.actors_[var_571_7.prefab_name] ~= nil then
						local var_571_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_7.prefab_name].transform, "story_v_out_324531", "324531108", "story_v_out_324531.awb")

						arg_568_1:RecordAudio("324531108", var_571_13)
						arg_568_1:RecordAudio("324531108", var_571_13)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_out_324531", "324531108", "story_v_out_324531.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_out_324531", "324531108", "story_v_out_324531.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_14 = math.max(var_571_5, arg_568_1.talkMaxDuration)

			if var_571_4 <= arg_568_1.time_ and arg_568_1.time_ < var_571_4 + var_571_14 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_4) / var_571_14

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_4 + var_571_14 and arg_568_1.time_ < var_571_4 + var_571_14 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play324531109 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 324531109
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play324531110(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = arg_572_1.actors_["10170ui_story"]
			local var_575_1 = 0

			if var_575_1 < arg_572_1.time_ and arg_572_1.time_ <= var_575_1 + arg_575_0 and not isNil(var_575_0) and arg_572_1.var_.characterEffect10170ui_story == nil then
				arg_572_1.var_.characterEffect10170ui_story = var_575_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_2 = 0.200000002980232

			if var_575_1 <= arg_572_1.time_ and arg_572_1.time_ < var_575_1 + var_575_2 and not isNil(var_575_0) then
				local var_575_3 = (arg_572_1.time_ - var_575_1) / var_575_2

				if arg_572_1.var_.characterEffect10170ui_story and not isNil(var_575_0) then
					local var_575_4 = Mathf.Lerp(0, 0.5, var_575_3)

					arg_572_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_572_1.var_.characterEffect10170ui_story.fillRatio = var_575_4
				end
			end

			if arg_572_1.time_ >= var_575_1 + var_575_2 and arg_572_1.time_ < var_575_1 + var_575_2 + arg_575_0 and not isNil(var_575_0) and arg_572_1.var_.characterEffect10170ui_story then
				local var_575_5 = 0.5

				arg_572_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_572_1.var_.characterEffect10170ui_story.fillRatio = var_575_5
			end

			local var_575_6 = 0
			local var_575_7 = 0.825

			if var_575_6 < arg_572_1.time_ and arg_572_1.time_ <= var_575_6 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_8 = arg_572_1:FormatText(StoryNameCfg[7].name)

				arg_572_1.leftNameTxt_.text = var_575_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_9 = arg_572_1:GetWordFromCfg(324531109)
				local var_575_10 = arg_572_1:FormatText(var_575_9.content)

				arg_572_1.text_.text = var_575_10

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_11 = 33
				local var_575_12 = utf8.len(var_575_10)
				local var_575_13 = var_575_11 <= 0 and var_575_7 or var_575_7 * (var_575_12 / var_575_11)

				if var_575_13 > 0 and var_575_7 < var_575_13 then
					arg_572_1.talkMaxDuration = var_575_13

					if var_575_13 + var_575_6 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_13 + var_575_6
					end
				end

				arg_572_1.text_.text = var_575_10
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_14 = math.max(var_575_7, arg_572_1.talkMaxDuration)

			if var_575_6 <= arg_572_1.time_ and arg_572_1.time_ < var_575_6 + var_575_14 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_6) / var_575_14

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_6 + var_575_14 and arg_572_1.time_ < var_575_6 + var_575_14 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J27g",
		"TextureConfig/Background/ST2007",
		"TextureConfig/Background/ST2008",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/J25f",
		"TextureConfig/Background/MS2406",
		"TextureConfig/Background/MS2406a",
		"TextureConfig/Background/MS2406b",
		"TextureConfig/Background/MS2406c"
	},
	voices = {
		"story_v_out_324531.awb"
	}
}
